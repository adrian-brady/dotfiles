# vim: ft=zsh

export THEME=tokyonight_storm
PATH=$PATH:/Applications/Xcode.app/Contents/Developer/usr/bin

### ZSH Home
export ZSH=$HOME/.zsh

### ------ History Config ------
export HISTFILE=$ZSH/.zsh_history
# export TERM=xterm-256color
export HISTSIZE=10000
export SAVEHIST=10000
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_FIND_NO_DUPS

### --- ZSH Plugins and Themes
fpath=($ZSH/plugins/zsh-completions/src $fpath)

# Initialize the ZSH completion system
# IMPORTANT: This should come after fpath modifications and before sourcing plugins/configs that rely on completion.
# Check if compinit needs to be run (avoids slowdowns)
if ! type compinit >/dev/null 2>&1; then
  autoload -U compinit
fi
compinit -i -d "$ZSH/.zcompdump-$ZSH_VERSION" # -i: insecure dirs, -d: specify dump file

# Source other plugins AFTER compinit if they interact with completion or zle
source $ZSH/plugins/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh
source $ZSH/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

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
export PATH=$PATH:$GOPATH/bin
export PATH="$PATH:/Users/adrianbrady/.local/bin" # Duplicated? Check if needed twice
export PATH=$PATH:/Users/adrianbrady/bin # Already added via $HOME/bin?
export PATH=$PATH:/Library/Frameworks/Python.framework/Versions/3.12/bin
export PATH=$PATH:/opt/local/bin:/opt/local/sbin
export PATH=$PATH:/Library/Frameworks/Python.framework/Versions/3.10/bin # Check if needed alongside 3.12
# Homebrew paths are likely covered by /opt/homebrew/bin, but keep if specific sbin needed
export PATH=$PATH:/opt/homebrew/sbin
# System paths usually come last or are handled by default login profiles
# export PATH=$PATH:/System/Cryptexes/App/usr/bin:/usr/bin:/bin:/usr/sbin:/sbin:... etc. (Review if needed)
export PATH=$PATH:/Library/TeX/texbin
export PATH=$PATH:/usr/local/share/dotnet:~/.dotnet/tools
export PATH=$PATH:/usr/local/opt/llvm/bin
export PATH=$PATH:/Users/adrianbrady/.cargo/bin
export PATH=$PATH:/Users/adrianbrady/go/bin # Duplicated? Check if needed twice
export PATH=$PATH:/opt/cross/bin
export PATH=$PATH:/Users/adrianbrady/Scripts
export PATH=$PATH:/opt/homebrew/lib # Usually for libraries, not executables
export PATH=$PATH:/opt/homebrew/include # Usually for headers, not executables
export PATH=$PATH:/usr/local/opt/include # Usually for headers, not executables
export PATH=$PATH:/usr/local/opt/lib # Usually for libraries, not executables
export PATH=$PATH:/opt/local/lib # Usually for libraries, not executables
export PATH=$PATH:/Users/adrianbrady/.config/scripts/git-scripts
export PATH="/Users/adrianbrady/git-repos/git-fuzzy/bin:$PATH"
export PATH="/opt/homebrew/opt/postgresql@17/bin:$PATH"
export PATH="$PATH:/usr/local/texlive/" # Check if this path is correct/needed
export PATH=$PATH:/nix/var/nix/profiles/default/bin # If using Nix

# Ensure Ruby paths are added correctly
if [ -d "/opt/homebrew/opt/ruby/bin" ]; then
  export PATH="/opt/homebrew/opt/ruby/bin:$PATH"
  # Check if gem environment command works and is needed
  if command -v gem >/dev/null 2>&1; then
    export PATH="$(gem environment gemdir)/bin:$PATH"
  fi
fi

# Pyenv Init (should come after PATH setup)
export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init --path)" # Use --path for PATH modification only first
eval "$(pyenv init - zsh)"  # Then init the shell integration

# SDKMAN Init
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$SDKMAN_DIR/bin/sdkman-init.sh" ]] && source "$SDKMAN_DIR/bin/sdkman-init.sh"

# Other Exports
export EDITOR='nvim'
export VISUAL='nvim'
export GOPATH=$HOME/go
export OPENSSL_ROOT_DIR=/opt/homebrew/opt/openssl@3
export CMAKE_PREFIX_PATH=$CMAKE_PREFIX_PATH:$(brew --prefix qt@5)
export PATH=$PATH:$(brew --prefix qt@5)/bin # Add Qt bin if needed

# Broot Init (Source the correct shell version)
if command -v broot >/dev/null 2>&1; then
  source <(broot --print-shell-function zsh)
fi

