Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Tue, 08 Jan 2019 08:54:00 +0100
Message-ID: <4486944.DYXfSb8N5e@bentobox>
In-Reply-To: <20190107184906.GC5399@otheros>
References: <20181207135846.6152-1-sven@narfation.org>
 <20181207135846.6152-3-sven@narfation.org> <20190107184906.GC5399@otheros>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart5930028.PgqtcrPFqD";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [RFC v3 02/19] batman-adv: Prepare framework for
 mesh genl config
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

--nextPart5930028.PgqtcrPFqD
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

On Monday, 7 January 2019 19.49.06 CET Linus L=FCssing wrote:
[...]
> I seem to be able to trigger a null pointer dereference for this
> batadv_hardif_put() call here. With the following steps I end up
> with a primary_if =3D=3D NULL:
>=20
> $ batctl if add 1
>=20
> root@Linus-Debian:~# batctl o
> Error - interface bat0 is not present or not a batman-adv interface
> root@Linus-Debian:~# batctl if add 1
> Error - interface does not exist: 1
> root@Linus-Debian:~# batctl o
> Killed
> root@Linus-Debian:~#
> root@Linus-Debian:~#
> root@Linus-Debian:~# batctl o

You can reproduce it easier with (destroy is only there to make sure that t=
he=20
bat0 is really empty before the originator dump):

    batctl if destroy
    batctl if create
    batctl o

The check before=20

    	batadv_hardif_put(primary_if);

is missing. So it should actually be (like in the nla_put_failure case):

    	if (primary_if)
    		batadv_hardif_put(primary_if);


And "batctl if add" is basically a short version of:

   batctl if create
   batctl if add -M XXXX

And in your test, only the second part failed.

Kind regards,
	Sven
--nextPart5930028.PgqtcrPFqD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAlw0VxgACgkQXYcKB8Em
e0ZoAg/9EEWIoNsyL/bJn07Fy2i6PNWX4wQgnLDfeuVAjJ+lEiIbz0aetnjI3O6V
QJOSmOaJvN3El24+/ubtSW9Y/a5VVWyanvbO3Htf8SUrqTuGohrWr6R39AuIEyL8
J/pJ971sjvq4VjC8TRhUA0sC1/65MXNqpo5c+owUzwkkH0YTiNMGfTcK6bNJ46fw
NTOBMY8Ti7G5Q8RGi7U1Dn6LYhe29nI5q/SuKG7m/s8OJjgWfdAvMV0QYKNzi+5p
tCTbzy2hQ+kyBGxb7KXbeJ0iTmn/jAjyNpe2ptgutosUiLVjm4Dw2z25hVQHc41+
C+7hbUufjUh/1jk61+zxvKnZOhwia0M4lTeHoHuGThTrOd5gKZHMqUik47Tx4lt4
g2fbSyr0fahsg3Bc9fhN2CrGi8i19q/8wB0AYkT1cCvycV3x6CHk9VyKcycnpAEw
1R0Dp4cTz5KmKBa/RxtZ6dDXnnB+H8+Lo5MaQmcS3athAoPpQdmp0eOscIkJRXfL
9pimJOufMt1hiQuDwiwV0e4qcuFkz+sMlVoj7SwdWAoqVZjxZCfEHOaZ0soqyclo
+XITshxricWdY+/w8S2IZwDR6jqs1yzhzMNLKxa5k1N5dgsb/fRtZF84nud/qsDb
6WN2igYy1cquDPOe34GflBahPQGpPecamqeFN/u4lSJgLWtzXdA=
=eHr2
-----END PGP SIGNATURE-----

--nextPart5930028.PgqtcrPFqD--

