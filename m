Return-Path: <linus.luessing@web.de>
Date: Tue, 4 Feb 2014 03:00:19 +0100
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@web.de>
Message-ID: <20140204020018.GB28274@Linus-Debian>
References: <1390816116-23804-1-git-send-email-linus.luessing@web.de>
 <1390816116-23804-7-git-send-email-linus.luessing@web.de>
 <1410522.xVbSBtgclD@diderot>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1410522.xVbSBtgclD@diderot>
Subject: Re: [B.A.T.M.A.N.] [PATCH 6/6] batman-adv: Send multicast packets
 to nodes with a WANT_ALL flag
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

On Wed, Jan 29, 2014 at 02:53:49PM +0800, Marek Lindner wrote:
> On Monday 27 January 2014 10:48:36 Linus Lüssing wrote:
> >  /**
> > + * batadv_mcast_want_all_count - number of nodes with unspecific mcast
> > interest + * @bat_priv: the bat priv with all the soft interface
> > information + * @ethhdr: ethernet header of a packet
> > + * @want_all_list: pointer to a mcast want list in our bat_priv
> > + *
> > + * Return the number of nodes which want all IPv4 multicast traffic if
> > + * the given ethhdr is from an IPv4 packet or the number of nodes which
> > want + * all IPv6 traffic if it matches an IPv6 packet and set the
> > want_list to the + * according one in our bat_priv. For other frame types
> > leave the want_list + * untouched and return zero.
> > + */
> > +static int batadv_mcast_want_all_count(struct batadv_priv *bat_priv,
> > +				       struct ethhdr *ethhdr,
> > +				       struct hlist_head **want_all_list)
> > +{
> > +	int ret;
> > +
> > +	switch (ntohs(ethhdr->h_proto)) {
> > +	case ETH_P_IP:
> > +		ret = atomic_read(&bat_priv->mcast.num_want_all_ipv4);
> > +		if (ret)
> > +			*want_all_list = &bat_priv->mcast.want_all_ipv4_list;
> > +		break;
> > +	case ETH_P_IPV6:
> > +		ret = atomic_read(&bat_priv->mcast.num_want_all_ipv6);
> > +		if (ret)
> > +			*want_all_list = &bat_priv->mcast.want_all_ipv6_list;
> > +		break;
> > +	default:
> > +		/* we shouldn't be here... */
> > +		ret = 0;
> > +	}
> > +
> > +	return ret;
> > +}
> 
> As far as I can tell the want_all list is returned through 3 different 
> functions to end up in batadv_mcast_want_all_node_get() where the code checks 
> again for IPv4 vs IPv6. Wouldn't be much easier to make a simple IPv4/IPv6 in 
> that function to retrieve the list ? Or better, 
> batadv_mcast_want_all_ipv4_node_get() / batadv_mcast_want_all_ipv6_node_get() 
> get bat_priv passed and use the correct list ? I see no need to pass the list 
> around.

Sure, we could pass something else around instead of the list, for
instance simply ETH_P_IP/ETH_P_IPV6. But we'd need to pass around
at least something to batadv_mcast_want_all_node_get() to make it
possible for that function to decide whether to call the ipv4 or
ipv6 variant.

Or we'd use another approach, see considerations/suggestions at
the bottom.

> 
> 
> >  /**
> > + * batadv_mcast_want_all_ipv4_node_get - get an orig_node with
> > want_all_ipv4 + * @head: list of originators that want all IPv4 multicast
> > traffic + *
> > + * Return the first orig_node from the given want_all_ipv4 list. Increases
> > + * the refcount of the returned orig_node.
> > + */
> > +static struct batadv_orig_node *
> > +batadv_mcast_want_all_ipv4_node_get(struct hlist_head *head)
> > +{
> > +	struct batadv_orig_node *orig_node = NULL;
> > +
> > +	rcu_read_lock();
> > +	hlist_for_each_entry_rcu(orig_node, head,
> > +				 mcast_want_all_ipv4_node) {
> > +		if (atomic_inc_not_zero(&orig_node->refcount))
> > +			break;
> > +	}
> > +	rcu_read_unlock();
> > +
> > +	return orig_node;
> > +}
> > +
> > +/**
> > + * batadv_mcast_want_all_ipv6_node_get - get an orig_node with
> > want_all_ipv6 + * @head: list of originators that want all IPv6 multicast
> > traffic + *
> > + * Return the first orig_node from the given want_all_ipv6 list. Increases
> > + * the refcount of the returned orig_node.
> > + */
> > +static struct batadv_orig_node *
> > +batadv_mcast_want_all_ipv6_node_get(struct hlist_head *head)
> > +{
> > +	struct batadv_orig_node *orig_node = NULL;
> > +
> > +	rcu_read_lock();
> > +	hlist_for_each_entry_rcu(orig_node, head,
> > +				 mcast_want_all_ipv6_node) {
> > +		if (atomic_inc_not_zero(&orig_node->refcount))
> > +			break;
> > +	}
> > +	rcu_read_unlock();
> > +
> > +	return orig_node;
> > +}
> 
> Both functions have the same crucial bug. What will the function return if we 
> have on entry in the list but are unable to increment the refcount ?

Ah - you're right, we should reset *orig_node to NULL in that case
to have the skb dropped. Going to fix that, thanks!

