Return-Path: <simon.wunderlich@s2003.tu-chemnitz.de>
From: Simon Wunderlich <simon.wunderlich@s2003.tu-chemnitz.de>
Date: Wed, 17 Oct 2012 22:07:58 +0200
Message-Id: <1350504478-31854-1-git-send-email-siwu@hrz.tu-chemnitz.de>
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: Fix broadcast duplist for
	fragmentation
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
Cc: Simon Wunderlich <siwu@hrz.tu-chemnitz.de>

If the skb is fragmented, the checksum must be computed on the
individual fragments, just using skb->data may fail on fragmented
data. Instead of doing linearizing the packet, use the new
batadv_crc32 to do that more efficiently- it should not hurt
replacing the old crc16 by the new crc32.

Reported-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <siwu@hrz.tu-chemnitz.de>
---
 bridge_loop_avoidance.c |   18 +++++++-----------
 bridge_loop_avoidance.h |    3 +--
 routing.c               |   10 +++-------
 types.h                 |    2 +-
 4 files changed, 12 insertions(+), 21 deletions(-)

diff --git a/bridge_loop_avoidance.c b/bridge_loop_avoidance.c
index c6c1c59..b766441 100644
--- a/bridge_loop_avoidance.c
+++ b/bridge_loop_avoidance.c
@@ -1247,8 +1247,7 @@ int batadv_bla_init(struct batadv_priv *bat_priv)
 /**
  * batadv_bla_check_bcast_duplist
  * @bat_priv: the bat priv with all the soft interface information
- * @bcast_packet: encapsulated broadcast frame plus batman header
- * @bcast_packet_len: length of encapsulated broadcast frame plus batman header
+ * @skb: contains the bcast_packet to be checked
  *
  * check if it is on our broadcast list. Another gateway might
  * have sent the same packet because it is connected to the same backbone,
@@ -1260,20 +1259,17 @@ int batadv_bla_init(struct batadv_priv *bat_priv)
  * the same host however as this might be intended.
  */
 int batadv_bla_check_bcast_duplist(struct batadv_priv *bat_priv,
-				   struct batadv_bcast_packet *bcast_packet,
-				   int bcast_packet_len)
+				   struct sk_buff *skb)
 {
-	int i, length, curr, ret = 0;
-	uint8_t *content;
-	uint16_t crc;
+	int i, curr, ret = 0;
+	uint32_t crc;
+	struct batadv_bcast_packet *bcast_packet;
 	struct batadv_bcast_duplist_entry *entry;
 
-	length = bcast_packet_len - sizeof(*bcast_packet);
-	content = (uint8_t *)bcast_packet;
-	content += sizeof(*bcast_packet);
+	bcast_packet = (struct batadv_bcast_packet *)skb->data;
 
 	/* calculate the crc ... */
-	crc = crc16(0, content, length);
+	crc = batadv_skb_crc32(skb, (u8 *)(bcast_packet + 1));
 
 	spin_lock_bh(&bat_priv->bla.bcast_duplist_lock);
 
diff --git a/bridge_loop_avoidance.h b/bridge_loop_avoidance.h
index 789cb73..f1bc9cd 100644
--- a/bridge_loop_avoidance.h
+++ b/bridge_loop_avoidance.h
@@ -31,8 +31,7 @@ int batadv_bla_backbone_table_seq_print_text(struct seq_file *seq,
 					     void *offset);
 int batadv_bla_is_backbone_gw_orig(struct batadv_priv *bat_priv, uint8_t *orig);
 int batadv_bla_check_bcast_duplist(struct batadv_priv *bat_priv,
-				   struct batadv_bcast_packet *bcast_packet,
-				   int hdr_size);
+				   struct sk_buff *skb);
 void batadv_bla_update_orig_address(struct batadv_priv *bat_priv,
 				    struct batadv_hard_iface *primary_if,
 				    struct batadv_hard_iface *oldif);
diff --git a/routing.c b/routing.c
index 5da62df..5da7724 100644
--- a/routing.c
+++ b/routing.c
@@ -1181,16 +1181,12 @@ int batadv_recv_bcast_packet(struct sk_buff *skb,
 
 	spin_unlock_bh(&orig_node->bcast_seqno_lock);
 
-	/* keep skb linear for crc calculation */
-	if (skb_linearize(skb) < 0)
-		goto out;
-
-	bcast_packet = (struct batadv_bcast_packet *)skb->data;
-
 	/* check whether this has been sent by another originator before */
-	if (batadv_bla_check_bcast_duplist(bat_priv, bcast_packet, skb->len))
+	if (batadv_bla_check_bcast_duplist(bat_priv, skb))
 		goto out;
 
+	bcast_packet = (struct batadv_bcast_packet *)skb->data;
+
 	/* rebroadcast packet */
 	batadv_add_bcast_packet_to_list(bat_priv, skb, 1);
 
diff --git a/types.h b/types.h
index 7b3d0d7..354b699 100644
--- a/types.h
+++ b/types.h
@@ -156,7 +156,7 @@ struct batadv_neigh_node {
 #ifdef CONFIG_BATMAN_ADV_BLA
 struct batadv_bcast_duplist_entry {
 	uint8_t orig[ETH_ALEN];
-	uint16_t crc;
+	uint32_t crc;
 	unsigned long entrytime;
 };
 #endif
-- 
1.7.10

