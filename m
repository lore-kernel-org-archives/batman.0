Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Sat, 30 Jun 2012 11:55:25 +0200
References: <1340785387-3821-1-git-send-email-ordex@autistici.org>
	<1340785387-3821-2-git-send-email-ordex@autistici.org>
In-Reply-To: <1340785387-3821-2-git-send-email-ordex@autistici.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201206301155.25761.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCHv2 1/4] batman-adv: add reference counting
	for type batadv_tt_orig_list_entry
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

On Wednesday, June 27, 2012 10:23:04 Antonio Quartulli wrote:
> @@ -639,12 +641,17 @@ batadv_tt_global_entry_has_orig(const struct
> batadv_tt_global_entry *entry, rcu_read_lock();
>  	head = &entry->orig_list;
>  	hlist_for_each_entry_rcu(tmp_orig_entry, node, head, list) {
> -		if (tmp_orig_entry->orig_node == orig_node) {
> -			found = true;
> -			break;
> -		}
> +		if (tmp_orig_entry->orig_node != orig_node)
> +			continue;
> +		if (!atomic_inc_not_zero(&tmp_orig_entry->refcount))
> +			continue;
> +
> +		found = true;
> +		batadv_tt_orig_list_entry_free_ref(tmp_orig_entry);

Instead of having this weird increment and immediate decrement this patch 
should add a general "orig_entry_get" / "orig_entry_find" function like we do 
everywhere else. Check the following functions to get an idea:
 * batadv_primary_if_get_selected()
 * batadv_orig_node_get_router()
 * batadv_tt_hash_find()


> @@ -663,6 +670,7 @@ batadv_tt_global_add_orig_entry(struct
> batadv_tt_global_entry *tt_global_entry, atomic_inc(&orig_node->tt_size);
>  	orig_entry->orig_node = orig_node;
>  	orig_entry->ttvn = ttvn;
> +	atomic_set(&orig_entry->refcount, 0);

This looks extremely broken. We init with 0, never increase the counter and 
when we should free, we decrease first before checking if it is 0 ?

Cheers,
Marek
