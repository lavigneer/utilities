#!/bin/bash

until pgrep $1 > /dev/null
do
	echo "Waiting for $1 to come up..." >&2
	sleep 1;
done


PID=$(pgrep $1)
while pgrep $1 > /dev/null; do
	STATS=$(ps -p $PID -o %cpu,%mem | tail -n1;);
	echo "$(date +%FT%T) ${STATS}";
	sleep 1;
done

