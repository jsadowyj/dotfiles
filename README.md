# dotfiles

A collection of configuration files for my macOS development environment, managed with GNU Stow for easy symlink management.

## Structure

- `.zshrc` - Main zshell configuration with prompt, aliases, and environment settings
- `.aliases` - Custom command aliases for productivity
- `.gitconfig` - Git configuration with GPG signing and user info
- `.env` - Environment variables for development tools
- `.config/gh/` - GitHub CLI configuration
- `.zsh/plugins/` - ZSH plugins for enhanced terminal experience

## Dependencies

- Homebrew (for package management)
- 1Password CLI (for secret injection)
- ZSH as default shell

## Required Packages

Install these Homebrew packages:

```bash
brew install stow autojump fzf zsh-autosuggestions zsh-syntax-highlighting
```

The shell displays installation instructions if any of these packages are missing.

## Installation

This configuration uses GNU Stow for symlink management:

```bash
git clone https://github.com/jsadowyj/dotfiles ~/.dotfiles
cd ~/.dotfiles
stow -v  .
```

After installation, restart the shell or run:

```bash
source ~/.zshrc
```

## Customization

Create local overrides without affecting tracked files:
- `.zshrc.local` - Custom ZSH configurations
- `.aliases.local` - Additional aliases
- `.env.local` - Local environment variables

> Note: The `op inject` command in .zshrc requires 1Password CLI and proper authentication.
