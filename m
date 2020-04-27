Return-Path: <b.a.t.m.a.n-bounces@lists.open-mesh.org>
From: Sven Eckelmann <sven@narfation.org>
Subject: Re: configuration issue
Date: Mon, 27 Apr 2020 17:27:30 +0200
Message-ID: <1684592.5WYlJ4OYfx@bentobox>
In-Reply-To: <CANKYHpeiWj7w2KEnkEfjUHWKfbhEAj7kMVE5hL5xv6O_1ZVFwg@mail.gmail.com>
References: <CANKYHpeiWj7w2KEnkEfjUHWKfbhEAj7kMVE5hL5xv6O_1ZVFwg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3756528.ibSLklOHiU"; micalg="pgp-sha512"; protocol="application/pgp-signature"
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n.lists.open-mesh.org>
List-Archive: <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Oguzhan Kayhan <oguzhan@kayhan.name.tr>

 
--nextPart3756528.ibSLklOHiU
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Monday, 27 April 2020 14:26:40 CEST Oguzhan Kayhan wrote:
> Hello
> I am running batman over a openwrt 18.06
> default batman config over this firmware is batman-adv 2017.4

This is odd. 18.06 is using batman-adv 2018.1 (2018.1-11 at the moment). 
Sounds like something went wrong with your routing feed.


[...]
> config wifi-iface
>         option device 'radio0'
>         option ifname 'mesh0'
>         option network 'mesh'
>         option mode 'adhoc'
>         option ssid 'mesh'
>         option bssid '02:CA:FE:CA:CA:40'
>         option mcast_rate '18000'
[...]

Please think about switching to meshpoint without forwarding.

    config wifi-iface 'wmesh'
        option device 'radio0'
        option ifname 'mesh0'
        option network 'bat0_hardif_mesh0'
        option mode 'mesh'
        option mesh_id 'mesh'
        option mesh_fwding '0'
        option mesh_ttl '1'
        option 'mcast_rate' '18000'

At least in my experience, the IBSS support in the device firmware is either
not there or starting to rot.


> I have two systems present..
> One board is with 802.11n radio. other is 802.11ac radio
> This is the only difference..same image compiled running on both devices..
[...]
> This configuration works fine..
> But if I run same config on the second node with 802.11ac radio.. it fails..
> So I dig around and changed the config as follows.. And it started to work..
> batman-adv is same..no difference
[...]
> config interface 'bat0_hardif_eth0'
>         option mtu '1532'
>         option proto 'batadv'
>         option mesh 'bat0'
>         option ifname 'eth0'

Hum, where is the ethernet coming from? This is not used in the other 
configuration as slave interface for bat0. And it should also fail if you do 
something like this on the 11n device and don't use a separate interface
section in /etc/config/network for it.

Besides this, what is the change? I don't see one.

And if you just wanted to have eth0 as slave and the wlan interface as slave - 
then yes, you need two different interfaces with proto batadv (batadv_hardif 
in OpenWrt 19.07) in /etc/config/network. It is not possible to have multiple 
slave interfaces in /etc/config/network attached to a single master interface 
using a single (non-"bridge" type) interface section . This is a limitation
of netifd.

> I have two questions so far..
> 
> Why the first config does not work over second system..(Wifi works
> fine but. for mesh. i needed to change the config like this)
> 
> Second question.. I can live with different config.. Ok..
> But I want to use eth0 and eth2 and mesh network as a bridge...

"as a bridge"? Maybe you mean in a bridge? Should work right of the box with eth2:

    config interface 'bat0_hardif_wlan'
            option mtu '1532'
            option proto 'batadv'
            option mesh 'bat0'
    
    config interface 'bat0_hardif_eth0'
            option mtu '1532'
            option proto 'batadv'
            option mesh 'bat0'
            option ifname 'eth0'

    config interface 'lan'
            option type 'bridge'
            option ifname 'eth2 bat0'
            option proto 'static'


If you want to use eth0, eth2 and bat0 in a bridge then it would look like this:

    config interface 'bat0_hardif_wlan'
            option mtu '1532'
            option proto 'batadv'
            option mesh 'bat0'

    config interface 'lan'
            option type 'bridge'
            option ifname 'eth0 eth2 bat0'
            option proto 'static'

> But whenever i add any of this interfaces on bridge.. batman-adv fails..
> What am I missing???

A device just cannot be in a bridge and in batadv at the same time. Just not 
possible because the bridge would steal all the ethernet packets before 
batman-adv would receive them. So it is not even allowed to have two masters 
(batadv interface and a bridge) for a single interface (wlan0, eth0, ...).

Kind regards,
	Sven

--nextPart3756528.ibSLklOHiU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAl6m+eIACgkQXYcKB8Em
e0ae9g//QECsAAdFuxDwu4WF+bsZlxMxaGnM/vYraAc71dliXjX4IK5bwbPfE/6L
z5RCguLxsXtL63E5tCtmZAe5IRrmFI8NJzvAs3Asf+9L9Dc25vdHJxKYv0J+uCxl
rlji3V3bnwR8nDyyqYTAITSaaPMx6bqfa3di4JbwqAEXz/QXbvTboaZdXEcesTW5
FFPr837+0zen4H+j6RuJBaW0AkE67/A/nnMEqAJ7jL3NuyemZ6j4diYP0WzhpW1J
r1avxQuHb0Ay73c2ouCXmk3DD+nXXzedRuiPZkqOcU9ViDJbv06ihOpBOhp81KGm
JvVm71A4GwiU11JS6CsE1vlBH/VDW5a2XzdIitsn4Mwmid0gdLqeotyN8V/NZStj
34OOPAIkME8Sjw7m8VuHM4OwY5lIwusy3POUD/iYAmuZmS8r75oXK2+bKt7qZKuz
NmRaaPqXuYdahVZYfCju3xuciBjx6DNACOL84MmtWtcmx09pYoGP3+bv1+rn0X1h
nkwPwjrNXU5WfmcwUVQdKkuYY1RbrdHsI4c7p7vk3+dxmV2O46VE2K7xuYfk76Fp
jwSGKNtJIyHkVLIPr+NwLiE7sBTWwti7n8BPYBJeO3Cx3A7qW6XDCc8WGlaL+0W9
y4Zj0YRIWeRUqBYhA2qyezZKsO3NyvZUD9gg8BklBUd+s0F+kio=
=QWor
-----END PGP SIGNATURE-----

--nextPart3756528.ibSLklOHiU--


