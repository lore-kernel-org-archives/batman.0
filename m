Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Sat, 10 Jul 2010 11:09:44 +0200
References: <1277504905-27672-1-git-send-email-sven.eckelmann@gmx.de>
	<201007101040.53995.sven.eckelmann@gmx.de>
	<201007101055.11401.hrogge@googlemail.com>
In-Reply-To: <201007101055.11401.hrogge@googlemail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2758813.6Ny0PAtlId";
	protocol="application/pgp-signature"; micalg=pgp-sha512
Content-Transfer-Encoding: 7bit
Message-Id: <201007101109.45623.sven.eckelmann@gmx.de>
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
To: Henning Rogge <hrogge@googlemail.com>
Cc: b.a.t.m.a.n@lists.open-mesh.org

--nextPart2758813.6Ny0PAtlId
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Henning Rogge wrote:
> Am Samstag 10 Juli 2010, 10:40:52 schrieb Sven Eckelmann:
> > Daniel Seither wrote:
> > > Am 10.07.2010 01:07, Sven Eckelmann wrote:
> > > > batman-adv works quite well for us - but that doesn't mean that it =
is
> > > > good in context of the current kernel development. And who should
> > > > know it better than the netdev guys.
> > >=20
> > > Hagen Paul Pfeifer suggested in his message "a generalized architectu=
re
> > > and a user space implementation of the protocol". What came to my mind
> > > when I read this again was a division of control plane and
> > > data/forwarding plane as known from traditional routing.
> > >=20
> > > The whole forwarding stuff would stay in the kernel, using a simple
> > > routing table (for destination X, send to node Y on interface Z).
> >=20
> > This would go against the bonding/alternating functionality.
>=20
> The bonding/alternating functionality could be part of the routing
> framework. I think there is something similar on IP layer routing in
> linux.

Yes, I know that it must be part of the routing framework - just the rulese=
t=20
he explained is not sufficient for that task.

Kind regards,
	Sven

--nextPart2758813.6Ny0PAtlId
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIcBAABCgAGBQJMODjYAAoJEF2HCgfBJntGCtgP/39A7KQPpy7nFQxFsk6LkzdP
y+J84VkOti5Z6B2fDpUForBOtol1SW9FlwYHjlUiM/wcB2fP6NlKktynm3tIEO8B
WLSKGNqEs0+jkFOjpK/byMxwZ0Cco9slB5/8mId40gH15E9e+J2t4JHitD/EgvDP
DkWMsn9/cC8au4oUxaJrN1zNgCL/yxMZWr88lv7fp0rVSRyAGplyCp9Oft1yVMp/
cpHPiQlPyKdfBoIh23rFOV5gz14rXpzS6qV6rVNiuaUMLEUuFD59Wqk7eg1S7zN2
AuAh9N9RFFbXAJqPOSoCe5LOFAxc+5WsK6Anmu8PYeYmDt+y/tQHqIfk1azv8sjR
wi5sUSVgavcgG9GXdaDLLHeeNY9MW0w4jJXiCqwqwGjgItonXUwigT1+c7zFEaKz
N0ZwzSn65QzS80LFxOuVohyaJ9pT71ngSC3sSRFhQwEb2Ej0ThKRmbn+GYlk6ggA
v491xHQ5VtfMLWtViogCfyduUbzQCGcN6YgrJQg2x4d7SGvTJub7TtEBC8PRdgdS
0gRpnlElbJ0zdwSEsHB+fyWPk50b/NViLR5zg6nBmc6ZHDu6+L8NY22rj6Z3074P
vgi8na3kBDE6fdTt/wzRJgahL0k1w+WsrbZfbr7aNuCpx4fvW0IVQ/bL/lq40YBj
6jrDsLutA6FaM8hb1tZV
=jmEE
-----END PGP SIGNATURE-----

--nextPart2758813.6Ny0PAtlId--
