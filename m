Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Subject: [PATCH 4.4 06/11] batman-adv: mcast: fix duplicate mcast packets from
 BLA backbone to mesh
Date: Sat, 20 Nov 2021 13:39:34 +0100
Message-Id: <20211120123939.260723-7-sven@narfation.org>
In-Reply-To: <20211120123939.260723-1-sven@narfation.org>
References: <20211120123939.260723-1-sven@narfation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: stable@vger.kernel.org
Cc: b.a.t.m.a.n@lists.open-mesh.org, =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@c0d3.blue>, Simon Wunderlich <sw@simonwunderlich.de>, Sven Eckelmann <sven@narfation.org>

From: Linus Lüssing <linus.luessing@c0d3.blue>

commit 2369e827046920ef0599e6a36b975ac5c0a359c2 upstream.

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

Fixes: fe2da6ff27c7 ("batman-adv: add broadcast duplicate check")
Signed-off-by: Linus Lüssing <linus.luessing@c0d3.blue>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
[ bp: 4.4 backported: adjust context, correct fixes line, switch back to
  int return type ]
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/bridge_loop_avoidance.c | 99 ++++++++++++++++++++++----
 1 file changed, 85 insertions(+), 14 deletions(-)

diff --git a/net/batman-adv/bridge_loop_avoidance.c b/net/batman-adv/bridge_loop_avoidance.c
index c8fbcaed5844..e97b1e000670 100644
--- a/net/batman-adv/bridge_loop_avoidance.c
+++ b/net/batman-adv/bridge_loop_avoidance.c
@@ -1366,31 +1366,32 @@ int batadv_bla_init(struct batadv_priv *bat_priv)
 }
 
 /**
- * batadv_bla_check_bcast_duplist
+ * batadv_bla_check_duplist() - Check if a frame is in the broadcast dup.
  * @bat_priv: the bat priv with all the soft interface information
- * @skb: contains the bcast_packet to be checked
+ * @skb: contains the multicast packet to be checked
+ * @payload_ptr: pointer to position inside the head buffer of the skb
+ *  marking the start of the data to be CRC'ed
+ * @orig: originator mac address, NULL if unknown
  *
- * check if it is on our broadcast list. Another gateway might
- * have sent the same packet because it is connected to the same backbone,
- * so we have to remove this duplicate.
+ * Check if it is on our broadcast list. Another gateway might have sent the
+ * same packet because it is connected to the same backbone, so we have to
+ * remove this duplicate.
  *
  * This is performed by checking the CRC, which will tell us
  * with a good chance that it is the same packet. If it is furthermore
  * sent by another host, drop it. We allow equal packets from
  * the same host however as this might be intended.
  */
-int batadv_bla_check_bcast_duplist(struct batadv_priv *bat_priv,
-				   struct sk_buff *skb)
+static int batadv_bla_check_duplist(struct batadv_priv *bat_priv,
+				    struct sk_buff *skb, u8 *payload_ptr,
+				    const u8 *orig)
 {
 	int i, curr, ret = 0;
 	__be32 crc;
-	struct batadv_bcast_packet *bcast_packet;
 	struct batadv_bcast_duplist_entry *entry;
 
-	bcast_packet = (struct batadv_bcast_packet *)skb->data;
-
 	/* calculate the crc ... */
-	crc = batadv_skb_crc32(skb, (u8 *)(bcast_packet + 1));
+	crc = batadv_skb_crc32(skb, payload_ptr);
 
 	spin_lock_bh(&bat_priv->bla.bcast_duplist_lock);
 
@@ -1409,8 +1410,21 @@ int batadv_bla_check_bcast_duplist(struct batadv_priv *bat_priv,
 		if (entry->crc != crc)
 			continue;
 
-		if (batadv_compare_eth(entry->orig, bcast_packet->orig))
-			continue;
+		/* are the originators both known and not anonymous? */
+		if (orig && !is_zero_ether_addr(orig) &&
+		    !is_zero_ether_addr(entry->orig)) {
+			/* If known, check if the new frame came from
+			 * the same originator:
+			 * We are safe to take identical frames from the
+			 * same orig, if known, as multiplications in
+			 * the mesh are detected via the (orig, seqno) pair.
+			 * So we can be a bit more liberal here and allow
+			 * identical frames from the same orig which the source
+			 * host might have sent multiple times on purpose.
+			 */
+			if (batadv_compare_eth(entry->orig, orig))
+				continue;
+		}
 
 		/* this entry seems to match: same crc, not too old,
 		 * and from another gw. therefore return 1 to forbid it.
@@ -1426,7 +1440,14 @@ int batadv_bla_check_bcast_duplist(struct batadv_priv *bat_priv,
 	entry = &bat_priv->bla.bcast_duplist[curr];
 	entry->crc = crc;
 	entry->entrytime = jiffies;
-	ether_addr_copy(entry->orig, bcast_packet->orig);
+
+	/* known originator */
+	if (orig)
+		ether_addr_copy(entry->orig, orig);
+	/* anonymous originator */
+	else
+		eth_zero_addr(entry->orig);
+
 	bat_priv->bla.bcast_duplist_curr = curr;
 
 out:
@@ -1435,6 +1456,48 @@ int batadv_bla_check_bcast_duplist(struct batadv_priv *bat_priv,
 	return ret;
 }
 
+/**
+ * batadv_bla_check_ucast_duplist() - Check if a frame is in the broadcast dup.
+ * @bat_priv: the bat priv with all the soft interface information
+ * @skb: contains the multicast packet to be checked, decapsulated from a
+ *  unicast_packet
+ *
+ * Check if it is on our broadcast list. Another gateway might have sent the
+ * same packet because it is connected to the same backbone, so we have to
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
+ * batadv_bla_check_bcast_duplist() - Check if a frame is in the broadcast dup.
+ * @bat_priv: the bat priv with all the soft interface information
+ * @skb: contains the bcast_packet to be checked
+ *
+ * Check if it is on our broadcast list. Another gateway might have sent the
+ * same packet because it is connected to the same backbone, so we have to
+ * remove this duplicate.
+ *
+ * Return: true if a packet is in the duplicate list, false otherwise.
+ */
+int batadv_bla_check_bcast_duplist(struct batadv_priv *bat_priv,
+				   struct sk_buff *skb)
+{
+	struct batadv_bcast_packet *bcast_packet;
+	u8 *payload_ptr;
+
+	bcast_packet = (struct batadv_bcast_packet *)skb->data;
+	payload_ptr = (u8 *)(bcast_packet + 1);
+
+	return batadv_bla_check_duplist(bat_priv, skb, payload_ptr,
+					bcast_packet->orig);
+}
+
 /**
  * batadv_bla_is_backbone_gw_orig
  * @bat_priv: the bat priv with all the soft interface information
@@ -1587,6 +1650,14 @@ int batadv_bla_rx(struct batadv_priv *bat_priv, struct sk_buff *skb,
 			    packet_type == BATADV_UNICAST)
 				goto handled;
 
+	/* potential duplicates from foreign BLA backbone gateways via
+	 * multicast-in-unicast packets
+	 */
+	if (is_multicast_ether_addr(ethhdr->h_dest) &&
+	    packet_type == BATADV_UNICAST &&
+	    batadv_bla_check_ucast_duplist(bat_priv, skb))
+		goto handled;
+
 	ether_addr_copy(search_claim.addr, ethhdr->h_source);
 	search_claim.vid = vid;
 	claim = batadv_claim_hash_find(bat_priv, &search_claim);
-- 
2.30.2

