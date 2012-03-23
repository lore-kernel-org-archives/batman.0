Return-Path: <andrew@lunn.ch>
Date: Fri, 23 Mar 2012 22:22:33 +0100
From: Andrew Lunn <andrew@lunn.ch>
Message-ID: <20120323212233.GG5662@lunn.ch>
References: <201203222250.31309.lindner_marek@yahoo.de>
	<1332453075-27999-1-git-send-email-lindner_marek@yahoo.de>
	<1332453075-27999-2-git-send-email-lindner_marek@yahoo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1332453075-27999-2-git-send-email-lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [RFC 2/5] batman-adv: ELP - creating neighbor
 structures, updating LQs
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

> +static int bat_v_elp_packet_recv(struct sk_buff *skb,
> +				 struct hard_iface *if_incoming)
> +{
> +	struct bat_priv *bat_priv = netdev_priv(if_incoming->soft_iface);
> +	struct batman_elp_packet *elp_packet;
> +	struct hard_iface *primary_if;
> +	struct ethhdr *ethhdr;
> +	bool ret;
> +
> +	ret = check_management_packet(skb, if_incoming, BATMAN_ELP_HLEN);
> +	if (!ret)
> +		return NET_RX_DROP;
> +
> +	/* did we receive a B.A.T.M.A.N. V ELP packet on an interface
> +	 * that does not have B.A.T.M.A.N. V ELP enabled ? */
> +	if (bat_priv->bat_algo_ops->bat_ogm_emit != bat_v_ogm_emit)
> +		return NET_RX_DROP;

Hi Marek

I've not looked at the code, but i assume this can happen because
there is not a per algorithm receive handler? Maybe it makes sense to
have a receive handler in algo structure, which can handle per
algorithm receive functions? The common PDUs can be handled first and
then a call into the algo receive function made to dispatch algo
specific PDUs.

	 Andrew
