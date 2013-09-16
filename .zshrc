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

# Functions
extract () {
    # A check for flags on compressed files.
    if [ -f $1 ] ; then
	case $1 in
	    *.tar.bz2)
		tar -xvjf $1
		;;
	    *.tar.gz)
		tar -xvzf $1
		;;
	    *.bz2)
		bunzip2 $1
		;;
	    *.rar)
		unrar x $1
		;;
	    *.gz)
		gunzip $1
		;;
	    *.tar)
		tar -xf $1
		;;
	    *.tbz2)
		tar -xvjf $1
		;;
	    *.tgz)
		tar -xvzf $1
		;;
	    *.zip)
		unzip $1
		;;
	    *.Z)
		uncompress $1
		;;
	    *)
		echo "$1 is not valid for extraction"
		;;
	esac
    else
	echo "$1 is not a valid file"
    fi
}

psgrep () {
    #Finds process numbers
    if [ ! -z $1 ] ; then
	echo "Grepping for processes matching $1..."
	ps aux | grep $1 | grep -v grep
    else
	echo "!! Need name to grep for"
    fi
}

dls () {
	# directory ls
	echo $(ls -l | grep "^d" | awk '{ print $9 }' | tr -d "/")
}

export EDITOR="emacs"

alias cleanup=~/killxdots/cleanup
alias rice=~/shell/rice
alias emacs=/usr/bin/emacs-24.3-no-x11
alias gitupper=~/gitupper/gitupper
