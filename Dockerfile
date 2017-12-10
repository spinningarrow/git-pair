FROM alpine:latest

RUN apk update
RUN apk add bash

# Runtime dependencies
RUN apk add coreutils
RUN apk add git
RUN apk add util-linux # for column

# Test dependencies
RUN apk add bats
RUN apk add expect
RUN apk add ncurses # for tput

COPY git-pair /usr/local/bin/

ENTRYPOINT ["/tests/test.bats"]
