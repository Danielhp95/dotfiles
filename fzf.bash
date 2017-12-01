# Setup fzf
# ---------
if [[ ! "$PATH" == */home/sarios/.fzf/bin* ]]; then
  export PATH="$PATH:/home/sarios/.fzf/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "/home/sarios/.fzf/shell/completion.bash" 2> /dev/null

# Key bindings
# ------------
export FZF_COMPLETION_TRIGGER='#'
source "/home/sarios/.fzf/shell/key-bindings.bash"

