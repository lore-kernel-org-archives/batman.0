Return-Path: <simon.wunderlich@s2003.tu-chemnitz.de>
Date: Sun, 17 Apr 2011 18:22:10 +0200
From: Simon Wunderlich <simon.wunderlich@s2003.tu-chemnitz.de>
Message-ID: <20110417162210.GA19178@pandem0nium>
References: <1302708420-8552-1-git-send-email-lindner_marek@yahoo.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="YiEDa0DAkWCtVeE4"
Content-Disposition: inline
In-Reply-To: <1302708420-8552-1-git-send-email-lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH] batctl: avoid error message when command
 was successful
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


--YiEDa0DAkWCtVeE4
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Applied in eee3fc6,

thanks
	Simon

On Wed, Apr 13, 2011 at 05:27:00PM +0200, Marek Lindner wrote:
> Reported-by: Linus L=C3=BCssing <linus.luessing@web.de>
> Signed-off-by: Marek Lindner <lindner_marek@yahoo.de>
> ---
>  sys.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/sys.c b/sys.c
> index 729f898..3511b40 100644
> --- a/sys.c
> +++ b/sys.c
> @@ -420,10 +420,10 @@ int handle_gw_setting(char *mesh_iface, int argc, c=
har **argv)
>  	case GW_MODE_SERVER:
>  		res =3D write_file(path_buff, SYS_GW_BW, argv[2], NULL);
>  		break;
> -	default:
> -		goto out;
>  	}
> =20
> +	goto out;
> +
>  opt_err:
>  	printf("Error - the supplied argument is invalid: %s\n", argv[1]);
>  	printf("The following values are allowed:\n");
> --=20
> 1.7.2.3
>=20
>=20

--YiEDa0DAkWCtVeE4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAk2rE7IACgkQrzg/fFk7axZEFQCfVaojw/AKJJytIP0y5OPaSgpK
kY0AoIz9J/MfiMnadfhpz2L1oRi0WLKK
=SFok
-----END PGP SIGNATURE-----

--YiEDa0DAkWCtVeE4--
