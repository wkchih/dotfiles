# BASICS

# path
PATH=~/bin:/usr/local/bin:/usr/local/sbin:/usr/bin:/usr/sbin:/bin:/sbin:$PATH
export PATH

# umask
umask 022

# editor/visual/pager
export EDITOR=vim
export VISUAL=vim
export PAGER=less

# zsh will not beep
setopt no_beep

# make cd push the old directory onto the directory stack
setopt auto_pushd



# COLORS

# colors
autoload -U colors
colors

# colored grep
export GREP_COLOR='31'
export GREP_OPTIONS='--color=auto'

# colored ls
eval "`dircolors -b`"
alias ls='ls --color=auto'

# make less always work with colored input
alias less='less -R'

# make watch always work with colored input
alias watch='watch --color'



# ALIASES

# ls
alias ll='ls -al'
alias l='ls -l'
alias sl=ls

# git
alias g='git'
alias wtf='git wtf'

# cd
alias -- -='cd -'
alias ..='cd ..'
alias ...='cd ../..'

# rails / bundler
alias r='rails'
alias b='bundle'
alias bundler='bundle'
alias bi='b install'
alias bu='b update'
alias be='b exec'

# heroku
alias hcp='heroku console --remote production'
alias hcs='heroku console --remote staging'
alias hlp='heroku logs -t --remote production'
alias hls='heroku logs -t --remote staging'

# subversion
alias svndiff='svn diff --diff-cmd=colordiff'
alias svnaddall='svn status | awk "/\\?/ {print \$2}" | xargs svn add'

# misc
alias _='sudo'
alias ack='ack-grep'
alias diff='colordiff -u'
alias mc='mc -cu'



# GLOBAL ALIASES

alias -g C='| wc -l'
alias -g L='| less'
alias -g M='| more'
alias -g S='&> /dev/null'



# HISTORY

# zsh history
export HISTFILE="$HOME/.zsh_history"
export HISTSIZE=10000
export SAVEHIST=${HISTSIZE}

# multiple zsh sessions will append to the same history file (incrementally, after each command is executed)
setopt inc_append_history

# purge duplicates first
setopt hist_expire_dups_first

# if a new command line being added to the history list duplicates an older one, the older command is removed from the list
setopt hist_ignore_all_dups

# reduce unnecessary blanks from commands being written to history
setopt hist_reduce_blanks

# import new commands from history (mostly)
setopt share_history



# COMMAND COMPLETION

# treat `#', `~' and `^' characters as part of patterns for filename generation
setopt extended_glob

# case insensitive matching when performing filename expansion
setopt no_case_glob

# if command not found, but directory found, cd into this directory
setopt auto_cd

# with auto_cd will also let you match directories found in ~/
setopt cdable_vars

# perform implicit tees or cats when multiple redirections are attempted
setopt multios

# do not send the HUP signal to backround jobs on shell exit
setopt no_hup

# parameter expansion, command substitution and arithmetic expansion are performed in prompts
setopt prompt_subst

# tab completion for both ends
setopt completeinword

# fuzzy matching for typos
zstyle ':completion:*' completer _complete _match _approximate
zstyle ':completion:*:match:*' original only
zstyle ':completion:*:approximate:*' max-errors 1 numeric

# tab completion should be case-insensitive
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'

# cd will never select parent
zstyle ':completion:*:cd:*' ignore-parents parent pwd

# tab completion for PIDs
zstyle ':completion:*:*:*:*:processes' command "ps -u `whoami` -o pid,user,comm,command -w -w"
zstyle ':completion:*:*:kill:*' menu yes select
zstyle ':completion:*:kill:*' force-list always

# cache completions
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.zsh/cache

# load completions
autoload -U compinit
compinit



# KEY BINDINGS

# make backward-word and forward-word move to each word separated by a '/'
export WORDCHARS=''

# emacs style keybindings by default
bindkey -e

# turn off terminal driver flow control (CTRL+S/CTRL+Q) (if we are a terminal)
if [ -t 0 ]; then
  stty -ixon -ixoff
fi

# edit command line
autoload -U edit-command-line
zle -N edit-command-line
bindkey '\C-x\C-e' edit-command-line

case "$TERM" in
  *xterm*)
    # alt + arrows
    bindkey '[D' backward-word
    bindkey '[C' forward-word

    # ctrl + arrows
    bindkey '^[OD' backward-word
    bindkey '^[OC' forward-word

    # home / end
    bindkey '^[[1~' beginning-of-line
    bindkey '^[[4~' end-of-line

    # delete
    bindkey '^[[3~' delete-char

    # page up / page down
    bindkey '^[[5~' history-beginning-search-backward
    bindkey '^[[6~' history-beginning-search-forward

    # shift + tab
    bindkey '^[[Z' reverse-menu-complete
  ;;
esac



# PROMPT

# zsh-git-prompt (https://github.com/olivierverdier/zsh-git-prompt/) -- slow, but *awesome*
source ~/.zsh/git-prompt/zshrc.sh

local smiley="%(?,%{$fg[green]%}☺%{$reset_color%},%{$fg[red]%}☹%{$reset_color%})"

PROMPT='
%(!.%{$fg[red]%}.%{$fg[green]%})%n@%m%{$reset_color%}: %{$fg[blue]%}%~%{$reset_color%} $(git_super_status) %{$fg[white]%}$(~/.rvm/bin/rvm-prompt)%{$reset_color%}
${smiley} %{$reset_color%}'

RPROMPT='%{$fg[white]%}%T%{$reset_color%}'



# SPELLING CORRECTIONS

setopt correct_all

alias man='nocorrect man'
alias mv='nocorrect mv'
alias mysql='nocorrect mysql'
alias mkdir='nocorrect mkdir'
alias gist='nocorrect gist'
alias heroku='nocorrect heroku'



# MISC STUFF

# Never type "bunde exec" again
source ~/.zsh/bundler/bundler.plugin.zsh

# SMART URLS
autoload -U url-quote-magic
zle -N self-insert url-quote-magic

# display CPU usage stats for commands taking more than 10 seconds
REPORTTIME=10

# Rails production environment by default for all non-development machines
[[ $(hostname -s) != 'ubuntu' ]] && [[ $(hostname -s) != 'genesis' ]] && export RAILS_ENV="production"

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(lesspipe)"

# git function
function scoreboard () {
  git log | grep Author | sort | uniq -ci | sort -hr
}

# set DISPLAY if Xvfb is running (expects it to run on :0)
xdpyinfo -display :0 &> /dev/null && export DISPLAY=:0

# RVM
if [[ -s ~/.rvm/scripts/rvm ]] ; then source ~/.rvm/scripts/rvm ; fi