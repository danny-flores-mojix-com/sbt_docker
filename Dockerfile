FROM anapsix/alpine-java

MAINTAINER Danny Flores <danny.flores@mojix.com>

RUN apk update && apk add bash

RUN apk add --no-cache bash

RUN apk add --no-cache --virtual=build-dependencies curl

RUN SBTFILE=`curl -s https://api.github.com/repos/sbt/sbt/releases/latest | grep browser_download_url | grep 'tgz.$' |cut -d '"' -f 4` && \
    curl -sL $SBTFILE | gunzip | tar -x -C /usr/local && \
    ln -s /usr/local/sbt/bin/sbt /usr/local/bin/sbt && \
    chmod 0755 /usr/local/bin/sbt && \
    apk del build-dependencies
RUN sbt
