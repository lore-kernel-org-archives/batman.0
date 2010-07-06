Return-Path: <andrew@lunn.ch>
Date: Tue, 6 Jul 2010 19:07:37 +0200
From: Andrew Lunn <andrew@lunn.ch>
Message-ID: <20100706170737.GA18453@lunn.ch>
References: <20100706175814.6927f767@rechenknecht>
	<1278431960-4636-2-git-send-email-an.langer@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1278431960-4636-2-git-send-email-an.langer@gmx.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH 2/2] batman-adv: layer2 unicast packet
 fragmentation
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

> +struct frag_packet_list_entry *search_frag_packet(struct list_head *head,
> +	struct unicast_frag_packet *up) {
> +
> +	struct frag_packet_list_entry *tfp;
> +	struct unicast_frag_packet *tmp_up = NULL;
> +
> +	list_for_each_entry(tfp, head, list) {
> +
> +		if (!tfp->skb)
> +			continue;
> +
> +		if (tfp->seqno == ntohs(up->seqno))
> +			goto mov_tail;

Please could you explain this last bit? If we have received a
retransmit we move it to the tail of the list?

> +
> +		tmp_up = (struct unicast_frag_packet *) tfp->skb->data;
> +
> +		if (up->flags & UNI_FRAG_HEAD) {
> +
> +			if (tfp->seqno == ntohs(up->seqno)+1) {
> +				if (tmp_up->flags & UNI_FRAG_HEAD)
> +					goto mov_tail;
> +				else
> +					goto ret_tfp;
> +			}
> +		} else {
> +
> +			if (tfp->seqno == ntohs(up->seqno)-1) {
> +				if (tmp_up->flags & UNI_FRAG_HEAD)
> +					goto ret_tfp;
> +				else
> +					goto mov_tail;
> +			}
> +		}

How about simplifying this loop a little. Not tested, probably broken,
but i hope expresses the idea:

	if (up->flags & UNI_FRAG_HEAD) {
	      search_seqno = ntohs(up->seqno)+1
	} else {
	      search_seqno = ntohs(up->seqno)-1
	}
    
	list_for_each_entry(tfp, head, list) {
		if (!tfp->skb)
			continue;
		
		/* Found the other fragment? */
		if (tfp->seqno == search_seqno)
		    /* Head and a tail? */
		    if ((tmp_up->flags & UNI_FRAG_HEAD) != 
 		        (tfp->flags & UNI_FRAG_HEAD)
		       return tfp;
		    } else {
		      /* Two heads or tails. Move to tail of list so it will 
		         get recycled */
		      list_move_tail(&tfp->list, head);
		      return NULL;
                    }
        }
	return NULL;

Moving the ntohs() out of the loop should save a few cycles and it is
hopefully a little bit more readable.

> +	}
> +	goto ret_null;
> +
> +ret_tfp:
> +	return tfp;
> +mov_tail:
> +	list_move_tail(&tfp->list, head);
> +ret_null:
> +	return NULL;

Assuming you don't like my re-write, could we remove ret_tfp and
ret_null. I don't think they aid the understandability of the
code. They are just return statements.

> +}
> +
> +void frag_list_free(struct list_head *head)
> +{
> +
> +	struct frag_packet_list_entry *pf, *tmp_pf;
> +
> +	if (!list_empty(head)) {
> +
> +		list_for_each_entry_safe(pf, tmp_pf, head, list) {
> +			if (pf->skb)
> +				kfree_skb(pf->skb);

kfree_skb() is happy to take a NULL pointer. So there is no need to do
the comparison here. It will get repeated inside kfree_skb(). This
happens in a few places.

> +			list_del(&pf->list);
> +			kfree(pf);
> +		}
> +	}
> +	return;


> +int recv_unicast_packet(struct sk_buff *skb, struct batman_if *recv_if)
> +{
> +	struct unicast_packet *unicast_packet;
> +	struct ethhdr *ethhdr;
> +	int hdr_size = sizeof(struct unicast_packet);
> +
> +	/* drop packet if it has not necessary minimum size */
> +	if (skb_headlen(skb) < hdr_size)
> +		return NET_RX_DROP;
> +
> +	ethhdr = (struct ethhdr *) skb_mac_header(skb);
> +
> +	/* packet with unicast indication but broadcast recipient */
> +	if (is_bcast(ethhdr->h_dest))
> +		return NET_RX_DROP;
> +
> +	/* packet with broadcast sender address */
> +	if (is_bcast(ethhdr->h_source))
> +		return NET_RX_DROP;
> +
> +	/* not for me */
> +	if (!is_my_mac(ethhdr->h_dest))
> +		return NET_RX_DROP;
> +
> +	unicast_packet = (struct unicast_packet *) skb->data;
> +
> +	/* packet for me */
> +	if (is_my_mac(unicast_packet->dest)) {
> +		interface_rx(skb, hdr_size);
> +		return NET_RX_SUCCESS;
> +	}
> +
> +	return route_unicast_packet(skb, recv_if, hdr_size);
> +}
> +
> +int recv_ucast_frag_packet(struct sk_buff *skb, struct batman_if *recv_if)
> +{
> +	struct unicast_frag_packet *unicast_packet;
> +	struct orig_node *orig_node;
> +	struct ethhdr *ethhdr;
> +	struct frag_packet_list_entry *tmp_frag_entry;
> +	int hdr_size = sizeof(struct unicast_frag_packet);
> +	unsigned long flags;
> +
> +	/* drop packet if it has not necessary minimum size */
> +	if (skb_headlen(skb) < hdr_size)
> +		return NET_RX_DROP;
> +
> +	ethhdr = (struct ethhdr *) skb_mac_header(skb);
> +
> +	/* packet with unicast indication but broadcast recipient */
> +	if (is_bcast(ethhdr->h_dest))
> +		return NET_RX_DROP;
> +
> +	/* packet with broadcast sender address */
> +	if (is_bcast(ethhdr->h_source))
> +		return NET_RX_DROP;
> +
> +	/* not for me */
> +	if (!is_my_mac(ethhdr->h_dest))
> +		return NET_RX_DROP;
> +

There is some code here which is identical to
recv_unicast_packet(). Could it be refactored into a helper function?


       Andrew
