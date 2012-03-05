Return-Path: <ordex@autistici.org>
Date: Tue, 6 Mar 2012 00:11:06 +0100
From: Antonio Quartulli <ordex@autistici.org>
Message-ID: <20120305231105.GD31430@ritirata.org>
References: <1330933911-6320-1-git-send-email-ordex@autistici.org>
	<201203060352.47058.lindner_marek@yahoo.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="OBd5C1Lgu00Gd/Tn"
Content-Disposition: inline
In-Reply-To: <201203060352.47058.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: avoid ap_isolated check for
 broadcast packet
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


--OBd5C1Lgu00Gd/Tn
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 06, 2012 at 03:52:46AM +0800, Marek Lindner wrote:
> On Monday, March 05, 2012 15:51:51 Antonio Quartulli wrote:
> > in case of a broadcast packet, the result of the ap_isolated check is
> > always false (since we have no ff:ff:ff:ff:ff:ff client to check for
> > TT_CLIENT_WIFI), therefore we can avoid searching the translation table
> > and we can return false directly
>=20
> How about also checking the source address ?

Actually I assumed that "legal" data only is passed to this function and so
there should be no need to check for the source address as well.

But I think this assumption is wrong, right? Actually the "internal" data o=
f a
unicast/broadcast packet is never checked and so I should not assume that t=
he
addresses passed to this function are legal.

> You probably also should add similar checks for tt_local_add() ?

Yep, we probably want to have the same checks in tt_local_add() because a w=
ired
client could send any spoofed packet and we should protect our tables from =
them.

> Or do we have "legal" cases in which we announce multicast addresses ?

Not that I know (right now)


Cheers,
and greetings from Bruxelles

--=20
Antonio Quartulli

=2E.each of us alone is worth nothing..
Ernesto "Che" Guevara

--OBd5C1Lgu00Gd/Tn
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.18 (GNU/Linux)

iQEcBAEBAgAGBQJPVUgJAAoJEFMQTLzJFOZFS9QH/1V685LhBF0BSiqkfSj4LePQ
/jsYb1VOUOjvNDEVWkp8ziYKAdHwUAROqxv1Sb5bSVL2hTNfpnezD3TlWxsxCv0D
niVtHvZOHbnsrGbk3AVrdxbkIxRGl47olV+adR52Vbd0Y/VGO2hBOFb2PjWv19Up
cW+i/ENYQA6BZ+1HdjxFagqm3dtJMylGIA9HoF+j6s+2PLYAaL3biTkkkC4NZ6t6
v6qZE1J2Ji9YwomX++JGHLAgUImFtsM857cTdpNNJJ7OPc7jEUILtjQm9rWu5AIj
HQ69DXhYXQNIEttrhOX6MS/xIJ3mFRopE4U+W7KwqbO9RTIUVhjADxwkBaPjYwU=
=5I2G
-----END PGP SIGNATURE-----

--OBd5C1Lgu00Gd/Tn--
