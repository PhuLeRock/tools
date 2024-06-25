### How it works
VSCode plugin "dev container" will automatically read .devcontainer/*/devcontainer.json -> run Docker-compose.yaml. 
### How to use
In VSCode, install plugin dev container.

Open folder, command palette: dev containers: reopen container.

You can configure AWS credential by export these env variable
AWS_ACCESS_KEY_ID: "xx"
AWS_SECRET_ACCESS_KEY: "xx"
AWS_DEFAULT_REGION: "ap-southeast-1"

tfwitch is located at /root/.local/bin/tfwitch
 
To stop, need to use MacOs terminal to run ```docker-compose down```

