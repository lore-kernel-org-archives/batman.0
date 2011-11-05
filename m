Return-Path: <simon.wunderlich@s2003.tu-chemnitz.de>
From: Simon Wunderlich <simon.wunderlich@s2003.tu-chemnitz.de>
Date: Sat,  5 Nov 2011 18:24:17 +0100
Message-Id: <1320513862-28360-7-git-send-email-siwu@hrz.tu-chemnitz.de>
In-Reply-To: <1320513862-28360-1-git-send-email-siwu@hrz.tu-chemnitz.de>
References: <1320513862-28360-1-git-send-email-siwu@hrz.tu-chemnitz.de>
Subject: [B.A.T.M.A.N.] [PATCH 06/11] batman-adv: don't let backbone
	gateways exchange tt entries
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Simon Wunderlich <siwu@hrz.tu-chemnitz.de>

As the backbone gateways are connected to the same backbone, they
should announce the same clients on the backbone non-exclusively.

Signed-off-by: Simon Wunderlich <siwu@hrz.tu-chemnitz.de>
---
[2011-10-27] Changes suggested by Marek Lindner:
 * move rcu_read_lock() more into the loops

Signed-off-by: Simon Wunderlich <siwu@hrz.tu-chemnitz.de>
---
 bridge_loop_avoidance.c |   50 +++++++++++++++++++++++++++++++++++++++++++++++
 bridge_loop_avoidance.h |    1 +
 routing.c               |    6 +++++
 translation-table.c     |   17 ++++++++++++++-
 4 files changed, 72 insertions(+), 2 deletions(-)

diff --git a/bridge_loop_avoidance.c b/bridge_loop_avoidance.c
index 725c0f5..e9efc91 100644
--- a/bridge_loop_avoidance.c
+++ b/bridge_loop_avoidance.c
@@ -24,6 +24,7 @@
 #include "hard-interface.h"
 #include "originator.h"
 #include "bridge_loop_avoidance.h"
+#include "translation-table.h"
 #include "send.h"
 
 #include <linux/etherdevice.h>
@@ -363,6 +364,7 @@ static struct backbone_gw *bla_get_backbone_gw(struct bat_priv *bat_priv,
 		uint8_t *orig, short vid)
 {
 	struct backbone_gw *entry;
+	struct orig_node *orig_node;
 	int hash_added;
 
 	entry = backbone_hash_find(bat_priv, orig, vid);
@@ -397,6 +399,13 @@ static struct backbone_gw *bla_get_backbone_gw(struct bat_priv *bat_priv,
 		return NULL;
 	}
 
+	/* this is a gateway now, remove any tt entries */
+	orig_node = orig_hash_find(bat_priv, orig);
+	if (orig_node) {
+		tt_global_del_orig(bat_priv, orig_node,
+			    "became a backbone gateway");
+		orig_node_free_ref(orig_node);
+	}
 	return entry;
 }
 
