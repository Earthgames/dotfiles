hostname="%{$fg_bold[green]%}%n%{$fg[cyan]%}%1{@%}%{$fg_bold[magenta]%}%m" # name@hostname
battery="{{#if laptop}}%f[$(battery_pct_prompt)]{{/if}}" # [battery%] 
clock="%{$fg[cyan]%}[20%D %T]" # [YYYY-MM-DD HH:MM] in 24H
current_path="%3~" # path max 3 deep with ~ for home
succes_indicator="%(?.%{$fg_bold[green]%}.%{$fg_bold[red]%})->" # -> in red or green depending on the outcome of the previous command
reset="%{$reset_color%}" # reset the color for the prompt
git='$(git_prompt_info)' # git info
PROMPT="$hostname$battery$clock $current_path $succes_indicator$reset $git"

# see https://zsh.sourceforge.io/Doc/Release/Prompt-Expansion.html for more

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg_bold[blue]%}git:(%{$fg[red]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%} "
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[blue]%}) %{$fg[yellow]%}%1{✗%}"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[blue]%})"
