source /opt/homebrew/share/antigen/antigen.zsh

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
antigen bundle zsh-users/zsh-completions
antigen bundle zdharma-continuum/fast-syntax-highlighting
antigen bundle Aloxaf/fzf-tab
antigen bundle zsh-users/zsh-autosuggestions
antigen bundle jeffreytse/zsh-vi-mode

antigen apply

ZSH_COLORIZE_TOOL=chroma
ENABLE_CORRECTION=true

eval "$(oh-my-posh init zsh --config ~/.config/oh-my-posh/zen.toml)"

export PATH="/opt/homebrew/bin:$PATH"
export PATH="/opt/homebrew/opt/openjdk/bin:$PATH"
export PATH="/opt/homebrew/opt/zip/bin:$PATH"
export PATH="/opt/homebrew/opt/llvm/bin:$PATH"
export PATH="/opt/homebrew/opt/curl/bin:$PATH"
export PATH="/Users/jiangjoshua/.rustup/toolchains/stable-aarch64-apple-darwin/bin:$PATH"
export PATH="/Users/jiangjoshua/.vscode/extensions/mgt19937.typst-preview-0.11.7-darwin-arm64/out:$PATH"
export PATH=$PATH:$HOME/.local/bin

export DYLD_LIBRARY_PATH="/opt/homebrew/lib"

export CURL_CA_BUNDLE="$(brew --prefix)/etc/openssl@3/cert.pem"
export SSL_CERT_FILE="$(brew --prefix)/etc/openssl/cert.pem"
export JAVA_HOME=/opt/homebrew/Cellar/openjdk@17/17.0.7/libexec/openjdk.jdk/Contents/Home
export JAVA_HOME=$(/usr/libexec/java_home)
export SDKROOT=$(xcrun --sdk macosx --show-sdk-path)
export MYVIMRC="/Users/jiangjoshua/.config/nvim/init.lua"
export LDFLAGS="-L/opt/homebrew/opt/llvm/lib"
export CPPFLAGS="-I/opt/homebrew/opt/llvm/include"


bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down
bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down


export FZF_DEFAULT_COMMAND="fd --type file --color=always"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_DEFAULT_OPTS="--ansi"

alias config="/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME"

alias python="/opt/homebrew/bin/python3.12"
alias python3="/opt/homebrew/bin/python3.12"
alias pip="/opt/homebrew/bin/pip3.12"
alias pip3="/opt/homebrew/bin/pip3.12"

alias ls='lsd'
alias l='lsd'
alias ll='l -l'
alias la='ls -a'
alias lla='ls -la'
alias lt='ls --tree'

alias pipupall="pip3 list -o | cut -f1 -d' ' | tr ' ' '\n' | awk '{if(NR>=3)print}' | cut -d' ' -f1 | xargs -n1 pip3 install -U"

alias icat="kitty +kitten icat"
alias d="kitten diff"

alias preview="open -a preview"
alias typora="open -a typora"

eval "$(zoxide init zsh)"
