# piping-server-onion-service-replit

[Piping Server](https://github.com/nwtgck/piping-server) as Onion Service

## How to self host on Replit

1. Go to <https://replit.com/@nwtgck/piping-server-onion-service>
1. Click <kbd>Fork</kbd> button
1. Run <kbd>Start</kbd> button on the top


### hostname

You can see .onion hostname as follows.

```bash
cat /home/runner/psuedo_root/var/lib/tor/hidden_service/hostname
```


## Host persistency

Set `HS_ED25519_SECRET_KEY_BASE64` environment variable in the Replit secrets for hostname persistency. The value is:

```bash
cat /home/runner/psuedo_root/var/lib/tor/hidden_service/hs_ed25519_secret_key | base64
```

## Waking up server

You can access to `https://<your replit name>.<your user name>.repl.co` to wake up server. In the original Replit case, the URL is `https://piping-server-onion-service.nwtgck.repl.co`.

You can also use "Always Boot" feature in Replit.

## Onion Service

<http://vpt6lzjiuqd6ntjxsc655x2zlddvg4pobvhio7j5jksyshn5eia7umad.onion>