# Aliases
alias lg="lazygit"
alias ll="ls -l"
alias gs="git status"
alias gd="git diff"
alias gds="git diff --staged"
alias gl="git log --graph --oneline"
alias glo="git log --oneline"
alias sd="~/.config/scripts/sd.sh"
alias ls="eza" # Ensure eza is installed
alias zource="source ~/.zshrc"
alias zshrc="nvim ~/dotfiles/zsh/.zshrc" # Adjust path if needed
# Source custom alias files if they exist
[[ -f ~/.config/zsh/.zsh-alias ]] && source ~/.config/zsh/.zsh-alias

# Custom Keybinds / ZLE Widgets
tmux_sessionizer() { ~/Scripts/tmux-sessionizer.sh }
zellij_sessionizer() { ~/Scripts/zellij-smart-sessionizer }
zle -N tmux_sessionizer
zle -N zellij_sessionizer
bindkey '^f' tmux_sessionizer
bindkey '^p' history-search-backward # Default Zsh keybind? Check if needed
bindkey '^n' history-search-forward  # Default Zsh keybind? Check if needed
# Source custom keybind files if they exist
[[ -f ~/.config/zsh/.zsh-keys ]] && source ~/.config/zsh/.zsh-keys

### ------ FZF Config ------

# Set FZF default options (colors, layout, etc.)
# Ensure this comes BEFORE sourcing fzf's zsh script
export FZF_DEFAULT_OPTS=" \
  --height=~40% \
  --highlight-line \
  --info=inline-right \
  --ansi \
  --layout=reverse \
  --border=none \
  --color=bg+:#292e42 \
  --color=bg:#24283b \
  --color=border:#7aa2f7 \
  --color=fg:#c0caf5 \
  --color=gutter:#3b4261 \
  --color=header:#89ddff \
  --color=hl+:#41a6b5 \
  --color=hl:#41a6b5 \
  --color=info:#545c7e \
  --color=marker:#db4b4b \
  --color=pointer:#f7768e \
  --color=prompt:#7aa2f7 \
  --color=query:#c0caf5:regular \
  --color=scrollbar:#7aa2f7 \
  --color=separator:#ff9e64 \
  --color=spinner:#e0af68 \
"

# Set up fzf key bindings (like CTRL-R) and load its Zsh completion integration
# Ensure fzf is in PATH
if command -v fzf >/dev/null 2>&1; then
  source <(fzf --zsh)
else
  echo "Warning: fzf command not found. FZF integration disabled." >&2
fi

# General options for fzf used during completion
export FZF_COMPLETION_OPTS='--border --info=inline'

# --- Configure FZF Preview for Zsh Git Completion ---
# This relies on compinit having run and fzf --zsh being sourced
# zstyle ':completion:*:*:git:*' fzf-completion-opts \
#     --height=40% \
#     --reverse \
#     --preview 'git_object=$(echo {} | awk "{print \$1}"); git show --color=always $git_object || git log --color=always $git_object'

# --- FZF Path/Dir Completion (using fd) ---
# Ensure fd is in PATH

# --- FZF Command Specific Previews ---
# This function is used by fzf's completion script if defined
# _fzf_comprun() {
#   local command=$1
#   shift
#
#   case "$command" in
#     cd)           fzf --preview 'tree -C {} | head -200' "$@" ;; # Ensure tree is installed
#     export|unset) fzf --preview "eval 'echo \$'{}" "$@" ;;
#     ssh)          fzf --preview 'dig {}' "$@" ;; # Ensure dig is installed
#     nvim)         fzf --preview 'bat -n --color=always {}' "$@" ;; # Ensure bat is installed
#     *)            fzf "$@" ;; # Pass arguments for the default case
#   esac
# }

