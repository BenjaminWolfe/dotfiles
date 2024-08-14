## Examples: `jq` and `miiller`

`jq` and `miller` are great tools for light data manipulation from the CLI.

Say you have a JSON file that's an array of similar objects,
and you want to convert it to CSV.
And maybe you'd like to sort it by the `Name` field first!

```sh
mlr --j2c sort -f Name then cat myData.json > myData.csv
```

Or say you have to first pull out an element called `fieldList`,
which is the actual array of objects.
You could do this with `jq`, and chain that with `mlr`:

```sh
jq '.fieldList[]' myData.json | mlr --j2c cat > myData.csv
```

More complex `jq` scripts can be put in their own files, or `jq` scripts.

## Formatting `jq` Scripts With `jqfmt`

There are no standard tools for formatting `jq` scripts.
The install scripts in this repo install `jqfmt` for that purpose.
Format a script in place like this:

```sh
qfmt -ar -ob -f myScript.jq > temp.jq && mv temp.jq myScript.jq
```

- `-ar` formats arrays nicely.
- `-ob` formats objects nicely.

I find that this formatter really doesn't make things look as clean as I like.
So for now, consider just formatting by hand.

Note that this formatter also requires a file at `~/.jq`.
The file can be completely empty!
Our install scripts set this up automatically.
