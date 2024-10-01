
# https://docs.brew.sh/Shell-Completion#configuring-completions-in-zsh
if type brew &>/dev/null
then
  echo "🔥Installing brew dependency completions"
  FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"
fi

autoload -U compinit; compinit
autoload -U +X bashcompinit && bashcompinit

zstyle ':completion:*' completer _extensions _complete _approximate
zstyle ':completion:*' menu select
zstyle ':completion:*' file-list all
zstyle ':completion:*' squeeze-slashes true
zstyle ':completion:*' complete-options true
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'

# Cache completions
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path "$XDG_CACHE_HOME/zsh/.zcompcache"

if [ -x "$(command -v kubectl)" ]; then
  echo "🔥Installing kubectl completions"
  source <(kubectl completion zsh)
fi

if [ -x "$(command -v helm)" ]; then
  echo "🔥Installing helm completions"
  source <(helm completion zsh)
fi

if [ -x "$(command -v talosctl)" ]; then
    echo "🔥Installing talosctl completions"
    source <(talosctl completion zsh)
fi