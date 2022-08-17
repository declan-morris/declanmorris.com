---
title: "Terraform Provider Secrets with Bitwarden CLI"
description: Getting terraform provider secrets securely with bitwarden CLI
date: 2022-08-14T20:50:20+01:00
draft: false
tags:
- terraform
- bitwarden
- iac
---

# Terraform Provider Secrets with Bitwarden CLI

Publishing your IAC code to the public internet can be daunting. To ensure you're doing it correctly you'll want to lock down your terraform secrets, I do it with bitwarden cli, below is a guide on how to implement it on AWS and Azure but the same logic can be used for other terraform providers.

## Secrets in Terraform 

Some of your most important secrets will be your provider secrets, these typically contain secrets used to create or modify the infrastructure you have created. These can be accessed in a variety of different ways but here I'll illustrate using the bitwarden cli to store the secrets in bitwarden, then pull those secrets to populate environment variables which terraform can access.

Using the bitwarden cli means your secrets are only ever stored in environment variables within your local session, this allows you to upload code publicly, safe in the knowledge that your secrets are secured by bitwarden (or another password manager).

## bitWarden login and boilerplate sync

To use the bitwarden cli you will need to download and install the cli. Instructions for this differ based on your operating system but further instructions can be found [here](https://bitwarden.com/help/cli/#download-and-install)

Once installed you will need to login with

``` bash
bw login
```
After logging in you can then create a new script file to source with the below boilerplate code to unlock your bitwarden account to pull secrets as in the examples below. 

``` bash
export BW_SESSION=$(bw unlock --raw)

bw sync
```


## Provider Examples

Create a secret that you want to later access via the bw cli

![example of bitwarden key](bitwardenKey.png#center)

### AWS

``` bash
export AWS_ACCESS_KEY_ID=$(bw get password aws-terraform-keyid --session $BW_SESSION)
export AWS_SECRET_ACCESS_KEY=$(bw get password aws-terraform-accesskey --session $BW_SESSION)
```

### Azure

``` bash
export ARM_CLIENT_ID=$(bw get password azure-terraform-clientid --session $BW_SESSION)
export ARM_CLIENT_SECRET=$(bw get password azure-terraform-clientSecret --session $BW_SESSION)
export ARM_SUBSCRIPTION_ID=$(bw get password azure-terraform-subscriptionid --session $BW_SESSION)
export ARM_TENANT_ID=$(bw get password azure-terraform-tenantid --session $BW_SESSION)
```

## Creating and sourcing the script

You can of course just execute these commands in the current window to populate these variables before you start coding, however if you want to streamline the process yous should save the boilerplate as well as any provider secrets you want to pull in a script that that be sourced before you start development. 

Below is an example that can be saved as `prepareEnv.sh`.


``` bash
export BW_SESSION=$(bw unlock --raw)

bw sync

export AWS_ACCESS_KEY_ID=$(bw get password aws-terraform-keyid --session $BW_SESSION)
export AWS_SECRET_ACCESS_KEY=$(bw get password aws-terraform-accesskey --session $BW_SESSION)
```

To use the above, source the script with `source prepareEnv.sh`, this will request you to login then add the environment variable to your current shell. After this you can use terraform as usual with `terraform apply` without needing to supply any aws credentials.

You can check that the variables have been exported to the current shell by executing `echo $AWS_ACCESS_KEY_ID`. This should print out the value you have saved as a secret in bitwarden under the login of `aws-terraform-keyid`.