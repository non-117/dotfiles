# history
HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=10000
setopt hist_ignore_dups
setopt share_history

zstyle :compinstall filename '$HOME/.zshrc'

#alias
alias ipaddr="curl 'http://dyn.value-domain.com/cgi-bin/dyn.fcg?ip';echo"
alias now='date "+%y/%m/%d %H:%M:%S"'
alias ws="cd $HOME/Documents/workspace"
alias rs="python manage.py runserver"
alias cot='open $1 -a /Applications/CotEditor.app'
alias vpn='sudo openvpn $HOME/Dropbox/Server/openvpn2/openvpn443.conf'
alias python='python3'
alias py3='python3'

#path
PATH="/usr/local/bin:/usr/local/sbin:$HOME/.rbenv/bin:$HOME/.cabal/bin:$PATH"

#mikutter
export LANG=ja_JP.UTF-8
export XMODIFIERS=@im=uim
export GTK_IM_MODULE=uim

#node
#if [[ -f ~/.nodebrew/nodebrew ]]; then
#    export PATH=$HOME/.nodebrew/current/bin:$PATH
#    nodebrew use 0.10
#fi

#python
#export PYTHONPATH="$HOME/Documents/workspace/:$HOME/.pythonlib/:$PYTHONPATH"
#export INCLUDE_PATH="/usr/local/Cellar/python/2.7.5/Frameworks/Python.framework/Versions/2.7/include/python2.7:$INCLUDE_PATH"
#export WORKON_HOME=$HOME/virtualenvs
#source `which virtualenvwrapper.sh`
PIP_RESPECT_VIRTUALENV=true

#opencv
#export DYLD_FALLBACK_LIBRARY_PATH="/usr/local/opencv/lib:$DYLD_FALLBACK_LIBRARY_PATH"
export INCLUDE_PATH="/usr/local/opencv/include:$INCLUDE_PATH"
export LD_LIBRARY_PATH="/usr/local/opencv/lib:$LD_LIBRARY_PATH"
export PKG_CONFIG_PATH="/usr/local/opencv/lib/pkgconfig:/usr/lib/pkgconfig:$PKG_CONFIG_PATH"

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


###-begin-npm-completion-###
#
# npm command completion script
#
# Installation: npm completion >> ~/.bashrc  (or ~/.zshrc)
# Or, maybe: npm completion > /usr/local/etc/bash_completion.d/npm
#

COMP_WORDBREAKS=${COMP_WORDBREAKS/=/}
COMP_WORDBREAKS=${COMP_WORDBREAKS/@/}
export COMP_WORDBREAKS

if type complete &>/dev/null; then
  _npm_completion () {
    local si="$IFS"
    IFS=$'\n' COMPREPLY=($(COMP_CWORD="$COMP_CWORD" \
                           COMP_LINE="$COMP_LINE" \
                           COMP_POINT="$COMP_POINT" \
                           npm completion -- "${COMP_WORDS[@]}" \
                           2>/dev/null)) || return $?
    IFS="$si"
  }
  complete -F _npm_completion npm
elif type compdef &>/dev/null; then
  _npm_completion() {
    si=$IFS
    compadd -- $(COMP_CWORD=$((CURRENT-1)) \
                 COMP_LINE=$BUFFER \
                 COMP_POINT=0 \
                 npm completion -- "${words[@]}" \
                 2>/dev/null)
    IFS=$si
  }
  compdef _npm_completion npm
elif type compctl &>/dev/null; then
  _npm_completion () {
    local cword line point words si
    read -Ac words
    read -cn cword
    let cword-=1
    read -l line
    read -ln point
    si="$IFS"
    IFS=$'\n' reply=($(COMP_CWORD="$cword" \
                       COMP_LINE="$line" \
                       COMP_POINT="$point" \
                       npm completion -- "${words[@]}" \
                       2>/dev/null)) || return $?
    IFS="$si"
  }
  compctl -K _npm_completion npm
fi
###-end-npm-completion-###
