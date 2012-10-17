Return-Path: <simon.wunderlich@s2003.tu-chemnitz.de>
Date: Wed, 17 Oct 2012 22:18:15 +0200
From: Simon Wunderlich <simon.wunderlich@s2003.tu-chemnitz.de>
Message-ID: <20121017201815.GD31782@pandem0nium>
References: <1350503758-20685-1-git-send-email-sven@narfation.org>
 <1350503758-20685-4-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="ZJcv+A0YCCLh2VIg"
Content-Disposition: inline
In-Reply-To: <1350503758-20685-4-git-send-email-sven@narfation.org>
Subject: Re: [B.A.T.M.A.N.] [PATCH 4/4] alfred: Fix test for failed sendbuf
 allocation
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


--ZJcv+A0YCCLh2VIg
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Applied in revision 4f92363.

Thanks,
	Simon

On Wed, Oct 17, 2012 at 09:55:58PM +0200, Sven Eckelmann wrote:
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> ---
>  recv.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/recv.c b/recv.c
> index dce7e50..8ddf7ab 100644
> --- a/recv.c
> +++ b/recv.c
> @@ -217,7 +217,7 @@ int send_alfred_packet(struct globals *globals, uint8=
_t *dest, void *buf,
>  	char *sendbuf;
> =20
>  	sendbuf =3D malloc(sizeof(*ethhdr) + length);
> -	if (!buf)
> +	if (!sendbuf)
>  		return -1;
> =20
>  	ethhdr =3D (struct ethhdr *)sendbuf;
> --=20
> 1.7.10.4
>=20
>=20

--ZJcv+A0YCCLh2VIg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAlB/EocACgkQrzg/fFk7axYFNQCfXRY6+etmgsQlZdSYMiUwfFE7
oHgAoKWQU74Ul1LlBk5V0PTWH5dLX18x
=5lQI
-----END PGP SIGNATURE-----

--ZJcv+A0YCCLh2VIg--
