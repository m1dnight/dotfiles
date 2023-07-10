
#  Used for setting user's interactive shell configuration and executing commands, 
# will be read when starting as an interactive shell.

autoload -Uz compinit promptinit

compinit
promptinit

zstyle ':completion:*' menu select

prompt walters

for file in ~/.{aliases,functions,path,dockerfunc,extra,exports}; do
	if [[ -r "$file" ]] && [[ -f "$file" ]]; then
		# shellcheck source=/dev/null
		source "$file"
	fi
done
unset file