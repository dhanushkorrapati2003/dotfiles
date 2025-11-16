# Dotfiles Setup

A minimal and portable Zsh environment using:

- Oh My Zsh
- Powerlevel10k
- zsh-autosuggestions
- zsh-syntax-highlighting
- z

## 🚀 Installation

Clone the repo:

```bash
git clone https://github.com/dhanushkorrapati2003/dotfiles.git ~/dotfiles
cd ~/dotfiles
```

Run the instalation script:

```bash
chmod +x bootstrap.sh
./install.sh
```
 
Open a new zsh terminal — the Powerlevel10k setup wizard will start automatically.

## Other configs

Tmux and wezterm configs are included which can be used as drop in replacements.

Note: For the tmux config, copy the tmux variable from the ~/.zshrc if you are not picking the whole config. 


Note: In modern terminal emulators like Wezterm, you'll have to create a zprofile as they by default spin up login shell, or you can just set default_prog in the wezterm lua config.  
