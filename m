Return-Path: <ben@decadent.org.uk>
Message-ID: <1484441452.2998.11.camel@decadent.org.uk>
From: Ben Hutchings <ben@decadent.org.uk>
Date: Sun, 15 Jan 2017 00:50:52 +0000
In-Reply-To: <20170114212803.GF3254@otheros>
References: <20170114212803.GF3254@otheros>
Content-Type: multipart/signed; micalg="pgp-sha512";
 protocol="application/pgp-signature"; boundary="=-qJ7zocg3uZiX9H0MSW+h"
Mime-Version: 1.0
Subject: Re: [B.A.T.M.A.N.] Duplicate #include guards with make-kpkg /
 out-of-tree compile errors
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Linus =?ISO-8859-1?Q?L=FCssing?= <linus.luessing@c0d3.blue>
Cc: b.a.t.m.a.n@lists.open-mesh.org, Manoj Srivastava <srivasta@debian.org>, Daniel Borkmann <daniel@iogearbox.net>, debian-kernel@lists.debian.org


--=-qJ7zocg3uZiX9H0MSW+h
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

kernel-package is maintained by Manoj Srivastava (cc'd), not the kernel
team.

Ben.

On Sat, 2017-01-14 at 22:28 +0100, Linus L=C3=BCssing wrote:
> Hi Ben and others,
>=20
> Recently we stumbled upon some compile errors when trying to build
> a backport version of the batman-adv kernel module for a 4.5 kernel
> [0]:
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0"implicit declaration of function =E2=80=98G_TC_A=
T=E2=80=99"
>=20
> It seems VirtualBox has stumbled over this issue, too [1].
>=20
> When trying to find the cause of these errors we noticed that the
> headers directory created via "$ make-kpkg kernel_headers" for 4.5
> kernel resulted in two differing header files with the same guard,
> namely __LINUX_PKT_CLS_H:
>=20
> https://metameute.de/~tux/batman-adv/net-sched-issues/linux-headers-4
> .5.0%2b/include/uapi/linux/pkt_cls.h
> https://metameute.de/~tux/batman-adv/net-sched-issues/linux-headers-4
> .5.0%2b/include/linux/pkt_cls.h
>=20
> The latter, the non-uapi version, has the "#ifdef __KERNEL__"
> section stripped, causing the compile issue if it is included
> before the uapi variant.
>=20
> Removing this non-uapi version from the unpacked
> linux-headers .deb package manually afterwards lets
> a batman-adv compilation succeed again.
>=20
> Daniel (CC) has helped a lot with debugging so far and he
> expressed the suspicion that maybe make-kpkg might install
> "$ make headers_install" into the wrong directory?
>=20
> Regards, Linus
>=20
> [0]: https://www.open-mesh.org/issues/322
> [1]: https://www.virtualbox.org/ticket/15327
>=20
> PS: make-kpkg was invoked on a Debian Jessie (kernel-package
> 13.014+nmu1).
--=20
Ben Hutchings
Hoare's Law of Large Problems:
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0Inside every large problem =
is a small problem struggling to get
out.


--=-qJ7zocg3uZiX9H0MSW+h
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEErCspvTSmr92z9o8157/I7JWGEQkFAlh6x2wACgkQ57/I7JWG
EQlgmhAAhN4gAvv+yAKB3oOhscprFx/qC0cxjhWn4VZM9thkEfJwACZuw1Xi51Js
pPff3A2da/3kH+JIyJs/J1zLFjO4y7/jSDRZ8jVEDquZi6AKE1Cj7e/QgnMNf5oC
abZl7Q7oTN2RBQyvYnbu2TIaSdfYk+/GJ0/xxRIYU7ApQ17QMjvT9gWZhL9Q6ten
s4zSsu4L1iwowg7qHqKqJoMD4TCtFyd1FsJ181fQCeD6lb5cCpJ556SOyotW0buJ
lENrmz+54ODfOxMg873x3B5j9fhLMOYMT/JQ2jNlBOGeqzpdwpRslQHp78a5b2RW
R9aZ9G1r7ws4rm7HcYqXjb+LikIK8qlaNKiqYeseA47lo6o12ps7aR3PnBSqLy/h
56F9YTwQdy9B6PuoOjyNswtaugX7ayYJlmZocgFDbBcpav/FuDMpGGPAgoYU1m3G
AGb1vLoK04WVK/QjdhxZmwopNSG/He/Gd4Y7E/EHJ2xrfWzcQ0/bw9ijJLmlvy7o
ZxqbxDXqlL8UI+YXpN1STYyx3WabAb0P4nXLwD6jkm6GWdSPYhFJ9NjBdRR3gdix
nnO202srfww30OTsvSeYRNtu006WL6AMdRmHkuckPkhP6q8L9UnqQmK1V35RxS7W
szqq5WnligjsVGENzLLeEbil+ul0mrUei8MWTx5vJ+N70n6T03g=
=etkU
-----END PGP SIGNATURE-----

--=-qJ7zocg3uZiX9H0MSW+h--
