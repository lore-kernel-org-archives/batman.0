Return-Path: <simon.wunderlich@s2003.tu-chemnitz.de>
Date: Wed, 29 May 2013 16:32:21 +0200
From: Simon Wunderlich <simon.wunderlich@s2003.tu-chemnitz.de>
Message-ID: <20130529143221.GD23657@pandem0nium>
References: <1369779649-2537-1-git-send-email-ordex@autistici.org>
 <1369779649-2537-10-git-send-email-ordex@autistici.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="mJm6k4Vb/yFcL9ZU"
Content-Disposition: inline
In-Reply-To: <1369779649-2537-10-git-send-email-ordex@autistici.org>
Subject: Re: [B.A.T.M.A.N.] [RFC 08/10] batman-adv: adapt the gateway
 feature to use the new API functions
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


--mJm6k4Vb/yFcL9ZU
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 29, 2013 at 12:20:48AM +0200, Antonio Quartulli wrote:
> From: Antonio Quartulli <antonio@open-mesh.com>
>=20
> Signed-off-by: Antonio Quartulli <antonio@open-mesh.com>
> ---
>  gateway_client.c | 74 +++++++++++++++++++++++++++++++-------------------=
------
>  main.h           |  1 +
>  2 files changed, 42 insertions(+), 33 deletions(-)
>=20
> diff --git a/gateway_client.c b/gateway_client.c
> index 69488b2..0a9f1d0 100644
> --- a/gateway_client.c
> +++ b/gateway_client.c
> @@ -113,13 +113,13 @@ void batadv_gw_deselect(struct batadv_priv *bat_pri=
v)
>  static struct batadv_gw_node *
>  batadv_gw_get_best_gw_node(struct batadv_priv *bat_priv)
>  {
> -	struct batadv_neigh_node *router;
> +	struct batadv_algo_ops *bao =3D bat_priv->bat_algo_ops;
>  	struct batadv_gw_node *gw_node, *curr_gw =3D NULL;
>  	uint32_t max_gw_factor =3D 0, tmp_gw_factor =3D 0;
> -	uint32_t gw_divisor;
> -	uint8_t max_tq =3D 0;
> -	uint8_t tq_avg;
>  	struct batadv_orig_node *orig_node;
> +	struct batadv_neigh_node *router;
> +	uint32_t metric, max_metric =3D 0;
> +	uint32_t gw_divisor;
> =20
>  	gw_divisor =3D BATADV_TQ_LOCAL_WINDOW_SIZE * BATADV_TQ_LOCAL_WINDOW_SIZ=
E;
>  	gw_divisor *=3D 64;
> @@ -137,18 +137,19 @@ batadv_gw_get_best_gw_node(struct batadv_priv *bat_=
priv)
>  		if (!atomic_inc_not_zero(&gw_node->refcount))
>  			goto next;
> =20
> -		tq_avg =3D router->bat_iv.tq_avg;
> +		metric =3D bao->bat_metric_get(router);
> =20
>  		switch (atomic_read(&bat_priv->gw_sel_class)) {
>  		case 1: /* fast connection */
> -			tmp_gw_factor =3D tq_avg * tq_avg;
> +			tmp_gw_factor =3D metric * metric;

Hmm, that is rather strange ... I think fiddling with the metric directly
this way is weird when abstracting. For example:
 1.) Assuming we don't know how the metric looks like, we can't just
     multiplicate them. A logarithmic scaled metric or even arbritrary
     metric would look different compared to the linear metrics as we
     use now.
 2.) This might overflow because metric is u32 and tmp_gw_factor is too.
     It should work for batman IV where the metric is <256, but might
     not for BATMAN V.

I think this "bandwidth magic" should be abstracted as well somehow, if
we want to keep on using it that way.

