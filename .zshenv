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

# add .scripts to PATH
export PATH="$PATH:$HOME/.scripts"
# add pipx bin PATH
export PATH="$PATH:$HOME/.local/bin"
# add gnu binaries to PATH
export PATH="/opt/homebrew/opt/gnu-tar/libexec/gnubin:$PATH"
# add local man pages to MANPATH
export MANPATH="$MANPATH:$HOME/.local/share/man"

ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20

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
