Return-Path: <a@unstable.cc>
References: <20171016074803.17947-1-sven.eckelmann@openmesh.com>
From: Antonio Quartulli <a@unstable.cc>
Message-ID: <f18395d0-306a-80fb-4b88-22ece6ee2d23@unstable.cc>
Date: Mon, 16 Oct 2017 16:53:19 +0800
MIME-Version: 1.0
In-Reply-To: <20171016074803.17947-1-sven.eckelmann@openmesh.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="aiQP9uCvJIdSEb4MrJxLeNje0l8SPthoF"
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: Avoid spurious warnings from
 bat_v neigh_cmp implementation
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>, Sven Eckelmann <sven.eckelmann@openmesh.com>
Cc: Joseph Stefek <joseph.stefek@openmesh.com>, =?UTF-8?Q?Steffen_F=c3=b6rster?= <steffen@chemnitz.freifunk.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--aiQP9uCvJIdSEb4MrJxLeNje0l8SPthoF
Content-Type: multipart/mixed; boundary="gv0uxaLlXreK8SUg8s9QnlNFb4HBIFxhP";
 protected-headers="v1"
From: Antonio Quartulli <a@unstable.cc>
To: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n@lists.open-mesh.org>,
 Sven Eckelmann <sven.eckelmann@openmesh.com>
Cc: Joseph Stefek <joseph.stefek@openmesh.com>,
 =?UTF-8?Q?Steffen_F=c3=b6rster?= <steffen@chemnitz.freifunk.net>
Message-ID: <f18395d0-306a-80fb-4b88-22ece6ee2d23@unstable.cc>
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: Avoid spurious warnings from
 bat_v neigh_cmp implementation
References: <20171016074803.17947-1-sven.eckelmann@openmesh.com>
In-Reply-To: <20171016074803.17947-1-sven.eckelmann@openmesh.com>

--gv0uxaLlXreK8SUg8s9QnlNFb4HBIFxhP
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 16/10/17 15:48, Sven Eckelmann wrote:
> The neighbor compare API implementation for B.A.T.M.A.N. V checks wheth=
er
> the neigh_ifinfo for this neighbor on a specific interface exists. A
> warning is printed when it isn't found.
>=20
> But it is not called inside a lock which would prevent that this
> information is lost right before batadv_neigh_ifinfo_get. It must there=
fore
> be expected that batadv_v_neigh_(cmp|is_sob) might not be able to get t=
he
> requested neigh_ifinfo.
>=20
> A WARN_ON for such a situation seems not to be appropriate because this=

> will only flood the kernel logs. The warnings must therefore be removed=
=2E
>=20
> Signed-off-by: Sven Eckelmann <sven.eckelmann@openmesh.com>

Yeah, this makes sense. As a read only operation, the lock is not held
on purpose, therefore such situation has to be expected.

Acked-by: Antonio Quartulli <a@unstable.cc>

--=20
Antonio Quartulli


--gv0uxaLlXreK8SUg8s9QnlNFb4HBIFxhP--

--aiQP9uCvJIdSEb4MrJxLeNje0l8SPthoF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEERdCuyFSHc3WdqS4EB6U8WA7yzXQFAlnkc4QACgkQB6U8WA7y
zXQZbw//SRSR+hO+ZMAZJZwWDmFWHBTqnEY0dlFvYacYF4M2cdh+VpUxG5eD/gfj
rGTVCvzoE1AdGjnwawwLc1rn/1J/OU08RUo8OBJ3YXe9UhhJF4tQ/E2+z99zhuPe
PhNVNDSXgOunb76QCSnRdTvrD4YNSvaq+o42HCml1lnRb0j/cKI2UrDFK/TcUfmq
0UwpqThCAmmr6yJ7oKj1k1sDAuhTQvndImAn88GFtdnSkyV0KXc9M2OdLCHxiP75
cQvKZ6QFm2yWT6xCAOriSddySQsDSoAaSVl5BwxHyFLto9TKb0o9qw2LygU2mcED
N8FgBHOVxtxOM1oXxk5IxuJHBiG1Q4drgEitbA/Y8B/4OzFUt+kccpkiDlK4dRbt
8ghjVxiaUnhV2ZdHJDXvBrJ9PdsUCwHfvErorYpqy35SOrUWYuoYh38bLssjrbl0
6w832Pc/dET6CdE0zWLROT8Ynn6t7ifu9e9Bge/B6chgtCutkgzLTze4c16hb3pk
knj3ZSxO5QklgtXFwa/LivBaMbKWz/EC0UsgUxMyxYESl33B3dhlBcGCU1zxMZt7
n+6vkaUm5v4q86FYUd/8RSiOQyyXFtRf1dA7UceOz2y9iBr0dhKyFtcX2jMX3RS6
LgK4OxqTXb304q2fHPXX1pK2hIjQ6tf299RNEzDxOEVuGvHzVvk=
=/mmg
-----END PGP SIGNATURE-----

--aiQP9uCvJIdSEb4MrJxLeNje0l8SPthoF--
