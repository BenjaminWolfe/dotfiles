## Installation and Configuration

See [README.md](../README.md) for how to install Insomnia
and the 1Password CLI, add the Insomnia plugin,
and configure them all to work together.

## Using Insomnia With the 1Password Plugin

To add a value from 1Password anywhere in Insomnia,
type Control+Space, tab down to `1Password => Fetch Secret`,
and add the value as `op://{vault name or ID}/{item name or ID}/{field name}`.

You can get vault names and IDs from the command line:

```
op vault list
```

And you can get item names and IDs as well:

```
op item list [--vault <vault_name>]
```

Field names are just as you'd expect from the 1Password UI.
I'm not sure what to do with spaces or special characters.
