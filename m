Return-Path: <andrew@lunn.ch>
Date: Tue, 11 Feb 2014 18:12:07 +0100
From: Andrew Lunn <andrew@lunn.ch>
Message-ID: <20140211171207.GE24633@lunn.ch>
References: <1392122903-805-1-git-send-email-antonio@meshcoding.com>
 <1392122903-805-8-git-send-email-antonio@meshcoding.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1392122903-805-8-git-send-email-antonio@meshcoding.com>
Subject: Re: [B.A.T.M.A.N.] [RFC 07/23] batman-adv: OGMv2 - add basic
 infrastructure
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
Cc: Antonio Quartulli <antonio@open-mesh.com>

> +static void batadv_v_ogm_send(struct work_struct *work)
> +{
> +	struct batadv_hard_iface *hard_iface;
> +	struct batadv_priv_bat_v *bat_v;
> +	struct batadv_priv *bat_priv;
> +	struct batadv_ogm2_packet *ogm2;
> +	struct sk_buff *skb;
> +	unsigned char *ogm_buff, *pkt_buff;
> +	int ogm_buff_len;
> +	uint16_t tvlv_len = 0;
> +
> +	bat_v = container_of(work, struct batadv_priv_bat_v, ogm_wq.work);
> +	bat_priv = container_of(bat_v, struct batadv_priv, bat_v);
> +
> +	if (atomic_read(&bat_priv->mesh_state) == BATADV_MESH_DEACTIVATING)
> +		goto out;
> +
> +	ogm_buff = bat_priv->bat_v.ogm_buff;
> +	ogm_buff_len = bat_priv->bat_v.ogm_buff_len;
> +	/* tt changes have to be committed before the tvlv data is
> +	 * appended as it may alter the tt tvlv container
> +	 */
> +	batadv_tt_local_commit_changes(bat_priv);
> +	tvlv_len = batadv_tvlv_container_ogm_append(bat_priv, &ogm_buff,
> +						    &ogm_buff_len,
> +						    BATADV_OGM2_HLEN);
> +
> +	bat_priv->bat_v.ogm_buff = ogm_buff;
> +	bat_priv->bat_v.ogm_buff_len = ogm_buff_len;
> +
> +	skb = netdev_alloc_skb_ip_align(NULL, ETH_HLEN + ogm_buff_len);
> +	if (!skb)
> +		goto out;
> +
> +	skb_reserve(skb, ETH_HLEN);
> +	pkt_buff = skb_put(skb, ogm_buff_len);
> +	memcpy(pkt_buff, ogm_buff, ogm_buff_len);
> +
> +	ogm2 = (struct batadv_ogm2_packet *)skb->data;
> +	ogm2->seqno = htonl(atomic_read(&bat_priv->bat_v.ogm_seqno));
> +	atomic_inc(&bat_priv->bat_v.ogm_seqno);
> +	ogm2->tvlv_len = htons(tvlv_len);
> +
> +	/* broadcast on every interface */
> +	rcu_read_lock();
> +	list_for_each_entry_rcu(hard_iface, &batadv_hardif_list, list) {
> +		if (hard_iface->soft_iface != bat_priv->soft_iface)
> +			continue;
> +
> +		batadv_dbg(BATADV_DBG_BATMAN, bat_priv,
> +			   "Sending own OGM2 packet (originator %pM, seqno %u, metric %u, TTL %d) on interface %s [%pM]\n",
> +			   ogm2->orig, ntohl(ogm2->seqno), ntohl(ogm2->metric),
> +			   ogm2->ttl, hard_iface->net_dev->name,
> +			   hard_iface->net_dev->dev_addr);
> +
> +		batadv_v_ogm_send_to_if(skb, hard_iface);
> +	}
> +	rcu_read_unlock();
> +
> +	consume_skb(skb);
> +
> +	batadv_v_ogm_start_timer(bat_priv);
> +out:
> +	return;

If you jump to out because netdev_alloc_skb_ip_align() failed, don't
you want to start the timer again? I would assume it is a transient
problem not being able to get memory for the skb, and the next time
the timer goes off it might work?

> +	bat_priv->bat_v.ogm_buff_len = BATADV_OGM2_HLEN;
> +	ogm_buff = kmalloc(bat_priv->bat_v.ogm_buff_len, GFP_ATOMIC);

Maybe use kzalloc to ensure it is zero?

      Andrew
