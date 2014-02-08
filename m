Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Sat, 08 Feb 2014 21:14:34 +0800
Message-ID: <4985684.n49h5G54Rj@diderot>
In-Reply-To: <1391352791-19305-1-git-send-email-mareklindner@neomailbox.ch>
References: <1391352791-19305-1-git-send-email-mareklindner@neomailbox.ch>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2460897.rW5psCgrrN";
 micalg="pgp-sha1"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: backport eth_hdr() compat
	fix to avoid kernel oops
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n@lists.open-mesh.org>
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


--nextPart2460897.rW5psCgrrN
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

On Sunday 02 February 2014 22:53:11 Marek Lindner wrote:
> From: Linus L=FCssing <linus.luessing@web.de>
>=20
> Introduced by 41b38727749a94c1a65cf0f4be9bfe1cbaf0adeb
>    ("batman-adv: fix potential kernel paging error for unicast
> transmissions")
>=20
> Signed-off-by: Marek Lindner <mareklindner@neomailbox.ch>
> CC: Linus L=FCssing <linus.luessing@web.de>
> ---
>  compat.h | 11 +++++++++++
>  1 file changed, 11 insertions(+)

Applied in revision b921e8f.

Thanks,
Marek

--nextPart2460897.rW5psCgrrN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQEcBAABAgAGBQJS9i2+AAoJEFNVTo/uthzAhdcIAKldrMoCTG9VunWKDH4OpO08
QDK3yl3veRD5Yz3Cog61soz+jpDVKJBmE0wCTl9IRoC5nQ5QypjLBldHXWkCwm2j
ojgJrQ0eTsHU3IVtd2DKKGp9dP1m8T1+wlvifyhtp/Eoi7e5I/p8KDpxa43RCVBL
TP9SxLVas9qHgEqC8GpdV9Ll1yDyo2tV+8zn4/buenhkjQMVprzIE3ejwyjegtpg
J51NOI8ZKX5S7cDrY2kTEJJgTFwgsGW2mwa7JRsvQAd11JtB2blRU0GcIMp6LELo
w41fOm6hjVfpTN5+kEdRTRTh8RcRc7Ni4X4ibMlnY2Snv4vAulbStOKgK4bMDe4=
=8taL
-----END PGP SIGNATURE-----

--nextPart2460897.rW5psCgrrN--

