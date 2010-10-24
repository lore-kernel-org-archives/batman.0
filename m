Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Sun, 24 Oct 2010 22:03:22 +0200
References: <1287950297-7983-1-git-send-email-lindner_marek@yahoo.de>
In-Reply-To: <1287950297-7983-1-git-send-email-lindner_marek@yahoo.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart7320774.UUDlGQrkOD";
	protocol="application/pgp-signature"; micalg=pgp-sha512
Content-Transfer-Encoding: 7bit
Message-Id: <201010242203.23528.sven.eckelmann@gmx.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: fix crash on mesh cleanup in
	bridge loop avoidance code
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
Cc: Marek Lindner <lindner_marek@yahoo.de>

--nextPart7320774.UUDlGQrkOD
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Marek Lindner wrote:
> Signed-off-by: Marek Lindner <lindner_marek@yahoo.de>
> ---
>  batman-adv/soft-interface.c |    1 -
>  1 files changed, 0 insertions(+), 1 deletions(-)
>=20
> diff --git a/batman-adv/soft-interface.c b/batman-adv/soft-interface.c
> index a13276b..5ae26e8 100644
> --- a/batman-adv/soft-interface.c
> +++ b/batman-adv/soft-interface.c
> @@ -114,7 +114,6 @@ void softif_neigh_purge(struct bat_priv *bat_priv)
>  		hlist_del_rcu(&softif_neigh->list);
>=20
>  		if (bat_priv->softif_neigh =3D=3D softif_neigh) {
> -			bat_priv->softif_neigh =3D NULL;
>  			bat_dbg(DBG_ROUTES, bat_priv,
>  				 "Current mesh exit point '%pM' vanished "
>  				 "(vid: %d).\n",

Acked-by: Sven Eckelmann <sven.eckelmann@gmx.de>

--nextPart7320774.UUDlGQrkOD
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIcBAABCgAGBQJMxJEKAAoJEF2HCgfBJntGlk4P/2ockFfoMfc2OAmAmzBKxSlw
Dmp5ZPrRZfec6qRa1JqN3u8U2Rnt6Msgt29DtDybiJaG5Zm1c/hqLe0WZ6XxH5Uo
p+T0iTS2zvz//rvxspJ6GKGqNP6VSIuCnyN0n/iI7irh0IbRZSIVenHb2Vh7aswW
Vuak72FwSdG1VDqrEjOlyE9zTyGJG2Uwdoh021P0du4JDmPdCtoq2siWGdq6yuNc
mxCWkLLPP5avrQdALSUc6K4O96xyRKs/KYLj5oYPkqDDWox6j9QlCA8wo9+iaPZX
5VnBFgtjHCZo9yaf7Qrq5untMZtRlffnNRtIRdfXSclb+PEj0J4XjtOd4x+hP483
ap5BEkX1w+QWw9BQWF8UOCzZjFDKZsHPgkiF+E4lMJh6JM8hIECTAuU0a4ZeliW/
Mb10H+aLapPvfOSR1nOaRMU5ZKUwuTgrATDlq8WhSJ8WSVOEz5l4MMJBSZ975Bv6
Khd2ljk3WhBuzEYuPdkBq4E5/coAMThdGFG7ZDj8PxHwQaas2oqanQoDBKlouYCS
OPgXB0fLDz55oILLTpQ2mtZ4BpgYuO7iJq3O+uORIgTFH6TXZt52vynf/JDF5BFU
oAMFmA59h/JDkh5OrHGKy5dQFM68PkGeJNn18b3PPkLD23e8fsKWrSH3wwkgDCLJ
8eHNDrLyJw1Fu+ZMctLc
=go86
-----END PGP SIGNATURE-----

--nextPart7320774.UUDlGQrkOD--
