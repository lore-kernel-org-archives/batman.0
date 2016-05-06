Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Fri, 06 May 2016 12:43:25 +0200
Message-ID: <5062590.3XvjaM2H77@sven-edge>
In-Reply-To: <1462525107-19750-5-git-send-email-apape@phoenixcontact.com>
References: <1462525107-19750-1-git-send-email-apape@phoenixcontact.com>
 <1462525107-19750-5-git-send-email-apape@phoenixcontact.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart9752137.0PXCWHUaFq";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCHv3 4/6] batman-adv: drop unicast packets
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

--nextPart9752137.0PXCWHUaFq
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Friday 06 May 2016 10:58:25 Andreas Pape wrote:
[...]
> +		/* If this is a unicast packet from another backgone gw,
> +		 * drop it.
> +		 */
> +		orig_addr = ethhdr->h_source;
> +		orig_node = batadv_orig_hash_find(bat_priv, orig_addr);

I think we already told this before: This is overwriting the previous
orig_node without freeing the reference. It most likely has also other weird
consequences. Here is the relevant code to better understand what it
overwrites:

		if (is4addr) {
			subtype = unicast_4addr_packet->subtype;
			batadv_dat_inc_counter(bat_priv, subtype);

			/* Only payload data should be considered for speedy
			 * join. For example, DAT also uses unicast 4addr
			 * types, but those packets should not be considered
			 * for speedy join, since the clients do not actually
			 * reside at the sending originator.
			 */
			if (subtype == BATADV_P_DATA) {
				orig_addr = unicast_4addr_packet->src;
				orig_node = batadv_orig_hash_find(bat_priv,
								  orig_addr);
			}
		}

		/* If this is a unicast packet from another backgone gw,
		 * drop it.
		 */
		orig_addr = ethhdr->h_source;
		orig_node = batadv_orig_hash_find(bat_priv, orig_addr);
		if (orig_node &&
		    batadv_bla_is_backbone_gw(skb, orig_node, hdr_size)) {
			batadv_dbg(BATADV_DBG_BLA, bat_priv,
				   "recv_unicast_packet(): Dropped unicast pkt received from another backbone gw %pM.\n",
				   orig_addr);
			batadv_orig_node_put(orig_node);
			return NET_RX_DROP;
		}

Kind regards,
	Sven
--nextPart9752137.0PXCWHUaFq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJXLHVNAAoJEF2HCgfBJntGsTkP/j0TDroCQBmnE4dUjjx7Oyrw
ayZ2kfydTnqYu+RcAg1OIyxT5oo/7uN5pligErSxDnzPrxuqjqQh4usFWjyhJr/6
zTVZZrX23KYw05R431F1g1UijOpRwQIpHj1HStqfnwSolIHnr2zvS2gYBD7prPPk
vLOoEHpdtjdi7dM4jwm8T+tqCzzJ+pg5gVPv1Z4hLQkVyun0jsCRzx2/q+ln8eoX
rVR1yooawzpDWK1Ng2BixZXdxBy9uK4nK7ZQplw1yoINRM3Dwm+H7a4/ApXSmK+9
DEhNsS5skP5/g55o+8Y4ipERK2RSBX/C89iTssWVFBxOryp2qrXlWYMEWl9F5b5w
rTGiqZFzwoVqBzh/E/J+OeNmS4AYI2Sd2w9rD4Nc7B+sHMG1fwom2xySdDzPlVrN
F+Od8BHZFknX/xyVpsoOlE/YBlXiScR3ah9UYlMqnXJYZlHujSPYl5tAdBpfJ7za
D4Kv0V+daN/EyTOmRcfMy5WCc3S/1RR6TpsgJsgL+w/Gz/+lhcSvprCyj2cnzQcS
NFDmilf0bkUcyxNv20qn1o8mCkjCfzl2f+R2RNtxrqWshP4qK/RzZAeFFb6mY79i
p+TQQLqVMp6Fk97pYLybLDOsPxShpgw4LNhGgrAFAzJ0JrgQ/eX5A2cCld7sRy3v
N6hU0zP8UVDKx0W5k5bw
=qD7X
-----END PGP SIGNATURE-----

--nextPart9752137.0PXCWHUaFq--

