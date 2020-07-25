certbot
=======

## 1. Overview
| Plugin       | Authenticator | Installer | Notes                                                                                                                                                                                                                                | Challenge types (and port)  |
|--------------|:-------------:|:---------:|--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|-----------------------------|
| apache       |       Y       |     Y     | Automates obtaining and installing a certificate with Apache.                                                                                                                                                                        | http-01 (80)                |
| nginx        |       Y       |     Y     | Automates obtaining and installing a certificate with Nginx.                                                                                                                                                                         | http-01 (80)                |
| webroot      |       Y       |     N     | Obtains a certificate by writing to the webroot directory of an already running webserver.                                                                                                                                           | http-01 (80)                |
| standalone   |       Y       |     N     | Uses a “standalone” webserver to obtain a certificate. Requires port 80 to be available. This is useful on systems with no webserver, or when direct integration with the local webserver is not supported or not desired.           | http-01 (80)                |
| DNS plugins* |       Y       |     N     | This category of plugins automates obtaining a certificate by modifying DNS records to prove you have control over a domain. Doing domain validation in this way is the only way to obtain wildcard certificates from Let’s Encrypt. | dns-01 (53)                 |
| manual       |       Y       |     N     | Helps you obtain a certificate by giving you instructions to perform domain validation yourself. Additionally allows you to specify scripts to automate the validation task in a customized way.                                     | http-01 (80) or dns-01 (53) |

[DNS Plugins*](https://certbot.eff.org/docs/using.html#dns-plugins):
* [certbot-dns-cloudflare](https://certbot-dns-cloudflare.readthedocs.io/)
* [certbot-dns-cloudxns](https://certbot-dns-cloudxns.readthedocs.io/)
* [certbot-dns-digitalocean](https://certbot-dns-digitalocean.readthedocs.io/)
* [certbot-dns-dnsimple](https://certbot-dns-dnsimple.readthedocs.io/)
* [certbot-dns-dnsmadeeasy](https://certbot-dns-dnsmadeeasy.readthedocs.io/)
* [certbot-dns-google](https://certbot-dns-google.readthedocs.io/)
* [certbot-dns-linode](https://certbot-dns-linode.readthedocs.io/)
* [certbot-dns-luadns](https://certbot-dns-luadns.readthedocs.io/)
* [certbot-dns-nsone](https://certbot-dns-nsone.readthedocs.io/)
* [certbot-dns-ovh](https://certbot-dns-ovh.readthedocs.io/)
* [certbot-dns-rfc2136](https://certbot-dns-rfc2136.readthedocs.io/)
* [certbot-dns-route53](https://certbot-dns-route53.readthedocs.io/)

## 2. Generate Wildcard SSL certificate using Let’s Encrypt/Certbot
## 2.1 Manual Authenticator
```bash
certbot certonly \
  --manual \
  --preferred-challenges dns \
  --manual-public-ip-logging-ok \
  --agree-tos \
  --email devops@dungdm93.me \
  -d '*.example.com'
```

After executing the above command, the Certbot will share a text record to add to your DNS.
```log
Please deploy a DNS TXT record under the name
_acme-challenge.example.com with the following value:

J_POuY6GAI5e_XXXXXXXXXXXXXXXXXXXXXXXXXXXXXX

Before continuing, verify the record is deployed.
```

The bigest issue of this method is **NO auto-review**.

## 2.2 DNS plugins Authenticator (e.g Cloudflare)
1. Install `certbot-dns-cloudflare`
    ```bash
    apt install python3-certbot-dns-cloudflare
    # or
    dnf install python3-certbot-dns-cloudflare
    # or
    pip install certbot-dns-cloudflare
    ```

2. Create Cloudflare credentials file `/etc/letsencrypt/cloudflare.ini`:
    ```ini
    # Cloudflare API token used by Certbot
    dns_cloudflare_api_token = 0123456789abcdef0123456789abcdef01234567
    ```
    Note: change file owner & permissions:
    ```bash
    chown root: cloudflare.ini
    chmod 600   cloudflare.ini
    ```

3. Issue certificate
    ```bash
    certbot certonly \
      --dns-cloudflare \
      --dns-cloudflare-credentials /etc/letsencrypt/cloudflare.ini \
      --agree-tos \
      --email devops@dungdm93.me \
      -d '*.example.com'
    ```

## 3. Renewing certificates
## 3.1 Auto-renew
`certbot` included `systemd-timer` unit run twice daily in order to renew all previously obtained certificates that are near expiry.

```bash
systemctl list-timers
systemctl status certbot.timer
```

## 3.1 Hooks
All renew hooks are placed at `/etc/letsencrypt/renewal-hooks/`, eg:
```bash
#!/bin/bash
# /etc/letsencrypt/renewal-hooks/deploy/restart-nginx.sh
service nginx restart
```
