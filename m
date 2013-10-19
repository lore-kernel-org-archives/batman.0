Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Sat, 19 Oct 2013 16:53:46 +0200
References: <1381323938-26931-1-git-send-email-siwu@hrz.tu-chemnitz.de>
 <1381323938-26931-3-git-send-email-siwu@hrz.tu-chemnitz.de>
 <1480017.xk7ZtmFkYa@diderot>
In-Reply-To: <1480017.xk7ZtmFkYa@diderot>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <201310191653.46297.sw@simonwunderlich.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH 2/7] batman-adv: split tq information in
	neigh_node struct
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
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Marek Lindner <mareklindner@neomailbox.ch>

Thanks for the review!

> On Wednesday 09 October 2013 15:05:33 Simon Wunderlich wrote:
> > @@ -1223,6 +1286,7 @@ static void batadv_iv_ogm_process(const struct
> > ethhdr *ethhdr, struct batadv_orig_node *orig_neigh_node, *orig_node,
> > *orig_node_tmp; struct batadv_neigh_node *router = NULL, *router_router =
> > NULL;
> > 
> >  	struct batadv_neigh_node *orig_neigh_router = NULL;
> > 
> > +	struct batadv_neigh_node_ifinfo *router_ifinfo = NULL;
> > 
> >  	int has_directlink_flag;
> >  	int is_my_addr = 0, is_my_orig = 0, is_my_oldorig = 0;
> >  	int is_bidirect;
> > 
> > @@ -1355,7 +1419,7 @@ static void batadv_iv_ogm_process(const struct
> > ethhdr *ethhdr, return;
> > 
> >  	dup_status = batadv_iv_ogm_update_seqnos(ethhdr, batadv_ogm_packet,
> > 
> > -						 if_incoming);
> > +						 if_incoming, NULL);
> 
> Does it even make sense to call batadv_iv_ogm_update_seqnos() with
> outgoing_if always set to NULL ? The way you changed
> batadv_iv_ogm_update_seqnos() makes me wonder. 

NULL is a "valid" outgoing interface - it represents the default outgoing 
interface, if no outgoing interface is selected. This is used for the local 
table and other occurences. Since at this point of the patchset we don't 
consider the outgoing interfaces yet, it makes sense to use the default NULL.

> If
> batadv_neigh_node_get_ifinfo() returns NULL if outgoing_if is NULL (as the
> current kernel doc states) the function does not do any duplicate check -
> the call is useless. 

Where do you read that in the kerneldoc? Let me quote again:

> + * batadv_neigh_node_get_ifinfo - gets the ifinfo from an neigh_node
> + * @neigh_node: the neigh node to be queried
> + * @if_outgoing: the interface for which the ifinfo should be acquired
> + *
> + * Note: this function must be called under rcu lock
> + *
> + * Returns the requested neigh_node_ifinfo or NULL if not found

The documentation does not say that it will return NULL if the outgoing 
interface was NULL. It says that it will return if the ifinfo wasn't found.

As I said, NULL is a valid outgoing interface in this patchset.

Maybe we should use another define for that, something like

#define BATADV_MULTIIF_DEFAULT  NULL

> If we expect batadv_neigh_node_get_ifinfo() to always
> return something we still haven't linked the OGM count to any specific
> outgoing interface. In case we want that why calling
> batadv_iv_ogm_update_seqnos() with an outgoing_if at all. What am I missing
> ? 

The OGM is linked to the interface "NULL" and is checked against that.

> Has this code been tested ?

Yes, I've tested various scenarioes in my VMs. If you test it you could see 
how the different OGM tables behave, too ...

> 
> > @@ -285,10 +301,13 @@ out:
> >  void batadv_gw_check_election(struct batadv_priv *bat_priv,
> >  
> >  			      struct batadv_orig_node *orig_node)
> >  
> >  {
> > 
> > +	struct batadv_neigh_node_ifinfo *router_orig_tq = NULL;
> > +	struct batadv_neigh_node_ifinfo *router_gw_tq = NULL;
> > 
> >  	struct batadv_orig_node *curr_gw_orig;
> >  	struct batadv_neigh_node *router_gw = NULL, *router_orig = NULL;
> >  	uint8_t gw_tq_avg, orig_tq_avg;
> > 
> > +	rcu_read_lock();
> > 
> >  	curr_gw_orig = batadv_gw_get_selected_orig(bat_priv);
> >  	if (!curr_gw_orig)
> >  	
> >  		goto deselect;
> > 
> > @@ -297,6 +316,10 @@ void batadv_gw_check_election(struct batadv_priv
> > *bat_priv, if (!router_gw)
> > 
> >  		goto deselect;
> > 
> > +	router_gw_tq = batadv_neigh_node_get_ifinfo(router_gw, NULL);
> > +	if (!router_gw_tq)
> > +		goto deselect;
> > +
> > 
> >  	/* this node already is the gateway */
> >  	if (curr_gw_orig == orig_node)
> >  	
> >  		goto out;
> > 
> > @@ -305,8 +328,15 @@ void batadv_gw_check_election(struct batadv_priv
> > *bat_priv, if (!router_orig)
> > 
> >  		goto out;
> > 
> > -	gw_tq_avg = router_gw->bat_iv.tq_avg;
> > -	orig_tq_avg = router_orig->bat_iv.tq_avg;
> > +	router_orig_tq = batadv_neigh_node_get_ifinfo(router_orig, NULL);
> > +	if (!router_orig_tq) {
> > +		batadv_gw_deselect(bat_priv);
> > +		goto out;
> > +	}
> 
> What hinders you to jump to the deselect goto here too ?

Good point, will do.
> 
> >  /**
> > 
> > + * batadv_neigh_node_get_ifinfo - gets the ifinfo from an neigh_node
> > + * @neigh_node: the neigh node to be queried
> > + * @if_outgoing: the interface for which the ifinfo should be acquired
> > + *
> > + * Note: this function must be called under rcu lock
> > + *
> > + * Returns the requested neigh_node_ifinfo or NULL if not found
> > + */
> > +struct batadv_neigh_node_ifinfo *
> > +batadv_neigh_node_get_ifinfo(struct batadv_neigh_node *neigh,
> > +			     struct batadv_hard_iface *if_outgoing)
> > +{
> > +	struct batadv_neigh_node_ifinfo *neigh_ifinfo = NULL,
> > +					*tmp_neigh_ifinfo;
> > +
> > +	rcu_read_lock();
> > +	hlist_for_each_entry_rcu(tmp_neigh_ifinfo, &neigh->ifinfo_list,
> > +				 list) {
> > +		if (tmp_neigh_ifinfo->if_outgoing != if_outgoing)
> > +			continue;
> > +
> > +		neigh_ifinfo = tmp_neigh_ifinfo;
> > +	}
> > +	if (neigh_ifinfo)
> > +		goto out;
> > +
> > +	neigh_ifinfo = kzalloc(sizeof(*neigh_ifinfo), GFP_ATOMIC);
> > +	if (!neigh_ifinfo)
> > +		goto out;
> > +
> > +	if (if_outgoing && !atomic_inc_not_zero(&if_outgoing->refcount)) {
> > +		kfree(neigh_ifinfo);
> > +		neigh_ifinfo = NULL;
> > +		goto out;
> > +	}
> > +
> > +	INIT_HLIST_NODE(&neigh_ifinfo->list);
> > +	neigh_ifinfo->if_outgoing = if_outgoing;
> > +
> > +	spin_lock_bh(&neigh->ifinfo_lock);
> > +	hlist_add_head_rcu(&neigh_ifinfo->list, &neigh->ifinfo_list);
> > +	spin_unlock_bh(&neigh->ifinfo_lock);
> > +out:
> > +	rcu_read_unlock();
> > +
> > +	return neigh_ifinfo;
> > +}
> 
> There seems to be no immediate need for the caller to hold rcu_lock as
> stated in the kernel doc. Is it an older documentation fragment that
> should be removed ?

Yup, thanks.

> 
> Furthermore, 'returning NULL if not found' does not seem to be implemented.
> This is all the more interesting since you have implemented function calls
> that do seem to expect the 'NULL if not found' behavior. For instance,
> batadv_gw_get_best_gw_node(), batadv_gw_check_election(), etc. Even
> implictely, through batadv_iv_ogm_neigh_cmp().
> Please carefully re-check your code.

Hmm ... yeah, you are right. it actually only returns NULL if there was an 
error allocating the missing ifinfo. As far as I've checked quickly, this 
should not make a difference as these functions don't "depend" on that 
behaviour but merely do a safety check. Anyway, I'll review it one more time 
and definitely change the documentation. If there is a function which requires 
that behaviour we could still add a "neigh_node_find_info()" which does not 
allocate ...

> 
> > +/* struct batadv_neigh_node_ifinfo - neighbor information per outgoing
> > interface + *	for BATMAN IV
> > 
> >   * @tq_recv: ring buffer of received TQ values from this neigh node
> >   * @tq_index: ring buffer index
> >   * @tq_avg: averaged tq of all tq values in the ring buffer (tq_recv)
> >   * @real_bits: bitfield containing the number of OGMs received from this
> > 
> > neigh - *  node (relative to orig_node->last_real_seqno)
> > - * @real_packet_count: counted result of real_bits
> > - * @lq_update_lock: lock protecting tq_recv & tq_index
> > 
> >   */
> > 
> > -struct batadv_neigh_bat_iv {
> > +struct batadv_neigh_ifinfo_bat_iv {
> > 
> >  	uint8_t tq_recv[BATADV_TQ_GLOBAL_WINDOW_SIZE];
> >  	uint8_t tq_index;
> >  	uint8_t tq_avg;
> >  	DECLARE_BITMAP(real_bits, BATADV_TQ_LOCAL_WINDOW_SIZE);
> >  	uint8_t real_packet_count;
> > 
> > -	spinlock_t lq_update_lock; /* protects tq_recv & tq_index */
> > 
> >  };
> 
> Documentation longer than one line should be indented by one char not 8
> (second line).

OK

> Half of the documentation of real_bits is removed as well as
> @real_packet_count though it still is defined in the struct ?
Whoops, yep, that's wrong, thanks!

Cheers,
    Simon
