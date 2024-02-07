# Spide Network Docker

### Containerised docker image for Spide Network

>**Note:** This is an unofficial build and comes with no warranty of any kind. By using this image you also agree to [Spide Network's terms and conditions](https://spide.network/terms-of-use.html).

The aim is to containerise the standard Linux CLI version of the binary into a dockerised container.

## Prerequisite
This section only applies to running on **`ARM`** platforms as the image and its underlying binary are originally compiled for **`x86_64`** (64-Bit) Intel/AMD-based architectures.

To run the docker image on ARM platforms such as Raspberry Pi, it needs to run on an emulation layer.

```yaml
sudo docker run --privileged --rm tonistiigi/binfmt --install all
```
Now the non-native docker image will run, which previously wouldn't without enabling the emulation layer first.

The downside to the command above is that on restart, it needs to be enabled again. Therefore, a permanent solution is to have it auto-start as a service.
```groovy
sudo cp docker.binfmt.service /etc/systemd/system
sudo systemctl enable docker.binfmt.service
sudo systemctl start docker.binfmt.service
```

This should now work on **`ARM`** platforms such as **`arm64`**, **`arm64v8`**, **`arm32v7`**, `**aarch64**`.

Alternatively, if sticking to the first option, cron is also another option to ensure it gets started on reboot by putting an entry into crontab.
```yaml
@reboot docker run --privileged --rm tonistiigi/binfmt --install all
```
or via (only adding x86_64)
```yaml
@reboot docker run --rm --privileged aptman/qus -s -- -p x86_64
```

## Run Usage
#### Docker Compose
Via `compose.yml`
```yaml
version: '3'

services:
  spide:
    container_name: spide
    image: xterna/spide-network
    restart: unless-stopped
    platform: linux/amd64
    dns:
        - 1.1.1.1
        - 8.8.8.8
```
```yaml
docker compose up -d
```

#### Docker run
```yaml
docker run -d --restart unless-stopped --name spide xterna/spide-network
```
This will start the application in the background. The alias assigned is `spide`.

## Register device
The device running the Spide application will need to be registered in the dashboard for the device to be linked to your earning account.

To get the device key, you need to run the docker logs command to find the key for registering.

```yaml
docker logs spide
```
```groovy
2024/02/07 00:34:47 Build version: 2022-07-12_11:08:44AM-LINUX
2024/02/07 00:34:47 ENV: prod
2024/02/07 00:34:47 Device Key:  c253589lk23j523jkhasf904124kj1as8512972215kljasd04asd9085124as3r
2024/02/07 00:34:48 get url https://config-alpha-01.sgp1.digitaloceanspaces.com/client_config_prod_v0.1.json content length 517
2024/02/07 00:34:48 Client version:  14
2024/02/07 00:34:48 connect to server 159.223.219.217:50001
2024/02/07 00:34:48 Status: OK
```
If for any reason you can't locate the key, stop the container and start it again. Give it a second or two before fetching the logs again.
```yaml
docker stop spide; docker start spide
```
### Spide Dashboard
Register for an account if you haven't [**here**](https://spide.network/register.html?c315ee).
>You will benefit from **$5** using my link to sign up.

Once you have an account head over to the [**dashboard**](https://spide.network/network.html), locate **`Register Device`** to register.

![image](https://github.com/XternA/spide-network/assets/9136075/834613f2-4eb6-45d7-8789-b84a197a8dda)

Give it a name for easy recognition and put in the device key that was obtained from the logs earlier.

## Like my work?
Donations are warmly welcomed and thank you very much. 😌
- **BTC:** bc1qq993w3mxsf5aph5c362wjv3zaegk37tcvw7rl4
- **ETH:** 0x2601B9940F9594810DEDC44015491f0f9D6Dd1cA
- **PayPal:** [@**xterna**](https://paypal.me/xterna)
