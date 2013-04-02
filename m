Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Tue,  2 Apr 2013 11:41:08 +0200
Message-Id: <1364895668-15046-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: move
	batadv_slide_own_bcast_window to bat_iv_ogm.c
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
Cc: Antonio Quartulli <antonio@open-mesh.com>

From: Antonio Quartulli <antonio@open-mesh.com>

batadv_slide_own_bcast_window() is used only in bat_iv_ogm.c
and it is currently touching only batman_iv specific
attributes.

Move it into bat_iv_ogm.c and make it static.

Signed-off-by: Antonio Quartulli <antonio@open-mesh.com>
---
 bat_iv_ogm.c | 32 +++++++++++++++++++++++++++++++-
 routing.c    | 29 -----------------------------
 routing.h    |  1 -
 3 files changed, 31 insertions(+), 31 deletions(-)

diff --git a/bat_iv_ogm.c b/bat_iv_ogm.c
index bd50e0d..3c6670f 100644
--- a/bat_iv_ogm.c
+++ b/bat_iv_ogm.c
@@ -589,6 +589,36 @@ static void batadv_iv_ogm_forward(struct batadv_orig_node *orig_node,
 				if_incoming, 0, batadv_iv_ogm_fwd_send_time());
 }
 
+static void
+batadv_iv_ogm_slide_own_bcast_window(struct batadv_hard_iface *hard_iface)
+{
+	struct batadv_priv *bat_priv = netdev_priv(hard_iface->soft_iface);
+	struct batadv_hashtable *hash = bat_priv->orig_hash;
+	struct hlist_head *head;
+	struct batadv_orig_node *orig_node;
+	unsigned long *word;
+	uint32_t i;
+	size_t word_index;
+	uint8_t *w;
+
+	for (i = 0; i < hash->size; i++) {
+		head = &hash->table[i];
+
+		rcu_read_lock();
+		hlist_for_each_entry_rcu(orig_node, head, hash_entry) {
+			spin_lock_bh(&orig_node->ogm_cnt_lock);
+			word_index = hard_iface->if_num * BATADV_NUM_WORDS;
+			word = &(orig_node->bcast_own[word_index]);
+
+			batadv_bit_get_packet(bat_priv, word, 1, 0);
+			w = &orig_node->bcast_own_sum[hard_iface->if_num];
+			*w = bitmap_weight(word, BATADV_TQ_LOCAL_WINDOW_SIZE);
+			spin_unlock_bh(&orig_node->ogm_cnt_lock);
+		}
+		rcu_read_unlock();
+	}
+}
+
 static void batadv_iv_ogm_schedule(struct batadv_hard_iface *hard_iface)
 {
 	struct batadv_priv *bat_priv = netdev_priv(hard_iface->soft_iface);
@@ -633,7 +663,7 @@ static void batadv_iv_ogm_schedule(struct batadv_hard_iface *hard_iface)
 		batadv_ogm_packet->gw_flags = BATADV_NO_FLAGS;
 	}
 
-	batadv_slide_own_bcast_window(hard_iface);
+	batadv_iv_ogm_slide_own_bcast_window(hard_iface);
 	batadv_iv_ogm_queue_add(bat_priv, hard_iface->bat_iv.ogm_buff,
 				hard_iface->bat_iv.ogm_buff_len, hard_iface, 1,
 				batadv_iv_ogm_emit_send_time(bat_priv));
diff --git a/routing.c b/routing.c
index 8f88967..0b79e65 100644
--- a/routing.c
+++ b/routing.c
@@ -34,35 +34,6 @@
 static int batadv_route_unicast_packet(struct sk_buff *skb,
 				       struct batadv_hard_iface *recv_if);
 
-void batadv_slide_own_bcast_window(struct batadv_hard_iface *hard_iface)
-{
-	struct batadv_priv *bat_priv = netdev_priv(hard_iface->soft_iface);
-	struct batadv_hashtable *hash = bat_priv->orig_hash;
-	struct hlist_head *head;
-	struct batadv_orig_node *orig_node;
-	unsigned long *word;
-	uint32_t i;
-	size_t word_index;
-	uint8_t *w;
-
-	for (i = 0; i < hash->size; i++) {
-		head = &hash->table[i];
-
-		rcu_read_lock();
-		hlist_for_each_entry_rcu(orig_node, head, hash_entry) {
-			spin_lock_bh(&orig_node->ogm_cnt_lock);
-			word_index = hard_iface->if_num * BATADV_NUM_WORDS;
-			word = &(orig_node->bcast_own[word_index]);
-
-			batadv_bit_get_packet(bat_priv, word, 1, 0);
-			w = &orig_node->bcast_own_sum[hard_iface->if_num];
-			*w = bitmap_weight(word, BATADV_TQ_LOCAL_WINDOW_SIZE);
-			spin_unlock_bh(&orig_node->ogm_cnt_lock);
-		}
-		rcu_read_unlock();
-	}
-}
-
 static void _batadv_update_route(struct batadv_priv *bat_priv,
 				 struct batadv_orig_node *orig_node,
 				 struct batadv_neigh_node *neigh_node)
diff --git a/routing.h b/routing.h
index 99eeafa..72a29bd 100644
--- a/routing.h
+++ b/routing.h
@@ -20,7 +20,6 @@
 #ifndef _NET_BATMAN_ADV_ROUTING_H_
 #define _NET_BATMAN_ADV_ROUTING_H_
 
-void batadv_slide_own_bcast_window(struct batadv_hard_iface *hard_iface);
 bool batadv_check_management_packet(struct sk_buff *skb,
 				    struct batadv_hard_iface *hard_iface,
 				    int header_len);
-- 
1.8.1.5

