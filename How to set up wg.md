### Download wiregaurd

## **1. Download and Install WireGuard**

- On Linux, install using your package manager:

```bash
sudo apt update
sudo apt install wireguard
```

For Windows or Mac, download the installer from the official WireGuard website and follow the prompts[1](https://www.wireguard.com/quickstart/)[2](https://www.tangramvision.com/blog/what-they-dont-tell-you-about-setting-up-a-wireguard-vpn).

## **2. Generate Keys**

- On both server and client, generate a private and public key pair:

```bash
wg genkey | tee privatekey | wg pubkey > publickey
```


## **3. Create the Server Configuration (`wg0.conf`)**

- Place your config file in `/etc/wireguard/wg0.conf` (Linux) or use the `WireGuard` app on Windows/Mac.
- Example server config

```bash
[Interface]
Address = 10.0.0.1/24
ListenPort = 51820
PrivateKey = <server_private_key>

[Peer]
PublicKey = <client_public_key>
AllowedIPs = 10.0.0.2/32
```


Then add the actual keys 

## **5. Exchange Keys and Add Peer Sections**

- On the server, add a `[Peer]` section for each client using their public key and assign a unique IP
- On the client, add the server’s public key and endpoint.


## **6. Start the WireGuard Interface**

- On Linux, use:

```bash
sudo wg-quick up wg0
```

To stop:

```bash
sudo wg-quick down wg0
```

## **8. Verify Connection**

- Check status with:

```bash
sudo wg
```


**Summary:**

- Install WireGuard.
- Generate keys on both server and client.
- Create and exchange config files, adding each peer’s public key to the other’s config.
- Start the interface and ensure firewall/port forwarding is set.
- Use `wg` or the GUI to verify the tunnel is up

