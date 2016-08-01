Return-Path: <linus.luessing@c0d3.blue>
Date: Mon, 1 Aug 2016 22:49:31 +0200
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@c0d3.blue>
Message-ID: <20160801204931.GA9200@otheros>
References: <1469187482-29894-1-git-send-email-linus.luessing@c0d3.blue>
 <1469187482-29894-2-git-send-email-linus.luessing@c0d3.blue>
 <2274431.CFHQGBLaok@sven-edge>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2274431.CFHQGBLaok@sven-edge>
Subject: Re: [B.A.T.M.A.N.] [PATCH 2/2] batman-adv: Simple (re)broadcast
 avoidance
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

On Fri, Jul 22, 2016 at 03:12:57PM +0200, Sven Eckelmann wrote:
> > @@ -517,7 +518,8 @@ batadv_neigh_node_get(const struct batadv_orig_node *orig_node,
> >   */
> >  static struct batadv_hardif_neigh_node *
> >  batadv_hardif_neigh_create(struct batadv_hard_iface *hard_iface,
> > -			   const u8 *neigh_addr)
> > +			   const u8 *neigh_addr,
> > +			   struct batadv_orig_node *orig_node)
> >  {
> >  	struct batadv_priv *bat_priv = netdev_priv(hard_iface->soft_iface);
> >  	struct batadv_hardif_neigh_node *hardif_neigh = NULL;
> > @@ -534,10 +536,12 @@ batadv_hardif_neigh_create(struct batadv_hard_iface *hard_iface,
> >  		goto out;
> >  
> >  	kref_get(&hard_iface->refcount);
> > +	kref_get(&orig_node->refcount);
> >  	INIT_HLIST_NODE(&hardif_neigh->list);
> >  	ether_addr_copy(hardif_neigh->addr, neigh_addr);
> >  	hardif_neigh->if_incoming = hard_iface;
> >  	hardif_neigh->last_seen = jiffies;
> > +	hardif_neigh->orig_node = orig_node;
> 
> Can you please move the kref_get near the place where new reference is used?

Added this suggestion too, although it seems that there is quite
a mixed style at the moment. Most of these allocation functions seem to first
increase refcounts in one block and then do the assignment parts afterwards.

There are a few exceptions though which follow the style you are
suggesting :). (which might be easier to spot refcounting bugs and
therefore nicer, indeed - although the other style might be more
esthetically pleasing as it visually has better alignment prefix
wise, but not sure how much that matters :) )
