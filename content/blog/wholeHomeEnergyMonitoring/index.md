---
title: "UK whole home energy monitoring with Bright"
description: Getting terraform provider secrets securely with bitwarden CLI
date: 2022-09-11
draft: false
tags:
- energy monitoring
- energy crisis
- homeassistant
---

## UK whole home energy monitoring with Bright/Hildebrand glow/Glowmarkt

With the current energy prices in the UK increasing on an almost exponential level, I, like probably quite a few of you decided the more I know the better.

To get whole home monitoring you can use guides for CT clamps in your mains fuse box. A small device will then monitor the energy on one of the main circuits in your home. Doing this is quite involved and requires purchasing extra equipment and working with/near mains electricity.  An alternative available to some of us in the UK is to request a copy of the data that is sent to the electricity suppliers via the in home display/smart meters deployed in our homes.

To do this you can sign up with Hildebrand Glow/Bright/Glowmarkt (their company naming is confusing, I'll be calling them Bright as it's shorter and easier). Essentially you agree to send Bright your data via your Smart Meter, and then you can also request a copy of this data for yourself once they have a copy. Bright can request this data as they're registered SECA (Smart Energy Code Administrator) in the UK. We as individuals are not registered so we have to jump through hoops. It's annoying roundabout to get your own data in your own systems but Bright currently offer the easiest way to do this.

## Signing up with Bright

Download the Bright App on from [google play](https://play.google.com/store/apps/details?id=uk.co.hildebrand.brightionic) or [apple](https://apps.apple.com/us/app/bright/id1369989022) store.

You will need to set up your smart meter. This can be done using their chat like setup seen below, follow the instructions provided you'll need to enter your postcode and the device id. Mine was on the back of my in home display hidden behind an attached stand.

Once the setup in the application is complete, you should be able to see you data in the app, some people reported the data going back to their smart meter install but mine only shows from when I associated with Bright.

Home Screen
![Bright Home Screen](BrightHomeScreen.png?w=10)
{{ $image := .Resources.GetMatch "BrightHomeScreen.png" }}
{{ $image := $image.Resize "600x" }}
<img src="{{ $image.RelPermalink }}" width="{{ $image.Width }}" height="{{ $image.Height }}">