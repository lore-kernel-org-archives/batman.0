Return-Path: <ordex@autistici.org>
Date: Fri, 14 Jun 2013 14:49:26 +0200
From: Antonio Quartulli <ordex@autistici.org>
Message-ID: <20130614124926.GB1237@ritirata.org>
References: <1371203642-2224-1-git-send-email-linus.luessing@web.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="mxv5cy4qt+RJ9ypb"
Content-Disposition: inline
In-Reply-To: <1371203642-2224-1-git-send-email-linus.luessing@web.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: (style) fix for switched
 vid-ifiindex parameter order
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


--mxv5cy4qt+RJ9ypb
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey Linus,

On Fri, Jun 14, 2013 at 11:54:02AM +0200, Linus L=C3=BCssing wrote:
> batadv_tt_local_add() first takes the vid and then the interface index
> parameter. One of these calls had the order switched.
>=20
> However in this case it is not a functional, but just a style fix
> because at the moment BATADV_NO_FLAGS is equal to BATADV_NULL_IFINDEX.
>=20

Thanks for fixing this :)

However, can you please resend this patch adding the commit id and the subj=
ect
of the change introducing this problem? This will help me in squashing the
original patch and this fix before sending the patches upstream.
(Sorry for annoying with this :-))

> Signed-off-by: Linus L=C3=BCssing <linus.luessing@web.de>

You can also add

Acked-by: Antonio Quartulli <ordex@autistici.org>

Cheers,

> ---
>  main.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/main.c b/main.c
> index f2f1137..a7ad6cb 100644
> --- a/main.c
> +++ b/main.c
> @@ -128,7 +128,7 @@ int batadv_mesh_init(struct net_device *soft_iface)
>  		goto err;
> =20
>  	batadv_tt_local_add(soft_iface, soft_iface->dev_addr,
> -			    BATADV_NULL_IFINDEX, BATADV_NO_FLAGS);
> +			    BATADV_NO_FLAGS, BATADV_NULL_IFINDEX);
> =20
>  	ret =3D batadv_bla_init(bat_priv);
>  	if (ret < 0)
> --=20
> 1.7.10.4

--=20
Antonio Quartulli

=2E.each of us alone is worth nothing..
Ernesto "Che" Guevara

--mxv5cy4qt+RJ9ypb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBCAAGBQJRuxFWAAoJEADl0hg6qKeOuCgP/2DHk3v3+qAKvPbPFJRkG19r
BOoOpdLNE8pLhc6S9NPv2mNWuG4kJW3MeSfH6cBVPreneXVEnz/Dl4DX5IsTjj8G
izPbXHKFwi/2M5kkU3XukS+1Csm1baG18B3dOLwvkJWOpvoCUq+AkNIVfDZiTtkn
tcxB9Je8FcMtKqQJPGkIA3BDAQGWZhmiVeTKAdfy0ufvTrfPsQUrByZWSCupBtzQ
Y44dt7yMcCrx2HgggUZCmu5EF5FahwaK1OWgWBWKopOlMSbPQnPaJkSPGFSl1Ylo
qinkiIDVQHuyzvnzgEqxJQfOgfF8U5R5h7hRcOWE/VciU/b6dNZ0vUHABRoaOPn2
f3VVk3L6EsM6s7vtI4q8mm32utYTTof0NDVSY3nop17wKByuViavYbeC8zMzGlv2
/duSv9EOqOBmjThRJNGmg13Rk17tRhZ5k3ZJ76NGJ6rr2Gx64RFSI9fJiNHaLGX2
ugulSpsyHsQ/83MBGDlVeJItOVvHgYywHibSDqWX+s3GknKEip+wPYFyQ7cjkc5i
P2/dTd8T4ZBu5fBClFtTE4YxF66Um5mUW2OKY7CiSgbk00TfDGBt1E78zrnZ/Zs/
GhGHWmCxeo+9zkvh0eXJXjwP+FHUy11yinDNmiOt41bhZQ0/uXn97AhPpfBuCU9S
0OIQ3CxBMLhF8O4pwJ0S
=rt/g
-----END PGP SIGNATURE-----

--mxv5cy4qt+RJ9ypb--
