Return-Path: <andrew@lunn.ch>
Date: Mon, 9 May 2011 16:48:12 +0200
From: Andrew Lunn <andrew@lunn.ch>
Message-ID: <20110509144812.GB31070@lunn.ch>
References: <1304579589-5222-1-git-send-email-ordex@autistici.org>
	<1304946150-6026-3-git-send-email-ordex@autistici.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1304946150-6026-3-git-send-email-ordex@autistici.org>
Subject: Re: [B.A.T.M.A.N.] [PATCHv3 3/3] batman-adv: improved gateway
 tq-based selection
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

On Mon, May 09, 2011 at 03:02:30PM +0200, Antonio Quartulli wrote:
> If a client issues a DHCPREQUEST for renewal, the packet is dropped
> if the old destination (the old gateway for the client) TQ is smaller
> than the current best gateway TQ less GW_THRESHOLD
> 
> Signed-off-by: Antonio Quartulli <ordex@autistici.org>
> ---
>  gateway_client.c |   94 ++++++++++++++++++++++++++++++++++++++++++++++++++++-
>  gateway_client.h |    3 +-
>  main.h           |    3 +-
>  soft-interface.c |   10 ++++-
>  4 files changed, 104 insertions(+), 6 deletions(-)
> 
> diff --git a/gateway_client.c b/gateway_client.c
> index 761dcfb..33bceee 100644
> --- a/gateway_client.c
> +++ b/gateway_client.c
> @@ -25,11 +25,17 @@
>  #include "gateway_common.h"
>  #include "hard-interface.h"
>  #include "originator.h"
> +#include "routing.h"
>  #include <linux/ip.h>
>  #include <linux/ipv6.h>
>  #include <linux/udp.h>
>  #include <linux/if_vlan.h>
>  
> +/* This is the offset of the options field in a dhcp packet starting at
> + * the beginning of the dhcp header */
> +#define DHCP_OPTIONS_OFFSET 240
> +#define DHCP_REQUEST 3
> +
>  static void gw_node_free_rcu(struct rcu_head *rcu)
>  {
>  	struct gw_node *gw_node;
> @@ -509,14 +515,75 @@ out:
>  	return ret;
>  }
>  
> -int gw_is_target(struct bat_priv *bat_priv, struct sk_buff *skb)
> +static bool is_type_dhcprequest(struct sk_buff *skb, int header_len)
> +{
> +	int ret = false;
> +	unsigned char *p;
> +	int pkt_len;
> +
> +	if (skb_linearize(skb) < 0)
> +		goto out;
> +
> +	pkt_len = skb_headlen(skb);
> +
> +	if (pkt_len < header_len + DHCP_OPTIONS_OFFSET + 1)
> +		goto out;
> +
> +	p = skb->data + header_len + DHCP_OPTIONS_OFFSET;
> +	pkt_len -= header_len + DHCP_OPTIONS_OFFSET + 1;
> +
> +	/* Access the dhcp option lists. Each entry is made up by:
> +	 * - octect 1: option type
> +	 * - octect 2: option data len (only if type != 255 and 0)
> +	 * - octect 3: option data */
> +	while (*p != 255 && !ret) {
> +		/* p now points to the first octect: option type */
> +		if (*p == 53) {
> +			/* type 53 is the message type option.
> +			 * Jump the len octect and go to the data octect */
> +			if (pkt_len < 2)
> +				goto out;
> +			pkt_len -= 2;
> +			p += 2;
> +
> +			/* check if the message type is what we need */
> +			if (*p == DHCP_REQUEST)
> +				ret = true;

Why do you continue parsing the options if it is not a DHCP_REQUEST?
Do you think there will be a second, third, fourth option information
element 53?

	Andrew
