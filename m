Return-Path: <andrew@lunn.ch>
Date: Thu, 5 Jul 2012 19:56:26 +0200
From: Andrew Lunn <andrew@lunn.ch>
Message-ID: <20120705175626.GA16368@lunn.ch>
References: <1341508969-22984-1-git-send-email-ordex@autistici.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1341508969-22984-1-git-send-email-ordex@autistici.org>
Subject: Re: [B.A.T.M.A.N.] [RFC] batman-adv: create a unique entry point
 for unicast packets
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

On Thu, Jul 05, 2012 at 07:22:49PM +0200, Antonio Quartulli wrote:
> Right now in batman-adv we have several unicast packets 'subtypes' (UNICAST,
> UNICAST_FRAG, TT_QUERY and ROAM_ADV) that in the initial part of the rx path
> need the same treatment (e.g. size check, destination check, is_for_me? check,
> etc.).
> 
> For this reason we would like to propose to unify the rx paths in this early
> stage. This change would reduce code duplication and avoid introducing bugs
> (e.g. it is easy to add a check for the TT_QUERY and forget to do the same for
> the UNICAST packet).
> 
> It could be the case that to better address this issue we would need to slightly
> redesign packet format. So we would probably need to wait until the next (and
> hopefully last needed) compatibility breakage.
> 
> But for now you get this a proposal :-)
> 
> Reported-by: Martin Hundeb??ll <martin@hundeboll.net>
> Reported-by: Marek Lindner <lindner_marek@yahoo.de>
> Signed-off-by: Antonio Quartulli <ordex@autistici.org>
> ---
>  main.c    |   17 +++++++++-----
>  routing.c |   74 ++++++++++++++++++++++++++++++++-----------------------------
>  routing.h |   10 ++-------
>  3 files changed, 52 insertions(+), 49 deletions(-)
> 
> diff --git a/main.c b/main.c
> index 13c88b2..da1b728 100644
> --- a/main.c
> +++ b/main.c
> @@ -277,18 +277,23 @@ static void batadv_recv_handler_init(void)
>  
>  	/* batman icmp packet */
>  	batadv_rx_handler[BATADV_ICMP] = batadv_recv_icmp_packet;
> -	/* unicast packet */
> -	batadv_rx_handler[BATADV_UNICAST] = batadv_recv_unicast_packet;
> -	/* fragmented unicast packet */
> -	batadv_rx_handler[BATADV_UNICAST_FRAG] = batadv_recv_ucast_frag_packet;
>  	/* broadcast packet */
>  	batadv_rx_handler[BATADV_BCAST] = batadv_recv_bcast_packet;
>  	/* vis packet */
>  	batadv_rx_handler[BATADV_VIS] = batadv_recv_vis_packet;
> +
> +	/* all the unicast packets have now a single entry point that will make
> +	 * all the common checks on the packets. It will then invoke the proper
> +	 * parser function based on the real packet type
> +	 */
> +	/* unicast packet */
> +	batadv_rx_handler[BATADV_UNICAST] = batadv_recv_generic_unicast;
> +	/* fragmented unicast packet */
> +	batadv_rx_handler[BATADV_UNICAST_FRAG] = batadv_recv_generic_unicast;
>  	/* Translation table query (request or response) */
> -	batadv_rx_handler[BATADV_TT_QUERY] = batadv_recv_tt_query;
> +	batadv_rx_handler[BATADV_TT_QUERY] = batadv_recv_generic_unicast;
>  	/* Roaming advertisement */
> -	batadv_rx_handler[BATADV_ROAM_ADV] = batadv_recv_roam_adv;
> +	batadv_rx_handler[BATADV_ROAM_ADV] = batadv_recv_generic_unicast;

Hi Antonio

I think it is a shame to throw away table based dispatching of frames
by message type to handler functions. How about extending
batadv_rx_handler to have two function pointers per packet type.

struct batadv_rx_handler {
       bool (*void validate)(struct sk_buff *, struct batadv_hard_iface *);
       int (*void handle)(struct sk_buff *, struct batadv_hard_iface *);  
}


Only call the handle function if the validation function returns true.

You can then have one shared validation function for unicast packets.

    Andrew
