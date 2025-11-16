#!/usr/bin/env bash
set -e

echo ""
echo "==========================="
echo "  Bootstrapping Zsh Setup  "
echo "==========================="
echo ""

# ------------------------------
# Install Zsh (if missing)
# ------------------------------
if ! command -v zsh >/dev/null 2>&1; then
  echo "Installing Zsh..."
  if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    sudo apt update && sudo apt install -y zsh
  elif [[ "$OSTYPE" == "darwin"* ]]; then
    brew install zsh
  fi
fi

# ------------------------------
# Install Oh My Zsh
# ------------------------------
if [ ! -d "$HOME/.oh-my-zsh" ]; then
  echo "Installing Oh My Zsh..."
  RUNZSH=no CHSH=no sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
else
  echo "Oh My Zsh already installed."
fi

# ------------------------------
# Install Powerlevel10k
# ------------------------------
THEMES_DIR="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes"
if [ ! -d "$THEMES_DIR/powerlevel10k" ]; then
  echo "Installing Powerlevel10k..."
  git clone https://github.com/romkatv/powerlevel10k.git "$THEMES_DIR/powerlevel10k"
else
  echo "Powerlevel10k already installed."
fi

# ------------------------------
# Install Plugins
# ------------------------------
PLUGINS_DIR="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins"

install_plugin() {
  local repo="$1"
  local dir="$2"
  if [ ! -d "$PLUGINS_DIR/$dir" ]; then
    echo "Installing plugin: $dir"
    git clone "$repo" "$PLUGINS_DIR/$dir"
  else
    echo "Plugin '$dir' already installed."
  fi
}

install_plugin "https://github.com/zsh-users/zsh-autosuggestions" "zsh-autosuggestions"
install_plugin "https://github.com/zsh-users/zsh-syntax-highlighting" "zsh-syntax-highlighting"
install_plugin "https://github.com/agkozak/zsh-z" "zsh-z"

# ------------------------------
# Install fzf
# ------------------------------
if [ ! -d "$HOME/.fzf" ]; then
  echo "Installing fzf..."
  git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
  ~/.fzf/install --all
else
  echo "fzf already installed."
fi

# ------------------------------
# Finishing up
# ------------------------------
echo ""
echo "Bootstrap complete!"
echo "Open a new terminal or run:  source ~/.zshrc"
echo "If this is a fresh machine, the p10k wizard will launch automatically."
echo ""

