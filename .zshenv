export VISUAL="nvim"
export EDITOR="nvim"

export LSCOLORS=gxBxhxDxfxhxhxhxhxcxcx

# python multithreading workaround
export OBJC_DISABLE_INITIALIZE_FORK_SAFETY=YES

# add local man pages to MANPATH
export MANPATH="$MANPATH:$HOME/.local/share/man"

# ansible vault-pass binary
#test -f $HOME/.bin/vault-env && export ANSIBLE_VAULT_PASSWORD_FILE="$HOME/.bin/vault-env"

export ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20
export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=238'

export SSH_AUTH_SOCK="$HOME/Library/Group Containers/2BUA8C4S2C.com.1password/t/agent.sock"
