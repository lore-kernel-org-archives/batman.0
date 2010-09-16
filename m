Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Thu, 16 Sep 2010 15:16:26 +0200
References: <1284589835-26617-1-git-send-email-sven.eckelmann@gmx.de>
	<1284629407-20394-1-git-send-email-sven.eckelmann@gmx.de>
	<201009161451.40470.arnd@arndb.de>
In-Reply-To: <201009161451.40470.arnd@arndb.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2287908.nEyXKn2et7";
	protocol="application/pgp-signature"; micalg=pgp-sha512
Content-Transfer-Encoding: 7bit
Message-Id: <201009161516.27824.sven.eckelmann@gmx.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: Mark debugfs files as
	nonseekable
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
To: Arnd Bergmann <arnd@arndb.de>
Cc: b.a.t.m.a.n@lists.open-mesh.org

--nextPart2287908.nEyXKn2et7
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Arnd Bergmann wrote:
> On Thursday 16 September 2010, Sven Eckelmann wrote:
> > We don't allow to seek in the debugfs socket and log files. Thus we
> > should mark the file descriptor as nonseekable.
> >=20
> > Signed-off-by: Sven Eckelmann <sven.eckelmann@gmx.de>
> > Cc: Arnd Bergmann <arnd@arndb.de>
>=20
> Acked-by: Arnd Bergmann <arnd@arndb.de>
>=20
> Looks good. Do you want to merge it yourself? Otherwise I'll queue it up
> in my tree.

This patch is for the batman-adv repository (so the paths aren't 100% ready=
=20
for the kernel tree). So I would wait for Marek Lindner to approve it and t=
han=20
wandering from there to Gregs staging-next tree for 2.6.37.

I've just Cc'ed you that you know that this clashes slightly with your llse=
ek=20
patches (which you wanted to cleanup - so the batman-adv part can be droppe=
d).

Best regards,
	Sven

--nextPart2287908.nEyXKn2et7
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIcBAABCgAGBQJMkhirAAoJEF2HCgfBJntGd20P/19REBob1q1Lk3oYe5xIUd0s
82gN0J7lmkCqNyZlzNKWF3erqTifMINB5o1spxwZeQF2uzKr7ry5ff7qOL022vxh
IdVydm7nEoa8UZbTSBEfND3NxuV/eSXQCagZmP1FYgXiRTjzmIyOv2tUmTTUaE7x
Fsjo8thiQ+U9iwNm/aJdW/xEKdCRk8u0XYOT77jPsj8OnyfaqMBu0fsw/76EIJ8q
qm/q/aMTQTUYy3cTbV86upuAybwugCcsyK0OBpP5Aa8q3MlxDyrJxPTkqUoGCndn
BhLAOr6tWbHpSB/m39C3IX9ucc/5pqVd2gtzh/ZMROzV+nS73/BEReX2YunE9EOX
TADsZyMby7i9GCuLrWMOKY4PnaaEr/4trbm6zpyCTIiT+1FQploTg4FsVfpU6Nlx
noyl/gyaFsthqUvwQelbrbgKNYJQyl2Pe43oDRplFcCXGphXSq7DGaUdrukpG27N
lch/Q90zMh9K33jA1CXm4lYtOxISsJUONCqJjJVVLF171pIwK4Tu8pudU7lA4sbF
12XqVVFzdkoOlEbwDcZVTiXb51eC+kiRySca2GQdhKUK6r9p/yd4Kpk6McqzUGuF
iL4JTh8IBDbpVDKyKYaCq2p35CAkphm1UdHvO4I8e54NB8SBd1UTS/zGOaS2UmaV
uYbLdolDq0lza6A+MXGN
=r3hD
-----END PGP SIGNATURE-----

--nextPart2287908.nEyXKn2et7--
