Return-Path: <andrew@lunn.ch>
Date: Fri, 25 Nov 2011 09:31:25 +0100
From: Andrew Lunn <andrew@lunn.ch>
Message-ID: <20111125083125.GF6836@lunn.ch>
References: <1322173279-18338-1-git-send-email-ordex@autistici.org>
	<1322173279-18338-5-git-send-email-ordex@autistici.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1322173279-18338-5-git-send-email-ordex@autistici.org>
Subject: Re: [B.A.T.M.A.N.] [PATCHv4 4/7] batman-adv: Distributed ARP Table
 - add ARP parsing functions
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



> +/* Returns arphdr->ar_op if the skb contains a valid ARP packet, otherwise
> + * returns 0 */
> +static uint16_t arp_get_type(struct bat_priv *bat_priv, struct sk_buff *skb)
> +{
> +	struct arphdr *arphdr;
> +	struct ethhdr *ethhdr;
> +	uint16_t type = 0;
> +
> +	if (unlikely(!pskb_may_pull(skb, ETH_HLEN)))
> +		goto out;
> +
> +	ethhdr = (struct ethhdr *)skb_mac_header(skb);
> +
> +	if (ethhdr->h_proto != htons(ETH_P_ARP))
> +		goto out;

Do we have any idea how many people run vlans over B.A.T.M.A.N? It
would not be too hard to skip over the VLAN tag if there is one to see
if it is an ARP message inside.

   Andrew
