# Docker commands
Some useful docker commands

## Manage docker images

### Check docker images
`docker images -a`

TO show full image id

`docker images --no-trunc`

### Build a docker image
in a directory containing a Dockerfile:

`docker build . -t <image-name>`

you may want to add --no-cache flag in order to make `apt update && apt upgrade` in Dockerfile take effect:

`docker build . --no-cache -t <image-name>`

if you have multiple dockerfiles in a directory, you need to specify your dockerfile name:
`docker build . -t <image-name> -f <docker-file-name>`

### Load a docker image from xxx.tar.gz
`docker load -i xxx.tar.gz`

### Rename a docker image
`docker tag <old-image-name> <new-image-name>`

### Remove a docker image
`docker rmi <image-name>`

## Manager docker containers

### Check docker containers
`docker ps -a`

### Check port forwarding of containers
`docker ps --format "{{.ID}}: {{.Ports}}"`
or 
`docker ps --format "{{.Names}}: {{.Ports}}"`

### Check mounted directories of a container
`docker inspect -f '{{ .Mounts }}' <container-name>`

### Run a docker image(create and then start a container)
```
docker run --name <image-name> -td -p <host-port>:<container-port> \
-v <host-directory>:<container-directory> \
-e <environment-variable-name>=<environment-variable-value> --restart always <container-name>
```

### Start a existing but stopped container
`docker start -i <container-name>`

### Enter a container
`docker exec -it <container-name> bash`

### Exit a container without stopping it
`<ctrl+p>` and then `<ctrl+q>`

### Stop a container
`docker stop <container-name>`

### Remove a container
`docker rm <container-name>`

### Stop and remove a container
`docker rm -f <container-name>`

## Other commands

### Copy a file to and from a container
```
docker cp <file-name> <container-name>:/<file-name>
docker cp <container-name>:/<file-name> <file-name>
```

### Retrieve the logs of a container
`docker logs <container-name>`
