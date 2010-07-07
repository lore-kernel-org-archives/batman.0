Return-Path: <clemens-john@gmx.de>
From: Clemens John <clemens-john@gmx.de>
Date: Wed, 7 Jul 2010 13:25:51 +0200
References: <201007061948.05784.clemens-john@gmx.de>
	<201007070145.39178.clemens-john@gmx.de>
	<201007071316.11906.lindner_marek@yahoo.de>
In-Reply-To: <201007071316.11906.lindner_marek@yahoo.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1574587.sGQEZH8Op3";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <201007071325.56772.clemens-john@gmx.de>
Subject: Re: [B.A.T.M.A.N.] Batman advanced and internet gateways
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

--nextPart1574587.sGQEZH8Op3
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable

Am Mittwoch 07 Juli 2010, 13:16:11 schrieb Marek Lindner:
> > Our current setup makes not much sense if we use Batman advanced with
> > gateway mode because we do not have a gateway in each cloud and it would
> > be difficult to get one to each cloud.
> > The best way would be a solution that can use all gateways available in
> > the network without extra configuration for each cloud.
>=20
> This sounds overly complicated. I don't fully understand your setup &
> requirements yet which is also one reason for asking for documentation.
> What your are trying to solve is this (I'm guessing here):
>=20
> wifi client <> batman node <> VPN <> batman node <> batman with internet
>=20
> And you have several of these "batman with internet" but not in each cloud
> and want each client to choose its best ?

Right and the wifi clients have no batman advanced installed. Currently the=
y=20
are getting their IP and defaultroute from a central dhcp server.

Thank you
Clemens

--nextPart1574587.sGQEZH8Op3
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEABECAAYFAkw0ZD8ACgkQZgdHbA22lqPICQCgyBGwOMXjwLCi0P7kRuvmRIN1
kvQAoKBqTmxNqQvpET4X07j+Jap71cJZ
=1rO4
-----END PGP SIGNATURE-----

--nextPart1574587.sGQEZH8Op3--
