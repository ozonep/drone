# docker build --rm -f docker/Dockerfile -t drone/drone .

FROM golang:buster as buster
ENV GOPATH /go
#RUN apk add -U --no-cache ca-certificates

COPY . ${GOPATH}/src/github.com/drone/drone
WORKDIR ${GOPATH}/src/github.com/drone/drone

RUN  chmod +x ./build.sh
RUN ./build.sh

FROM alpine:3.12 as alpine
RUN apk add -U --no-cache ca-certificates

FROM alpine:3.12
EXPOSE 80 443
VOLUME /data

RUN [ ! -e /etc/nsswitch.conf ] && echo 'hosts: files dns' > /etc/nsswitch.conf

ENV GODEBUG netdns=go
ENV XDG_CACHE_HOME /data
ENV DRONE_DATABASE_DRIVER sqlite3
ENV DRONE_DATABASE_DATASOURCE /data/database.sqlite
ENV DRONE_RUNNER_OS=linux
ENV DRONE_RUNNER_ARCH=amd64
ENV DRONE_SERVER_PORT=:80
ENV DRONE_SERVER_HOST=localhost
ENV DRONE_DATADOG_ENABLED=false

COPY --from=alpine /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/
COPY --from=buster /go/src/github.com/drone/drone/release/linux/amd64/drone-server /bin/

#ADD release/linux/amd64/drone-server /bin/
ENTRYPOINT ["/bin/drone-server"]
