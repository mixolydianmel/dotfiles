#!/bin/sh

# Screen
xset s off
xset -dpms

# Start Programs

# compositor
killall picom
while pgrep -u $UID -x picom >/dev/null; do sleep 1; done
picom --experimental-backends --blur-background-fixed --blur-method "gaussian" --blur-size 10 --blur-deviation 5 --corner-radius 8 --round-borders 8 --backend glx --vsync &

# bg
killall feh
feh --bg-scale '/home/caden/Pictures/bg.png' &

# eyesight
killall redshift
while pgrep -u $UID -x redshift >/dev/null; do sleep 1; done
redshift -r -l 38.90:-77.16 &

# dwmblocks
killall dwmblocks
dwmblocks &

# time
sudo sv restart openntpd
ntpd -s -d &

# pulseaudio
killall pulseaudio
pulseaudio -k
pulseaudio &
pulseaudio --start &

# cursor
xbanish
