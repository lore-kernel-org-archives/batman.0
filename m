Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Thu, 23 Apr 2015 18:22:24 +0200
Message-Id: <1429806145-28753-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH 1/2] batman-adv: Clarify calculation
	precedence for '&' and '?'
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

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/bat_iv_ogm.c        |  2 +-
 net/batman-adv/main.h              |  2 +-
 net/batman-adv/translation-table.c | 42 +++++++++++++++++++-------------------
 3 files changed, 23 insertions(+), 23 deletions(-)

diff --git a/net/batman-adv/bat_iv_ogm.c b/net/batman-adv/bat_iv_ogm.c
index 9adbc61..753383c 100644
--- a/net/batman-adv/bat_iv_ogm.c
+++ b/net/batman-adv/bat_iv_ogm.c
@@ -479,7 +479,7 @@ static void batadv_iv_ogm_send_to_if(struct batadv_forw_packet *forw_packet,
 			   batadv_ogm_packet->orig,
 			   ntohl(batadv_ogm_packet->seqno),
 			   batadv_ogm_packet->tq, batadv_ogm_packet->ttl,
-			   (batadv_ogm_packet->flags & BATADV_DIRECTLINK ?
+			   ((batadv_ogm_packet->flags & BATADV_DIRECTLINK) ?
 			    "on" : "off"),
 			   hard_iface->net_dev->name,
 			   hard_iface->net_dev->dev_addr);
diff --git a/net/batman-adv/main.h b/net/batman-adv/main.h
index 4cb77ed..3c981d0 100644
--- a/net/batman-adv/main.h
+++ b/net/batman-adv/main.h
@@ -182,7 +182,7 @@ struct batadv_ogm_packet;
 struct seq_file;
 struct sk_buff;
 
-#define BATADV_PRINT_VID(vid) (vid & BATADV_VLAN_HAS_TAG ? \
+#define BATADV_PRINT_VID(vid) ((vid & BATADV_VLAN_HAS_TAG) ? \
 			       (int)(vid & VLAN_VID_MASK) : -1)
 
 extern char batadv_routing_algo[];
diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index 0611c58..b482495 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -973,17 +973,17 @@ int batadv_tt_local_seq_print_text(struct seq_file *seq, void *offset)
 				   " * %pM %4i [%c%c%c%c%c%c] %3u.%03u   (%#.8x)\n",
 				   tt_common_entry->addr,
 				   BATADV_PRINT_VID(tt_common_entry->vid),
-				   (tt_common_entry->flags &
-				    BATADV_TT_CLIENT_ROAM ? 'R' : '.'),
+				   ((tt_common_entry->flags &
+				     BATADV_TT_CLIENT_ROAM) ? 'R' : '.'),
 				   no_purge ? 'P' : '.',
-				   (tt_common_entry->flags &
-				    BATADV_TT_CLIENT_NEW ? 'N' : '.'),
-				   (tt_common_entry->flags &
-				    BATADV_TT_CLIENT_PENDING ? 'X' : '.'),
-				   (tt_common_entry->flags &
-				    BATADV_TT_CLIENT_WIFI ? 'W' : '.'),
-				   (tt_common_entry->flags &
-				    BATADV_TT_CLIENT_ISOLA ? 'I' : '.'),
+				   ((tt_common_entry->flags &
+				     BATADV_TT_CLIENT_NEW) ? 'N' : '.'),
+				   ((tt_common_entry->flags &
+				     BATADV_TT_CLIENT_PENDING) ? 'X' : '.'),
+				   ((tt_common_entry->flags &
+				     BATADV_TT_CLIENT_WIFI) ? 'W' : '.'),
+				   ((tt_common_entry->flags &
+				     BATADV_TT_CLIENT_ISOLA) ? 'I' : '.'),
 				   no_purge ? 0 : last_seen_secs,
 				   no_purge ? 0 : last_seen_msecs,
 				   vlan->tt.crc);
