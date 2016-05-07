Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sat, 07 May 2016 16:18:38 +0200
Message-ID: <112511932.Eq5c9Kmyda@sven-edge>
In-Reply-To: <572DF6E3.3030901@wifibot.com>
References: <572DF6E3.3030901@wifibot.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2262511.Yo6VkQmugZ";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] no able to switch routing algo to V ?
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: b.a.t.m.a.n@lists.open-mesh.org

--nextPart2262511.Yo6VkQmugZ
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Saturday 07 May 2016 16:08:35 contact wrote:
> Hello,
> 
> I just got openwrt 15.05.1 with batman-adv 2016.1 on 3 picostation HP,
> this time a selected before the build of openwrt batman V option, I can
> see it when it ask for available routing algo ,
> 
> root@OpenWrt:/etc/init.d# cat /sys/kernel/debug/batman_adv/routing_algos
> Available routing algorithms:
>   * BATMAN_IV
>   * BATMAN_V
> 
> but when I do :
> 
> echo BATMAN_V > /sys/module/batman_adv/parameters/routing_algo
> 
> It does nothing, still on BATMAN_IV during session and on reboot ?

This module parameter only controls what routing algorithm is chosen when a
new batman-adv interface is created. So if you already have created it then
changing the parameter doesn't do anything to the already existing batman-adv
interface. Also rebooting a device will reset it either to the default or to
the one you've explicitly specified during the loading of the modules.

But you seem to use OpenWrt. It allows to specify the routing_algo in
/etc/config/network and should be applied right before the batman-adv
interface is created. You just have to make sure that you don't specify
conflicting things. An example of a simple configuration is:

    config interface 'batnet'
            option mtu '1532'
            option proto 'batadv'
            option mesh 'bat0'
            option routing_algo 'BATMAN_V'

The wireless configuration would then normally reference this batnet network:

    config wifi-iface 'wmesh'
            option device 'radio0'
            option ifname 'adhoc0'
            option network 'batnet'
            option mode 'adhoc'
            option ssid 'mesh'
            option 'mcast_rate' '18000'
            option bssid '02:CA:FE:CA:CA:40'

This information was taken from Batman-adv-openwrt-config wiki page [1]

Kind regards,
	Sven

[1] https://www.open-mesh.org/projects/batman-adv/wiki/Batman-adv-openwrt-config

--nextPart2262511.Yo6VkQmugZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJXLfk+AAoJEF2HCgfBJntGNesP/A2vNHAoXXI4dXT9AV1fKPaU
rSozIq+vA75IghLA6iyEtiVkLIe28l2MrCOd0l9A+lF1PlvHyqS2Fj8YwTSxzuvw
DFHSjuWvnzYgmJLXBzJDVAfB+OrbKu6ujpSSPGyIb/rRZnqtP06fPSQ7laqSJm+/
UyFxmXPg4titbbH6tGM7LbDO90q9UcvS279aVkW1R/bUbly4XAshTeHfI7lIZqoX
9oiF127YBskHF4tcSzH3rtZX39b6PF5gShkOtVQeP44/swkqAEEclmQm21Xz6zNz
iZaYgOdnvLBLYBQjWPwvzNQJI7qLrzn5KVYsbh994vfCppz9Tm2MXUwbwN/rbGAp
YY+vZxvyf0sW1c7w5cUtng/RUAVAKGjSjGlZzwBegTGhXrMXH3A30YBqJJZInRLL
oJa/Cl5+WgdkuvQDMnSFyRyItBa53cAoZV0BrgLnEO3JpLAClVse1RTMczd3ZCpf
OU3mV9+1fJq9+cCxJvhKcPz8X84xFBF2X3XHSQHrdZNrYhVfqsYNJpUkeMDJ63fw
pS66jot86czYHyGWiKNpm/cDOqzzuQyLg+UG4g871eswRc3C5N8ZdxZCE5bVALMz
gsX7oPrCrd7GavJvFZ36l3MjpPtjtwezjE2bsyutIkAoteT6fyxLUcVWv1/1JDNI
b4c4H0OwCMrRb1NdQ+gP
=NAa/
-----END PGP SIGNATURE-----

--nextPart2262511.Yo6VkQmugZ--

