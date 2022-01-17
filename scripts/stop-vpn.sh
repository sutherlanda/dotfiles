#!/bin/bash
sudo ufw delete allow $(piactl get portforward) &> /dev/null
piactl disconnect
echo "Disconnecting, please wait."
while [ "$(piactl get connectionstate)" != "Disconnected" ]
do
	echo "..."
	sleep 3
done
sleep 3
echo "Disconnected."

