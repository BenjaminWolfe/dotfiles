# Claude with Obsidian

Quick README for connecting Claude Desktop to Obsidian
using MCP Obsidian and the Obsidian REST API plugin.

## Prerequisites

- Obsidian, Claude Desktop, and `uv` installed
  (the dotfiles repo assumes Homebrew installs).
- Run the dotfiles startup scripts (including `setup-symlinks.sh`)
  so initial Claude config is created.

## Install and configure Obsidian REST API plugin

1. Open Obsidian → Settings → Community Plugins.
2. Enable Community Plugins (if not already enabled).
3. Browse community plugins and install "REST API".
4. Enable the REST API plugin.
5. In the plugin Options, copy the API key.
6. In Advanced Settings for the plugin,
   enable the encrypted (HTTPS) server.

## Configure Claude Desktop

- Open `~/Library/Application Support/Claude/claude_desktop_config.json`.
- Set the `obsidian_api_key` field to the API key copied from the REST API plugin.

## Notes

- These steps follow the dotfiles repo conventions
  and assume those setup scripts were used.
- The config file in use here may be newer than external guides;
  I used Claude itself to troubleshoot, as the reference materials I was using
  were already out of date.

## Reference

- YouTube walkthrough: https://www.youtube.com/watch?v=_PiRCPnQmgk
- MCP Obsidian repo: https://github.com/MarkusPfundstein/mcp-obsidian
- Obsidian REST API plugin: https://github.com/coddingtonbear/obsidian-local-rest-api
