typeset -g POWERLEVEL9K_INSTANT_PROMPT=quiet
# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi


export ZSH="$HOME/.oh-my-zsh"

zstyle ':omz:update' frequency 7
zstyle ':omz:update' mode auto

ZVM_INIT_MODE=sourcing

plugins=(
  aliases
  brew
  cabal
  colored-man-pages
  colorize
  command-not-found
  copybuffer
  copyfile
  copypath
  dirhistory
  fast-syntax-highlighting
  fd
  fzf
  fzf-tab
  git
  gitignore
  history-substring-search
  jsontools
  macos
  ripgrep
  rust
  stack
  sudo
  web-search
  zsh-autosuggestions
  zsh-vi-mode
  zoxide
)

FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"
chmod -R go-w "$(brew --prefix)/share"


ZSH_COLORIZE_TOOL=chroma
ENABLE_CORRECTION=true

source $ZSH/oh-my-zsh.sh
source /opt/homebrew/share/zsh-autopair/autopair.zsh
source /opt/homebrew/opt/powerlevel10k/powerlevel10k.zsh-theme
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh



export PATH="/opt/homebrew/bin:$PATH"
export PATH="/opt/homebrew/opt/openjdk/bin:$PATH"
export PATH="/opt/homebrew/opt/zip/bin:$PATH"
# export PATH="/opt/homebrew/opt/llvm/bin:$PATH"
export PATH="/Users/jiangjoshua/.rustup/toolchains/stable-aarch64-apple-darwin/bin:$PATH"
export PATH="/opt/homebrew/opt/node@16/bin:$PATH"
export PATH=$PATH:$HOME/.local/bin


export JAVA_HOME=/opt/homebrew/Cellar/openjdk@17/17.0.7/libexec/openjdk.jdk/Contents/Home
export JAVA_HOME=$(/usr/libexec/java_home)
# export LDFLAGS="-L/opt/homebrew/opt/llvm/lib"
# export CPPFLAGS="-I/opt/homebrew/opt/llvm/include"
export SDKROOT=$(xcrun --sdk macosx --show-sdk-path)
export MYVIMRC="/Users/jiangjoshua/.config/nvim/init.lua"

bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down
bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down


# [ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# if type rg &> /dev/null; then
#   export FZF_DEFAULT_COMMAND='rg --files'
#   export FZF_DEFAULT_OPTS='-m'
# fi
export FZF_DEFAULT_COMMAND="fd --type file --color=always"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_DEFAULT_OPTS="--ansi"

alias config='/usr/bin/git --git-dir=/Users/jiangjoshua/.cfg/ --work-tree=/Users/jiangjoshua'


#[ -f "/Users/jiangjoshua/.ghcup/env" ] && source "/Users/jiangjoshua/.ghcup/env" # ghcup-env

# opam configuration
[[ ! -r /Users/jiangjoshua/.opam/opam-init/init.zsh ]] || source /Users/jiangjoshua/.opam/opam-init/init.zsh  > /dev/null 2> /dev/null


alias python="/opt/homebrew/bin/python3.11"
alias python3="/opt/homebrew/bin/python3.11"
alias pip="/opt/homebrew/bin/pip3.11"
alias pip3="/opt/homebrew/bin/pip3.11"

alias ls='lsd'
alias l='ls -l'
alias la='ls -a'
alias lla='ls -la'
alias lt='ls --tree'

alias vim='nvim'
alias vi='nvim'

alias pipupall="pip3 list -o | cut -f1 -d' ' | tr ' ' '\n' | awk '{if(NR>=3)print}' | cut -d' ' -f1 | xargs -n1 pip3 install -U"

alias icat="kitty +kitten icat"

alias preview="open -a preview"

[ -f "/Users/jiangjoshua/.ghcup/env" ] && source "/Users/jiangjoshua/.ghcup/env" # ghcup-env