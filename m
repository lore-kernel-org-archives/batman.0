Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Fri, 25 Nov 2011 09:19:09 +0800
References: <1322173279-18338-1-git-send-email-ordex@autistici.org>
	<1322173279-18338-8-git-send-email-ordex@autistici.org>
In-Reply-To: <1322173279-18338-8-git-send-email-ordex@autistici.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201111250919.09975.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCHv4 7/7] batman-adv: add Distributed ARP
	Table compile option
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

On Friday, November 25, 2011 06:21:19 Antonio Quartulli wrote:
>  /*
> - * dat_addr_t is the type used for all DHT indexes. If it is changed,
> - * DAT_ADDR_MAX is changed as well.
> - *
> - * *Please be careful: dat_addr_t must be UNSIGNED*
> - */
> +* dat_addr_t is the type used for all DHT indexes. If it is changed,
> +* DAT_ADDR_MAX is changed as well.
> +*
> +* *Please be careful: dat_addr_t must be UNSIGNED*
> +*/
>  #define dat_addr_t uint16_t
>  #define DAT_ADDR_MAX biggest_unsigned_int(dat_addr_t)
>  
>  #define ARP_HW_SRC(skb) ((uint8_t *)(skb->data) + sizeof(struct ethhdr) +
> \ -                       sizeof(struct arphdr))
> +               sizeof(struct arphdr))
>  #define ARP_IP_SRC(skb) (*(uint32_t *)(ARP_HW_SRC(skb) + ETH_ALEN))
>  #define ARP_HW_DST(skb) (ARP_HW_SRC(skb) + ETH_ALEN + 4)
>  #define ARP_IP_DST(skb) (*(uint32_t *)(ARP_HW_SRC(skb) + ETH_ALEN * 2 +
> 4)) 
> +
>  bool arp_snoop_outgoing_request(struct bat_priv *bat_priv,
> -                               struct sk_buff *skb);
> +                       struct sk_buff *skb);
>  bool arp_snoop_incoming_request(struct bat_priv *bat_priv,
> -                               struct sk_buff *skb);
> +                       struct sk_buff *skb);
>  bool arp_snoop_outgoing_reply(struct bat_priv *bat_priv, struct sk_buff
> *skb); bool arp_snoop_incoming_reply(struct bat_priv *bat_priv, struct
> sk_buff *skb); bool arp_drop_broadcast_packet(struct bat_priv *bat_priv,
> -                              struct forw_packet *forw_packet);
> +                      struct forw_packet *forw_packet);

This looks like a couple of spacing fixes that do not belong here ...

Regards,
Marek
