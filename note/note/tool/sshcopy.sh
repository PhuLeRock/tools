
source=/home/phultv/Documents/ddos
dest=/data/
server=103.224.170.92
port=
user=
	
if [ -n $port ]; then port=3322; fi
if [ -n $user ]; then user=root; fi
echo rsync -ar -e "ssh -i /home/phultv/Dropbox/Documents/sshkey/phultv.rsa -p$port" $source $user@$server:$dest
rsync -ar -e "ssh -i /home/phultv/Dropbox/Documents/sshkey/phultv.rsa -p$port" $source $user@$server:$dest
echo "~~~~~~~~~~Listing:"
ssh -i /home/phultv/Dropbox/Documents/sshkey/phultv.rsa -p$port $user@$server ls $dest
