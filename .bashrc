# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# Add coreutils bin dir to path
if [ -d /usr/local/opt/coreutils/libexec ]; then
  export PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH"
  export MANPATH="/usr/local/opt/coreutils/libexec/gnuman:$MANPATH"
fi

# Use colors.
export CLICOLOR=1
export LSCOLORS=ExFxCxDxBxegedabagacad

# dircolors
if [ -e ~/.dircolors ]; then
  eval `dircolors -b ~/.dircolors`
fi


# Include alias file (if present) containing aliases for ssh, etc.
if [ -f ~/.bash_aliases ]
then
  source ~/.bash_aliases
fi

# Include bashrc file (if present).
if [ -f ~/.bashrc ]
then
  source ~/.bashrc
fi

# Syntax-highlight code for copying and pasting.
# Requires highlight (`brew install highlight`).
function pretty() {
  pbpaste | highlight --syntax=$1 -O rtf | pbcopy
}

# Lock and Load a custom theme file
# location /.bash_it/themes/
export BASH_IT_THEME='slick'

# Set this to false to turn off version control status checking within the prompt for all themes
export SCM_CHECK=true

# Tab complete sudo commands
complete -cf sudo

# Load Bash It
export BASH_IT="$HOME/.bash_it"

if [ -e $BASH_IT/bash_it.sh ]; then
  source $BASH_IT/bash_it.sh
fi

test -e "${HOME}/.iterm2_shell_integration.bash" && source "${HOME}/.iterm2_shell_integration.bash"

if [ -d /usr/local/opt/python/libexec/bin ]; then
  export PATH="/usr/local/opt/python/libexec/bin:$PATH"
fi

# Fix vim colors inside tmux
if [ -n $TMUX ]; then
  alias vim="TERM=screen-256color vim"
fi

# Set default editor to vim
export EDITOR=vim


# Tell homebrew to not autoupdate every single time I run it (just once a week).
export HOMEBREW_AUTO_UPDATE_SECS=604800

# Turn on Git autocomplete.
# brew_prefix=`brew --prefix`
brew_prefix='/usr/local'
if [ -f $brew_prefix/etc/bash_completion ]; then
  . $brew_prefix/etc/bash_completion
fi

# Turn on kubectl autocomplete.
if [ -x "$(command -v kubectl)" ]; then
  source <(kubectl completion bash)
fi

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
