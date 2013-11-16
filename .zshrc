############################################
#  Joe's killX .zshrc
############################################


# Set up the prompt

autoload -Uz promptinit
promptinit
prompt adam2

#source plugins by path
source ~/.antigen/antigen.zsh

#antigen launches
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle git
antigen bundle command-not-found

#setopts
setopt histignorealldups sharehistory
setopt nobeep
setopt hist_ignore_dups
setopt hist_ignore_all_dups

# Use emacs keybindings even if our EDITOR is set to vi
bindkey -e
  # Modified Keybinds:
bindkey "^B" backward-word
bindkey "^F" forward-word

# Zstyles
  # Fuzzy Completion based on length
zstyle ':completion:*' completer _complete _match _approximate
zstyle ':completion:*:match:*' original only
zstyle ':completion:*:approximate:*' max-errors 1 numeric
zstyle -e ':completion:*:approximate:*' \
    max-errors 'reply=($((($#PREFIX+$#SUFFIX)/3))numeric)'
  # Keep History Clean
zstyle ':completion:*:history-words' stop-yes
zstyle ':completion:*:history-words' remove-all-dups yes
zstyle ':completion:*:history-words' list false
zstyle ':completion:*:history-words' menu yes
  # Ignore completions for commands I don't have
zstyle ':completion:*:functions' ignored-patterns '_*'
  # Cute completions
zstyle ':completion:*' format '___%d___'
zstyle ':completion:*:warnings' \
    format 'I can count to potato!!!'

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

killit() {
    #Kills process that match a regexp in the argv
    ps aux | grep -v "grep" | grep "$@" | awk '{print $2}' | xargs sudo kill
}

# crun -- compile and run .c program
crun() {
  local cprog=$1; shift
  local n=$@[(i)--]
  gcc -o ${cprog%.*} $cprog $@[1,n-1] && ./${cprog%.*} $@[n+1,-1]
}

clean_empty() {
    rm -i (.L0) *.bak(.)
}

widthcheck() {
    echo ${(l:79::-:)}
}

locate() {
    find / -name "$1" 2>/dev/null
}

internetquery() {
    ping -q -w 1 -c 1 $(ip r | grep default | cut -d ' ' -f 3) \
	       > /dev/null && echo "Internet up" || echo "No Internet"
}

export EDITOR="emacs"

# aliases often for scripts...nobody else uses this system
alias cleanup="~/killxdots/cleanup"
alias emacs="/usr/bin/emacs-24.3-no-x11"
alias gitupper="~/gitupper/gitupper"
alias tmacs="~/killxdots/tmacs"
alias kxt="~/killxdots/kxt"
alias ccolor="~/consolecolor/ccolors"
alias gcm="git commit -m"
alias ga="git add"
alias gpom="git push origin master"

# Finalize
antigen apply
