FROM golang:buster as buster
ENV GOPATH /go
COPY . ${GOPATH}/src/github.com/ozonep/drone
WORKDIR ${GOPATH}/src/github.com/ozonep/drone
RUN chmod +x ./build.sh
RUN ./build.sh

FROM stefanprodan/alpine-base:latest
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
COPY --from=buster /go/src/github.com/ozonep/drone/release/linux/amd64/drone-server /bin/
ENTRYPOINT ["/bin/drone-server"]

