# Setup fzf
# ---------
if [[ ! "$PATH" == */home/soheil/.fzf/bin* ]]; then
  PATH="${PATH:+${PATH}:}/home/soheil/.fzf/bin"
fi

# Show Hidden Files/Directory
# ___________________________
export FZF_DEFAULT_COMMAND='find .' 

# Auto-completion
# ---------------
source "/home/soheil/.fzf/shell/completion.bash"

# Key bindings
# ------------
source "/home/soheil/.fzf/shell/key-bindings.bash"
