Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Fri, 26 Feb 2016 17:03:26 +0100
Message-ID: <1642814.nAlCBA5LKq@bentobox>
In-Reply-To: <1456492719-29748-1-git-send-email-apape@phoenixcontact.com>
References: <1456492719-29748-1-git-send-email-apape@phoenixcontact.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1550813.LVfQzPkoiZ";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCHv2 3/7] batman-adv: prevent duplication of
	ARP replies when DAT is used
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

--nextPart1550813.LVfQzPkoiZ
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Friday 26 February 2016 14:18:39 Andreas Pape wrote:
>  	dat_entry = batadv_dat_entry_hash_find(bat_priv, ip_dst, vid);
> -	if (!dat_entry)
> +	if (!dat_entry) {
> +		/* Check if this is a 4addr unicast DAT_DHT_GET frame from
> +		 * another backbone gw of the same backbone. If yes, drop
> +		 * it as this leads to multiplication of arp requests in bla
> +		 * setups as long as there is no dat_entry fo this answer.
> +		 * In this case better drop the DHT_GET. Normal bla code
> +		 * doesn't take care of these packets as they are tunneled
> +		 * via unicast.
> +		 */
> +		unicast_4addr_packet =
> +				(struct batadv_unicast_4addr_packet *)skb->data;
> +		orig_node =
> +			batadv_orig_hash_find(bat_priv,
> +					      unicast_4addr_packet->src);
> +		if (orig_node) {
> +			if ((unicast_4addr_packet->u.packet_type ==
> +			     BATADV_UNICAST_4ADDR) &&
> +			     (unicast_4addr_packet->subtype ==
> +			      BATADV_P_DAT_DHT_GET) &&
> +			     (batadv_bla_is_backbone_gw(skb, orig_node,
> +							hdr_size))) {
> +				batadv_dbg(BATADV_DBG_DAT, bat_priv, "Doubled ARP request removed: ARP MSG = [src: %pM-%pI4 dst: %pM-%pI4]; originator: %pM\n",
> +					   hw_src, &ip_src,
> +					   batadv_arp_hw_dst(skb, hdr_size),
> +					   &ip_dst, unicast_4addr_packet->src);
> +				ret = true;
> +			}
> +			batadv_orig_node_put(orig_node);
> +		}
> +
>  		goto out;
> +	}

This looks really squashed. Maybe this stuff can be moved in a separate
function.

Kind regards,
	Sven
--nextPart1550813.LVfQzPkoiZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJW0HdOAAoJEF2HCgfBJntGPAgQALsAWv7pXtF7Ak+N6NApVkjM
xdc8TTj2uehgwgGnl4XxiPG+I4iqGxFKZteCDCOlkSvUX7dguCO1Iu5Jo7Pn/TBY
tcPMKwoEySEptA7K5598m6LQxcv2JKrc4xNJ32uUKVR9r4LXeT3t0yD77f8HYeEV
9SyxVnDRPkqQg+u2NYXHnPZJEHqQ5kDuozZzNfd6khIJp3IoXYnqOhzNPTiqYEyk
Si+mgvSiV1zfyOJKHD6YHu7KBysTBGGhOhBbk1TzSdrj0desG1w7iwBzNZaogD/A
VPA2S3nJVQnhhGqZXpe8g3OeVCWxfDs3YR46LFRpLGz/9oxf6kcLORaRmKXJWNfK
fDVPAAOJtUKHfPk8KSSDXxk7DmjuGj6NZtlcKT6fk//ICTq1P6wIWZ6cZf0Ca0m0
5TzoDPTFRxDcejIV1Lrt2D4FJCDg/ISNsWHRXuVCqfodIu2lWBzZtXR/6beLKoKH
oPrb++7sAcvfvTAoxiyitSxW3T8DOAIt/yB1Ei85KA5/huVYc3BOoS5p+ARAsvQv
d5MKNUPVfiJupXeVWZat6xIJOK1nnExxAJe0xozWrlgEsYxRg73nVD2TvEyQD7aa
OkHj2LRW125WCGd6Qh4mX/rL5uVuO00kyDL0sq4Q0XTEJ2yVaxsTnWRNRgb/QTrf
uL+3zVT0BBUT8Y17vi5b
=GKbM
-----END PGP SIGNATURE-----

--nextPart1550813.LVfQzPkoiZ--

