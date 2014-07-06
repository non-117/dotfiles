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
alias cot='open $1 -a /Applications/CotEditor.app'
alias vpn='sudo openvpn $HOME/Dropbox/Server/openvpn/openvpn443.conf'
alias py3='python3'

#path
PATH="/usr/local/bin:/usr/local/sbin:$HOME/Library/Haskell/bin:$HOME/.rbenv/bin:$PATH"

#node
if [[ -f ~/.nodebrew/nodebrew ]]; then
    export PATH=$HOME/.nodebrew/current/bin:$PATH
    nodebrew use 0.10
fi

#python
#export PYTHONPATH="$HOME/Documents/workspace/:$HOME/.pythonlib/:$PYTHONPATH"
#export INCLUDE_PATH="/usr/local/Cellar/python/2.7.5/Frameworks/Python.framework/Versions/2.7/include/python2.7:$INCLUDE_PATH"
#export WORKON_HOME=$HOME/virtualenvs
#source `which virtualenvwrapper.sh`
#PIP_RESPECT_VIRTUALENV=true

#opencv
#export DYLD_FALLBACK_LIBRARY_PATH="/usr/local/opencv/lib:$DYLD_FALLBACK_LIBRARY_PATH"
#export INCLUDE_PATH="/usr/local/opencv/include:$INCLUDE_PATH"
#export LD_LIBRARY_PATH="/usr/local/opencv/lib:$LD_LIBRARY_PATH"
#export PKG_CONFIG_PATH="/usr/local/opencv/lib/pkgconfig:/usr/lib/pkgconfig:$PKG_CONFIG_PATH"

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
# auto_pushd
setopt auto_pushd
setopt pushd_ignore_dups

# ls
case "${OSTYPE}" in
freebsd*|darwin*)
  alias ls="ls -GF"
  ;;
linux*)
  alias ls="ls -F --color"
  ;;
esac

#cdls
function chpwd() {ls}


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
(✿╹◡╹)c %{${fg[yellow]}%}%~%{${reset_color}%} 
[%B%F{6}%n%f@%F{2}${HOST}%f%b]$ "

PROMPT2='[%n]> ' 

#history search
autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^P" history-beginning-search-backward-end
bindkey "^N" history-beginning-search-forward-end 

#url quote magic
autoload -Uz url-quote-magic
zle -N self-insert url-quote-magic

#abbreviation
typeset -A myabbrev
myabbrev=(
#    "ll"    "| less"
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

# ruby
eval "$(rbenv init -)"

# syntaxhighlight
if [ -f ~/.zsh/syntax-highlight/zsh-syntax-highlighting.zsh ]; then
    source ~/.zsh/syntax-highlight/zsh-syntax-highlighting.zsh
fi

# pyenv
export PYENV_ROOT="${HOME}/.pyenv"
if [ -d "${PYENV_ROOT}" ]; then
    export PATH=${PYENV_ROOT}/bin:${PYENV_ROOT}/shims:$PATH
    eval "$(pyenv init -)"
fi

