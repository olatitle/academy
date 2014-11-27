#!/bin/bash
 
function shutdown()
{
        date
        echo "Shutting down Tomcat"
        Users/admin/tomcat/bin/catalina.sh stop
}
 
date
echo "Starting Tomcat"
export CATALINA_PID=/tmp/$$
 
# uncomment to increase Tomcat's maximum heap allocation
# export JAVA_OPTS=-Xmx512M $JAVA_OPTS
 
. /Users/admin/tomcat/bin/catalina.sh start
 
# allow any signal which would kill a process to stop Tomcat
trap shutdown HUP INT QUIT ABRT KILL ALRM TERM TSTP
 
echo "Waiting for `cat $CATALINA_PID`"
wait `cat $CATALINA_PID`

