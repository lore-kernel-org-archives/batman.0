Return-Path: <martin@darmstadt.freifunk.net>
References: <1464588694-19855-1-git-send-email-sven@narfation.org>
From: Martin Weinelt <martin@darmstadt.freifunk.net>
Message-ID: <87543f23-dcb6-fed6-c9a6-e32a6698dd52@darmstadt.freifunk.net>
Date: Tue, 31 May 2016 09:00:02 +0200
MIME-Version: 1.0
In-Reply-To: <1464588694-19855-1-git-send-email-sven@narfation.org>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [B.A.T.M.A.N.] [v2,
 maint] batman-adv: Fix use-after-free/double-free of tt_req_node
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Sven Eckelmann <sven@narfation.org>, b.a.t.m.a.n@lists.open-mesh.org
Cc: a@unstable.cc

Tested-by: Martin Weinelt <martin@darmstadt.freifunk.net>

On 30.05.2016 08:11, Sven Eckelmann wrote:
> The tt_req_node is added and removed from a list inside a spinlock. But the
> locking is sometimes removed even when the object is still referenced and
> will be used later via this reference. For example batadv_send_tt_request
> can create a new tt_req_node (including add to a list) and later
> re-acquires the lock to remove it from the list and to free it. But at this
> time another context could have already removed this tt_req_node from the
> list and freed it.
> 
> CPU#0
> 
>     batadv_batman_skb_recv from net_device 0
>     -> batadv_iv_ogm_receive
>       -> batadv_iv_ogm_process
>         -> batadv_iv_ogm_process_per_outif
>           -> batadv_tvlv_ogm_receive
>             -> batadv_tvlv_ogm_receive
>               -> batadv_tvlv_containers_process
>                 -> batadv_tvlv_call_handler
>                   -> batadv_tt_tvlv_ogm_handler_v1
>                     -> batadv_tt_update_orig
>                       -> batadv_send_tt_request
>                         -> batadv_tt_req_node_new
>                            spin_lock(...)
>                            allocates new tt_req_node and adds it to list
>                            spin_unlock(...)
>                            return tt_req_node
> 
> CPU#1
> 
>     batadv_batman_skb_recv from net_device 1
>     -> batadv_recv_unicast_tvlv
>       -> batadv_tvlv_containers_process
>         -> batadv_tvlv_call_handler
>           -> batadv_tt_tvlv_unicast_handler_v1
>             -> batadv_handle_tt_response
>                spin_lock(...)
>                tt_req_node gets removed from list and is freed
>                spin_unlock(...)
> 
> CPU#0
> 
>                       <- returned to batadv_send_tt_request
>                          spin_lock(...)
>                          tt_req_node gets removed from list and is freed
>                          MEMORY CORRUPTION/SEGFAULT/...
>                          spin_unlock(...)
> 
> This can only be solved via reference counting to allow multiple contexts
> to handle the list manipulation while making sure that only the last
> context holding a reference will free the object.
> 
> Fixes: cea194d90b11 ("batman-adv: improved client announcement mechanism")
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> ---
> v2:
>  - fixed list->object in commit message
>  - add example what could have gone wrong in commit message
> ---
>  net/batman-adv/translation-table.c | 27 +++++++++++++++++++++++----
>  net/batman-adv/types.h             |  2 ++
>  2 files changed, 25 insertions(+), 4 deletions(-)
> 
> diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
> index 48adb91..46f90c5 100644
> --- a/net/batman-adv/translation-table.c
> +++ b/net/batman-adv/translation-table.c
> @@ -2272,6 +2272,19 @@ static u32 batadv_tt_local_crc(struct batadv_priv *bat_priv,
>  	return crc;
>  }
>  
> +/**
> + * batadv_tt_req_node_release - free tt_req node entry
> + * @ref: kref pointer of the tt req_node entry
> + */
> +static void batadv_tt_req_node_release(struct kref *ref)
> +{
> +	struct batadv_tt_req_node *node;
> +
> +	node = container_of(ref, struct batadv_tt_req_node, refcount);
> +
> +	kfree(node);
> +}
> +
>  static void batadv_tt_req_list_free(struct batadv_priv *bat_priv)
>  {
>  	struct batadv_tt_req_node *node;
> @@ -2281,7 +2294,7 @@ static void batadv_tt_req_list_free(struct batadv_priv *bat_priv)
>  
>  	hlist_for_each_entry_safe(node, safe, &bat_priv->tt.req_list, list) {
>  		hlist_del_init(&node->list);
> -		kfree(node);
> +		kref_put(&node->refcount, batadv_tt_req_node_release);
>  	}
>  
>  	spin_unlock_bh(&bat_priv->tt.req_list_lock);
> @@ -2318,7 +2331,7 @@ static void batadv_tt_req_purge(struct batadv_priv *bat_priv)
>  		if (batadv_has_timed_out(node->issued_at,
>  					 BATADV_TT_REQUEST_TIMEOUT)) {
>  			hlist_del_init(&node->list);
> -			kfree(node);
> +			kref_put(&node->refcount, batadv_tt_req_node_release);
>  		}
>  	}
>  	spin_unlock_bh(&bat_priv->tt.req_list_lock);
> @@ -2350,9 +2363,11 @@ batadv_tt_req_node_new(struct batadv_priv *bat_priv,
>  	if (!tt_req_node)
>  		goto unlock;
>  
> +	kref_init(&tt_req_node->refcount);
>  	ether_addr_copy(tt_req_node->addr, orig_node->orig);
>  	tt_req_node->issued_at = jiffies;
>  
> +	kref_get(&tt_req_node->refcount);
>  	hlist_add_head(&tt_req_node->list, &bat_priv->tt.req_list);
>  unlock:
>  	spin_unlock_bh(&bat_priv->tt.req_list_lock);
> @@ -2619,9 +2634,13 @@ out:
>  		spin_lock_bh(&bat_priv->tt.req_list_lock);
>  		/* hlist_del_init() verifies tt_req_node still is in the list */
>  		hlist_del_init(&tt_req_node->list);
> +		kref_put(&tt_req_node->refcount, batadv_tt_req_node_release);
>  		spin_unlock_bh(&bat_priv->tt.req_list_lock);
> -		kfree(tt_req_node);
>  	}
> +
> +	if (tt_req_node)
> +		kref_put(&tt_req_node->refcount, batadv_tt_req_node_release);
> +
>  	kfree(tvlv_tt_data);
>  	return ret;
>  }
> @@ -3057,7 +3076,7 @@ static void batadv_handle_tt_response(struct batadv_priv *bat_priv,
>  		if (!batadv_compare_eth(node->addr, resp_src))
>  			continue;
>  		hlist_del_init(&node->list);
> -		kfree(node);
> +		kref_put(&node->refcount, batadv_tt_req_node_release);
>  	}
>  
>  	spin_unlock_bh(&bat_priv->tt.req_list_lock);
> diff --git a/net/batman-adv/types.h b/net/batman-adv/types.h
> index 1e47fbe..d75beef 100644
> --- a/net/batman-adv/types.h
> +++ b/net/batman-adv/types.h
> @@ -1129,11 +1129,13 @@ struct batadv_tt_change_node {
>   * struct batadv_tt_req_node - data to keep track of the tt requests in flight
>   * @addr: mac address address of the originator this request was sent to
>   * @issued_at: timestamp used for purging stale tt requests
> + * @refcount: number of contexts the object is used by
>   * @list: list node for batadv_priv_tt::req_list
>   */
>  struct batadv_tt_req_node {
>  	u8 addr[ETH_ALEN];
>  	unsigned long issued_at;
> +	struct kref refcount;
>  	struct hlist_node list;
>  };
>  
> 

