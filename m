Return-Path: <simon.wunderlich@s2003.tu-chemnitz.de>
Date: Sun, 18 Nov 2012 21:23:53 +0100
From: Simon Wunderlich <simon.wunderlich@s2003.tu-chemnitz.de>
Message-ID: <20121118202353.GA22840@pandem0nium>
References: <1353239559-18279-1-git-send-email-ordex@autistici.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="J2SCkAp4GZ/dPZZf"
Content-Disposition: inline
In-Reply-To: <1353239559-18279-1-git-send-email-ordex@autistici.org>
Subject: Re: [B.A.T.M.A.N.] [PATCH next] batman-adv: use batadv_compare_eth
 instead of memcmp
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>


--J2SCkAp4GZ/dPZZf
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Looks good.

Acked-by: Simon Wunderlich <siwu@hrz.tu-chemnitz.de>

Thanks,
	Simon
On Sun, Nov 18, 2012 at 12:52:39PM +0100, Antonio Quartulli wrote:
> When comparing ethernet address the batadv_compare_eth function has
> to be used instead of memcmp.
>=20
> This was introduced by 923d5d148cdd0928c9c5f8e0e2024f585dcf6efd
> ("batman-adv: fix bla compare function")
>=20
> Signed-off-by: Antonio Quartulli <ordex@autistici.org>
> ---
>  bridge_loop_avoidance.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/bridge_loop_avoidance.c b/bridge_loop_avoidance.c
> index fc56ea2..5aebe93 100644
> --- a/bridge_loop_avoidance.c
> +++ b/bridge_loop_avoidance.c
> @@ -79,7 +79,7 @@ static int batadv_compare_backbone_gw(const struct hlis=
t_node *node,
>  					 hash_entry);
>  	const struct batadv_backbone_gw *gw1 =3D data1, *gw2 =3D data2;
> =20
> -	if (memcmp(gw1->orig, gw2->orig, ETH_ALEN))
> +	if (!batadv_compare_eth(gw1->orig, gw2->orig))
>  		return 0;
> =20
>  	if (gw1->vid !=3D gw2->vid)
> @@ -96,7 +96,7 @@ static int batadv_compare_claim(const struct hlist_node=
 *node,
>  					 hash_entry);
>  	const struct batadv_claim *cl1 =3D data1, *cl2 =3D data2;
> =20
> -	if (memcmp(cl1->addr, cl2->addr, ETH_ALEN))
> +	if (!batadv_compare_eth(cl1->addr, cl2->addr))
>  		return 0;
> =20
>  	if (cl1->vid !=3D cl2->vid)
> --=20
> 1.8.0
>=20
>=20

--J2SCkAp4GZ/dPZZf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAlCpQ9kACgkQrzg/fFk7axZdHgCgq3VUNl/zVSmqJZqrxnVM9snc
9aMAn3GVSiPZ59xSTEXJJ/w0n+Sfy6we
=vXAc
-----END PGP SIGNATURE-----

--J2SCkAp4GZ/dPZZf--
