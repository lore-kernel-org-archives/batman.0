Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Wed,  7 Aug 2013 18:28:56 +0200
Message-Id: <1375892936-3602-3-git-send-email-ordex@autistici.org>
In-Reply-To: <1375892936-3602-1-git-send-email-ordex@autistici.org>
References: <1375892936-3602-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCHv2 2/2] batman-adv: make the backbone gw check
	VLAN specific
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
Cc: Simon Wunderlich <siwu@hrz.tu-chemnitz.de>, Antonio Quartulli <antonio@open-mesh.com>

From: Antonio Quartulli <antonio@open-mesh.com>

The backbone gw check has to be VLAN specific so that code
using it can specify VID where the check has to be done.

In the TT code, the check has been moved into the
tt_global_add() function so that it can be performed on a
per-entry basis instead of ignoring all the TT data received
from another backbone node. Only TT global entries belonging
to the VLAN where the backbone node is connected to are
skipped.
All the other spots where the TT code was checking whether a
node is a backbone have been removed.

Moreover, batadv_bla_is_backbone_gw_orig() now returns bool
since it used to return only 1 or 0.

Cc: Simon Wunderlich <siwu@hrz.tu-chemnitz.de>
Signed-off-by: Antonio Quartulli <antonio@open-mesh.com>
---
 bridge_loop_avoidance.c | 19 +++++++++++--------
 bridge_loop_avoidance.h | 10 ++++++----
 translation-table.c     | 41 ++++++++++-------------------------------
 3 files changed, 27 insertions(+), 43 deletions(-)

diff --git a/bridge_loop_avoidance.c b/bridge_loop_avoidance.c
index 3b3867d..28eb5e6 100644
--- a/bridge_loop_avoidance.c
+++ b/bridge_loop_avoidance.c
@@ -1315,12 +1315,14 @@ out:
 
 /* @bat_priv: the bat priv with all the soft interface information
  * @orig: originator mac address
+ * @vid: VLAN identifier
  *
- * check if the originator is a gateway for any VLAN ID.
+ * Check if the originator is a gateway for the VLAN identified by vid.
  *
- * returns 1 if it is found, 0 otherwise
+ * Returns true if orig is a backbone for this vid, false otherwise.
  */
