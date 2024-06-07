# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="robbyrussell"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder


# Override default cd command
ZOXIDE_CMD_OVERRIDE="cd"

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
	git 
	battery
	archlinux 
	thefuck 
	ssh-agent 
	rust
	ripgrep
	zoxide
)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

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

# Set editor to neovim
export EDITOR="nvim"
export VISUAL="nvim"

# xbps
alias xbi="doas xbps-install "
alias xbr="doas xbps-remove "
alias xbq="xbps-query "
alias xbrc="doas xbps-reconfigure "

# shorts
alias die="pkill -9 "
alias bye="sudo poweroff "
alias rb="sudo reboot "
alias s="sudo "
alias ls="ls --color=auto"
alias l="ls -l "
alias ds="dirs -v "
alias pd="pushd "
alias pp="popd "
# alias cuda="LD_LIBRARY_PATH="/home/arend/programms/zluda:$LD_LIBRARY_PATH" "

# vimlike
alias :q="exit"
alias :x="exit"

# Only neovim
alias vim="nvim"

# Use ripgrep
alias grep="rg"

# matrix(like the movie)
alias matrix="cmatrix -ab "
alias rainbowmatrix="cmatrix -abr"

alias nuget="mono /usr/local/bin/nuget.exe"

#cmus display
# alias cmdis="/home/arend/.config/cmus/cmus-cover-art/display.sh"

# paths
export XBPS_DISTDIR=$HOME/void-packages
export PATH=$HOME/packages/anaconda/bin:$PATH
export PATH=$HOME/.dotnet/:$PATH
export PATH=$HOME/programms/android-studio/bin/:$PATH
export PATH=/usr/lib/ruby/gems/3.2.0/bin:$PATH
export PATH=$HOME/.local/bin:$PATH
export PATH=$HOME/.cargo/bin:$PATH
export DOTNET_ROOT=$HOME/.dotnet
export MGFXC_WINE_PATH=/home/arend/.winemonogame
# export DOTNET_SYSTEM_GLOBALIZATION_INVARIANT=1

# locals
export LC_CTYPE="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"

# Add .NET Core SDK tools
export PATH=$PATH:/home/arend/.dotnet/tools
export MGFXC_WINE_PATH=$HOME/.winemonogame
. "$HOME/.cargo/env"

