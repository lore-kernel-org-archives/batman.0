Return-Path: <linus.luessing@web.de>
Date: Fri, 14 Jun 2013 17:50:41 +0200
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@web.de>
Message-ID: <20130614155041.GD28709@Linus-Debian>
References: <1371200525-2011-1-git-send-email-linus.luessing@web.de>
 <1371200525-2011-4-git-send-email-linus.luessing@web.de>
 <20130614143028.GA26907@pandem0nium>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20130614143028.GA26907@pandem0nium>
Subject: Re: [B.A.T.M.A.N.] [PATCHv5 3/3] batman-adv: Modified forwarding
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

On Fri, Jun 14, 2013 at 04:30:28PM +0200, Simon Wunderlich wrote:
> On Fri, Jun 14, 2013 at 11:02:05AM +0200, Linus Lüssing wrote:
>   
> >  /**
> > + * batadv_tt_orig_entries_count - count the number of originators
> > + * @head: a list of originators
> > + *
> > + * Return the number of originator entries in the given list.
> > + *
> > + * The caller needs to hold the rcu_read_lock().
> > + */
> > +static int batadv_tt_orig_entries_count(struct hlist_head *head)
> > +{
> > +	struct batadv_tt_orig_list_entry *orig_entry;
> > +	int count = 0;
> > +
> > +	hlist_for_each_entry_rcu(orig_entry, head, list) {
> > +		if (!atomic_read(&orig_entry->refcount))
> > +			continue;
> > +
> > +		count++;
> > +	}
> > +
> > +	return count;
> > +}
> > +
> > +/**
> > + * batadv_tt_global_hash_count - count the number of orig entries
> > + * @hash: hash table containing the tt entries
> > + * @addr: the mac address of the client to count entries for
> > + * @vid: VLAN identifier
> > + *
> > + * Return the number of originators advertising the given address/data
> > + * (excluding ourself).
> > + */
> > +int batadv_tt_global_hash_count(struct batadv_priv *bat_priv,
> > +				const uint8_t *addr, unsigned short vid)
> > +{
> > +	struct hlist_head *head, *orig_list;
> > +	struct batadv_tt_common_entry to_search, *tt_common_entry;
> > +	struct batadv_tt_global_entry *tt_global_entry;
> > +	uint32_t index;
> > +	int count = 0;
> > +
> > +	if (!bat_priv->tt.global_hash)
> > +		goto out;
> > +
> > +	memcpy(to_search.addr, addr, ETH_ALEN);
> > +	to_search.vid = vid;
> > +
> > +	index = batadv_choose_tt(&to_search, bat_priv->tt.global_hash->size);
> > +	head = &bat_priv->tt.global_hash->table[index];
> > +
> > +	rcu_read_lock();
> > +	hlist_for_each_entry_rcu(tt_common_entry, head, hash_entry) {
> > +		if (!batadv_compare_eth(tt_common_entry, addr))
> > +			continue;
> > +
> > +		if (!atomic_read(&tt_common_entry->refcount))
> > +			continue;
> > +
> > +		tt_global_entry = container_of(tt_common_entry,
> > +					       struct batadv_tt_global_entry,
> > +					       common);
> > +		orig_list = &tt_global_entry->orig_list;
> > +		count = batadv_tt_orig_entries_count(orig_list);
> > +		break;
> > +	}
> > +	rcu_read_unlock();
> > +
> > +out:
> > +	return count;
> > +}
> > +
> > +/**
> 
> I've been thinking about this part ... it is not good to iterate over the whole
> hash for every multicast packet - this is the fastpath after all, so it's critical.

This is what we do for any packet, it's a simple, fast hash-lookup
(and for the rare case of two entries having the same hash result,
then a small list lookup, too). Pretty much what we are doing with
any batadv_transtable_search(). It's mostly a copy-paste of the
batadv_tt_hash_find().

Except the batadv_tt_orig_entries_count(), that's a list lookup
which we do not have with a common transtable_search(). I had
thought about adding an atomic counter for the orig_list in and to
the struct tt_global_entry (but didn't do it because I wanted to
leave the original translation-table.c functions as untouched as
possible and thought the performance gain wouldn't be that huge).
Hm, but maybe you're right about the performance if we are going
to have a large mesh network with many originators claiming a
certain multicast address. I'm going to add that atomic counter.

> 
> Can't you just use batadv_tt_global_hash_find(), count the list entries within
> struct batadv_tt_global_entry (or find out if it is empty, one entry or more
> than one entry) and be done? This should be much faster.

But looking at that function again now, you're right, because the
lookup in batadv_tt_global_hash_count() is nearly identical now to
batadv_tt_global_hash_find(), I can use that one instead.
(Initially I needed to do such copying of the tt_global_hash_find()
function because of my wrong assumption that there'd be a
tt_global_entry for every originator announcing that address -
but, yeah, now that's even easier :) ).

Will change that :).

> 
> Apart from that, the patch series appears to be pretty mature now, I've done
> some more testing in my VMs and it looks good. Should be (hopefully) the last
> thing from my side. :)

No worries, every comment welcome. And with just 3 instead of ~15
multicast patches it's a lot easier to fix and rebase things now :P.

> 
> Cheers,
> 	Simon

Cheers, Linus
