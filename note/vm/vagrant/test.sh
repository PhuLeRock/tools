echo ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAQEAzPKGrRox7DgQwDyZr/PGnWeXD8ymbGOIJTebO9QBgEUSq9BORv8a3Mbxnb7ctli3nVz7/NEOd3qI730gXAhfEltdzJiiDa1bH5g2t9Rig/MLPAX587u7zqmSjrZc1mj9b0u3r+dIaIVWenuIsVbv6oWVe+UuN3hWLu6HXVOVetzTfSwt27EKYTTu3QH9WQTlq3uZjlk2ffLSgnnf5er0JyywHXeyIuZo4RjrLgfcjkZVqPQVmGY/MPstuTrSlloqGJLtwB/i1FgJ4lkIJcNGmz74u3rj2UFlCBPjJQtfSCsBqxH0177zr+ucCZRShFc8iqK8vEqtHSuOAB+vB1/UQw== phulerock@mocxi-lappy >> /home/vagrant/.ssh/authorized_keys
apt-get -y install docker.io
/etc/init.d/docker restart
mkdir -p /data/docker/
echo '
FROM centos:centos6.6
MAINTAINER phultv@hvn.vn <cloud-ops@centos.org>
RUN echo "nginx on CentOS 6 inside Docker" > /root/test.txt"
' >> /data/docker/Dockerfile
cd /data/docker/
docker pull centos:centos6.6
docker build -t test/nginx .
docker run --name="nginx" -d -p 80:80 -it test/nginx /bin/bash