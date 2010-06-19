Return-Path: <simon.wunderlich@s2003.tu-chemnitz.de>
Date: Sun, 20 Jun 2010 00:23:55 +0200
From: Simon Wunderlich <simon.wunderlich@s2003.tu-chemnitz.de>
Message-ID: <20100619222355.GA25183@pandem0nium>
References: <1276961074-3223-1-git-send-email-linus.luessing@web.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="pf9I7BMVVzbSWLtt"
Content-Disposition: inline
In-Reply-To: <1276961074-3223-1-git-send-email-linus.luessing@web.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: Avoid rounding issues
	for	local hna timeout
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


--pf9I7BMVVzbSWLtt
Content-Type: text/plain; charset=utf8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey Linus,

thanks, applied in r1710.

Cheers,
	Simon

On Sat, Jun 19, 2010 at 05:24:34PM +0200, Linus L=C3=BCssing wrote:
> With the current default values, this patch is not critical, as
> LOCAL_HNA_TIMEOUT is a multiple of 1000 anyway. However, if someone
> would like to change this #define, the person could have some
> unexpected rounding issues. Therefore doing the multiplication before
> the division now.
>=20
> Signed-off-by: Linus L=C3=BCssing <linus.luessing@web.de>
> ---
>  translation-table.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>=20
> diff --git a/translation-table.c b/translation-table.c
> index 619a9a8..cf37cc4 100644
> --- a/translation-table.c
> +++ b/translation-table.c
> @@ -259,7 +259,7 @@ static void hna_local_purge(struct work_struct *work)
>  		hna_local_entry =3D hashit.bucket->data;
> =20
>  		timeout =3D hna_local_entry->last_seen +
> -			((LOCAL_HNA_TIMEOUT / 1000) * HZ);
> +			((LOCAL_HNA_TIMEOUT * HZ) / 1000);
>  		if ((!hna_local_entry->never_purge) &&
>  		    time_after(jiffies, timeout))
>  			hna_local_del(hna_local_entry, "address timed out");
> --=20
> 1.7.1
>=20
>=20

--pf9I7BMVVzbSWLtt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkwdQ3sACgkQrzg/fFk7axZ8BQCdGEghZeMW9jCxSZxYle7WTW7h
8W8AoILPDJbGkDw7tn6fkKRfMj0WqbwP
=MjQB
-----END PGP SIGNATURE-----

--pf9I7BMVVzbSWLtt--
