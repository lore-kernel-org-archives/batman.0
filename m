Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Fri, 16 Aug 2013 17:27:51 +0800
References: <1376376232-2178-1-git-send-email-ordex@autistici.org>
 <201308161146.41467.lindner_marek@yahoo.de>
 <20130816062729.GV849@ritirata.org>
In-Reply-To: <20130816062729.GV849@ritirata.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201308161727.51653.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCHv3 1/9] batman-adv: make struct
	batadv_neigh_node algorithm agnostic
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

On Friday, August 16, 2013 14:27:29 Antonio Quartulli wrote:
> On Fri, Aug 16, 2013 at 11:46:41AM +0800, Marek Lindner wrote:
> > On Tuesday, August 13, 2013 14:43:44 Antonio Quartulli wrote:
> > > @@ -1011,13 +1011,13 @@ batadv_iv_ogm_update_seqnos(const struct ethhdr
> > > *ethhdr, }
> > > 
> > >  		/* if the window moved, set the update flag. */
> > > 
> > > -		need_update |= batadv_bit_get_packet(bat_priv,
> > > -						     tmp_neigh_node->real_bits,
> > > +		bitmap = tmp_neigh_node->bat_iv.real_bits;
> > > +		need_update |= batadv_bit_get_packet(bat_priv, bitmap,
> > > 
> > >  						     seq_diff, set_mark);
> > > 
> > > -		packet_count = bitmap_weight(tmp_neigh_node->real_bits,
> > > +		packet_count = bitmap_weight(tmp_neigh_node->bat_iv.real_bits,
> > > 
> > >  					     BATADV_TQ_LOCAL_WINDOW_SIZE);
> > > 
> > > -		tmp_neigh_node->real_packet_count = packet_count;
> > > +		tmp_neigh_node->bat_iv.real_packet_count = packet_count;
> > > 
> > >  	}
> > 
> > You can't make assumptions about the size of bitmap because it is
> > platform specific which is why the variable declaration is a macro in
> > the first place.
> 
> where do I make such assumption? Variable bitmap is a just storing the
> address of the bitmap.

If it is just the address it probably is ok - you are right.


> > > -	struct batadv_priv *bat_priv = netdev_priv(hard_iface->soft_iface);
> > > 
> > >  	struct batadv_neigh_node *neigh_node;
> > >  	
> > >  	neigh_node = kzalloc(sizeof(*neigh_node), GFP_ATOMIC);
> > >  	if (!neigh_node)
> > >  	
> > >  		goto out;
> > > 
> > > -	INIT_HLIST_NODE(&neigh_node->list);
> > > -
> > > 
> > >  	memcpy(neigh_node->addr, neigh_addr, ETH_ALEN);
> > > 
> > > -	spin_lock_init(&neigh_node->lq_update_lock);
> > > +	neigh_node->if_incoming = hard_iface;
> > > +	neigh_node->orig_node = orig_node;
> > > +
> > > +	spin_lock_bh(&orig_node->neigh_list_lock);
> > > +	hlist_add_head_rcu(&neigh_node->list, &orig_node->neigh_list);
> > > +	spin_unlock_bh(&orig_node->neigh_list_lock);
> > > +
> > > +	INIT_LIST_HEAD(&neigh_node->bonding_list);
> > > 
> > >  	/* extra reference for return */
> > >  	atomic_set(&neigh_node->refcount, 2);
> > > 
> > > -	batadv_dbg(BATADV_DBG_BATMAN, bat_priv,
> > > -		   "Creating new neighbor %pM on interface %s\n", neigh_addr,
> > > -		   hard_iface->net_dev->name);
> > > -
> > > 
> > >  out:
> > >  	return neigh_node;
> > >  
> > >  }
> > 
> > All variables should be initialized before we add the new entry to the
> > any list.
> 
> object is allocated with kzalloc: everything is zero. I thought we use
> kzalloc for this purpose: avoid initialisation of every field..no?

What is "INIT_LIST_HEAD(&neigh_node->bonding_list);" ? Looks like an 
initialization if I am not mistaken. Moreover, batadv_iv_ogm_neigh_new() inits 
even more after this function returns ...

Cheers,
Marek
