#!/bin/bash

if status is-interactive
    # Commands to run in interactive sessions can go here
end

# initialize ssh-agent
eval (ssh-agent -c)

# initialize starship
if test -z (pgrep starship)
    starship init fish | source
end

# Update path for homebrew installed things
set -U fish_user_paths /opt/homebrew/bin/ $fish_user_paths

# add pyenv
if test -z (pgrep pyenv)
    eval "$(pyenv init -)"
end
