#!/bin/env bash

# Completing the host name will take ~10 seconds b/c we need to get the host
# names from AWS. The results are cached for 5 minutes.

_ansible() {
  local current_word=${COMP_WORDS[COMP_CWORD]}
  local previous_word=${COMP_WORDS[COMP_CWORD - 1]}

  if [[ "$previous_word" == "-l" ]] || [[ "$previous_word" == "--limit" ]]; then
    _ansible_complete_host "$current_word"
  else
    _ansible_complete_host_group "$current_word"
  fi
}

_ansible_complete_host_group() {
  local current_word=$1
  local groups=$( ansible localhost -m debug -a 'var=groups.keys()' | \
    awk 'NR==2{print $0}' | sed -r 's/.*\[(.*)\].*/\1/' | sed -r 's/, /\n/g' | \
    sed -r "s/'//g" )
  COMPREPLY=( $( compgen -W "$groups" -- "$current_word" ) )
}

_ansible_complete_host() {
  local current_word=$1
  local current_group=$( echo "${COMP_LINE}" | \
    sed -r 's/^.*?[[:space:]](.*(servers|cluster)).*/\1/' )

  # if there's no inventory group already on the line, look for "all" groups
  if [[ "$current_group" == "${COMP_LINE}" ]]; then
    current_group="all"
  fi

  local hosts=$(ansible $current_group --list-hosts | awk '/[^:]$/ {print $1}')

  COMPREPLY=( $( compgen -W "$hosts" -- "$current_word" ) )
}

complete -o default -F _ansible ansible
complete -o default -F _ansible ansible-playbook
