Return-Path: <andrew@lunn.ch>
Date: Fri, 23 Mar 2012 21:52:12 +0100
From: Andrew Lunn <andrew@lunn.ch>
Message-ID: <20120323205212.GF5662@lunn.ch>
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

> +/* extract my own tq to neighbor from the elp packet */
> +static uint8_t bat_v_elp_fetch_tq(uint8_t *my_iface_addr,
> +				  struct batman_elp_packet *elp_packet,
> +				  int elp_packet_len)
> +{
> +	struct elp_neigh_entry *elp_neigh_entry;
> +	uint8_t tq = 0;
> +	int i;
> +
> +	elp_neigh_entry = (struct elp_neigh_entry *)(elp_packet + 1);
> +	elp_packet_len -= BATMAN_ELP_HLEN;
> +
> +	for (i = 0; i < elp_packet->num_neighbors; i++) {
> +		if (!compare_eth(my_iface_addr, elp_neigh_entry->addr))
> +			goto next;
> +
> +		tq = elp_neigh_entry->rq;
> +		break;
> +
> +	next:
> +		elp_packet_len -= sizeof(struct elp_neigh_entry);
> +		if (elp_packet_len < 0)
> +			break;
> +
> +		elp_neigh_entry++;
> +	}

Hi Marek

I'm personally not a fan of using goto like this. Reminds me of BASIC.

Could this be changed? Maybe first validate elp_packet->num_neighbors
matches the packet length, and then skip elp_packet_len check in each
iteration of the loop. A normal if then else should then be possible.

  Thanks
	Andrew	  
