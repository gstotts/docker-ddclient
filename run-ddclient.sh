#!/bin/sh
while true; do
  /usr/bin/ddclient -daemon=0
  sleep 300  # Sleep for 5 minutes before restarting
done
