# Fast zsh config - no framework, lazy loading

# ============================================================================
# History
# ============================================================================
HISTFILE="${HOME}/.zsh_history"
HISTSIZE=50000
SAVEHIST=50000
setopt EXTENDED_HISTORY        # save timestamp and duration with each entry
setopt HIST_EXPIRE_DUPS_FIRST  # expire duplicate entries first when trimming
setopt HIST_IGNORE_ALL_DUPS    # remove older duplicate entries from history
setopt HIST_FIND_NO_DUPS       # don't show duplicates when searching
setopt HIST_IGNORE_SPACE       # don't save commands starting with a space
setopt HIST_SAVE_NO_DUPS       # don't write duplicate entries to history file
setopt HIST_REDUCE_BLANKS      # remove superfluous blanks from history
setopt HIST_VERIFY             # show expanded command before executing (!! etc)
setopt INC_APPEND_HISTORY      # write to history file immediately, not on exit
unsetopt SHARE_HISTORY

alias h='history'
alias hs='history | grep'
function hsi() { history | grep -i "$@" }

# ============================================================================
# Basic options
# ============================================================================
setopt AUTO_CD
setopt AUTO_PUSHD
setopt PUSHD_IGNORE_DUPS
setopt PUSHD_SILENT

# ============================================================================
# Completions (cached compinit)
# ============================================================================
autoload -Uz compinit
# Only regenerate .zcompdump once per day
if [[ -n ${ZDOTDIR}/.zcompdump(#qN.mh+24) ]]; then
  compinit
else
  compinit -C
fi
autoload -U +X bashcompinit && bashcompinit

zstyle ':completion:*' completer _extensions _complete _approximate
zstyle ':completion:*' menu select
zstyle ':completion:*' file-list all
zstyle ':completion:*' squeeze-slashes true
zstyle ':completion:*' complete-options true
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path "${XDG_CACHE_HOME:-$HOME/.cache}/zsh/.zcompcache"

# ============================================================================
# Cached completions (generated once, not on every shell start)
# ============================================================================
_completion_cache_dir="${XDG_CACHE_HOME:-$HOME/.cache}/zsh/completions"
[[ -d "$_completion_cache_dir" ]] || mkdir -p "$_completion_cache_dir"

_cache_completion() {
  local cmd=$1
  local cache_file="${_completion_cache_dir}/_${cmd}"
  if [[ -x "$(command -v $cmd)" ]]; then
    if [[ ! -f "$cache_file" || "$(command -v $cmd)" -nt "$cache_file" ]]; then
      $cmd completion zsh > "$cache_file" 2>/dev/null
    fi
    [[ -f "$cache_file" ]] && source "$cache_file"
  fi
}

_cache_completion kubectl
_cache_completion helm
_cache_completion talosctl

# ============================================================================
# Plugins (direct source, no framework)
# ============================================================================
_zsh_autosuggest="${HOME}/.zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh"
[[ -f "$_zsh_autosuggest" ]] && source "$_zsh_autosuggest"

# ============================================================================
# Aliases
# ============================================================================
[[ -f "${HOME}/.aliases.zsh" ]] && source "${HOME}/.aliases.zsh"

# ============================================================================
# Lazy load NVM (only init when needed)
# ============================================================================
if [[ -d "${NVM_DIR:-$HOME/.nvm}" ]]; then
  export NVM_DIR="${NVM_DIR:-$HOME/.nvm}"
  for _cmd in nvm node npm npx yarn pnpm corepack; do
    eval "
${_cmd}() {
  unset -f nvm node npm npx yarn pnpm corepack
  [[ -s \"\$NVM_DIR/nvm.sh\" ]] && source \"\$NVM_DIR/nvm.sh\"
  [[ -s \"\$NVM_DIR/bash_completion\" ]] && source \"\$NVM_DIR/bash_completion\"
  ${_cmd} \"\$@\"
}"
  done
  unset _cmd
fi

# ============================================================================
# SDKMAN
# ============================================================================
[[ -s "${SDKMAN_DIR:-$HOME/.sdkman}/bin/sdkman-init.sh" ]] && source "${SDKMAN_DIR:-$HOME/.sdkman}/bin/sdkman-init.sh"

# ============================================================================
# Keychain (SSH agent)
# ============================================================================
if [[ -x "$(command -v keychain)" && -f "${HOME}/.ssh/gitlab" ]]; then
  eval "$(keychain -q --nogui --eval "${HOME}/.ssh/gitlab")"
fi

# ============================================================================
# Prompt (Starship)
# ============================================================================
if [[ -x "$(command -v starship)" ]]; then
  eval "$(starship init zsh)"
fi

# ============================================================================
# PATH additions
# ============================================================================


# ============================================================================
# Key bindings for terminal navigation
# ============================================================================
# Alt+Left/Right for word navigation
bindkey '^[[1;3D' backward-word  # Alt+Left
bindkey '^[[1;3C' forward-word   # Alt+Right
bindkey '^[^[[D' backward-word   # Alt+Left (alternative)
bindkey '^[^[[C' forward-word    # Alt+Right (alternative)

# Ctrl+Left/Right for word navigation (alternative)
bindkey '^[[1;5D' backward-word  # Ctrl+Left
bindkey '^[[1;5C' forward-word   # Ctrl+Right

# Home/End keys
bindkey '^[[H' beginning-of-line
bindkey '^[[F' end-of-line

# Delete key
bindkey '^[[3~' delete-char
