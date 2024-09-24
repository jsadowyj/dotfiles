umask 0022

# Load version control information
# Add Homebrew to PATH
eval "$(/opt/homebrew/bin/brew shellenv)"

# Add git terminal integration
autoload -Uz vcs_info
zstyle ':vcs_info:*' enable git svn
precmd() {
    vcs_info
}

# Enables terminal colors
autoload -U colors && colors
export CLICOLOR=1
setopt prompt_subst

# Makes colors easier to deal with
source ~/.zsh/plugins/spectrum.zsh

# Configure autojump
if [ -f /opt/homebrew/etc/profile.d/autojump.sh ]; then
  source /opt/homebrew/etc/profile.d/autojump.sh
else
  brew install autojump
fi

# Customized prompt
PROMPT='%{$FG[032]%}%n%{$reset_color%}:%{$fg[green]%}%c%{$reset_color%} ${vcs_info_msg_0_}%{$reset_color%}%(!.#.$) '

# Styles git prompt
zstyle ':vcs_info:git*' formats "%{$FG[247]%}%s:(%{$FG[214]%}%b*%{$FG[247]%})%{$reset_color%} "

# ZSH Autocompletions
if type brew &>/dev/null; then
  FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"
fi
# https://github.com/zsh-users/zsh-completions
fpath=($HOME/.local/share/zsh/zsh-completions/src $fpath)
# Custom completions
fpath=($HOME/.zsh/completion $fpath)

# Basic auto/tab complete:
autoload -Uz compinit && compinit -i
zstyle ':completion:*' menu select
zmodload zsh/complist
# compinit
_comp_options+=(globdots)		# Include hidden files.

# Enables bash keybindings
bindkey -e

if command -v fzf &> /dev/null; then
  # Enable fzf
  source <(fzf --zsh)
else
  brew install fzf
fi

# ZSH Autosuggestions
# https://github.com/zsh-users/zsh-autosuggestions
if [ -f /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh ]; then
  source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
else
  brew install zsh-autosuggestions
fi

# ZSH syntax highlightning
# https://github.com/zsh-users/zsh-syntax-highlighting
if [ -f /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]; then
  source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
else
  brew install zsh-syntax-highlighting
fi

# Disables underlining:
(( ${+ZSH_HIGHLIGHT_STYLES} )) || typeset -A ZSH_HIGHLIGHT_STYLES
ZSH_HIGHLIGHT_STYLES[path]=none
ZSH_HIGHLIGHT_STYLES[path_prefix]=none

# Better ZSH History
export HISTFILE="$HOME/.zsh_history"
export HISTSIZE=10000000
export SAVEHIST=10000000
setopt HIST_IGNORE_SPACE
setopt INC_APPEND_HISTORY        # Write to the history file immediately, not when the shell exits.
setopt SHARE_HISTORY             # Share history between all sessions.
setopt HIST_VERIFY               # Don't execute immediately upon history expansion.
setopt HIST_BEEP                 # Beep when accessing nonexistent history.

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm


# source aliases
test -f $HOME/.aliases && source ~/.aliases

# source .mnx.zshrc if exists
test -f $HOME/.mnx.zshrc && source $HOME/.mnx.zshrc

function load_envs() {
  if [ -f $HOME/.env ]; then
    op inject --account my.1password.com -i $HOME/.env -o $HOME/.env.tmp > /dev/null
    export $(cat $HOME/.env.tmp | xargs)
    rm -f $HOME/.env.tmp
  fi
}

function manta {
      local alg=rsa-sha256
      local keyId=/$MANTA_USER/keys/$MANTA_KEY_ID
      local now=$(date -u "+%a, %d %h %Y %H:%M:%S GMT")
      local sig=$(echo "date:" $now | \
                  tr -d '\n' | \
                  openssl dgst -sha256 -sign $HOME/.ssh/id_mnx | \
                  openssl enc -e -a | tr -d '\n')

      curl -sS $MANTA_URL"$@" -H "date: $now"  \
          -H "Authorization: Signature keyId=\"$keyId\",algorithm=\"$alg\",signature=\"$sig\""
}

# add .bin to PATH
export PATH="$HOME/.bin:$PATH"
# add pipx bin PATH
export PATH="$HOME/.local/bin:$PATH"
# add gnu binaries to PATH
export PATH="/opt/homebrew/opt/gnu-tar/libexec/gnubin:$PATH"
# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$HOME/.rvm/bin:$PATH"

