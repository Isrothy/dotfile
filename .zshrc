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


plugins=(
  aliases
  brew
  colored-man-pages
  colorize
  fast-syntax-highlighting
  macos
  sudo
  zsh-autosuggestions
  zsh-vi-mode
)

FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"
rm -f ~/.zcompdump; compinit
chmod -R go-w "$(brew --prefix)/share"


ZSH_COLORIZE_TOOL=chroma
ENABLE_CORRECTION=true

source $ZSH/oh-my-zsh.sh

# source /opt/homebrew/share/zsh-autocomplete/zsh-autocomplete.plugin.zsh
# bindkey '\t' menu-complete "$terminfo[kcbt]" reverse-menu-complete
# zstyle ':autocomplete:*' add-space \
    # executables aliases functions builtins reserved-words commands

source /opt/homebrew/opt/powerlevel10k/powerlevel10k.zsh-theme
# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

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

alias icat="kitty +kitten icat"

export PATH="/opt/homebrew/bin:$PATH"
export PATH="/opt/homebrew/opt/openjdk/bin:$PATH"
export PATH="/opt/homebrew/opt/zip/bin:$PATH"
export PATH="/opt/homebrew/opt/llvm/bin:$PATH"
export PATH="/Users/jiangjoshua/.rustup/toolchains/stable-aarch64-apple-darwin/bin:$PATH"
export PATH="/opt/homebrew/opt/node@16/bin:$PATH"

export PATH=$PATH:$HOME/.local/bin


# export JAVA_HOME=/opt/homebrew/Cellar/openjdk@17/17.0.7/libexec/openjdk.jdk/Contents/Home
export JAVA_HOME=$(/usr/libexec/java_home)
export LDFLAGS="-L/opt/homebrew/opt/llvm/lib"
export CPPFLAGS="-I/opt/homebrew/opt/llvm/include"
export SDKROOT=$(xcrun --sdk macosx --show-sdk-path)
export MYVIMRC="/Users/jiangjoshua/.config/nvim/init.lua"


[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# if type rg &> /dev/null; then
#   export FZF_DEFAULT_COMMAND='rg --files'
#   export FZF_DEFAULT_OPTS='-m'
# fi
export FZF_DEFAULT_COMMAND="fd --type file --color=always"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_DEFAULT_OPTS="--ansi"

alias config='/usr/bin/git --git-dir=/Users/jiangjoshua/.cfg/ --work-tree=/Users/jiangjoshua'

eval "$(zoxide init zsh --cmd cd)"

[ -f "/Users/jiangjoshua/.ghcup/env" ] && source "/Users/jiangjoshua/.ghcup/env" # ghcup-env
