Return-Path: <mpa@pengutronix.de>
Date: Sun, 28 Dec 2014 12:11:10 +0100
From: Markus Pargmann <mpa@pengutronix.de>
Message-ID: <20141228111110.GD10331@pengutronix.de>
References: <1419594103-10928-1-git-send-email-mpa@pengutronix.de>
 <1419594103-10928-26-git-send-email-mpa@pengutronix.de>
 <2175702.tFymAKUbUX@diderot>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="bajzpZikUji1w+G9"
Content-Disposition: inline
In-Reply-To: <2175702.tFymAKUbUX@diderot>
Subject: Re: [B.A.T.M.A.N.] [PATCH v2 25/26] batman-adv: packet.h,
	add some missing includes
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
To: Marek Lindner <mareklindner@neomailbox.ch>
Cc: b.a.t.m.a.n@lists.open-mesh.org, Sven Eckelmann <sven@narfation.org>, Antonio Quartulli <antonio@meshcoding.com>


--bajzpZikUji1w+G9
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 28, 2014 at 10:35:03AM +0800, Marek Lindner wrote:
> On Friday 26 December 2014 12:41:42 Markus Pargmann wrote:
> > Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
> > ---
> >  packet.h | 5 +++++
> >  1 file changed, 5 insertions(+)
>=20
> Again, why is it a problem if these headers are missing ? Something not=
=20
> compiling ? Something else broken ? What are we fixing ?

This is fixing missing includes that I discovered when removing other
includes from c files. As this header uses defines from that include file
I think it should be explicitly listed. Will add more description to the
commit message.

Best regards,

Markus

--=20
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

--bajzpZikUji1w+G9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJUn+VOAAoJEEpcgKtcEGQQ1ZMQAI9O+cRy47TalG068dzWhhkv
sqZCHk1aFjXFHCGP5MqEdOiwSTAt7Klsg/jHmUYkDFSgWHTGaioVfr6rxixGljIv
BYFMECHHnkNPNY2xItLGEX7XTuzLc7mwXFR3Z8MUuBuDYm+bmVVO9u8Z5O8FpQRe
BNQNEGU8R0d222B/gxgYrhLerW2cZ0Of4JQJEv4zSGIBjXK0ecoEDFeKWx5748qa
qHqaPqQ3KE9WOthJJcBxR1vVfZUEqh+dl0cmrZgQe0DrpgPP5NuucFYb3reH3WFY
5AolwUkJCtUoZOBpgGh+ztNl+jwn0T6Y14c5TYUBu8grScU/m7bnAMrKofU2Q6Rx
/aSHnX6z9RiARLo2yp4g6xTP645Lfy5gBl26tggoy2BxCNOvKBodcB38W33To2E8
mt2Tz8jUNNX5JCCowcRopzsJV3Hz0ynkK1hCpSz4UeRWTAnyfmN5fpJKzentC/+/
Y3Sdf/s0Rv9ff2yxsq//q1VSOPemoQUhCLGNF0Z3yW0+/hPG6tmjynkIaOLw8G7s
GINJ/j7qZSauKEZbRTNDtOGQigkq+igvsekB1p8+ep5saf79jFwkNmW+g6FQGF0W
rO92X16xiBrHdGBtmWiZZWlqhTzKWhBgwy6gJcCg03XZaQSTj9DskPF8j2ttQ7c0
QTDoqp9ZJ7YAgmDgnKFo
=wZGi
-----END PGP SIGNATURE-----

--bajzpZikUji1w+G9--
