# history
HISTFILE=~/.histfile
HISTSIZE=1000000
SAVEHIST=1000000
setopt hist_ignore_dups
setopt share_history

zstyle :compinstall filename '$HOME/.zshrc'

# ENV config
unset SSH_ASKPASS

#alias
alias now='date "+%y/%m/%d %H:%M:%S"'
alias tmux="TERM=screen-256color-bce tmux"
if [[ -x `which colordiff` ]]; then
  alias diff='colordiff -u'
  export LESS='-R'
else
  alias diff='diff -u'
fi
alias con='rails c'
alias server='rails s -b 0.0.0.0'
alias weather='curl http://wttr.in/kyoto'

#proxy
#export http_proxy=''
#export https_proxy=''

#vim
export XDG_CONFIG_HOME=$HOME/.config

#path
PATH="/usr/local/bin:/usr/local/sbin:$HOME/.rbenv/bin:$HOME/.pyenv/bin:$HOME/build/bin:/usr/local/opt/go/libexec/bin:$HOME/.nodebrew/current/bin:$PATH"
export LD_LIBRARY_PATH="/usr/local/lib:$LD_LIBRARY_PATH"

#emacs keybind
bindkey -e
export EDITOR=vim
#hjkl

# less
export LESS='-R --no-init --quit-if-one-screen'
export LESSOPEN='| /usr/local/bin/src-hilite-lesspipe.sh %s'

# gtags
export GTAGSLABEL=pygments

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

source ~/.zsh/plugin/incr*.zsh

# ruby
eval "$(rbenv init -)"

# python
eval "$(pyenv init -)"

# direnv
eval "$(direnv hook zsh)"

# syntaxhighlight
if [ -f ~/.zsh/syntax-highlight/zsh-syntax-highlighting.zsh ]; then
    source ~/.zsh/syntax-highlight/zsh-syntax-highlighting.zsh
fi

export REPORTTIME=1

source ~/.pecorc

#complement
autoload -Uz compinit && compinit

man() {
    env \
        LESS_TERMCAP_mb=$(printf "\e[1;31m") \
        LESS_TERMCAP_md=$(printf "\e[1;31m") \
        LESS_TERMCAP_me=$(printf "\e[0m") \
        LESS_TERMCAP_se=$(printf "\e[0m") \
        LESS_TERMCAP_so=$(printf "\e[1;44;33m") \
        LESS_TERMCAP_ue=$(printf "\e[0m") \
        LESS_TERMCAP_us=$(printf "\e[1;32m") \
            man "$@"
}
