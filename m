Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Sat, 21 Jun 2014 20:50:12 +0800
Message-ID: <2808362.GMTcl9ijMO@diderot>
In-Reply-To: <1402650950-5886-1-git-send-email-sw@simonwunderlich.de>
References: <1402650950-5886-1-git-send-email-sw@simonwunderlich.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3134140.ejvnWDRlYi";
 micalg="pgp-sha1"; protocol="application/pgp-signature"
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
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>


--nextPart3134140.ejvnWDRlYi
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Friday 13 June 2014 11:15:50 Simon Wunderlich wrote:
> +/**
> + * batadv_is_encapsulated_claim - checks if a claim frame is encapsulated
> + * @bat_priv: the bat priv with all the soft interface information
> + * @skb: skb to be checked
> + *
> + * Check if this frame is a claim frame encapsulated in at least two layers
> + * of VLANs.

Maybe you mention QinQ here ? 'Two layers of VLANs' isn't that obvious 
(without the commit message).


> + * Returns 1 if this is an encapsulated claim frame, 0 otherwise.

Boolean functions should return bool instead of 0 / 1.


> +	 * At this point it is known that the first two protocols
> +	 * are VLAN headers, so start checking at the encapsulated protocol
> +	 * of the second header.

The first two protocols ? Are you trying to say that at this point we already 
know we are having QinQ ?


> +	 */
> +	headlen = VLAN_ETH_HLEN;
> +	do {
> +		vhdr_ptr = skb_header_pointer(skb, headlen, VLAN_HLEN, &vhdr);
> +		if (!vhdr_ptr)
> +			return 0;
> +
> +		headlen += VLAN_HLEN;
> +	} while (vhdr_ptr->h_vlan_encapsulated_proto == htons(ETH_P_8021Q));

Is there a length check somewhere in skb_header_pointer() ? We wouldn't want 
to read more than we have in the skb, right ?


> +	if (vhdr_ptr->h_vlan_encapsulated_proto != htons(ETH_P_ARP))
> +		return 0;
> +
> +	if (unlikely(!pskb_may_pull(skb, headlen + arp_hdr_len(skb->dev))))
> +		return 0;
> +
> +	/* pskb_may_pull() may have modified the pointers, get ethhdr again */
> +	ethhdr = eth_hdr(skb);
> +	arphdr = (struct arphdr *)((uint8_t *)ethhdr + headlen);
> +
> +	/* Check whether the ARP frame carries a valid IP information */
> +	if (arphdr->ar_hrd != htons(ARPHRD_ETHER))
> +		return 0;
> +	if (arphdr->ar_pro != htons(ETH_P_IP))
> +		return 0;
> +	if (arphdr->ar_hln != ETH_ALEN)
> +		return 0;
> +	if (arphdr->ar_pln != 4)
> +		return 0;
> +
> +	hw_src = (uint8_t *)arphdr + sizeof(struct arphdr);
> +	hw_dst = hw_src + ETH_ALEN + 4;
> +	bla_dst = (struct batadv_bla_claim_dst *)hw_dst;
> +	bla_dst_own = &bat_priv->bla.claim_dest;

Looks like copy & paste from batadv_bla_process_claim() ? How about using a 
shared function ?

Cheers,
Marek

--nextPart3134140.ejvnWDRlYi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABAgAGBQJTpX+IAAoJEFNVTo/uthzAqhMH/jVIqheB0rbSbAfyKRBh5zHZ
j/ObuhCHFfztvnsvnOYYkjUS55Y/dlzTjPz24EdEwW9skk76rCAM99dYsbUZ+dYc
qRc4E105GBFgDBi+c2JiXN+VyV/BchXaPV4KExW2zBFk0vmAYsNL6j1rqehNU+BW
BfamOj6YYISmLDAqEhJ489DnBmQdB7+V2KVJL4YJEit5gAAhRRwSHbMyk0Rh21q8
eg+V4WHQ8R9yQxU5ofMtI4CwiMERFqAlfPr1X5t6XwdmEmEinJxw0rjyc6TtNQDz
5Lxrx5IPdBhFgKgMiOzBngLgy7bYHC8kQKIxTrIgcoEWE4brFCpiC9/KeTvo2Bg=
=mgBA
-----END PGP SIGNATURE-----

--nextPart3134140.ejvnWDRlYi--

