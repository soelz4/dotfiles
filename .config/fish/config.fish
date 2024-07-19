if status is-interactive
    # Commands to run in interactive sessions can go here
	set fish_greeting ""
	set -gx TERM xterm-256color

	# Alias
	alias ls "exa --long --all --icons --header"
	alias tree "eza --tree"
	alias cat "bat"
	alias fzf "fzf --preview 'bat --style=numbers --color=always {}' --bind 'enter:become(vim {})'"
	alias nv "nvim"

	# Rust
	set -U fish_user_paths $HOME/.cargo/env $fish_user_paths
	set -U fish_user_paths $HOME/.cargo/bin $fish_user_paths
	# GO
	set -x -U fish_user_paths /usr/local/go/bin $fish_user_paths 
	# Tmuxifier
	set -gx PATH $HOME/.tmuxifier/bin $PATH
	eval (tmuxifier init - fish)
	# Deno
	set -x DENO_INSTALL ~/.deno
	set -x PATH $DENO_INSTALL/bin $PATH
	# Atuin
	atuin init fish | source
end
