Return-Path: <linus.luessing@web.de>
Date: Thu, 16 May 2013 20:22:25 +0200
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@web.de>
Message-ID: <20130516182225.GD22374@Linus-Debian>
References: <1368293014-30742-1-git-send-email-linus.luessing@web.de>
 <1368293014-30742-4-git-send-email-linus.luessing@web.de>
 <20130511232929.GF901@ritirata.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20130511232929.GF901@ritirata.org>
Subject: Re: [B.A.T.M.A.N.] [PATCH 3/3] batman-adv: Modified forwarding
 behaviour for multicast packets
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

On Sun, May 12, 2013 at 01:29:29AM +0200, Antonio Quartulli wrote:
> On Sat, May 11, 2013 at 07:23:27PM +0200, Linus Lüssing wrote:
> > With this patch a multicast packet is not always simply flooded anymore,
> > the bevahiour for the following cases is changed to reduce
> > unnecessary overhead:
> > 
> > If all nodes within the horizon of a certain node have signalized
> > multicast listener announcement capability
> > (BATADV_MCAST_LISTENER_ANNOUNCEMENT) then an IPv6 multicast packet
> > with a destination of IPv6 link-local scope coming from the upstream
> > of this node...
> > 
> > * ...is dropped if there is no according multicast listener in the
> >   translation table.
> > * ...is forwarded via unicast if there is a single node with interested
> >   multicast listeners.
> > 
> 
> othwerwise? Does it get flooded like now if there is more than one receiver?

Yes, it will get flooded. Thought it was clear because I was
saying "for the following cases is changed", trying to imply that
for anything else it'll still get flooded. But ok, I can make it
more explicit.

> 
> >  
> >  /**
> > + * batadv_mcast_flood - Checks on how to forward a multicast packet
> > + * @skb: The multicast packet to check
> > + * @bat_priv: the bat priv with all the soft interface information
> > + *
> > + * Returns 1 if the packet should be flooded, 0 if it should be forwarded
> > + * via unicast or -1 if it should be drooped.
> > + */
> > +int batadv_mcast_flood(struct sk_buff *skb, struct batadv_priv *bat_priv)
> > +{
> > +	struct ethhdr *ethhdr = (struct ethhdr *)(skb->data);
> > +	struct ipv6hdr *ip6hdr;
> > +	int count, ret = 1;
> > +
> > +	if (atomic_read(&bat_priv->mcast_group_awareness) &&
> > +	    !atomic_read(&bat_priv->mcast_num_non_aware) &&
> > +	    ntohs(ethhdr->h_proto) == ETH_P_IPV6) {
> 
> mh..this would not work for VLANs..did you plan to introduce support for VLANs
> later? or you simply overlooked it? :)

I guess I overlooked, will try to add that in the same patch, too.

> 
> > +		if (!pskb_may_pull(skb, sizeof(*ethhdr) + sizeof(*ip6hdr))) {
> > +			ret = -1;
> > +			goto out;
> > +		}
> > +
> > +		ip6hdr = ipv6_hdr(skb);
> > +
> > +		/* TODO: Implement Multicast Router Discovery, then add
> > +		 * scope >= IPV6_ADDR_SCOPE_LINKLOCAL, too */
> > +		if (IPV6_ADDR_MC_SCOPE(&ip6hdr->daddr) !=
> > +		    IPV6_ADDR_SCOPE_LINKLOCAL)
> > +			goto out;
> > +
> > +		count = batadv_tt_global_hash_count(bat_priv, ethhdr->h_dest);
> > +
> > +		if (!count)
> > +			ret = -1;
> > +		else if (count == 1)
> > +			ret = 0;
> 
> how can this function return more than one?
> When there is more than one originator announcing the same MAC address then we
> have _a single_ global entry having a list of orig_entry. but stil only one
> global entry.
> 
> so you may want to count the orig_entries rather than the global_entries?

You are right, looks like I only tested dropping vs. unicast, not
unicast vs. flooding behaviour in my VMs.

> 
> > diff --git a/translation-table.c b/translation-table.c
> > index 37e7d47..1d2d618 100644
> > --- a/translation-table.c
> > +++ b/translation-table.c
> > @@ -83,6 +83,40 @@ batadv_tt_hash_find(struct batadv_hashtable *hash, const void *data)
> >  	return tt_common_entry_tmp;
> >  }
> >  
> > +/**
> > + * batadv_tt_hash_count - Counts the number of tt entries for the given data
> > + * @hash: hash table containing the tt entries
> > + * @data: The data to count entries for
> 
> One line saying what you are returning would be nice :)

ok

> 
> > + */
> > +static int batadv_tt_hash_count(struct batadv_hashtable *hash, const void *data)
> > +{
> > +	struct hlist_head *head;
> > +	struct batadv_tt_common_entry *tt_common_entry;
> > +	uint32_t index;
> > +	int count = 0;
> > +
> > +	if (!hash)
> > +		goto out;
> > +
> > +	index = batadv_choose_orig(data, hash->size);
> > +	head = &hash->table[index];
> > +
> > +	rcu_read_lock();
> > +	hlist_for_each_entry_rcu(tt_common_entry, head, hash_entry) {
> > +		if (!batadv_compare_eth(tt_common_entry, data))
> > +			continue;
> > +
> > +		if (!atomic_read(&tt_common_entry->refcount))
> > +			continue;
> > +
> > +		count++;
> > +	}
> > +	rcu_read_unlock();
> > +
> > +out:
> > +	return count;
> > +}
> 
> as I asked before: this function cannot return >1 because the same address is
> never stored twice.
> 
> 
> Nice job so far!
> Thanks for working on this cool feature!
> 
> Cheers,
> 
> -- 
> Antonio Quartulli
> 
> ..each of us alone is worth nothing..
> Ernesto "Che" Guevara

Cheers, Linus
