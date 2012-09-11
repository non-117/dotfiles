# history
HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=10000
setopt hist_ignore_dups
setopt share_history

zstyle :compinstall filename '$HOME/.zshrc'

#alias
alias ip="curl 'http://dyn.value-domain.com/cgi-bin/dyn.fcg?ip';echo"
alias now='date "+%y/%m/%d %H:%M:%S"'
alias ws="cd $HOME/Documents/workspace"
alias rs="python manage.py runserver"

#gentoo
EPREFIX="$HOME/Gentoo"
PATH="/usr/local/bin:$EPREFIX/usr/sbin:$EPREFIX/usr/bin:$EPREFIX/bin:$EPREFIX/tmp/usr/bin:$EPREFIX/tmp/bin:$PATH:/Library/PostgreSQL/9.0/bin/:/usr/local/share/python/"

#python
export PYTHONPATH="$HOME/Documents/workspace/:"$PYTHONPATH../
export WORKON_HOME=$HOME/virtualenvs
source `which virtualenvwrapper.sh`
PIP_RESPECT_VIRTUALENV=true

#emacs keybind
bindkey -e

#complement
autoload -Uz compinit && compinit

# encoding
export LANG=ja_JP.UTF-8

# cd
setopt auto_cd
# cdup
function cdup() {
echo
cd ..
zle reset-prompt
}
zle -N cdup
bindkey '\^' cdup

# ls
case "${OSTYPE}" in
freebsd*|darwin*)
  if [ -d $EPREFIX ];then;
    alias ls="ls -GF --color"
  else;
    alias ls="ls -GF"
  fi;
  ;;
linux*)
  alias ls="ls -F --color"
  ;;
esac

#cdls
function cd() {builtin cd $@ && ls}


alias la='ls -a'
alias ll='ls -l'
alias lla='ls -al'

alls() {
  zle accept-line
  if [[ -z "$BUFFER" ]]; then
    echo ''
    ls
  fi
}
zle -N alls
bindkey "\C-m" alls

#prompt
autoload colors
colors
PROMPT="
 %{${fg[yellow]}%}%~%{${reset_color}%} 
[%n]$ "

PROMPT2='[%n]> ' 

#history search
autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^P" history-beginning-search-backward-end
bindkey "^N" history-beginning-search-forward-end 

#abbreviation
typeset -A myabbrev
myabbrev=(
    "ll"    "| less"
    "lg"    "| grep"
    "tx"    "tar -xvzf"
)

my-expand-abbrev() {
    local left prefix
    left=$(echo -nE "$LBUFFER" | sed -e "s/[_a-zA-Z0-9]*$//")
    prefix=$(echo -nE "$LBUFFER" | sed -e "s/.*[^_a-zA-Z0-9]\([_a-zA-Z0-9]*\)$/\1/")
    LBUFFER=$left${myabbrev[$prefix]:-$prefix}" "
}
zle -N my-expand-abbrev
bindkey     " "         my-expand-abbrev

source .zsh/plugin/incr*.zsh
