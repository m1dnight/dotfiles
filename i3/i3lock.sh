#!/bin/bash
screenshot=$(mktemp --suffix=.png -u)
scrot "${screenshot}"
mogrify -scale 10% -scale 1000% "${screenshot}"
i3lock -i "${screenshot}"