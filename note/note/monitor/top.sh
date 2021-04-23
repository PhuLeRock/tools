#
echo $$ > top.pid
checkdir() {
	if [ ! -d cpulog ]; then
		mkdir cpulog
	else
		echo logdir ok
	fi
}
removedir() {
	if [ -d cpulog ]; then
		rm -rf cpulog
	fi
}
screenshot() {
echo $(date +%Y-%m-%d-%H.%M.%S) >> cpulog/top.log
top -cbn3 | head -n15 | tail -n8 >> cpulog/top.log
echo "~~~~~~~~~~~~~~~" >> cpulog/top.log
}

go() {
while true; do
	printf "%.0f" $(top -cbn3 | head -n8 | tail -n1 | awk '{print $9}') > toptmp.log
	if [ $(cat toptmp.log) -gt 40 ]; then 
		screenshot
	fi
	sleep 1
done
}

#removedir
checkdir
go