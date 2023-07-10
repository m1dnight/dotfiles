#  Used for executing user's commands at start, will be read when starting as a login shell. 
# Typically used to autostart graphical sessions and to set session-wide environment variables.

# Brew.
if [[ $OSTYPE == 'darwin'* ]]; then
	eval "$(/opt/homebrew/bin/brew shellenv)"
fi

if [[ -f "/opt/homebrew/opt/asdf/libexec/asdf.sh" ]]; then
	# shellcheck source=/dev/null
	. "/opt/homebrew/opt/asdf/libexec/asdf.sh"
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

if [[ $0 == "-bash" ]]; then
    echo "bash shell"
    if [[ -f "${HOME}/.asdf/completions/asdf.bash" ]]; then
        # shellcheck source=/dev/null
        . "${HOME}/.asdf/completions/asdf.bash"
    fi
fi