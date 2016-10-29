Return-Path: <linus.luessing@c0d3.blue>
Date: Sat, 29 Oct 2016 04:46:46 +0200
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@c0d3.blue>
Message-ID: <20161029024646.GE7448@otheros>
References: <20161005234308.29871-1-linus.luessing@c0d3.blue>
 <20161005234308.29871-2-linus.luessing@c0d3.blue>
 <2315506.rV8PSJo6DZ@bentobox>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2315506.rV8PSJo6DZ@bentobox>
Subject: Re: [B.A.T.M.A.N.] [PATCH v3 1/2] batman-adv: fix race conditions
 on interface removal
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

On Fri, Oct 21, 2016 at 02:30:10PM +0200, Sven Eckelmann wrote:
> On Donnerstag, 6. Oktober 2016 01:43:07 CEST Linus Lüssing wrote:
> > The most prominent general protection fault I was experiencing when
> > quickly removing and adding interfaces to batman-adv is the following:
> 
> I am personally not sure whether go through net.git or through net-next.git.
> If you think it should go through net-next then maybe it would be good to
> state quite early in the commit message that mdelay(...) is required to cause
> the problem?

mdelay()s are not required, but it happens very rarelly in
general use cases.

I'll try to clarify that better in the next version, thanks!

> > ...
> > [ 1137.451885] ---[ end trace 803b9bdc6a4a952b ]---
> > [ 1137.453154] Kernel panic - not syncing: Fatal exception in interrupt
> > [ 1137.457143] Kernel Offset: disabled
> > [ 1137.457143] ---[ end Kernel panic - not syncing: Fatal exception in interrupt
> > ~~~~~~
> 
> Can we reduce the length of some lines here? Especially the modules line
> (which is not really interesting - I hope) to something like "Modules linked
> in: batman-adv(O-) <...>". Also please remove the "[ 1137.457143] " and just
> use 2/4 spaces in front of the snippet.

Oki doki.

> [...]
> Yes, this is bogus and a deficit of checkpatch.pl. But since we run checkpatch
> each day and I don't want to find a way to fix it in checkpatch.pl - maybe you
> can shorten it in send.h?
> 
>     bool batadv_forw_packet_steal(struct batadv_forw_packet *packet, spinlock_t *l);

K, will do.

> 
> [...]
> > +bool batadv_forw_packet_steal(struct batadv_forw_packet *forw_packet,
> > +			      spinlock_t *lock)
> > +{
> > +	struct hlist_head head = HLIST_HEAD_INIT;
> > +
> > +	/* did purging routine steal it earlier? */
> > +	spin_lock_bh(lock);
> > +	if (batadv_forw_packet_was_stolen(forw_packet)) {
> > +		spin_unlock_bh(lock);
> > +		return false;
> > +	}
> > +
> > +	hlist_del(&forw_packet->list);
> > +
> > +	/* Just to spot misuse of this function */
> > +	hlist_add_head(&forw_packet->bm_list, &head);
> > +	hlist_add_fake(&forw_packet->bm_list);
> 
> Sorry, I don't get how this should spot misuse via this extra hlist_add_head.
> You first add the packet to the list (on the stack) and then setting pprev
> pointer to itself. So you basically have a fake hashed node with next pointer
> set to NULL. Wouldn't it be better here to use INIT_HLIST_NODE instead of
> hlist_add_head? I would even say that INIT_HLIST_NODE isn't needed here
> because you already did this during batadv_forw_packet_alloc.
> 
> But I would assume that you actually only wanted hlist_add_fake for the
> WARN_ONCE in batadv_forw_packet_queue, right?

Right :). I'm only using the _fake() variant for this WARN_ONCE.
(So I'll leave that as is? Or too confusing? Do you want me to
reword / clarify something better in the code?)

> 
> [...]
> > +/**
> > + * batadv_forw_packet_queue - try to queue a forwarding packet
> > + * @forw_packet: the forwarding packet to queue
> > + * @lock: a key to the store (e.g. forw_{bat,bcast}_list_lock)
> > + * @head: the shelve to queue it on (e.g. forw_{bat,bcast}_list)
> > + * @send_time: timestamp (jiffies) when the packet is to be sent
> > + *
> > + * This function tries to (re)queue a forwarding packet. If packet was stolen
> > + * earlier then the shop owner will (usually) keep quiet about it.
> 
> Can "shop owner" please replaced with some relevant information for
> batman-adv?
> 
> > + *
> > + * Caller needs to ensure that forw_packet->delayed_work was initialized.
> > + */
> > +static void batadv_forw_packet_queue(struct batadv_forw_packet *forw_packet,
> > +				     spinlock_t *lock, struct hlist_head *head,
> > +				     unsigned long send_time)
> > +{
> > +	spin_lock_bh(lock);
> > +
> > +	/* did purging routine steal it from us? */
> > +	if (batadv_forw_packet_was_stolen(forw_packet)) {
> > +		/* If you got it for free() without trouble, then
> > +		 * don't get back into the queue after stealing...
> > +		 */
> > +		WARN_ONCE(hlist_fake(&forw_packet->bm_list),
> > +			  "Oh oh... the kernel OOPs are on our tail now... Jim won't bail us out this time!\n");
> 
> Can this be replaced with a less funny but more helpful message?

"Why - so - serious?"
...
but ok ;-)

> 
> [...]
> >  
> > +/**
> > + * batadv_purge_outstanding_packets - stop/purge scheduled bcast/OGMv1 packets
> > + * @bat_priv: the bat priv with all the soft interface information
> > + * @hard_iface:	the hard interface to cancel and purge bcast/ogm packets on
> 
> Please replace the tab between " @hard_iface:" and "the hard in" with a space
> 
> [...]
> > @@ -21,6 +21,7 @@
> >  #include "main.h"
> >  
> >  #include <linux/compiler.h>
> > +#include <linux/spinlock_types.h>
> >  #include <linux/types.h>
> 
> This include is actually correct - but I am currently mapping 
> linux/spinlock_types.h to linux/spinlock.h in iwyu. So would be easier for me
> when this include will be set to linux/spinlock.h.
> 
> I am not sure about all the crime related puns in this patch but the idea
> makes sense and also cleans up some of the forwarding packet code.

Thanks for the review so far, will send an updated patch soon!

Regards, Linus
