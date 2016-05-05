Return-Path: <a@unstable.cc>
Date: Thu, 5 May 2016 18:04:35 +0800
From: Antonio Quartulli <a@unstable.cc>
Message-ID: <20160505100435.GL11201@prodigo.lan>
References: <1462434282-3307-1-git-send-email-sven.eckelmann@open-mesh.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="Zz5hxuHUV8Fb7Aol"
Content-Disposition: inline
In-Reply-To: <1462434282-3307-1-git-send-email-sven.eckelmann@open-mesh.com>
Subject: Re: [B.A.T.M.A.N.] [PATCH next] batman-adv: replace
 dev->trans_start update with helper
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


--Zz5hxuHUV8Fb7Aol
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 05, 2016 at 09:44:42AM +0200, Sven Eckelmann wrote:
> From: Florian Westphal <fw@strlen.de>
>=20
> Replace all trans_start updates with netif_trans_update helper.
> change was done via spatch:
>=20
> struct net_device *d;
> @@
> - d->trans_start =3D jiffies
> + netif_trans_update(d)
>=20
> Compile tested only.
>=20
> Signed-off-by: Florian Westphal <fw@strlen.de>
> Signed-off-by: Sven Eckelmann <sven.eckelmann@open-mesh.com>
> ---
> Warning: untested
>=20
>  compat-include/linux/netdevice.h | 10 ++++++++++
>  net/batman-adv/soft-interface.c  |  2 +-
>  2 files changed, 11 insertions(+), 1 deletion(-)
>=20
> diff --git a/compat-include/linux/netdevice.h b/compat-include/linux/netd=
evice.h
> index f47f5c3..fb5b519 100644
> --- a/compat-include/linux/netdevice.h
> +++ b/compat-include/linux/netdevice.h
> @@ -74,4 +74,14 @@
> =20
>  #endif /* < KERNEL_VERSION(4, 5, 0) */
> =20
> +#if LINUX_VERSION_CODE < KERNEL_VERSION(4, 7, 0)
> +
> +#define netif_trans_update batadv_netif_trans_update
> +static inline void batadv_netif_trans_update(struct net_device *dev)

Sven,

do we really need to rename the function is the original one does not exist=
 in
kernels < 4.7 ? Or maybe it exists but does something else ?

Cheers,


--=20
Antonio Quartulli

--Zz5hxuHUV8Fb7Aol
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJXKxqzAAoJEJ4aZjxxc6bKhIAP/3UHoejf0e85KqN44J3dXesb
lXbtx8Ci6Ai5IA/sWvsw4mN4LC9lwT9J1F4FjTZORmjPEzcDL1MF8V0q789ONHPa
hPDiMros4GFULcVWcai47eCy27KtyjTlCW4hRZnQjhofxvlKNW6lhbtq+QApc0kS
hUVkzBL9YPO+b/Y5otyyhy0DbjHEOR98tvyTrsNGqIzqP8CKS/4HQPviK27Sp5a5
0vTIv1pkigB57h+MQrPkj5kQ4RkKanWEjmIULTWeeDxl67Um/FOrzo24j7tQ1fOn
hkK87fO+HoIPlIBFuZAbpTQi9b04ilkFSYPv93UfGiOyosngk35NGJ8U+1tdoaKd
C1i0FkjuPQkrfPgKqxyU5v89VF9rXa4E10kZuFf/tZPAyh38i/DtwFx6yklZ92QW
CUiTAETsu1UseyXbLM5W3vRHdkHxyqxFlcu/Yr0awkQi8W0MgDxv2HSHRlUGA7JL
eXf9oGre7unWdsrUetYPDhGE0hzmp0VAeugUYUC/475llvWqRcWri9JVktEEFMe6
Ho+daB8Apx0imt5/iNP5p8+j9k7CyQHHMn/KIvfpQ9fFHBuRaT7TO2jX1ioOD8yi
sxHVgJDO3YG/N/80s/oelRB5/SeU57S7tAFxAPu332egwh1+G5mYTjgnIQ8acA7h
Vc3AOmxu9Uq7DvYGbWx6
=qqm8
-----END PGP SIGNATURE-----

--Zz5hxuHUV8Fb7Aol--
