FROM alpine:latest

RUN mkdir /var/application

RUN adduser -h /var/application -s /bin/sh -H c-user

WORKDIR /var/application

COPY app.c .

RUN apk update && apk add gcc musl-dev --no-cache

RUN gcc app.c -o app

RUN chown -R c-user:c-user /var/application

USER c-user

CMD ["./app"]

