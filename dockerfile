FROM alpine:latest

LABEL author="XternA"
LABEL description="Unofficial docker image of Spide Network."

RUN apk update; apk add --no-cache curl unzip ca-certificates
RUN touch /etc/machine-id

WORKDIR /app

ADD https://config-alpha-01.sgp1.digitaloceanspaces.com/spide_linux_cli.zip /app
RUN unzip spide_linux_cli.zip;  rm -rf spide_linux_cli.zip
RUN mv spide_cli/spide .; rm -rf spide_cli

CMD ["./spide"]
