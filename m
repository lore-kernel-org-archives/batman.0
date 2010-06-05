Return-Path: <simon.wunderlich@s2003.tu-chemnitz.de>
Date: Sat, 5 Jun 2010 19:58:55 +0200
From: Simon Wunderlich <simon.wunderlich@s2003.tu-chemnitz.de>
Message-ID: <20100605175855.GD9284@pandem0nium>
References: <1275519516-21394-1-git-send-email-sven.eckelmann@gmx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="osDK9TLjxFScVI/L"
Content-Disposition: inline
In-Reply-To: <1275519516-21394-1-git-send-email-sven.eckelmann@gmx.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH 1/3] batman: Correct gw_speed down
	bit	mask
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


--osDK9TLjxFScVI/L
Content-Type: text/plain; charset=utf8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Thanks, applied in svn r1691.

On Thu, Jun 03, 2010 at 12:58:34AM +0200, Sven Eckelmann wrote:
> We want to get bits .OOOO... and not as the mask would suggest .OOOOO..
> when we decode the encoded bits for the download part of the gateway
> speed.
>=20
> Reported-By: Bill Meier <wmeier@newsguy.com>
> Signed-off-by: Sven Eckelmann <sven.eckelmann@gmx.de>
> ---
>  batman/batman.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>=20
> diff --git a/batman/batman.c b/batman/batman.c
> index 4374af5..ab689b2 100644
> --- a/batman/batman.c
> +++ b/batman/batman.c
> @@ -482,7 +482,7 @@ void update_gw_list(struct orig_node *orig_node, uint=
8_t new_gwflags, uint16_t g
>  void get_gw_speeds(unsigned char gw_class, int *down, int *up)
>  {
>  	char sbit =3D (gw_class & 0x80) >> 7;
> -	char dpart =3D (gw_class & 0x7C) >> 3;
> +	char dpart =3D (gw_class & 0x78) >> 3;
>  	char upart =3D (gw_class & 0x07);
> =20
>  	*down =3D 32 * (sbit + 2) * (1 << dpart);
> --=20
> 1.7.1
>=20
>=20

--osDK9TLjxFScVI/L
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkwKkF8ACgkQrzg/fFk7axY9YACffM4kQNNJfVHlRQI5pJ18GySC
SEgAoOQfqBkyvfXc8YkMaEI840RJR0VI
=IdvF
-----END PGP SIGNATURE-----

--osDK9TLjxFScVI/L--
