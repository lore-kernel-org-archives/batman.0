Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Tue, 29 Jan 2019 16:42:56 +0100
Message-ID: <2115997.7JKGhZffWe@bentobox>
In-Reply-To: <20190119061422.32335-1-linus.luessing@c0d3.blue>
References: <20190119061422.32335-1-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1733459.H1ZqWIxQRZ";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: Add multicast-to-unicast
 support for multiple targets
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
Cc: Linus =?ISO-8859-1?Q?L=FCssing?= <linus.luessing@c0d3.blue>, David Bauer <mail@david-bauer.net>

--nextPart1733459.H1ZqWIxQRZ
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

On Saturday, 19 January 2019 07.14.22 CET Linus L=FCssing wrote:
[...]
> +		ret =3D batadv_send_skb_unicast(bat_priv, newskb,
> +					      BATADV_UNICAST, 0,
> +					      orig_entry->orig_node, vid);
> +
> +		if (ret !=3D NET_XMIT_SUCCESS) {
> +			/* use kfree_skb() to signalize losses here, but keep
> +			 * trying other destinations
> +			 */
> +			kfree_skb(newskb);
> +			ret =3D NET_XMIT_SUCCESS;
> +		}
[...]
> +		ret =3D batadv_send_skb_unicast(bat_priv, newskb,
> +					      BATADV_UNICAST, 0,
> +					      orig_node, vid);
> +
> +		if (ret !=3D NET_XMIT_SUCCESS) {
> +			/* use kfree_skb() to signalize losses here, but keep
> +			 * trying other destinations
> +			 */
> +			kfree_skb(newskb);
> +			ret =3D NET_XMIT_SUCCESS;
> +		}

As you already wrote in your other messages - the send skb send functions=20
(like also in other parts of the kernel) consume the skb. The caller must=20
therefore not free the skb again.

Which also means that you should rewrite the patch to behave the same and n=
ot=20
leak skbs. You most likely already partially do this this in [1]. But we ha=
ve=20
to check this in detail in the new version.

One point where it looks "wrong" (I've seen the comment) is=20
batadv_mcast_forw_want_all_send -> default case. Not sure what to do about=
=20
batadv_mcast_forw_tt_send + batadv_mcast_forw_want_all_send which follow af=
ter=20
each other in batadv_mcast_forw_send. Even when the function should have
consumed the actual skb.

Kind regards,
	Sven


[1] https://github.com/freifunk-gluon/gluon/pull/1357/commits/a973442fc9efd=
28a8b2ccc4bef65bcab981d0b20
--nextPart1733459.H1ZqWIxQRZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAlxQdIAACgkQXYcKB8Em
e0b9cxAA07Aat6eYRlNBUiBE+lWSb7A1RxKkQnfjiQdnWBWiHKtjswTZTS+rFYiF
TViKC2SRZDGWmsuxMubxBfZo5N8toUQYlqQ74po2gg7KaE3SZBeruZh8/Ea9atPM
xAds86CqnQmNanADSU7Mc/z4xxvDwL32Y4d8Uhg+iSaB2yXsH1mjF7vXS1d5cWb0
Nc/eOZLPrdoptvMTo3aaIzBErTZ9wC31ORx09IZ5jLTrunmwmbXk+iCKeyVHIK2U
7IBg2bmxEsWp54N1/sgI3NuzjA5R6TIgAOM9gNtS8jMCrtyfECfupAGajvoD2Zan
zckLvJUffrk0MeYfW6cMbNhGVK4/jUWrrcMkEsTr2YTdsNBN09ZIz7I9WDAC03p9
k1IeO6HCLcNCI9+C01rqK7n6VBFDOFtxFOOGErUH/JR/LH5jmuhKBRKyZQ+6y180
blut6/PNMtE81xqGcchiGBN7VvhldzywPJTdD2t8Y4zw7Qo9RTOCv+GxFCCR2rsi
AAgXDqFm3+I88iHlDJMQIziFDVcJP2AvciW5RPnugbx9gb9aR9BdCX6EVyZfx7CM
J5z99orIixd4wgfZJbXADkJX9Vpq7px3heKMxO+EduOU/C2kJjAQ/oOke/HhBp00
AAxzM4Kc6/gOQ9hhkC05CSEHYJ3iA2fn9gLbjOe9ASSakq5SDYQ=
=Gc30
-----END PGP SIGNATURE-----

--nextPart1733459.H1ZqWIxQRZ--