>  			tmp_gw_factor *=3D gw_node->bandwidth_down;
>  			tmp_gw_factor *=3D 100 * 100;
>  			tmp_gw_factor /=3D gw_divisor;
> =20
>  			if ((tmp_gw_factor > max_gw_factor) ||
>  			    ((tmp_gw_factor =3D=3D max_gw_factor) &&
> -			     (tq_avg > max_tq))) {
> +			     (bao->bat_metric_compare(metric,
> +						      max_metric) > 0))) {
>  				if (curr_gw)
>  					batadv_gw_node_free_ref(curr_gw);
>  				curr_gw =3D gw_node;
> @@ -163,7 +164,7 @@ batadv_gw_get_best_gw_node(struct batadv_priv *bat_pr=
iv)
>  			  *     soon as a better gateway appears which has
>  			  *     $routing_class more tq points)
>  			  */
> -			if (tq_avg > max_tq) {
> +			if (bao->bat_metric_compare(metric, max_metric) > 0) {
>  				if (curr_gw)
>  					batadv_gw_node_free_ref(curr_gw);
>  				curr_gw =3D gw_node;
> @@ -172,8 +173,8 @@ batadv_gw_get_best_gw_node(struct batadv_priv *bat_pr=
iv)
>  			break;
>  		}
> =20
> -		if (tq_avg > max_tq)
> -			max_tq =3D tq_avg;
> +		if (bao->bat_metric_compare(metric, max_metric) > 0)
> +			max_metric =3D metric;
> =20
>  		if (tmp_gw_factor > max_gw_factor)
>  			max_gw_factor =3D tmp_gw_factor;
> @@ -229,22 +230,24 @@ void batadv_gw_election(struct batadv_priv *bat_pri=
v)
>  				    NULL);
>  	} else if ((!curr_gw) && (next_gw)) {
>  		batadv_dbg(BATADV_DBG_BATMAN, bat_priv,
> -			   "Adding route to gateway %pM (bandwidth: %u.%u/%u.%u MBit, tq: %i)=
\n",
> +			   "Adding route to gateway %pM (bandwidth: %u.%u/%u.%u MBit, metric:=
 %u)\n",
>  			   next_gw->orig_node->orig,
>  			   next_gw->bandwidth_down / 10,
>  			   next_gw->bandwidth_down % 10,
>  			   next_gw->bandwidth_up / 10,
> -			   next_gw->bandwidth_up % 10, router->bat_iv.tq_avg);
> +			   next_gw->bandwidth_up % 10,
> +			   bat_priv->bat_algo_ops->bat_metric_get(router));
>  		batadv_throw_uevent(bat_priv, BATADV_UEV_GW, BATADV_UEV_ADD,
>  				    gw_addr);
>  	} else {
>  		batadv_dbg(BATADV_DBG_BATMAN, bat_priv,
> -			   "Changing route to gateway %pM (bandwidth: %u.%u/%u.%u MBit, tq: %=
i)\n",
> +			   "Changing route to gateway %pM (bandwidth: %u.%u/%u.%u MBit, metri=
c: %u)\n",
>  			   next_gw->orig_node->orig,
>  			   next_gw->bandwidth_down / 10,
>  			   next_gw->bandwidth_down % 10,
>  			   next_gw->bandwidth_up / 10,
> -			   next_gw->bandwidth_up % 10, router->bat_iv.tq_avg);
> +			   next_gw->bandwidth_up % 10,
> +			   bat_priv->bat_algo_ops->bat_metric_get(router));
>  		batadv_throw_uevent(bat_priv, BATADV_UEV_GW, BATADV_UEV_CHANGE,
>  				    gw_addr);
>  	}
> @@ -263,9 +266,10 @@ out:
>  void batadv_gw_check_election(struct batadv_priv *bat_priv,
>  			      struct batadv_orig_node *orig_node)
>  {
> -	struct batadv_orig_node *curr_gw_orig;
>  	struct batadv_neigh_node *router_gw =3D NULL, *router_orig =3D NULL;
> -	uint8_t gw_tq_avg, orig_tq_avg;
> +	struct batadv_algo_ops *bao =3D bat_priv->bat_algo_ops;
> +	struct batadv_orig_node *curr_gw_orig;
> +	uint16_t gw_metric, orig_metric;
> =20
>  	curr_gw_orig =3D batadv_gw_get_selected_orig(bat_priv);
>  	if (!curr_gw_orig)
> @@ -283,23 +287,25 @@ void batadv_gw_check_election(struct batadv_priv *b=
at_priv,
>  	if (!router_orig)
>  		goto out;
> =20
> -	gw_tq_avg =3D router_gw->bat_iv.tq_avg;
> -	orig_tq_avg =3D router_orig->bat_iv.tq_avg;
> +	gw_metric =3D bao->bat_metric_get(router_gw);
> +	orig_metric =3D bao->bat_metric_get(router_orig);
> =20
> -	/* the TQ value has to be better */
> -	if (orig_tq_avg < gw_tq_avg)
> +	/* the metric has to be better */
> +	if (bao->bat_metric_compare(orig_metric, gw_metric) > 0)
>  		goto out;
> =20
>  	/* if the routing class is greater than 3 the value tells us how much
> -	 * greater the TQ value of the new gateway must be
> +	 * greater the metric of the new gateway must be.
> +	 *
> +	 * FIXME: This comparison is strictly TQ related.
>  	 */
>  	if ((atomic_read(&bat_priv->gw_sel_class) > 3) &&
> -	    (orig_tq_avg - gw_tq_avg < atomic_read(&bat_priv->gw_sel_class)))
> +	    (orig_metric - gw_metric < atomic_read(&bat_priv->gw_sel_class)))
>  		goto out;
> =20
>  	batadv_dbg(BATADV_DBG_BATMAN, bat_priv,
> -		   "Restarting gateway selection: better gateway found (tq curr: %i, t=
q new: %i)\n",
> -		   gw_tq_avg, orig_tq_avg);
> +		   "Restarting gateway selection: better gateway found (metric curr: %=
u, metric new: %u)\n",
> +		   gw_metric, orig_metric);
> =20
>  deselect:
>  	batadv_gw_deselect(bat_priv);
> @@ -503,11 +509,11 @@ static int batadv_write_buffer_text(struct batadv_p=
riv *bat_priv,
> =20
>  	curr_gw =3D batadv_gw_get_selected_gw_node(bat_priv);
> =20
> -	ret =3D seq_printf(seq, "%s %pM (%3i) %pM [%10s]: %u.%u/%u.%u MBit\n",
> +	ret =3D seq_printf(seq, "%s %pM (%10u) %pM [%10s]: %u.%u/%u.%u MBit\n",
>  			 (curr_gw =3D=3D gw_node ? "=3D>" : "  "),
>  			 gw_node->orig_node->orig,
> -			 router->bat_iv.tq_avg, router->addr,
> -			 router->if_incoming->net_dev->name,
> +			 bat_priv->bat_algo_ops->bat_metric_get(router),
> +			 router->addr, router->if_incoming->net_dev->name,
>  			 gw_node->bandwidth_down / 10,
>  			 gw_node->bandwidth_down % 10,
>  			 gw_node->bandwidth_up / 10,
> @@ -533,8 +539,8 @@ int batadv_gw_client_seq_print_text(struct seq_file *=
seq, void *offset)
>  		goto out;
> =20
>  	seq_printf(seq,
> -		   "      %-12s (%s/%i) %17s [%10s]: advertised uplink bandwidth ... [=
B.A.T.M.A.N. adv %s, MainIF/MAC: %s/%pM (%s)]\n",
> -		   "Gateway", "#", BATADV_TQ_MAX_VALUE, "Nexthop", "outgoingIF",
> +		   "      %-12s (%-4s) %17s [%10s]: advertised uplink bandwidth ... [B=
=2EA.T.M.A.N. adv %s, MainIF/MAC: %s/%pM (%s)]\n",
> +		   "Gateway", "#", "Nexthop", "outgoingIF",
>  		   BATADV_SOURCE_VERSION, primary_if->net_dev->name,
>  		   primary_if->net_dev->dev_addr, net_dev->name);
> =20
> @@ -707,12 +713,13 @@ bool batadv_gw_is_dhcp_target(struct sk_buff *skb, =
unsigned int *header_len)
>  bool batadv_gw_out_of_range(struct batadv_priv *bat_priv,
>  			    struct sk_buff *skb, struct ethhdr *ethhdr)
>  {
> +	struct batadv_algo_ops *bao =3D bat_priv->bat_algo_ops;
>  	struct batadv_neigh_node *neigh_curr =3D NULL, *neigh_old =3D NULL;
>  	struct batadv_orig_node *orig_dst_node =3D NULL;
>  	struct batadv_gw_node *gw_node =3D NULL, *curr_gw =3D NULL;
>  	bool ret, out_of_range =3D false;
>  	unsigned int header_len =3D 0;
> -	uint8_t curr_tq_avg;
> +	uint32_t curr_metric;
>  	unsigned short vid;
> =20
>  	vid =3D batadv_get_vid(skb, 0);
> @@ -739,7 +746,7 @@ bool batadv_gw_out_of_range(struct batadv_priv *bat_p=
riv,
>  		/* If we are a GW then we are our best GW. We can artificially
>  		 * set the tq towards ourself as the maximum value
>  		 */
> -		curr_tq_avg =3D BATADV_TQ_MAX_VALUE;
> +		curr_metric =3D BATADV_MAX_METRIC;
>  		break;
>  	case BATADV_GW_MODE_CLIENT:
>  		curr_gw =3D batadv_gw_get_selected_gw_node(bat_priv);
> @@ -759,7 +766,7 @@ bool batadv_gw_out_of_range(struct batadv_priv *bat_p=
riv,
>  		if (!neigh_curr)
>  			goto out;
> =20
> -		curr_tq_avg =3D neigh_curr->bat_iv.tq_avg;
> +		curr_metric =3D bao->bat_metric_get(neigh_curr);
>  		break;
>  	case BATADV_GW_MODE_OFF:
>  	default:
> @@ -770,7 +777,8 @@ bool batadv_gw_out_of_range(struct batadv_priv *bat_p=
riv,
>  	if (!neigh_old)
>  		goto out;
> =20
> -	if (curr_tq_avg - neigh_old->bat_iv.tq_avg > BATADV_GW_THRESHOLD)
> +	if (bao->bat_metric_is_similar(bao->bat_metric_get(neigh_old),
> +				       curr_metric))
>  		out_of_range =3D true;

Hmm ... if you add the abs for metric_is_similar as suggested for the patch=
 introducing
the function, this one would fail. For BATMAN IV, curr_metric would be 0xff=
ffffff and
the neigh_old would be something < 256, making this function fail for the B=
ATADV_GW_MODE_SERVER
case.=20

Actually BATADV_GW_MODE_SERVER could just set out_of_range and goto out, I =
don't understand
the purpose of this "artificially setting the tq towards ourself" is good f=
or.

> =20
>  out:
> diff --git a/main.h b/main.h
> index 1d3611f..8d69641 100644
> --- a/main.h
> +++ b/main.h
> @@ -31,6 +31,7 @@
> =20
>  /* B.A.T.M.A.N. parameters */
> =20
> +#define BATADV_MAX_METRIC 0xffffffff
>  #define BATADV_TQ_MAX_VALUE 255
>  #define BATADV_JITTER 20
> =20
> --=20
> 1.8.1.5
>=20

--mJm6k4Vb/yFcL9ZU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEARECAAYFAlGmEXUACgkQrzg/fFk7axaNrwCggeaXG5PB90SXBVi6e1p2FTmB
t3wAoPVHj5KKBNFNtW6oFsGVLOiLgEUX
=eyym
-----END PGP SIGNATURE-----

--mJm6k4Vb/yFcL9ZU--
