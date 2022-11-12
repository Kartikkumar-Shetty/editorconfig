autoload -Uz promptinit
promptinit
#prompt adam1


setopt histignorealldups sharehistory

# Use emacs keybindings even if our EDITOR is set to vi
bindkey -e

# Keep 1000 lines of history within the shell and save it to ~/.zsh_history:
HISTSIZE=1000
SAVEHIST=1000
HISTFILE=~/.zsh_history

# Use modern completion system
#autoload -Uz compinit
#compinit

zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _expand _complete _correct _approximate
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' menu select=2
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'
zstyle ':completion:*' menu select=long
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' use-compctl false
zstyle ':completion:*' verbose true
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'
zstyle ':completion:*' menu select
export TERM="xterm-256color"


export CLICOLOR=1

export PS1='%B%F{#6aa121}%~: %b%f%k
$ '
setopt promptsubst

if sysctl -n sysctl.proc_translated | grep -q '1'; then
	PS1=$'${(r:$COLUMNS::.:)}'$PS1
	alias brew='arch --x86_64 /usr/local/Homebrew/bin/brew'
	echo "Rosetta Enabled"
else
	PS1=$'${(r:$COLUMNS::-:)}'$PS1
        alias ibrew='arch --x86_64 /usr/local/Homebrew/bin/brew'
fi

#show git info
# Load version control information
autoload -Uz vcs_info
precmd() { vcs_info }
# Format the vcs_info_msg_0_ variable
zstyle ':vcs_info:git:*' formats ' %b'
RPROMPT=\$vcs_info_msg_0_

alias ls='ls --color'

#Syntax Highlighting and Autocomplete
source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh

#go back and forward word by word
bindkey "^[[1;3C" forward-word
bindkey "^[[1;3D" backward-word

#set LS colors and aut complete tab menu colors
export LSCOLORS="exgxbxfxcxegedabagacad"
zstyle ':completion:*:default' list-colors \
  "di=1;34" "ln=36" "so=31" "pi=35" "ex=32" "bd=34;46"
autoload -Uz compinit
compinit


