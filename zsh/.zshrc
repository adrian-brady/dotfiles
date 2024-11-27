export THEME=tokyonight_storm

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
export PATH="$PATH:/Users/adrianbrady/.local/bin"
export PATH=/Users/adrianbrady/bin:/opt/homebrew/bin:/usr/local/bin:/Library/Frameworks/Python.framework/Versions/3.12/bin:/opt/local/bin:/opt/local/sbin:/Library/Frameworks/Python.framework/Versions/3.10/bin:/opt/homebrew/bin:/opt/homebrew/sbin:/usr/local/bin:/System/Cryptexes/App/usr/bin:/usr/bin:/bin:/usr/sbin:/sbin:/var/run/com.apple.security.cryptexd/codex.system/bootstrap/usr/local/bin:/var/run/com.apple.security.cryptexd/codex.system/bootstrap/usr/bin:/var/run/com.apple.security.cryptexd/codex.system/bootstrap/usr/appleinternal/bin:/Library/Apple/usr/bin:/Library/TeX/texbin:/usr/local/share/dotnet:~/.dotnet/tools:/usr/local/opt/llvm/bin:/Users/adrianbrady/bin:/opt/homebrew/bin:/Library/Frameworks/Python.framework/Versions/3.12/bin:/opt/local/bin:/opt/local/sbin:/Library/Frameworks/Python.framework/Versions/3.10/bin:/opt/homebrew/sbin:/Users/adrianbrady/.cargo/bin:/Users/adrianbrady/.local/bin:/Users/adrianbrady/go/bin:/Users/adrianbrady/.local/bin:/Users/adrianbrady/go/bin:/Users/adrianbrady/.local/bin:/opt/cross/bin
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
alias ls="eza"
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

# bg = "#24283b",
# bg_dark = "#1f2335",
# bg_highlight = "#292e42",
# blue = "#7aa2f7",
# blue0 = "#3d59a1",
# blue1 = "#2ac3de",
# blue2 = "#0db9d7",
# blue5 = "#89ddff",
# blue6 = "#b4f9f8",
# blue7 = "#394b70",
# comment = "#565f89",
# cyan = "#7dcfff",
# dark3 = "#545c7e",
# dark5 = "#737aa2",
# fg = "#c0caf5",
# fg_dark = "#a9b1d6",
# fg_gutter = "#3b4261",
# green = "#9ece6a",
# green1 = "#73daca",
# green2 = "#41a6b5",
# magenta = "#bb9af7",
# magenta2 = "#ff007c",
# orange = "#ff9e64",
# purple = "#9d7cd8",
# red = "#f7768e",
# red1 = "#db4b4b",
# teal = "#1abc9c",
# terminal_black = "#414868",
# yellow = "#e0af68",

export FZF_DEFAULT_OPTS="$FZF_DEFAULT_OPTS \
  --highlight-line \
  --info=inline-right \
  --ansi \
  --layout=reverse \
  --border=none
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

export FZF_COMPLETION_OPTS='--border --info=inline'

# Use fd (https://github.com/sharkdp/fd) for listing path candidates.
# - The first argument to the function ($1) is the base path to start traversal
# - See the source code (completion.{bash,zsh}) for the details.
_fzf_compgen_path() {
  fd --hidden --follow --exclude ".git" . "$1"
}

# Use fd to generate the list for directory completion
_fzf_compgen_dir() {
  fd --type d --hidden --follow --exclude ".git" . "$1"
}

# Advanced customization of fzf options via _fzf_comprun function
# - The first argument to the function is the name of the command.
# - You should make sure to pass the rest of the arguments to fzf.
_fzf_comprun() {
  local command=$1
  shift

  case "$command" in
    cd)           fzf --preview 'tree -C {} | head -200'   "$@" ;;
    export|unset) fzf --preview "eval 'echo \$'{}"         "$@" ;;
    ssh)          fzf --preview 'dig {}'                   "$@" ;;
    nvim)         fzf --preview 'bat -n --color=always {}' "$@" ;;
    *)            fzf                                           ;;
  esac
}

