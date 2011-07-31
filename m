Return-Path: <ordex@autistici.org>
Date: Sun, 31 Jul 2011 23:53:19 +0200
From: Antonio Quartulli <ordex@autistici.org>
Message-ID: <20110731215318.GA25702@ritirata.org.org>
References: <1310255457-26009-1-git-send-email-ordex@autistici.org>
	<201107232317.23438.lindner_marek@yahoo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <201107232317.23438.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: handle hash_add() return
 value in the TT code
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

On Sat, Jul 23, 2011 at 11:17:22 +0200, Marek Lindner wrote:
> On Sunday, July 10, 2011 01:50:57 Antonio Quartulli wrote:
> > @@ -220,8 +221,14 @@ void tt_local_add(struct net_device *soft_iface, const
> > uint8_t *addr) * (consistency check) */
> >  	tt_local_entry->flags |= TT_CLIENT_NEW;
> > 
> > -	hash_add(bat_priv->tt_local_hash, compare_ltt, choose_orig,
> > -		 tt_local_entry, &tt_local_entry->hash_entry);
> > +	hash_added = hash_add(bat_priv->tt_local_hash, compare_ltt,
> > +			      choose_orig, tt_local_entry,
> > +			      &tt_local_entry->hash_entry);
> > +	if (hash_added != 0)
> > +		tt_local_entry_free_ref(tt_local_entry);
> > +
> > +	if (hash_added < 0)
> > +		goto out;
> 
> No matter whether we add a new element to the tt hash or not we always 
> generate a log message and throw a tt_local_event(). Is that what we want ?

What about going to 'out' in case of hash_added != 0? In both cases (<0 or >0) 
we cannot go ahead with the function as the entry has already been added or it
is not possible to add it.

> 
> 
> > @@ -519,10 +527,17 @@ int tt_global_add(struct bat_priv *bat_priv, struct
> > orig_node *orig_node, tt_global_entry->roam_at = 0;
> >  		atomic_set(&tt_global_entry->refcount, 2);
> > 
> > -		hash_add(bat_priv->tt_global_hash, compare_gtt,
> > -			 choose_orig, tt_global_entry,
> > -			 &tt_global_entry->hash_entry);
> > -		atomic_inc(&orig_node->tt_size);
> > +		hash_added = hash_add(bat_priv->tt_global_hash, compare_gtt,
> > +				      choose_orig, tt_global_entry,
> > +				      &tt_global_entry->hash_entry);
> > +		if (hash_added != 0)
> > +			tt_global_entry_free_ref(tt_global_entry);
> > +
> > +		if (hash_added < 0)
> > +			goto out;
> > +
> > +		if (!hash_added)
> > +			atomic_inc(&orig_node->tt_size);
> 
> Here we only generate a log message when the element has been added or already 
> exists. Do we want that too ?
> 

The same as before.

Cheers,
Antonio
