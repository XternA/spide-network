# Spide Network Docker
#### If you like this project, don't forget to leave a star. ⭐

### Containerised docker image for [Spide Network](https://spide.network/register.html?c315ee)

>**Note:** This is an unofficial build and comes with no warranty of any kind. By using this image you also agree to [Spide Network's terms and conditions](https://spide.network/terms-of-use.html).

The aim is to containerise the standard Linux CLI version of the binary into a dockerised container.

> This docker image comes pre-bundled with [**Income Generator**](https://github.com/XternA/income-generator). A tool which consolidates and earns passive income from multiple sources.

## For ARM Platforms Only
This section only applies to running on **`ARM`** platforms as the image and its underlying binary are originally compiled for **`x86_64`** (64-bit) Intel/AMD-based architectures.

To run the docker image on ARM platforms such as Raspberry Pi, it needs to run on an emulation layer.

```yaml
docker run --rm --privileged aptman/qus -s -- -p x86_64
```

However, on reboot, the emulation must be re-enabled again. Therefore, cron can be used so that the cron scheduler will start the emulation on reboot.

```yaml
sudo crontab -e
```

Then add the entry and that's it.

```yaml
@reboot docker run --privileged --rm tonistiigi/binfmt --install all
```
or via (only adding x86_64)
```yaml
@reboot docker run --rm --privileged aptman/qus -s -- -p x86_64
```

The non-native docker image will now run on **`ARM`** platforms such as **`arm64`**, **`arm64v8`**, **`arm32v7`**, **`aarch64`** which previously wouldn't without first enabling the emulation layer.

## Run Usage
### Docker Compose
Via `compose.yml`
```yaml
services:
  spide:
    container_name: spide
    image: xterna/spide-network
    restart: unless-stopped
    dns:
        - 1.1.1.1
        - 8.8.8.8
```
If want to re-use an existing device key registration, obtain the machine ID from the logs first. Define an environment argument.

Using the machine ID will be able to revive the same `Device Key`.
```yaml
services:
  spide:
    container_name: spide
    image: xterna/spide-network
    restart: unless-stopped
    environment:
      - ID=<machine-id>
    dns:
        - 1.1.1.1
        - 8.8.8.8
```
```yaml
docker compose up -d
```

### Docker run
```yaml
docker run -d --restart unless-stopped --name spide xterna/spide-network
```
If want to reuse an existing device with its associated device key registered, use the machine ID from the logs to load an existing device on a new container.
```yaml
docker run -d --restart unless-stopped --name spide -e ID=<machine-id> xterna/spide-network
```

This will start the application in the background. The alias assigned is `spide`.

## Register device
The device running the Spide application will need to be registered in the dashboard for the device to be linked to your earning account.

### Device Key
To get the device key, you need to run the docker logs command to find the key for registering.

```yaml
docker logs spide
```
```
[ USE MACHINE ID BELOW TO REUSE SAME DEVICE - DEVICE KEY FOR DEVICE REGISTRATION ]
Machine ID: 80838d00ba2331a6da3e007c15c97699

2024/02/07 00:34:47 Build version: 2022-07-12_11:08:44AM-LINUX
2024/02/07 00:34:47 ENV: prod
2024/02/07 00:34:47 Device Key:  c253589lk23j523jkhasf904124kj1as8512972215kljasd04asd9085124as3r
2024/02/07 00:34:48 get url https://config-alpha-01.sgp1.digitaloceanspaces.com/client_config_prod_v0.1.json content length 517
2024/02/07 00:34:48 Client version:  14
2024/02/07 00:34:48 connect to server 159.223.219.217:50001
2024/02/07 00:34:48 Status: OK
```

To just get the device key
```yaml
docker logs spide-test 2>&1 | grep "Device Key"
```
```
2024/02/07 00:34:47 Device Key:  c253589lk23j523jkhasf904124kj1as8512972215kljasd04asd9085124as3r
```

### Machine ID
Unlike the `Device Key`, the machine ID is used to generate the device key. You can keep regenerating the same device key so long as you have the matching machine ID. You can't go the other away around.

⚠️ This is important because once the `Device Key` is registered on Spide in your account, you can't change, de-register or re-register.

Obtaining the machine ID can be done via the top of the logs or by running the following command to filter to just the ID.

```yaml
docker logs spide-test 2>&1 | grep "Machine ID"
```
Then use the machine ID to redeploy the container with the `-e ID<machine-id>` argument.
```yaml
Machine ID: 80838d00ba2331a6da3e007c15c97699
```
Lose track of the machine ID and you can no longer regenerate the same `Device Key` associated with a particular device registered on Spide.

### Restarting
If for any reason you can't locate the key, restart the container. Give it a second or two before fetching the logs again.
```yaml
docker restart spide
```
### Spide Dashboard
Register for an account if you haven't [**here**](https://spide.network/register.html?c315ee).
>You will benefit from **$5** added to your account using my link to sign up.

Once you have an account head over to the [**dashboard**](https://spide.network/network.html), locate **`Register Device`** to register.

![image](https://github.com/XternA/spide-network/assets/9136075/834613f2-4eb6-45d7-8789-b84a197a8dda)

Give it a name for easy recognition and put in the device key that was obtained from the logs earlier.

## Like my work?
Donations are warmly welcomed no matter how small and thank you very much. 😌
- **Bitcoin (BTC)** - `bc1qq993w3mxsf5aph5c362wjv3zaegk37tcvw7rl4`
- **Ethereum (ETH)** - `0x2601B9940F9594810DEDC44015491f0f9D6Dd1cA`
- **Binance (BNB)** - `bnb1dj3l3fp24z05vtwtjpaatjyz9sll4elu9lkjww`
- **Binance Smart Chain (BSC)** - `0x2601B9940F9594810DEDC44015491f0f9D6Dd1cA`
- **Solana (SOL)** - `Ap5aiAbnsLtR2XVJB3sp37qdNP5VfqydAgUThvdEiL5i`
- **PayPal** - [@xterna](https://paypal.me/xterna)
