Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Tue, 31 Jul 2012 14:14:31 +0200
Message-Id: <1343736871-7131-1-git-send-email-ordex@autistici.org>
In-Reply-To: <1343603730-3824-1-git-send-email-ordex@autistici.org>
References: <1343603730-3824-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCHv2] batman-adv: pass the WIFI flag from the
	local to global entry
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

in case of client roaming a new global entry is added while a corresponding
local one is still present. In this case the node can safely pass the WIFI flag
from the local to the global entry.

This change is required to let the AP-isolation correctly working in case of
roaming: if a generic WIFI client C roams from node A to B, A adds a global
entry for C without adding any WIFI flag. The latter will be set only later,
once A has received C's advertisement from B. In this time period the
AP-Isolation (if enabled) would not correctly work since C is not marked as
WIFI, so allowing it to communicate with other WIFI clients.

Signed-off-by: Antonio Quartulli <ordex@autistici.org>
---

v2:
- commit message rearranged

 translation-table.c |   36 ++++++++++++++++++++++++++++--------
 1 file changed, 28 insertions(+), 8 deletions(-)

diff --git a/translation-table.c b/translation-table.c
index 37ae4a9..2aacde9 100644
--- a/translation-table.c
+++ b/translation-table.c
@@ -500,21 +500,30 @@ batadv_tt_local_set_pending(struct batadv_priv *bat_priv,
 		   tt_local_entry->common.addr, message);
 }
 
+static void __batadv_tt_local_remove(struct batadv_priv *bat_priv,
+				     struct batadv_tt_local_entry *tt_local,
+				     const char *message, bool roaming)
+{
+	uint16_t flags;
+
+	flags = BATADV_TT_CLIENT_DEL;
+	if (roaming)
+		flags |= BATADV_TT_CLIENT_ROAM;
+
+	batadv_tt_local_set_pending(bat_priv, tt_local, flags, message);
+}
+
 void batadv_tt_local_remove(struct batadv_priv *bat_priv, const uint8_t *addr,
 			    const char *message, bool roaming)
 {
 	struct batadv_tt_local_entry *tt_local_entry = NULL;
-	uint16_t flags;
 
 	tt_local_entry = batadv_tt_local_hash_find(bat_priv, addr);
 	if (!tt_local_entry)
 		goto out;
 
-	flags = BATADV_TT_CLIENT_DEL;
-	if (roaming)
-		flags |= BATADV_TT_CLIENT_ROAM;
+	__batadv_tt_local_remove(bat_priv, tt_local_entry, message, roaming);
 
-	batadv_tt_local_set_pending(bat_priv, tt_local_entry, flags, message);
 out:
 	if (tt_local_entry)
 		batadv_tt_local_entry_free_ref(tt_local_entry);
@@ -721,9 +730,11 @@ int batadv_tt_global_add(struct batadv_priv *bat_priv,
 			 uint8_t ttvn)
 {
 	struct batadv_tt_global_entry *tt_global_entry = NULL;
+	struct batadv_tt_local_entry *tt_local_entry = NULL;
 	int ret = 0;
 	int hash_added;
 	struct batadv_tt_common_entry *common;
+	uint16_t wifi_flag;
 
 	tt_global_entry = batadv_tt_global_hash_find(bat_priv, tt_addr);
 
@@ -789,14 +800,23 @@ int batadv_tt_global_add(struct batadv_priv *bat_priv,
 		   tt_global_entry->common.addr, orig_node->orig);
 
 out_remove:
+	tt_local_entry = batadv_tt_local_hash_find(bat_priv, tt_addr);
+	if (!tt_local_entry)
+		goto out;
+
+	wifi_flag = tt_local_entry->common.flags & BATADV_TT_CLIENT_WIFI;
+	tt_global_entry->common.flags |= wifi_flag;
+
 	/* remove address from local hash if present */
-	batadv_tt_local_remove(bat_priv, tt_global_entry->common.addr,
-			       "global tt received",
-			       flags & BATADV_TT_CLIENT_ROAM);
+	__batadv_tt_local_remove(bat_priv, tt_local_entry, "global tt received",
+				 flags & BATADV_TT_CLIENT_ROAM);
+
 	ret = 1;
 out:
 	if (tt_global_entry)
 		batadv_tt_global_entry_free_ref(tt_global_entry);
+	if (tt_local_entry)
+		batadv_tt_local_entry_free_ref(tt_local_entry);
 	return ret;
 }
 
-- 
1.7.9.4

