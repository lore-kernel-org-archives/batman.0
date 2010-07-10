Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Sat, 10 Jul 2010 10:40:52 +0200
References: <1277504905-27672-1-git-send-email-sven.eckelmann@gmx.de>
	<201007100107.57451.sven.eckelmann@gmx.de>
	<4C37C205.3030003@tiwoc.de>
In-Reply-To: <4C37C205.3030003@tiwoc.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1311734.JUTrkQqtVJ";
	protocol="application/pgp-signature"; micalg=pgp-sha512
Content-Transfer-Encoding: 7bit
Message-Id: <201007101040.53995.sven.eckelmann@gmx.de>
Subject: Re: [B.A.T.M.A.N.] Staging: batman-adv for 2.6.36 (3)
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
To: b.a.t.m.a.n@lists.open-mesh.org

--nextPart1311734.JUTrkQqtVJ
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Daniel Seither wrote:
> Am 10.07.2010 01:07, Sven Eckelmann wrote:
> > batman-adv works quite well for us - but that doesn't mean that it is
> > good in context of the current kernel development. And who should know
> > it better than the netdev guys.
>=20
> Hagen Paul Pfeifer suggested in his message "a generalized architecture
> and a user space implementation of the protocol". What came to my mind
> when I read this again was a division of control plane and
> data/forwarding plane as known from traditional routing.
>=20
> The whole forwarding stuff would stay in the kernel, using a simple
> routing table (for destination X, send to node Y on interface Z).

This would go against the bonding/alternating functionality.

> The
> processing of routing messages (OGMs) and creation/update of the routing
> table based on the full originator table could be moved to a user space
> daemon. Relative to packets of regular data transmissions, routing
> messages are not sent and received that often such that processing them
> in user space should not hurt performance (very much), especially when
> compared to the original implementation of batman-adv in the user space.
>=20
> Firstly, this approach would improve the architecture by separation of
> concerns, which makes it easier to understand, debug and maintain the
> code. Secondly, it would get easier to play with / improve the routing
> protocol and the metrics if the latter parts were implemented in user
> space. And maybe it is indeed possible to make the kernel part of the
> code agnostic to the used protocol implementation, which would lead to
> the generalized architecture that Hagen envisioned.

Yes, that was what I wanted to discuss with him further. I tried to express=
 my=20
view about that topic using

  But it does not work for things which must route ethernet frames as there
  does not exist such a framework and it is hard to create one which everyo=
ne
  will like and has enough information to provide all features they need.

Yes, I could imagine that this is an alternative route which could be elega=
nt=20
and successful, but the hard part is that we don't have anything that is=20
really sufficient to be the general routing framework (see for example the=
=20
unicast fragmentation which is added quite late.. or at least proposed quit=
e=20
late). There are even more things coming which are related to some parts of=
=20
the multiple gateway handling (I never saw the implementation of the part I=
 am=20
referring to, but as far as I can follow the explanation the routing code m=
ust=20
be adjusted again when we want to handle the non-dhcp/ndp multiple gateway =
for=20
redundant paths to the non-mesh world situation).

Lets check what we may remove from kernelland when move everything to=20
userspace (but don't forget, that the formular would be:
 sizeof(kernelpart) + sizeof(userpart) >> sizeof(current kernelland part)

 * aggregation.* -> complete to userspace (but creates lot of jitter).=20
 * bat_debugfs.* -> nearly nothing moves to userspace
 * bat_sysfs.* -> around 60-70% stays inside the kernelland
 * bitarray.* -> stays inside the kernel
 * hard-interface.* -> stays inside the kernel
 * hash.* -> stays inside the kernel
 * icmp_socket.c -> stays inside the kernel
 * main.* -> stays inside the kernel
 * originator.* -> moves to userspace
 * ring_buffer.* -> moves to userspace
 * routing.* -> 80-90% stays inside the kernel
 * send.* -> 60% stays inside the kernel
 * soft-interface.* -> stays inside the kernel
 * translation-table.* -> stays inside the kernel
 * vis.* -> moves to userspace=20

This is a quite sketchy list and may misses some important points.=20
Nevertheless we see that probably most of the code is just the routing/devi=
ce=20
stuff. So we could really think about splitting batman-adv in two parts: SE=
MF=20
(simple ethernet mesh framework) and batman-adv (the part which does the=20
discovery and route management). This doesn't mean that we really move to=20
userspace, but that we have a better separation between those two parts ins=
ide=20
the kernelland.

The first step would be to have more than one soft-interface.

This doesn't mean that this move is good (or bad), but it is a lot smaller=
=20
step which can be discussed much more in detail without forgetting most of =
the=20
important parts while discussing kernelland<->userspace interfaces.

Best regards,
	Sven

--nextPart1311734.JUTrkQqtVJ
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIcBAABCgAGBQJMODIVAAoJEF2HCgfBJntGXBgP/RRHDTTy6NuG5NijeCGDLU+n
MFZQHTeG2JyuEFiBPW/iSVC3X3GJuKaM+4BkMK99367xXsqbedxpkbQiSlwcV46S
vX2+Zwrt9MCuzmFNmK2s6S+yWyPGzpHwtXFYfnENZiY9ReH5jDCXKF3X1nd895B9
/yzUEPmDBwN9rNSUZfr/e905bhuFJ8jyJdlwnBshIl8OwkpHBl+iq5BH7u5RBz9V
arg/vNJ8BkDHuggnVGWUWxmhAS5b8Vq4TU4OaDydINx4v1bEb3ZzFackI6tFn46o
jI+OYOcDi48q25/7DZwSoi/VW4IIrYL+ShciYFZ3FtPqpdXbuKer+yxho/8IqwP5
at/vIuEJyJjkDSTzold9Sm4lLlJrC16mF0mtbbnIs9HM1Jh306p7QMmdPzhlCvfm
v6/guN/iIgzo5vCe1zXOOdHGTkJN3P7LnCWdX+fZ2WpowDNztlO1Dle8RrU3ZYYp
ooprJuGTJhsHtFC8npP1FLNenOaxnSspAOKhrlqPnsOQJGkxUPNhgvSeKCNCx07/
Yum6kYNWWGvfRlMa92cInEPE/6SDIff5h4tMNryNOMqI+jZLPsdqIh6NZozqlYMO
jDGKk8jJGM5oYVh6+x+v4qP+ZfZkWhSI+dScCtSCnP5OXh7D7eDib96ndJyEfPAo
F6Obfd7XHTVDeEfH21VG
=CKyo
-----END PGP SIGNATURE-----

--nextPart1311734.JUTrkQqtVJ--
