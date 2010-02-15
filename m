Return-Path: <andrew@lunn.ch>
Date: Mon, 15 Feb 2010 17:22:58 +0100
From: Andrew Lunn <andrew@lunn.ch>
Message-ID: <20100215162258.GL2900@lunn.ch>
References: <4B796833.2050205@tiwoc.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4B796833.2050205@tiwoc.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH v2] batman-adv: Record route for ICMP
 messages
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

> +#define BAT_RR_LEN 96
> +
> +/* icmp_packet_rr must start with all fields from imcp_packet
> +   as this is assumed by code that handles ICMP packets */
> +struct icmp_packet_rr {
> +	uint8_t  packet_type;
> +	uint8_t  version;  /* batman version field */
> +	uint8_t  msg_type; /* see ICMP message types above */
> +	uint8_t  ttl;
> +	uint8_t  dst[6];
> +	uint8_t  orig[6];
> +	uint16_t seqno;
> +	uint8_t  uid;
> +	uint8_t  rr_cur;
> +	uint8_t  rr[BAT_RR_LEN];

This might be more readable as

 uint8_t rr[BAT_RR_ENTRIES][ETH_ALEN];

and then your memcpy becomes

/* add record route information if not full */
if (icmp_packet->rr_cur < BAT_RR_ENTRIES) {
	memcpy(icmp_packet->rr[icmp_packet->rr_cur++],
		ethhdr->h_dest, ETH_ALEN);
}

while looks nicer.    

> +} __attribute__((packed));


>  ssize_t bat_device_write(struct file *file, const char __user *buff,
> @@ -206,28 +210,42 @@
>  {
>  	struct device_client *device_client =
>  		(struct device_client *)file->private_data;
> -	struct icmp_packet icmp_packet;
> +	struct icmp_packet_rr icmp_packet;
>  	struct orig_node *orig_node;
>  	struct batman_if *batman_if;
>  	uint8_t dstaddr[ETH_ALEN];
>  	unsigned long flags;
> +	size_t packet_len = sizeof(struct icmp_packet);
> +	int with_rr = 0;
> 
>  	if (len < sizeof(struct icmp_packet)) {
>  		bat_dbg(DBG_BATMAN, "batman-adv:Error - can't send packet from char device: invalid packet size\n");
>  		return -EINVAL;
>  	}
> 
> -	if (!access_ok(VERIFY_READ, buff, sizeof(struct icmp_packet)))
> +	if (len >= sizeof(struct icmp_packet_rr)) {

At first look, this looks wrong. I would of expected icmp_packet, not
icmp_packet_rr. But maybe it is right?


>  int recv_icmp_packet(struct sk_buff *skb)
>  {
> -	struct icmp_packet *icmp_packet;
> +	struct icmp_packet_rr *icmp_packet;
>  	struct ethhdr *ethhdr;
>  	struct orig_node *orig_node;
>  	struct sk_buff *skb_old;
> @@ -860,8 +868,24 @@
>  	if (!is_my_mac(ethhdr->h_dest))
>  		return NET_RX_DROP;
> 
> -	icmp_packet = (struct icmp_packet *) skb->data;
> +	icmp_packet = (struct icmp_packet_rr *) skb->data;
> 
> +	if (icmp_packet->packet_type == BAT_ICMP_RR) {
> +		hdr_size = sizeof(struct icmp_packet_rr);
> +
> +		/* drop packet if it has not necessary minimum size */
> +		if (skb_headlen(skb) < hdr_size)
> +			return NET_RX_DROP;
> +
> +		/* add record route information if not full */
> +		if (icmp_packet->rr_cur > 0
> +			&& icmp_packet->rr_cur < BAT_RR_LEN / ETH_ALEN) {
> +			memcpy(&(icmp_packet->rr[icmp_packet->rr_cur * ETH_ALEN]),
> +				ethhdr->h_dest, ETH_ALEN);

Why rr_cur > 0?

    Andrew
