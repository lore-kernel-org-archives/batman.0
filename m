Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Fri, 30 Aug 2013 12:20:01 +0800
References: <1377723291-3335-1-git-send-email-ordex@autistici.org>
 <1377723291-3335-2-git-send-email-ordex@autistici.org>
In-Reply-To: <1377723291-3335-2-git-send-email-ordex@autistici.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201308301220.01356.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCHv5 1/9] batman-adv: make struct
	batadv_neigh_node algorithm agnostic
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

On Thursday, August 29, 2013 04:54:43 Antonio Quartulli wrote:
> -	INIT_HLIST_NODE(&neigh_node->list);
> -
>  	memcpy(neigh_node->addr, neigh_addr, ETH_ALEN);
> -	spin_lock_init(&neigh_node->lq_update_lock);
> +	neigh_node->if_incoming = hard_iface;
> +	neigh_node->orig_node = orig_node;
> +
> +	spin_lock_bh(&orig_node->neigh_list_lock);
> +	hlist_add_head_rcu(&neigh_node->list, &orig_node->neigh_list);
> +	spin_unlock_bh(&orig_node->neigh_list_lock);
> +
> +	INIT_LIST_HEAD(&neigh_node->bonding_list);
> 
>  	/* extra reference for return */
>  	atomic_set(&neigh_node->refcount, 2);
> 
> -	batadv_dbg(BATADV_DBG_BATMAN, bat_priv,
> -		   "Creating new neighbor %pM on interface %s\n", neigh_addr,
> -		   hard_iface->net_dev->name);
> -

The init problem remains unresolved ?


> @@ -470,8 +472,7 @@ batadv_find_bond_router(struct batadv_orig_node
> *primary_orig, * does not exist as rcu version
>  	 */
>  	list_del_rcu(&primary_orig->bond_list);
> -	list_add_rcu(&primary_orig->bond_list,
> -		     &router->bonding_list);
> +	list_add_rcu(&primary_orig->bond_list, &router->bonding_list);
>  	spin_unlock_bh(&primary_orig->neigh_list_lock);
> 
>  out:

Did you forget to remove this section or did you choose to ignore my previous 
comment ?

Please do not resend your patchset before *all* comments have been addressed 
or list "open issues" in your cover letter.

Cheers,
Marek
