Return-Path: <ordex@autistici.org>
Date: Mon, 16 Apr 2012 13:03:00 +0200
From: Antonio Quartulli <ordex@autistici.org>
Message-ID: <20120416110259.GD24938@ritirata.org>
References: <CAKLmikNxzz_zNwui4xejaAgvXXsHrTUGCPG+UT-cSH5iP3cEJw@mail.gmail.com>
	<20120413055947.GH7664@lunn.ch>
	<CAKLmikPJBmk=Xoom0a1D2OFfx6o8OtSk7D4PdT3TDXDx9iyO1A@mail.gmail.com>
	<201204161237.37008.lindner_marek@yahoo.de>
	<CAKLmikMRRkrvB3Kgga51hJ=GygEto_KqLCp9TwTPseyK4gJsOw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="PGNNI9BzQDUtgA2J"
Content-Disposition: inline
In-Reply-To: <CAKLmikMRRkrvB3Kgga51hJ=GygEto_KqLCp9TwTPseyK4gJsOw@mail.gmail.com>
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


--PGNNI9BzQDUtgA2J
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 16, 2012 at 12:46:35PM +0200, Mitar wrote:
> Hi!
>=20
> On Mon, Apr 16, 2012 at 12:37 PM, Marek Lindner <lindner_marek@yahoo.de> =
wrote:
> > Note: Whoever is going to implement that should think about the implica=
tions
> > of mesh clouds periodically connecting and disconnecting. A lot of even=
ts
> > could be fired over and over again.
>=20
> We made such extension to olsrd (which runs given bash script) and I
> think it is the consumer who needs to take care to aggregate/average
> those events and so on. Batman logic could be very simple.
>=20
> > You don't need to run another routing protocol "on top" of batman-adv. =
You only
> > run it to announce "stuff". You can simply run your routing protocol of=
 choice
> > to announce the routes.
>=20
> Announcing and checking for node reachability, no? And the second part
> still require some additional bandwidth, no?

We are not talking about another "wireless oriented" routing protocol, which
would need to measure link quality (cost) and announce it. We are talking a=
bout
something like OSPF/BGP/RIP which can be configured to announce routes only
(actually I think this is the standard way they work and this is also the r=
eason
why they are not suitable for wireless networks).

Cheers,


--=20
Antonio Quartulli

=2E.each of us alone is worth nothing..
Ernesto "Che" Guevara

--PGNNI9BzQDUtgA2J
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQEcBAEBAgAGBQJPi/xjAAoJEFMQTLzJFOZFzp8IAJBZ5qxf4VAx9xE8uVRs6nTy
Yld8UmAJP6FqQlIEdVuhorCYNO4rou4U6JDXsvwJEsRsXzId2+lo943IycCBsd4V
4EWxFClYPEkpWR88J4QBkM2qGEXgZ6CJ8zJIYuAozLgOE7nafGhUrOk7NJHS09kq
+DuRkQ6Ss7QDyIo6sLP1YmqSlNgovWv2Q6OC7RP2hr6fzUGUvOC5CY89Vw4syqQF
ytigd38H6U5HlUS97hPJ2oMmsfBIq8ehEUMATY0dgc5u2yMC7AetCqk1JdODw+5h
ALbvLbAKrvssYOaBNIkYvE1xm7OOJxsYPImAr4U/3TzO4dLVRHIXdQfMZpbKq1w=
=+dib
-----END PGP SIGNATURE-----

--PGNNI9BzQDUtgA2J--
