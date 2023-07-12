# Used for setting user's environment variables; 
# it should not contain commands that produce output or assume the shell is attached to a TTY.
# When this file exists it will always be read.

# default editor
EDITOR=emacs

# history
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000

PROMPT='%/ %# '

# History in iex.
ERL_AFLAGS="-kernel shell_history enabled"


