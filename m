Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Fri, 9 Jul 2010 16:51:25 +0200
References: <20100707193047.422ac235@rechenknecht>
	<1278523926-29219-2-git-send-email-an.langer@gmx.de>
In-Reply-To: <1278523926-29219-2-git-send-email-an.langer@gmx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1545891.ytV0PlhGeu";
	protocol="application/pgp-signature"; micalg=pgp-sha512
Content-Transfer-Encoding: 7bit
Message-Id: <201007091651.27867.sven.eckelmann@gmx.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH 2/2] batman-adv: layer2 unicast packet
	fragmentation
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: b.a.t.m.a.n@lists.open-mesh.org

--nextPart1545891.ytV0PlhGeu
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit

Andreas Langer wrote:
> +	if (atomic_read(&bat_priv->frag_enabled) && batman_if->net_dev->mtu <
> +		ETH_DATA_LEN + BAT_HEADER_LEN)
> +		bat_info(soft_device,
> +			"The MTU of interface %s is too small (%zi) to handle "
> +			"the transport of batman-adv packets. Packets going "
> +			"over this interface will be fragmented on layer2 "
> +			"which could impact the performance. Setting the MTU "
> +			"to %zi would solve the problem.\n",
> +			batman_if->dev, batman_if->net_dev->mtu,
> +			ETH_DATA_LEN + BAT_HEADER_LEN);
> +
> +	if (!atomic_read(&bat_priv->frag_enabled) && batman_if->net_dev->mtu <
> +		ETH_DATA_LEN + BAT_HEADER_LEN)
> +		bat_info(soft_device,
> +			"The MTU of interface %s is too small (%zi) to handle "
> +			"the transport of batman-adv packets. If you experience"
> +			" problems getting traffic through try increasing the "
> +			"MTU to %zi.\n",
> +			batman_if->dev, batman_if->net_dev->mtu,
> +			ETH_DATA_LEN + BAT_HEADER_LEN);
> +
>  	if (hardif_is_iface_up(batman_if))
>  		hardif_activate_interface(soft_device, bat_priv, batman_if);


Nach der Aenderung der Argumente muesstest du das erste %zi wieder in ein %i
umaendern:

diff --git a/batman-adv/hard-interface.c b/batman-adv/hard-interface.c
index 1177e93..9dbbe2b 100644
--- a/batman-adv/hard-interface.c
+++ b/batman-adv/hard-interface.c
@@ -276,7 +276,7 @@ int hardif_enable_interface(struct batman_if *batman_if)
 	if (atomic_read(&bat_priv->frag_enabled) && batman_if->net_dev->mtu <
 		ETH_DATA_LEN + BAT_HEADER_LEN)
 		bat_info(soft_device,
-			"The MTU of interface %s is too small (%zi) to handle "
+			"The MTU of interface %s is too small (%i) to handle "
 			"the transport of batman-adv packets. Packets going "
 			"over this interface will be fragmented on layer2 "
 			"which could impact the performance. Setting the MTU "
@@ -287,7 +287,7 @@ int hardif_enable_interface(struct batman_if *batman_if)
 	if (!atomic_read(&bat_priv->frag_enabled) && batman_if->net_dev->mtu <
 		ETH_DATA_LEN + BAT_HEADER_LEN)
 		bat_info(soft_device,
-			"The MTU of interface %s is too small (%zi) to handle "
+			"The MTU of interface %s is too small (%i) to handle "
 			"the transport of batman-adv packets. If you experience"
 			" problems getting traffic through try increasing the "
 			"MTU to %zi.\n",

--nextPart1545891.ytV0PlhGeu
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIcBAABCgAGBQJMNzduAAoJEF2HCgfBJntGGEQQAMavLucGuX9q0ZcRGIGOZoJC
vtOCJp/uVrQf77NxYNJGyGaF6q1tuTlJZqtCVB+QETX+wcmcb1hOSwdFffSdsdgC
OhAWTHf5UixVZB/sCXr/9bna6b2nRi/ZbrcR6FCGTgQDQSKyctqK0PjvTmvIb6AE
nE/MSnikgaWT0sszB9X/bfYv5Srxf22wStniEL/TjhTZHcfWE22HYIDL0O8P59Ql
XCOw88dETQwj/N02f89zLuDzY4tlxStSx7IR93+W7W4aDZnzqborON3kiHwUHZG5
2LwHO0DMmuPnk+Ib4GYyPqAcSwqgD4KDO7xHOiGpyNs3VJmyYGs10Z22RU1RYRoH
KTwiIbQInd3W3xXSzwu/kct7usIwLYmc+GKyN6YFJIzXT0bipEwChYLGmT1IsQ+r
xbdPrL4JGghdFHU5gA33fR1kvcA0+3q7Wz6S0MMN0JaLN13itj8HdRbmyEXuwzL9
w2xSw3ZbfMlmkHnjboLoDPR+v5KfCDsAKarWt/WVoPuIYkcxBOyA7BCfkH4EqNOQ
m5O8yHbfypAbx6ynCoLXGYS4LuZrFJP3a1n0Sx68LCqj8II3sJ6eW6k8zHf15JVC
NKK5naPjjOKtmWfx+iRPvHoank60MeOsMKLbaUtHyOcu+xzCso6TYJPn88onGpPS
mOygPDQ+6FhAp3tYPGKf
=qqcz
-----END PGP SIGNATURE-----

--nextPart1545891.ytV0PlhGeu--
