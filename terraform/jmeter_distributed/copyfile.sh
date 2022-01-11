#~/Documents/PerformanceTest/14122021/tester.rsa


server=root@54.71.227.110:/opt/Sharedvolume/
localpc='./newreport'

rsync -avr -e 'ssh -i ~/Documents/PerformanceTest/14122021/tester.rsa'  $server $localpc