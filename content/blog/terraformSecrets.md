---
title: "Terraform Provider Secrets with Bitwarden CLI"
date: 2022-08-14T20:50:20+01:00
draft: true
---

Publishing your IAC code to the public internet can be daunting. To ensure you're doing it correctly you'll want to lock down your terraform secrets, I do it with bitwarden cli, maybe you want to do something similar?

## Secrets in Terraform 

The majority of your most important secrets will be your provider secrets, these typically contain secrets used to creat or modify the infrastructure you have created. These can be done in a varety of differents ways but here I'll illustrate using the bitwarden cli to store the secrets in bitwarden, then pull those secrets to populate environment variables which terraform can access.

# Install bitwarden cli

# bitWarden boiler plate to get login creds

``` sh
export BW_SESSION=$(bw unlock --raw)

bw sync
```


## TLDR Examples



### AWS

```

```

### Azure


### GCP