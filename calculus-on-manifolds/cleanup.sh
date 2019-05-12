#!/bin/bash
# thanks to
# https://gist.github.com/lelandbatey/8677901
FNAME="${1%.*}"
convert "$1" -morphology Convolve DoG:15,100,0 -negate -normalize -blur 0x1 -channel RBG -level 60%,91%,0.1 -type Grayscale -resize 768\> "$FNAME.gif"