> 
> 
> > +/**
> > + * batadv_mcast_list_add - grab a lock and add a node to a head
> > + * @node: the node to add
> > + * @head: the head to add the node to
> > + * @lock: the lock to grab while adding the node to the head
> > + */
> > +static void batadv_mcast_list_add(struct hlist_node *node,
> > +				  struct hlist_head *head,
> > +				  spinlock_t *lock)
> > +{
> > +	spin_lock_bh(lock);
> > +	hlist_add_head_rcu(node, head);
> > +	spin_unlock_bh(lock);
> > +}
> > +
> > +/**
> > + * batadv_mcast_list_del - grab a lock and delete a node from its list
> > + * @node: the node to delete from its list
> > + * @lock: the lock to grab while deleting the node from its list
> > + */
> > +static void batadv_mcast_list_del(struct hlist_node *node, spinlock_t
> > *lock) +{
> > +	spin_lock_bh(lock);
> > +	hlist_del_rcu(node);
> > +	spin_unlock_bh(lock);
> > +}
> > +
> > +/**
> > + * batadv_mcast_list_update - update the list of a flag
> > + * @flag: the flag we want to update the list for
> > + * @node: a list node of an originator
> > + * @head: the list head the node might be added to
> > + * @lock: the lock that synchronizes list modifications
> > + * @new_flags: the new capability bitset of a node
> > + * @old_flags: the current, to be updated bitset of a node
> > + *
> > + * Update the list of the given node/head with the help of the new flag
> > + * information of an originator to contain the nodes which have the given
> > + * flag set.
> > + */
> > +static void batadv_mcast_list_update(uint8_t flag,
> > +				     struct hlist_node *node,
> > +				     struct hlist_head *head,
> > +				     spinlock_t *lock,
> > +				     uint8_t new_flags, int old_flags)
> > +{
> > +	if (new_flags & flag && !(old_flags & flag))
> > +		batadv_mcast_list_add(node, head, lock);
> > +	else if (!(new_flags & flag) && old_flags & flag)
> > +		batadv_mcast_list_del(node, lock);
> > +}
> 
> Didn't we agree on banishing batadv_mcast_list_update() a while ago ?

I understood we agreed on banishing the counter_update() functions. If you'd
like that one to be removed as well, similar to what we did with
the counters, then okay. But note that this is going to make
batadv_mcast_tvlv_ogm_handler_v1() even longer... (and I was
tought by a great guy and at the university to usually try to keep
functions to fit on a screen).

> 
> 
> > +/**
> > + * batadv_mcast_want_all_node_get - get an orig_node with an mcast want
> > list
> > + * @want_all_list: list of originators that want all IPv4 or IPv6 mcast
> > traffic + * @bat_priv: the bat priv with all the soft interface information
> > + *
> > + * Return the first orig_node from the given want_all list. Increases the
> > + * refcount of the returned orig_node.
> > + */
> > +struct batadv_orig_node *
> > +batadv_mcast_want_all_node_get(struct hlist_head *want_all_list,
> > +                              struct batadv_priv *bat_priv)
> > +{
> > +       if (want_all_list == &bat_priv->mcast.want_all_ipv4_list)
> > +               return batadv_mcast_want_all_ipv4_node_get(want_all_list);
> > +       else if (want_all_list == &bat_priv->mcast.want_all_ipv6_list)
> > +               return batadv_mcast_want_all_ipv6_node_get(want_all_list);
> > +       else
> > +               return NULL;
> > +}
> 
> In case there is a good reason to keep this function: bat_priv should be the 
> first argument.

Oki doki.

> 
> 
> > +/**
> > + * batadv_send_skb_via_mcast - send an skb to a node with a WANT_ALL flag
> > + * @bat_priv: the bat priv with all the soft interface information
> > + * @skb: payload to send
> > + * @vid: the vid to be used to search the translation table
> > + * @want_all_list: a list of originators with a WANT_ALL flag
> > + *
> > + * Get an originator node from the want_all_list. Wrap the given skb into a
> > + * batman-adv unicast header and send this frame to this node.
> > + */
> > +int batadv_send_skb_via_mcast(struct batadv_priv *bat_priv,
> > +			      struct sk_buff *skb, unsigned short vid,
> > +			      struct hlist_head *want_all_list)
> > +
> > +{
> > +	struct batadv_orig_node *orig_node;
> > +
> > +	orig_node = batadv_mcast_want_all_node_get(want_all_list, bat_priv);
> > +	return batadv_send_skb_unicast(bat_priv, skb, BATADV_UNICAST, 0,
> > +				       orig_node, vid);
> > +}
> 
> Maybe I am missing the whole point of WANT_ALL but why do we maintain a list 
> of WANT_ALL nodes to only send the packet to the first valid entry in the list?

Hm, the thing is, there can be multiple nodes with that flag. But
most of the time we only end up in this function when there's just
a single node in this list. (when there's more than one, we'd
usually end up in the broadcast instead of unicasting path)

We could remove the list entirely but then we'd have to loop over
all orig_nodes and check their mcast_flags for every packet -
which is too costly on the fast path.

We could replace these two lists by two variables holding a single
originator address or orig_node each. But then we'd still have to
loop over all originators when the numbers of nodes with such a
flag decreases to one to find this one node to update the variable
with.


But yes, this pointer pointer to a list head is not really nice
either... what do you think about returning a pointer pointer to
an orig_node with batadv_mcast_want_all_count() already, instead?
That way we'd spare checking the IP address family twice, too. Or
the list-to-orig_node-variable substitution approach?

Cheers, Linus
