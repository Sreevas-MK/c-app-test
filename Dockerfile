FROM alpine:latest As stage1

RUN mkdir /var/application

WORKDIR /var/application

COPY app.c .

RUN apk update && apk add gcc musl-dev --no-cache

RUN gcc app.c -o app



FROM alpine:latest

RUN mkdir /var/application

WORKDIR /var/application

COPY --from=stage1 /var/application/app .

RUN adduser -h /var/application -s /bin/sh -H c-user

RUN chown -R c-user:c-user /var/application

USER c-user

CMD ["./app"]

