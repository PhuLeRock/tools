
THREADS=3
DURATION=30
RAMPUP=3
LOGFILE=chaythu.jtl
LIST_HOST="172.31.9.190,172.31.8.66"
jmx_FILE=vnexpress.net.jmx
echo jmeter -n -t $jmx_FILE  -Dserver.rmi.ssl.disable=true -R $LIST_HOST -l $LOGFILE -DTHREADS=$THREADS -DRAMP_UP=$RAMPUP -DDURATION=$DURATION