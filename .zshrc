source $(brew --prefix)/share/antigen/antigen.zsh

antigen use oh-my-zsh

antigen bundle aliases
antigen bundle brew
antigen bundle cabal
antigen bundle colored-man-pages
antigen bundle colorize
antigen bundle command-not-found
antigen bundle copybuffer
antigen bundle copyfile
antigen bundle copypath
antigen bundle dirhistory
antigen bundle fd
antigen bundle fzf
antigen bundle git
antigen bundle gitignore
antigen bundle history-substring-search
antigen bundle jsontools
antigen bundle macos
antigen bundle ripgrep
antigen bundle stack
antigen bundle sudo
antigen bundle web-search
antigen bundle zoxide

antigen bundle hlissner/zsh-autopair
antigen bundle Aloxaf/fzf-tab
antigen bundle zsh-users/zsh-completions
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle zsh-users/zsh-autosuggestions
antigen bundle jeffreytse/zsh-vi-mode

antigen apply

ZSH_COLORIZE_TOOL=chroma
ENABLE_CORRECTION=true

eval "$(oh-my-posh init zsh --config ~/.config/oh-my-posh/zen.toml)"

export PATH="$(brew --prefix)/bin:$PATH"
export PATH="$(brew --prefix)/opt/curl/bin:$PATH"
export PATH="$(brew --prefix)/opt/llvm/bin:$PATH"
export PATH="$(brew --prefix)/opt/openjdk/bin:$PATH"
export PATH="$(brew --prefix)/opt/postgresql@16/bin:$PATH"
export PATH="$(brew --prefix)/opt/ruby/bin:$PATH"
export PATH="$(brew --prefix)/opt/tcl-tk@8/bin:$PATH"
export PATH="$(brew --prefix)/opt/zip/bin:$PATH"
export PATH="$(brew --prefix)/anaconda3/bin":$PATH
export PATH="$HOME/.rustup/toolchains/nightly-aarch64-apple-darwin/bin:$PATH"
export PATH="$HOME/.local/bin":$PATH
export PATH="/Applications/Docker.app/Contents/Resources/bin":$PATH
export PATH="/Applications/Docker.app/Contents/Resources/cli-plugins/":$PATH


export DYLD_LIBRARY_PATH="$(brew --prefix)/lib:$DYLD_LIBRARY_PATH"
export SSL_CERT_FILE="$(brew --prefix)/etc/openssl@3/cert.pem"
export CURL_CA_BUNDLE="$(brew --prefix)/etc/openssl@3/cert.pem"
export NODE_EXTRA_CA_CERTS="$(brew --prefix)/etc/openssl@3/cert.pem"
export JAVA_HOME=$(/usr/libexec/java_home)
export SDKROOT=$(xcrun --sdk macosx --show-sdk-path)
export MYVIMRC=$HOME"/.config/nvim/init.lua"
export MANPAGER='nvim +Man!'
export MANWIDTH=80

# history-substring-search
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down
bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down

# git baredot
alias config="/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME"

# pyenv
export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init - zsh)"

# fzf
export FZF_DEFAULT_COMMAND="fd --type file --color=always"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_DEFAULT_OPTS="--ansi  --color bg+:#D8DEE9"

# macchina
alias neofetch='macchina'

# lsd
alias ls='lsd'
alias l='lsd'
alias ll='l -l'
alias la='ls -a'
alias lla='ls -la'
alias lt='ls --tree'

# pip
alias pipupall="pip3 list -o | cut -f1 -d' ' | tr ' ' '\n' | awk '{if(NR>=3)print}' | cut -d' ' -f1 | xargs -n1 pip3 install -U"

# kitty
alias icat="kitty +kitten icat"
alias d="kitten diff"

# open
alias preview="open -a preview"
alias typora="open -a typora"

# zoxide
eval "$(zoxide init zsh)"

# zle
autoload -Uz edit-command-line
zle -N edit-command-line

# kitty-scrollback
function kitty_scrollback_edit_command_line() {
  local VISUAL=$HOME'/.local/share/nvim/lazy/kitty-scrollback.nvim/scripts/edit_command_line.sh'
  zle edit-command-line
  zle kill-whole-line
}
zle -N kitty_scrollback_edit_command_line

bindkey '^x^e' kitty_scrollback_edit_command_line

# api-keys
[ -f ~/.api-keys ] && source ~/.api-keys


# The following lines have been added by Docker Desktop to enable Docker CLI completions.
fpath=(/Users/jiangjoshua/.docker/completions $fpath)
autoload -Uz compinit
compinit
# End of Docker CLI completions
