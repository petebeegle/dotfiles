#!/usr/bin/env bash
# Claude Code status line — based on bash PS1: \u@\h:\w
input=$(cat)

user=$(whoami)
host=$(hostname -s)
cwd=$(echo "$input" | jq -r '.workspace.current_dir // .cwd // empty')
model=$(echo "$input" | jq -r '.model.display_name // empty')

# Context window usage
used_pct=$(echo "$input" | jq -r '.context_window.used_percentage // empty')

# Rate limits
five_h=$(echo "$input" | jq -r '.rate_limits.five_hour.used_percentage // empty')
seven_d=$(echo "$input" | jq -r '.rate_limits.seven_day.used_percentage // empty')

# Shorten cwd: replace $HOME with ~
home_dir=$(eval echo ~)
cwd="${cwd/#$home_dir/\~}"

# Build rate limit string
rate_str=""
[ -n "$five_h" ] && rate_str="5h:$(printf '%.0f' "$five_h")%"
[ -n "$seven_d" ] && rate_str="$rate_str 7d:$(printf '%.0f' "$seven_d")%"
rate_str="${rate_str# }"

# Build context string
ctx_str=""
[ -n "$used_pct" ] && ctx_str="ctx:$(printf '%.0f' "$used_pct")%"

# Assemble status line with ANSI colors
printf "\033[32m%s@%s\033[0m:\033[34m%s\033[0m" "$user" "$host" "$cwd"

if [ -n "$model" ]; then
  printf " \033[33m[%s]\033[0m" "$model"
fi

if [ -n "$ctx_str" ]; then
  printf " \033[36m%s\033[0m" "$ctx_str"
fi

if [ -n "$rate_str" ]; then
  printf " \033[35m%s\033[0m" "$rate_str"
fi

printf "\n"
