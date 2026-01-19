# Fast zsh config - no framework, lazy loading

# ============================================================================
# History
# ============================================================================
HISTFILE="${HOME}/.zsh_history"
HISTSIZE=10000
SAVEHIST=10000
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_SAVE_NO_DUPS
setopt HIST_REDUCE_BLANKS
setopt INC_APPEND_HISTORY
unsetopt SHARE_HISTORY

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
# Aliases & exports
# ============================================================================
_dotfiles_dir="${DOTFILES_LOCATION:-$HOME/dotfiles}"
[[ -f "${_dotfiles_dir}/omz/aliases.zsh" ]] && source "${_dotfiles_dir}/omz/aliases.zsh"
[[ -f "${_dotfiles_dir}/omz/exports.zsh" ]] && source "${_dotfiles_dir}/omz/exports.zsh"

# ============================================================================
# Lazy load NVM (only init when needed)
# ============================================================================
if [[ -d "${NVM_DIR:-$HOME/.nvm}" ]]; then
  _nvm_cmds=(nvm node npm npx yarn pnpm corepack)
  _nvm_lazy_load() {
    unset -f "${_nvm_cmds[@]}"
    export NVM_DIR="${NVM_DIR:-$HOME/.nvm}"
    [[ -s "$NVM_DIR/nvm.sh" ]] && source "$NVM_DIR/nvm.sh"
    [[ -s "$NVM_DIR/bash_completion" ]] && source "$NVM_DIR/bash_completion"
  }
  for _cmd in "${_nvm_cmds[@]}"; do
    eval "${_cmd}() { _nvm_lazy_load; ${_cmd} \"\$@\"; }"
  done
  unset _cmd
fi

# ============================================================================
# Lazy load SDKMAN (only init when needed)
# ============================================================================
if [[ -d "${SDKMAN_DIR:-$HOME/.sdkman}" ]]; then
  _sdk_cmds=(sdk java javac gradle mvn kotlin kotlinc groovy scala sbt)
  _sdk_lazy_load() {
    unset -f "${_sdk_cmds[@]}"
    export SDKMAN_DIR="${SDKMAN_DIR:-$HOME/.sdkman}"
    [[ -s "$SDKMAN_DIR/bin/sdkman-init.sh" ]] && source "$SDKMAN_DIR/bin/sdkman-init.sh"
  }
  for _cmd in "${_sdk_cmds[@]}"; do
    eval "${_cmd}() { _sdk_lazy_load; ${_cmd} \"\$@\"; }"
  done
  unset _cmd
fi

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
export PATH="${HOME}/.local/bin:${PATH}"


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
