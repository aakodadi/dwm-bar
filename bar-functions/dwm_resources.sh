#!/bin/sh

# A dwm_bar function to display information regarding system memory, CPU temperature, and storage
# Joe Standring <git@joestandring.com>
# GNU GPLv3

paths_logos=""

paths_logos="$paths_logos:/,"

paths_logos="$paths_logos:/home,"

paths_logos="$paths_logos:/mnt/linux-data,"

dwm_resources () {
	# get all the infos first to avoid high resources usage
	free_output=$(free -h | grep Mem)
	# Used and total memory
	MEMUSED=$(echo $free_output | awk '{print $3}')
	MEMTOT=$(echo $free_output | awk '{print $2}')
	# CPU usage
	CPU=$(top -bn1 | grep Cpu | awk '{print $2}')
	#CPU=$(sysctl -n hw.sensors.cpu0.temp0 | cut -d. -f1)
	# CPU temperature
	CPUTEMP=$(echo "scale=2 ; $(cat /sys/class/hwmon/hwmon1/temp1_input) / 1000" | bc)°C
	# Used and total storage in /home (rounded to 1024B)
	storage_format=" "
	for path_logo in $(echo $paths_logos | sed "s/:/ /g") ; do
		path="$(echo $path_logo | cut -d, -f1)"
		logo="$(echo $path_logo | cut -d, -f2)"
		df="$(df -h $path | tail -n 1)"
		df_used=$(echo $df | awk '{print $3}')
		df_total=$(echo $df | awk '{print $2}')
		df_persentage=$(echo $df | awk '{print $5}')
		storage_format="$storage_format$SEP1$logo $df_used/$df_total: $df_persentage$SEP2"
	done

	# trim
	storage_format=$(echo $storage_format)

	printf "%s" "$SEP1"
	if [ "$IDENTIFIER" = "unicode" ]; then
		printf " %s/%s$SEP2$SEP1 %s$SEP2$SEP1 %s$SEP2$SEP1%s" "$MEMUSED" "$MEMTOT" "$CPU" "$CPUTEMP" "$storage_format"
	else
		printf "STA | MEM %s/%s CPU %s STO %s/%s: %s" "$MEMUSED" "$MEMTOT" "$CPU" "$STOUSED" "$STOTOT" "$STOPER"
	fi
	printf "%s\n" "$SEP2"
}

dwm_resources
