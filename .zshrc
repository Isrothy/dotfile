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
export EDITOR=nvim

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

# Check if the terminal likely supports OSC 133 (XT is a terminfo capability)
# and ensure Kitty's full integration (which is more comprehensive) isn't already active.
if (( ${+terminfo[XT]} )) && [[ -z "$KITTY_SHELL_INTEGRATION" ]]; then
  _zsh_nvim_term_osc_precmd() {
    print -Pn "\e]133;A\a"  # Mark: Start of prompt
  }
  _zsh_nvim_term_osc_preexec() {
    print -Pn "\e]133;C\a"  # Mark: Start of command output/execution
  }

  # More robust precmd that includes D (end of last command) then A (start of new prompt)
  _zsh_nvim_term_osc_precmd_fuller() {
    local ret=$?
    print -Pn "\e]133;D;${ret}\a" # Mark: End of last command output, with exit status
    print -Pn "\e]133;A\a"         # Mark: Start of prompt
  }

  autoload -Uz add-zsh-hook
  add-zsh-hook precmd _zsh_nvim_term_osc_precmd_fuller
  add-zsh-hook preexec _zsh_nvim_term_osc_preexec
fi

# open
alias preview="open -a preview"
alias typora="open -a typora"

# zoxide
eval "$(zoxide init zsh)"

# zle
autoload -Uz edit-command-line
zle -N edit-command-line

# api-keys
[ -f ~/.api-keys ] && source ~/.api-keys

