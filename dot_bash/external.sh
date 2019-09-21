#!/bin/bash

if [ -d /usr/share/fzf ]; then
	source /usr/share/fzf/key-bindings.bash
	source /usr/share/fzf/completion.bash

	# fe [FUZZY PATTERN] - Open the selected file with the default editor
	#   - Bypass fuzzy finder if there's only one match (--select-1)
	#   - Exit if there's no match (--exit-0)
	fe() {
		local files
		IFS=$'\n' files=($(fzf-tmux --query="$1" --multi --select-1 --exit-0 --preview "bat --color \"always\" {}"))
		[[ -n "$files" ]] && ${EDITOR} "${files[@]}"
	}

	# fdr - cd to selected parent directory
	fdr() {
		local declare dirs=()
		get_parent_dirs() {
			if [[ -d "${1}" ]]; then dirs+=("$1"); else return; fi
			if [[ "${1}" == '/' ]]; then
				for _dir in "${dirs[@]}"; do echo $_dir; done
			else
				get_parent_dirs $(dirname "$1")
			fi
		}
		local DIR=$(get_parent_dirs $(realpath "${1:-$PWD}") | fzf-tmux --tac)
		cd "$DIR"
	}

	# fda - including hidden directories
	fda() {
		local dir
		dir=$(find ${1:-.} -type d 2> /dev/null | fzf +m) && cd "$dir"
	}
fi

if CMD_AVAILABLE activate-global-python-argcomplete; then
	eval "$(activate-global-python-argcomplete --dest=-)"
fi
