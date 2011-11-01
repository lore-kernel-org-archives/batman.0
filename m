Return-Path: <ordex@autistici.org>
Date: Tue, 1 Nov 2011 10:16:05 +0100
From: Antonio Quartulli <ordex@autistici.org>
Message-ID: <20111101091604.GD20215@ritirata.org>
References: <1319964962-5092-1-git-send-email-ordex@autistici.org>
	<1319964962-5092-6-git-send-email-ordex@autistici.org>
	<20111031001221.GF10726@pandem0nium>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20111031001221.GF10726@pandem0nium>
Subject: Re: [B.A.T.M.A.N.] [PATCH 5/6] batman-adv: Distributed ARP Table -
 add snooping functions for ARP messages
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

On Mon, Oct 31, 2011 at 01:12:21AM +0100, Simon Wunderlich wrote:
> This patch fails checkpatch.pl --strict.
> 
> On Sun, Oct 30, 2011 at 09:56:01AM +0100, Antonio Quartulli wrote:
> > +bool arp_snoop_outgoing_request(struct bat_priv *bat_priv, struct sk_buff *skb)
> > [...]
> > +	arp_neigh_update(bat_priv, ip_src, hw_src);
> > +
> > +	n = neigh_lookup(&arp_tbl, &ip_dst, primary_if->soft_iface);
> > +	/* check if it is a valid neigh entry */
> > +	if (n && (n->nud_state & NUD_CONNECTED)) {
> > +		skb_new = arp_create(ARPOP_REPLY, ETH_P_ARP, ip_src,
> > +				     primary_if->soft_iface, ip_dst, hw_src, n->ha,
> > +				     hw_src);
> > +		unicast_send_skb(skb_new, bat_priv);
> > +		bat_dbg(DBG_ARP, bat_priv, "ARP request replied locally\n");
> 
> This function is hooked up in the tx patch, why do we send the unicast reply to
> the mesh? Shouldn't it be sent on the soft interface instead? I don't really understand this one ...

You are right. As we have already discussed on IRC, I should use netif_rx()
directly here (to deliver the packet to the soft_iface).

> >  	if (is_my_mac(unicast_packet->dest)) {
> >  		interface_rx(recv_if->soft_iface, skb, recv_if, hdr_size);
> > +
> >  		return NET_RX_SUCCESS;
> >  	}
> >  
> 
> This added newline is useless.

Yeah :D

Thanks,

-- 
Antonio Quartulli

..each of us alone is worth nothing..
Ernesto "Che" Guevara
