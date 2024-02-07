FROM ubuntu:rolling

LABEL auther="XternA"
LABEL description="Unofficial docker image of Spide Network."

RUN apt update; \
    apt install curl unzip ca-certificates -y

WORKDIR /app

ADD https://config-alpha-01.sgp1.digitaloceanspaces.com/spide_linux_cli.zip /app
RUN unzip spide_linux_cli.zip; rm -rf spide_linux_cli.zip
RUN mv spide_cli/spide .; rm -rf spide_cli

CMD ["./spide"]
