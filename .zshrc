if type brew &>/dev/null; then
  FPATH=$(brew --prefix)/share/zsh/site-functions:$FPATH
fi

autoload -Uz compinit && compinit
alias config='/usr/bin/git --git-dir=/Users/renem/.cfg/ --work-tree=/Users/renem'
