Return-Path: <linus.luessing@web.de>
Date: Thu, 10 Feb 2011 13:45:44 +0100
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@web.de>
Message-ID: <20110210124544.GC13038@Sellars>
References: <201102031802.52134.lindner_marek@yahoo.de>
	<1296832896-30081-3-git-send-email-linus.luessing@ascom.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1296832896-30081-3-git-send-email-linus.luessing@ascom.ch>
Sender: linus.luessing@web.de
Subject: Re: [B.A.T.M.A.N.] [PATCH 2/7] batman-adv: Correct rcu refcounting
 for softif_neigh
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

On Fri, Feb 04, 2011 at 04:21:31PM +0100, Linus Lüssing wrote:
> @@ -143,8 +140,11 @@ static struct softif_neigh *softif_neigh_get(struct bat_priv *bat_priv,
>  		if (softif_neigh->vid != vid)
>  			continue;
>  
> +		if (!atomic_inc_not_zero(&softif_neigh->refcount))
> +			continue;
> +
>  		softif_neigh->last_seen = jiffies;
> -		goto found;
> +		goto out;
>  	}
Hmm, we could do a rcu_read_unlock() here, already, I think. Would
it be better to do so, keeping the rcu grace period as small as
possible?
>  
>  	softif_neigh = kzalloc(sizeof(struct softif_neigh), GFP_ATOMIC);
> @@ -154,15 +154,14 @@ static struct softif_neigh *softif_neigh_get(struct bat_priv *bat_priv,
>  	memcpy(softif_neigh->addr, addr, ETH_ALEN);
>  	softif_neigh->vid = vid;
>  	softif_neigh->last_seen = jiffies;
> -	kref_init(&softif_neigh->refcount);
> +	/* initialize with 2 - caller decrements counter by one */
> +	atomic_set(&softif_neigh->refcount, 2);
>  
>  	INIT_HLIST_NODE(&softif_neigh->list);
>  	spin_lock_bh(&bat_priv->softif_neigh_lock);
>  	hlist_add_head_rcu(&softif_neigh->list, &bat_priv->softif_neigh_list);
>  	spin_unlock_bh(&bat_priv->softif_neigh_lock);
>  
> -found:
> -	kref_get(&softif_neigh->refcount);
>  out:
>  	rcu_read_unlock();
>  	return softif_neigh;

The rest of the new atomic handling seems fine. Just two more
things I noticed while reading the softif_neigh specific code:
bat_priv->softif_neigh needs to be changed to a rcu-protected
pointer.

There's a race condition in softif_neigh_seq_print_text(), between
the rcu_read_unlock() and rcu_read_lock() the number of
softif_neigh's can have increased and there's no check for
accidentally writing outside of the allocated buffer.

Cheers, Linus
