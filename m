Return-Path: <andrew@lunn.ch>
Date: Wed, 8 Dec 2010 19:12:08 +0100
From: Andrew Lunn <andrew@lunn.ch>
Message-ID: <20101208181208.GC11267@lunn.ch>
References: <20101207221351.GA19474@Sellars>
	<1291761150-29818-13-git-send-email-linus.luessing@saxnet.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1291761150-29818-13-git-send-email-linus.luessing@saxnet.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH 13/20] batman-adv: Send own BAT_MCAST
 packets in proact_tracking multicast mode
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>
Cc: Linus L??ssing <linus.luessing@saxnet.de>

On Tue, Dec 07, 2010 at 11:32:23PM +0100, Linus L??ssing wrote:
> This patch adds the capability to encapsulate and send a node's own
> multicast data packets. Based on the previously established multicast
> forwarding table, the sender can decide wheather it actually has to send
> the multicast data to one or more of its interfaces or not.
> 
> Furthermore, the sending procedure also decides whether to broadcast or
> unicast a multicast data packet to its next-hops, depending on the
> configured mcast_fanout (default: < 3 next hops on an interface, send
> seperate unicast packets).
> 
> Signed-off-by: Linus L??ssing <linus.luessing@saxnet.de>
> ---
>  multicast.c      |  133 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  multicast.h      |    1 +
>  soft-interface.c |   25 +++++++++--
>  types.h          |    1 +
>  4 files changed, 156 insertions(+), 4 deletions(-)
> 
> diff --git a/multicast.c b/multicast.c
> index 2b1bfde..72249ef 100644
> --- a/multicast.c
> +++ b/multicast.c
> @@ -23,6 +23,7 @@
>  #include "multicast.h"
>  #include "hash.h"
>  #include "send.h"
> +#include "soft-interface.h"
>  #include "compat.h"
>  
>  /* If auto mode for tracker timeout has been selected,
> @@ -1058,6 +1059,138 @@ int mcast_forw_table_seq_print_text(struct seq_file *seq, void *offset)
>  	return 0;
>  }
>  
> +static void route_mcast_packet(struct sk_buff *skb, struct bat_priv *bat_priv)
> +{
> +	struct sk_buff *skb1;
> +	struct mcast_packet *mcast_packet;
> +	struct ethhdr *ethhdr;
> +	struct batman_if *batman_if;
> +	unsigned long flags;
> +	struct mcast_forw_table_entry *table_entry;
> +	struct mcast_forw_orig_entry *orig_entry;
> +	struct mcast_forw_if_entry *if_entry;
> +	struct mcast_forw_nexthop_entry *nexthop_entry;
> +	int mcast_fanout = atomic_read(&bat_priv->mcast_fanout);
> +	int num_bcasts = 3, i;
> +	struct dest_entries_list dest_list, *dest_entry, *tmp;
> +
> +	mcast_packet = (struct mcast_packet*)skb->data;
> +	ethhdr = (struct ethhdr*)(mcast_packet + 1);
> +
> +	INIT_LIST_HEAD(&dest_list.list);
> +
> +	mcast_packet->ttl--;
> +
> +	rcu_read_lock();
> +	spin_lock_irqsave(&bat_priv->mcast_forw_table_lock, flags);
> +	list_for_each_entry(table_entry, &bat_priv->mcast_forw_table, list) {
> +		if (memcmp(ethhdr->h_dest, table_entry->mcast_addr, ETH_ALEN))
> +			continue;
> +
> +		list_for_each_entry(orig_entry, &table_entry->mcast_orig_list,
> +				    list) {
> +			if (memcmp(mcast_packet->orig,
> +				   orig_entry->orig, ETH_ALEN))
> +				continue;
> +
> +			list_for_each_entry(if_entry,
> +					    &orig_entry->mcast_if_list, list) {
> +				batman_if = if_num_to_batman_if(
> +							if_entry->if_num);
> +
> +				/* send via broadcast */
> +				if (if_entry->num_nexthops > mcast_fanout) {
> +					dest_entry = kmalloc(sizeof(struct
> +							dest_entries_list),
> +							GFP_ATOMIC);
> +					memcpy(dest_entry->dest,
> +					       broadcast_addr, ETH_ALEN);
> +					dest_entry->batman_if = batman_if;
> +					list_add(&dest_entry->list,
> +						 &dest_list.list);
> +					continue;
> +				}
> +
> +				/* send seperate unicast packets */
> +				list_for_each_entry(nexthop_entry,
> +						&if_entry->mcast_nexthop_list,
> +						list) {
> +					if (!get_remaining_timeout(
> +								nexthop_entry,
> +								bat_priv))
> +						continue;
> +

Again, refactor this into four functions. 

       Andrew
