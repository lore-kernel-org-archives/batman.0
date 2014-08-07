Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Thu, 7 Aug 2014 20:08:57 +0200
References: <1406673579-20110-1-git-send-email-linus.luessing@web.de>
 <1406673579-20110-4-git-send-email-linus.luessing@web.de>
In-Reply-To: <1406673579-20110-4-git-send-email-linus.luessing@web.de>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <201408072008.57487.sw@simonwunderlich.de>
Subject: Re: [B.A.T.M.A.N.] [PATCHv6 3/3] batman-adv: Add debugfs table for
	mcast flags
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

> --- a/multicast.c
> +++ b/multicast.c
> @@ -995,6 +995,116 @@ void batadv_mcast_init(struct batadv_priv *bat_priv)
>  }
> 
>  /**
> + * batadv_mcast_flags_print_header - print own mcast flags to debugfs
> table + * @bat_priv: the bat priv with all the soft interface information
> + * @seq: debugfs table seq_file struct
> + *
> + * Prints our own multicast flags including a more specific reason why
> + * they are set, that is prints the bridge and querier state too, to
> + * the debugfs table specified via @seq.
> + */
> +static void batadv_mcast_flags_print_header(struct batadv_priv *bat_priv,
> +					    struct seq_file *seq)
> +{
> +	struct net_device *dev = bat_priv->soft_iface;
> +	uint8_t flags = bat_priv->mcast.flags;
> +	char ip4_querier_c, ip6_querier_c, ip4_shadowed_c, ip6_shadowed_c;
> +	bool bridged = batadv_mcast_has_bridge(bat_priv);
> +
> +	if (bridged) {
> +		bool ip4_querier, ip6_querier, ip4_shadowed, ip6_shadowed;
> +
> +		ip4_querier = br_multicast_has_querier_anywhere(dev, ETH_P_IP);
> +		ip6_querier = br_multicast_has_querier_anywhere(dev,
> +								ETH_P_IPV6);
> +		ip4_shadowed = br_multicast_has_querier_adjacent(dev, ETH_P_IP);
> +		ip6_shadowed = br_multicast_has_querier_adjacent(dev,
> +								 ETH_P_IPV6);

Isn't this info already in bat_priv->querier_ipv4/v6->exists/shadowed? Should 
avoid the 80 lines workarounds you are having here, or maybe you are able to 
squash that with the lines below.

> +
> +		ip4_querier_c = !ip4_querier ? '+' : '-';
> +		ip6_querier_c = !ip6_querier ? '+' : '-';
> +		ip4_shadowed_c = ip4_shadowed ? '+' : '-';
> +		ip6_shadowed_c = ip6_shadowed ? '+' : '-';
> +	} else {
> +		ip4_querier_c = '?';
> +		ip6_querier_c = '?';
> +		ip4_shadowed_c = '?';
> +		ip6_shadowed_c = '?';
> +	}
> +
> +	seq_printf(seq, "Multicast flags (own flags: [%c%c%c])\n",
> +		   flags & BATADV_MCAST_WANT_ALL_UNSNOOPABLES ? 'U' : '.',
> +		   flags & BATADV_MCAST_WANT_ALL_IPV4 ? '4' : '.',
> +		   flags & BATADV_MCAST_WANT_ALL_IPV6 ? '6' : '.');
> +	seq_printf(seq, "* Bridged [U]\t\t\t\t%c\n", bridged ? '+' : '-');

What does the U mean? Unsnoopables? The U-flag? (just noticed that this "U-
Flag" is also used without explanation in the previous patch).

> +	seq_printf(seq, "* No IGMP/MLD Querier [4/6]:\t\t%c/%c\n",
> +		   ip4_querier_c, ip6_querier_c);
> +	seq_printf(seq, "* Shadowing IGMP/MLD Querier [4/6]:\t%c/%c\n",
> +		   ip4_shadowed_c, ip6_shadowed_c);
> +	seq_puts(seq, "-------------------------------------------\n");
> +	seq_printf(seq, "       %-10s %s\n", "Originator", "Flags");
> +}
> +
> +/**
> + * batadv_mcast_flags_seq_print_text - print the mcast flags of other
> nodes + * @seq: seq file to print on
> + * @offset: not used
> + *
> + * This prints a table of (primary) originators and their according
> + * multicast flags, including (in the header) our own.
> + */
> +int batadv_mcast_flags_seq_print_text(struct seq_file *seq, void *offset)
> +{
> +	struct net_device *net_dev = (struct net_device *)seq->private;
> +	struct batadv_priv *bat_priv = netdev_priv(net_dev);
> +	struct batadv_hard_iface *primary_if;
> +	struct batadv_hashtable *hash = bat_priv->orig_hash;
> +	struct batadv_orig_node *orig_node;
> +	struct hlist_head *head;
> +	uint8_t flags;
> +	uint32_t i;
> +
> +	primary_if = batadv_seq_print_text_primary_if_get(seq);
> +	if (!primary_if)
> +		return 0;
> +
> +	batadv_mcast_flags_print_header(bat_priv, seq);
> +
> +	for (i = 0; i < hash->size; i++) {
> +		head = &hash->table[i];
> +
> +		rcu_read_lock();
> +		hlist_for_each_entry_rcu(orig_node, head, hash_entry) {
> +			if (!(orig_node->capa_initialized &
> +			      BATADV_ORIG_CAPA_HAS_MCAST))
> +				continue;
> +
> +			flags = orig_node->mcast_flags;
> +
> +			if (!(orig_node->capabilities &
> +			      BATADV_ORIG_CAPA_HAS_MCAST)) {
> +				seq_printf(seq, "%pM -\n", orig_node->orig);
> +				continue;
> +			}
> +
> +			seq_printf(seq, "%pM [%c%c%c]\n", orig_node->orig,
> +				   (flags & BATADV_MCAST_WANT_ALL_UNSNOOPABLES ?
> +				    'U' : '.'),
> +				   (flags & BATADV_MCAST_WANT_ALL_IPV4 ?
> +				    '4' : '.'),
> +				   (flags & BATADV_MCAST_WANT_ALL_IPV6 ?
> +				    '6' : '.'));
> +		}
> +		rcu_read_unlock();
> +	}
> +
> +	batadv_hardif_free_ref(primary_if);
> +
> +	return 0;
> +}
> +
> +
> +/**
>   * batadv_mcast_free - free the multicast optimizations structures
>   * @bat_priv: the bat priv with all the soft interface information
>   */

The rest looks good ... I'll need to test all that later. :)

Thanks,
    Simon
