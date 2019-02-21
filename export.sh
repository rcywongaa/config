#!/bin/bash

./import_export_keybindings.pl -e keybindings.csv
dconf dump /org/gnome/ > gnome.dconf
