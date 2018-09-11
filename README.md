# alpine-cloud9

Dockerfile for cloud9

## Build Command

```
docker build -t alpine-cloud9 .
```

## Run Command

### Default

By default, username is `user`, password is `pass`

```
docker run --rm -d -v /path/to/workspace:/workspace -p 8080:8080 alpine-cloud9
```

### When setting Username/Password

```
docker run --rm -d -v /path/to/workspace:/workspace -p 8080:8080 -e USERNAME=user -e PASSWORD=pass alpine-cloud9
```

### When use docker-compose

First, please edit docker-compose.yml

```
docker-compose build
docker-compose up -d
```