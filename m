Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Mon, 13 Jun 2011 22:46:51 +0200
References: <1307986680-21113-1-git-send-email-ordex@autistici.org>
In-Reply-To: <1307986680-21113-1-git-send-email-ordex@autistici.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1818492.1l9WTL3O4m";
	protocol="application/pgp-signature"; micalg=pgp-sha512
Content-Transfer-Encoding: 7bit
Message-Id: <201106132246.53025.sven@narfation.org>
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: clean up the tt_query flags
	field
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

--nextPart1818492.1l9WTL3O4m
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit

>  			"Routing TT_RESPONSE to %pM [%c]\n",
>  			tt_query->dst,
>  			(tt_query->flags & TT_FULL_TABLE ? 'F' : '.'));
> -		tt_query->tt_data = htons(tt_query->tt_data);
> -		return route_unicast_packet(skb, recv_if);
> +			tt_query->tt_data = htons(tt_query->tt_data);
> +			return route_unicast_packet(skb, recv_if);

Could you indent everything (except the return) with one more tab?

The rest:

Acked-by; Sven Eckelmann <sven@narfation.org>

Thanks,
	Sven

--nextPart1818492.1l9WTL3O4m
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABCgAGBQJN9nc7AAoJEF2HCgfBJntGMAsP/ROPIpUup0TeKk/eBxBcOvmU
dFLmTCLS7LKNqQsdIWH4ChMmdA6FoNfOFOG9sO9PrnYwQixWUPa/VGnPYE0W8bHn
Svw0Yb8Xbnh+HiOG5tuXg/XZP/S9epsDEmm36eifZwzDHTCrNJTqkZcB0EZ9oK3j
945M2IxUdYUTyoZtV3u2E7lc1EPy2gpV3eVjNUbTRxmxXD1LjkvkAo+/quc0Lakh
4PI5MHdbi2yWPn4QxJFJaGypS4CrtybEc/kvUE4uOv7eg2t3Ylg/G9lwvgXIzF2V
kI99yKZ1HKIN89vNG0f3t/bh+xAtNWzQPUrUVw85aCyDEJBsg04urcOnR0fzgamg
4p3xHLMluc6+J+XurhP932i3xJh9I0VvGn0Zstiy5RmgKxnR5yd+PjoLPVWLsHFA
irvPY5lWzYICyicy3g2gT3NVCc4PyjJmihfOkCHzdOza/xAnFYVRsjVw+m8Y4lId
hEEeYvTjay+YqlzJzc3LWXWLokEcEPSGMaNa4/qpJ0YFvxoFgxljkzcOW8JtFucg
v1ejJJW7BuHtlS5slgBT09bRVI6jVSOxUxQkPT29dHT8EI4S2pNCDS/J0I5y1mxJ
+eB40nT1nqKpCvUfrqxtxUz8cd1jgt5RIeXnp8oChnvhbqwhCv0NhZAZPyveUhFK
naeAuBiCZXecLYwgkoKc
=8B/k
-----END PGP SIGNATURE-----

--nextPart1818492.1l9WTL3O4m--
