PROMPT="%{$fg_bold[green]%}%n%{$fg[cyan]%}%1{@%}%{$fg_bold[magenta]%}%m{{#if laptop}}%f[$(battery_pct_prompt)]{{/if}}%{$fg[cyan]%}[20%D %T] %~ %(?:%{$fg_bold[green]%}%1 %{➜%}:%{$fg_bold[red]%}%1{➜%})%{$reset_color%}"
PROMPT+=' $(git_prompt_info)'

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg_bold[blue]%}git:(%{$fg[red]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%} "
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[blue]%}) %{$fg[yellow]%}%1{✗%}"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[blue]%})"

