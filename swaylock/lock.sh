image=`find $HOME/Pictures/lock_screen/ -type f | shuf -n 1`
echo $image
swaylock -i $image -s fit -c 000000 --caps-lock-key-hl-color F070F0
