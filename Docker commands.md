# Docker commands
Some useful docker commands

## Check docker images
`docker images`

## Build a docker image
in a directory containing a Dockerfile:

`docker build . -t <image-name>` 

you may want to add --no-cache flag in order to make the `apt update && apt upgrade` in Dockerfile takes effect:

`docker build . --no-cache -t <image-name>`

## Run a docker image
```
docker run --name <image-name> -td -p <host-port>:<container-port> \
-v <host-directory>:<container-directory> \
-e <environment-variable-name>=<environment-variable-value> --restart always <container-name>
```

## Change docker image name
`docker tag <old-image-name> <new-image-name>`

## Remove a docker image
`docker rmi <image-name>`

## Check docker containers
`docker ps -a`

## Enter a container
`docker exec -it <container-name> bash`

## Stop a container
`docker stop <container-name>`

## Stop and remove a container
`docker rm -f <container-name>`
