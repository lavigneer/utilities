#!/bin/bash

PROCESS=$1
DIRECTORY=$2

mkdir -p "$DIRECTORY"

until pgrep "$PROCESS" > /dev/null
do
	echo "Waiting for ${PROCESS} to come up..." >&2
	sleep 1;
done

while pgrep "$PROCESS" > /dev/null; do
	PIDS=$(pgrep "$PROCESS")
	for PID in $PIDS
	do
		STATS=$(ps -p "$PID" -o %cpu,%mem | tail -n1;);
		echo "$(date +%FT%T) ${STATS}" >> "${DIRECTORY}/${PROCESS}_${PID}.csv";
	done
	sleep 1;
done

