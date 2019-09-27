#!/bin/bash

i3lock -e -f -B 1 \
    --clock --timecolor=ffffffff --datecolor=ffffffff \
    --ringcolor=505050ff --keyhlcolor=ffffffff \
    --linecolor=00000000 \
    --ringvercolor=00000000 --insidevercolor=00000000 --verifcolor=00000000 \
    --ringwrongcolor=00000000 --insidewrongcolor=00000000 --wrongcolor=00000000 \
    --wrongtext="f*ck off!" --wrongsize=100 --wrongcolor=ffffffff

systemctl suspend