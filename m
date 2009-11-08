Return-Path: <hrogge@googlemail.com>
From: Henning Rogge <hrogge@googlemail.com>
Date: Sun, 8 Nov 2009 09:15:08 +0100
References: <871vkbzd6s.fsf@trurl.pps.jussieu.fr>
	<3F4B7F12-DB83-4483-AE6F-4B615E3A0AFE@lo-res.org>
	<7i4op5lt5r.fsf@lanthane.pps.jussieu.fr>
In-Reply-To: <7i4op5lt5r.fsf@lanthane.pps.jussieu.fr>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1625591.QiQvlDPyDF";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200911080915.12794.hrogge@googlemail.com>
Subject: Re: [B.A.T.M.A.N.] [Babel-users] [Olsr-users] A peer-reviewed
	assessment of OLSR, BATMAN and Babel
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
Cc: olsr list users mailing <olsr-users@lists.olsr.org>, The Ad-hoc Networking list for a Better Approach To Mobile <b.a.t.m.a.n@lists.open-mesh.net>, jerryw@uow.edu.au, Juliusz Chroboczek <Juliusz.Chroboczek@pps.jussieu.fr>, brett_hagelstein@uow.edu.au, mehrana@uow.edu.au

--nextPart1625591.QiQvlDPyDF
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Am Sonntag 08 November 2009 02:08:48 schrieb Juliusz Chroboczek:
> > I would have liked to see a comparison with OLSR.org default settings
> > (ETX metric) instead of hopcount metric.
>=20
> Agreed.
>=20
> Note however that this doesn't entirely explain why OLSR collapsed in
> their tests.  If you look at table I, you'll notice that in the case of
> node Babel did choose the shortest hop-count route, and Babel and OLSR
> exhibited similar levels of route flapping; in other words, in this
> particular test ETX and shortest-hop coincide.  However, Figure 2
> indicates that OLSR's throughput was half that of Babel, and in
> Figure 3, OLSR's packet delivery ratio was just 75%.
Good question. Maybe they activated an agressive MPR setting and hit a know=
n=20
bug in the dijkstra algorithm that can create problems with MPR settings (t=
he=20
bug is fixed in the development tree and the current 0.5.6 displays an erro=
r=20
message with the not-working settings).

Henning

--nextPart1625591.QiQvlDPyDF
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.13 (GNU/Linux)

iEYEABECAAYFAkr2fhAACgkQcenvcwAcHWeYQwCfWf2IX0DroEv5NDglTQNm951+
sH0An35m++xSXsbMGVp4ohl1VP1snREU
=eHiu
-----END PGP SIGNATURE-----

--nextPart1625591.QiQvlDPyDF--
