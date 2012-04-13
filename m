Return-Path: <ordex@autistici.org>
Date: Sat, 14 Apr 2012 00:13:52 +0200
From: Antonio Quartulli <ordex@autistici.org>
Message-ID: <20120413221351.GA19795@ritirata.org>
References: <1334214449-3996-1-git-send-email-ordex@autistici.org>
	<1334214449-3996-4-git-send-email-ordex@autistici.org>
	<201204132304.23485.lindner_marek@yahoo.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="bp/iNruPH9dso1Pn"
Content-Disposition: inline
In-Reply-To: <201204132304.23485.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCHv3 3/3] batman-adv: use static inline
 functions to fake not compiled-in routines
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


--bp/iNruPH9dso1Pn
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 13, 2012 at 11:04:23 +0200, Marek Lindner wrote:
> On Thursday, April 12, 2012 09:07:29 Antonio Quartulli wrote:
> > In case of not compiled-in components, we need to fake some functions in
> > order to let the rest of the code correctly build. But instead of using
> > something like:
> >=20
> > We have to use:
> >=20
> > static inline bla_init(struct bat_priv *bat_priv)
> > {
> >         return 1;
> > }
> >=20
> > In this way the compiler can correctly check the type and the number of=
 the
> > arguments passed to the function, even if the related component (bla in
> > this case) is not compiled.
>=20
> The same needs to be done for DAT, right ?

Exactly.
the next pull request should contain this change also for DAT. Moreover we
should provide a sysfs mechanism enable/disable DAT at runtime, so that peo=
ple
can disable it on all the nodes without the need of rebuilding the module.

Cheers,

--=20
Antonio Quartulli

=2E.each of us alone is worth nothing..
Ernesto "Che" Guevara

--bp/iNruPH9dso1Pn
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQEcBAEBAgAGBQJPiKUfAAoJEFMQTLzJFOZFXQcH/3S+VabkEWfgtrOqLqhOst8N
nxhlVpYDjfRFQoaPmXQACw9UZ+Wz8tymScNvtMF2WVcrwFah1Kj3CCs2mmKf1b4A
DTiGXykYQEGw3qksZoi30SPHeSf0G2i/DU46/QOxCpGepOTQ3SErc5kjGRtoQmiC
IZrF71x4CjtZs3XY/UXnKbqh/v0NWy9RjIdOqRLdMrHqcWe2MPMqM8+XtBLgySsc
mvoZqISipLlyy0NAPrMWob7M8hCao7p6nZf0P8eY9IDcqguSdDfRTvIhKj0FEaMq
fM16HeQnr3um5bAQYZCR/aQ4KxnO5YhtSjWcc1qgnaZb/fEZ/fQli40bU9HWdDs=
=QaOb
-----END PGP SIGNATURE-----

--bp/iNruPH9dso1Pn--
