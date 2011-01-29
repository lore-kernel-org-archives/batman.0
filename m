Return-Path: <simon.wunderlich@s2003.tu-chemnitz.de>
Date: Sat, 29 Jan 2011 18:44:02 +0100
From: Simon Wunderlich <simon.wunderlich@s2003.tu-chemnitz.de>
Message-ID: <20110129174402.GA11792@pandem0nium>
References: <1296236047-15200-1-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="FCuugMFkClbJLl1L"
Content-Disposition: inline
In-Reply-To: <1296236047-15200-1-git-send-email-sven@narfation.org>
Subject: Re: [B.A.T.M.A.N.] [PATCH 1/3] batman-adv: Remove vis info
	on	hashing errors
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


--FCuugMFkClbJLl1L
Content-Type: text/plain; charset=utf8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Sven,

i've applied your patches in r1922-r1924.

Thanks for your contribution
	Simon

On Fri, Jan 28, 2011 at 06:34:05PM +0100, Sven Eckelmann wrote:
> A newly created vis info object must be removed when it couldn't be
> added to the hash. The old_info which has to be replaced was already
> removed and isn't related to the hash anymore.
>=20
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> ---
>  batman-adv/vis.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>=20
> diff --git a/batman-adv/vis.c b/batman-adv/vis.c
> index 2cdf01c..9d2729c 100644
> --- a/batman-adv/vis.c
> +++ b/batman-adv/vis.c
> @@ -446,7 +446,7 @@ static struct vis_info *add_packet(struct bat_priv *b=
at_priv,
>  			      info);
>  	if (hash_added < 0) {
>  		/* did not work (for some reason) */
> -		kref_put(&old_info->refcount, free_info);
> +		kref_put(&info->refcount, free_info);
>  		info =3D NULL;
>  	}
> =20
> --=20
> 1.7.2.3
>=20
>=20

--FCuugMFkClbJLl1L
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAk1EUeIACgkQrzg/fFk7axZBPACdGlEJPFM3QHpJU6EGScZmY4cv
NagAn04CLAuxHnHkgE6ctm2PlESf5N//
=ZEQV
-----END PGP SIGNATURE-----

--FCuugMFkClbJLl1L--
