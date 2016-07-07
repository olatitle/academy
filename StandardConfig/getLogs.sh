#!/bin/bash
LOGFILE=/var/log/messages
DIR=~/networkLogs/$(date +"%d-%m-%y_%T")

mkdir -p $DIR

scp dhis@192.168.2.2:$LOGFILE $DIR/UniFiAP
scp dhis@192.168.2.5:$LOGFILE $DIR/UniFiDualAP
scp ubnt@192.168.1.1:$LOGFILE $DIR/router
