############################################
#  Joe's killX .zshrc
############################################


# Set up the prompt

autoload -Uz promptinit
promptinit
prompt adam2

#source plugins
source ~/.antigen/antigen.zsh

#antigen launches
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle git

#setopts
setopt histignorealldups sharehistory

# Use emacs keybindings even if our EDITOR is set to vi
bindkey -e

# Keep 1000 lines of history within the shell and save it to ~/.zsh_history:
HISTSIZE=1000
SAVEHIST=1000
HISTFILE=~/.zsh_history

# Use modern completion system
autoload -Uz compinit
compinit

export EDITOR="emacs"

alias cleanup=~/shell/cleanup
alias rice=~/shell/rice
alias emacs=/usr/bin/emacs-24.3-no-x11
