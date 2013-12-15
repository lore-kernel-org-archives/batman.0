Return-Path: <antonio@meshcoding.com>
Message-ID: <52ADCCF7.80109@meshcoding.com>
Date: Sun, 15 Dec 2013 16:38:31 +0100
From: Antonio Quartulli <antonio@meshcoding.com>
MIME-Version: 1.0
References: <1386013113-25471-1-git-send-email-sw@simonwunderlich.de>
In-Reply-To: <1386013113-25471-1-git-send-email-sw@simonwunderlich.de>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="Mx3BOIVINhD59dKr2hgg68FPlBsftlO1r"
Subject: Re: [B.A.T.M.A.N.] [PATCH-next 1/4] batman-adv: fix alignment for
 batadv_coded_packet
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
To: Marek Lindner <mareklindner@neomailbox.ch>
Cc: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Mx3BOIVINhD59dKr2hgg68FPlBsftlO1r
Content-Type: multipart/mixed;
 boundary="------------080309050900090005020402"

This is a multi-part message in MIME format.
--------------080309050900090005020402
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Marek,

when merging next into master you will hit a number of conflicts (as you
already realized).
Here you have the diff showing how I solved them.

I hope it can help.


Cheers,


--=20
Antonio Quartulli

--------------080309050900090005020402
Content-Type: text/x-patch;
 name="solve-conflict.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="solve-conflict.patch"

diff --git a/bat_iv_ogm.c b/bat_iv_ogm.c
index f8b9770..aaec261 100644
--- a/bat_iv_ogm.c
+++ b/bat_iv_ogm.c
@@ -484,31 +484,7 @@ static void batadv_iv_ogm_emit(struct batadv_forw_pa=
cket *forw_packet)
 	if (WARN_ON(forw_packet->if_outgoing->soft_iface !=3D soft_iface))
 		goto out;
=20
-<<<<<<< HEAD
 	if (forw_packet->if_incoming->if_status !=3D BATADV_IF_ACTIVE)
-=3D=3D=3D=3D=3D=3D=3D
-	/* multihomed peer assumed
-	 * non-primary OGMs are only broadcasted on their interface
-	 */
-	if ((directlink && (batadv_ogm_packet->ttl =3D=3D 1)) ||
-	    (forw_packet->own && (forw_packet->if_incoming !=3D primary_if))) {=

-		/* FIXME: what about aggregated packets ? */
-		batadv_dbg(BATADV_DBG_BATMAN, bat_priv,
-			   "%s packet (originator %pM, seqno %u, TTL %d) on interface %s [%pM=
]\n",
-			   (forw_packet->own ? "Sending own" : "Forwarding"),
-			   batadv_ogm_packet->orig,
-			   ntohl(batadv_ogm_packet->seqno),
-			   batadv_ogm_packet->ttl,
-			   forw_packet->if_incoming->net_dev->name,
-			   forw_packet->if_incoming->net_dev->dev_addr);
-
-		/* skb is only used once and than forw_packet is free'd */
-		batadv_send_skb_packet(forw_packet->skb,
-				       forw_packet->if_incoming,
-				       batadv_broadcast_addr);
-		forw_packet->skb =3D NULL;
-
->>>>>>> origin/next
 		goto out;
=20
 	primary_if =3D batadv_primary_if_get_selected(bat_priv);
