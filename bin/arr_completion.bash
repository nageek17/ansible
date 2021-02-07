#!/bin/bash

# Completing the host name will take ~10 seconds b/c we need to get the host
# names from AWS. The results are cached for 5 minutes.

_arr() {
  local current_word=${COMP_WORDS[COMP_CWORD]}
  local previous_word=${COMP_WORDS[COMP_CWORD - 1]}

  if [[ "$previous_word" == "arr" ]]; then
    local options=$( ls roles | awk '/^[^_]/ {print}' )
    COMPREPLY=( $( compgen -W "$options" -- "$current_word" ) )
  elif [[ "$previous_word" == "-l" ]] || [[ "$previous_word" == "--limit" ]]; then
    _ansible_complete_host "$current_word"
  else
    _ansible_complete_host_group "$current_word"
  fi
}

complete -o default -F _arr arr
