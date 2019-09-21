#!/bin/bash

HISTCONTROL=ignoreboth
HISTSIZE=5000
HISTFILESIZE=5000
HISTIGNORE="&:exit:clear:pwd:?:??"	# ignore one and two char commands

shopt -s histappend
shopt -s globstar
shopt -s cmdhist
shopt -s cdspell
shopt -s checkwinsize
