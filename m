Return-Path: <andrew@lunn.ch>
Date: Thu, 17 Jun 2010 07:42:57 +0200
From: Andrew Lunn <andrew@lunn.ch>
Message-ID: <20100617054257.GA15420@lunn.ch>
References: <1276727961-18719-1-git-send-email-sven.eckelmann@gmx.de>
	<201006170042.13864.sven.eckelmann@gmx.de>
	<201006170052.18499.lindner_marek@yahoo.de>
	<201006170110.19294.sven.eckelmann@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201006170110.19294.sven.eckelmann@gmx.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: use rx_handler_data pointer
 to store net_bridge_port pointer
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
Cc: Marek Lindner <lindner_marek@yahoo.de>

> --- a/batman-adv-kernelland/hard-interface.h
> +++ b/batman-adv-kernelland/hard-interface.h
> @@ -38,3 +38,8 @@ int batman_skb_recv(struct sk_buff *skb,
>  				struct net_device *orig_dev);
>  int hardif_min_mtu(void);
>  void update_min_mtu(void);
> +
> +#ifndef netdev_isbridged
> +#define netdev_isbridged(netdev) \
> +	((net_dev)->priv_flags & IFF_BRIDGE_PORT)
> +#endif

Maybe this could be pushed upstream? Seems like a useful bit of code
in general?

   Andrew
