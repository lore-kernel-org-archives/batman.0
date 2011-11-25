Return-Path: <andrew@lunn.ch>
Date: Fri, 25 Nov 2011 09:18:20 +0100
From: Andrew Lunn <andrew@lunn.ch>
Message-ID: <20111125081820.GD6836@lunn.ch>
References: <1322173279-18338-1-git-send-email-ordex@autistici.org>
	<1322173279-18338-2-git-send-email-ordex@autistici.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1322173279-18338-2-git-send-email-ordex@autistici.org>
Subject: Re: [B.A.T.M.A.N.] [PATCHv4 1/7] batman-adv: implement an helper
 function to forge unicast packets
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

On Thu, Nov 24, 2011 at 11:21:13PM +0100, Antonio Quartulli wrote:
> A new function named prepare_unicast_packet() has been implemented so that it can
> do all the needed operations to set up a skb for unicast sending. It is general
> enough to be used in every context. Helpful for later developments
> 
> Signed-off-by: Antonio Quartulli <ordex@autistici.org>
> ---
>  unicast.c |   36 ++++++++++++++++++++++++------------
>  unicast.h |    1 +
>  2 files changed, 25 insertions(+), 12 deletions(-)
> 
> diff --git a/unicast.c b/unicast.c
> index 6f3c659..d49f2cc 100644
> --- a/unicast.c
> +++ b/unicast.c
> @@ -283,6 +283,29 @@ out:
>  	return ret;
>  }
>  
> +bool prepare_unicast_packet(struct sk_buff *skb, struct orig_node *orig_node)
> +{
> +	struct unicast_packet *unicast_packet;
> +
> +	if (my_skb_head_push(skb, sizeof(*unicast_packet)) < 0)
> +		return false;
> +
> +	unicast_packet = (struct unicast_packet *)skb->data;
> +
> +	unicast_packet->header.version = COMPAT_VERSION;
> +	/* batman packet type: unicast */
> +	unicast_packet->header.packet_type = BAT_UNICAST;
> +	/* set unicast ttl */
> +	unicast_packet->header.ttl = TTL;

When Sven added this header structure, did he also add a function to
fill it in?

     Andrew
