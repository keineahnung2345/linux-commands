# Docker commands
Some useful docker commands

## Check docker images
`docker images`

TO show full image id

`docker images --no-trunc`

## Build a docker image
in a directory containing a Dockerfile:

`docker build . -t <image-name>` 

you may want to add --no-cache flag in order to make the `apt update && apt upgrade` in Dockerfile takes effect:

`docker build . --no-cache -t <image-name>`

## Load a docker image from xxx.tar.gz
`docker load -i xxx.tar.gz`

## Run a docker image
```
docker run --name <image-name> -td -p <host-port>:<container-port> \
-v <host-directory>:<container-directory> \
-e <environment-variable-name>=<environment-variable-value> --restart always <container-name>
```

## Rename a docker image
`docker tag <old-image-name> <new-image-name>`

## Remove a docker image
`docker rmi <image-name>`

## Check docker containers
`docker ps -a`

## Enter a container
`docker exec -it <container-name> bash`

## Stop a container
`docker stop <container-name>`

## Remove a container
`docker rm <container-name>`

## Stop and remove a container
`docker rm -f <container-name>`

## Copy a file to and from a container
```
docker cp <file-name> <container-name>:/<file-name>
docker cp <container-name>:/<file-name> <file-name>
```
