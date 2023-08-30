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
alias -s gb "git branch"
alias -s gcb "git checkout -b"
alias -s gcn! "git commit --verbose --no-edit --amend"
alias -s gcmsg "git commit --message"
alias -s gd "git diff"
alias -s gl "git pull"
alias -s glog "git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"
alias -s gp "git push"
alias -s gpf "git push -f"
alias -s gs "git status -sb"

alias -s l "ls -lFh"

alias -s prc "pre-commit"
alias -s prcra "pre-commit run --all-files"

alias -s tf "terraform"
alias -s tfa "terraform apply"
alias -s tfa! "terraform apply -auto-approve"
alias -s tfp "terraform plan"

# functions
function gpsup --wraps='git push origin $git_current_branch --set-upstream' --description 'alias gpsup git push origin $git_current_branch --set-upstream'
  git push origin --set-upstream $(git_current_branch)

end
funcsave gpsup

function gswm --wraps='git switch $git_main_branch' --description 'alias gswm git switch $git_main_branch'
  git switch $(git_main_branch)
end
funcsave gswm

function aws-sso -d "Switch aws profiles" -a profile
  aws sso login --profile $profile
  eval "$(aws configure export-credentials --profile $profile --format env)"
end
funcsave aws-sso
