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
	notify-send -t 60000 --icon=gtk-info Work "Work\nStop goofing around and get to work... \n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n :)"
	#count work
	for i in `seq 0 24`; #25 min
	do
		rem=`echo "25-$i" | bc`
		printf "Work for $rem  "\\r
		sleep 60
	done    
	
	#desktop notification
	notify-send -t 299000 --icon=gtk-info Relax "Stand up and Relax...\nStarch your legs, it's good for your health! \n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n:D"
	#play music
	hour=`date +%H`
	day=`date +%u` #1-7 1==Monday
	if test "$hour" -ge 8 && test "$hour" -lt 17 && test "$day" -ne 6 && test "$day" -ne 7 #workdays(mon to fri) 8am to 7pm
	then
		mplayer -loop 0 -volume 58 "$mp3" 2>&1 > /dev/null & #68
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

