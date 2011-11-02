Return-Path: <ordex@autistici.org>
Date: Wed, 2 Nov 2011 11:13:57 +0100
From: Antonio Quartulli <ordex@autistici.org>
Message-ID: <20111102101354.GA5599@ritirata.org>
References: <1320226969-6117-1-git-send-email-siwu@hrz.tu-chemnitz.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1320226969-6117-1-git-send-email-siwu@hrz.tu-chemnitz.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: check return value for
 hash_add()
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
Cc: Simon Wunderlich <siwu@hrz.tu-chemnitz.de>

Hello Simon,

On Wed, Nov 02, 2011 at 10:42:49 +0100, Simon Wunderlich wrote:
> if hash_add() fails, we should remove the structure to avoid memory
> leaks.
> 
> Signed-off-by: Simon Wunderlich <siwu@hrz.tu-chemnitz.de>
> ---
> As this was the last unchecked occurence, this should close bug #136
> in the open-mesh.org redmine bugtracker.
> ---
>  translation-table.c |   22 ++++++++++++++++++----
>  1 files changed, 18 insertions(+), 4 deletions(-)
> 
> @@ -217,16 +218,22 @@ void tt_local_add(struct net_device *soft_iface, const uint8_t *addr,
> -	hash_add(bat_priv->tt_local_hash, compare_tt, choose_orig,
> +	hash_added = hash_add(bat_priv->tt_local_hash, compare_tt, choose_orig,
>  		 &tt_local_entry->common, &tt_local_entry->common.hash_entry);

In my opinion you should indent this invocation a bit better :-P

>  
> +	if (unlikely(!hash_added)) {
> +		/* remove the reference for the hash */
> +		tt_local_entry_free_ref(tt_local_entry);
> +		goto out;
> +	}
> +
> +	tt_local_event(bat_priv, addr, tt_local_entry->common.flags);
> +

Here you are invoking tt_local_event() _after_ setting the TT_CLIENT_NEW. This
means that this flag is going to be copied in the tt_change structure and later
it will be sent out within the next OGM. This has to not happen. Therefore I would
move the or-assignment of the TT_CLIENT_NEW flag _after_ the invocation of
tt_local_event().


>  	/* remove address from global hash if present */
>  	tt_global_entry = tt_global_hash_find(bat_priv, addr);
>  
> @@ -499,6 +506,7 @@ int tt_global_add(struct bat_priv *bat_priv, struct orig_node *orig_node,
>  	struct tt_global_entry *tt_global_entry;
>  	struct orig_node *orig_node_tmp;
>  	int ret = 0;
> +	int hash_added;
>  
>  	tt_global_entry = tt_global_hash_find(bat_priv, tt_addr);
>  
> @@ -518,9 +526,15 @@ int tt_global_add(struct bat_priv *bat_priv, struct orig_node *orig_node,
>  		tt_global_entry->ttvn = ttvn;
>  		tt_global_entry->roam_at = 0;
>  
> -		hash_add(bat_priv->tt_global_hash, compare_tt,
> +		hash_added = hash_add(bat_priv->tt_global_hash, compare_tt,
>  			 choose_orig, &tt_global_entry->common,
>  			 &tt_global_entry->common.hash_entry);
> +
> +		if (unlikely(!hash_added)) {
> +			/* remove the reference for the hash */
> +			tt_global_entry_free_ref(tt_global_entry);
> +			goto out;
> +		}

In this case the global client could be a roaming one....what about invoking
tt_local_remove() first? Otherwise we would still have a local client which is
actually not one of ours..What do you think? Moreover it would free some space


Cheers,

-- 
Antonio Quartulli

..each of us alone is worth nothing..
Ernesto "Che" Guevara
