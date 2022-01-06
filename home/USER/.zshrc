# Environment variables - start

# export PATH=$HOME/bin:/usr/local/bin:$HOME/.asdf/installs/nodejs/14.17.1/.npm/bin:$PATH
export PATH=$HOME/bin:/usr/local/bin:$PATH
export GOPATH=$HOME/.asdf/shims/go
export HELM_EXPERIMENTAL_OCI=1
export UPDATE_ZSH_DAYS=1
export ZSH="/home/geverton/.oh-my-zsh"

# Environment variables - end

# ZSH variables - start

CASE_SENSITIVE="false"
COMPLETION_WAITING_DOTS="true"
DISABLE_AUTO_TITLE="false"
DISABLE_AUTO_UPDATE="false"
DISABLE_LS_COLORS="false"
DISABLE_MAGIC_FUNCTIONS="false"
DISABLE_UNTRACKED_FILES_DIRTY="false"
DISABLE_UPDATE_PROMPT="true"
ENABLE_CORRECTION="true"
HIST_STAMPS="mm/dd/yyyy"
HYPHEN_INSENSITIVE="true"
ZSH_CUSTOM=$ZSH/custom
ZSH_THEME="miloshadzic"
ZSH_THEME_RANDOM_CANDIDATES=(
  agnoster
  amuse
  arrow
  awesomepanda
  cloud
  daveverwer
  dieter
  edvardm
  emotty
  fwalch
  geoffgarside
  garyblessington
  gianu
  gozilla
  half-life
  jaischeema
  jbergantine
  kennethreitz
  kolo
  mgutz
  mikeh
  miloshadzic
  mrtazz
  nebirhos
  norm
  obraun
  refined
  robbyrussell
  sammy
  smt
  sonicradish
  sorin
  sporty_256
  takashiyoshida
  theunraveler
  tjkirch
  wedisagree
  wuffers
  zhann
)

# ZSH variables - end

# Plugins - start

plugins=(
  asdf
  docker
  docker-compose
  git
  helm
  kubectl
  minikube
  node
  npm
  vagrant
  yarn
  zsh-autosuggestions
)

# Plugins - end

# Source ZSH
source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

. $HOME/.asdf/asdf.sh

###-begin-npm-completion-###
#
# npm command completion script
#
# Installation: npm completion >> ~/.bashrc (or ~/.zshrc)
# Or, maybe: npm completion > /usr/local/etc/bash_completion.d/npm

if type complete &>/dev/null; then
  _npm_completion () {
    local words cword
    if type _get_comp_words_by_ref &>/dev/null; then
      _get_comp_words_by_ref -n = -n @ -n : -w words -i cword
    else
      cword="$COMP_CWORD"
      words=("${COMP_WORDS[@]}")
    fi

    local si="$IFS"
    IFS=$'\n' COMPREPLY=($(COMP_CWORD="$cword" \
                           COMP_LINE="$COMP_LINE" \
                           COMP_POINT="$COMP_POINT" \
                           npm completion -- "${words[@]}" \
                           2>/dev/null)) || return $?
    IFS="$si"
    if type __ltrim_colon_completions &>/dev/null; then
      __ltrim_colon_completions "${words[cword]}"
    fi
  }
  complete -o default -F _npm_completion npm
elif type compdef &>/dev/null; then
  _npm_completion() {
    local si=$IFS
    compadd -- $(COMP_CWORD=$((CURRENT-1)) \
                 COMP_LINE=$BUFFER \
                 COMP_POINT=0 \
                 npm completion -- "${words[@]}" \
                 2>/dev/null)
    IFS=$si
  }
  compdef _npm_completion npm
elif type compctl &>/dev/null; then
  _npm_completion () {
    local cword line point words si
    read -Ac words
    read -cn cword
    let cword-=1
    read -l line
    read -ln point
    si="$IFS"
    IFS=$'\n' reply=($(COMP_CWORD="$cword" \
                       COMP_LINE="$line" \
                       COMP_POINT="$point" \
                       npm completion -- "${words[@]}" \
                       2>/dev/null)) || return $?
    IFS="$si"
  }
  compctl -K _npm_completion npm
fi

###-end-npm-completion-###
