# Dockerfile
FROM amazonlinux:2023 AS arm

# Install any necessary packages (optional)
RUN yum update
RUN yum install -y awscli
RUN yum install -y tar gzip jq
RUN ln -s /usr/bin/python3.9 /usr/bin/python
# binary at /root/.local/bin/tfswitch 
RUN curl -L https://raw.githubusercontent.com/warrensbox/terraform-switcher/master/install.sh | bash -s -- -b $HOME/.local/bin
# Create workspace
RUN mkdir /workspace/


# Command to run when the container starts
CMD ["sleep", "infinity"]
# Install terraform tfwitch
