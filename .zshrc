if type brew &>/dev/null; then
  FPATH=$(brew --prefix)/share/zsh/site-functions:$FPATH
fi

[ -f ~/.profile ] && source ~/.profile

autoload -Uz compinit && compinit
