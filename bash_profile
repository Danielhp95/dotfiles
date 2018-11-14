# Xclip aliases
alias pbcopy='xclip -selection clipboard'
alias pbpaste='xclip -selection clipboard -o'

# Git aliases
alias wow="git status"
alias such="git"
alias gitadog='git log --all --decorate --oneline --graph'

# base16 aliases
alias day='base16_google-light'
alias night='base16_3024'
alias bright='base16_bright'
alias normal='base16_solarized-dark'

# York vpn and YARCC aliases
alias yorkvpn="/usr/local/pulse/pulsesvc -h webvpn.york.ac.uk -u dh1135 -r york_users_realm"
alias sshyarcc="ssh dh1135@login.yarcc.york.ac.uk"

# pipenv alias
alias pvr='pipenv run'

# Unity utilities
alias Unity='~/ProgramFiles/Unity/Editor/Unity'

# system utilities
alias wtf='~/ProgramFiles/wtf_0.1.1_linux_386/wtf'
alias se='sensors'

# Browsers
alias ff='./ProgramFiles/firefox/firefox'

# Remaping caps to escape
setxkbmap -option caps:escape
