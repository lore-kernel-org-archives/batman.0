Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Tue, 5 Nov 2013 14:14:02 +0100
References: <1383141713-15820-1-git-send-email-sw@simonwunderlich.de>
 <1383141713-15820-4-git-send-email-sw@simonwunderlich.de>
 <20131105000342.GU15496@Linus-Debian>
In-Reply-To: <20131105000342.GU15496@Linus-Debian>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <201311051414.02525.sw@simonwunderlich.de>
Subject: Re: [B.A.T.M.A.N.] [PATCHv2 3/8] batman-adv: split out router from
	orig_node
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

Hey Linus,

again, all suggestions not commented are approved. Some comments inline (BTW, 
it would be enough if you just keep the hunk you comment and don't keep the 
whole patchset in the reply).

> > + * @if_incoming: the interface where this packet was receved
> > + * @if_outgoing: the interface for which the packet should be considered
> > + */
> > +static void
> > +batadv_iv_ogm_process_per_outif(const struct sk_buff *skb, int
> > ogm_offset, +				struct batadv_orig_node *orig_node,
> > +				struct batadv_hard_iface *if_incoming,
> > +				struct batadv_hard_iface *if_outgoing)
> > 
> >  {
> >  
> >  	struct batadv_priv *bat_priv = netdev_priv(if_incoming->soft_iface);
> > 
> > -	struct batadv_hard_iface *hard_iface;
> > -	struct batadv_orig_node *orig_neigh_node, *orig_node, *orig_node_tmp;
> > 
> >  	struct batadv_neigh_node *router = NULL, *router_router = NULL;
> > 
> > +	struct batadv_orig_node *orig_neigh_node, *orig_node_tmp;
> > +	struct batadv_orig_ifinfo *orig_ifinfo;
> > 
> >  	struct batadv_neigh_node *orig_neigh_router = NULL;
> >  	struct batadv_neigh_ifinfo *router_ifinfo = NULL;
> > 
> > -	int has_directlink_flag;
> > -	int is_my_addr = 0, is_my_orig = 0, is_my_oldorig = 0;
> > -	int is_bidirect;
> > -	bool is_single_hop_neigh = false;
> > -	bool is_from_best_next_hop = false;
> > -	int sameseq, similar_ttl;
> > +	struct batadv_ogm_packet *ogm_packet;
> > 
> >  	enum batadv_dup_status dup_status;
> > 
> > -	uint32_t if_incoming_seqno;
> > +	bool is_from_best_next_hop = false;
> > +	bool is_single_hop_neigh = false;
> > +	bool sameseq, similar_ttl;
> > +	struct sk_buff *skb_priv;
> > +	struct ethhdr *ethhdr;
> > 
> >  	uint8_t *prev_sender;
> > 
> > +	int is_bidirect;
> > +
> > +	/* create a private copy of the skb, as some functions change tq 
value
> > +	 * and/or flags.
> > +	 */
> > +	skb_priv = skb_copy(skb, GFP_ATOMIC);
> > +	if (!skb_priv)
> > +		return;
> > +
> > +	ethhdr = eth_hdr(skb_priv);
> > +	ogm_packet = (struct batadv_ogm_packet *)(skb_priv->data + 
ogm_offset);
> > +
> > +	dup_status = batadv_iv_ogm_update_seqnos(ethhdr, ogm_packet,
> > +						 if_incoming, if_outgoing);
> 
> To avoid redundant code execution,
> move this if statement to the calling function maybe?
> 

No, this has to be called per outgoing interface.

> > +	if (batadv_compare_eth(ethhdr->h_source, ogm_packet->orig))
> > +		is_single_hop_neigh = true;
> > +
> > +	if (dup_status == BATADV_PROTECTED) {
> > +		batadv_dbg(BATADV_DBG_BATMAN, bat_priv,
> > +			   "Drop packet: packet within seqno protection time 
(sender:
> > %pM)\n", +			   ethhdr->h_source);
> > +		goto out;
> > +	}
> > +
> 
> Move this if statement to the calling function maybe?
> 

... depends on dup_status.

> > +	if (ogm_packet->tq == 0) {
> > +		batadv_dbg(BATADV_DBG_BATMAN, bat_priv,
> > +			   "Drop packet: originator packet with tq equal 0\n");
> > +		goto out;
> > +	}
> > +
> > +	router = batadv_orig_router_get(orig_node, if_outgoing);
> > +	if (router) {
> > +		orig_node_tmp = router->orig_node;
> > +		router_router = batadv_orig_router_get(router->orig_node,
> > +						       if_outgoing);
> > +		router_ifinfo = batadv_neigh_ifinfo_get(router, if_outgoing);
> > +	}
> > +
> > +	if ((router_ifinfo && router_ifinfo->bat_iv.tq_avg != 0) &&
> > +	    (batadv_compare_eth(router->addr, ethhdr->h_source)))
> > +		is_from_best_next_hop = true;
> > +
> > +	prev_sender = ogm_packet->prev_sender;
> > +	/* avoid temporary routing loops */
> > +	if (router && router_router &&
> > +	    (batadv_compare_eth(router->addr, prev_sender)) &&
> > +	    !(batadv_compare_eth(ogm_packet->orig, prev_sender)) &&
> > +	    (batadv_compare_eth(router->addr, router_router->addr))) {
> > +		batadv_dbg(BATADV_DBG_BATMAN, bat_priv,
> > +			   "Drop packet: ignoring all rebroadcast packets that 
may make me
> > loop (sender: %pM)\n", +			   ethhdr->h_source);
> > +		goto out;
> > +	}
> > +
> 
> Move this to ...
> 

Nope, this comes after the duplicate check/filling of the respective bitfields. 
As we can't move the dupstatus changing the order is not a good idea imho.

> > +	/* if sender is a direct neighbor the sender mac equals
> > +	 * originator mac
> > +	 */
> > +	if (is_single_hop_neigh)
> > +		orig_neigh_node = orig_node;
> > +	else
> > +		orig_neigh_node = batadv_iv_ogm_orig_get(bat_priv,
> > +							 ethhdr->h_source);
> > +
> > +	if (!orig_neigh_node)
> > +		goto out;
> > +
> > +	/* Update nc_nodes of the originator */
> > +	batadv_nc_update_nc_node(bat_priv, orig_node, orig_neigh_node,
> > +				 ogm_packet, is_single_hop_neigh);
> 
> ... this to the calling function, maybe?
> 

Not sure here, but I'd rather not fiddle with network coding here.

To summarise here: I wanted to split the ogm_process function between the 
outif-independent part and the outif-dependent part while keeping the order of 
the processing as it was before - to not introduce new bugs here. Therefore I 
prefer to keep the order, even if some checks are done twice after the bitfield 
setting.

> > +
> > +	orig_neigh_router = batadv_orig_router_get(orig_neigh_node,
> > +						   if_outgoing);
> > +
> > +	/* drop packet if sender is not a direct neighbor and if we
> > +	 * don't route towards it
> > +	 */
> > +	if (!is_single_hop_neigh && (!orig_neigh_router)) {
> > +		batadv_dbg(BATADV_DBG_BATMAN, bat_priv,
> > +			   "Drop packet: OGM via unknown neighbor!\n");
> > +		goto out_neigh;
> > +	}
> > +
> > +	is_bidirect = batadv_iv_ogm_calc_tq(orig_node, orig_neigh_node,
> > +					    ogm_packet, if_incoming,
> > +					    if_outgoing);
> > +
> > +	/* update ranking if it is not a duplicate or has the same
> > +	 * seqno and similar ttl as the non-duplicate
> > +	 */
> > +	orig_ifinfo = batadv_orig_ifinfo_new(orig_node, if_outgoing);
> > +	if (!orig_ifinfo)
> > +		goto out_neigh;
> > +
> > +	sameseq = orig_ifinfo->last_real_seqno == ntohl(ogm_packet->seqno);
> > +	similar_ttl = (orig_ifinfo->last_ttl - 3) <= ogm_packet->header.ttl;
> > +	if (is_bidirect && ((dup_status == BATADV_NO_DUP) ||
> > +			    (sameseq && similar_ttl))) {
> > +		batadv_iv_ogm_orig_update(bat_priv, orig_node,
> > +					  orig_ifinfo, ethhdr,
> > +					  ogm_packet, if_incoming,
> > +					  if_outgoing, dup_status);
> > +	}
> > +	batadv_orig_ifinfo_free_ref(orig_ifinfo);
> > +
> > +	/* is single hop (direct) neighbor */
> > +	if (is_single_hop_neigh) {
> > +		if ((ogm_packet->header.ttl <= 2) &&
> > +		    (if_incoming != if_outgoing)) {
> > +			batadv_dbg(BATADV_DBG_BATMAN, bat_priv,
> > +				   "Drop packet: OGM from secondary interface and 
wrong outgoing
> > interface\n"); +			goto out_neigh;
> > +		}
> 
> The check above, is this just an optimization independant of
> this patchset or is it somehow needed for the multi interface
> patchset? Maybe a comment could be added?
> 

Yeah this is required now as the function is called multiple times, I'll add a 
comment.

> > +		/* mark direct link on incoming interface */
> > +		batadv_iv_ogm_forward(orig_node, ethhdr, ogm_packet,
> > +				      is_single_hop_neigh,
> > +				      is_from_best_next_hop, if_incoming);
> 
> Hmm, okay, now we are forwarding OGMs on an interface multiple
> times. Though you are fixing this in "batman-adv: consider
> outgoing interface in OGM sending" I guess, this is still a
> regression here, isn't it?
> 

Well, yes, you are probably right. I'll add a check here to only schedule for 
the default interface and will remove in the next one again. The "consider 
outgoing interface" patch is not trivial so I wanted to keep it seperate.
> > +
> > +		batadv_dbg(BATADV_DBG_BATMAN, bat_priv,
> > +			   "Forwarding packet: rebroadcast neighbor packet with 
direct link
> > flag\n"); +		goto out_neigh;
> > +	}
> > +
> > +	/* multihop originator */
> > +	if (!is_bidirect) {
> > +		batadv_dbg(BATADV_DBG_BATMAN, bat_priv,
> > +			   "Drop packet: not received via bidirectional 
link\n");
> > +		goto out_neigh;
> > +	}
> > +
> > +	if (dup_status == BATADV_NEIGH_DUP) {
> > +		batadv_dbg(BATADV_DBG_BATMAN, bat_priv,
> > +			   "Drop packet: duplicate packet received\n");
> > +		goto out_neigh;
> > +	}
> > +
> > +	batadv_dbg(BATADV_DBG_BATMAN, bat_priv,
> > +		   "Forwarding packet: rebroadcast originator packet\n");
> > +	batadv_iv_ogm_forward(orig_node, ethhdr, ogm_packet,
> > +			      is_single_hop_neigh, is_from_best_next_hop,
> > +			      if_incoming);
> > +
> > +out_neigh:
> > +	if ((orig_neigh_node) && (!is_single_hop_neigh))
> > +		batadv_orig_node_free_ref(orig_neigh_node);
> > +out:
> > +	if (router)
> > +		batadv_neigh_node_free_ref(router);
> > +	if (router_router)
> > +		batadv_neigh_node_free_ref(router_router);
> > +	if (orig_neigh_router)
> > +		batadv_neigh_node_free_ref(orig_neigh_router);
> > +
> > +	kfree_skb(skb_priv);
> > +}
> 
> Although this is mostly just code moved around, maybe it would be
> a good idea to split it into several functions now? Would make it
> easier to debug and find potential regressions introduced by this
> patch later, wouldn't it?
> 
> Maybe batadv_iv_ogm_process() would benefit from some more splits,
> too?

Apart from my personal laziness, the idea was to actually keep the code as 
much as it was as possible to make it easier to compare to the previous one. I 
think doing refactoring now would even complicate the review later.

> > @@ -1382,14 +1580,14 @@ static void batadv_iv_ogm_process(const struct
> > ethhdr *ethhdr,
> > 
> >  		 */
> >  		
> >  		if (has_directlink_flag &&
> >  		
> >  		    batadv_compare_eth(if_incoming->net_dev->dev_addr,
> > 
> > -				       batadv_ogm_packet->orig)) {
> > +				       ogm_packet->orig)) {
> > 
> >  			if_num = if_incoming->if_num;
> >  			offset = if_num * BATADV_NUM_WORDS;
> >  			
> >  			spin_lock_bh(&orig_neigh_node->bat_iv.ogm_cnt_lock);
> >  			word = &(orig_neigh_node->bat_iv.bcast_own[offset]);
> >  			bit_pos = if_incoming_seqno - 2;
> > 
> > -			bit_pos -= ntohl(batadv_ogm_packet->seqno);
> > +			bit_pos -= ntohl(ogm_packet->seqno);
> > 
> >  			batadv_set_bit(word, bit_pos);
> >  			weight = &orig_neigh_node->bat_iv.bcast_own_sum[if_num];
> >  			*weight = bitmap_weight(word,
> > 
> > @@ -1410,144 +1608,34 @@ static void batadv_iv_ogm_process(const struct
> > ethhdr *ethhdr,
> > 
> >  		return;
> >  	
> >  	}
> > 
> > -	if (batadv_ogm_packet->flags & BATADV_NOT_BEST_NEXT_HOP) {
> > +	if (ogm_packet->flags & BATADV_NOT_BEST_NEXT_HOP) {
> > 
> >  		batadv_dbg(BATADV_DBG_BATMAN, bat_priv,
> >  		
> >  			   "Drop packet: ignoring all packets not forwarded from the 
best
> >  			   next hop (sender: %pM)\n", ethhdr->h_source);
> >  		
> >  		return;
> >  	
> >  	}
> > 
> > -	orig_node = batadv_iv_ogm_orig_get(bat_priv, batadv_ogm_packet->orig);
> > +	orig_node = batadv_iv_ogm_orig_get(bat_priv, ogm_packet->orig);
> > 
> >  	if (!orig_node)
> >  	
> >  		return;
> > 
> > -	dup_status = batadv_iv_ogm_update_seqnos(ethhdr, batadv_ogm_packet,
> > -						 if_incoming,
> > -						 BATADV_IF_DEFAULT);
> > +	batadv_tvlv_ogm_receive(bat_priv, ogm_packet, orig_node);
> 
> Hmm, moving the tvlv_ogm processing upwards, in front of all the
> duplicate/protected/etc. checks seems like a notable, functional change.
> Though there don't seem to be any problems with the OGM TVLVs we
> are currently having as far as I can tell, maybe this change could
> be mentioned in the commit message though?

You are right ... I'll better keep it at the original place and just perform 
that for the default outgoing interface.

> > + * batadv_purge_orig_ifinfo - purge ifinfo entries from originator
> > + * @bat_priv: the bat priv with all the soft interface information
> > + * @orig_node: orig node which is to be checked
> > + *
> > + * Returns true if any ifinfo entry was purged, false otherwise.
> > + */
> > +static bool
> > +batadv_purge_orig_ifinfo(struct batadv_priv *bat_priv,
> > +			 struct batadv_orig_node *orig_node)
> > +{
> > +	struct batadv_orig_ifinfo *orig_ifinfo;
> > +	struct batadv_hard_iface *if_outgoing;
> > +	struct hlist_node *node_tmp;
> > +	bool ifinfo_purged = false;
> > +
> > +	spin_lock_bh(&orig_node->neigh_list_lock);
> > +
> > +	/* for all neighbors towards this originator ... */
> > +	hlist_for_each_entry_safe(orig_ifinfo, node_tmp,
> > +				  &orig_node->ifinfo_list, list) {
> > +		if_outgoing = orig_ifinfo->if_outgoing;
> > +		if (!if_outgoing)
> > +			continue;
> > +
> > +		if ((if_outgoing->if_status != BATADV_IF_INACTIVE) &&
> > +		    (if_outgoing->if_status != BATADV_IF_NOT_IN_USE) &&
> > +		    (if_outgoing->if_status != BATADV_IF_TO_BE_REMOVED))
> > +			continue;
> > +
> 
> Hm, if we aren't purging them now, when are we going to do that
> instead? Later we can't because the orig_node and its ifinfo list is
> gone, can we?
> 

The purge function is there to remove obsolete ifinfos of the orig node, just 
as purge_orig_node checks and removes obsolete neighbors and other parts (or 
the whole orig node if it timed out).

I'll update the kerneldoc and will also add kerneldoc to 
batadv_purge_orig_node, this is not very clear.

Thanks,
    Simon
