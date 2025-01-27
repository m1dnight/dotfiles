
#  Used for setting user's interactive shell configuration and executing
# commands, will be read when starting as an interactive shell.

################################################################################
# import all files from dotfiles
for file in ~/.{aliases,functions,dockerfunc,extra,exports,path}; do
	if [[ -r "$file" ]] && [[ -f "$file" ]]; then
		# shellcheck source=/dev/null
		source "$file"
	fi
done
unset file

################################################################################

autoload -U colors && colors
autoload -Uz vcs_info
precmd() { vcs_info }

################################################################################
# vcs_info configuration

# Enable checking for (un)staged changes, enabling use of %u and %c
zstyle ':vcs_info:*' check-for-changes true
# Set custom strings for an unstaged vcs repo changes (*) and staged changes (+)
zstyle ':vcs_info:*' unstagedstr ' *'
zstyle ':vcs_info:*' stagedstr ' +'
# Set the format of the Git information for vcs_info
# %m is the ahead/before diff
zstyle ':vcs_info:git:*' formats       '(%b%u%c|%m)'
zstyle ':vcs_info:git:*' actionformats '(%b|%a%u%c)'

# zstyle ':vcs_info:*+*:*' debug true

### git: Show +N/-N when your local branch is ahead-of or behind remote HEAD.
# Make sure you have added misc to your 'formats':  %m
zstyle ':vcs_info:git*+set-message:*' hooks git-st git-untracked
+vi-git-st() {
    local ahead behind
    local -a gitstatus

    # Exit early in case the worktree is on a detached HEAD
    git rev-parse ${hook_com[branch]}@{upstream} >/dev/null 2>&1 || return 0

    local -a ahead_and_behind=(
        $(git rev-list --left-right --count HEAD...${hook_com[branch]}@{upstream} 2>/dev/null)
    )

    ahead=${ahead_and_behind[1]}
    behind=${ahead_and_behind[2]}

	((( $ahead)) || (( $behind))) || gitstatus+=( "✓" )
    (( $ahead )) && gitstatus+=( "+${ahead}" )
    (( $behind )) && gitstatus+=( "-${behind}" )

    hook_com[misc]+=${(j:/:)gitstatus}
}

### git: Show untracked branches
# Make sure you have added misc to your 'formats':  %m
# zstyle ':vcs_info:git*+set-message:*' hooks git-untracked
+vi-git-untracked() {
    local -a xx

    # Exit early in case the worktree has a remote branch
    git rev-parse ${hook_com[branch]}@{push} >/dev/null 2>&1 && return 0

	xx+=( "untracked" )

    hook_com[misc]+=${(j:/:)xx}
}

################################################################################

# append asdf completions to fpath
fpath=(${ASDF_DIR}/completions $fpath)

autoload -Uz compinit promptinit
compinit

# https://superuser.com/questions/1092033/how-can-i-make-zsh-tab-completion-fix-capitalization-errors-for-directories-and
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'

promptinit
prompt walters

# Autoload zsh add-zsh-hook and vcs_info functions (-U autoload w/o substition, -z use zsh style)
autoload -Uz add-zsh-hook vcs_info
# Enable substitution in the prompt.
setopt prompt_subst
# Run vcs_info just before a prompt is displayed (precmd)
add-zsh-hook precmd vcs_info
# add ${vcs_info_msg_0} to the prompt
# e.g. here we add the Git information in red


################################################################################
# prompt

# PROMPT='%{$bg[cyan]%}%{$fg[white]%}%n%{$reset_color%}@%{$fg[red]%}%m %{$fg[white]%}%~ %{$reset_color%} %F{magenta}${vcs_info_msg_0_}%f %# '
PROMPT='%{$fg[cyan]%}%n%{$reset_color%}@%{$fg[red]%}%m %{$fg[white]%}%~ %{$reset_color%} %F{magenta}${vcs_info_msg_0_}%f %# '

RPS1='%D{%L:%M:%S}'


################################################################################
# history

# https://unix.stackexchange.com/questions/273861/unlimited-history-in-zsh
setopt histignorealldups
HISTFILE="$HOME/.zsh_history"
HISTSIZE=10000000
SAVEHIST=10000000
setopt BANG_HIST                 # Treat the '!' character specially during expansion.
setopt EXTENDED_HISTORY          # Write the history file in the ":start:elapsed;command" format.
setopt INC_APPEND_HISTORY        # Write to the history file immediately, not when the shell exits.
setopt SHARE_HISTORY             # Share history between all sessions.
setopt HIST_EXPIRE_DUPS_FIRST    # Expire duplicate entries first when trimming history.
setopt HIST_IGNORE_DUPS          # Don't record an entry that was just recorded again.
setopt HIST_IGNORE_ALL_DUPS      # Delete old recorded entry if new entry is a duplicate.
setopt HIST_FIND_NO_DUPS         # Do not display a line previously found.
setopt HIST_REDUCE_BLANKS        # Remove superfluous blanks before recording entry.
setopt HIST_VERIFY               # Don't execute immediately upon history expansion.
setopt HIST_BEEP                 # Beep when accessing nonexistent history.

#foo