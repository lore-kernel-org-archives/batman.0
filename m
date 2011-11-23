Return-Path: <andrew@lunn.ch>
Date: Wed, 23 Nov 2011 17:11:51 +0100
From: Andrew Lunn <andrew@lunn.ch>
Message-ID: <20111123161151.GC2656@lunn.ch>
References: <1321915993-29312-1-git-send-email-ordex@autistici.org>
	<1321915993-29312-6-git-send-email-ordex@autistici.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1321915993-29312-6-git-send-email-ordex@autistici.org>
Subject: Re: [B.A.T.M.A.N.] [PATCHv3 5/7] batman-adv: Distributed ARP Table
 - add snooping functions for ARP messages
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

Hi Antonio

> +	n = neigh_lookup(&arp_tbl, &ip_dst, primary_if->soft_iface);
> +	/* check if it is a valid neigh entry */
> +	if (!n || !(n->nud_state & NUD_CONNECTED))
> +		goto out;
> +
> +	skb_new = arp_create(ARPOP_REPLY, ETH_P_ARP, ip_src,
> +			     primary_if->soft_iface, ip_dst, hw_src, n->ha,
> +			     hw_src);
> +
> +	unicast_send_skb(skb_new, bat_priv);

Can arp_create fail? Should you check the return value before calling
unicast_send_skb()?

	Andrew