# fshow() {
#   git log --graph --color=always \
#       --format="%C(auto)%h%d %s %C(black)%C(bold)%cr" "$@" |
#   fzf --ansi --no-sort --reverse --tiebreak=index --bind=ctrl-s:toggle-sort \
#       --bind "ctrl-m:execute:
#                 (grep -o '[a-f0-9]\{7\}' | head -1 |
#                 xargs -I % sh -c 'git show --color=always % | less -R') << 'FZF-EOF'
#                 {}
# FZF-EOF"
# }

# fshow - git commit browser
fshow() {
	local g=(
		git log
		--graph
		--format='%C(auto)%h%d %s %C(white)%C(bold)%cr'
		--color=always
		"$@"
	)

	local fzf=(
		fzf
		--ansi
		--reverse
		--tiebreak=index
		--no-sort
		--bind=ctrl-s:toggle-sort
		--preview 'f() { set -- $(echo -- "$@" | grep -o "[a-f0-9]\{7\}"); [ $# -eq 0 ] || git show --color=always $1; }; f {}'
	)
	$g | $fzf
}

# fcs - get git commit sha
fcs() {
  local commits commit
  commits=$(git log --color=always --pretty=oneline --abbrev-commit --reverse) &&
  commit=$(echo "$commits" | fzf --tac +s +m -e --ansi --reverse --preview 'bat -n --color=always {}') &&
  echo -n $(echo "$commit" | sed "s/ .*//")
}

# fbr - checkout git branch (including remote branches)
fbrr() {
  local branches branch
  branches=$(git branch --all | grep -v HEAD) &&
  branch=$(echo "$branches" |
           fzf-tmux -d $(( 2 + $(wc -l <<< "$branches") )) +m) &&
  git checkout $(echo "$branch" | sed "s/.* //" | sed "s#remotes/[^/]*/##")
}

function git-fixup () {
  git ll -n 20 | fzf | cut -f 1 | xargs git commit --no-verify --fixup
}

# fbr - checkout git branch
fsw() {
  local branches branch
  branches=$(git --no-pager branch -vv) &&
  branch=$(echo "$branches" | fzf +m) &&
  git switch $(echo "$branch" | awk '{print $1}' | sed "s/.* //")
}

# fco_preview - checkout git branch/tag, with a preview showing the commits between the tag/branch and HEAD
fco_preview() {
  local tags branches target
  branches=$(
    git --no-pager branch --all \
      --format="%(if)%(HEAD)%(then)%(else)%(if:equals=HEAD)%(refname:strip=3)%(then)%(else)%1B[0;34;1mbranch%09%1B[m%(refname:short)%(end)%(end)" \
    | sed '/^$/d') || return
  tags=$(
    git --no-pager tag | awk '{print "\x1b[35;1mtag\x1b[m\t" $1}') || return
  target=$(
    (echo "$branches"; echo "$tags") |
    fzf --no-hscroll --no-multi -n 2 \
        --ansi --preview="git --no-pager log -150 --pretty=format:%s '..{2}'") || return
  git checkout $(awk '{print $2}' <<<"$target" )
}

# CTRL-/ to toggle small preview window to see the full command
# CTRL-Y to copy the command into clipboard using pbcopy
export FZF_CTRL_R_OPTS="
  --preview 'echo {}' --preview-window up:3:hidden:wrap
  --bind 'ctrl-/:toggle-preview'
  --bind 'ctrl-y:execute-silent(echo -n {2..} | pbcopy)+abort'
  --color header:italic
  --header 'Press CTRL-Y to copy command into clipboard'"

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

[ -n "$WEZTERM_PANE" ] && export NVIM_LISTEN_ADDRESS="/tmp/nvim$WEZTERM_PANE"

### ------ SDK Man Init ------
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"
export OPENSSL_ROOT_DIR=/opt/homebrew/opt/openssl@3
export CMAKE_PREFIX_PATH=$CMAKE_PREFIX_PATH:$(brew --prefix qt@5)
export PATH=$PATH:$(brew --prefix qt@5)/bin
export PATH=$PATH:/opt/local/lib
export PATH=$PATH:/Users/adrianbrady/.config/scripts/git-scripts
export PATH="/Users/adrianbrady/git-repos/git-fuzzy/bin:$PATH"
