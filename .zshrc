alias yolo='claude --dangerously-skip-permissions'

# カレントディレクトリとGitブランチ表示 
autoload -Uz vcs_info
precmd() { vcs_info }
zstyle ':vcs_info:git:*' formats '%b'
setopt PROMPT_SUBST
PROMPT='%F{blue}%~%f %F{green}${vcs_info_msg_0_}%f%# '

export PATH=/home/mmatt/.npm-global/bin:$PATH