Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sun,  5 Feb 2012 18:55:22 +0100
Message-Id: <1328464522-7344-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: Remove declaration of only
	locally used functions
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

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
This should help us to find unused code. The test was done with
a script that was inspired by another script from d0tslash.
I would like to add this to the daily tests when this patch
was added to next.

set -e
defined="`nm -g --defined-only *.o|awk '{print $3}'|sort|uniq`"
used="`nm -g --undefined-only *.o|awk '{print $2}'|sort|uniq`"

for i in $defined; do
	found=0
	for j in $used; do
		[ "$i" = "$j" ] && found=1 && break
	done
	[ "$found" = "0" ] && echo $i
done
---
 translation-table.c |   22 ++++++++++++++--------
 translation-table.h |    8 --------
 2 files changed, 14 insertions(+), 16 deletions(-)

diff --git a/translation-table.c b/translation-table.c
index 9a6f315..c1abf48 100644
--- a/translation-table.c
+++ b/translation-table.c
@@ -30,6 +30,8 @@
 
 #include <linux/crc16.h>
 
+static void send_roam_adv(struct bat_priv *bat_priv, uint8_t *client,
+			  struct orig_node *orig_node);
 static void _tt_global_del(struct bat_priv *bat_priv,
 			   struct tt_global_entry *tt_global_entry,
 			   const char *message);
@@ -644,9 +646,10 @@ out:
 		tt_global_entry_free_ref(tt_global_entry);
 }
 
-void tt_global_del(struct bat_priv *bat_priv,
-		   struct orig_node *orig_node, const unsigned char *addr,
-		   const char *message, bool roaming)
+static void tt_global_del(struct bat_priv *bat_priv,
+			  struct orig_node *orig_node,
+			  const unsigned char *addr,
+			  const char *message, bool roaming)
 {
 	struct tt_global_entry *tt_global_entry = NULL;
 	struct tt_local_entry *tt_local_entry = NULL;
@@ -848,7 +851,8 @@ out:
 }
 
 /* Calculates the checksum of the local table of a given orig_node */
-uint16_t tt_global_crc(struct bat_priv *bat_priv, struct orig_node *orig_node)
+static uint16_t tt_global_crc(struct bat_priv *bat_priv,
+			      struct orig_node *orig_node)
 {
 	uint16_t total = 0, total_one;
 	struct hashtable_t *hash = bat_priv->tt_global_hash;
@@ -936,8 +940,10 @@ static void tt_req_list_free(struct bat_priv *bat_priv)
 	spin_unlock_bh(&bat_priv->tt_req_list_lock);
 }
 
-void tt_save_orig_buffer(struct bat_priv *bat_priv, struct orig_node *orig_node,
-			 const unsigned char *tt_buff, uint8_t tt_num_changes)
+static void tt_save_orig_buffer(struct bat_priv *bat_priv,
+				struct orig_node *orig_node,
+				const unsigned char *tt_buff,
+				uint8_t tt_num_changes)
 {
 	uint16_t tt_buff_len = tt_len(tt_num_changes);
 
@@ -1629,8 +1635,8 @@ unlock:
 	return ret;
 }
 
-void send_roam_adv(struct bat_priv *bat_priv, uint8_t *client,
-		   struct orig_node *orig_node)
+static void send_roam_adv(struct bat_priv *bat_priv, uint8_t *client,
+			  struct orig_node *orig_node)
 {
 	struct neigh_node *neigh_node = NULL;
 	struct sk_buff *skb = NULL;
diff --git a/translation-table.h b/translation-table.h
index c753633..bfebe26 100644
--- a/translation-table.h
+++ b/translation-table.h
@@ -39,23 +39,15 @@ int tt_global_add(struct bat_priv *bat_priv, struct orig_node *orig_node,
 int tt_global_seq_print_text(struct seq_file *seq, void *offset);
 void tt_global_del_orig(struct bat_priv *bat_priv,
 			struct orig_node *orig_node, const char *message);
-void tt_global_del(struct bat_priv *bat_priv,
-		   struct orig_node *orig_node, const unsigned char *addr,
-		   const char *message, bool roaming);
 struct orig_node *transtable_search(struct bat_priv *bat_priv,
 				    const uint8_t *src, const uint8_t *addr);
-void tt_save_orig_buffer(struct bat_priv *bat_priv, struct orig_node *orig_node,
-			 const unsigned char *tt_buff, uint8_t tt_num_changes);
 uint16_t tt_local_crc(struct bat_priv *bat_priv);
-uint16_t tt_global_crc(struct bat_priv *bat_priv, struct orig_node *orig_node);
 void tt_free(struct bat_priv *bat_priv);
 bool send_tt_response(struct bat_priv *bat_priv,
 		      struct tt_query_packet *tt_request);
 bool is_my_client(struct bat_priv *bat_priv, const uint8_t *addr);
 void handle_tt_response(struct bat_priv *bat_priv,
 			struct tt_query_packet *tt_response);
-void send_roam_adv(struct bat_priv *bat_priv, uint8_t *client,
-		   struct orig_node *orig_node);
 void tt_commit_changes(struct bat_priv *bat_priv);
 bool is_ap_isolated(struct bat_priv *bat_priv, uint8_t *src, uint8_t *dst);
 void tt_update_orig(struct bat_priv *bat_priv, struct orig_node *orig_node,
-- 
1.7.8.3

