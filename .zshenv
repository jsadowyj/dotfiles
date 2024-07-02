export EDITOR="vim"
export VISUAL="vim"
export LSCOLORS=gxBxhxDxfxhxhxhxhxcxcx

export MANTA_URL=https://us-central.manta.mnx.io
export MANTA_USER=jsadowyj
unset MANTA_SUBUSER
export MANTA_KEY_ID=$(ssh-keygen -E md5 -l -f ~/.ssh/id_mnx.pub | awk '{print $2}' | tr -d '\n' | cut -d: -f 2-)

export TRITON_PROFILE="env"
export TRITON_URL="https://us-central-1.api.mnx.io"
export TRITON_ACCOUNT="jsadowyj"
unset TRITON_USER
export TRITON_KEY_ID="$(ssh-keygen -l -f $HOME/.ssh/id_mnx.pub | awk '{print $2}')"
unset TRITON_TESTING
unset TRITON_PROFILE

# python multithreading workaround
export OBJC_DISABLE_INITIALIZE_FORK_SAFETY=YES

# add .bin to PATH
export PATH="$PATH:$HOME/.bin"
# add pipx bin PATH
export PATH="$PATH:$HOME/.local/bin"
# add gnu binaries to PATH
export PATH="/opt/homebrew/opt/gnu-tar/libexec/gnubin:$PATH"
# add local man pages to MANPATH
export MANPATH="$MANPATH:$HOME/.local/share/man"

ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20
