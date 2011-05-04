Return-Path: <andrew@lunn.ch>
Date: Wed, 4 May 2011 13:22:34 +0200
From: Andrew Lunn <andrew@lunn.ch>
Message-ID: <20110504112234.GA1528@lunn.ch>
References: <1303940106-1457-1-git-send-email-ordex@autistici.org>
	<1304438096-19009-4-git-send-email-ordex@autistici.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1304438096-19009-4-git-send-email-ordex@autistici.org>
Subject: Re: [B.A.T.M.A.N.] [PATCHv2 3/4] batman-adv: improved roaming
 mechanism
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

> +struct roam_adv_packet {
> +	uint8_t  packet_type;
> +	uint8_t  version;
> +	uint8_t  dst[6];
> +	uint8_t  ttl;
> +	uint8_t  src[6];
> +	uint8_t  client[6];
> +} __packed;
> +

Maybe put ttl at the end, to help with alignment? 

> +	tt_global_add(bat_priv, orig_node, roam_adv_packet->client,
> +		      atomic_read(&orig_node->last_ttvn) + 1, true);
> +
> +	/* Roaming phase starts: I have a new information but the ttvn has been
> +	 * incremented yet. This flag will make me check all the incoming
> +	 * packets for the correct destination. */

The grammar in that comment could be better:

	/* Roaming phase starts: I have new information but the ttvn has not 
	 * been incremented yet. This flag will make me check all the incoming
	 * packets for the correct destination. */


 +void send_roam_adv(struct bat_priv *bat_priv, uint8_t *client,
> +		   struct orig_node *orig_node)
> +{
> +	struct neigh_node *neigh_node;
> +	struct sk_buff *skb;
> +	struct roam_adv_packet *roam_adv_packet;
> +	struct tt_roam_node *tt_roam_node;
> +	bool found = false;
> +	int ret = 1;
> +
> +	spin_lock_bh(&bat_priv->tt_roam_list_lock);
> +	/* The new tt_req will be issued only if I'm not waiting for a
> +	 * reply from the same orig_node yet */
> +	list_for_each_entry(tt_roam_node, &bat_priv->tt_roam_list, list) {
> +		if (!compare_eth(tt_roam_node->addr, client))
> +			continue;
> +
> +		if (is_out_of_time(tt_roam_node->first_time,
> +				   ROAMING_MAX_TIME * 1000))
> +			continue;
> +
> +		if (!atomic_dec_not_zero(&tt_roam_node->counter))
> +			/* Sorry, you roamed too many times! */
> +			goto unlock;
> +
> +		found = true;
> +		break;
> +	}
> +
> +	if (!found) {
> +		tt_roam_node = kmalloc(sizeof(struct tt_roam_node), GFP_ATOMIC);
> +		if (!tt_roam_node)
> +			goto unlock;
> +
> +		tt_roam_node->first_time = jiffies;
> +		atomic_set(&tt_roam_node->counter, ROAMING_MAX_COUNT - 1);
> +		memcpy(tt_roam_node->addr, client, ETH_ALEN);
> +
> +		list_add(&tt_roam_node->list, &bat_priv->tt_roam_list);
> +	}
> +	spin_unlock_bh(&bat_priv->tt_roam_list_lock);
> +
> +	skb = dev_alloc_skb(sizeof(struct roam_adv_packet) + ETH_HLEN);
> +	if (!skb)
> +		goto free_skb;

If the allocation fails, go free it ?

> +
> +	skb_reserve(skb, ETH_HLEN);
> +
> +	roam_adv_packet = (struct roam_adv_packet *)skb_put(skb,
> +					sizeof(struct roam_adv_packet));
> +
> +	roam_adv_packet->packet_type = BAT_ROAM_ADV;
> +	roam_adv_packet->version = COMPAT_VERSION;
> +	roam_adv_packet->ttl = TTL;
> +	memcpy(roam_adv_packet->src,
> +		bat_priv->primary_if->net_dev->dev_addr, ETH_ALEN);
> +	memcpy(roam_adv_packet->dst, orig_node->orig, ETH_ALEN);
> +	memcpy(roam_adv_packet->client, client, ETH_ALEN);
> +
> +	neigh_node = find_router(bat_priv, orig_node, NULL);
> +	if (!neigh_node)
> +		goto free_skb;
> +
> +	if (neigh_node->if_incoming->if_status != IF_ACTIVE)
> +		goto free_neigh;
> +
> +	bat_dbg(DBG_ROUTES, bat_priv,
> +		"Sending ROAMING_ADV to %pM (client %pM) via %pM\n",
> +		orig_node->orig, client, neigh_node->addr);
> +
> +	send_skb_packet(skb, neigh_node->if_incoming, neigh_node->addr);
> +	ret = 0;
> +
> +free_neigh:
> +	if (neigh_node)
> +		neigh_node_free_ref(neigh_node);
> +free_skb:
> +	if (ret)
> +		kfree_skb(skb);
> +	return;
> +unlock:
> +	spin_unlock_bh(&bat_priv->tt_roam_list_lock);
>  }

All these different goto's makes me think of BASIC. How about breaking
this function up into a number of functions. 

1) find an existing tt_roam_node
2) Create a new tt_roam_node
3) Allocate and fill in the roam_adv_packet.
4) Find the neigh_node and send the packet.

You then end up with something like

void send_roam_adv(struct bat_priv *bat_priv, uint8_t *client,
		   struct orig_node *orig_node)
{
	spin_lock_bh(&bat_priv->tt_roam_list_lock);
	
	tt_roam_node = find_tt_roam_node(client);

	if (!tt_roam_node) {
	   tt_roam_node = new_tt_roam_node(client, bat_priv);
	}
	spin_unlock_bh(&bat_priv->tt_roam_list_lock);

	if (tt_roam_node)
	   roam_pkt = build_roam_pkt(bat_priv, orig_node, client);
	   if (roan_pkt)
	      send_roam_pkt(roam_pkt, orig_node, client);
}

No goto's and easier to understand.  It also makes it clear that
tt_roam_node is not actually used while sending the packet, so maybe
it does not belong inside send_roam_adv()?

> +	bool tt_poss_change; /* this flag is needed to detect an ongoing
> +			      * roaming event. If it is true, it means that
> +			      * in the last OGM interval I sent a Roaming_adv,
> +			      * so I have to check every packet going to it
> +			      * whether the destination is still a client of
> +			      * its or not, it will be reset as soon as I'll
> +			      * receive a new TTVN from it */
> +

Too many it/its. I have a hard time understanding what it is.

So, mostly comments about the comments and style issues.

  Andrew
