Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Fri, 22 Jul 2016 15:17:46 +0200
Message-ID: <4153918.ZK2BvdZRV2@sven-edge>
In-Reply-To: <1469187482-29894-1-git-send-email-linus.luessing@c0d3.blue>
References: <1469187482-29894-1-git-send-email-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3239762.8UHQcbuazB";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH 1/2] batman-adv: Remove unused
	skb_reset_mac_header()
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

--nextPart3239762.8UHQcbuazB
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

On Freitag, 22. Juli 2016 13:38:01 CEST Linus L=FCssing wrote:
> During broadcast queueing, the skb_reset_mac_header() sets the skb
> to a place invalid for a MAC header, pointing right into the
> batman-adv broadcast packet. Luckily, no one seems to actually use
> eth_hdr(skb) afterwards until batadv_send_skb_packet() resets the
> header to a valid position again.
>=20
> Therefore removing this unnecessary, weird skb_reset_mac_header()
> call.
>=20
> Signed-off-by: Linus L=FCssing <linus.luessing@c0d3.blue>

Reviewed-by: Sven Eckelmann <sven@narfation.org>

Kind regards,
	Sven

--nextPart3239762.8UHQcbuazB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJXkhz6AAoJEF2HCgfBJntGahQP/iD4eFl84RVmlSlSnLuGWnFb
VH3b5KyAftnLPSexJ5YK36VoQqFwTFfPQ1D/AjRKmAEJxYLm0qjDnDEdRSpwAO2H
E858sAbiYog44shKPdisrIQKaBDgDEFnrndUYHt78EaBI+EXFsAe5jhOyH5sF90W
shwYIJwLfPuzoOE8uGPUDonX7uUKm7NYdrcPA8Lv5ov1KH+MCBaWRPBaoPQtw2tp
ndb0dNHPWUXoHlUUp0eusGFdLM3Yf48Tn0oFuC3a2MEI1dFifaxmWUh5Lu34WrE4
4bF13QIv9B21wdO8qYc0vAer/KDCmm66FwgnI0LFTEnEg/LEWmiK9L4tQbVHbdgc
R+T4pcoxMklYCH6EDSCKAD+xcJbsYc8YZ1nYhYUalyPVNM7cTs6/5y/eFzgSdOi5
Zzoak0u9MwWPkxIkxBiCdZFHiSqtHg4FAGrfdCZEU34ZIyL4N1Qpr5nghoadMd48
v1wIb+Yn4s8FWZZ9xSI0A833MN/hiecdMz0CLzxFYd6y1r4HcCe7nuxf8/foQWE2
IytD90BcSkiniIijOIAy3CYdN9jJQ0Xai6EJsm9G3UTr9gd2QwEFmZe/A8fuS28N
O4BqSJVumduTfnHLKeANrs9KP2BmHin41OrJrRodKvTK5m3exuP3BO7M2u3TCRNO
syl+h8T97oH95fb6h9G0
=+bA3
-----END PGP SIGNATURE-----

--nextPart3239762.8UHQcbuazB--

