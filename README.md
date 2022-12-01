# Docker Loxone backup

Docker image for automated [Loxone](https://www.loxone.com/) backups.

## Information

| Service                                                     | Stats                                                                                                                                                                                                                                                                                                               |
|-------------------------------------------------------------|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| [GitHub](https://github.com/jokay/docker-loxone-backup)     | ![Last commit](https://img.shields.io/github/last-commit/jokay/docker-loxone-backup.svg?style=flat-square) ![Issues](https://img.shields.io/github/issues-raw/jokay/docker-loxone-backup.svg?style=flat-square) ![PR](https://img.shields.io/github/issues-pr-raw/jokay/docker-loxone-backup.svg?style=flat-square) |
| [Docker Hub](https://hub.docker.com/r/xjokay/loxone-backup) | ![Pulls](https://img.shields.io/docker/pulls/xjokay/loxone-backup.svg?style=flat-square) ![Stars](https://img.shields.io/docker/stars/xjokay/loxone-backup.svg?style=flat-square)                                                                                                                                   |

## Usage

```sh
docker pull docker.io/xjokay/loxone-backup:latest
```

### Supported tags

| Tag       | Description                                                                                                |
|-----------|------------------------------------------------------------------------------------------------------------|
| latest    | [Latest](https://github.com/jokay/docker-loxone-backup/releases/latest) release                            |
| {release} | Specific release version, see available [releases](https://github.com/jokay/docker-loxone-backup/releases) |

### Exposed Ports

None

### Volumes

| Directory | Description             |
|-----------|-------------------------|
| /data     | Location of the backups |

### Configuration

These environment variables must be set for the first start:

| ENV field       | Req. / Opt.  | Description                                            |
|-----------------|--------------|--------------------------------------------------------|
| LOXONE_IP       | **Required** | IP address of the Loxone Miniserver.                   |
| LOXONE_USERNAME | **Required** | Loxone username.                                       |
| LOXONE_PASSWORD | **Required** | Loxone password.                                       |
| INTERVAL        | *Optional*   | Interval of backups, default is `86400` seconds (24h). |
| BACKUP_LIMIT    | *Optional*   | Number of backups to keep, default is `30`.            |

## Samples

### docker-compose

```yml
services:
  app:
    image: docker.io/xjokay/loxone-backup:latest
    volumes:
      - ./data:/data
    environment:
      - TZ=Europe/Zurich
      - LOXONE_IP=192.168.1.10
      - LOXONE_USERNAME={loxone-username}
      - LOXONE_PASSWORD={loxone-password}
    networks:
      - default
```

### docker run

```sh
docker run -d \
  -v $PWD/data:/data \
  -e TZ=Europe/Zurich \
  -e LOXONE_IP=192.168.1.10 \
  -e LOXONE_USERNAME={loxone-username} \
  -e LOXONE_PASSWORD={loxone-password} \
  docker.io/xjokay/loxone-backup:latest
```
