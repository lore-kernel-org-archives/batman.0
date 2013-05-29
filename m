Return-Path: <simon.wunderlich@s2003.tu-chemnitz.de>
Date: Wed, 29 May 2013 16:16:57 +0200
From: Simon Wunderlich <simon.wunderlich@s2003.tu-chemnitz.de>
Message-ID: <20130529141657.GB23657@pandem0nium>
References: <1369779649-2537-1-git-send-email-ordex@autistici.org>
 <1369779649-2537-7-git-send-email-ordex@autistici.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="PmA2V3Z32TCmWXqI"
Content-Disposition: inline
In-Reply-To: <1369779649-2537-7-git-send-email-ordex@autistici.org>
Subject: Re: [B.A.T.M.A.N.] [RFC 05/10] batman-adv: add
 bat_metric_is_similar API function
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


--PmA2V3Z32TCmWXqI
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 29, 2013 at 12:20:45AM +0200, Antonio Quartulli wrote:
> From: Antonio Quartulli <antonio@open-mesh.com>
>=20
> Each routing protocol has its own metric semantic and
> therefore is the protocol itself the only component able to
> compare two metrics to check similarity similarity.
>=20
> This new API allows each routing protocol to implement its
> own logic and make the external code protocol agnostic.
>=20
> Signed-off-by: Antonio Quartulli <antonio@open-mesh.com>
> ---
>  bat_iv_ogm.c | 7 +++++++
>  main.c       | 3 ++-
>  main.h       | 6 ++++++
>  types.h      | 3 +++
>  4 files changed, 18 insertions(+), 1 deletion(-)
>=20
> diff --git a/bat_iv_ogm.c b/bat_iv_ogm.c
> index abf4cd3..18c9ae8 100644
> --- a/bat_iv_ogm.c
> +++ b/bat_iv_ogm.c
> @@ -1441,6 +1441,12 @@ static uint32_t batadv_iv_ogm_metric_get(struct ba=
tadv_neigh_node *neigh_node)
>  	return neigh_node->bat_iv.tq_avg;
>  }
> =20
> +static bool batadv_iv_ogm_metric_is_similar(uint32_t metric,
> +					    uint32_t new_metric)
> +{
> +	return (metric - new_metric < BATADV_TQ_SIMILARITY_THRESHOLD);

You might want to use abs(metric - new_metric) here, otherwise is_similar(a=
, b) output
might differ from is_similar(b, a).
> +}
> +

--PmA2V3Z32TCmWXqI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEARECAAYFAlGmDdkACgkQrzg/fFk7axbNjACfQBf9KTmMMRDbfq87QonjJuRE
f/4AoMC8P3nYQNY1SFtp2de8tbc7swJN
=6r7h
-----END PGP SIGNATURE-----

--PmA2V3Z32TCmWXqI--