@@ -1547,10 +1547,10 @@ batadv_tt_global_print_entry(struct batadv_priv *bat_priv,
 			   BATADV_PRINT_VID(tt_global_entry->common.vid),
 			   best_entry->ttvn, best_entry->orig_node->orig,
 			   last_ttvn, vlan->tt.crc,
-			   (flags & BATADV_TT_CLIENT_ROAM ? 'R' : '.'),
-			   (flags & BATADV_TT_CLIENT_WIFI ? 'W' : '.'),
-			   (flags & BATADV_TT_CLIENT_ISOLA ? 'I' : '.'),
-			   (flags & BATADV_TT_CLIENT_TEMP ? 'T' : '.'));
+			   ((flags & BATADV_TT_CLIENT_ROAM) ? 'R' : '.'),
+			   ((flags & BATADV_TT_CLIENT_WIFI) ? 'W' : '.'),
+			   ((flags & BATADV_TT_CLIENT_ISOLA) ? 'I' : '.'),
+			   ((flags & BATADV_TT_CLIENT_TEMP) ? 'T' : '.'));
 
 		batadv_orig_node_vlan_free_ref(vlan);
 	}
@@ -1579,10 +1579,10 @@ print_list:
 			   BATADV_PRINT_VID(tt_global_entry->common.vid),
 			   orig_entry->ttvn, orig_entry->orig_node->orig,
 			   last_ttvn, vlan->tt.crc,
-			   (flags & BATADV_TT_CLIENT_ROAM ? 'R' : '.'),
-			   (flags & BATADV_TT_CLIENT_WIFI ? 'W' : '.'),
-			   (flags & BATADV_TT_CLIENT_ISOLA ? 'I' : '.'),
-			   (flags & BATADV_TT_CLIENT_TEMP ? 'T' : '.'));
+			   ((flags & BATADV_TT_CLIENT_ROAM) ? 'R' : '.'),
+			   ((flags & BATADV_TT_CLIENT_WIFI) ? 'W' : '.'),
+			   ((flags & BATADV_TT_CLIENT_ISOLA) ? 'I' : '.'),
+			   ((flags & BATADV_TT_CLIENT_TEMP) ? 'T' : '.'));
 
 		batadv_orig_node_vlan_free_ref(vlan);
 	}
@@ -2548,7 +2548,7 @@ static bool batadv_send_other_tt_response(struct batadv_priv *bat_priv,
 	batadv_dbg(BATADV_DBG_TT, bat_priv,
 		   "Received TT_REQUEST from %pM for ttvn: %u (%pM) [%c]\n",
 		   req_src, tt_data->ttvn, req_dst,
-		   (tt_data->flags & BATADV_TT_FULL_TABLE ? 'F' : '.'));
+		   ((tt_data->flags & BATADV_TT_FULL_TABLE) ? 'F' : '.'));
 
 	/* Let's get the orig node of the REAL destination */
 	req_dst_orig_node = batadv_orig_hash_find(bat_priv, req_dst);
@@ -2679,7 +2679,7 @@ static bool batadv_send_my_tt_response(struct batadv_priv *bat_priv,
 	batadv_dbg(BATADV_DBG_TT, bat_priv,
 		   "Received TT_REQUEST from %pM for ttvn: %u (me) [%c]\n",
 		   req_src, tt_data->ttvn,
-		   (tt_data->flags & BATADV_TT_FULL_TABLE ? 'F' : '.'));
+		   ((tt_data->flags & BATADV_TT_FULL_TABLE) ? 'F' : '.'));
 
 	spin_lock_bh(&bat_priv->tt.commit_lock);
 
@@ -2918,7 +2918,7 @@ static void batadv_handle_tt_response(struct batadv_priv *bat_priv,
 	batadv_dbg(BATADV_DBG_TT, bat_priv,
 		   "Received TT_RESPONSE from %pM for ttvn %d t_size: %d [%c]\n",
 		   resp_src, tt_data->ttvn, num_entries,
-		   (tt_data->flags & BATADV_TT_FULL_TABLE ? 'F' : '.'));
+		   ((tt_data->flags & BATADV_TT_FULL_TABLE) ? 'F' : '.'));
 
 	orig_node = batadv_orig_hash_find(bat_priv, resp_src);
 	if (!orig_node)
-- 
2.1.4

