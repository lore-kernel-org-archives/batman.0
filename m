Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Mon, 26 Aug 2013 11:11:37 +0800
References: <1376376232-2178-1-git-send-email-ordex@autistici.org>
 <1376376232-2178-7-git-send-email-ordex@autistici.org>
In-Reply-To: <1376376232-2178-7-git-send-email-ordex@autistici.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201308261111.37380.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCHv3 6/9] batman-adv: adapt bonding to use
	the new API functions
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

On Tuesday, August 13, 2013 14:43:49 Antonio Quartulli wrote:
> -void batadv_bonding_candidate_add(struct batadv_orig_node *orig_node,
> +void batadv_bonding_candidate_add(struct batadv_priv *bat_priv,
> +				  struct batadv_orig_node *orig_node,
>  				  struct batadv_neigh_node *neigh_node)
>  {

Kernel doc ?


> @@ -133,8 +136,9 @@ void batadv_bonding_candidate_add(struct
> batadv_orig_node *orig_node, goto candidate_del;
> 
>  	/* ... and is good enough to be considered */
> -	if (neigh_node->bat_iv.tq_avg <
> -	    router->bat_iv.tq_avg - BATADV_BONDING_TQ_THRESHOLD)
> +	router_metric = bao->bat_metric_get(router);
> +	neigh_metric = bao->bat_metric_get(neigh_node);
> +	if (bao->bat_metric_is_equiv_or_better(neigh_metric, router_metric))
>  		goto candidate_del;

[..]


>  	/* check if we have another candidate with the same mac address or
> @@ -486,11 +490,14 @@ out:
>   * Increases the returned router's refcount
>   */
>  static struct batadv_neigh_node *
> -batadv_find_ifalter_router(struct batadv_orig_node *primary_orig,
> +batadv_find_ifalter_router(struct batadv_priv *bat_priv,
> +			   struct batadv_orig_node *primary_orig,
>  			   const struct batadv_hard_iface *recv_if)
>  {

Kernel doc ?


> -	struct batadv_neigh_node *tmp_neigh_node;
>  	struct batadv_neigh_node *router = NULL, *first_candidate = NULL;
> +	struct batadv_algo_ops *bao = bat_priv->bat_algo_ops;
> +	struct batadv_neigh_node *tmp_neigh_node;
> +	uint32_t tmp_metric, router_metric = UINT_MAX;
> 
>  	rcu_read_lock();
>  	list_for_each_entry_rcu(tmp_neigh_node, &primary_orig->bond_list,
> @@ -502,8 +509,8 @@ batadv_find_ifalter_router(struct batadv_orig_node
> *primary_orig, if (tmp_neigh_node->if_incoming == recv_if)
>  			continue;
> 
> -		if (router &&
> -		    tmp_neigh_node->bat_iv.tq_avg <= router->bat_iv.tq_avg)
> +		tmp_metric = bao->bat_metric_get(tmp_neigh_node);
> +		if (router && (tmp_metric <= router_metric))
>  			continue;

This last comparison looks horribly wrong. Isn't that what we have the API 
for?

Besides, it seems to me the bat_metric_is_equiv_or_better() call has been 
misdesigned. Instead of passing the metric and having each function store + 
process the metric this call should accept 2 neighbor nodes as argument. This 
should save 2 out of 3 API calls (2 * bao->bat_metric_get()) and some code in 
all the functions needing the bat_metric_is_equiv_or_better() API. Moreover, 
it should reduce the impact on performance because each callback will cost us 
a little bit ..

Cheers,
Marek
