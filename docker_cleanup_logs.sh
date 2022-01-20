contname=$(docker ps -f name=clientcenterv2 | grep -v 'job\|CONTAINER' | awk '{print$1}')
echo "name is" $contname
echo "logfile at" $(docker inspect --format='{{.LogPath}}' $contname)
ls -lah $(docker inspect --format='{{.LogPath}}' $contname)
#echo " " > $(docker inspect --format='{{.LogPath}}' $contname)
contname=0