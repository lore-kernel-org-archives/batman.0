Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Tue, 25 Dec 2012 17:03:21 +0800
Message-Id: <1356426206-8667-3-git-send-email-lindner_marek@yahoo.de>
In-Reply-To: <1356426206-8667-1-git-send-email-lindner_marek@yahoo.de>
References: <1356426206-8667-1-git-send-email-lindner_marek@yahoo.de>
Subject: [B.A.T.M.A.N.] [PATCH 3/8] batman-adv: group tt type definitions
	together
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
Cc: Marek Lindner <lindner_marek@yahoo.de>

Signed-off-by: Marek Lindner <lindner_marek@yahoo.de>
---
 types.h |   50 +++++++++++++++++++++++++-------------------------
 1 file changed, 25 insertions(+), 25 deletions(-)

diff --git a/types.h b/types.h
index db3fb25..9a66115 100644
--- a/types.h
+++ b/types.h
@@ -339,6 +339,31 @@ struct batadv_socket_packet {
 	struct batadv_icmp_packet_rr icmp_packet;
 };
 
+#ifdef CONFIG_BATMAN_ADV_BLA
+struct batadv_backbone_gw {
+	uint8_t orig[ETH_ALEN];
+	short vid;		/* used VLAN ID */
+	struct hlist_node hash_entry;
+	struct batadv_priv *bat_priv;
+	unsigned long lasttime;	/* last time we heard of this backbone gw */
+	atomic_t wait_periods;
+	atomic_t request_sent;
+	atomic_t refcount;
+	struct rcu_head rcu;
+	uint16_t crc;		/* crc checksum over all claims */
+};
+
+struct batadv_claim {
+	uint8_t addr[ETH_ALEN];
+	short vid;
+	struct batadv_backbone_gw *backbone_gw;
+	unsigned long lasttime;	/* last time we heard of claim (locals only) */
+	struct rcu_head rcu;
+	atomic_t refcount;
+	struct hlist_node hash_entry;
+};
+#endif
+
 struct batadv_tt_common_entry {
 	uint8_t addr[ETH_ALEN];
 	struct hlist_node hash_entry;
@@ -368,31 +393,6 @@ struct batadv_tt_orig_list_entry {
 	struct hlist_node list;
 };
 
-#ifdef CONFIG_BATMAN_ADV_BLA
-struct batadv_backbone_gw {
-	uint8_t orig[ETH_ALEN];
-	short vid;		/* used VLAN ID */
-	struct hlist_node hash_entry;
-	struct batadv_priv *bat_priv;
-	unsigned long lasttime;	/* last time we heard of this backbone gw */
-	atomic_t wait_periods;
-	atomic_t request_sent;
-	atomic_t refcount;
-	struct rcu_head rcu;
-	uint16_t crc;		/* crc checksum over all claims */
-};
-
-struct batadv_claim {
-	uint8_t addr[ETH_ALEN];
-	short vid;
-	struct batadv_backbone_gw *backbone_gw;
-	unsigned long lasttime;	/* last time we heard of claim (locals only) */
-	struct rcu_head rcu;
-	atomic_t refcount;
-	struct hlist_node hash_entry;
-};
-#endif
-
 struct batadv_tt_change_node {
 	struct list_head list;
 	struct batadv_tt_change change;
-- 
1.7.10.4

