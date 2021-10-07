# https://askubuntu.com/a/22043
# The first word of each simple command, if unquoted, 
# is checked to see if it has an alias.
#
# If the last character of the alias value is a space or tab character, 
# then the next command word following the alias is also checked 
# for alias expansion. 
alias sudo='sudo '

alias cl='clear'
alias cls='clear; ls'
alias ll='ls -hal'
alias la='ls -A'
alias l='ls -CF'
alias tree='tree -a -I ".svn|.git|.hg"'
alias tree2='tree -L 2'
alias tree3='tree -L 3'

alias mci='mvn -T 1C clean install'
alias mcd='mvn clean deploy'
alias killjava='killall java'

alias gs='git status'
alias gl='git log'
