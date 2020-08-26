#!/bin/bash

# Load .bashrc and other files...
for file in ~/.{bashrc,bash_prompt,aliases,functions,path,dockerfunc,exports,secrets}; do
	if [[ -r "$file" ]] && [[ -f "$file" ]]; then
		# shellcheck source=/dev/null
		source "$file"
	fi
done
unset file

# nvm for osx 

if [ -f "$(brew --prefix nvm)/nvm.sh" ]; then
    source $(brew --prefix nvm)/nvm.sh 
else 
	echo "WARN: Sourcing NVM on OSX, but the file is not found."
fi
