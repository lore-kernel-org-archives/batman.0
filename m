Return-Path: <simon.wunderlich@s2003.tu-chemnitz.de>
Date: Sat, 5 Jun 2010 19:57:42 +0200
From: Simon Wunderlich <simon.wunderlich@s2003.tu-chemnitz.de>
Message-ID: <20100605175742.GC9284@pandem0nium>
References: <1275519516-21394-1-git-send-email-sven.eckelmann@gmx.de>
	<1275519516-21394-2-git-send-email-sven.eckelmann@gmx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="IpbVkmxF4tDyP/Kb"
Content-Disposition: inline
In-Reply-To: <1275519516-21394-2-git-send-email-sven.eckelmann@gmx.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH 2/3] batman-adv: Correct gw_speed
	down	bit mask
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
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>


--IpbVkmxF4tDyP/Kb
Content-Type: text/plain; charset=utf8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Thanks, committed in r1690.

On Thu, Jun 03, 2010 at 12:58:35AM +0200, Sven Eckelmann wrote:
> We want to get bits .OOOO... and not as the mask would suggest .OOOOO..
> when we decode the encoded bits for the download part of the gateway
> speed.
>=20
> Reported-By: Bill Meier <wmeier@newsguy.com>
> Signed-off-by: Sven Eckelmann <sven.eckelmann@gmx.de>
> ---
>  batman-adv-kernelland/gateway_common.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>=20
> diff --git a/batman-adv-kernelland/gateway_common.c b/batman-adv-kernella=
nd/gateway_common.c
> index d542306..270cf3d 100644
> --- a/batman-adv-kernelland/gateway_common.c
> +++ b/batman-adv-kernelland/gateway_common.c
> @@ -63,7 +63,7 @@ static void kbit_to_gw_srv_class(int down, int up, long=
 *gw_srv_class)
>  void gw_srv_class_to_kbit(uint8_t gw_srv_class, int *down, int *up)
>  {
>  	char sbit =3D (gw_srv_class & 0x80) >> 7;
> -	char dpart =3D (gw_srv_class & 0x7C) >> 3;
> +	char dpart =3D (gw_srv_class & 0x78) >> 3;
>  	char upart =3D (gw_srv_class & 0x07);
> =20
>  	if (!gw_srv_class) {
> --=20
> 1.7.1
>=20
>=20

--IpbVkmxF4tDyP/Kb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkwKkBYACgkQrzg/fFk7axb5qgCgttIKT4J2aU6KFJBbtZuYHwzy
LsEAoKAFOwHIR/DDB+ZWHm5lJSPUPjmm
=dFaA
-----END PGP SIGNATURE-----

--IpbVkmxF4tDyP/Kb--
