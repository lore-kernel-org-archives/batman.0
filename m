Return-Path: <simon.wunderlich@s2003.tu-chemnitz.de>
Date: Tue, 28 May 2013 17:42:48 +0200
From: Simon Wunderlich <simon.wunderlich@s2003.tu-chemnitz.de>
Message-ID: <20130528154248.GD14466@pandem0nium>
References: <179dd3afbd3ecdcd2144bd3016e1b01eaf0d5263.1369754967.git.mschiffer@universe-factory.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="DrWhICOqskFTAXiy"
Content-Disposition: inline
In-Reply-To: <179dd3afbd3ecdcd2144bd3016e1b01eaf0d5263.1369754967.git.mschiffer@universe-factory.net>
Subject: Re: [B.A.T.M.A.N.] [PATCH maint] batman-adv: wait for rtnl in
 batadv_store_mesh_iface instead of failing if it is taken
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


--DrWhICOqskFTAXiy
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 28, 2013 at 05:32:32PM +0200, Matthias Schiffer wrote:
> The rtnl_lock in batadv_store_mesh_iface has been converted to a rtnl_try=
lock
> some time ago to avoid a possible deadlock between rtnl and s_active on r=
emoval
> of the sysfs nodes.
>=20
> The behaviour introduced by that was quite confusing as it could lead to =
the
> sysfs store to fail, making batman-adv setup scripts unreliable. As recen=
tly the
> sysfs removal was postponed to a worker not running with the rtnl taken, =
the
> deadlock can't occur any more and it is safe to change the trylock back t=
o a
> lock to make the sysfs store reliable again.
>=20
> Signed-off-by: Matthias Schiffer <mschiffer@universe-factory.net>

Reviewed-by: Simon Wunderlich <siwu@hrz.tu-chemnitz.de>

Thanks for posting,
	Simon

> ---
>  sysfs.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
>=20
> diff --git a/sysfs.c b/sysfs.c
> index 15a22ef..929e304 100644
> --- a/sysfs.c
> +++ b/sysfs.c
> @@ -582,10 +582,7 @@ static ssize_t batadv_store_mesh_iface(struct kobjec=
t *kobj,
>  	    (strncmp(hard_iface->soft_iface->name, buff, IFNAMSIZ) =3D=3D 0))
>  		goto out;
> =20
> -	if (!rtnl_trylock()) {
> -		ret =3D -ERESTARTSYS;
> -		goto out;
> -	}
> +	rtnl_lock();
> =20
>  	if (status_tmp =3D=3D BATADV_IF_NOT_IN_USE) {
>  		batadv_hardif_disable_interface(hard_iface,
> --=20
> 1.8.3
>=20

--DrWhICOqskFTAXiy
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEARECAAYFAlGk0HgACgkQrzg/fFk7axZh7ACeJ0G+4h8PVobVFwLSrLhYaefB
NCwAn2qlewxX7xWNwTBY0ZhbLzFNR10Q
=JUa9
-----END PGP SIGNATURE-----

--DrWhICOqskFTAXiy--
