# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# -------------------------------------------------------
# Oh My Zsh
# -------------------------------------------------------
export ZSH="$HOME/.oh-my-zsh"

# Theme (Powerlevel10k)
ZSH_THEME="powerlevel10k/powerlevel10k"

# Load Oh My Zsh
source "$ZSH/oh-my-zsh.sh"

# -------------------------------------------------------
# Plugins
# -------------------------------------------------------
plugins=(
  git
  z
  zsh-autosuggestions
  zsh-syntax-highlighting
)

# -------------------------------------------------------
# Powerlevel10k Setup
# -------------------------------------------------------
[[ ! -f ~/.p10k.zsh ]] && p10k configure         # auto-run wizard
[[ -f ~/.p10k.zsh ]] && source ~/.p10k.zsh       # load config

# -------------------------------------------------------
# Environment
# -------------------------------------------------------
export EDITOR="vim"
export VISUAL="$EDITOR"

export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/bin:$PATH"

# -------------------------------------------------------
# History Settings
# -------------------------------------------------------
setopt APPEND_HISTORY
setopt INC_APPEND_HISTORY

export HISTSIZE=100000
export HISTFILESIZE=200000

# -------------------------------------------------------
# Tmux Setup
# -------------------------------------------------------
export TMUX_CONF_LOCAL="$HOME/.tmux.conf.local"


# -------------------------------------------------------
# Aliases
# -------------------------------------------------------

autossh() {
  while true; do
    ssh -t "$@" || true
    echo "Disconnected from $@. Reconnecting in 5s..."
    sleep 5
  done
}

tmux-send-all() {
  if [ $# -eq 0 ]; then
    echo "Usage: tmux-send-all <command>"
    return 1
  fi

  local cmd="$*"

  for p in $(tmux list-panes -a -F '#{session_name}:#{window_index}.#{pane_index}'); do
    tmux send-keys -t "$p" "$cmd" C-m
  done
}

alias tmux-source-all="tmux-send-all \"source ~/.zshrc\""
