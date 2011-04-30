Return-Path: <andrew@lunn.ch>
Date: Sat, 30 Apr 2011 10:42:26 +0200
From: Andrew Lunn <andrew@lunn.ch>
Message-ID: <20110430084226.GM21883@lunn.ch>
References: <1303940106-1457-1-git-send-email-ordex@autistici.org>
	<1303940106-1457-3-git-send-email-ordex@autistici.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1303940106-1457-3-git-send-email-ordex@autistici.org>
Subject: Re: [B.A.T.M.A.N.] [PATCH 2/4] batman-adv: improved client
 announcement mechanismy
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

On Wed, Apr 27, 2011 at 11:35:04PM +0200, Antonio Quartulli wrote:
> The old HNA mechanism has been totally rewritten from scratch.
> The new mechanism consists in announcing local translation-table changes
> only, reducing the protocol overhead.
 
Hi Antonia

> For details, please visit:
> http://www.open-mesh.org/wiki/batman-adv/Hna-improvements

This is a nice summary of the idea. The LaTeX document is also good.
Great to see documentation...

>  /* is there another aggregated packet here? */
> -static inline int aggregated_packet(int buff_pos, int packet_len, int num_tt)
> +static inline int aggregated_packet(int buff_pos, int packet_len,
> +				    int tt_num_changes)
>  {
> -	int next_buff_pos = buff_pos + BAT_PACKET_LEN + (num_tt * ETH_ALEN);
> +	int next_buff_pos = buff_pos + BAT_PACKET_LEN + (tt_num_changes *
> +						sizeof(struct tt_change));

You indentation/wrapping is a bit strange. In the function
declaration, i would of put the int tt_num_changes directly under int
buff_pos. For next_buff_pos i would of put the whole ( ) subexpression
on the next line, not split it in half. This happens throughout the
patch.

> +#define TT_OGM_APPEND_MAX 3 /* number of OGMs sent with the last tt diff */
> +
> +/* Transtable operations */
> +#define TT_ADD 0
> +#define TT_DEL 1

> +
> +++ b/packet.h
> @@ -30,9 +30,10 @@
>  #define BAT_BCAST        0x04
>  #define BAT_VIS          0x05
>  #define BAT_UNICAST_FRAG 0x06
> +#define BAT_TT_QUERY	 0x07

Indentation?

>  
>  /* this file is included by batctl which needs these defines */
> -#define COMPAT_VERSION 12
> +#define COMPAT_VERSION 14

What happened to version 13? It suggests this diff is against an older
version of batman. Is there going to be merging problems?

> @@ -52,6 +53,11 @@
>  #define UNI_FRAG_HEAD 0x01
>  #define UNI_FRAG_LARGETAIL 0x02
>  
> +/* TT flags */
> +#define TT_RESPONSE	0x00
> +#define TT_REQUEST	0x01
> +#define TT_FULL_TABLE	0x02
> +
> @@ -101,6 +109,7 @@ struct unicast_packet {
>  	uint8_t  version;  /* batman version field */
>  	uint8_t  dest[6];
>  	uint8_t  ttl;
> +	uint8_t  ttvn; /* destination ttvn */
>  } __packed;

What is ttvn? The vn in particular? Is it version? There is already
ver and version used, do we want yet another way to say version?

> @@ -134,4 +143,25 @@ struct vis_packet {
>  	uint8_t  sender_orig[6]; /* who sent or rebroadcasted this packet */
>  } __packed;
>  
> +struct tt_query_packet {
> +	uint8_t  packet_type;
> +	uint8_t  version;  /* batman version field */
> +	uint8_t  dst[6];
> +	uint8_t  ttl;
> +	uint8_t  flags;		/* bit0: 0: -> tt_request
> +				 *	 1: -> tt_response
> +				 * bit1: request the full table
> +				 */

Rather than document the bits, it would be better to reference to the
macros TT_*. Somebody at some time with add new flags, or change the
values and not update this description.


> +	uint8_t  src[6];
> +	uint8_t  ttvn;		/* if tt_request: ttvn that triggered the
> +				 *		  request
> +				 * if tt_response: new ttvn for the src
> +				 * orig_node
> +				 */
> +	uint16_t tt_data;	/* if tt_request: crc associated with the
> +				 *		   ttvn
> +				 * if tt_response: table_size
> +				 */

Maybe a union instead of tt_data being used for two different things?
Makes it less confusing when reading the code.

> diff --git a/routing.c b/routing.c
> index 91b3709..838394b 100644
> --- a/routing.c
> +++ b/routing.c
> @@ -64,28 +64,68 @@ void slide_own_bcast_window(struct hard_iface *hard_iface)
>  	}
>  }
>  
> -static void update_TT(struct bat_priv *bat_priv, struct orig_node *orig_node,
> -		       unsigned char *tt_buff, int tt_buff_len)
> +static void update_transtable(struct bat_priv *bat_priv,
> +			      struct orig_node *orig_node,
> +			      unsigned char *tt_buff, uint8_t tt_num_changes,
> +			      uint8_t ttvn, uint16_t tt_crc)
>  {
> -	if ((tt_buff_len != orig_node->tt_buff_len) ||
> -	    ((tt_buff_len > 0) &&
> -	     (orig_node->tt_buff_len > 0) &&
> -	     (memcmp(orig_node->tt_buff, tt_buff, tt_buff_len) != 0))) {
> -
> -		if (orig_node->tt_buff_len > 0)
> -			tt_global_del_orig(bat_priv, orig_node,
> -					    "originator changed tt");
> -
> -		if ((tt_buff_len > 0) && (tt_buff))
> -			tt_global_add_orig(bat_priv, orig_node,
> -					    tt_buff, tt_buff_len);
> +	struct tt_change *tt_change;
> +	int count;
> +	uint8_t orig_ttvn = (uint8_t)atomic_read(&orig_node->last_tt_ver_num);
> +
> +	/* the ttvn increased by one -> we can apply the attached changes */
> +	if (ttvn - orig_ttvn == 1) {
> +		/* if it does not contain the changes send a tt request */
> +		if (!tt_num_changes)
> +			goto request_table;

Why would that happen? It sounds like you are handling a bug, not
something which is designed to happen. 

> +
> +		for (count = 0; count < tt_num_changes; count++) {
> +			tt_change = (struct tt_change *) tt_buff + count;
> +			/* Check for the change op */
> +			if (tt_change->op == TT_DEL)
> +				tt_global_del(bat_priv, orig_node,
> +					      tt_change->addr,
> +					      "tt remotely removed");
> +			else
> +				if (!tt_global_add(bat_priv, orig_node,
> +							tt_change->addr,
> +							ttvn))
> +					/* In case of problem while storing a
> +					 * global_entry, we stop the updating
> +					 * procedure without committing the
> +					 * ttvn change. This will avoid to send
> +					 * corrupted data on tt_request
> +					 */
> +					return;

Why would an add fail? Because we are out of space? Does it make sense
to have two passes over the changes. The first pass does all the
deletes and the second pass the adds? Does that make it less likely
the add will fail?

Also, the ttvn still has the old value, but some of the new content.
Does this cause problems when somebody makes a request for the ttvn
with the old value? The requester gets something between ttvn and
ttvn+1, but thinks it has ttvn. Can subsequent updates work?

>  	bat_dbg(DBG_BATMAN, bat_priv,
>  		"Received BATMAN packet via NB: %pM, IF: %s [%pM] "
> -		"(from OG: %pM, via prev OG: %pM, seqno %d, tq %d, "
> -		"TTL %d, V %d, IDF %d)\n",
> +		"(from OG: %pM, via prev OG: %pM, seqno %d, ttvn %u, "
> +		"crc %u, changes %u, td %d, TTL %d, V %d, IDF %d)\n",
>  		ethhdr->h_source, if_incoming->net_dev->name,
>  		if_incoming->net_dev->dev_addr, batman_packet->orig,
>  		batman_packet->prev_sender, batman_packet->seqno,
> -		batman_packet->tq, batman_packet->ttl, batman_packet->version,
> +		batman_packet->tt_ver_num, batman_packet->tt_crc,
> +		batman_packet->tt_num_changes, batman_packet->tq,
> +		batman_packet->ttl, batman_packet->version,
>  		has_directlink_flag);

I think this is the information bisect uses to look for routing loops
etc. Do you plan to extend bisect to look for TT problems? Does it
make sense to add a new DBG_TT which dumps the adds and removes in the
OGM?
  
> +int recv_tt_query(struct sk_buff *skb, struct hard_iface *recv_if)
> +{
> +	struct bat_priv *bat_priv = netdev_priv(recv_if->soft_iface);
> +	struct tt_query_packet *tt_query;
> +	struct ethhdr *ethhdr;
> +	int ret = NET_RX_DROP;
> +
> +	/* drop packet if it has not necessary minimum size */
> +	if (unlikely(!pskb_may_pull(skb, sizeof(struct tt_query_packet))))
> +		goto out;
> +
> +	/* I could need to modify it */
> +	if (skb_cow(skb, sizeof(struct tt_query_packet)) < 0)
> +		goto out;
> +
> +	ethhdr = (struct ethhdr *)skb_mac_header(skb);
> +
> +	/* packet with unicast indication but broadcast recipient */
> +	if (is_broadcast_ether_addr(ethhdr->h_dest))
> +		goto out;
> +
> +	/* packet with broadcast sender address */
> +	if (is_broadcast_ether_addr(ethhdr->h_source))
> +		goto out;
> +
> +	tt_query = (struct tt_query_packet *)skb->data;
> +
> +	tt_query->tt_data = ntohs(tt_query->tt_data);
> +
> +	if (tt_query->flags & TT_REQUEST) {
> +		/* Try to reply to this tt_request */
> +		ret = send_tt_response(bat_priv, tt_query);
> +		if (ret != NET_RX_SUCCESS) {

This looks wrong. The name send_tt_response() suggests we are sending,
but you compare against NET_RX_SUCCESS!

> +			bat_dbg(DBG_ROUTES, bat_priv,
> +				"Routing TT_REQUEST to %pM [%c]\n",
> +				tt_query->dst,
> +				(tt_query->flags & TT_FULL_TABLE ? 'F' : '.'));
> +			tt_query->tt_data = htons(tt_query->tt_data);
> +			return route_unicast_packet(skb, recv_if);
> +		}
> +		goto out;
> +	}
> +	/* We need to linearize the packet to access the TT data */
> +	if (skb_linearize(skb) < 0)
> +		goto out;

Isn't this too late. You have already accessed tt_query->tt_data in
the code above?

> +	diff = unicast_packet->ttvn - curr_ttvn;
> +	/* Check whether I have to reroute the packet */
> +	if (unicast_packet->packet_type == BAT_UNICAST &&
> +	    (diff < 0 && diff > -0xff/2)) {

Are there no helper methods to do this wrap around comparison in one
of the linux header files?

   Andrew
