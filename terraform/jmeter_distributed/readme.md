cost
terraform plan -out=plan.tfplan > /dev/null && terraform show -json plan.tfplan | curl -s -X POST -H "Content-Type: application/json" -d @- https://cost.modules.tf/


https://apps.apple.com/vn/app/simpleclient-for-ftp-sftp/id1406961198?mt=12

THREADS=
DURATION=
RAMPUP=
LOGFILE=logfile.jtl

jmeter -n -t vnexpress.net.jmx  -Dserver.rmi.ssl.disable=true -R 172.31.1.88,172.31.11.82 -l $LOGFILE    -DTHREADS=$THREADS -DRAMP_UP=$RAMPUP -DDURATION=$DURATION

1. ssh vào:
ssh -i ~/Documents/sshkey/phultv.rsa  root@34.210.250.129
docker exec -it master bash
cd cd /opt/Sharedvolume/

2. sửa file run.sh rồi chép lên, chạy
sh run.sh