Return-Path: <linus.luessing@c0d3.blue>
Date: Thu, 6 Oct 2016 17:41:29 +0200
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@c0d3.blue>
Message-ID: <20161006154129.GG19216@otheros>
References: <20160920121245.593-1-linus.luessing@c0d3.blue>
 <20160920121245.593-2-linus.luessing@c0d3.blue>
 <7378987.EkNMrEAytt@sven-edge>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7378987.EkNMrEAytt@sven-edge>
Subject: Re: [B.A.T.M.A.N.] [PATCH 1/3] batman-adv: Store and transmit own
 neighborhood hash
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

On Thu, Sep 29, 2016 at 05:31:27PM +0200, Sven Eckelmann wrote:
> On Dienstag, 20. September 2016 14:12:43 CEST Linus Lüssing wrote:
> [...]
> >  /**
> > + * batadv_hardif_neigh_get_pre - get the predecessor of a neighbor node
> > + * @hard_iface: the interface this neighbour is connected to
> > + * @neigh_addr: address of the neighbour to retrieve the predecessor for
> > + *
> > + * Tries to find the neighbor node which has an address closest to but
> > + * smaller than the neigh_addr provided. In other words, tries to
> > + * find a potential predecessor of a given MAC address.
> > + *
> > + * Return: The alphabetical predecessor of a neighbor node. Returns NULL
> > + * if no such predecessor exists.
> > + */
> > +static struct batadv_hardif_neigh_node *
> > +batadv_hardif_neigh_get_pre(struct batadv_hard_iface *hard_iface,
> > +			    const u8 *neigh_addr)
> > +{
> > +	struct batadv_hardif_neigh_node *tmp_hardif_neigh, *hardif_neigh = NULL;
> > +
> > +	rcu_read_lock();
> > +	hlist_for_each_entry_rcu(tmp_hardif_neigh, &hard_iface->neigh_list,
> > +				 list) {
> > +		if (memcmp(tmp_hardif_neigh->addr, neigh_addr, ETH_ALEN) >= 0)
> > +			break;
> > +
> > +		if (!kref_get_unless_zero(&tmp_hardif_neigh->refcount))
> > +			continue;
> > +
> > +		if (hardif_neigh)
> > +			batadv_hardif_neigh_put(hardif_neigh);
> > +
> > +		hardif_neigh = tmp_hardif_neigh;
> > +	}
> > +	rcu_read_unlock();
> > +
> > +	return hardif_neigh;
> > +}
> > +
> > +/**
> >   * batadv_hardif_neigh_create - create a hardif neighbour node
> >   * @hard_iface: the interface this neighbour is connected to
> >   * @neigh_addr: the interface address of the neighbour to retrieve
> > @@ -522,7 +559,7 @@ batadv_hardif_neigh_create(struct batadv_hard_iface *hard_iface,
> >  			   struct batadv_orig_node *orig_node)
> >  {
> >  	struct batadv_priv *bat_priv = netdev_priv(hard_iface->soft_iface);
> > -	struct batadv_hardif_neigh_node *hardif_neigh = NULL;
> > +	struct batadv_hardif_neigh_node *hardif_neigh = NULL, *pre_neigh;
> >  
> >  	spin_lock_bh(&hard_iface->neigh_list_lock);
> >  
> > @@ -547,7 +584,13 @@ batadv_hardif_neigh_create(struct batadv_hard_iface *hard_iface,
> >  	if (bat_priv->algo_ops->neigh.hardif_init)
> >  		bat_priv->algo_ops->neigh.hardif_init(hardif_neigh);
> >  
> > -	hlist_add_head(&hardif_neigh->list, &hard_iface->neigh_list);
> > +	pre_neigh = batadv_hardif_neigh_get_pre(hard_iface, neigh_addr);
> > +	if (!pre_neigh) {
> > +		hlist_add_head(&hardif_neigh->list, &hard_iface->neigh_list);
> > +	} else {
> > +		hlist_add_behind(&hardif_neigh->list, &pre_neigh->list);
> > +		batadv_hardif_neigh_put(pre_neigh);
> > +	}
> 
> I personally would have liked to see this in a separate patch. But there are
> more important things here.
> 
> First you have to use hlist_add_head_rcu and hlist_add_behind_rcu here because
> the readers use RCU to access the list. I think it would also be more
> appropriate to replace the rcu_read_lock in the batadv_hardif_neigh_get_pre
> function and instead use lockdep to mark the function as "requires
> hard_iface->neigh_list_lock".

PS: In v2, I haven't changed batadv_hardif_neigh_get_pre() to a
non-rcu variant with lockdep. You are right, rcu isn't really
necessary in this context, but I kind of like being able to have a
function on one screen and seeing immediately whether it works or
not, without needing to scroll.

And I liked keeping it similar to batadv_hardif_neigh_get().

Does that make sense?
