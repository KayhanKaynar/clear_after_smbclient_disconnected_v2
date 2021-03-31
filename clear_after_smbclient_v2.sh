#!/bin/bash
#
# Kayhan KAYNAR 2021
# kayhan.kaynar@hotmail.com
# You can schedule this script on your crontab for 5 or 15 minutes.

smbclientonlinefile=/tmp/smbclientonlinefile.txt

#determining if the samba client is connected
declare RESULT=($(ss -4 | grep 'microsoft' | awk '{print $2}'))


if [ ${RESULT[0]} == ESTAB ]
then
#echo "CONNECTED"
     #if does not exist, create the samba client online file to recognize if client has disconnected.
     if [ ! -e $smbclientonlinefile ]
        then
        touch $smbclientonlinefile
        IP=$( ss -4 | grep 'microsoft' | awk '{print $5}' | cut -d ":" -f1 )
        echo $IP
        echo $IP >> $smbclientonlinefile
     fi
else
#echo "NOT CONNECTED"
    #detecting that the samba client has disconnected. While connection has been ESTABLISHED , some unnecessary files can be created. And that can be deleted by the way.
    if [ -e $smbclientonlinefile ]
        then
        rm $smbclientonlinefile
        #you can edit your samba file share mount that you macos connects.
        find /mnt/ExtHDD -type f \( -name ".*" \) -delete
    fi
fi

exit 0