-int batadv_bla_is_backbone_gw_orig(struct batadv_priv *bat_priv, uint8_t *orig)
+bool batadv_bla_is_backbone_gw_orig(struct batadv_priv *bat_priv, uint8_t *orig,
+				    unsigned short vid)
 {
 	struct batadv_hashtable *hash = bat_priv->bla.backbone_hash;
 	struct hlist_head *head;
@@ -1328,25 +1330,26 @@ int batadv_bla_is_backbone_gw_orig(struct batadv_priv *bat_priv, uint8_t *orig)
 	int i;
 
 	if (!atomic_read(&bat_priv->bridge_loop_avoidance))
-		return 0;
+		return false;
 
 	if (!hash)
-		return 0;
+		return false;
 
 	for (i = 0; i < hash->size; i++) {
 		head = &hash->table[i];
 
 		rcu_read_lock();
 		hlist_for_each_entry_rcu(backbone_gw, head, hash_entry) {
-			if (batadv_compare_eth(backbone_gw->orig, orig)) {
+			if (batadv_compare_eth(backbone_gw->orig, orig) &&
+			    backbone_gw->vid == vid) {
 				rcu_read_unlock();
-				return 1;
+				return true;
 			}
 		}
 		rcu_read_unlock();
 	}
 
-	return 0;
+	return false;
 }
 
 
diff --git a/bridge_loop_avoidance.h b/bridge_loop_avoidance.h
index 4b102e7..da173e7 100644
--- a/bridge_loop_avoidance.h
+++ b/bridge_loop_avoidance.h
@@ -30,7 +30,8 @@ int batadv_bla_is_backbone_gw(struct sk_buff *skb,
 int batadv_bla_claim_table_seq_print_text(struct seq_file *seq, void *offset);
 int batadv_bla_backbone_table_seq_print_text(struct seq_file *seq,
 					     void *offset);
-int batadv_bla_is_backbone_gw_orig(struct batadv_priv *bat_priv, uint8_t *orig);
+bool batadv_bla_is_backbone_gw_orig(struct batadv_priv *bat_priv, uint8_t *orig,
+				    unsigned short vid);
 int batadv_bla_check_bcast_duplist(struct batadv_priv *bat_priv,
 				   struct sk_buff *skb);
 void batadv_bla_update_orig_address(struct batadv_priv *bat_priv,
@@ -74,10 +75,11 @@ static inline int batadv_bla_backbone_table_seq_print_text(struct seq_file *seq,
 	return 0;
 }
 
-static inline int batadv_bla_is_backbone_gw_orig(struct batadv_priv *bat_priv,
-						 uint8_t *orig)
+static inline bool batadv_bla_is_backbone_gw_orig(struct batadv_priv *bat_priv,
+						  uint8_t *orig,
+						  unsigned short vid)
 {
-	return 0;
+	return false;
 }
 
 static inline int
diff --git a/translation-table.c b/translation-table.c
index 37f34a8..b6f8a9a 100644
--- a/translation-table.c
+++ b/translation-table.c
@@ -1153,6 +1153,10 @@ static bool batadv_tt_global_add(struct batadv_priv *bat_priv,
 	struct batadv_tt_common_entry *common;
 	uint16_t local_flags;
 
+	/* ignore global entries from backbone nodes */
+	if (batadv_bla_is_backbone_gw_orig(bat_priv, orig_node->orig, vid))
+		return true;
+
 	tt_global_entry = batadv_tt_global_hash_find(bat_priv, tt_addr, vid);
 	tt_local_entry = batadv_tt_local_hash_find(bat_priv, tt_addr, vid);
 
@@ -2136,7 +2140,8 @@ static bool batadv_tt_global_check_crc(struct batadv_orig_node *orig_node,
 		 * the CRC as we ignore all the global entries over it
 		 */
 		if (batadv_bla_is_backbone_gw_orig(orig_node->bat_priv,
-						   orig_node->orig))
+						   orig_node->orig,
+						   ntohs(tt_vlan_tmp->vid)))
 			continue;
 
 		vlan = batadv_orig_node_vlan_get(orig_node,
@@ -2184,7 +2189,8 @@ static void batadv_tt_global_update_crc(struct batadv_priv *bat_priv,
 		/* if orig_node is a backbone node for this VLAN, don't compute
 		 * the CRC as we ignore all the global entries over it
 		 */
-		if (batadv_bla_is_backbone_gw_orig(bat_priv, orig_node->orig))
+		if (batadv_bla_is_backbone_gw_orig(bat_priv, orig_node->orig,
+						   vlan->vid))
 			continue;
 
 		crc = batadv_tt_global_crc(bat_priv, orig_node, vlan->vid);
@@ -2528,16 +2534,11 @@ static bool batadv_send_tt_response(struct batadv_priv *bat_priv,
 				    struct batadv_tvlv_tt_data *tt_data,
 				    uint8_t *req_src, uint8_t *req_dst)
 {
-	if (batadv_is_my_mac(bat_priv, req_dst)) {
-		/* don't answer backbone gws! */
-		if (batadv_bla_is_backbone_gw_orig(bat_priv, req_src))
-			return true;
-
+	if (batadv_is_my_mac(bat_priv, req_dst))
 		return batadv_send_my_tt_response(bat_priv, tt_data, req_src);
-	} else {
+	else
 		return batadv_send_other_tt_response(bat_priv, tt_data,
 						     req_src, req_dst);
-	}
 }
 
 static void _batadv_tt_update_changes(struct batadv_priv *bat_priv,
@@ -2669,10 +2670,6 @@ static void batadv_handle_tt_response(struct batadv_priv *bat_priv,
 		   resp_src, tt_data->ttvn, num_entries,
 		   (tt_data->flags & BATADV_TT_FULL_TABLE ? 'F' : '.'));
 
-	/* we should have never asked a backbone gw */
-	if (batadv_bla_is_backbone_gw_orig(bat_priv, resp_src))
-		goto out;
-
 	orig_node = batadv_orig_hash_find(bat_priv, resp_src);
 	if (!orig_node)
 		goto out;
@@ -3053,10 +3050,6 @@ static void batadv_tt_update_orig(struct batadv_priv *bat_priv,
 	struct batadv_tvlv_tt_vlan_data *tt_vlan;
 	bool full_table = true;
 
-	/* don't care about a backbone gateways updates. */
-	if (batadv_bla_is_backbone_gw_orig(bat_priv, orig_node->orig))
-		return;
-
 	tt_vlan = (struct batadv_tvlv_tt_vlan_data *)tt_buff;
 	/* orig table not initialised AND first diff is in the OGM OR the ttvn
 	 * increased by one -> we can apply the attached changes
@@ -3178,13 +3171,6 @@ bool batadv_tt_add_temporary_global_entry(struct batadv_priv *bat_priv,
 {
 	bool ret = false;
 
-	/* if the originator is a backbone node (meaning it belongs to the same
-	 * LAN of this node) the temporary client must not be added because to
-	 * reach such destination the node must use the LAN instead of the mesh
-	 */
-	if (batadv_bla_is_backbone_gw_orig(bat_priv, orig_node->orig))
-		goto out;
-
 	if (!batadv_tt_global_add(bat_priv, orig_node, addr, vid,
 				  BATADV_TT_CLIENT_TEMP,
 				  atomic_read(&orig_node->last_ttvn)))
@@ -3345,13 +3331,6 @@ static int batadv_roam_tvlv_unicast_handler_v1(struct batadv_priv *bat_priv,
 	if (!batadv_is_my_mac(bat_priv, dst))
 		return NET_RX_DROP;
 
-	/* check if it is a backbone gateway. we don't accept
-	 * roaming advertisement from it, as it has the same
-	 * entries as we have.
-	 */
-	if (batadv_bla_is_backbone_gw_orig(bat_priv, src))
-		goto out;
-
 	if (tvlv_value_len < sizeof(*roaming_adv))
 		goto out;
 
-- 
1.8.1.5

