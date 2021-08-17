Return-Path: <b.a.t.m.a.n-bounces@lists.open-mesh.org>
From: Sven Eckelmann <sven@narfation.org>
Subject: Re: [PATCH v3 3/3] batman-adv: bcast: remove remaining skb-copy calls
 for broadcasts
Date: Tue, 17 Aug 2021 14:24:36 +0200
Message-ID: <8357888.XYH0bx1MCn@ripper>
In-Reply-To: <20210516223309.12596-3-linus.luessing@c0d3.blue>
References: <20210516223309.12596-1-linus.luessing@c0d3.blue>
 <20210516223309.12596-3-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart4234697.lddkiTJQAK";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Linus =?ISO-8859-1?Q?L=FCssing?= <linus.luessing@c0d3.blue>

 
--nextPart4234697.lddkiTJQAK
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Linus =?ISO-8859-1?Q?L=FCssing?= <linus.luessing@c0d3.blue>
Subject: Re: [PATCH v3 3/3] batman-adv: bcast: remove remaining skb-copy calls for broadcasts
Date: Tue, 17 Aug 2021 14:24:36 +0200
Message-ID: <8357888.XYH0bx1MCn@ripper>
In-Reply-To: <20210516223309.12596-3-linus.luessing@c0d3.blue>
References: <20210516223309.12596-1-linus.luessing@c0d3.blue> <20210516223309.12596-3-linus.luessing@c0d3.blue>

On Monday, 17 May 2021 00:33:09 CEST Linus L=FCssing wrote:
> +       /* __batadv_forw_bcast_packet clones, make sure original
> +        * skb stays writeable
> +        */
> +       return (skb_cow(skb, 0) < 0) ? NETDEV_TX_BUSY : NETDEV_TX_OK;

Just because we had this discussion a couple of hours ago: My last comment=
=20
from May was that the skb_cow might be unnecessary - not that you need a=20
skb_copy.

You wrote (for situation B):

> a packet is
> additionally decapsulated and is sent up the stack through
> batadv_recv_bcast_packet()->batadv_interface_rx(). Which needs an
> unshared skb data for potential modifications from other protocols.

And my reply to this was:

> Take for example the bridge code. You can find the skb_share_check in=20
> br_handle_frame. Afterwards, it knows that it has a clone of the skb (but=
 not=20
> necessarily a private copy of the actual data). If it needs to modify the=
 data=20
> then it is copying the skb.
>=20
> Another example is the IPv4 code. One of the first things it does is to c=
heck=20
> in ip_rcv_core for the shared skb. And if it needs to modify it (for exam=
ple=20
> by forwarding it in ip_forward), it uses skb_cow directly.

Kind regards,
	Sven
--nextPart4234697.lddkiTJQAK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAmEbqoQACgkQXYcKB8Em
e0bxkg/+KWAcW3cOzs8V4EWWFVHIj8j2DKTPEz8+G86hYBwqq+UUB428zjuYUgle
3SeUViw8ktYppp/yrmqyFTcSqt0Cc00K+Ik1qhXqRm1LGrueNV2PMd6PxVVf92sY
s52xmqIBt2bwlPwI3s7+Th2jN5OjxTCpFP0ZmDnuepLmOqhyzvlH0wlgd3bC3w7Y
4PloqfuF5xjMPNroSKRO0AoFsa2h25kvPIA6Mgv+sHbTiIg/aHf23kUxcCvyO8wI
qsEcqlbtH4k8XtOj0NdNFC3q2sX14rr84KSFo/hmrebGwG9ligft+HxH/1OSEcgw
bjg25KT8EhcmA4OlRFdN9pwpH4IYgTG+i86khX3EzApymVfk8SJTY8ZiMM+3ODMx
hU7TmzFTRimtil8mq94NaUedEytdfJnCx6cXM+Xl/6Y52g7jnUt1ikRY1THul7m7
JdykHW748cng01wadAxuz2Vod6NDA/aSK66cUETT+Kl6QVZslggp/+zDcTq75+x0
iIFx7jiA24U664iwIoeMIy87dGZoppwcGsufUnHy8b8kanzxjCdBIWOFHXBg4+sC
Gx8WRx5p8qgFRpiLMJ70xJyhjpTSNYo0c49qOn6WnVceHrDrkzmiGxy4W215iail
TuRtOIWmvnjm5GdsU6yQAuPpgHrqDBgAY0mk8pI8QsCr5+dBm+c=
=HEd6
-----END PGP SIGNATURE-----

--nextPart4234697.lddkiTJQAK--


