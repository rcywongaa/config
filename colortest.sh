#!/bin/sh
#
## colortest256.sh - output a color test page

clear=$(printf "\033[m")
bg=$(printf "\033[48;5;")
fg=$(printf "\033[38;5;")
bd=$(printf "\033[1m")

printf "The 16 ${bd}system colors:$clear\n"
for color in 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15; do
  printf "$bg${color}m$fg%dm%3d" $((color % 4 ? 0 : 15)) $color
  test $color = 7 && printf "$clear${fg}0m\n"
done
printf "$clear\n\n"

printf "The 6x6x6 color cube:\n"
for g in 0 1 2 3 4 5; do
  for r in 0 1 2; do
    for b in 0 1 2 3 4 5; do
      : $((color = 16 + r * 36 + g * 6 + b))
      printf "$bg${color}m$fg%dm%3d$clear" $((g > 2 ? 0 : 15)) $color
      test $b -lt 5 && printf ' '
    done
    printf "$clear"
    test $r -lt 2 && printf '|'
  done
  printf "\n"
done
printf '%s\n' "-----------------------+-----------------------+-----------------------"

for g in 0 1 2 3 4 5; do
  for r in 3 4 5; do
    for b in 0 1 2 3 4 5; do
      : $((color = 16 + r * 36 + g * 6 + b))
      printf "$bg${color}m$fg%dm%3d$clear" $((g > 2 ? 0 : 15)) $color
      test $b -lt 5 && printf ' '
    done
    test $r -lt 5 && printf '|'
    printf "$clear"
  done
  printf "\n"
done
printf "\n"

printf "The neutral step wedge:\n";
for color in 232 233 234 235 236 237 238 239 240 241 242 243; do
  printf "$bg${color}m${fg}15m%4d" $color
done
printf "$clear\n"
for color in 244 245 246 247 248 249 250 251 252 253 254 255; do
  printf "$bg${color}m${fg}0m%4d" $color
done
printf "$clear\n"
