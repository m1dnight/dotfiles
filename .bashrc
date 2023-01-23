#!/bin/bash
# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
	*i*) ;;
	*) return;;
esac

# Case-insensitive globbing (used in pathname expansion)
shopt -s nocaseglob

# Append to the Bash history file, rather than overwriting it
shopt -s histappend

# Autocorrect typos in path names when using `cd`
shopt -s cdspell

# Enable some Bash 4 features when possible:
# * `autocd`, e.g. `**/qux` will enter `./foo/bar/baz/qux`
# * Recursive globbing, e.g. `echo **/*.txt`
for option in autocd globstar; do
	shopt -s "$option" 2> /dev/null
done

# Add tab completion for SSH hostnames based on ~/.ssh/config
# ignoring wildcards
[[ -e "$HOME/.ssh/config" ]] && complete -o "default" \
	-o "nospace" \
	-W "$(grep "^Host" ~/.ssh/config | \
	grep -v "[?*]" | cut -d " " -f2 | \
	tr ' ' '\n')" scp sftp ssh

# source kubectl bash completion
if hash kubectl 2>/dev/null; then
	# shellcheck source=/dev/null
	source <(kubectl completion bash)
fi

# ASDF 
if [[ -f "/opt/homebrew/opt/asdf/libexec/asdf.sh" ]]; then
	# shellcheck source=/dev/null
	. "/opt/homebrew/opt/asdf/libexec/asdf.sh"
fi

if [[ -f "${HOME}/.asdf/asdf.sh" ]]; then
	# shellcheck source=/dev/null
	. "${HOME}/.asdf/asdf.sh"
fi

if [[ -f "${HOME}/.asdf/completions/asdf.bash" ]]; then
	# shellcheck source=/dev/null
	. "${HOME}/.asdf/completions/asdf.bash"
fi

for file in ~/.{bash_prompt,aliases,functions,path,dockerfunc,extra,exports}; do
	if [[ -r "$file" ]] && [[ -f "$file" ]]; then
		# shellcheck source=/dev/null
		source "$file"
	fi
done
unset file

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
