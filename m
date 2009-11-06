Return-Path: <hrogge@googlemail.com>
From: Henning Rogge <hrogge@googlemail.com>
Date: Fri, 6 Nov 2009 23:55:38 +0100
References: <871vkbzd6s.fsf@trurl.pps.jussieu.fr>
In-Reply-To: <871vkbzd6s.fsf@trurl.pps.jussieu.fr>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1292641.jWL0EGKbx3";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200911062355.43624.hrogge@googlemail.com>
Subject: Re: [B.A.T.M.A.N.] [Babel-users] A peer-reviewed assessment of OLSR,
	BATMAN and Babel
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.net>
List-Unsubscribe: <https://lists.open-mesh.net/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=help>
List-Subscribe: <https://lists.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=subscribe>
To: babel-users@lists.alioth.debian.org
Cc: olsr-users@lists.olsr.org, b.a.t.m.a.n@lists.open-mesh.net, jerryw@uow.edu.au, Juliusz Chroboczek <jch@pps.jussieu.fr>, brett_hagelstein@uow.edu.au, mehrana@uow.edu.au

--nextPart1292641.jWL0EGKbx3
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Am Freitag 06 November 2009 20:05:31 schrieb Juliusz Chroboczek:
> I've just come upon an interesting paper that experimentally compares
> the performance of OLSR, BATMAN and Babel.
>=20
>     Real-world Performance of Current Proactive Multi-hop Mesh
>     Protocols.  M. Abolhasan, B. Hagelstein, J. C.-P. Wang.
>   =20
>  http://ro.uow.edu.au/cgi/viewcontent.cgi?article=3D1747&context=3Dinfopa=
pers
Interesting link Juliusz, thank you.
=20
> Short summary: see Table II on the last page.
>=20
>=20
> A few comments on the paper:
>=20
> 1. Section II (the informal description of the protocols) doesn't make
>    much sense.  Ignore it.
>=20
> 2. They evaluated original OLSR, not OLSR-ETX as used by our friends in
>    Vienna and Berlin.
This is the bane of the OLSR protocol. Most people not doing mesh-research=
=20
just "use the RFC compatible OLSR" to compare it with anything else... and=
=20
discover (as we all know) that hopcount metric does not work. I'm fighting =
for=20
including a simple ETX implementation into the coming OLSRv2 RFC at the=20
moment.

Henning Rogge

--nextPart1292641.jWL0EGKbx3
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.13 (GNU/Linux)

iEYEABECAAYFAkr0qW8ACgkQcenvcwAcHWflvACff6LoKokHz6AsQAEdB5qsfTZ9
HRwAnj4jfhdQHX7w2GnhxQYD1RPkqkLb
=Qg27
-----END PGP SIGNATURE-----

--nextPart1292641.jWL0EGKbx3--
