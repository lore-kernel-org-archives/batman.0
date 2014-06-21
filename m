Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Sat, 21 Jun 2014 16:57:42 +0200
References: <1402650950-5886-1-git-send-email-sw@simonwunderlich.de>
 <2808362.GMTcl9ijMO@diderot>
In-Reply-To: <2808362.GMTcl9ijMO@diderot>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <201406211657.42780.sw@simonwunderlich.de>
Subject: Re: [B.A.T.M.A.N.] [PATCHv2] batman-adv: drop QinQ claim frames in
	bridge loop avoidance
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Marek Lindner <mareklindner@neomailbox.ch>

> On Friday 13 June 2014 11:15:50 Simon Wunderlich wrote:
> > +/**
> > + * batadv_is_encapsulated_claim - checks if a claim frame is
> > encapsulated + * @bat_priv: the bat priv with all the soft interface
> > information + * @skb: skb to be checked
> > + *
> > + * Check if this frame is a claim frame encapsulated in at least two
> > layers + * of VLANs.
> 
> Maybe you mention QinQ here ? 'Two layers of VLANs' isn't that obvious
> (without the commit message).

OK, sure.

> 
> > + * Returns 1 if this is an encapsulated claim frame, 0 otherwise.
> 
> Boolean functions should return bool instead of 0 / 1.

OK.

> 
> > +	 * At this point it is known that the first two protocols
> > +	 * are VLAN headers, so start checking at the encapsulated protocol
> > +	 * of the second header.
> 
> The first two protocols ? Are you trying to say that at this point we
> already know we are having QinQ ?
> 

Yep. I can make that more clear.

> > +	 */
> > +	headlen = VLAN_ETH_HLEN;
> > +	do {
> > +		vhdr_ptr = skb_header_pointer(skb, headlen, VLAN_HLEN, &vhdr);
> > +		if (!vhdr_ptr)
> > +			return 0;
> > +
> > +		headlen += VLAN_HLEN;
> > +	} while (vhdr_ptr->h_vlan_encapsulated_proto == htons(ETH_P_8021Q));
> 
> Is there a length check somewhere in skb_header_pointer() ? We wouldn't
> want to read more than we have in the skb, right ?
> 

Yes, skb_header_pointer (or also skb_copy_bits() which is called by that) 
checks the length, so we don't have to do that on our own.

> > +	if (vhdr_ptr->h_vlan_encapsulated_proto != htons(ETH_P_ARP))
> > +		return 0;
> > +
> > +	if (unlikely(!pskb_may_pull(skb, headlen + arp_hdr_len(skb->dev))))
> > +		return 0;
> > +
> > +	/* pskb_may_pull() may have modified the pointers, get ethhdr again */
> > +	ethhdr = eth_hdr(skb);
> > +	arphdr = (struct arphdr *)((uint8_t *)ethhdr + headlen);
> > +
> > +	/* Check whether the ARP frame carries a valid IP information */
> > +	if (arphdr->ar_hrd != htons(ARPHRD_ETHER))
> > +		return 0;
> > +	if (arphdr->ar_pro != htons(ETH_P_IP))
> > +		return 0;
> > +	if (arphdr->ar_hln != ETH_ALEN)
> > +		return 0;
> > +	if (arphdr->ar_pln != 4)
> > +		return 0;
> > +
> > +	hw_src = (uint8_t *)arphdr + sizeof(struct arphdr);
> > +	hw_dst = hw_src + ETH_ALEN + 4;
> > +	bla_dst = (struct batadv_bla_claim_dst *)hw_dst;
> > +	bla_dst_own = &bat_priv->bla.claim_dest;
> 
> Looks like copy & paste from batadv_bla_process_claim() ? How about using a
> shared function ?

Yeah, it's copy and pasted. The only thing which we could put into a common 
function are the 4 checks, the local variables are used in a different way for 
the further code in each function. This didn't really look worth it so I 
didn't bother to refactor in that patch, if you feel otherwise let me know and 
i'll refactor in v2.

Thanks!
    Simon

