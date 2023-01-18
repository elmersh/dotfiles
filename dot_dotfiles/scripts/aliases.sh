#!/bin/bash
# Development stuff


# MongoDB
alias mongoin='mongosh  "mongodb://root:asdfbr%21%21%21@localhost:27017"'
alias tomc='/opt/homebrew/opt/tomcat/bin/catalina run'

# other

alias du='du -h'
alias myip='curl ipinfo.io/ip'

alias cp='cp -i'
alias mv='mv -i'

alias co='xclip-copyfile'
alias pa='xclip-pastefile'
alias cu='xclip-cutfile'

alias lh='ls -d .*' # only hidden files
alias la="ls -AXb --group-directories-first --sort=extension"
alias ln="ln -sv"
alias lsda="lsd -A --group-dirs first --classify"
alias lsdo="lsd -A --group-dirs first --classify --recursive --depth=2"
alias l='ls -l'
alias lla='ls -la'
alias lt='ls --tree'
# alias reloaddns='dscacheutil -flushcache && sudo killall -HUP mDNSResponder'

alias l='lsd'

# Laravel
alias a='php artisan'
alias amfs='php artisan migrate:fresh --seed'

# Archivos de proyectos
alias dev='cd ~/Dev'


# checkout main branch
alias gchm='git checkout main'
alias gchd='git checkout dev'
alias ginit="git init && git add . && git commit -m 'Inicializando proyecto'"
alias amend='git commit --amend --no-edit'
alias amendall='git add . && amend'
alias wip='commit wip'
alias gchw='git checkout $(date +%d%b%Y)'
alias gchn='git checkout -b $(date +%d%b%Y)'
alias gmw='git merge $(date +%d%b%Y)'
alias gmw='git merge main'
alias gmd='git merge dev'
alias resolve='git add . && git commit --no-edit'
alias nuke='git clean -df && git reset --hard'
alias gac="git add . && git commit -m 'algo se hizo acá...'"


alias ptest='vendor/bin/phpunit'

# tmux aliases
alias ta='tmux attach'
alias tls='tmux ls'
alias tat='tmux attach -t'
alias tns='tmux new-session -s'
alias tkill='\tmux kill-session -a'


# npm
alias npi='npm install'
alias nrd='npm run dev'
alias nrp='npm run prod'
alias nget="pnpm install $1"
alias rrw="pnpm run dev"
alias rrbd="pnpm run build"
alias pn=pnpm

# yarn
alias yar='yarn'
alias yara='yarn add'
alias yarad='yarn add --dev'

