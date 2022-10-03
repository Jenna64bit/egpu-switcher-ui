#!/usr/bin/bash -e
# UI to make picking GPU & restarting X easy as pie
# Requires egpu to be on the path & zenity installed

# Just using globals, too lazy to pass args
# This creates a symlink to the correct X11 config
update_x11()
{    
    echo "$password" | sudo -S egpu-switcher switch "$selection"
}

# And restart the session to apply the changes
restart_x_session()
{    
    echo "$password" | sudo -S service lightdm restart
}

# Prompt to grab user password for sudo
# User must have sudo permissions
password=$(zenity --password --title "eGPU Picker")

# Asks user to pick one of three options internal/egpu/auto
# Auto is enabled by default (falsey/truth bits)
selection=$(zenity --list --title "eGPU Picker" --radiolist --text 'Select GPU to use.\nX SESSION WILL RESTART IMMEDIATELY\!' --width 400 --height 300 --column "GPU" --column "Mode" FALSE 'internal' FALSE 'egpu' TRUE 'auto')

# And go!
update_x11
restart_x_session
