Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Fri, 11 Sep 2015 16:12:03 +0200
Message-Id: <1441980723-3805-1-git-send-email-sw@simonwunderlich.de>
Subject: [B.A.T.M.A.N.] [PATCH-maint] batman-adv: lock crc access in bridge
	loop avoidance
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

We have found some networks in which nodes were constantly requesting
other nodes BLA claim tables to synchronize, just to ask for that again
once completed. The reason was that the crc checksum of the asked nodes
were out of sync due to missing locking and multiple writes to the same
crc checksum when adding/removing entries. Therefore the asked nodes
constantly reported the wrong crc, which caused repeating requests.

To avoid multiple functions changing a backbone gateways crc entry at
the same time, lock it using a spinlock.

Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
Tested-by: Alfons Name <AlfonsName@web.de>
---
 net/batman-adv/bridge_loop_avoidance.c | 35 +++++++++++++++++++++++++++++-----
 net/batman-adv/types.h                 |  2 ++
 2 files changed, 32 insertions(+), 5 deletions(-)

diff --git a/net/batman-adv/bridge_loop_avoidance.c b/net/batman-adv/bridge_loop_avoidance.c
index ba06092..19832a3 100644
--- a/net/batman-adv/bridge_loop_avoidance.c
+++ b/net/batman-adv/bridge_loop_avoidance.c
@@ -259,7 +259,9 @@ batadv_bla_del_backbone_claims(struct batadv_bla_backbone_gw *backbone_gw)
 	}
 
 	/* all claims gone, initialize CRC */
+	spin_lock_bh(&backbone_gw->crc_lock);
 	backbone_gw->crc = BATADV_BLA_CRC_INIT;
+	spin_unlock_bh(&backbone_gw->crc_lock);
 }
 
 /**
@@ -407,6 +409,7 @@ batadv_bla_get_backbone_gw(struct batadv_priv *bat_priv, uint8_t *orig,
 	entry->lasttime = jiffies;
 	entry->crc = BATADV_BLA_CRC_INIT;
 	entry->bat_priv = bat_priv;
+	spin_lock_init(&entry->crc_lock);
 	atomic_set(&entry->request_sent, 0);
 	atomic_set(&entry->wait_periods, 0);
 	ether_addr_copy(entry->orig, orig);
@@ -556,7 +559,9 @@ static void batadv_bla_send_announce(struct batadv_priv *bat_priv,
 	__be16 crc;
 
 	memcpy(mac, batadv_announce_mac, 4);
+	spin_lock_bh(&backbone_gw->crc_lock);
 	crc = htons(backbone_gw->crc);
+	spin_unlock_bh(&backbone_gw->crc_lock);
 	memcpy(&mac[4], &crc, 2);
 
 	batadv_bla_send_claim(bat_priv, mac, backbone_gw->vid,
@@ -617,14 +622,18 @@ static void batadv_bla_add_claim(struct batadv_priv *bat_priv,
 			   "bla_add_claim(): changing ownership for %pM, vid %d\n",
 			   mac, BATADV_PRINT_VID(vid));
 
+		spin_lock_bh(&claim->backbone_gw->crc_lock);
 		claim->backbone_gw->crc ^= crc16(0, claim->addr, ETH_ALEN);
+		spin_unlock_bh(&claim->backbone_gw->crc_lock);
 		batadv_backbone_gw_free_ref(claim->backbone_gw);
 	}
 	/* set (new) backbone gw */
 	atomic_inc(&backbone_gw->refcount);
 	claim->backbone_gw = backbone_gw;
 
+	spin_lock_bh(&backbone_gw->crc_lock);
 	backbone_gw->crc ^= crc16(0, claim->addr, ETH_ALEN);
+	spin_unlock_bh(&backbone_gw->crc_lock);
 	backbone_gw->lasttime = jiffies;
 
 claim_free_ref:
@@ -652,7 +661,9 @@ static void batadv_bla_del_claim(struct batadv_priv *bat_priv,
 			   batadv_choose_claim, claim);
 	batadv_claim_free_ref(claim); /* reference from the hash is gone */
 
+	spin_lock_bh(&claim->backbone_gw->crc_lock);
 	claim->backbone_gw->crc ^= crc16(0, claim->addr, ETH_ALEN);
+	spin_unlock_bh(&claim->backbone_gw->crc_lock);
 
 	/* don't need the reference from hash_find() anymore */
 	batadv_claim_free_ref(claim);
