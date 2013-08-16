Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Fri, 16 Aug 2013 12:01:36 +0800
References: <1376376232-2178-1-git-send-email-ordex@autistici.org>
 <1376376232-2178-3-git-send-email-ordex@autistici.org>
In-Reply-To: <1376376232-2178-3-git-send-email-ordex@autistici.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201308161201.36653.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCHv3 2/9] batman-adv: make struct
	batadv_orig_node algorithm agnostic
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

On Tuesday, August 13, 2013 14:43:45 Antonio Quartulli wrote:
> From: Antonio Quartulli <antonio@open-mesh.com>
> 
> some of the struct batadv_orig_node members are B.A.T.M.A.N. IV
> specific and therefore they are moved in a algorithm specific
> substruct in order to make batadv_orig_node routing algorithm
> agnostic
> 
> Signed-off-by: Antonio Quartulli <antonio@open-mesh.com>
> ---
>  bat_iv_ogm.c | 93
> ++++++++++++++++++++++++++++++++++++++++++------------------ originator.c
> | 77 ++++++++++++++++++------------------------------- originator.h |  2
> +-
>  types.h      | 30 +++++++++++++-------
>  4 files changed, 114 insertions(+), 88 deletions(-)
> 
> diff --git a/bat_iv_ogm.c b/bat_iv_ogm.c
> index a0b11b0..b8114d6 100644
> --- a/bat_iv_ogm.c
> +++ b/bat_iv_ogm.c
> @@ -87,6 +87,42 @@ static uint8_t batadv_ring_buffer_avg(const uint8_t
> lq_recv[]) return (uint8_t)(sum / count);
>  }
> 
> +static struct batadv_orig_node *
> +batadv_iv_ogm_orig_get(struct batadv_priv *bat_priv, const uint8_t *addr)
> +{
> +	struct batadv_orig_node *orig_node;
> +	int size;
> +
> +	orig_node = batadv_orig_hash_find(bat_priv, addr);
> +	if (orig_node)
> +		return orig_node;
> +
> +	orig_node = batadv_orig_node_new(bat_priv, addr);
> +	if (!orig_node)
> +		return NULL;
> +
> +	spin_lock_init(&orig_node->bat_iv.ogm_cnt_lock);
> +
> +	size = bat_priv->num_ifaces * sizeof(unsigned long) * BATADV_NUM_WORDS;
> +	orig_node->bat_iv.bcast_own = kzalloc(size, GFP_ATOMIC);
> +	if (!orig_node->bat_iv.bcast_own)
> +		goto free_orig_node;
> +
> +	size = bat_priv->num_ifaces * sizeof(uint8_t);
> +	orig_node->bat_iv.bcast_own_sum = kzalloc(size, GFP_ATOMIC);
> +	if (!orig_node->bat_iv.bcast_own_sum)
> +		goto free_bcast_own;
> +
> +	return orig_node;
> +
> +free_bcast_own:
> +	kfree(orig_node->bat_iv.bcast_own);
> +free_orig_node:
> +	batadv_orig_node_free_ref(orig_node);
> +
> +	return NULL;
> +}

Kernel doc ?


> @@ -297,18 +297,13 @@ void batadv_originator_free(struct batadv_priv
> *bat_priv) /* this function finds or creates an originator entry for the
> given * address if it does not exits
>   */
> -struct batadv_orig_node *batadv_get_orig_node(struct batadv_priv
> *bat_priv, +struct batadv_orig_node *batadv_orig_node_new(struct
> batadv_priv *bat_priv, const uint8_t *addr)

When you are writing the kernel doc don't forget that you changed the behavior 
of this function.


> @@ -356,37 +350,21 @@ struct batadv_orig_node *batadv_get_orig_node(struct
> batadv_priv *bat_priv, */
>  	batadv_orig_node_vlan_free_ref(vlan);
> 
> -	size = bat_priv->num_ifaces * sizeof(unsigned long) * BATADV_NUM_WORDS;
> -
> -	orig_node->bcast_own = kzalloc(size, GFP_ATOMIC);
> -	if (!orig_node->bcast_own)
> -		goto free_vlan;
> -
> -	size = bat_priv->num_ifaces * sizeof(uint8_t);
> -	orig_node->bcast_own_sum = kzalloc(size, GFP_ATOMIC);
> -
>  	for (i = 0; i < BATADV_FRAG_BUFFER_COUNT; i++) {
>  		INIT_HLIST_HEAD(&orig_node->fragments[i].head);
>  		spin_lock_init(&orig_node->fragments[i].lock);
>  		orig_node->fragments[i].size = 0;
>  	}
> 
> -	if (!orig_node->bcast_own_sum)
> -		goto free_bcast_own;
> -
>  	hash_added = batadv_hash_add(bat_priv->orig_hash, batadv_compare_orig,
>  				     batadv_choose_orig, orig_node,
>  				     &orig_node->hash_entry);
> -	if (hash_added != 0)
> -		goto free_bcast_own_sum;
> +	if (hash_added != 0) {
> +		kfree(orig_node);
> +		return NULL;
> +	}

Why not go to free_orig_node ?

Cheers,
Marek
