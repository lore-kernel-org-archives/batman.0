Return-Path: <ordex@autistici.org>
Date: Mon, 2 Jul 2012 16:36:04 +0200
From: Antonio Quartulli <ordex@autistici.org>
Message-ID: <20120702143604.GD2917@ritirata.org>
References: <CAHD-aqJUX0LxRfxrqJL4-oc7+QxLRdfiHikY40FvafL3pgEUyw@mail.gmail.com>
	<CAHD-aqK-SrQ0VxmrZSzq3gb_aVZQY5ZYxN7qjdC8dind+jgeuw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="orO6xySwJI16pVnm"
Content-Disposition: inline
In-Reply-To: <CAHD-aqK-SrQ0VxmrZSzq3gb_aVZQY5ZYxN7qjdC8dind+jgeuw@mail.gmail.com>
Subject: Re: [B.A.T.M.A.N.] batman majareta? I can batctl ping but not ping
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


--orO6xySwJI16pVnm
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 02, 2012 at 10:57:57AM -0300, Guido Iribarren wrote:
> > I used arping, with and without -b , and seemed like i could narrow
> > the problem down to incoming broadcast packet handling, but further
> > tests just left me more puzzled!
>=20
> Well, seems colmena is the uncooperative bathost
> another log:
> http://pastebin.com/FMD9Lieq
> that can be summarized as follows
>=20
> ### From COLMENA-CASA, can ping bochita but not ana
> ### From PEREYRA, can ping bochita but not ana
> ### From COLMENA, works perfect to both destinations
>=20
> colmena-casa and pereyra must pass through colmena, which is for some
> reason allowing batctl pings , ogms , and whatnot passthrough in its
> way to ana, but no ICMP echo requests, or tcp traffic whatsoever if
> it's final destination is ana.
> if final destination is bochita, everything works as expected.
>=20
> Any ideas?
>=20
> I'm going to delay rebooting colmena as long as i can, in case someone
> comes up with an insightful test to run :)

Hello!

Has debug support been compiled in batman-adv? IF yes, it would be interest=
ing
so see the output of the tt log (batctl ll tt; batctl l)

Recently we fixed a bug that which fix has not been released yet. If we are=
 sure
that this is the cause, you could eventually try an upgrade to a more recen=
te
dev-version. But let's see the log first (if possible)

Cheers,

>=20
> Gui

--=20
Antonio Quartulli

=2E.each of us alone is worth nothing..
Ernesto "Che" Guevara

--orO6xySwJI16pVnm
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iEYEARECAAYFAk/xsdQACgkQpGgxIkP9cwd4mwCfeNblQzCtBrUysVPolI0YD8Nl
FTAAn0TRG9U5IoOLHutbL5Dl6sizOu1F
=4kKU
-----END PGP SIGNATURE-----

--orO6xySwJI16pVnm--
