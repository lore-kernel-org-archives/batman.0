Return-Path: <antonio@meshcoding.com>
Date: Mon, 11 Nov 2013 08:05:02 +0100
From: Antonio Quartulli <antonio@meshcoding.com>
Message-ID: <20131111070502.GA3713@neomailbox.net>
References: <1384123721-23691-1-git-send-email-linus.luessing@web.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="PNTmBPCT7hxwcZjr"
Content-Disposition: inline
In-Reply-To: <1384123721-23691-1-git-send-email-linus.luessing@web.de>
Subject: Re: [B.A.T.M.A.N.] [PATCHv3] batman-adv: introduce capability
 initialization bitfield
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
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>


--PNTmBPCT7hxwcZjr
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 10, 2013 at 11:48:41PM +0100, Linus L=C3=BCssing wrote:
> The new bitfield allows us to keep track whether capability subsets of
> an originator have gone through their initialization phase yet.
>=20
> The translation table is the only user right now, but a new one will be
> added soon.
>=20
> Signed-off-by: Linus L=C3=BCssing <linus.luessing@web.de>

Acked-by: Antonio Quartulli <antonio@meshcoding.com>

--=20
Antonio Quartulli

--PNTmBPCT7hxwcZjr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCAAGBQJSgIGeAAoJEADl0hg6qKeO8wMQAJ9vXxL0yUbUJmzxYOT9dLSB
R1Oso6GEgtNf3xQ8qJcuMVWLik9iRh4Km46efFbCKuxC8sI3ZvPky2hlaHeXwn53
nC4WBh7Cwni7oKGTzLOLJMfTP2mYzB4Owe8i1oogRxpQXh8yhRPRtNj9oBCH/TB/
ioLlpL4a50z/myTUQ0wPrN88PE9+ldBcKja/bA2XeBD0XIlA4x8CUcFAoMPE4Zs4
Ommmqh4NUo50a22Uk/UYHt4yBCjZdAtAS3GpK613r967Vl5ikpUsSwwuJ2NdKRkd
bCN+AAKahGc4hyazJO7CFQnhw8wMfas+9IdaspUdvD4tzM6V+oVjrn9iXZ5FydJX
XPdMZyZCJh5TLhSqhuuPFCbYC0YlHRj3gSvqQuWk6Lye4cEePtQOrPT30ok5Cx8+
maa3E+3Il1psGe0sY4HHrDpDeklb0rBF/Znvsy1bMvXOiRoWVa+liMp4p7eZtEIU
N+vFpNQOAqSFQb1No5A6pOCJi9RdblPT4rpWllGMXoeBa6VWxfTj+3VGIL8LLvIt
KyDFQ+a4dQ/aBhm38kYNob0aUwyZgEyQuWZR9sJC+c63YXgDTym7ntCyKEhV681G
sA/MxpK4xOPZMUlYEvZ0iVYiJn1rDS8jgNvtFQsZXY9ZsIiK3Vj9udDsSErOgAnz
XTuF+ilDMRKGUjaaZXQ6
=66mS
-----END PGP SIGNATURE-----

--PNTmBPCT7hxwcZjr--
