
#  Used for setting user's interactive shell configuration and executing commands, 
# will be read when starting as an interactive shell.

<<<<<<< HEAD
# for colors in prompt
autoload -U colors && colors

# Load version control information
autoload -Uz vcs_info
precmd() { vcs_info }
zstyle ':vcs_info:git:*' formats '(%b)'
=======
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

# append asdf completions to fpath
fpath=(${ASDF_DIR}/completions $fpath)
>>>>>>> origin/zsh

autoload -Uz compinit promptinit

compinit
# https://superuser.com/questions/1092033/how-can-i-make-zsh-tab-completion-fix-capitalization-errors-for-directories-and
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'


promptinit
prompt walters

<<<<<<< HEAD
for file in ~/.{aliases,functions,path,dockerfunc,extra,exports}; do
	if [[ -r "$file" ]] && [[ -f "$file" ]]; then
		# shellcheck source=/dev/null
		source "$file"
	fi
done
unset file


# setopt PROMPT_SUBST
# PROMPT="%{$fg[red]%}%n%{$reset_color%}@%{$fg[blue]%}%m %{$fg[yellow]%}%~ %{$reset_color%} ${vcs_info_msg_0_}%% "


# Autoload zsh add-zsh-hook and vcs_info functions (-U autoload w/o substition, -z use zsh style)
autoload -Uz add-zsh-hook vcs_info
# Enable substitution in the prompt.
setopt prompt_subst
# Run vcs_info just before a prompt is displayed (precmd)
add-zsh-hook precmd vcs_info
# add ${vcs_info_msg_0} to the prompt
# e.g. here we add the Git information in red  
PROMPT='%{$fg[red]%}%n%{$reset_color%}@%{$fg[blue]%}%m %{$fg[yellow]%}%~ %{$reset_color%} %F{red}${vcs_info_msg_0_}%f %# '

# Enable checking for (un)staged changes, enabling use of %u and %c
zstyle ':vcs_info:*' check-for-changes true
# Set custom strings for an unstaged vcs repo changes (*) and staged changes (+)
zstyle ':vcs_info:*' unstagedstr ' *'
zstyle ':vcs_info:*' stagedstr ' +'
# Set the format of the Git information for vcs_info
zstyle ':vcs_info:git:*' formats       '(%b%u%c)'
zstyle ':vcs_info:git:*' actionformats '(%b|%a%u%c)'
=======
>>>>>>> origin/zsh
