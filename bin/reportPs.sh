#!/usr/bin/env bash

rm ~/reportPs.log

while true; do
	ps auxcr | head -n21 >> ~/reportPs.log
	sleep 7
done

