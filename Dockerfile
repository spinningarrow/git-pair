FROM alpine:latest

RUN apk update
RUN apk add coreutils
RUN apk add bash
RUN apk add git
RUN apk add expect
RUN apk add util-linux

COPY git-pair /usr/local/bin/

ENTRYPOINT ["/tests/test.sh"]
