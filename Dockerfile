FROM alpine:latest

LABEL author="XternA"
LABEL description="Unofficial docker image of Spide Network."

RUN apk update; apk add --no-cache curl unzip ca-certificates
RUN rm -rf /etc/machine-id

WORKDIR /app

ADD https://config-alpha-01.sgp1.digitaloceanspaces.com/spide_linux_cli.zip /app
RUN unzip spide_linux_cli.zip; rm -rf spide_linux_cli.zip; mv spide_cli/spide .; rm -rf spide_cli

CMD if [ ! -f /etc/machine-id ]; then \
        if [ -n "$ID" ]; then \
            echo "$ID" > /etc/machine-id; \
        else \
            cat /dev/urandom | LC_ALL=C tr -dc 'a-f0-9' | dd bs=1 count=32 2>/dev/null > /etc/machine-id; \
        fi; \
    fi; \
    printf "[ USE MACHINE ID BELOW TO REUSE SAME DEVICE - DEVICE KEY FOR DEVICE REGISTRATION ]\nMachine ID: $(cat /etc/machine-id)\n\n"; \
    ./spide
