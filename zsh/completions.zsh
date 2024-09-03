autoload -U compinit; compinit
autoload -U +X bashcompinit && bashcompinit

if [ -x "$(command -v kubectl)" ]; then
  source <(kubectl completion zsh)
fi

complete -o nospace -C /opt/homebrew/bin/terraform terraform

zstyle ':completion:*' completer _extensions _complete _approximate
zstyle ':completion:*' menu select
zstyle ':completion:*' file-list all
zstyle ':completion:*' squeeze-slashes true
zstyle ':completion:*' complete-options true
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'

# Cache completions
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path "$XDG_CACHE_HOME/zsh/.zcompcache"
