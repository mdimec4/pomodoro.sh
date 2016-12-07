#!/bin/bash

# use first mp3 file found
mp3=`for i in *.mp3; do printf '%s\n' "$i"; break; done`

trap 'killgroup' INT TERM HUP QUIT
killgroup() {
echo "**** Shutting down... ****"
trap '' INT TERM HUP QUIT    # ignore signals while shutting down
kill %1
#waitall
wait #wait with out arguments waits for all children to terminate
exit 0
}


echo "hit ^C to stop"
while true
do	
	#desktop notification
	notify-send --icon=gtk-info Test "Work"
	#count work
	for i in `seq 0 24`; #25 min
	do
		rem=`echo "25-$i" | bc`
		printf "Work for $rem  "\\r
		sleep 60
	done    
	
	#desktop notification
	notify-send --icon=gtk-info Test "Stand up and Relax"
	#play music
	hour=`date +%H`
	if test "$hour" -ge 8 && test "$hour" -lt 7
	then
		mplayer -volume 50 "$mp3" 2>&1 > /dev/null &
		echo  "Mplayer PID: " `jobs -p`
	fi
	#count pause
	for i in `seq 0 4`; # 5 min
	do
		rem=`echo "5-$i" | bc`
		printf "Relax for $rem "\\r
		sleep 60
	done 
	jobs
	kill %1 # stop music
	wait
done

