# https://zsh.sourceforge.io/Doc/Release/User-Contributions.html#Version-Control-Information
# https://www.tweaking4all.com/software/macosx-software/customize-zsh-prompt/
# https://www.tweaking4all.com/software/macosx-software/xterm-color-cheat-sheet/

export PATH="$HOME/.local/bin:$PATH"

autoload -Uz vcs_info
autoload -Uz add-zsh-hook

add-zsh-hook precmd vcs_info

zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:*' formats " %F{120}%c%u(%b)%f"
zstyle ':vcs_info:*' actionformats " %F{120}%c%u(%b)%f"

# Custom prompt
setopt prompt_subst
PROMPT='%F{013}%~%f%B$vcs_info_msg_0_%b '

# Case-insensitive tab completion
set completion-ignore-case on

cd_code_dir() {
  cd ~/Developer/$1
}

# Aliases
alias d="docker"
alias dd="docker compose"
alias la="ls -la"
alias cdp="cd_code_dir"
alias gb="git branch"
alias gs="git status"
alias ga="git add -A"
alias gp="git pull --rebase"
alias co="git checkout"
alias undo_commit="git reset --soft HEAD~"
alias clean_branches="git remote prune origin; git branch --merged | grep -v '\*' | grep -v dev | xargs -n 1 git branch -d"

alias nginx.start="sudo nginx"
alias nginx.stop="sudo nginx -s quit"
alias nginx.restart="sudo nginx -s reload"
alias nginx.test="sudo nginx -t"

run_with_bundler() {
  if [ -e ./Gemfile ]; then
    echo "bundle exec $@"
    bundle exec $@
  else
    $@
  fi
}

for cmd in irb rake pry spec rspec puma rails rackup guard; do
  alias $cmd="run_with_bundler $cmd"
done

