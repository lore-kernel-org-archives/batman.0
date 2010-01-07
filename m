Return-Path: <linus.luessing@web.de>
Date: Thu, 7 Jan 2010 22:43:44 +0100
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@web.de>
Message-ID: <20100107214343.GA2554@Linus-Debian>
References: <200912181714.58212.lindner_marek@yahoo.de>
	<DE721D43-8031-4174-8357-DE4A475A7898@dd19.de>
	<201001072123.32104.lindner_marek@yahoo.de>
	<914B198A-C2DA-4222-9306-B81CFFE88284@dd19.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="2oS5YaxWCcQjTEyO"
Content-Disposition: inline
In-Reply-To: <914B198A-C2DA-4222-9306-B81CFFE88284@dd19.de>
Sender: linus.luessing@web.de
Subject: Re: [B.A.T.M.A.N.] B.A.T.M.A.N. V outlook
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


--2oS5YaxWCcQjTEyO
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Moin Alex,

On Thu, Jan 07, 2010 at 05:10:39PM +0100, Alex Morlang wrote:
>=20
> Am 07.01.2010 um 14:23 schrieb Marek Lindner:
>=20
> >On Thursday 07 January 2010 15:44:36 Alex Morlang wrote:
> >>are you considering attaching metrics to HNA?
> >
> >That is not necessary as each non-batman host is connected to a
> >batman host
> >which has a metric. Therefore the implementation just needs to
> >support the HNA
> >metric. The batman daemon does so since quite a long time. It is
> >on the
> >feature list for batman-adv 0.3 but does not require any protocol
> >changes
> >unless I miss your point.
At the moment, every mac address announced by a batman-adv node in
the mesh network has the same value. In an open mesh network an
evil batman-adv node could do some serious DoS attacks. Therefore
it is planned to prefer HNAs from the closest batman-adv node
in batman-adv 0.3 instead so that such an attack would be limited
to the local area only. As Marek already pointed out, this
behavior had already been implemented in batman-daemon (the old
layer 3 version) and would probably just need to be ported without
any internal batman-adv protocol changes.
>=20
> maybe you do, as you might have costs between the connected network
> and the connecting batman node.
In general, batman-adv adds a little header of 24 Bytes. But this
kind of extra cost also applies to packets between batman nodes,
not only when a packet comes from the connected network. So if you
are bridging any other networks/hosts into the mesh network (i.e.
bridging eth0 + bat0) does not matter, you should just a) increase
the MTU of the mesh-interfaces to 1524 which is usually not a
problem for wifi interfaces or b) decrease the MTU on all hosts to
1476 (usually not so do-able).
> when you have more then one batman node connecting a network to the
> mesh, this costs should be relevant.
Hmm, well, batman-adv is adding the HNAs stating the
hosts' mac addresses behind a certain batman-node (the bat0
interfaces directly or nodes being bridged into this one) to its
originator messages, which get flooded one in a second by default so
far. Do the maths how bad that might be for larger mesh networks
(keeping the intended packet loss of wifi in mind).
>=20
> >
> >
> >>How about ipv6?
> >
> >I can't follow you here. The length of the protocol identifier (IPv4
> >address/IPv6 address/mac address/random number) is not relevant
> >for the
> >routing protocol.
> >
>=20
> ok, i thought you were talking about an implementation, so i asked
> about support for this addresstype.
>=20
> so am i right in thinking the next batman will be protocol independent?
batman-adv is operating between layer 2 and 3, you can use ipv6,
ipv4, ..., any layer 3 internet protocol you like. And this has
already been supperted in previous versions, this won't be a new
feature of a batman-adv 0.3 version :).

> >Regards,
> >Marek
>=20
> Gruss, Alex
>
Cheers, Linus

--2oS5YaxWCcQjTEyO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIcBAEBAgAGBQJLRlWPAAoJEBKw7u43QNpfSNoP/REYB8Z8d94VbhAGLXsnT3N1
9ZmTc0UOGf7NLRH4OXz2Ej7iz3/soOa0lwUc7fSFEiK/rCzIvefWZQqeatgeMp0G
sx32QtvoiEOlQP+pQiu4a5gXUqIgIWaEXHeFi4XI8oW7+K+L9spWz2udnYh4M87x
AR8TuY/cVRjUTo5qCteWqsijuF7MRERXVag0ueZ5YUNTXJ8NuDhQ8ye9yEOjiah/
LGFI5qZXFpwKhpxHeGPc1CS/Jd1NosFz8CMjyKlzzPvOXW+p0EER4CwmpwZY1ZQE
wJIPpk3vQBkl6As4c9eb4+vKBOjevpQsaCj8PeX5h3mwK/lV2mLdeebmoAu6tW5F
QvcZPiQOz/62/4Cs4Ycql5sduHkEdaSkvcxH/gF/OsLia9FqrDH3rRkMXA3mo/DK
M/mJQvEVBRLuCVElpwts7ZZuB1U5NI1b6s4GsPj9kMFztQge1KbTavalYn+Kmt4H
CdxrU3cFKqZ0PYGmi7g/s8bLb64MoXsTnWNruXG/xTRAcLciVZfMPMYpVkF43AyW
p4a82SiOmyrOONf0mhnJRpLF4YVFSGuHSNISCv5cJ7mucz7Ap7WHVstRPhBSaSOP
qaEzs0R+ApBiNaget3+uorjPQc3P1FN9LGfpuesXoYDmKMfPmwvu2cFwPROSG8nF
XBJRwEAmevg50lM0wONl
=VWlG
-----END PGP SIGNATURE-----

--2oS5YaxWCcQjTEyO--
