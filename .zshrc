
#  Used for setting user's interactive shell configuration and executing commands, 
# will be read when starting as an interactive shell.

zstyle ':completion:*' completer _expand _complete _ignored _correct _approximate
zstyle :compinstall filename '/Users/christophe/.zshrc'

autoload -Uz compinit
compinit

for file in ~/.{aliases,functions,path,dockerfunc,extra,exports}; do
	if [[ -r "$file" ]] && [[ -f "$file" ]]; then
		# shellcheck source=/dev/null
		source "$file"
	fi
done
unset file