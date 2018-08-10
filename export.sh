#!/bin/bash

./keybindings.pl -e keybindings.csv
dconf dump /org/gnome/ > gnome.dconf
