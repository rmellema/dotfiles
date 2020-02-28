if type brew &>/dev/null; then
  FPATH=$(brew --prefix)/share/zsh/site-functions:$FPATH
fi

# Remove duplicates from history
setopt HIST_IGNORE_ALL_DUPS

autoload -Uz compinit && compinit

source /Users/renem/Library/Preferences/org.dystroy.broot/launcher/bash/br
