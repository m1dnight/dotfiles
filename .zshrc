
# The following lines were added by compinstall

zstyle ':completion:*' completer _expand _complete _ignored _correct _approximate
zstyle :compinstall filename '/Users/christophe/.zshrc'

autoload -Uz compinit
compinit

# End of lines added by compinstall
# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
# End of lines configured by zsh-newuser-install

# ASDF 
if [[ -f "/opt/homebrew/opt/asdf/libexec/asdf.sh" ]]; then
	# shellcheck source=/dev/null
	. "/opt/homebrew/opt/asdf/libexec/asdf.sh"
fi

if [[ -f "${HOME}/.asdf/asdf.sh" ]]; then
	# shellcheck source=/dev/null
	. "${HOME}/.asdf/asdf.sh"
fi

if [[ $0 == "-bash" ]]; then
    echo "bash shell"
    if [[ -f "${HOME}/.asdf/completions/asdf.bash" ]]; then
        # shellcheck source=/dev/null
        . "${HOME}/.asdf/completions/asdf.bash"
    fi
fi


for file in ~/.{bash_prompt,aliases,functions,path,dockerfunc,extra,exports}; do
	if [[ -r "$file" ]] && [[ -f "$file" ]]; then
		# shellcheck source=/dev/null
		source "$file"
	fi
done
unset file