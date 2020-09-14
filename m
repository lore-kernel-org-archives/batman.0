Return-Path: <b.a.t.m.a.n-bounces@lists.open-mesh.org>
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@c0d3.blue>
Subject: [PATCH maint v4 3/3] batman-adv: mcast: fix duplicate mcast packets from BLA backbone to mesh
Date: Mon, 14 Sep 2020 21:48:37 +0200
Message-Id: <20200914194837.10425-4-linus.luessing@c0d3.blue>
In-Reply-To: <20200914194837.10425-1-linus.luessing@c0d3.blue>
References: <20200914194837.10425-1-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n.lists.open-mesh.org>
List-Archive: <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@c0d3.blue>

Scenario:
* Multicast frame send from BLA backbone gateways (multiple nodes
  with their bat0 bridged together, with BLA enabled) sharing the same
  LAN to nodes in the mesh

Issue:
* Nodes receive the frame multiple times on bat0 from the mesh,
  once from each foreign BLA backbone gateway which shares the same LAN
  with another

For multicast frames via batman-adv broadcast packets coming from the
same BLA backbone but from different backbone gateways duplicates are
currently detected via a CRC history of previously received packets.

However this CRC so far was not performed for multicast frames received
via batman-adv unicast packets. Fixing this by appyling the same check
for such packets, too.

Room for improvements in the future: Ideally we would introduce the
possibility to not only claim a client, but a complete originator, too.
This would allow us to only send a multicast-in-unicast packet from a BLA
backbone gateway claiming the node and by that avoid potential redundant
transmissions in the first place.

Fixes: e5cf86d30a9b ("batman-adv: add broadcast duplicate check")
Signed-off-by: Linus L=C3=BCssing <linus.luessing@c0d3.blue>
---
 net/batman-adv/bridge_loop_avoidance.c | 109 +++++++++++++++++++++----
 1 file changed, 93 insertions(+), 16 deletions(-)

diff --git a/net/batman-adv/bridge_loop_avoidance.c b/net/batman-adv/brid=
ge_loop_avoidance.c
index 3d2a66f2..60ed5293 100644
--- a/net/batman-adv/bridge_loop_avoidance.c
+++ b/net/batman-adv/bridge_loop_avoidance.c
@@ -1580,14 +1580,17 @@ int batadv_bla_init(struct batadv_priv *bat_priv)
 }
=20
 /**
- * batadv_bla_check_bcast_duplist() - Check if a frame is in the broadca=
st dup.
+ * batadv_bla_check_duplist() - Check if a frame is in the broadcast dup=
.
  * @bat_priv: the bat priv with all the soft interface information
- * @skb: contains the bcast_packet to be checked
- *
- * check if it is on our broadcast list. Another gateway might
- * have sent the same packet because it is connected to the same backbon=
e,
- * so we have to remove this duplicate.
+ * @skb: contains the multicast packet to be checked
+ * @payload_ptr: pointer to position inside the head buffer of the skb
+ *  marking the start of the data to be CRC'ed
+ * @orig: originator mac address, NULL if unknown
  *
+ * Check if it is on our broadcast list. Another gateway might have sent=
 the
+ * same packet because it is connected to the same backbone, so we have =
to
+ * remove this duplicate.
+
  * This is performed by checking the CRC, which will tell us
  * with a good chance that it is the same packet. If it is furthermore
  * sent by another host, drop it. We allow equal packets from
@@ -1595,23 +1598,23 @@ int batadv_bla_init(struct batadv_priv *bat_priv)
  *
  * Return: true if a packet is in the duplicate list, false otherwise.
  */
