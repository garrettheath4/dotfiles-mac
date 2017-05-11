#!/usr/bin/env bash

rm ~/reportTop.log

while true; do
	top -i100 -l3 -ocpu -n10 -R -stats user,pid,command,cpu,time,pstate | tail -n44 >> ~/reportTop.log
	sleep 3
done

