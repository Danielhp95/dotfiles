# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Needed to run bundle commands
export PATH="$PATH:(ruby -e 'puts Gem.use_dir')/bin"
export EDITOR='/usr/bin/vim'
export TERMINAL='/usr/bin/kitty'
export BROWSER='/usr/bin/firefox'

# Enable control-s and control-q
stty -ixon
# Remaping caps to escape
setxkbmap -option caps:escape


# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="agnoster"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in ~/.oh-my-zsh/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Case-sensitive completion must be off. _ and - will be interchangeable.
HYPHEN_INSENSITIVE="true"

# Uncomment the following line to enable command auto-correction.
ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git fzf vundle colored-man-pages)

# Base16 Shell
BASE16_SHELL="$HOME/.config/base16-shell/"
[ -n "$PS1" ] && \
    [ -s "$BASE16_SHELL/profile_helper.sh" ] && \
        eval "$("$BASE16_SHELL/profile_helper.sh")"

# Users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.

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

alias tmuxx='tmux new-session -A -s playground'

# York vpn
alias yorkvpn="/usr/local/pulse/pulsesvc -h webvpn.york.ac.uk -u dh1135 -r york_users_realm"

# Unity utilities
alias Unity='~/ProgramFiles/Unity/Editor/Unity'

# system utilities
alias se='sensors'


# For kitty terminal
autoload -Uz compinit
compinit
# Completion for kitty
kitty + complete setup zsh | source /dev/stdin

if [ -z "$TMUX" ]; then
    base_session='playground'
    # Create a new session if it doesn't exist
    tmux has-session -t $base_session || tmux new-session -d -s $base_session
    tmux attach-session -t $base_session
fi

# Path to oh-my-zsh installation.
export ZSH="/home/sarios/.oh-my-zsh"
source $ZSH/oh-my-zsh.sh


prompt_end() {
    if [[ -n $CURRENT_BG ]]; then
        print -n "%{%k%F{$CURRENT_BG}%}$SEGMENT_SEPARATOR"
    else
        print -n "%{%k%}"
    fi

    print -n "%{%f%}"
    CURRENT_BG='' 

    #Adds the new line and ➜ as the start character.
    printf "\n ➜";
}


