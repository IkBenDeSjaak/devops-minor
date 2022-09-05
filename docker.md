# Docker

## General information

Docker vs Virtual Machine: Bij virtual machine zit ook nog het GuestOS erin.

### Containers vs Images

#### Verschillen

- Container is een instantie van de image.
- Image is immutable
- Container heeft rights to write to file system

### Containers

- Single proces
- Blijft runnen

#### Container isolation

- Seperated file system
- Seperated processes
- Seperated networking

### Images

#### Image contents

- OS Disk (bestanden die het de kenmerken geeft van dat operating system)
- Application code
- Dependencies
- Ports
- Generieke configuratie

#### Image layering

Een image is gebaseerd op een andere image.
Voorbeeld layers: Ubuntu => JDK => Tomcat (applicatie container) => App

#### Reduce image layers

When using `apt-get install` finish with `rm -rf /var/lib/apt/lists*` in a single run.

For example: `RUN apt-get update && apt-get install -y curl && rm -rf /var/lib/apt/lists*`.

Things that change often you should put at the end of the Dockerfile.

### Volumes

Hiermee kun je data behouden op je file system.

#### Bind mount

- `--mount type=bind,source=C:/Users/me/Documents,target=/me`

#### Named volumes

Run a container with a named volume.

- `docker container run -it --mount type=volume,source=myvolume,target/mydata --name whatever busybox`

### Users

Geef alleen users bepaalde permissions in container.

```Docker
FROM UBUNTU
RUN useradd -ms /bin/bash --uid 1542 someuser
USER someuser
```

## Commands

### General commands

- `docker inspect <NAME-OF-CONTAINER>`: Get JSON information about a container.

### Container

- `docker container run -it <NAME-OF-IMAGE>`: Run container in interactive terminal.
- `docker container run --name <NEW-NAME> -p 8080:80 <NAME-OF-IMAGE>`: Run container in foreground which you can access on localhost:8080. The container has TCP port 80 internal. Of `-P` voor automatische forwarding.
- `docker container ls`: List running containers.
- `docker container run -d <NAME-OF-IMAGE>`: Run container in background.
- `docker container exec -it <NAME-OF-CONTAINER> /bin/sh`: Start shell in interactive terminal in container.
- `docker container logs <NAME-OF-CONTAINER>`: Run container in interactive terminal.
- `docker container rm <NAME-OF-CONTAINER>`: Delete the container.

### Image

- `docker image ls`: List images.
- `docker image rm`: Remove images.
- `docker image saved`: Export image to tar file.
- `docker container commit <NAME-OF-CONTAINER> <NEW-IMAGE-NAME>`: Create new image based on running container.
- `docker image history <NEW-IMAGE-NAME>`: See what's in the image layers.
- `docker image build -t <NEW-IMAGE-NAME> .`: Build new docker image. The `.` represents the current location.
- `docker image tag <LOCAL-IMAGE> <USERNAME/IMAGE:VERSION>`: Tag a docker image.
- `docker image push <USERNAME/IMAGE:VERSION>`: Push image to registry.

### Volume

- `docker volume ls`: List all volumes.
- `docker volume create <NAME>`: Create a volume with a name.

### Compose

- `docker compose up`: Make the containers running from the compose file.
- `docker compose stop`: Stop all the containers running from the compose file.

## Dockerfile

- FROM: The base image.
- LABEL: Used to set metadata.
- ARG: Used for build time variables `--build-arg`.
- RUN: Execute a command.
`RUN <Command>`: Command is executed using shell.
`RUN ['command', 'param1']`: Command is directly executed without shell.
- COPY: Copies files from context to the specified location inside container.
- ADD: Copies files from context to the specified location inside container. Allows source to be a URL.
- EXPOSE: This is metadata. Used to inform docker daemon that this container will listen to specified ports.
- HEALTHCHECK: Used to mark container as healthy. Healthy is `exit code 0`.
- CMD: Process that starts the container. Not executed during image build.
- ENTRYPOINT: Concatenated with CMD to create instruction that is executed.
- ENV: Set environment variable.

## Docker compose

Docker Compose is een container orchestratie tool.
