#!/bin/bash
#
# Kayhan KAYNAR 2021
# kayhan.kaynar@hotmail.com

read disk <  /home/DISKNAME.txt

smbclientonlinefile=/tmp/smbclientonlinefile.txt

#declare RESULT=($(ss -4 | grep 'microsoft' | cut -d " " -f4 ))
declare RESULT=($(ss -4 | grep 'microsoft' | awk '{print $2}'))

echo ${RESULT[0]}
echo $RESULT

if [ ${RESULT[0]} == ESTAB ]
then
#echo "CONNECTED"
     if [ ! -e $smbclientonlinefile ]
        then
        touch $smbclientonlinefile
        IP=$( ss -4 | grep 'microsoft' | awk '{print $6}' | cut -d ":" -f1 )
        echo $IP
        echo $IP >> $smbclientonlinefile
     fi
else
#echo "NOT CONNECTED"
    if [ -e $smbclientonlinefile ]
        then
        rm $smbclientonlinefile
        find /mnt/$disk -type f \( -name ".*" \) -delete
    fi
fi

exit 0
