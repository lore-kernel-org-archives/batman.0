Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sat, 29 Jul 2017 10:25:37 +0200
Message-ID: <3105199.cDmPPX3bfG@sven-edge>
In-Reply-To: <20170706050225.24455-1-linus.luessing@c0d3.blue>
References: <20170706050225.24455-1-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2501336.G5PWik7JmC";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH maint v2] batman-adv: fix TT sync flag
 inconsistencies
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

--nextPart2501336.G5PWik7JmC
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

On Donnerstag, 6. Juli 2017 07:02:25 CEST Linus L=FCssing wrote:
> This patch fixes an issue in the translation table code potentially
> leading to a TT Request + Response storm. The issue may occur for nodes
> involving BLA and an inconsistent configuration of the batman-adv AP
> isolation feature. However, since the new multicast optimizations, a
> single, malformed packet may lead to a mesh-wide, persistent
> Denial-of-Service, too.
[...]
> This patch fixes this issue by storing the flags used in the CRC
> calculation on a a per TT orig entry basis to be able to respond with
> the correct, original flags in an intermediate TT Response for one
> thing. And to be able to correctly unset sync flags once all nodes
> announcing a sync flag vanish for another.
>=20
> Fixes: fa614fd04692 ("batman-adv: fix tt_global_entries flags update")
> Signed-off-by: Linus L=FCssing <linus.luessing@c0d3.blue>

Simon wanted to have a look at this patch before applying it. But I've alre=
ady=20
queued it up for openwrt-routing [1]. This should hopefully help people whi=
ch=20
want to test it.

Kind regards,
	Sven

[1] https://github.com/openwrt-routing/packages/pull/316


--nextPart2501336.G5PWik7JmC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAll8RoEACgkQXYcKB8Em
e0YoIRAA0T5hdQ8XDb9JEz7nr8EqBkYGezR8kVwA6p33CjICyowALu0v83pUAQ5C
b53pITPA6w7hkX4TqyxePeZExHQ0K13oDNgvimoUSFedk45nuMqye0ujts2TStnB
q9LwVBt/7vbxvNcz3ye8CA84S1u2BxuMspGtm3MA5W5L6jfQ5KAXY1rqjm30kX2G
CvggEOUi//q5YSoD8H7XN/mIi/ADDTogPGiOuW/UchfGcj5tpIz3SU3EbL+tquf/
8pUJoi4PgxF+g7imNBX2CMFwVqs99jUwusXI7QapMfcvq5Pwd8KB5FW09wdgwtpI
GzNJzh5b++5ApLtyMFE7ciAxXG7+esjsmBs6REzFpsHx62fcxxszGtXVL7Mtog7G
SMw5TBWZKDWvj2ElLJPRjz3H43K+RyBowW/xyIDyMpu86taIXh1eZwBXGpfaeMDL
+PoZq3RxHGC+UKqTNKImRp8MCt8j17qphU/WpAXy4HAfquygG/mp9PQA/+g/+MzH
GR5H5qCgsJl6uFdFoc5/T/VzmwLJTywbwQJbh4hniSapYvaIYFdHnJdDcoKTWPgx
MFNSuN07Yv0bFqOvdOdFJy9+MvT0hl+4kc4KKAHPFyLIJll3boesJhiLGc0dNPeI
VC016WRMbJ/ZOuZobFw3NyfyxUY/ZgLwYJpYeTL+Jh9K1HiiIKk=
=AS18
-----END PGP SIGNATURE-----

--nextPart2501336.G5PWik7JmC--

