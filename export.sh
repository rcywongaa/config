#!/bin/bash

./keybindings.pl -e keybindings.csv
dconf dump /org/gnome/shell/ > shell.dconf
dconf dump /org/gnome/terminal/ > terminal.dconf

