Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Tue, 8 Feb 2011 14:18:37 +0100
References: <201102031802.52134.lindner_marek@yahoo.de>
	<1296832896-30081-6-git-send-email-linus.luessing@ascom.ch>
In-Reply-To: <1296832896-30081-6-git-send-email-linus.luessing@ascom.ch>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Message-Id: <201102081418.38151.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH 5/7] batman-adv: Make bat_priv->curr_gw
	an rcu protected pointer
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


On Friday 04 February 2011 16:21:34 Linus L=C3=BCssing wrote:
> +	if (curr_gw) {
> +		rcu_read_unlock();
>  		return;
> +	}
>=20
> -	rcu_read_lock();
>  	if (hlist_empty(&bat_priv->gw_list)) {
> -		rcu_read_unlock();
>=20
> -		if (bat_priv->curr_gw) {
> +		if (curr_gw) {
> +			rcu_read_unlock();
>  			bat_dbg(DBG_BATMAN, bat_priv,
>  				"Removing selected gateway - "
>  				"no gateway in range\n");
>  			gw_deselect(bat_priv);
>  		}
> +		else
> +			rcu_read_unlock();

This is a bit odd here - we return if curr_gw is not NULL and later we prin=
t a=20
message if curr_gw is not NULL ?=20
The issue existed before your patch came along.


>  void gw_check_election(struct bat_priv *bat_priv, struct orig_node
> *orig_node) {
> -	struct gw_node *curr_gateway_tmp =3D bat_priv->curr_gw;
> +	struct gw_node *curr_gateway_tmp;
>  	uint8_t gw_tq_avg, orig_tq_avg;
>=20
> +	rcu_read_lock();
> +	curr_gateway_tmp =3D rcu_dereference(bat_priv->curr_gw);
>  	if (!curr_gateway_tmp)
> -		return;
> +		goto rcu_unlock;
>=20
>  	if (!curr_gateway_tmp->orig_node)
>  		goto deselect;

It seems if we jump to "deselect" here the rcu_lock() will never be unlocke=
d.


> @@ -316,7 +342,7 @@ void gw_node_purge(struct bat_priv *bat_priv)
> -		if (bat_priv->curr_gw =3D=3D gw_node)
> +		if (rcu_dereference(bat_priv->curr_gw) =3D=3D gw_node)
>  			gw_deselect(bat_priv);

At this point we neither hold a rcu_lock() nor the newly created spinlock .=
=2E.


>  	spinlock_t gw_list_lock; /* protects gw_list */
> +	spinlock_t curr_gw_lock; /* protects curr_gw updates */

Would speak anything against re-using the gw_list_lock ?

Regards,
Marek
