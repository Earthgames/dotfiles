#!/usr/bin/env bash

## Author  : Aditya Shakya (adi1090x)
## Github  : @adi1090x
#
## Applets : Screenshot

# Import Current Theme
dir="$HOME/.config/rofi"
style='screenshot.rasi'
theme="$type/$style"

# needs dunst

# Theme Elements
prompt='Screenshot'
mesg="DIR: `xdg-user-dir PICTURES`/Screenshots"

# Options
list_col='1'
list_row='5'
win_width='400px'
option_1=" Capture Desktop"
option_2=" Capture Area"
option_3=" Capture Window"
option_4=" Capture in 5s"
option_5=" Capture in 10s"

# Rofi CMD
rofi_cmd() {
	rofi -theme-str "window {width: $win_width;}" \
		-theme-str "listview {columns: $list_col; lines: $list_row;}" \
		-theme-str 'textbox-prompt-colon {str: "";}' \
		-dmenu \
		-p "$prompt" \
		-mesg "$mesg" \
		-markup-rows \
		-theme ${theme}
}

# Pass variables to rofi dmenu
run_rofi() {
	echo -e "$option_1\n$option_2\n$option_3\n$option_4\n$option_5" | rofi_cmd
}

# Screenshot
time=`date +%Y-%m-%d-%H-%M-%S`
geometry=`xrandr | grep 'current' | head -n1 | cut -d',' -f2 | tr -d '[:blank:],current'`
dir="`xdg-user-dir PICTURES`/Screenshots"
file="Screenshot_${time}_${geometry}.png"

if [[ ! -d "$dir" ]]; then
	mkdir -p "$dir"
fi

# notify and view screenshot
notify_view() {
	notify_cmd_shot='dunstify -u low --replace=699'
	${notify_cmd_shot} "Copied to clipboard."
	Action=$(dunstify --action="default,Reply" "Save screenshot?")
	if [ "$Action" = "default" ]; then
		wl-paste -n > $file # don't copy anything in this time
		${notify_cmd_shot} "Screenshot Saved."
	else
	 	${notify_cmd_shot} "Screenshot Not Saved."
	fi
}

# Copy screenshot to clipboard
copy_shot () {
	wl-copy -t image/png
}

# countdown
countdown () {
	for sec in `seq $1 -1 1`; do
		dunstify -t 1000 --replace=699 "Taking shot in : $sec"
		sleep 1
	done
}

# take shots
shotnow () {
	cd ${dir} && sleep 0.3 && grim - | copy_shot # wait till screenshot menu is away
	notify_view
}

shot5 () {
	countdown '5'
	sleep 1 && cd ${dir} && grim - | copy_shot
	notify_view
}

shot10 () {
	countdown '10'
	sleep 1 && cd ${dir} && grim -| copy_shot
	notify_view
}

shotwin () {
	pos="$(wf-info | command grep Geometry | awk '{print $2, $3}')"
	cd ${dir} && grim -g "$pos" - | copy_shot
	echo  "$pos"
	notify_view
}

shotarea () {
	cd ${dir} && grim -g "$(slurp -d)" - | copy_shot
	notify_view
}

# Execute Command
run_cmd() {
	if [[ "$1" == '--opt1' ]]; then
		shotnow
	elif [[ "$1" == '--opt2' ]]; then
		shotarea
	elif [[ "$1" == '--opt3' ]]; then
		shotwin
	elif [[ "$1" == '--opt4' ]]; then
		shot5
	elif [[ "$1" == '--opt5' ]]; then
		shot10
	fi
}

# Actions
chosen="$(run_rofi)"
case ${chosen} in
    $option_1)
		run_cmd --opt1
        ;;
    $option_2)
		run_cmd --opt2
        ;;
    $option_3)
		run_cmd --opt3
        ;;
    $option_4)
		run_cmd --opt4
        ;;
    $option_5)
		run_cmd --opt5
        ;;
esac
