Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Mon, 31 Jul 2017 10:51:00 +0200
Message-ID: <3509749.LU2Kc3mdbT@prime>
In-Reply-To: <20170706050225.24455-1-linus.luessing@c0d3.blue>
References: <20170706050225.24455-1-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart4650172.50mDiXWVd7";
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

--nextPart4650172.50mDiXWVd7
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

On Thursday, July 6, 2017 7:02:25 AM CEST Linus L=FCssing wrote:
> This patch fixes an issue in the translation table code potentially
> leading to a TT Request + Response storm. The issue may occur for nodes
> involving BLA and an inconsistent configuration of the batman-adv AP
> isolation feature. However, since the new multicast optimizations, a
> single, malformed packet may lead to a mesh-wide, persistent
> Denial-of-Service, too.
>=20
> The issue occurs because nodes are currently OR-ing the TT sync flags of
> all originators announcing a specific MAC address via the
> translation table. When an intermediate node now receives a TT Request
> and wants to answer this on behave of the destination node then this
> intermediate node now responds with an altered flag field and broken
> CRC. The next OGM of the real destination will lead to a CRC mismatch
> and triggering a TT Request and Response again.
>=20
> Furthermore, the OR-ing is currently never undone as long as at least
> one originator announcing the according MAC address remains, leading to
> the potential persistency of this issue.
>=20
> This patch fixes this issue by storing the flags used in the CRC
> calculation on a a per TT orig entry basis to be able to respond with
> the correct, original flags in an intermediate TT Response for one
> thing. And to be able to correctly unset sync flags once all nodes
> announcing a sync flag vanish for another.
>=20
> Fixes: fa614fd04692 ("batman-adv: fix tt_global_entries flags update")
> Signed-off-by: Linus L=FCssing <linus.luessing@c0d3.blue>

Applied in 2035bb89 with minor changes in the commit message

Thank you,
     Simon
--nextPart4650172.50mDiXWVd7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE1ilQI7G+y+fdhnrfoSvjmEKSnqEFAll+73QACgkQoSvjmEKS
nqE+/w/+MZRKdexA2AbVUz8mOWMBn0JJUMpu57oeMh23nBomuCjHucSLN29Qt1Lg
zetYJaOr5PEjvo5E7cm4qpfUZlKlUHgBRARrlVft4l2bkC1KY5A5O28AepmJiG/D
8HdOCM6LIe1OVxeJAJrxzSQpAkBb09b7nDnRHnVt8ZgSy1BRxvAkgQP09B6dSLMu
cGBRz33egqUYVDyL1S2sVvze5bB+oKzYTF4t34Gj7iK8CKQauLOTMowXVdQm0m12
LhmBqtJLZ0LXdf5MBccyz5lo85Jcu0mQIHKC0d0xyxiPSRw8M8kIsKdmzE+7RJwW
Rb65+XZjU+BkLnKvxbmYZkLymfvYoZ2glXmk5/h6zeGLU6oEDUBXktx/Skh17ouO
FGZhZr7X0es83vwwImkcxomfVqqUZ5d862oLso4KEwc0vv5MdxZOKJmxr12UaXZc
/AwyJ4m+Ls3tIlLCDzQK7S4dUuo73d+5FjrElC630m3EJ54cP8i55ZsrejR/av67
G6/T6DXhxyPq/B1pN50s7SDfxg5lXELtf2H20WFe48VKhr9c2hzvZusUyx6A52Ym
cmrk+9z94BlWwLmcvyFm6/Sh7BAreZmapxcsh0Fl5fQsJxQh6f0q+XkllD1sZhVP
+mTGpYfD2aJg7rDTTgKqK/agWQQ8TnLM0v4ksxlgPmlEvBdqsP8=
=gQ6y
-----END PGP SIGNATURE-----

--nextPart4650172.50mDiXWVd7--

