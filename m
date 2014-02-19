Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Wed, 19 Feb 2014 14:57:55 +0800
Message-ID: <4540640.KzBSvFgoGj@diderot>
In-Reply-To: <1392721435-7461-1-git-send-email-martin@hundeboll.net>
References: <1392721435-7461-1-git-send-email-martin@hundeboll.net>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart11236057.K5LAU6Qg33";
 micalg="pgp-sha1"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: make the use of braces in
	if-else consistent
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
Cc: Martin =?ISO-8859-1?Q?Hundeb=F8ll?= <martin@hundeboll.net>


--nextPart11236057.K5LAU6Qg33
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

On Tuesday 18 February 2014 12:03:55 Martin Hundeb=F8ll wrote:
> To avoid confusion, the linux kernel coding style discourage the use
> of one if-else branch with braces and another without braces.
>=20
> Introduced-by: 65d8217193427026169c48112c561c5ca4d1bd18 ("batman-adv:=

> compat: fix null pointer exception for kernels < 3.9")
>=20
> Signed-off-by: Martin Hundeb=F8ll <martin@hundeboll.net>
> ---
>  compat.h | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)

Applied in revision 534aa4a.

Thanks,
Marek

--nextPart11236057.K5LAU6Qg33
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQEcBAABAgAGBQJTBFX2AAoJEFNVTo/uthzA6/QH/1OnowET5IcnntpHqIMaNN0h
ypzL7Vp7qOHLGnq9HDvDL9303zjc6u1RwkFhKtsDiD0n20YAwfz+kDKH5alZ/Mvz
nc6FtKTuedkOZ1uws73j7PiQqx8A5Y+r0DRhj2aMx8Q9rN9+3+m+BjoYognGaVEl
OGkUJBaRxJDSXJy2iSsCzcjGQrJN36SZUy4LllE/RhMa6395e/WvBRUnu/GHcgil
0m5OnX01wpN8V0wZweVmiG728H/9zPH1le5D0ljoYchRiZJQpAbZE75iyWDQf+E3
BvtLAqSPY/WfuartGB5Z3GGYFcXfJzhOBdhJs5omlrZWx+46mC7CIqCNDcK1Go4=
=Ns40
-----END PGP SIGNATURE-----

--nextPart11236057.K5LAU6Qg33--

