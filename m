Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Sun, 14 Feb 2010 22:36:43 +0800
References: <4B759F67.5090407@tiwoc.de>
In-Reply-To: <4B759F67.5090407@tiwoc.de>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201002142236.43721.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: Record route for ICMP
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

On Saturday 13 February 2010 02:35:19 Daniel Seither wrote:
> The standard layer 3 ping utility can use the record route option of IP
> to collect route data for sent ping messages (ping -R). This patch
> introduces comparable functionality for batman-adv ICMP messages.
> 
> The patch modifies the batman ICMP packet format such that up to 17 MAC
> addresses can be recorded (sufficient for up to 8 hops per direction).
> batctl is extended to recognize the -R option for the ping subcommand.
> The output should be the same as for the standard iputils ping program.
> For this, the destination host is printed two times.

This is a very cool patch! I know quite some people will be happy to see this 
functionality. :-)


> This patch could be improved by dynamically growing the packet when a
> MAC address is to be added to the recorded route instead of statically
> allocating a buffer of fixed length.

I don't think it will be necessary to change the packet size dynamically. The 
gain will be rather small compared to the overhead it creates. However, it 
would make sense to specify 2 different icmp structs and only send the large 
packet when RR is really needed. 

For example:
struct icmp_packet {
	uint8_t  packet_type;
	uint8_t  version;  /* batman version field */
	uint8_t  msg_type; /* see ICMP message types above */
	uint8_t  ttl;
	uint8_t  dst[6];
	uint8_t  orig[6];
	uint16_t seqno;
	uint8_t  uid;
} __attribute__((packed));

struct icmp_packet_rr {
	uint8_t  packet_type;
	uint8_t  version;  /* batman version field */
	uint8_t  msg_type; /* see ICMP message types above */
	uint8_t  ttl;
	uint8_t  dst[6];
	uint8_t  orig[6];
	uint16_t seqno;
	uint8_t  uid;
        uint8_t  rr_cur;
	uint8_t  rr[BAT_RR_LEN];
} __attribute__((packed));

What do you think?


> +	/* add record route information if not full */
> +	if (icmp_packet->rr_cur && icmp_packet->rr_cur < BAT_RR_LEN / ETH_ALEN) {
> +		memcpy(&(icmp_packet->rr[icmp_packet->rr_cur * ETH_ALEN]),
> ethhdr->h_dest, ETH_ALEN);
> +		icmp_packet->rr_cur++;
> +	}

It would be better to check for the actual packet size rather than the 
BAT_RR_LEN define. Some node might have sent us an icmp packet which had a 
different size and then we crash here (or worse).

Regards,
Marek