@@ -1067,13 +1043,8 @@ batadv_iv_ogm_orig_update(struct batadv_priv *bat_=
priv,
 	spin_unlock_bh(&neigh_node->ifinfo_lock);
=20
 	if (dup_status =3D=3D BATADV_NO_DUP) {
-<<<<<<< HEAD
-		orig_ifinfo->last_ttl =3D batadv_ogm_packet->header.ttl;
-		neigh_ifinfo->last_ttl =3D batadv_ogm_packet->header.ttl;
-=3D=3D=3D=3D=3D=3D=3D
-		orig_node->last_ttl =3D batadv_ogm_packet->ttl;
-		neigh_node->last_ttl =3D batadv_ogm_packet->ttl;
->>>>>>> origin/next
+		orig_ifinfo->last_ttl =3D batadv_ogm_packet->ttl;
+		neigh_ifinfo->last_ttl =3D batadv_ogm_packet->ttl;
 	}
=20
 	/* if this neighbor already is our next hop there is nothing
@@ -1412,12 +1383,8 @@ batadv_iv_ogm_process_per_outif(const struct sk_bu=
ff *skb, int ogm_offset,
 	/* create a private copy of the skb, as some functions change tq value
 	 * and/or flags.
 	 */
-<<<<<<< HEAD
 	skb_priv =3D skb_copy(skb, GFP_ATOMIC);
 	if (!skb_priv)
-=3D=3D=3D=3D=3D=3D=3D
-	if (batadv_ogm_packet->packet_type !=3D BATADV_IV_OGM)
->>>>>>> origin/next
 		return;
=20
 	ethhdr =3D eth_hdr(skb_priv);
@@ -1428,107 +1395,6 @@ batadv_iv_ogm_process_per_outif(const struct sk_b=
uff *skb, int ogm_offset,
 	if (batadv_compare_eth(ethhdr->h_source, ogm_packet->orig))
 		is_single_hop_neigh =3D true;
=20
-<<<<<<< HEAD
-=3D=3D=3D=3D=3D=3D=3D
-	batadv_dbg(BATADV_DBG_BATMAN, bat_priv,
-		   "Received BATMAN packet via NB: %pM, IF: %s [%pM] (from OG: %pM, vi=
a prev OG: %pM, seqno %u, tq %d, TTL %d, V %d, IDF %d)\n",
-		   ethhdr->h_source, if_incoming->net_dev->name,
-		   if_incoming->net_dev->dev_addr, batadv_ogm_packet->orig,
-		   batadv_ogm_packet->prev_sender,
-		   ntohl(batadv_ogm_packet->seqno), batadv_ogm_packet->tq,
-		   batadv_ogm_packet->ttl,
-		   batadv_ogm_packet->version, has_directlink_flag);
-
-	rcu_read_lock();
-	list_for_each_entry_rcu(hard_iface, &batadv_hardif_list, list) {
-		if (hard_iface->if_status !=3D BATADV_IF_ACTIVE)
-			continue;
-
-		if (hard_iface->soft_iface !=3D if_incoming->soft_iface)
-			continue;
-
-		if (batadv_compare_eth(ethhdr->h_source,
-				       hard_iface->net_dev->dev_addr))
-			is_my_addr =3D 1;
-
-		if (batadv_compare_eth(batadv_ogm_packet->orig,
-				       hard_iface->net_dev->dev_addr))
-			is_my_orig =3D 1;
-
-		if (batadv_compare_eth(batadv_ogm_packet->prev_sender,
-				       hard_iface->net_dev->dev_addr))
-			is_my_oldorig =3D 1;
-	}
-	rcu_read_unlock();
-
-	if (is_my_addr) {
-		batadv_dbg(BATADV_DBG_BATMAN, bat_priv,
-			   "Drop packet: received my own broadcast (sender: %pM)\n",
-			   ethhdr->h_source);
-		return;
-	}
-
-	if (is_my_orig) {
-		unsigned long *word;
-		int offset;
-		int32_t bit_pos;
-		int16_t if_num;
-		uint8_t *weight;
-
-		orig_neigh_node =3D batadv_iv_ogm_orig_get(bat_priv,
-							 ethhdr->h_source);
-		if (!orig_neigh_node)
-			return;
-
-		/* neighbor has to indicate direct link and it has to
-		 * come via the corresponding interface
-		 * save packet seqno for bidirectional check
-		 */
-		if (has_directlink_flag &&
-		    batadv_compare_eth(if_incoming->net_dev->dev_addr,
-				       batadv_ogm_packet->orig)) {
-			if_num =3D if_incoming->if_num;
-			offset =3D if_num * BATADV_NUM_WORDS;
-
-			spin_lock_bh(&orig_neigh_node->bat_iv.ogm_cnt_lock);
-			word =3D &(orig_neigh_node->bat_iv.bcast_own[offset]);
-			bit_pos =3D if_incoming_seqno - 2;
-			bit_pos -=3D ntohl(batadv_ogm_packet->seqno);
-			batadv_set_bit(word, bit_pos);
-			weight =3D &orig_neigh_node->bat_iv.bcast_own_sum[if_num];
-			*weight =3D bitmap_weight(word,
-						BATADV_TQ_LOCAL_WINDOW_SIZE);
-			spin_unlock_bh(&orig_neigh_node->bat_iv.ogm_cnt_lock);
-		}
-
-		batadv_dbg(BATADV_DBG_BATMAN, bat_priv,
-			   "Drop packet: originator packet from myself (via neighbor)\n");
-		batadv_orig_node_free_ref(orig_neigh_node);
-		return;
-	}
-
-	if (is_my_oldorig) {
-		batadv_dbg(BATADV_DBG_BATMAN, bat_priv,
-			   "Drop packet: ignoring all rebroadcast echos (sender: %pM)\n",
-			   ethhdr->h_source);
-		return;
-	}
-
-	if (batadv_ogm_packet->flags & BATADV_NOT_BEST_NEXT_HOP) {
-		batadv_dbg(BATADV_DBG_BATMAN, bat_priv,
-			   "Drop packet: ignoring all packets not forwarded from the best nex=
t hop (sender: %pM)\n",
-			   ethhdr->h_source);
-		return;
-	}
-
-	orig_node =3D batadv_iv_ogm_orig_get(bat_priv, batadv_ogm_packet->orig)=
;
-	if (!orig_node)
-		return;
-
-	dup_status =3D batadv_iv_ogm_update_seqnos(ethhdr, batadv_ogm_packet,
-						 if_incoming);
-
->>>>>>> origin/next
 	if (dup_status =3D=3D BATADV_PROTECTED) {
 		batadv_dbg(BATADV_DBG_BATMAN, bat_priv,
 			   "Drop packet: packet within seqno protection time (sender: %pM)\n"=
,
@@ -1603,17 +1469,12 @@ batadv_iv_ogm_process_per_outif(const struct sk_b=
uff *skb, int ogm_offset,
 	/* update ranking if it is not a duplicate or has the same
 	 * seqno and similar ttl as the non-duplicate
 	 */
-<<<<<<< HEAD
 	orig_ifinfo =3D batadv_orig_ifinfo_new(orig_node, if_outgoing);
 	if (!orig_ifinfo)
 		goto out_neigh;
=20
 	sameseq =3D orig_ifinfo->last_real_seqno =3D=3D ntohl(ogm_packet->seqno=
);
-	similar_ttl =3D (orig_ifinfo->last_ttl - 3) <=3D ogm_packet->header.ttl=
;
-=3D=3D=3D=3D=3D=3D=3D
-	sameseq =3D orig_node->last_real_seqno =3D=3D ntohl(batadv_ogm_packet->=
seqno);
-	similar_ttl =3D orig_node->last_ttl - 3 <=3D batadv_ogm_packet->ttl;
->>>>>>> origin/next
+	similar_ttl =3D (orig_ifinfo->last_ttl - 3) <=3D ogm_packet->ttl;
 	if (is_bidirect && ((dup_status =3D=3D BATADV_NO_DUP) ||
 			    (sameseq && similar_ttl))) {
 		batadv_iv_ogm_orig_update(bat_priv, orig_node,
@@ -1632,8 +1493,7 @@ batadv_iv_ogm_process_per_outif(const struct sk_buf=
f *skb, int ogm_offset,
 		/* OGMs from secondary interfaces should only scheduled once
 		 * per interface where it has been received, not multiple times
 		 */
-		if ((ogm_packet->header.ttl <=3D 2) &&
-		    (if_incoming !=3D if_outgoing)) {
+		if ((ogm_packet->ttl <=3D 2) && (if_incoming !=3D if_outgoing)) {
 			batadv_dbg(BATADV_DBG_BATMAN, bat_priv,
 				   "Drop packet: OGM from secondary interface and wrong outgoing int=
erface\n");
 			goto out_neigh;
@@ -1717,7 +1577,7 @@ static void batadv_iv_ogm_process(const struct sk_b=
uff *skb, int ogm_offset,
 	 * packet in an aggregation.  Here we expect that the padding
 	 * is always zero (or not 0x01)
 	 */
-	if (ogm_packet->header.packet_type !=3D BATADV_IV_OGM)
+	if (ogm_packet->packet_type !=3D BATADV_IV_OGM)
 		return;
=20
 	/* could be changed by schedule_own_packet() */
@@ -1733,8 +1593,8 @@ static void batadv_iv_ogm_process(const struct sk_b=
uff *skb, int ogm_offset,
 		   ethhdr->h_source, if_incoming->net_dev->name,
 		   if_incoming->net_dev->dev_addr, ogm_packet->orig,
 		   ogm_packet->prev_sender, ntohl(ogm_packet->seqno),
-		   ogm_packet->tq, ogm_packet->header.ttl,
-		   ogm_packet->header.version, has_directlink_flag);
+		   ogm_packet->tq, ogm_packet->ttl,
+		   ogm_packet->version, has_directlink_flag);
=20
 	rcu_read_lock();
 	list_for_each_entry_rcu(hard_iface, &batadv_hardif_list, list) {
diff --git a/network-coding.c b/network-coding.c
index 7d13666..6a0b328 100644
--- a/network-coding.c
+++ b/network-coding.c
@@ -725,7 +725,6 @@ static bool batadv_can_nc_with_orig(struct batadv_pri=
v *bat_priv,
 	orig_ifinfo =3D batadv_orig_ifinfo_get(orig_node, BATADV_IF_DEFAULT);
 	if (!orig_ifinfo)
 		return false;
-<<<<<<< HEAD
=20
 	last_ttl =3D orig_ifinfo->last_ttl;
 	last_real_seqno =3D orig_ifinfo->last_real_seqno;
@@ -733,10 +732,7 @@ static bool batadv_can_nc_with_orig(struct batadv_pr=
iv *bat_priv,
=20
 	if (last_real_seqno !=3D ntohl(ogm_packet->seqno))
 		return false;
-	if (last_ttl !=3D ogm_packet->header.ttl + 1)
-=3D=3D=3D=3D=3D=3D=3D
-	if (orig_node->last_ttl !=3D ogm_packet->ttl + 1)
->>>>>>> origin/next
+	if (last_ttl !=3D ogm_packet->ttl + 1)
 		return false;
 	if (!batadv_compare_eth(ogm_packet->orig, ogm_packet->prev_sender))
 		return false;

--------------080309050900090005020402--

--Mx3BOIVINhD59dKr2hgg68FPlBsftlO1r
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCAAGBQJSrcz/AAoJEEKTMo6mOh1VF74P/Rqu1wYbJiZqGkHQPwPKnPXs
Ac1ezeMq0ufyMhe4N6E7s2LhJLlI3icgt7ZMgnvqDVwwAzmbtFb5Sdb9I5Yk4CIi
IXamoAP82rOiMW9Hz5lPdPhi4ScZ5vks8d7Gb5LHGF1Jqp+A6ahjfNcnkrrJgJgO
RsG8jB2/lx3xUfpkg2zXyc+1xqI9Qlz2JN9fyUNpL/wwo8OyuBvCZeA29iZXIhJL
xSSiM6fcsOH0Zi0YATLPQ8cXi/2yLIemfYGZqLmp5CmrJyV3uO7dENid3erbK0h2
kBjUkHsKIxi9gDOC48W5xk6b3SS1AqwlfDMRgj2jMwaM2I9lhVMFia+b5aNrygL8
Jn53c+tdcg9m7p+SZwECN9mONKmvFCb7NM/canQ62+T+B12ePxilAU+7juHjG/vt
EMJjezew/2ARo829K9NYxmQl0CP7VtztWNw5JAzm8f97/zC5JU1p+8pYN8DXv40d
HRY92W3CM1jI1HtiACVz9C4rpQ0BBJaa59hgglBf7IIhRtqmWBSz49w7yoqBg3O/
COxiAF+kyB/rLqPjefJbuoNrPUtEm2BXrdjg5JuBmKuaJNreDTzr2kwUGh55a3ic
7bY5nrqyxd5ItTg+oDlm0lJyrFGiDhYzpF9LU97wIHmWpiBsLtPuDa//gqZjtVVI
ot0x72wm7RgdP0yN/brk
=KQbQ
-----END PGP SIGNATURE-----

--Mx3BOIVINhD59dKr2hgg68FPlBsftlO1r--
