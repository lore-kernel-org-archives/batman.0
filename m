Return-Path: <simon.wunderlich@s2003.tu-chemnitz.de>
Date: Sat, 3 Aug 2013 23:10:07 +0200
From: Simon Wunderlich <simon.wunderlich@s2003.tu-chemnitz.de>
Message-ID: <20130803211005.GD12891@pandem0nium>
References: <1375303667-3018-1-git-send-email-ordex@autistici.org>
 <1375303667-3018-6-git-send-email-ordex@autistici.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="LTeJQqWS0MN7I/qa"
Content-Disposition: inline
In-Reply-To: <1375303667-3018-6-git-send-email-ordex@autistici.org>
Subject: Re: [B.A.T.M.A.N.] [RFCv2 05/10] batman-adv: add
 bat_metric_is_equiv_or_better API function
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
Cc: Antonio Quartulli <antonio@open-mesh.com>


--LTeJQqWS0MN7I/qa
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 31, 2013 at 10:47:42PM +0200, Antonio Quartulli wrote:
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
>  bat_iv_ogm.c | 6 ++++++
>  main.c       | 3 ++-
>  main.h       | 6 ++++++
>  types.h      | 4 ++++
>  4 files changed, 18 insertions(+), 1 deletion(-)
>=20
> diff --git a/bat_iv_ogm.c b/bat_iv_ogm.c
> index 32e0321..2e03fdb 100644
> --- a/bat_iv_ogm.c
> +++ b/bat_iv_ogm.c
> @@ -1465,6 +1465,11 @@ static uint32_t batadv_iv_ogm_metric_get(struct ba=
tadv_neigh_node *neigh_node)
>  	return neigh_node->bat_iv.tq_avg;
>  }
> =20
> +static bool batadv_iv_ogm_metric_is_eob(uint32_t metric, uint32_t new_me=
tric)
> +{
> +	return (metric - new_metric < BATADV_TQ_SIMILARITY_THRESHOLD);
> +}
> +

Since it's static anyway, maybe call this function batadv_iv_ogm_metric_is_=
equiv_or_better instead? eob
looks so ... random. :) Also, maybe use BATADV_IV_TQ_SIMILARITY_THRESHOLD? =
Although TQ somehow implies
BATADV_IV ...

>  static struct batadv_algo_ops batadv_batman_iv __read_mostly =3D {
>  	.name =3D "BATMAN_IV",
>  	.bat_iface_enable =3D batadv_iv_ogm_iface_enable,
> @@ -1474,6 +1479,7 @@ static struct batadv_algo_ops batadv_batman_iv __re=
ad_mostly =3D {
>  	.bat_ogm_schedule =3D batadv_iv_ogm_schedule,
>  	.bat_ogm_emit =3D batadv_iv_ogm_emit,
>  	.bat_metric_get =3D batadv_iv_ogm_metric_get,
> +	.bat_metric_is_equiv_or_better =3D batadv_iv_ogm_metric_is_eob,
>  	.bat_orig_print =3D batadv_iv_ogm_orig_print,
>  };
> =20
> diff --git a/main.c b/main.c
> index cc75126..d263a42 100644
> --- a/main.c
> +++ b/main.c
> @@ -446,7 +446,8 @@ int batadv_algo_register(struct batadv_algo_ops *bat_=
algo_ops)
>  	    !bat_algo_ops->bat_primary_iface_set ||
>  	    !bat_algo_ops->bat_ogm_schedule ||
>  	    !bat_algo_ops->bat_ogm_emit ||
> -	    !bat_algo_ops->bat_metric_get) {
> +	    !bat_algo_ops->bat_metric_get ||
> +	    !bat_algo_ops->bat_metric_is_equiv_or_better) {
>  		pr_info("Routing algo '%s' does not implement required ops\n",
>  			bat_algo_ops->name);
>  		ret =3D -EINVAL;
> diff --git a/main.h b/main.h
> index 7b68db9..9b365ad 100644
> --- a/main.h
> +++ b/main.h
> @@ -86,6 +86,12 @@
>  /* numbers of originator to contact for any PUT/GET DHT operation */
>  #define BATADV_DAT_CANDIDATES_NUM 3
> =20
> +/**
> + * BATADV_TQ_SIMILARITY_THRESHOLD - TQ points that a secondary metric ca=
n differ
> + *  at most from the primary one in order to be still considered accepta=
ble
> + */
> +#define BATADV_TQ_SIMILARITY_THRESHOLD 50
> +
>  /* how much worse secondary interfaces may be to be considered as bonding
>   * candidates
>   */
> diff --git a/types.h b/types.h
> index e994fe0..8885dc0 100644
> --- a/types.h
> +++ b/types.h
> @@ -991,6 +991,8 @@ struct batadv_forw_packet {
>   * @bat_primary_iface_set: called when primary interface is selected / c=
hanged
>   * @bat_ogm_schedule: prepare a new outgoing OGM for the send queue
>   * @bat_ogm_emit: send scheduled OGM
> + * @bat_metric_is_equiv_or_better: check if new_metric is good enough to=
 be
> + *  comparable with metric
>   * @bat_orig_print: print the originator table
>   */
>  struct batadv_algo_ops {
> @@ -1003,6 +1005,8 @@ struct batadv_algo_ops {
>  	void (*bat_ogm_schedule)(struct batadv_hard_iface *hard_iface);
>  	void (*bat_ogm_emit)(struct batadv_forw_packet *forw_packet);
>  	uint32_t (*bat_metric_get)(struct batadv_neigh_node *neigh_node);
> +	bool (*bat_metric_is_equiv_or_better)(uint32_t metric,
> +					      uint32_t new_metric);
>  	/* orig_node handling API */
>  	void (*bat_orig_print)(struct batadv_priv *priv, struct seq_file *seq);
>  };
> --=20
> 1.8.1.5
>=20

--LTeJQqWS0MN7I/qa
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEARECAAYFAlH9caoACgkQrzg/fFk7axY8JQCeL8+V97jbePJcwfyaTMEaHtUs
TUwAoKy50LAPoU5ZOr3q1j9MyoW/q29X
=UBCi
-----END PGP SIGNATURE-----

--LTeJQqWS0MN7I/qa--
