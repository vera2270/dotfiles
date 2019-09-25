#!/usr/bin/bash

# sets the HandlePowerKey and HandleSuspendKey options to ignore in /etc/systemd/logind.conf
FILE="/etc/systemd/logind.conf"

if [[ $1 != "ok" ]]; then
    if grep -q "HandlePowerKey=ignore" $FILE && grep -q "HandleSuspendKey=ignore" $FILE; then
        exit 0
    fi

    read -p "diable power and suspend keys in $FILE ? [y/N] " -r
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        exit 0
    fi
fi

if [[ $EUID -ne 0 ]];
then
    exec /usr/bin/sudo /usr/bin/bash "$0" "ok"
fi

sed -i '/HandlePowerKey/d;/HandleSuspendKey/d' $FILE
echo "HandlePowerKey=ignore" >> $FILE
echo "HandleSuspendKey=ignore" >> $FILE

systemctl restart systemd-logind

echo "ok"