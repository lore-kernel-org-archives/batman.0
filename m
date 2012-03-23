Return-Path: <ordex@autistici.org>
Date: Fri, 23 Mar 2012 08:51:46 +0100
From: Antonio Quartulli <ordex@autistici.org>
Message-ID: <20120323075145.GC16353@ritirata.org>
References: <201203222250.31309.lindner_marek@yahoo.de>
	<20120323063418.GB5662@lunn.ch>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="5G06lTa6Jq83wMTw"
Content-Disposition: inline
In-Reply-To: <20120323063418.GB5662@lunn.ch>
Subject: Re: [B.A.T.M.A.N.] [RFC] ELP
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


--5G06lTa6Jq83wMTw
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 23, 2012 at 07:34:18AM +0100, Andrew Lunn wrote:
> > cat /sys/kernel/debug/batman_adv/routing_algos=20
> > Available routing algorithms:
> > BATMAN IV
> > BATMAN V
> >=20
> > To activate B.A.T.M.A.N. V (ELP) you should run the following command *=
before*
> > adding any interface via batctl:
> >=20
> > echo -n "BATMAN V" > /sys/module/batman_adv/parameters/routing_algo
>=20
> Hi Marek
>=20
> How about BATMAN_V and BATMAN_IV, so avoiding the need for "" or \
> escaping of the space?

I agree :) Spaces are baaaad (and ugly :P (and error prone))! I already ima=
gine a number of people
trying to change protocol without using quotes.

Cheers,


p.s. Marek thank you very much for your work

--=20
Antonio Quartulli

=2E.each of us alone is worth nothing..
Ernesto "Che" Guevara

--5G06lTa6Jq83wMTw
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.18 (GNU/Linux)

iQEcBAEBAgAGBQJPbCuRAAoJEFMQTLzJFOZFlBgH/01LAIrkT7cl6ZOB4hBC38vC
W28dtEjcM6GoKCqVb4CZDKzYiTkW8BxG9+p+SfS/DkK31Em4Dq8eiLaa/fuAET2J
ikPKENyjfrMMWMcqG/b5ZN2I8/t7D6J8c88flRxlDOXqR4fqgrEAUTbwJdkxRiIF
oaHot3e5lUDPx5Clyx5UECctcQEB7y/tnofwgqKsRtG+LlWRzspCuDbUweGJt9P6
ogOm8Qhm2BaNGJJR5U90CvA+lOX73CLWqH+Yv88FthuAhXF+wbRmhBs2rc2uCjui
/3sW1FeWbd4qa1bS/8+pUH/QniLPqNw/k+13P10Tq2cielBbtKqjtNC5Sjk4cLs=
=7YUu
-----END PGP SIGNATURE-----

--5G06lTa6Jq83wMTw--
