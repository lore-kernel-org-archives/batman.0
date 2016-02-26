Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Fri, 26 Feb 2016 17:07:20 +0100
Message-ID: <6115028.oRNdbbxa5J@bentobox>
In-Reply-To: <1456492734-29785-1-git-send-email-apape@phoenixcontact.com>
References: <1456492734-29785-1-git-send-email-apape@phoenixcontact.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1927291.ppy6bNGlCC";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCHv2 4/7] batman-adv: drop unicast packets
	from other backbone gw
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

--nextPart1927291.ppy6bNGlCC
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Friday 26 February 2016 14:18:54 Andreas Pape wrote:
> @@ -896,6 +898,19 @@ int batadv_recv_unicast_packet(struct sk_buff *skb,
>  			}
>  		}
> 
> +		/* If this is a unicast packet from another backgone gw,
> +		 * drop it.
> +		 */
> +		orig_addr = ethhdr->h_source;
> +		orig_node = batadv_orig_hash_find(bat_priv, orig_addr);
> +		if (batadv_bla_is_backbone_gw(skb, orig_node, hdr_size)) {
> +			batadv_dbg(BATADV_DBG_BLA, bat_priv,
> +				   "Dropped unicast pkt received from another backbone gw %pM.\n",
> +				   orig_addr);
> +
> +			return NET_RX_DROP;
> +		}
> +

The orig_node was previously assigned via batadv_orig_hash_find. But this 
batadv_orig_hash_find already increased the reference pointer for orig_node. 
So we would now have an imbalance at the end of the function.

Kind regards,
	Sven
--nextPart1927291.ppy6bNGlCC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJW0Hg4AAoJEF2HCgfBJntGTLAQALZiwRSYHprzTPiHgmHRgUUs
77hHlDdj0p5xWwQxkp7Y6rEIBFU1Uuk/L/ctqKVe3RVrTMuLtza/5c3sxCfS82zu
6hhW4JBVexHpzCSujbDWM174UIMcF0b7GUx7bezNVCm5OnwgoWA9NTsF2cQbD+FM
goSlvLCLi3VfcbjzpzIbR8WG/FzxZPQSpDUkgVey9Q6yiwVPIVjXEt2j0vWIFR1Z
G9LXwJiZCFbUFKOC+7oSQmkdfqmVX68Q/ImiUzV/n89EVZsVUhd1eE1KuGuLxH+9
tms0KxYQyBPbLUMIR8ZZBti/IvbmO2bSz0vTirAS+Q2lmsQmopaaWlRU47cVfMO/
/kBVdp+YOF1YAq70lzaw4643MUJi8u1ehVbaNABR84Bh+Kwp5y3+GrmrPIKYNSz+
HC/W1xjHBN17YgVYN1jGUcHTqR8UN9c2Z/G0g1MtFPBIjrY4iJbGxl0dO1uqf1X+
dnDMF/uRt3NrvVIWiT9ANgte9p/lUl/kADamqFtb7eNv6IgkIozjoVVNdC1ocWnd
GQAG21851IM3RnVyOx5SgZbZqXtg3QJw7QyHXdDD7wHbS5nzStl+xXr9+aIGSZ9K
2s3Tc+TpZFfkmaerwAuq53huqvLRXZMgR/cuLkB3E1+QZj8R9R8U6I55gZIhoeT4
F6xK9oasIg9bQth8y6uc
=dBEk
-----END PGP SIGNATURE-----

--nextPart1927291.ppy6bNGlCC--