@@ -1059,6 +1068,47 @@ int bla_init(struct bat_priv *bat_priv)
 }
 
 /**
+ * @bat_priv: the bat priv with all the soft interface information
+ * @orig: originator mac address
+ *
+ * check if the originator is a gateway for any VLAN ID.
+ *
+ * returns 1 if it is found, 0 otherwise
+ *
+ **/
+
+int bla_is_backbone_gw_orig(struct bat_priv *bat_priv, uint8_t *orig)
+{
+	struct hashtable_t *hash = bat_priv->backbone_hash;
+	struct hlist_head *head;
+	struct hlist_node *node;
+	struct backbone_gw *backbone_gw;
+	int i;
+
+	if (!atomic_read(&bat_priv->bridge_loop_avoidance))
+		return 0;
+
+	if (!hash)
+		return 0;
+
+	for (i = 0; i < hash->size; i++) {
+		head = &hash->table[i];
+
+		rcu_read_lock();
+		hlist_for_each_entry_rcu(backbone_gw, node, head, hash_entry) {
+			if (compare_eth(backbone_gw->orig, orig)) {
+				rcu_read_unlock();
+				return 1;
+			}
+		}
+		rcu_read_unlock();
+	}
+
+	return 0;
+}
+
+
+/**
  * @skb: the frame to be checked
  * @orig_node: the orig_node of the frame
  * @hdr_size: maximum length of the frame
diff --git a/bridge_loop_avoidance.h b/bridge_loop_avoidance.h
index 3b312aa..bfafbad 100644
--- a/bridge_loop_avoidance.h
+++ b/bridge_loop_avoidance.h
@@ -24,6 +24,7 @@ int bla_tx(struct bat_priv *bat_priv, struct sk_buff *skb, short vid);
 int bla_is_backbone_gw(struct sk_buff *skb,
 		struct orig_node *orig_node, int hdr_size);
 int bla_claim_table_seq_print_text(struct seq_file *seq, void *offset);
+int bla_is_backbone_gw_orig(struct bat_priv *bat_priv, uint8_t *orig);
 void bla_update_orig_address(struct bat_priv *bat_priv,
 		struct hard_iface *primary_if, struct hard_iface *oldif);
 int bla_init(struct bat_priv *bat_priv);
diff --git a/routing.c b/routing.c
index 8050fb2..1554f60 100644
--- a/routing.c
+++ b/routing.c
@@ -675,6 +675,12 @@ int recv_roam_adv(struct sk_buff *skb, struct hard_iface *recv_if)
 	if (!is_my_mac(roam_adv_packet->dst))
 		return route_unicast_packet(skb, recv_if);
 
+	/* check if it is a backbone gateway. we don't accept
+	 * roaming advertisement from it, as it has the same
+	 * entries as we have. */
+	if (bla_is_backbone_gw_orig(bat_priv, roam_adv_packet->src))
+		goto out;
+
 	orig_node = orig_hash_find(bat_priv, roam_adv_packet->src);
 	if (!orig_node)
 		goto out;
diff --git a/translation-table.c b/translation-table.c
index 94a99f8..deef347 100644
--- a/translation-table.c
+++ b/translation-table.c
@@ -27,6 +27,7 @@
 #include "hash.h"
 #include "originator.h"
 #include "routing.h"
+#include "bridge_loop_avoidance.h"
 
 #include <linux/crc16.h>
 
@@ -1530,9 +1531,13 @@ out:
 bool send_tt_response(struct bat_priv *bat_priv,
 		      struct tt_query_packet *tt_request)
 {
-	if (is_my_mac(tt_request->dst))
+	if (is_my_mac(tt_request->dst)) {
+		/* don't answer backbone gws! */
+		if (bla_is_backbone_gw_orig(bat_priv, tt_request->src))
+			return true;
+
 		return send_my_tt_response(bat_priv, tt_request);
-	else
+	} else
 		return send_other_tt_response(bat_priv, tt_request);
 }
 
@@ -1637,6 +1642,10 @@ void handle_tt_response(struct bat_priv *bat_priv,
 		tt_response->tt_data,
 		(tt_response->flags & TT_FULL_TABLE ? 'F' : '.'));
 
+	/* we should have never asked a backbone gw */
+	if (bla_is_backbone_gw_orig(bat_priv, tt_response->src))
+		goto out;
+
 	orig_node = orig_hash_find(bat_priv, tt_response->src);
 	if (!orig_node)
 		goto out;
@@ -1955,6 +1964,10 @@ void tt_update_orig(struct bat_priv *bat_priv, struct orig_node *orig_node,
 	uint8_t orig_ttvn = (uint8_t)atomic_read(&orig_node->last_ttvn);
 	bool full_table = true;
 
+	/* don't care about a backbone gateways updates. */
+	if (bla_is_backbone_gw_orig(bat_priv, orig_node->orig))
+		return;
+
 	/* the ttvn increased by one -> we can apply the attached changes */
 	if (ttvn - orig_ttvn == 1) {
 		/* the OGM could not contain the changes due to their size or
-- 
1.7.7.1

