
# Path
_NEW_PATHS=""

_NEW_PATHS="$HOME/packages/anaconda/bin:$_NEW_PATHS"
_NEW_PATHS="$HOME/.dotnet/:$_NEW_PATHS" # The main dotnet binary directory
_NEW_PATHS="$HOME/programms/android-studio/bin/:$_NEW_PATHS"
_NEW_PATHS="/usr/lib/ruby/gems/3.2.0/bin:$_NEW_PATHS"
_NEW_PATHS="$HOME/.local/bin:$_NEW_PATHS"
_NEW_PATHS="$HOME/.cargo/bin:$_NEW_PATHS"

export PATH="$_NEW_PATHS:$PATH"

export PATH="$PATH:$HOME/.dotnet/tools"

# other env stuff
# export XBPS_DISTDIR="$HOME/void-packages"
export DOTNET_ROOT="$HOME/.dotnet"
export MGFXC_WINE_PATH="/home/arend/.winemonogame"
# export DOTNET_SYSTEM_GLOBALIZATION_INVARIANT=1

# Theme
export QT_QPA_PLATFORMTHEME=qt6ct

# locals
export LC_CTYPE="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"
