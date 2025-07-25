source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
#source ~/.zsh/zsh-autocomplete/zsh-autocomplete.plugin.zsh     
source ~/.zsh/f-sy-h/F-Sy-H.plugin.zsh
#source ~/.zsh/zsh-z-master/zsh-z.plugin.zsh

export PS1='%B%F{#6aa121}%~: %b%f%k
$ '
setopt promptsubst
PS1=$'${(r:$COLUMNS::-:)}'$PS1
preexec() {
  echo ""
}



# Load version control information
autoload -Uz vcs_info
precmd() { vcs_info }

# Format the vcs_info_msg_0_ variable to show repo name and branch
zstyle ':vcs_info:git:*' formats ' %F{cyan}%r%f:%F{yellow}%b%f'
zstyle ':vcs_info:git:*' actionformats ' %F{cyan}%r%f:%F{yellow}%b%f|%F{red}%a%f'
RPROMPT=\$vcs_info_msg_0_

alias ls='ls --color'

#go back and forward word by word
bindkey "^[[1;3C" forward-word
bindkey "^[[1;3D" backward-word


#set LS colors and aut complete tab menu colors
#export LSCOLORS="exgxbxfxcxegedabagacad"
#zstyle ':completion:*:default' list-colors \
#  "di=1;34" "ln=36" "so=31" "pi=35" "ex=32" "bd=34;46"

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

setopt appendhistory
setopt share_history

typeset -A ZSH_HIGHLIGHT_STYLES
(( ${+ZSH_HIGHLIGHT_STYLES} )) || typeset -A ZSH_HIGHLIGHT_STYLES
ZSH_HIGHLIGHT_STYLES[path]=none
ZSH_HIGHLIGHT_STYLES[path_prefix]=none


export TERM="xterm-256color"


export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

autoload -Uz compinit
compinit

export GOPATH="$HOME/src/go/"

bindkey '^[[1;9C' forward-word
bindkey '^[[1;9D' backward-word
bindkey "^[[1;3C" forward-word
bindkey "^[[1;3D" backward-word

setopt share_history
unsetopt EXTENDED_HISTORY


export PATH=$PATH:~/src/go/bin
export GROOVY_HOME=/opt/homebrew/opt/groovy/libexec
export PATH="$HOME/.jenv/bin:$PATH"
eval "$(jenv init -)"
export PATH="/opt/homebrew/opt/openjdk/bin:$PATH"
export GOPRIVATE=gitlab.connectwisedev.com/*


#AWS Configuration
aws-login () {
    export AWS_ENV=$1
    SSO_ACCOUNT=$(aws sts get-caller-identity --query "Account" --profile $AWS_ENV)
    if [ ${#SSO_ACCOUNT} -eq 14 ];  then
        echo "session still valid" ;
    else
        echo "Seems like session is expired or hasn't been yet established. Trying to login."
        aws sso login --profile $AWS_ENV
    fi
    alias ssh='ssh ${AWS_ENV:+-o IdentityFile="~/.ssh/connectwise/$AWS_ENV.pem"}'
    alias scp='scp -i ~/.ssh/connectwise/$AWS_ENV.pem'
    alias aws="aws --profile $AWS_ENV"
}



#eval "$(starship init zsh)"

function set_win_title(){
    echo -ne "\033]0; $(basename "$PWD") \007"
}

#Generate a Random Name for the TMUX session
# Define arrays of adjectives and nouns


# Generate a random session name in the format adjective_noun
#generate_random_name() {
#    adjectives=("focused" "brave" "clever" "bold" "eager" "frosty" "happy" "jolly" "keen" "lively")
#    nouns=("tiger" "panda" "eagle" "lion" "whale" "otter" "falcon" "wolf" "fox" "bear")
#    local adjective=${adjectives[$((RANDOM % ${#adjectives[@]} + 1))]}
#    local noun=${nouns[$((RANDOM % ${#nouns[@]} + 1))]}

#    local sequence_number=$(tmux list-sessions 2>/dev/null | wc -l)
#    echo "${sequence_number}_${adjective}_${noun}"
#}

# Automatically start tmux with a random session name if not already in a tmux session
#if [[ -z "$TMUX" ]]; then
#    session_name=$(generate_random_name)
#    tmux new-session -s "$session_name"
#fi
#starship_precmd_user_func="set_win_title"
#set-window-option -g status-left " #S "
# tmux-window-name() {
# 	($TMUX_PLUGIN_MANAGER_PATH/tmux-window-name/scripts/rename_session_windows.py &)
# }
# add-zsh-hook chpwd tmux-window-name

