Return-Path: <ordex@autistici.org>
Date: Mon, 16 Apr 2012 14:40:06 +0200
From: Antonio Quartulli <ordex@autistici.org>
Message-ID: <20120416124005.GE24938@ritirata.org>
References: <CAKLmikNxzz_zNwui4xejaAgvXXsHrTUGCPG+UT-cSH5iP3cEJw@mail.gmail.com>
	<201204161237.37008.lindner_marek@yahoo.de>
	<CAKLmikMRRkrvB3Kgga51hJ=GygEto_KqLCp9TwTPseyK4gJsOw@mail.gmail.com>
	<201204161258.04262.lindner_marek@yahoo.de>
	<CAKLmikPWjXYVqQkJLK=j9DB_1+cNjLsrZ3j9kHGf6SiBbusOvw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="z+pzSjdB7cqptWpS"
Content-Disposition: inline
In-Reply-To: <CAKLmikPWjXYVqQkJLK=j9DB_1+cNjLsrZ3j9kHGf6SiBbusOvw@mail.gmail.com>
Subject: Re: [B.A.T.M.A.N.] Migration to Batman
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


--z+pzSjdB7cqptWpS
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 16, 2012 at 02:32:09PM +0200, Mitar wrote:
> Hi!
>=20
> On Mon, Apr 16, 2012 at 12:58 PM, Marek Lindner <lindner_marek@yahoo.de> =
wrote:
> > If you already have a shell script uevent definitely is the way to go. =
It is
> > far easier to script than netlink.
>=20
> Yes, but are there uevent events for node reachable/unreachable?

Actually there is only one class of event: Gateway event.
A Uevent is sent to the userspace each time the node ADD/DELETE/CHANGE its =
own
batman-adv-GW. Actually, if the batman-adv-GW is co-located with the L3 GW,=
 you
can use this event to understand whether you have or not a default route in=
 the
network (assuming that I correctly understood your scenario).
>=20
> Are those uevents already available? Do we know of any existing
> routing protocol being capable of using them?

Uevents support is in the batman-adv code, but as I told you before we only=
 have
GW events right now. But the code is easily extendible for other uevents :)

Then, in the userspace you can use UDEV to handle such uevents and do somet=
hing
you like (e.g. triggeringa bash script, relaunching another daemon, whateve=
r..)

Cheers,

--=20
Antonio Quartulli

=2E.each of us alone is worth nothing..
Ernesto "Che" Guevara

--z+pzSjdB7cqptWpS
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQEcBAEBAgAGBQJPjBMlAAoJEFMQTLzJFOZF+ZMIAL9j3oKxC5o0DfXkVQqsCcCJ
vFhdlkuBQfA7RmMlSR3w3MXcpd3KC1MZPW6L4PaBlrw1etiIUUmMWL0kK517r14a
rv7a+ML1zir9ZXUtu6WbqpsAjHLUejA2CYGAvfsUTJqX5EfFApspMko7/4eKpyRs
glaw7RZg/KTDKhb1Zwrl+n+B18avB7Xrdfpt2AlZ4+cqdv+sukG5Gjig8N+GBdMK
HAv5BkXdgS7K8HTdAqN4QiJN6nvCp7zc83U9ecINKCtCKuFnqBa9fRVMcDe/mztK
LF0DeM4qSOeJHwoWFpajV/Hwa+Eqm2pro0pRlU9bpsHrZWf7dXfWEIRVKnJ1PYs=
=dGda
-----END PGP SIGNATURE-----

--z+pzSjdB7cqptWpS--
