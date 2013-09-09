Return-Path: <simon.wunderlich@s2003.tu-chemnitz.de>
Date: Mon, 9 Sep 2013 17:08:31 +0200
From: Simon Wunderlich <simon.wunderlich@s2003.tu-chemnitz.de>
Message-ID: <20130909150831.GA11737@pandem0nium>
References: <1378690742-19656-1-git-send-email-nils@nilsschneider.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="UugvWAfsgieZRqgk"
Content-Disposition: inline
In-Reply-To: <1378690742-19656-1-git-send-email-nils@nilsschneider.net>
Subject: Re: [B.A.T.M.A.N.] [PATCH] alfred: free globals. Fixes memory leak
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


--UugvWAfsgieZRqgk
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 09, 2013 at 03:39:02AM +0200, Nils Schneider wrote:
> ---
>  main.c | 15 +++++++++++----
>  1 file changed, 11 insertions(+), 4 deletions(-)
>=20
> diff --git a/main.c b/main.c
> index 86acfb7..58622f8 100644
> --- a/main.c
> +++ b/main.c
> @@ -142,6 +142,7 @@ static struct globals *alfred_init(int argc, char *ar=
gv[])
>  int main(int argc, char *argv[])
>  {
>  	struct globals *globals;
> +	int ret;
> =20
>  	globals =3D alfred_init(argc, argv);
> =20
> @@ -150,15 +151,21 @@ int main(int argc, char *argv[])
> =20
>  	switch (globals->clientmode) {
>  	case CLIENT_NONE:
> -		return alfred_server(globals);
> +		ret =3D alfred_server(globals);
>  		break;
>  	case CLIENT_REQUEST_DATA:
> -		return alfred_client_request_data(globals);
> +		ret =3D alfred_client_request_data(globals);
>  		break;
>  	case CLIENT_SET_DATA:
> -		return alfred_client_set_data(globals);
> +		ret =3D alfred_client_set_data(globals);
>  		break;
> +	default:
> +		ret =3D 0;
>  	}
> =20
> -	return 0;
> +	free(globals->interface);
> +	free(globals->mesh_iface);
> +	free(globals);
> +
> +	return ret;

Hrm, apart from that this patch lacks a commit message and signoff, what do=
es it help
freeing stuff just before the program exits? This will free anything automa=
tically
anyway ...

Cheers,
	Simon

--UugvWAfsgieZRqgk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEARECAAYFAlIt5G8ACgkQrzg/fFk7axaF8gCdEMVc97ru2LlD83B2vvlJRFHx
SaMAn1kChHdb282yIjwgF2kmd4e0g/BY
=XPbc
-----END PGP SIGNATURE-----

--UugvWAfsgieZRqgk--
