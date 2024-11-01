mic_state_file="/tmp/mic_state.txt"

amixer set Capture toggle > /dev/null 2>&1

amixer get Capture | grep -q "\[on\]"
mic_status=$?

echo "$mic_status" > "$mic_state_file"

if [ "$mic_status" -eq 0 ]; then
    notify-send "Micrófono activado" -t 2000
else
    notify-send "Micrófono silenciado" -t 2000
fi
