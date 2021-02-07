# ansible bash completions
export PATH="/ansible/bin:$PATH"
source /ansible/bin/ansible_completion.bash
source /ansible/bin/arr_completion.bash

# git bash completions
source /ansible/bin/git-completion.bash

# show git branch on prompt
source /ansible/bin/git-prompt.sh
export GIT_PS1_SHOWCOLORHINTS=true
export PROMPT_COMMAND='__git_ps1 "\u@\h:\w" "\n $ "'
