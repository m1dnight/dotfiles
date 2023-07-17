
#  Used for setting user's interactive shell configuration and executing commands, 
# will be read when starting as an interactive shell.

for file in ~/.{aliases,functions,path,dockerfunc,extra,exports}; do
	if [[ -r "$file" ]] && [[ -f "$file" ]]; then
		# shellcheck source=/dev/null
		source "$file"
	fi
done
unset file

# brew
if [[ $OSTYPE == 'darwin'* ]]; then
	eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# asdf osx
if [[ -f "/opt/homebrew/opt/asdf/libexec/asdf.sh" ]]; then
	# shellcheck source=/dev/null
	. "/opt/homebrew/opt/asdf/libexec/asdf.sh"
fi

# asdf linux
if [[ -f "${HOME}/.asdf/asdf.sh" ]]; then
	# shellcheck source=/dev/null
	. "${HOME}/.asdf/asdf.sh"
fi

# other files
if [[ $0 == "-bash" ]]; then
    echo "bash shell"
    if [[ -f "${HOME}/.asdf/completions/asdf.bash" ]]; then
        # shellcheck source=/dev/null
        . "${HOME}/.asdf/completions/asdf.bash"
    fi
fi

# # append completions to fpath
# fpath=(${ASDF_DIR}/completions $fpath)

autoload -Uz compinit promptinit

compinit
# https://superuser.com/questions/1092033/how-can-i-make-zsh-tab-completion-fix-capitalization-errors-for-directories-and
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'


promptinit
prompt walters

