Return-Path: <simon.wunderlich@s2003.tu-chemnitz.de>
Date: Wed, 17 Oct 2012 22:17:54 +0200
From: Simon Wunderlich <simon.wunderlich@s2003.tu-chemnitz.de>
Message-ID: <20121017201754.GC31782@pandem0nium>
References: <1350503758-20685-1-git-send-email-sven@narfation.org>
 <1350503758-20685-3-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="5G06lTa6Jq83wMTw"
Content-Disposition: inline
In-Reply-To: <1350503758-20685-3-git-send-email-sven@narfation.org>
Subject: Re: [B.A.T.M.A.N.] [PATCH 3/4] alfred: Test for failed global
 memory allocation
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


--5G06lTa6Jq83wMTw
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Applied in revision 09c40ac.

Thanks,
	Simon

On Wed, Oct 17, 2012 at 09:55:57PM +0200, Sven Eckelmann wrote:
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> ---
>  main.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/main.c b/main.c
> index 96e401a..ccb72cd 100644
> --- a/main.c
> +++ b/main.c
> @@ -67,11 +67,11 @@ struct globals *alfred_init(int argc, char *argv[])
>  	};
> =20
>  	globals =3D malloc(sizeof(*globals));
> -	memset(globals, 0, sizeof(*globals));
> -
>  	if (!globals)
>  		return NULL;
> =20
> +	memset(globals, 0, sizeof(*globals));
> +
>  	globals->opmode =3D OPMODE_SLAVE;
>  	globals->clientmode =3D CLIENT_NONE;
>  	globals->interface =3D NULL;
> --=20
> 1.7.10.4
>=20
>=20

--5G06lTa6Jq83wMTw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAlB/EnIACgkQrzg/fFk7axaiaQCfZcaKbCn+fPMDksDR4C9VWFdm
t1YAn2qHfouehXt7XZS5c5NMe69DUimZ
=1UpE
-----END PGP SIGNATURE-----

--5G06lTa6Jq83wMTw--
