# piping-server-onion-service

[Piping Server](https://github.com/nwtgck/piping-server) as Onion Service

## Onion Service

<http://vpt6lzjiuqd6ntjxsc655x2zlddvg4pobvhio7j5jksyshn5eia7umad.onion>

## Server setup

If you fork the Replit, you need to set `HS_ED25519_SECRET_KEY_BASE64` environment variable in Replit secrets. The value is:

```bash
cat /home/runner/psuedo_root/var/lib/tor/hidden_service/hs_ed25519_secret_key | base64
```

### hostname

```bash
cat /home/runner/psuedo_root/var/lib/tor/hidden_service/hostname
```
