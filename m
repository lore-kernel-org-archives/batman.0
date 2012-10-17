Return-Path: <simon.wunderlich@s2003.tu-chemnitz.de>
Date: Wed, 17 Oct 2012 22:17:34 +0200
From: Simon Wunderlich <simon.wunderlich@s2003.tu-chemnitz.de>
Message-ID: <20121017201734.GB31782@pandem0nium>
References: <1350503758-20685-1-git-send-email-sven@narfation.org>
 <1350503758-20685-2-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="Bn2rw/3z4jIqBvZU"
Content-Disposition: inline
In-Reply-To: <1350503758-20685-2-git-send-email-sven@narfation.org>
Subject: Re: [B.A.T.M.A.N.] [PATCH 2/4] alfred: Fix parsing of short program
 parameter -v and -V
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


--Bn2rw/3z4jIqBvZU
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Applied in revision 3c2de69.

Thanks,
	Simon

On Wed, Oct 17, 2012 at 09:55:56PM +0200, Sven Eckelmann wrote:
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> ---
>  main.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/main.c b/main.c
> index 0315fe3..96e401a 100644
> --- a/main.c
> +++ b/main.c
> @@ -78,7 +78,7 @@ struct globals *alfred_init(int argc, char *argv[])
>  	globals->best_server =3D NULL;
>  	globals->clientmode_version =3D 0;
> =20
> -	while ((opt =3D getopt_long(argc, argv, "ms:r:hi:", long_options,
> +	while ((opt =3D getopt_long(argc, argv, "ms:r:hi:vV:", long_options,
>  				  &opt_ind)) !=3D -1) {
>  		switch (opt) {
>  		case 'r':
> --=20
> 1.7.10.4
>=20
>=20

--Bn2rw/3z4jIqBvZU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAlB/El4ACgkQrzg/fFk7axbVqACgyMdL+AkOabPC7XlyNy5Z6RKM
2+EAoNekQbZXgNbjh0lNT65+t5FMOxpY
=jIFI
-----END PGP SIGNATURE-----

--Bn2rw/3z4jIqBvZU--
