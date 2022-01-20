
THREADS=3
DURATION=120
RAMPUP=3
LOGFILE=chaythu.jtl
LIST_HOST="172.31.4.198"
jmx_FILE=Perf_Script.jmx
#jmx_FILE=vnexpress.net.jmx
#jmx_FILE=Test03.jmx
jmeter -n -t $jmx_FILE  -Dserver.rmi.ssl.disable=true -R $LIST_HOST -l $LOGFILE -DTHREADS=$THREADS -DRAMP_UP=$RAMPUP -DDURATION=$DURATION