# --- Your other FZF helper functions (fshow, fcs, fbr, etc.) ---
# These are standalone commands, not part of completion config
fshow() {
	local g=( git log --graph --format='%C(auto)%h%d %s %C(white)%C(bold)%cr' --color=always "$@" )
	local fzf_cmd=( fzf --ansi --reverse --tiebreak=index --no-sort --bind=ctrl-s:toggle-sort --preview 'f() { set -- $(echo -- "$@" | grep -o "[a-f0-9]\{7\}"); [ $# -eq 0 ] || git show --color=always $1; }; f {}' )
	$g | $fzf_cmd
}
fcs() {
  local commits commit
  commits=$(git log --color=always --pretty=oneline --abbrev-commit --reverse) &&
  commit=$(echo "$commits" | fzf --tac +s +m -e --ansi --reverse --preview 'bat --color=always --line-range :500 {}') && # Use bat for preview if available
  echo -n $(echo "$commit" | sed "s/ .*//")
}
fbr() {
  local branches branch
  # Correctly list local and remote branches for switching
  branches=$(git branch -a --format='%(refname:short)' | sed 's#^remotes/origin/##' | sort -u)
  branch=$(echo "$branches" | fzf --height=~30% --border=rounded --no-hscroll --preview="git log --oneline --graph --color=always --abbrev-commit {}") &&
  git switch "$branch" # Directly use the selected branch name
}
function git-fixup () {
  # Assuming 'git ll' is an alias for a log format that includes the hash first
  local target_hash=$(git log --oneline --color=always -n 20 | fzf | cut -d ' ' -f 1)
  if [[ -n "$target_hash" ]]; then
      git commit --no-verify --fixup "$target_hash"
  fi
}
fsw() { # Similar to fbr, maybe consolidate?
  local branches branch
  branches=$(git --no-pager branch -vv) && # Shows tracking info
  branch=$(echo "$branches" | fzf +m --preview="git log --oneline --graph --color=always --abbrev-commit {1}") && # Preview based on first field (branch name)
  git switch $(echo "$branch" | awk '{print $1}' | sed "s/^\* //") # Handle '*' for current branch
}
gp() { # Preview diff between selection and HEAD
  local tags branches target
  branches=$(git branch -a --color=always --format="%(if)%(HEAD)%(then)%(color:red)%(else)%(color:green)%(end)%(refname:short)%(color:reset)") || return
  tags=$(git tag --sort=-creatordate --color=always --format="%(color:yellow)%(refname:short)%(color:reset)") || return
  target=$( (echo "$branches"; echo "$tags") |
    fzf --no-hscroll --no-multi -n 1 --ansi \
        --preview="git log --graph --oneline --color=always --abbrev-commit HEAD..{}" \
        --preview-window=down:50%:wrap ) || return
  git checkout "$target"
}

# --- FZF CTRL-R Configuration ---
export FZF_CTRL_R_OPTS=" \
  --preview 'echo {}' --preview-window up:3:hidden:wrap \
  --bind 'ctrl-/:toggle-preview' \
  --bind 'ctrl-y:execute-silent(echo -n {2..} | pbcopy)+abort' \
  --color header:italic \
  --header 'Press CTRL-Y to copy command into clipboard' \
"

[[ -s "$HOME/.zsh/plugins/fzf-tab/fzf-tab.plugin.zsh" ]] && source "$HOME/.zsh/plugins/fzf-tab/fzf-tab.plugin.zsh"

### ------ ZSTYLE Settings (Completion System) ------

zstyle ':fzf-tab:*' fzf-command ftb-tmux-popup

# Add this in your ZSTYLE section
# General preview settings for fzf-tab
# Use bat for syntax highlighting if available, otherwise head
zstyle ':completion:*' fzf-tab-preview '[[ -f {} ]] && (bat --color=always --plain --line-range :200 {} || head -n 200 {}) || ([[ -d {} ]] && (eza --tree --level=1 --color=always {} | head -n 200))'

# Enable fzf-tab's default git log/show previews
zstyle ':completion:*:*:git:*' fzf-preview 'git_fzf_tab_preview {}'

# Example: Use a different layout for completion
# zstyle ':completion:*' fzf-command 'fzf --layout=reverse --border'
# Example: Disable sort for git checkout
zstyle ':completion:*:git-checkout:*' fzf-flags '--no-sort'


# These should generally come after compinit
# Disable sorting for git checkout if desired
zstyle ':completion:*:git-checkout:*' sort false
# Set descriptions format
zstyle ':completion:*:descriptions' format '[%d]'
# Enable list colors using LS_COLORS
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
# Preview directory's content with eza when completing cd
# This requires a custom wrapper or using fzf-tab plugin
# zstyle ':completion:*:*:cd:*' fzf-preview 'eza -1 --color=always {}' # Example if using fzf-tab

# NOTE: The 'menu no' setting might interfere with fzf/tab completion. Test without it first.
# zstyle ':completion:*' menu no

### ------ Final Inits ------
# Starship Prompt (should be near the end)
if command -v starship >/dev/null 2>&1; then
  eval "$(starship init zsh)"
else
  echo "Warning: starship command not found." >&2
fi

# Zoxide Init (should be near the end)
if command -v zoxide >/dev/null 2>&1; then
  eval "$(zoxide init zsh)"
else
  echo "Warning: zoxide command not found." >&2
fi

# Wezterm/NVIM integration (fine at the end)
[ -n "$WEZTERM_PANE" ] && export NVIM_LISTEN_ADDRESS="/tmp/nvim$WEZTERM_PANE"

# --- End of .zshrc ---
export PATH="/opt/homebrew/opt/libpq/bin:$PATH"
