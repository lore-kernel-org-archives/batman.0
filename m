Return-Path: <linus.luessing@web.de>
MIME-Version: 1.0
Message-ID: <trinity-654eb65a-c1c3-48f5-9a73-23614f415e71-1366225529049@3capp-webde-bs26>
From: =?UTF-8?Q?=22Linus_L=C3=BCssing=22?= <linus.luessing@web.de>
Content-Type: text/plain; charset=UTF-8
Date: Wed, 17 Apr 2013 21:05:29 +0200 (CEST)
In-Reply-To: <1366109189-17384-1-git-send-email-ordex@autistici.org>
References: <1366109189-17384-1-git-send-email-ordex@autistici.org>
Subject: Re: [B.A.T.M.A.N.] [PATCHv2 1/2] batman-adv: avoid race conditions
 on TT global table by counting references
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
To: Antonio Quartulli <ordex@autistici.org>
Cc: b.a.t.m.a.n@lists.open-mesh.org, Marek Lindner <lindner_marek@yahoo.de>, Simon Wunderlich <siwu@hrz.tu-chemnitz.de>

Hi Antonio,

Looks good, I like the idea of using refcounting for the tt global hash. That will indeed nicely remove the ordering dependancy I introduced with my patch earlier.

> @@ -844,7 +897,17 @@ int batadv_tt_global_add(struct batadv_priv *bat_priv,
>  
>  		if (unlikely(hash_added != 0)) {
>  			/* remove the reference for the hash */
> -			batadv_tt_global_entry_free_ref(tt_global_entry);
> +			batadv_tt_global_entry_free_ref(bat_priv,
> +							tt_global_entry);
> +			goto out_remove;
> +		}
> +
> +		/* increase the refcounter for this new "reference to the global
> +		 * table represented by the global entry. If the increment
> +		 * fails remove the entry from the hash
> +		 */
> +		if (!atomic_inc_not_zero(&bat_priv->tt.global_refcount)) {
> +			hlist_del_rcu(&tt_global_entry->common.hash_entry);
>  			goto out_remove;
>  		}

Looks like there's a spin-lock missing, we usually need to do the rcu-list-adds/dels within such a lock.

Also the ordering looks a little different compared to what we usually do. Usually we increase all the refcounting first and add things to the lists in the end. Changing the order should remove the need for an hlist_del_rcu/spin-lock in the first place.

Cheers, Linus
