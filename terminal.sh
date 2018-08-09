#!/usr/bin/bash

# Check if gnome-terminal is running.  If not, launch it

/usr/bin/pgrep gnome-terminal >/dev/null 2>&1
if [[ $? -eq 1 ]]
then
	/usr/bin/gnome-terminal
	/usr/bin/xdotool search --classname "Gnome-terminal" | tail -n1 > /tmp/gnome-term.wid
	/usr/bin/xdotool key "Super_L+Up"
else

# Check if terminal is active window
# If it is not the active window, use xdotool's windowmap function.
# If it is the active window, use the windowunmap function.

ACTIVEWID=$(xdotool getactivewindow)
GNOMETERMWID=$(cat /tmp/gnome-term.wid)
if [[ $ACTIVEWID -ne $GNOMETERMWID ]]
	then
		/usr/bin/xdotool windowmap $GNOMETERMWID
		/usr/bin/xdotool windowmove $GNOMETERMWID 0 0
		/usr/bin/xdotool windowactivate $GNOMETERMWID
	else
#		/usr/bin/xdotool windowminimize $GNOMETERMWID
		/usr/bin/xdotool windowunmap $GNOMETERMWID
	fi
fi
