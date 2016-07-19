Return-Path: <linus.luessing@c0d3.blue>
Date: Tue, 19 Jul 2016 08:29:07 +0200
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@c0d3.blue>
Message-ID: <20160719062907.GA10173@otheros>
References: <1465557064-24406-1-git-send-email-apape@phoenixcontact.com>
 <1465557064-24406-3-git-send-email-apape@phoenixcontact.com>
 <1655869.LYQpVbDg6l@prime>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1655869.LYQpVbDg6l@prime>
Subject: Re: [B.A.T.M.A.N.] [PATCH v5 2/6] batman-adv: speed up dat by
 snooping received ip traffic
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

Hi Andreas,

After the observations in ticket #291 [0], Antonio and I had been
discussing this topic a little further on IRC.

The Linux kernel seems to refresh its ARP table by snooping the IP
traffic, too. But IP traffic does not create any ARP table
entries.

What do you think about doing the same in batman-adv? That is,
only updating, but not creating DAT cache entries from IP traffic.
That should get rid of the main two concerns, accidentally
snooping routed IP traffic and performance implications, shouldn't it?

Regards, Linus


On Fri, Jul 01, 2016 at 03:49:54PM +0200, Simon Wunderlich wrote:
> Hi Andreas,
> 
> as suggested by yourself and according to the discussion, please drop this 
> patch from the patchset on the next resend. It may be better to resend it 
> separately when the concerns are cleared.
> 
> Thanks!
>     Simon
> 
> On Friday 10 June 2016 13:11:00 Andreas Pape wrote:
> > Speeding up dat address lookup is achieved by snooping all incoming ip
> > traffic. This especially increases the propability in bla setups that
> > a gateway into a common backbone network already has a fitting dat entry
> > to answer incoming ARP requests directly coming from the backbone
> > network thus further reducing ARP traffic in the mesh.
> > 
> > Signed-off-by: Andreas Pape <apape@phoenixcontact.com>
> > ---
> >  net/batman-adv/distributed-arp-table.c |   55
> > ++++++++++++++++++++++++++++++++ net/batman-adv/distributed-arp-table.h |  
> >  9 +++++-
> >  net/batman-adv/soft-interface.c        |    3 ++
> >  3 files changed, 66 insertions(+), 1 deletions(-)
> > 
> > diff --git a/net/batman-adv/distributed-arp-table.c
> > b/net/batman-adv/distributed-arp-table.c index b752f8d..998a4b8 100644
> > --- a/net/batman-adv/distributed-arp-table.c
> > +++ b/net/batman-adv/distributed-arp-table.c
> > @@ -27,6 +27,7 @@
> >  #include <linux/if_arp.h>
> >  #include <linux/if_ether.h>
> >  #include <linux/if_vlan.h>
> > +#include <linux/ip.h>
> >  #include <linux/in.h>
> >  #include <linux/jiffies.h>
> >  #include <linux/kernel.h>
> > @@ -362,6 +363,60 @@ out:
> >  		batadv_dat_entry_put(dat_entry);
> >  }
> > 
> > +/**
> > + * batadv_dat_entry_check - check and update a dat entry
> > + * @bat_priv: the bat priv with all the soft interface information
> > + * @skb: socket buffer
> > + * @vid: VLAN identifier
> > + *
> > + * snoops incoming socket buffer for dat cache updates, if dat is enabled.
> > + * Can be called from other modules.
> > + */
> > +void batadv_dat_entry_check(struct batadv_priv *bat_priv, struct sk_buff
> > *skb, +			    unsigned short vid)
> > +{
> > +	struct vlan_ethhdr *vhdr = NULL, tmp_vhdr;
> > +	struct ethhdr *ethhdr = NULL;
> > +	struct iphdr *iphdr = NULL, tmp_iphdr;
> > +
> > +	if (!atomic_read(&bat_priv->distributed_arp_table))
> > +		return;
> > +
> > +	ethhdr = eth_hdr(skb);
> > +
> > +	switch (ntohs(ethhdr->h_proto)) {
> > +	case ETH_P_IP:
> > +		iphdr = skb_header_pointer(skb, ETH_HLEN, sizeof(tmp_iphdr),
> > +					   &tmp_iphdr);
> > +		break;
> > +	case ETH_P_8021Q:
> > +		vhdr = skb_header_pointer(skb, 0, sizeof(tmp_vhdr),
> > +					  &tmp_vhdr);
> > +		if (!vhdr)
> > +			return;
> > +		if (ntohs(vhdr->h_vlan_encapsulated_proto) != ETH_P_IP)
> > +			return;
> > +		iphdr = skb_header_pointer(skb, sizeof(tmp_vhdr),
> > +					   sizeof(tmp_iphdr),
> > +					   &tmp_iphdr);
> > +		break;
> > +	}
> > +
> > +	if (!iphdr)
> > +		return;
> > +	/* don't add source address 0.0.0.0, which can occur during
> > +	 * dhcp discover or request.
> > +	 */
> > +	if (ntohl(iphdr->saddr) == 0)
> > +		return;
> > +
> > +	batadv_dbg(BATADV_DBG_DAT, bat_priv,
> > +		   "Snooped IP address: %pI4 %pM (vid: %d)\n",
> > +		   &iphdr->saddr, ethhdr->h_source,
> > +		   BATADV_PRINT_VID(vid));
> > +	batadv_dat_entry_add(bat_priv, iphdr->saddr, ethhdr->h_source, vid);
> > +}
> > +
> >  #ifdef CONFIG_BATMAN_ADV_DEBUG
> > 
> >  /**
> > diff --git a/net/batman-adv/distributed-arp-table.h
> > b/net/batman-adv/distributed-arp-table.h index 813ecea..cf1b93c 100644
> > --- a/net/batman-adv/distributed-arp-table.h
> > +++ b/net/batman-adv/distributed-arp-table.h
> > @@ -80,7 +80,8 @@ batadv_dat_init_own_addr(struct batadv_priv *bat_priv,
> >  int batadv_dat_init(struct batadv_priv *bat_priv);
> >  void batadv_dat_free(struct batadv_priv *bat_priv);
> >  int batadv_dat_cache_seq_print_text(struct seq_file *seq, void *offset);
> > -
> > +void batadv_dat_entry_check(struct batadv_priv *bat_priv, struct sk_buff
> > *skb, +			    unsigned short vid);
> >  /**
> >   * batadv_dat_inc_counter - increment the correct DAT packet counter
> >   * @bat_priv: the bat priv with all the soft interface information
> > @@ -173,6 +174,12 @@ static inline void batadv_dat_inc_counter(struct
> > batadv_priv *bat_priv, {
> >  }
> > 
> > +static inline
> > +void batadv_dat_entry_check(struct batadv_priv *bat_priv, struct sk_buff
> > *skb, +			    unsigned short vid)
> > +{
> > +}
> > +
> >  #endif /* CONFIG_BATMAN_ADV_DAT */
> > 
> >  #endif /* _NET_BATMAN_ADV_DISTRIBUTED_ARP_TABLE_H_ */
> > diff --git a/net/batman-adv/soft-interface.c
> > b/net/batman-adv/soft-interface.c index 81665b1..a86748f 100644
> > --- a/net/batman-adv/soft-interface.c
> > +++ b/net/batman-adv/soft-interface.c
> > @@ -442,6 +442,9 @@ void batadv_interface_rx(struct net_device *soft_iface,
> >  		goto dropped;
> >  	}
> > 
> > +	/* Snoop incoming traffic for dat update */
> > +	batadv_dat_entry_check(bat_priv, skb, vid);
> > +
> >  	/* skb->dev & skb->pkt_type are set here */
> >  	skb->protocol = eth_type_trans(skb, soft_iface);
> > 
> > --
> > 1.7.0.4
> > 
> > 
> > 
> > ..................................................................
> > PHOENIX CONTACT ELECTRONICS GmbH
> > 
> > Sitz der Gesellschaft / registered office of the company: 31812 Bad Pyrmont
> > USt-Id-Nr.: DE811742156
> > Amtsgericht Hannover HRB 100528 / district court Hannover HRB 100528
> > Geschäftsführer / Executive Board: Roland Bent, Dr. Martin Heubeck
> > ___________________________________________________________________
> > Diese E-Mail enthält vertrauliche und/oder rechtlich geschützte
> > Informationen. Wenn Sie nicht der richtige Adressat sind oder diese E-Mail
> > irrtümlich erhalten haben, informieren Sie bitte sofort den Absender und
> > vernichten Sie diese Mail. Das unerlaubte Kopieren, jegliche anderweitige
> > Verwendung sowie die unbefugte Weitergabe dieser Mail ist nicht gestattet.
> > ---------------------------------------------------------------------------
> > ------------------------- This e-mail may contain confidential and/or
> > privileged information. If you are not the intended recipient (or have
> > received this e-mail in error) please notify the sender immediately and
> > destroy this e-mail. Any unauthorized copying, disclosure, distribution or
> > other use of the material or parts thereof is strictly forbidden.
> > ___________________________________________________________________


