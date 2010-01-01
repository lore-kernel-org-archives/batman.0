Return-Path: <simon.wunderlich@s2003.tu-chemnitz.de>
Date: Fri, 1 Jan 2010 17:40:33 +0100
From: Simon Wunderlich <simon.wunderlich@s2003.tu-chemnitz.de>
Message-ID: <20100101164033.GC16855@pandem0nium>
References: <20091231034120.GC18781@Sellars>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Qbvjkv9qwOGw/5Fx"
Content-Disposition: inline
In-Reply-To: <20091231034120.GC18781@Sellars>
Subject: Re: [B.A.T.M.A.N.] [PATCH 3/3] batman-adv: Remove unused variable
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.net>
List-Unsubscribe: <https://lists.open-mesh.net/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=help>
List-Subscribe: <https://lists.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.net>


--Qbvjkv9qwOGw/5Fx
Content-Type: text/plain; charset=utf8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey Linus,

sorry, i have not seen your patch and checked this in myself (r1525). Thank=
s=20
for reporting it anyway. :)

best regards,
	Simon

On Thu, Dec 31, 2009 at 04:41:20AM +0100, =3D?UTF-8?q?Linus=3D20L=3DC3=3DBC=
ssing?=3D wrote:
> The variable 'flag' is never being used in this function, therefore
> removing it.
>=20
> Signed-off-by: Linus L=C3=BCssing <linus.luessing@web.de>
> ---
>  soft-interface.c |    1 -
>  1 files changed, 0 insertions(+), 1 deletions(-)
>=20
> diff --git a/soft-interface.c b/soft-interface.c
> index 4d4d542..bc0217b 100644
> --- a/soft-interface.c
> +++ b/soft-interface.c
> @@ -148,7 +148,6 @@ struct net_device_stats *interface_stats(struct net_d=
evice *dev)
>  int interface_set_mac_addr(struct net_device *dev, void *p)
>  {
>  	struct sockaddr *addr =3D p;
> -	unsigned long flags;
> =20
>  	if (!is_valid_ether_addr(addr->sa_data))
>  		return -EADDRNOTAVAIL;
> --=20
> 1.6.5.7
>=20
> _______________________________________________
> B.A.T.M.A.N mailing list
> B.A.T.M.A.N@lists.open-mesh.net
> https://lists.open-mesh.net/mm/listinfo/b.a.t.m.a.n

--Qbvjkv9qwOGw/5Fx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAks+JYEACgkQrzg/fFk7axbW2QCeIv2/2D06d9bdOsfwdJJ5Epgu
dYsAoLKxapu3RZ2+7tKf3dH8krkMuHwf
=PYcV
-----END PGP SIGNATURE-----

--Qbvjkv9qwOGw/5Fx--
