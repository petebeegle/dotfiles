#!/usr/bin/env fish

# Check if main exists and use instead of master
function git_main_branch
  command git rev-parse --git-dir &>/dev/null || return
  for ref in refs/{heads,remotes/{origin,upstream}}/{main,trunk,mainline,default}
    if command git show-ref -q --verify $ref
      echo $(string split -r -m1 -f2 / $ref)
      return
    end
  end
  echo master
end

function git_current_branch
  echo $(command git rev-parse --abbrev-ref HEAD)
end

# aliases alphabetical order
alias -s g "git"
alias -s gaa "git add ."
alias -s gcb "git checkout -b"
alias -s gcn! "git commit --verbose --no-edit --amend"
alias -s gcmsg "git commit --message"
alias -s gp "git push"
alias -s gpf "git push -f"
alias -s gpsup "git push --set-upstream origin $(git_current_branch)"
alias -s gswm "git switch $(git_main_branch)"

alias -s l "ls -lFh"

alias -s prc "pre-commit"
alias -s prcra "pre-commit run --all-files"

alias -s tf "terraform"
alias -s tfa "terraform apply"
alias -s tfa! "terraform apply -auto-approve"
alias -s tfp "terraform plan"
