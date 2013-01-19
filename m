Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Sat, 19 Jan 2013 21:27:50 +0800
Message-Id: <1358602079-24024-5-git-send-email-ordex@autistici.org>
In-Reply-To: <1358602079-24024-1-git-send-email-ordex@autistici.org>
References: <1358602079-24024-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCH 04/13] batman-adv: group tt type definitions
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
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, Marek Lindner <lindner_marek@yahoo.de>

From: Marek Lindner <lindner_marek@yahoo.de>

Signed-off-by: Marek Lindner <lindner_marek@yahoo.de>
Signed-off-by: Antonio Quartulli <ordex@autistici.org>
---
 net/batman-adv/types.h | 58 +++++++++++++++++++++++++-------------------------
 1 file changed, 29 insertions(+), 29 deletions(-)

diff --git a/net/batman-adv/types.h b/net/batman-adv/types.h
index db3fb25..9a66115 100644
--- a/net/batman-adv/types.h
+++ b/net/batman-adv/types.h
@@ -339,35 +339,6 @@ struct batadv_socket_packet {
 	struct batadv_icmp_packet_rr icmp_packet;
 };
 
-struct batadv_tt_common_entry {
-	uint8_t addr[ETH_ALEN];
-	struct hlist_node hash_entry;
-	uint16_t flags;
-	unsigned long added_at;
-	atomic_t refcount;
-	struct rcu_head rcu;
-};
-
-struct batadv_tt_local_entry {
-	struct batadv_tt_common_entry common;
-	unsigned long last_seen;
-};
-
-struct batadv_tt_global_entry {
-	struct batadv_tt_common_entry common;
-	struct hlist_head orig_list;
-	spinlock_t list_lock;	/* protects the list */
-	unsigned long roam_at; /* time at which TT_GLOBAL_ROAM was set */
-};
-
-struct batadv_tt_orig_list_entry {
-	struct batadv_orig_node *orig_node;
-	uint8_t ttvn;
-	atomic_t refcount;
-	struct rcu_head rcu;
-	struct hlist_node list;
-};
-
 #ifdef CONFIG_BATMAN_ADV_BLA
 struct batadv_backbone_gw {
 	uint8_t orig[ETH_ALEN];
@@ -393,6 +364,35 @@ struct batadv_claim {
 };
 #endif
 
+struct batadv_tt_common_entry {
+	uint8_t addr[ETH_ALEN];
+	struct hlist_node hash_entry;
+	uint16_t flags;
+	unsigned long added_at;
+	atomic_t refcount;
+	struct rcu_head rcu;
+};
+
+struct batadv_tt_local_entry {
+	struct batadv_tt_common_entry common;
+	unsigned long last_seen;
+};
+
+struct batadv_tt_global_entry {
+	struct batadv_tt_common_entry common;
+	struct hlist_head orig_list;
+	spinlock_t list_lock;	/* protects the list */
+	unsigned long roam_at; /* time at which TT_GLOBAL_ROAM was set */
+};
+
+struct batadv_tt_orig_list_entry {
+	struct batadv_orig_node *orig_node;
+	uint8_t ttvn;
+	atomic_t refcount;
+	struct rcu_head rcu;
+	struct hlist_node list;
+};
+
 struct batadv_tt_change_node {
 	struct list_head list;
 	struct batadv_tt_change change;
-- 
1.8.0.2

