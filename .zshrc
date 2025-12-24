if [[ -d /opt/homebrew ]]; then
    export HOMEBREW_PREFIX="/opt/homebrew"
else
    export HOMEBREW_PREFIX="/usr/local"
fi

typeset -U path PATH
path=(
    "$HOMEBREW_PREFIX/bin"
    "$HOMEBREW_PREFIX/sbin"
    "$HOMEBREW_PREFIX/opt/curl/bin"
    "$HOMEBREW_PREFIX/opt/llvm/bin"
    "$HOMEBREW_PREFIX/opt/openjdk/bin"
    "$HOMEBREW_PREFIX/opt/postgresql@16/bin"
    "$HOMEBREW_PREFIX/opt/ruby/bin"
    "$HOMEBREW_PREFIX/opt/tcl-tk@8/bin"
    "$HOMEBREW_PREFIX/opt/zip/bin"
    "$HOME/.rustup/toolchains/nightly-aarch64-apple-darwin/bin"
    "$HOME/.local/bin"
    "/Applications/Docker.app/Contents/Resources/bin"
    "/Applications/Docker.app/Contents/Resources/cli-plugins/"
    "$HOME/.lmstudio/bin"
    "$path[@]"
)
export PATH

export JAVA_HOME=$(/usr/libexec/java_home)
export MYVIMRC="$HOME/.config/nvim/init.lua"
export EDITOR="nvim"
export MANPAGER="nvim +Man!"
export MANWIDTH=80

export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"

source "$HOMEBREW_PREFIX/share/antigen/antigen.zsh"

antigen bundle zsh-users/zsh-completions
antigen bundle zsh-users/zsh-autosuggestions
antigen bundle colored-man-pages
antigen bundle jeffreytse/zsh-vi-mode
antigen bundle Aloxaf/fzf-tab
antigen bundle hlissner/zsh-autopair
antigen bundle zsh-users/zsh-history-substring-search
antigen bundle zsh-users/zsh-syntax-highlighting

antigen apply

alias ls='eza --icons'
alias la='eza -a --icons'
alias ll='eza -l --icons --git -a'
alias lt='eza --tree'
alias neofetch='macchina'
alias config="/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME"

alias preview="open -a preview"
alias typora="open -a typora"

alias vq='nvim +":lua require(\"isrothy.utils.session\").load_current()"'
alias vs='nvim -c "autocmd User VeryLazy lua require(\"isrothy.utils.session\").select()"'
alias vo='nvim +":lua Snacks.picker.recent()"'
alias vo='nvim +":lua Snacks.picker.recent()"'
alias vc='nvim +":lua Snacks.picker.files({ cwd = vim.fn.stdpath(\"config\") })"'
alias vf='nvim +":lua Snacks.picker.files()"'
alias vg='nvim +":lua Snacks.picker.grep()"'
alias vl='nvim -c "autocmd User VeryLazy Lazy"'

eval "$(starship init zsh)"
eval "$(pyenv init - zsh)"
eval "$(zoxide init zsh)"

export FZF_DEFAULT_COMMAND="fd --type file --color=always"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
# export FZF_DEFAULT_OPTS="--ansi --color bg+:#D8DEE9"
export FZF_DEFAULT_OPTS="
  --ansi
  --height 80%
  --layout reverse
  --border rounded
  --info inline

  # Nord Color Scheme
  --color=bg+:#3B4252,bg:#2E3440,spinner:#81A1C1,hl:#616E88
  --color=fg:#D8DEE9,header:#616E88,info:#81A1C1,pointer:#81A1C1
  --color=marker:#81A1C1,fg+:#ECEFF4,prompt:#81A1C1,hl+:#81A1C1
"
bindkey -v
stty -ixon


autoload -Uz edit-command-line
zle -N edit-command-line
bindkey -M vicmd 'v' edit-command-line

bindkey '^l' autosuggest-accept

ZSH_AUTOSUGGEST_STRATEGY=(history completion)
ZSH_AUTOSUGGEST_USE_ASYNC=1

bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down
bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down


zstyle ':completion:*' menu select

fpath+=~/.zfunc
[ -f "$HOME/.ghcup/env" ] && source "$HOME/.ghcup/env"
[ -f "$HOME/.api-keys" ] && source "$HOME/.api-keys"

if [[ -d "$HOME/Library/Application Support/pipx" ]]; then
    PDD_COMP="$HOME/Library/Application Support/pipx/venvs/pdd-cli/lib/python3.13/site-packages/pdd/pdd_completion.zsh"
    [ -f "$PDD_COMP" ] && source "$PDD_COMP"
fi
[ -f "$HOME/.pdd/api-env.zsh" ] && source "$HOME/.pdd/api-env.zsh"
