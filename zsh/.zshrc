### ZSH Home
export ZSH=$HOME/.zsh

### ------ History Config ------
export HISTFILE=$ZSH/.zsh_history

# History Size to load
export HISTSIZE=10000

# History Size to save
export SAVEHIST=10000

# Don't save duplicates into history
setopt HIST_IGNORE_ALL_DUPS

# Don't show duplicates in search
setopt HIST_FIND_NO_DUPS

### --- ZSH Plugins and Themes
source $ZSH/plugins/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh
source $ZSH/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
fpath=($ZSH/plugins/zsh-completions/src $fpath)

### ------ Color Config ------

local color00='#282828'
local color01='#3c3836'
local color02='#504945'
local color03='#665c54'
local color04='#bdae93'
local color05='#d5c4a1'
local color06='#ebdbb2'
local color07='#fbf1c7'
local color08='#fb4934'
local color09='#fe8019'
local color0A='#fabd2f'
local color0B='#b8bb26'
local color0C='#8ec07c'
local color0D='#83a598'
local color0E='#d3869b'
local color0F='#d65d0e'

### ------ PATH, EDITOR, ALIASES, SCRIPTS, KEYBINDS ------

export PATH=$HOME/bin:/opt/homebrew/bin:/usr/local/bin:$PATH
export EDITOR='nvim'
export VISUAL='nvim'
export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin
export PATH="/opt/homebrew/opt/llvm/bin:$PATH"
export LDFLAGS="-L/opt/homebrew/opt/llvm/lib"
export CPPFLAGS="-I/opt/homebrew/opt/llvm/include"
export PATH="/usr/local/opt/llvm/bin:$PATH"
export PATH="$PATH:/Users/adrianbrady/.local/bin"
export PATH=/usr/local/opt/llvm/bin:/opt/homebrew/opt/llvm/bin:/Users/adrianbrady/bin:/opt/homebrew/bin:/usr/local/bin:/Library/Frameworks/Python.framework/Versions/3.12/bin:/opt/local/bin:/opt/local/sbin:/Library/Frameworks/Python.framework/Versions/3.10/bin:/opt/homebrew/bin:/opt/homebrew/sbin:/usr/local/bin:/System/Cryptexes/App/usr/bin:/usr/bin:/bin:/usr/sbin:/sbin:/var/run/com.apple.security.cryptexd/codex.system/bootstrap/usr/local/bin:/var/run/com.apple.security.cryptexd/codex.system/bootstrap/usr/bin:/var/run/com.apple.security.cryptexd/codex.system/bootstrap/usr/appleinternal/bin:/Library/Apple/usr/bin:/Library/TeX/texbin:/usr/local/share/dotnet:~/.dotnet/tools:/usr/local/opt/llvm/bin:/opt/homebrew/opt/llvm/bin:/Users/adrianbrady/bin:/opt/homebrew/bin:/Library/Frameworks/Python.framework/Versions/3.12/bin:/opt/local/bin:/opt/local/sbin:/Library/Frameworks/Python.framework/Versions/3.10/bin:/opt/homebrew/sbin:/Users/adrianbrady/.cargo/bin:/Users/adrianbrady/.local/bin:/Users/adrianbrady/go/bin:/Users/adrianbrady/.local/bin:/Users/adrianbrady/go/bin:/Users/adrianbrady/.local/bin:/opt/cross/bin
export PATH=$PATH:/Users/adrianbrady/Scripts
export PATH=$PATH:/opt/homebrew/lib
export PATH=$PATH:/opt/homebrew/include
export PATH=$PATH:/usr/local/opt/include
export PATH=$PATH:/usr/local/opt/lib
source /Users/adrianbrady/Library/Application\ Support/org.dystroy.broot/launcher/bash/br

alias lg="lazygit"
alias gs="git status"
alias gd="git diff"
alias gds="git diff --staged"
alias gl="git log --graph --oneline"
alias glo="git log --oneline"
alias sd="~/.config/scripts/sd.sh"
alias ls="eza -a"
alias zource="source ~/.zshrc"
alias zshrc="nvim ~/dotfiles/zsh/.zshrc"
source ~/.config/zsh/.zsh-alias
source ~/.config/zsh/.zsh-keys

tmux_sessionizer() {
  ~/Scripts/tmux-sessionizer.sh
}
zle -N tmux_sessionizer

bindkey '^f' tmux_sessionizer
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward

### ------ FZF Config ------

# Set up fzf key bindings and fuzzy completion
source <(fzf --zsh)

export FZF_DEFAULT_OPTS="$FZF_DEFAULT_OPTS"\
" --color=bg+:$color01,bg:$color00,spinner:$color0C,hl:$color0D"\
" --color=fg:$color04,header:$color0D,info:$color0A,pointer:$color0C"\
" --color=marker:$color0C,fg+:$color06,prompt:$color0A,hl+:$color0D"

# CTRL-/ to toggle small preview window to see the full command
# CTRL-Y to copy the command into clipboard using pbcopy
export FZF_CTRL_R_OPTS="
  --preview 'echo {}' --preview-window up:3:hidden:wrap
  --bind 'ctrl-/:toggle-preview'
  --bind 'ctrl-y:execute-silent(echo -n {2..} | pbcopy)+abort'
  --color header:italic
  --header 'Press CTRL-Y to copy command into clipboard'"

### ------ TMUX on start ------
if [ "$TMUX" = "" ]; then
    if ! tmux has-session -t "Home" 2> /dev/null; then
        tmux new-session -s "Home" -c "Home" -d
    fi

    tmux at -t "Home"
fi


### ------ ZSTYLE Settings ------

# disable sort when completing `git checkout`
zstyle ':completion:*:git-checkout:*' sort false
# set descriptions format to enable group support
# NOTE: don't use escape sequences here, fzf-tab will ignore them
zstyle ':completion:*:descriptions' format '[%d]'
# set list-colors to enable filename colorizing
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
# force zsh not to show completion menu, which allows fzf-tab to capture the unambiguous prefix
zstyle ':completion:*' menu no
# preview directory's content with eza when completing cd

### ------ Inits ------
eval "$(zoxide init zsh)"
eval "$(starship init zsh)"

### ------ SDK Man Init ------
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"
export OPENSSL_ROOT_DIR=/opt/homebrew/opt/openssl@3
