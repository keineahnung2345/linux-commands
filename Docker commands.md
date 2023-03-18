# Docker commands
Some useful docker commands

## Manage Docker as a non-root user
[Post-installation steps for Linux](https://docs.docker.com/install/linux/linux-postinstall/)
```sh
# create the group named docker
sudo groupadd docker
# add user to the group
sudo usermod -aG docker $USER
# activate the change to groups
newgrp docker 
```

## Start docker 
```sh
systemctl start docker
```

## Stop docker
```sh
systemctl stop docker
```

## Restart docker
```sh
service docker restart
```

## Check docker version
`docker -v` or `docker --version` show docker version in one line

`docker version` show details informations

## List and sort the versions available in your repo
```sh
yum list docker --showduplicates | sort -r
```

or

```sh
yum list docker-ce --showduplicates | sort -r
```

## search docker image
```sh
docker search <image-name>
```

## get tags of a docker image
From [How to list all tags of a docker image](http://www.googlinux.com/list-all-tags-of-docker-image/index.html):

List first 10 tags:
```sh
curl 'https://registry.hub.docker.com/v2/repositories/<owner>/<repo>/tags/'|jq '."results"[]["name"]'
```

Replace <owner>/<repo> with debian/tags, nvidia/cuda, etc.

List all tags:
```sh
i=0

while [ $? == 0 ]
do 
   i=$((i+1))
   curl https://registry.hub.docker.com/v2/repositories/<owner>/<repo>/tags/?page=$i 2>/dev/null|jq '."results"[]["name"]'
done
```

## get docker ip
```sh
docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' container_name_or_id
```

## run docker on an external device
[How to tell Docker to store and run containers on an external drive](https://serverfault.com/questions/916120/how-to-tell-docker-to-store-and-run-containers-on-an-external-drive)
```sh
chown -R root:root /mnt/external-drive/docker-base
chmod 701 /mnt/external-drive/docker-base
```

Edit the file `/etc/docker/daemon.json`:
```
{
    "graph": "/mnt/external-drive/docker-base"
}
```

And then `service docker restart`.

## Manage docker images

### Check docker images
`docker images -a`

TO show full image id

`docker images --no-trunc`

### Build a docker image
in a directory containing a Dockerfile:

`docker build . -t <image-name>`

`docker build . -t <image-name> -f <dockerfile-name>`

you may want to add --no-cache flag in order to make `apt update && apt upgrade` in Dockerfile take effect:

`docker build . --no-cache -t <image-name>`

if you have multiple dockerfiles in a directory, you need to specify your dockerfile name:
`docker build . -t <image-name> -f <docker-file-name>`

### Build a docker image from an existing container
`docker commit <container-name> <image-name:tag>`

### Pull a image from dockerhub
`docker pull <image-name:tag>`

### Push your image to dockerhub
```sh
docker login
docker tag <image-name:tag> <your-docker-hub-id>/<image-name:tag>
docker push <your-docker-hub-id>/<image-name:tag>
```

### Load a docker image from xxx.tar.gz
`docker load -i xxx.tar.gz`

### Save a docker image to xxx.tar.gz
`docker save -o xxx.tar.gz <image-name>`

### Rename a docker image
`docker tag <old-image-name> <new-image-name>`

### Remove a docker image
`docker rmi <image-name>`

### Remove all docker images
`docker rmi $(docker images -q)`

## Manager docker containers

### Check docker containers
`docker ps -a`

### Check port forwarding of containers
`docker ps --format "{{.ID}}: {{.Ports}}"`
or 
`docker ps --format "{{.Names}}: {{.Ports}}"`

### Check docker containers' numeric IDs
`docker ps -q`

### Remove all docker containers
`docker rm $(docker ps -aq)`

### Check mounted directories of a container
`docker inspect -f '{{ .Mounts }}' <container-name>`

### Run a docker image(create and then start a container)
```
docker run --name <container-name> -td -p <host-port>:<container-port> \
-v <host-directory>:<container-directory> \
-e <environment-variable-name>=<environment-variable-value> --restart always <image-name>
```

### Add new mount to existing but stopped container
[How can I add a volume to an existing Docker container?](https://stackoverflow.com/a/53516263/10651567)
Edit `/var/lib/docker/containers/99d...1fb/config.v2.json`, 
add a new volume into `"MountPoints":{}`.
And then `service docker restart`.

### Check container restart policy
[Is it possible to show the restart policy of a running Docker container?](https://stackoverflow.com/questions/43108227/is-it-possible-to-show-the-restart-policy-of-a-running-docker-container)
```sh
docker inspect -f "{{ .HostConfig.RestartPolicy }}" <container-name>
```

### Disable auto-restart container
[docker - how do you disable auto-restart on a container?](https://stackoverflow.com/questions/37599128/docker-how-do-you-disable-auto-restart-on-a-containerdocker update --restart=no)
```sh
docker update --restart=no <container-name>
```
To update all containers:
```sh
docker update --restart=no $(docker ps -a -q)
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

### Remove all exited containers
`docker ps -a | grep Exit | cut -d ' ' -f 1 | xargs docker rm`

### Rename a container
`docker rename <old-container-name> <new-container-name>`

## Docker machine

### Create a docker machine
`docker-machine create --driver virtualbox <your-vm-name>`

### List all docker machines
`docker-machine ls`

### Start a docker machine
`docker-machine start <your-vm-name>`

### Stop a docker machine
`docker-machine stop <your-vm-name>`

### Remove a docker machine
`docker-machine rm <your-vm-name>`

### Execute \<command> in \<your-vm-name>
`docker-machine ssh <your-vm-name> "<command>"`

### Copy \<filename> from local to \<your-vm-name>
`docker-machine scp <filename> <your-vm-name>:~`

### Configure \<your-vm-name>'s shell to host
`eval $(docker-machine env <your-vm-name>)`

## docker-compose

### Build containers for a service
`docker-compose up`

### Build containers for a service, specifying the yml file \<docker-compose.yml>
`docker-compose -f <docker-compose.yml> up`

### List images used by the created containers
`docker-compose images`

### Stops containers and removes containers, networks, volumes, and images created by `up`.
`docker-compose down`

### List containers
`docker-compose ps`

### Removes stopped service containers
`docker-compose rm`

### Scale docker containers
`docker-compose scale <service-name>=<num>`

## Docker swarm

### Make the host a manager
`docker swarm init` 

### Let other hosts join the swarm as a worker
```sh
docker swarm join \
>     --token SWMTKN-x-xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx-xxxxxxxxxxxxxxxxxxxxxxxxx \
>     \<manager-ip>:2377
```
This command is showed when you execute `docker swarm init` on your swarm manager, so don't worry about the token.

### (From manager host)List all nodes in swarm
`docker node ls`

### Remove a worker node
For worker node:
```sh
docker swarm leave #from swarm worker
docker node rm <NODE> #from swarm manager
```
or 
```sh
docker node rm -f <NODE> #from swarm manager
```

### Remove the last manager node
`docker swarm leave --force` success

`docker node demote <NODE>` gives "Error response from daemon: rpc error: code = 9 desc = attempting to demote the last manager of the swarm"

`docker node rm -f <NODE>` gives "Error response from daemon: rpc error: code = 9 desc = node ozsxfaadni1glz9yrl2w4o9kl is a cluster manager and is a member of the raft cluster. It must be demoted to worker before removal"

## Docker stack

### To deploy a service
`docker stack deploy -c <docker-compose.yml> <service-name>`

If you have a .env file, you may want to use the following command instead:

`docker stack deploy -c <(docker-compose config) <service-name>`

### Check the services on the swarm
`docker stack ls`

### Check the detail of the service \<service-name>
`docker stack services <service-name>`

### Check the machines running \<service-name>
`docker stack ps <service-name>`

### Remove the service \<service-name>
`docker stack rm <service-name>`


## Docker service

### List docker services
`docker service ls`

### Check the machines running \<service-name>
`docker service ps <service-name>`

### Check the detail of \<service-name> 
`docker service inspect <service-name>`

### Scale the docker service \<service-name> to \<N> replicas
`docker service scale <service-name>=<N>`

## Other commands

### Copy a file to and from a container
```sh
docker cp <file-name> <container-name>:/<file-name>
docker cp <container-name>:/<file-name> <file-name>
```

### Remove docker networks
```sh
docker network rm $(docker network ls -q)
```

### Retrieve the logs of a container
`docker logs <container-name>`

### Make a container hang around(not exit immediately)
`docker run -td --entrypoint=/bin/bash <image-name>`

## Installation

### Install docker 19.03
[NVIDIA/nvidia-docker](https://github.com/NVIDIA/nvidia-docker)

With docker 19.03 installed, then there is no need to use nvidia-docker since NVIDIA GPUs are now natively supported as devices in the Docker runtime.
```
# Add the package repositories
distribution=$(. /etc/os-release;echo $ID$VERSION_ID)
curl -s -L https://nvidia.github.io/nvidia-docker/gpgkey | sudo apt-key add -
curl -s -L https://nvidia.github.io/nvidia-docker/$distribution/nvidia-docker.list | sudo tee /etc/apt/sources.list.d/nvidia-docker.list
sudo apt-get update && sudo apt-get install -y nvidia-container-toolkit
sudo systemctl restart docker
```

### Install docker-compose
From https://docs.docker.com/compose/install/#install-compose:
```sh
# Run this command to download the latest version of Docker Compose:
# check https://github.com/docker/compose/releases to replace 1.23.1 with newest version
sudo curl -L "https://github.com/docker/compose/releases/download/1.23.1/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose

# Apply executable permissions to the binary
sudo chmod +x /usr/local/bin/docker-compose

# Test the installation
docker-compose --version
```

### Install docker-machine
```sh
# Download the Docker Machine binary and extract it to your PATH
base=https://github.com/docker/machine/releases/download/v0.16.0 &&
  curl -L $base/docker-machine-$(uname -s)-$(uname -m) >/tmp/docker-machine &&
  sudo install /tmp/docker-machine /usr/local/bin/docker-machine

# Check the installation by displaying the Machine version
docker-machine version
```

### Install VirtualBox
For Ubuntu:
```sh
apt-get install virtualbox
```

From [How To Install VirtualBox 5.2 on CentOS 7 / RHEL 7](https://www.itzgeek.com/how-tos/linux/centos-how-tos/install-virtualbox-4-3-on-centos-7-rhel-7.html).

```sh
# Install header and development tools
yum install -y kernel-devel kernel-headers gcc make perl

# Download and import the Oracle public key
yum -y install wget
wget https://www.virtualbox.org/download/oracle_vbox.asc
rpm --import oracle_vbox.asc

# Download the VirtualBox repository file for CentOS 7 / RHEL 7 and move it into /etc/yum.repos.d/ directory
wget http://download.virtualbox.org/virtualbox/rpm/el/virtualbox.repo -O /etc/yum.repos.d/virtualbox.repo

# Install VirtualBox v5.2
yum install -y VirtualBox-5.2

# Check the status of VirtualBox Linux kernel module service
systemctl status vboxdrv

# Access VirtualBox
virtualbox
```

To uninstall:
```sh
yum remove VirtualBox-<virtualbox-version>.x86_64 # For example, \<virtualbox-version> could be 5.0
```

# Nvidia docker commands

## Check nvidia docker version
```sh
nvidia-docker version
```
The first line will be NVIDIA Docker: <x.x.x>, following are the results from `docker version`

Note: Not `nvidia-docker -v` nor `nvidia-docker --version`, they will show the same result as `docker -v` and `docker --version`
