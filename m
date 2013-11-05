Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Tue, 5 Nov 2013 12:16:30 +0100
References: <1383141713-15820-1-git-send-email-sw@simonwunderlich.de>
 <1383141713-15820-3-git-send-email-sw@simonwunderlich.de>
 <20131101055333.GD15496@Linus-Debian>
In-Reply-To: <20131101055333.GD15496@Linus-Debian>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <201311051216.30588.sw@simonwunderlich.de>
Subject: Re: [B.A.T.M.A.N.] [PATCHv2 2/8] batman-adv: split tq information
	in neigh_node struct
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

Thanks for the comments! I applied your proposed changes/fixes and will include 
them in the next patchset, a few comments below:

> > @@ -1171,15 +1232,19 @@ batadv_iv_ogm_update_seqnos(const struct ethhdr
> > *ethhdr,
> > 
> >  	}
> >  	
> >  	rcu_read_lock();
> > 
> > -	hlist_for_each_entry_rcu(tmp_neigh_node,
> > -				 &orig_node->neigh_list, list) {
> > -		neigh_addr = tmp_neigh_node->addr;
> > -		is_dup = batadv_test_bit(tmp_neigh_node->bat_iv.real_bits,
> > +	hlist_for_each_entry_rcu(neigh_node, &orig_node->neigh_list, list) {
> > +		neigh_ifinfo = batadv_neigh_ifinfo_new(neigh_node,
> > +						       if_outgoing);
> 
> hm, not quite sure, but would a batadv_neigh_ifinfo_get() be
> sufficient here?

I don't think so. batadv_iv_ogm_update_seqnos() is called before 
batadv_iv_ogm_orig_update() which is the other function to call _new(). We 
need batadv_iv_ogm_update_seqnos() to call _new to create the ifinfo and put 
the first mark in the bitfield. 

> > +static void batadv_neigh_node_free_rcu(struct rcu_head *rcu)
> > +{
> > +	struct hlist_node *node_tmp;
> > +	struct batadv_neigh_node *neigh_node;
> > +	struct batadv_neigh_ifinfo *neigh_ifinfo;
> > +
> > +	neigh_node = container_of(rcu, struct batadv_neigh_node, rcu);
> > +
> > +	hlist_for_each_entry_safe(neigh_ifinfo, node_tmp,
> > +				  &neigh_node->ifinfo_list, list) {
> > +		batadv_neigh_ifinfo_free_ref_now(neigh_ifinfo);
> > +	}
> 
> two things are missing here: orig_node and if_incoming refcounters
> need to be decreased
> 

This appears to be broken in the current code already:
 * batadv_iv_ogm_neigh_new() calls batadv_neigh_node_new() and increases the 
if_incoming refcount (shouldn't be that in batadv_neigh_node_new() instead?)
 * orig_node does not get its refcounter increased in both functions
 * both functions set hard_iface and orig_node within the neigh_node struct 
(that seems to be redundant)
 * the current code does not free_ref neigh->if_incoming

As we have a cyclic dependency here (neigh_node -> orig_node and vice versa), 
I'm not sure if we add more problems by adding refcounting to the orig_node 
here (when cleaning up, that is).

I'll therefore add the free_ref for if_incoming and keep the orig_node 
refcounting as it is.

> 
> why not simply using a "break" within the if-case here instead of the
> "!best" check and continuing to iterate over the list?
> 

because we could have found a better neighbor then the previous "best", but 
not yet the "best" of the whole list. We need to check the whole list to find 
the best. 

Thanks,
     Simon
