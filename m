Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Fri, 10 Feb 2012 22:42:50 +0800
References: <1328830902-11574-1-git-send-email-ordex@autistici.org>
	<1328830902-11574-9-git-send-email-ordex@autistici.org>
In-Reply-To: <1328830902-11574-9-git-send-email-ordex@autistici.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201202102242.51229.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCHv5 8/9] batman-adv: add UNICAST_4ADDR
	packet type
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

On Friday, February 10, 2012 07:41:41 Antonio Quartulli wrote:
> --- a/routing.c
> +++ b/routing.c
> @@ -960,14 +960,20 @@ int recv_unicast_packet(struct sk_buff *skb, struct
> hard_iface *recv_if) struct unicast_packet *unicast_packet;
>  	int hdr_size = sizeof(*unicast_packet);
> 
> +	unicast_packet = (struct unicast_packet *)skb->data;
> +
> +	/* the caller function should have already pulled 2 bytes */
> +	if (unicast_packet->header.packet_type == BAT_UNICAST)
> +		hdr_size = sizeof(struct unicast_packet);
> +	else if (unicast_packet->header.packet_type == BAT_UNICAST_4ADDR)
> +		hdr_size = sizeof(struct unicast_4addr_packet);
> +

The first if statement should not be necessary given the default value of 
hdr_size. We also should stick to the general principle of using 
*variable_name instead of sizeof(). That was suggested in some of the kernel 
coding guidelines.


> +bool prepare_unicast_4addr_packet(struct bat_priv *bat_priv,
> +				  struct sk_buff *skb,
> +				  struct orig_node *orig_node)
> +{
> +	struct hard_iface *primary_if;
> +	struct unicast_4addr_packet *unicast_4addr_packet;
> +	bool ret = false;
> +
> +	primary_if = primary_if_get_selected(bat_priv);
> +	if (!primary_if)
> +		goto out;
> +
> +	if (my_skb_head_push(skb, sizeof(*unicast_4addr_packet)) < 0)
> +		goto out;
> +
> +	unicast_4addr_packet = (struct unicast_4addr_packet *)skb->data;
> +
> +	unicast_4addr_packet->u.header.version = COMPAT_VERSION;
> +	/* batman packet type: unicast */
> +	unicast_4addr_packet->u.header.packet_type = BAT_UNICAST_4ADDR;
> +	/* set unicast ttl */
> +	unicast_4addr_packet->u.header.ttl = TTL;
> +	/* copy the destination for faster routing */
> +	memcpy(unicast_4addr_packet->u.dest, orig_node->orig, ETH_ALEN);
> +	/* set the destination tt version number */
> +	unicast_4addr_packet->u.ttvn =
> +		(uint8_t)atomic_read(&orig_node->last_ttvn);
> +	memcpy(unicast_4addr_packet->src, primary_if->net_dev->dev_addr,
> +	       ETH_ALEN);
> +	ret = true;
> +out:
> +	if (primary_if)
> +		hardif_free_ref(primary_if);
> +	return ret;
> +}

This function looks like code duplication we coudl avoid. 
prepare_unicast_packet() does the same thing except for 2-3 fields ..


> +
> +int unicast_4addr_send_skb(struct sk_buff *skb, struct bat_priv *bat_priv)
> +{
> +	struct ethhdr *ethhdr = (struct ethhdr *)skb->data;
> +	struct unicast_4addr_packet *unicast_4addr_packet;
> +	struct orig_node *orig_node;
> +	struct neigh_node *neigh_node;
> +	int data_len = skb->len;
> +	int ret = 1;
> +
> +	/* get routing information */
> +	if (is_multicast_ether_addr(ethhdr->h_dest)) {
> +		orig_node = gw_get_selected_orig(bat_priv);
> +		if (orig_node)
> +			goto find_router;
> +	}
> +
> +	/* check for tt host - increases orig_node refcount.
> +	 * returns NULL in case of AP isolation */
> +	orig_node = transtable_search(bat_priv, ethhdr->h_source,
> +				      ethhdr->h_dest);
> +
> +find_router:
> +	/**
> +	 * find_router():
> +	 *  - if orig_node is NULL it returns NULL
> +	 *  - increases neigh_nodes refcount if found.
> +	 */
> +	neigh_node = find_router(bat_priv, orig_node, NULL);
> +
> +	if (!neigh_node)
> +		goto out;
> +
> +	if (!prepare_unicast_4addr_packet(bat_priv, skb, orig_node))
> +		goto out;
> +
> +	unicast_4addr_packet = (struct unicast_4addr_packet *)skb->data;
> +
> +	if (atomic_read(&bat_priv->fragmentation) &&
> +	    data_len + sizeof(*unicast_4addr_packet) >
> +				neigh_node->if_incoming->net_dev->mtu) {
> +		/* send frag skb decreases ttl */
> +		unicast_4addr_packet->u.header.ttl++;
> +		ret = frag_send_skb(skb, bat_priv,
> +				    neigh_node->if_incoming, neigh_node->addr);
> +		goto out;
> +	}
> +
> +	send_skb_packet(skb, neigh_node->if_incoming, neigh_node->addr);
> +	ret = 0;
> +	goto out;
> +
> +out:
> +	if (neigh_node)
> +		neigh_node_free_ref(neigh_node);
> +	if (orig_node)
> +		orig_node_free_ref(orig_node);
> +	if (ret == 1)
> +		kfree_skb(skb);
> +	return ret;
> +}

Same here. Isn't it possible to let function handle the difference in packet 
type without having the same function twice ? 

Regards,
Marek
