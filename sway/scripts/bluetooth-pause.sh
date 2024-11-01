#!/bin/sh

trap "playerctl --all-players pause" SIGUSR1
while true
do
    sleep 1
done
