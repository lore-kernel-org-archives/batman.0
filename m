Return-Path: <linus.luessing@c0d3.blue>
Date: Thu, 19 May 2016 21:33:12 +0200
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@c0d3.blue>
Message-ID: <20160519193312.GC12565@otheros>
References: <1462525107-19750-1-git-send-email-apape@phoenixcontact.com>
 <1462525107-19750-3-git-send-email-apape@phoenixcontact.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1462525107-19750-3-git-send-email-apape@phoenixcontact.com>
Subject: Re: [B.A.T.M.A.N.] [PATCHv3 2/6] batman-adv: speed up dat by
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

On Fri, May 06, 2016 at 10:58:23AM +0200, Andreas Pape wrote:
> Speeding up dat address lookup is achieved by snooping all incoming ip
> traffic. This especially increases the propability in bla setups that
> a gateway into a common backbone network already has a fitting dat entry
> to answer incoming ARP requests directly coming from the backbone
> network thus further reducing ARP traffic in the mesh.
> 
> Signed-off-by: Andreas Pape <apape@phoenixcontact.com>
> ---

This patch looks interesting :). Currently we have quite some
ARP-requests from gateways to clients left in Freifunk setups (had
been asking Antonio about it just yesterday) and looks like this
patch could help here.

> +void batadv_dat_entry_check(struct batadv_priv *bat_priv, struct sk_buff *skb,
> +			    unsigned short vid)
> +{
[...]
> +		batadv_dat_entry_add(bat_priv, iphdr->saddr,
> +				     ethhdr->h_source, vid);
> +	}
> +}

There is something in batadv_dat_entry_add() that makes me a
little worried:

----
	if (dat_entry) {
		if (!batadv_compare_eth(dat_entry->mac_addr,
					mac_addr))
			ether_addr_copy(dat_entry->mac_addr, mac_addr);
----

ether_addr_copy() isn't atomic, there is a race condition between
the update and any such check - like the one just above it.

This isn't really a bug of your patchset, but could make this race
condition much more likely. In the worst case, a fast IP packet
stream would create a constant rewrite and mostly broken
dat_entry->mac_addr.
