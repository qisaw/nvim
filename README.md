# My neovim config

This repository contains my personal Neovim configuration files.

The configuration is organized under `lua/config` and `lua/plugins`.

## Requirements
- Neovim 0.12 or higher
- Git
- Nerd Font for correct icon rendering. I use [JetBrains Mono Nerd Font](https://www.nerdfonts.com/font-downloads). I used [homebrew](https://formulae.brew.sh/cask/font-jetbrains-mono-nerd-font) to install this.
- Codex and [codex-acp](https://github.com/agentclientprotocol/codex-acp) for CodeCompanion chat
- Mermaid CLI for rendering Mermaid diagrams

Install `codex-acp` globally with npm, not Mason, so Neovim uses the same version you update:
```sh
npm install -g @agentclientprotocol/codex-acp
```

If you previously installed `codex-acp` with Mason, run `:MasonUninstall codex-acp` and restart Neovim. Check the executable Neovim finds with `:echo exepath('codex-acp')` and its version with `:!codex-acp --version`.

Install the Mermaid CLI with:
```sh
npm install -g @mermaid-js/mermaid-cli
```

## Installation
1. Clone this repository to your local machine at `~/.config/nvim`:
2. Open neovim and vim pack will automatically install the required plugins.