-bool batadv_bla_check_bcast_duplist(struct batadv_priv *bat_priv,
-				    struct sk_buff *skb)
+static bool batadv_bla_check_duplist(struct batadv_priv *bat_priv,
+				     struct sk_buff *skb, u8 *payload_ptr,
+				     const u8 *orig)
 {
+	struct batadv_bcast_duplist_entry *entry;
+	bool ret =3D false;
 	int i, curr;
 	__be32 crc;
-	struct batadv_bcast_packet *bcast_packet;
-	struct batadv_bcast_duplist_entry *entry;
-	bool ret =3D false;
-
-	bcast_packet =3D (struct batadv_bcast_packet *)skb->data;
=20
 	/* calculate the crc ... */
-	crc =3D batadv_skb_crc32(skb, (u8 *)(bcast_packet + 1));
+	crc =3D batadv_skb_crc32(skb, payload_ptr);
=20
 	spin_lock_bh(&bat_priv->bla.bcast_duplist_lock);
=20
 	for (i =3D 0; i < BATADV_DUPLIST_SIZE; i++) {
+		bool is_from_same_orig =3D false;
+
 		curr =3D (bat_priv->bla.bcast_duplist_curr + i);
 		curr %=3D BATADV_DUPLIST_SIZE;
 		entry =3D &bat_priv->bla.bcast_duplist[curr];
@@ -1626,7 +1629,24 @@ bool batadv_bla_check_bcast_duplist(struct batadv_=
priv *bat_priv,
 		if (entry->crc !=3D crc)
 			continue;
=20
-		if (batadv_compare_eth(entry->orig, bcast_packet->orig))
+		/* are the originators both known and not anonymous? */
+		if (orig && !is_zero_ether_addr(orig) &&
+		    !is_zero_ether_addr(entry->orig)) {
+			/* if known, check if the new frame came from
+			 * the same originator
+			 */
+			if (batadv_compare_eth(entry->orig, orig))
+				is_from_same_orig =3D true;
+		}
+
+		/* we are safe to take identical frames from the
+		 * same orig, if known, as multiplications in
+		 * the mesh are detected via the (orig, seqno) pair;
+		 * so we can be a bit more liberal here and allow
+		 * identical frames from the same orig which the source
+		 * host might have sent multiple times on purpose
+		 */
+		if (is_from_same_orig)
 			continue;
=20
 		/* this entry seems to match: same crc, not too old,
@@ -1643,7 +1663,14 @@ bool batadv_bla_check_bcast_duplist(struct batadv_=
priv *bat_priv,
 	entry =3D &bat_priv->bla.bcast_duplist[curr];
 	entry->crc =3D crc;
 	entry->entrytime =3D jiffies;
-	ether_addr_copy(entry->orig, bcast_packet->orig);
+
+	/* known originator */
+	if (orig)
+		ether_addr_copy(entry->orig, orig);
+	/* anonymous originator */
+	else
+		eth_zero_addr(entry->orig);
+
 	bat_priv->bla.bcast_duplist_curr =3D curr;
=20
 out:
@@ -1652,6 +1679,48 @@ bool batadv_bla_check_bcast_duplist(struct batadv_=
priv *bat_priv,
 	return ret;
 }
=20
+/**
+ * batadv_bla_check_ucast_duplist() - Check if a frame is in the broadca=
st dup.
+ * @bat_priv: the bat priv with all the soft interface information
+ * @skb: contains the multicast packet to be checked, decapsulated from =
a
+ *  unicast_packet
+ *
+ * Check if it is on our broadcast list. Another gateway might have sent=
 the
+ * same packet because it is connected to the same backbone, so we have =
to
+ * remove this duplicate.
+ *
+ * Return: true if a packet is in the duplicate list, false otherwise.
+ */
+static bool batadv_bla_check_ucast_duplist(struct batadv_priv *bat_priv,
+					   struct sk_buff *skb)
+{
+	return batadv_bla_check_duplist(bat_priv, skb, (u8 *)skb->data, NULL);
+}
+
+/**
+ * batadv_bla_check_bcast_duplist() - Check if a frame is in the broadca=
st dup.
+ * @bat_priv: the bat priv with all the soft interface information
+ * @skb: contains the bcast_packet to be checked
+ *
+ * Check if it is on our broadcast list. Another gateway might have sent=
 the
+ * same packet because it is connected to the same backbone, so we have =
to
+ * remove this duplicate.
+ *
+ * Return: true if a packet is in the duplicate list, false otherwise.
+ */
+bool batadv_bla_check_bcast_duplist(struct batadv_priv *bat_priv,
+				    struct sk_buff *skb)
+{
+	struct batadv_bcast_packet *bcast_packet;
+	u8 *payload_ptr;
+
+	bcast_packet =3D (struct batadv_bcast_packet *)skb->data;
+	payload_ptr =3D (u8 *)(bcast_packet + 1);
+
+	return batadv_bla_check_duplist(bat_priv, skb, payload_ptr,
+					bcast_packet->orig);
+}
+
 /**
  * batadv_bla_is_backbone_gw_orig() - Check if the originator is a gatew=
ay for
  *  the VLAN identified by vid.
@@ -1866,6 +1935,14 @@ bool batadv_bla_rx(struct batadv_priv *bat_priv, s=
truct sk_buff *skb,
 			    packet_type =3D=3D BATADV_UNICAST)
 				goto handled;
=20
+	/* potential duplicates from foreign BLA backbone gateways via
+	 * multicast-in-unicast packets
+	 */
+	if (is_multicast_ether_addr(ethhdr->h_dest) &&
+	    packet_type =3D=3D BATADV_UNICAST &&
+	    batadv_bla_check_ucast_duplist(bat_priv, skb))
+		goto handled;
+
 	ether_addr_copy(search_claim.addr, ethhdr->h_source);
 	search_claim.vid =3D vid;
 	claim =3D batadv_claim_hash_find(bat_priv, &search_claim);
--=20
2.28.0
