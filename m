Return-Path: <andrew@lunn.ch>
Date: Tue, 5 Jan 2010 07:43:49 +0100
From: Andrew Lunn <andrew@lunn.ch>
Message-ID: <20100105064349.GF9585@lunn.ch>
References: <201001042344.02273.lindner_marek@yahoo.de>
	<1262619976-5632-1-git-send-email-lindner_marek@yahoo.de>
	<1262619976-5632-2-git-send-email-lindner_marek@yahoo.de>
	<1262619976-5632-3-git-send-email-lindner_marek@yahoo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1262619976-5632-3-git-send-email-lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH 3/3] batman-adv: send DHCP requests
 directly to the chosen gw
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.net>
List-Unsubscribe: <https://lists.open-mesh.net/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=help>
List-Subscribe: <https://lists.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.net>
Cc: Marek Lindner <lindner_marek@yahoo.de>

> +bool gw_is_target(struct sk_buff *skb)
> +{
> +	struct ethhdr *ethhdr;
> +	struct iphdr *iphdr;
> +	struct udphdr *udphdr;
> +
> +	if (atomic_read(&gw_mode) != GW_MODE_CLIENT)
> +		return false;
> +
> +	if (!curr_gateway)
> +		return false;
> +
> +	ethhdr = (struct ethhdr *)skb->data;
> +	if (ntohs(ethhdr->h_proto) != ETH_P_IP)
> +		return false;
> +
> +	iphdr = (struct iphdr *)(skb->data + ETH_HLEN);
> +
> +	if (iphdr->protocol != IPPROTO_UDP)
> +		return false;
> +
> +	udphdr = (struct udphdr *)(skb->data + ETH_HLEN + (iphdr->ihl * 4));
> +
> +	if (ntohs(udphdr->dest) != 67)
> +		return false;
> +
> +	return true;
> +}
> -	/* ethernet packet should be broadcasted */
> -	if (is_bcast(ethhdr->h_dest) || is_mcast(ethhdr->h_dest)) {
> +	if (is_bcast(ethhdr->h_dest) || is_mcast(ethhdr->h_dest))
> +		bcast_dst = true;
> +
> +	if ((bcast_dst) && gw_is_target(skb))
> +		do_bcast = false;

Say the DHCP server is running in client mode. It has also been
requested to broadcast its replies, not unicast the replies.

http://blogs.technet.com/teamdhcp/archive/2009/02/12/dhcp-broadcast-flag-handling-in-windows-7.aspx

If i'm reading this code correctly, it will end up sending the DHCP
reply messages by unicast to the best gateway, not the DHCP client?

      Andrew
