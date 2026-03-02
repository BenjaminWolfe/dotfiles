# Snowflake with R on a Mac
## Background

At Palomar, we use both SQL Server and Snowflake.
I use a Mac (obviously; that’s the point of this repo).

On macOS, the most reliable setup we’ve found is:

- SQL Server: unixODBC + `odbc` (DBI) + `dbplyr`
- Snowflake: iODBC + Snowflake ODBC + `RODBC`
  (with Okta SSO via `externalbrowser`)

Why the split?

- Snowflake’s macOS ODBC driver expects **iODBC**.
  In practice, attempting to use Snowflake with unixODBC on macOS
  has proven extremely fragile (and I tried *everything*).
- Posit’s `odbc` / `dbplyr` ecosystem on macOS
  is built around **unixODBC**,
  and I don’t want to destabilize the SQL Server setup
  to accommodate Snowflake.

Note that this setup intentionally keeps **both** unixODBC and iODBC
installed side-by-side.
SQL Server continues to use unixODBC;
Snowflake is explicitly pointed at iODBC.

It’s a small price to pay to reliably pull data
from both sources in the same R environment.

> Note: `odbc.ini` holds **DSNs** (connections).
> `odbcinst.ini` holds **driver definitions**.
> It’s normal to already have ~/Library/ODBC/odbcinst.ini.

## Installation
### Verify Homebrew iODBC install

This dotfiles repo installs `libiodbc` via Homebrew. Verify:

```zsh
ls -l /opt/homebrew/opt/libiodbc/lib/libiodbcinst.dylib
```

It should be a symlink pointing to something like `libiodbcinst.2.dylib`.

(Optional sanity check on Apple Silicon:)

```zsh
file /opt/homebrew/opt/libiodbc/lib/libiodbcinst.dylib
```

It should say something like
`Mach-O 64-bit dynamically linked shared library arm64`.

### Install iODBC SDK (required for `iodbctest`)

Snowflake’s macOS ODBC instructions
rely on the iODBC SDK (specifically `iodbctest`).

Follow the Snowflake doc here
(kept as the canonical link in case filenames change):

  https://docs.snowflake.com/developer-guide/odbc/odbc-mac

Download and install `iODBC-SDK-3.52.16-macOS11.dmg`
(or the most recent macOS11+ version).
Open the `.dmg`, then run the `.pkg` inside it.

Verify the test tool exists:

```zsh
ls -l "/Library/Application Support/iODBC/bin/iodbctest"
```

### Install Snowflake ODBC driver for macOS

From the same Snowflake doc page above,
download and install the Snowflake ODBC Driver
(again: open the `.dmg`, run the `.pkg`).

Verify the driver library exists:

```zsh
ls -l /opt/snowflake/snowflakeodbc/lib/universal/libSnowflake.dylib
```

### Point Snowflake to iODBC (critical fix)

Edit:

```zsh
sudo code --wait /opt/snowflake/snowflakeodbc/lib/universal/simba.snowflake.ini
```


Under `[Driver]`, add:

```ini
ODBCInstLib=/opt/homebrew/opt/libiodbc/lib/libiodbcinst.dylib
```

This fixes the dreaded error:

> “Unable to locate SQLGetPrivateProfileString …
> could not load … libodbcinst.dylib”

### Configure the DSN

Create the user DSN folder + file:

```zsh
mkdir -p ~/Library/ODBC
touch -c ~/Library/ODBC/odbc.ini
```

Edit:

```zsh
code --wait ~/Library/ODBC/odbc.ini
```

Add:

```ini
[SnowflakePLMR]
Driver=/opt/snowflake/snowflakeodbc/lib/universal/libSnowflake.dylib
Server=PLMR-DATA.snowflakecomputing.com
UID=BWOLFE@PLMR.COM
Authenticator=externalbrowser
```

Adjust `Server` and `UID` as needed.

### Test Connection Outside R (recommended)

Per Snowflake docs, validate the DSN with `iodbctest` first:

```zsh
"/Library/Application Support/iODBC/bin/iodbctest"
```

At the prompt:

```
Enter ODBC connect string (? shows list):
```

Type:

```ini
DSN=SnowflakePLMR
```

This should open a browser for Okta login
and return you to a `SQL>` prompt.

### Test Snowflake from R with RODBC

`RODBC` should be among the packages installed by this dotfiles repo.
If not:

```r
install.packages("RODBC")
```

With `RODBC` installed:

```r
library(RODBC)

sf <- odbcConnect("SnowflakePLMR", believeNRows = FALSE)

query <- "select * from DEV_CORE.PREMIUM.CLEAN_TRANSACTIONAL limit 50"
test_data <- sqlQuery(sf, query, stringsAsFactors = FALSE)

head(test_data)

odbcClose(sf)
```

#### Known Failure Symptom

If Snowflake cannot find iODBC correctly, you’ll see:

> Unable to locate SQLGetPrivateProfileString  
> Could not load shared library: libodbcinst.dylib

If you see this, double-check `ODBCInstLib` in `simba.snowflake.ini`.