@@ -664,7 +675,7 @@ static int batadv_handle_announce(struct batadv_priv *bat_priv,
 				  unsigned short vid)
 {
 	struct batadv_bla_backbone_gw *backbone_gw;
-	uint16_t crc;
+	uint16_t backbone_crc, crc;
 
 	if (memcmp(an_addr, batadv_announce_mac, 4) != 0)
 		return 0;
@@ -683,12 +694,16 @@ static int batadv_handle_announce(struct batadv_priv *bat_priv,
 		   "handle_announce(): ANNOUNCE vid %d (sent by %pM)... CRC = %#.4x\n",
 		   BATADV_PRINT_VID(vid), backbone_gw->orig, crc);
 
-	if (backbone_gw->crc != crc) {
+	spin_lock_bh(&backbone_gw->crc_lock);
+	backbone_crc = backbone_gw->crc;
+	spin_unlock_bh(&backbone_gw->crc_lock);
+
+	if (backbone_crc != crc) {
 		batadv_dbg(BATADV_DBG_BLA, backbone_gw->bat_priv,
 			   "handle_announce(): CRC FAILED for %pM/%d (my = %#.4x, sent = %#.4x)\n",
 			   backbone_gw->orig,
 			   BATADV_PRINT_VID(backbone_gw->vid),
-			   backbone_gw->crc, crc);
+			   backbone_crc, crc);
 
 		batadv_bla_send_request(backbone_gw);
 	} else {
@@ -1647,6 +1662,7 @@ int batadv_bla_claim_table_seq_print_text(struct seq_file *seq, void *offset)
 	struct batadv_bla_claim *claim;
 	struct batadv_hard_iface *primary_if;
 	struct hlist_head *head;
+	uint16_t backbone_crc;
 	uint32_t i;
 	bool is_own;
 	uint8_t *primary_addr;
@@ -1669,11 +1685,15 @@ int batadv_bla_claim_table_seq_print_text(struct seq_file *seq, void *offset)
 		hlist_for_each_entry_rcu(claim, head, hash_entry) {
 			is_own = batadv_compare_eth(claim->backbone_gw->orig,
 						    primary_addr);
+
+			spin_lock_bh(&claim->backbone_gw->crc_lock);
+			backbone_crc = claim->backbone_gw->crc;
+			spin_lock_bh(&claim->backbone_gw->crc_lock);
 			seq_printf(seq, " * %pM on %5d by %pM [%c] (%#.4x)\n",
 				   claim->addr, BATADV_PRINT_VID(claim->vid),
 				   claim->backbone_gw->orig,
 				   (is_own ? 'x' : ' '),
-				   claim->backbone_gw->crc);
+				   backbone_crc);
 		}
 		rcu_read_unlock();
 	}
@@ -1692,6 +1712,7 @@ int batadv_bla_backbone_table_seq_print_text(struct seq_file *seq, void *offset)
 	struct batadv_hard_iface *primary_if;
 	struct hlist_head *head;
 	int secs, msecs;
+	uint16_t backbone_crc;
 	uint32_t i;
 	bool is_own;
 	uint8_t *primary_addr;
@@ -1722,10 +1743,14 @@ int batadv_bla_backbone_table_seq_print_text(struct seq_file *seq, void *offset)
 			if (is_own)
 				continue;
 
+			spin_lock_bh(&backbone_gw->crc_lock);
+			backbone_crc = backbone_gw->crc;
+			spin_unlock_bh(&backbone_gw->crc_lock);
+
 			seq_printf(seq, " * %pM on %5d %4i.%03is (%#.4x)\n",
 				   backbone_gw->orig,
 				   BATADV_PRINT_VID(backbone_gw->vid), secs,
-				   msecs, backbone_gw->crc);
+				   msecs, backbone_crc);
 		}
 		rcu_read_unlock();
 	}
diff --git a/net/batman-adv/types.h b/net/batman-adv/types.h
index 55610a8..bd4ed75 100644
--- a/net/batman-adv/types.h
+++ b/net/batman-adv/types.h
@@ -886,6 +886,7 @@ struct batadv_socket_packet {
  *  backbone gateway - no bcast traffic is formwared until the situation was
  *  resolved
  * @crc: crc16 checksum over all claims
+ * @crc_lock: lock protecting crc
  * @refcount: number of contexts the object is used
  * @rcu: struct used for freeing in an RCU-safe manner
  */
@@ -899,6 +900,7 @@ struct batadv_bla_backbone_gw {
 	atomic_t wait_periods;
 	atomic_t request_sent;
 	uint16_t crc;
+	spinlock_t crc_lock; /* protects crc */
 	atomic_t refcount;
 	struct rcu_head rcu;
 };
-- 
2.5.1

