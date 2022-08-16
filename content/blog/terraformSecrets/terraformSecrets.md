---
title: "Terraform Provider Secrets with Bitwarden CLI"
date: 2022-08-14T20:50:20+01:00
draft: true
---

# Terraform Provider Secrets with Bitwarden CLI

Publishing your IAC code to the public internet can be daunting. To ensure you're doing it correctly you'll want to lock down your terraform secrets, I do it with bitwarden cli, below is a guide on how to implement it on AWS and Azure but the same logic can be used for other terraform providers.

## Secrets in Terraform 

Some of your most important secrets will be your provider secrets, these typically contain secrets used to creat or modify the infrastructure you have created. These can be accessed in a varety of differents ways but here I'll illustrate using the bitwarden cli to store the secrets in bitwarden, then pull those secrets to populate environment variables which terraform can access.

Using the bitwarden cli means your secrets are only ever stored in environment variables within your local session, this allows you to upload code publically, safe in the knowledge that your secrets are secureced by bitwarden (or another password manager).

# Examples
## bitWarden boilerplate to login

To use the bitwarden cli you will need to download and install the cli. Instructuctions for this differ based on your operating system but further instructions can be found [here](https://bitwarden.com/help/cli/#download-and-install)

Once installed you will need to login with

``` sh
bw login
```
After logging in you can then create a new script file to source with the below boilerplate code to unlock your bitwarden account to pull secrets as in the examples below. 

``` sh
export BW_SESSION=$(bw unlock --raw)

bw sync
```


## Provider Examples

When you create a secret that you want to later access via the bw cli

![example of bitwarden key](/blog/terraformSecrets/bitwardenKey.png#center)

### AWS

``` sh
export AWS_ACCESS_KEY_ID=$(bw get password aws-terraform-keyid --session $BW_SESSION)
export AWS_SECRET_ACCESS_KEY=$(bw get password aws-terraform-accesskey --session $BW_SESSION)
```

### Azure

``` sh
export ARM_CLIENT_ID=$(bw get password azure-terraform-clientid --session $BW_SESSION)
export ARM_CLIENT_SECRET=$(bw get password azure-terraform-clientSecret --session $BW_SESSION)
export ARM_SUBSCRIPTION_ID=$(bw get password azure-terraform-subscriptionid --session $BW_SESSION)
export ARM_TENANT_ID=$(bw get password azure-terraform-tenantid --session $BW_SESSION)
```

## Full Example - in prepareEnv.sh


``` sh
export BW_SESSION=$(bw unlock --raw)

bw sync

export AWS_ACCESS_KEY_ID=$(bw get password aws-terraform-keyid --session $BW_SESSION)
export AWS_SECRET_ACCESS_KEY=$(bw get password aws-terraform-accesskey --session $BW_SESSION)
```

To use the above, source the script with `source prepareEnv.sh`, this will request you to login then add the envrironemnt variable to your current shell. After this you can use terraform as usual with `terraform apply` without needing to supply any aws credentials.