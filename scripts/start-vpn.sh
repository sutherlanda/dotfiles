#!/bin/bash
piactl login login.conf 2> /dev/null
piactl set region ca-vancouver
piactl set requestportforward true
piactl connect
echo "Connecting, please wait."
STATUS=$(piactl get connectionstate)
while [ "$STATUS" != "Connected" ] 
do
	echo "..."
	sleep 3
	STATUS=$(piactl get connectionstate)
done
echo "..."
sleep 3
echo "Connected to VPN with IP $(piactl get vpnip)." 
FORWARDED_PORT=$(piactl get portforward)
if [ "$FORWARDED_PORT" != "Inactive" ]; then
  echo "Port forwarding on port $(piactl get portforward)."
 
  # Reconfigure firewall to remove last used port and add current one
  sudo ufw delete allow "$FORWARDED_PORT"
  sudo transmission-remote -p $FORWARDED_PORT
  sudo ufw allow $FORWARDED_PORT
fi
