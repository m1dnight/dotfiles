# Used for setting user's environment variables; it should not contain commands
# that produce output or assume the shell is attached to a TTY. When this file
# exists it will always be read.

# Set SSH_AUTH_SOCK to use 1Password as SSH Agent when not ssh'd in remotely.
if [ -z $SSH_TTY ] ; then
    export SSH_AUTH_SOCK=~/Library/Group\ Containers/2BUA8C4S2C.com.1password/t/agent.sock
fi