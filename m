Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Tue,  3 Apr 2012 23:50:20 +0200
Message-Id: <1333489822-27692-4-git-send-email-ordex@autistici.org>
In-Reply-To: <1333489822-27692-1-git-send-email-ordex@autistici.org>
References: <1333489822-27692-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCH 3/5] batman-adv: beautify tt_global_add()
	argument list
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

Instead of adding a new bool argument each time it is needed, it is better (and
simpler) to pass an 8bit flag argument which contains all the needed flags

Signed-off-by: Antonio Quartulli <ordex@autistici.org>
---
 routing.c           |    2 +-
 translation-table.c |   32 +++++++++++++++++---------------
 translation-table.h |    3 +--
 3 files changed, 19 insertions(+), 18 deletions(-)

diff --git a/routing.c b/routing.c
index 795d3af..2435237 100644
--- a/routing.c
+++ b/routing.c
@@ -683,7 +683,7 @@ int recv_roam_adv(struct sk_buff *skb, struct hard_iface *recv_if)
 		roam_adv_packet->src, roam_adv_packet->client);
 
 	tt_global_add(bat_priv, orig_node, roam_adv_packet->client,
-		      atomic_read(&orig_node->last_ttvn) + 1, true, false);
+		      TT_CLIENT_ROAM, atomic_read(&orig_node->last_ttvn) + 1);
 
 	/* Roaming phase starts: I have new information but the ttvn has not
 	 * been incremented yet. This flag will make me check all the incoming
diff --git a/translation-table.c b/translation-table.c
index fa1ac3a..4898e99 100644
--- a/translation-table.c
+++ b/translation-table.c
@@ -248,7 +248,6 @@ void tt_local_add(struct net_device *soft_iface, const uint8_t *addr,
 		tt_local_entry->common.flags |= TT_CLIENT_WIFI;
 	atomic_set(&tt_local_entry->common.refcount, 2);
 	tt_local_entry->last_seen = jiffies;
-	tt_local_entry->common.added_at = tt_local_entry->last_seen;
 
 
 	/* the batman interface mac address should never be purged */
@@ -597,24 +596,22 @@ static void tt_global_add_orig_entry(struct tt_global_entry *tt_global_entry,
 
 /* caller must hold orig_node refcount */
 int tt_global_add(struct bat_priv *bat_priv, struct orig_node *orig_node,
-		  const unsigned char *tt_addr, uint8_t ttvn, bool roaming,
-		  bool wifi)
+		  const unsigned char *tt_addr, uint8_t flags, uint8_t ttvn)
 {
 	struct tt_global_entry *tt_global_entry = NULL;
+	struct tt_orig_list_entry *orig_entry;
 	int ret = 0;
 	int hash_added;
 
 	tt_global_entry = tt_global_hash_find(bat_priv, tt_addr);
 
 	if (!tt_global_entry) {
-		tt_global_entry = kzalloc(sizeof(*tt_global_entry),
-					  GFP_ATOMIC);
+		tt_global_entry = kzalloc(sizeof(*tt_global_entry), GFP_ATOMIC);
 		if (!tt_global_entry)
 			goto out;
 
 		memcpy(tt_global_entry->common.addr, tt_addr, ETH_ALEN);
-
-		tt_global_entry->common.flags = NO_FLAGS;
+		tt_global_entry->common.flags = flags;
 		tt_global_entry->roam_at = 0;
 		atomic_set(&tt_global_entry->common.refcount, 2);
 
@@ -648,14 +645,19 @@ int tt_global_add(struct bat_priv *bat_priv, struct orig_node *orig_node,
 			tt_global_entry->roam_at = 0;
 		}
 
-		if (!tt_global_entry_has_orig(tt_global_entry, orig_node))
+		orig_entry = tt_global_entry_has_orig(tt_global_entry,
+						      orig_node);
+		if (!orig_entry)
 			tt_global_add_orig_entry(tt_global_entry, orig_node,
 						 ttvn);
+		else
+			/* if we are "adding" global entry, we may want to
+			 * update the ttvn anyway. Perhaps the global entry is
+			 * here with a wrong ttvn because it was temporary added
+			 * before */
+			orig_entry->ttvn = ttvn;
 	}
 
-	if (wifi)
-		tt_global_entry->common.flags |= TT_CLIENT_WIFI;
-
 	bat_dbg(DBG_TT, bat_priv,
 		"Creating new global tt entry: %pM (via %pM)\n",
 		tt_global_entry->common.addr, orig_node->orig);
@@ -663,7 +665,7 @@ int tt_global_add(struct bat_priv *bat_priv, struct orig_node *orig_node,
 out_remove:
 	/* remove address from local hash if present */
 	tt_local_remove(bat_priv, tt_global_entry->common.addr,
-			"global tt received", roaming);
+			"global tt received", flags & TT_CLIENT_ROAM);
 	ret = 1;
 out:
 	if (tt_global_entry)
@@ -1267,7 +1269,7 @@ static int tt_global_valid_entry(const void *entry_ptr, const void *data_ptr)
 	tt_global_entry = container_of(tt_common_entry, struct tt_global_entry,
 				       common);
 
-	return tt_global_entry_has_orig(tt_global_entry, orig_node);
+	return (tt_global_entry_has_orig(tt_global_entry, orig_node) != NULL);
 }
 
 static struct sk_buff *tt_response_fill_table(uint16_t tt_len, uint8_t ttvn,
@@ -1674,9 +1676,9 @@ static void _tt_update_changes(struct bat_priv *bat_priv,
 				      (tt_change + i)->flags & TT_CLIENT_ROAM);
 		else
 			if (!tt_global_add(bat_priv, orig_node,
-					   (tt_change + i)->addr, ttvn, false,
+					   (tt_change + i)->addr,
 					   (tt_change + i)->flags &
-							TT_CLIENT_WIFI))
+							TT_CLIENT_WIFI, ttvn))
 				/* In case of problem while storing a
 				 * global_entry, we stop the updating
 				 * procedure without committing the
diff --git a/translation-table.h b/translation-table.h
index c43374d..3239b72 100644
--- a/translation-table.h
+++ b/translation-table.h
@@ -34,8 +34,7 @@ int tt_local_seq_print_text(struct seq_file *seq, void *offset);
 void tt_global_add_orig(struct bat_priv *bat_priv, struct orig_node *orig_node,
 			const unsigned char *tt_buff, int tt_buff_len);
 int tt_global_add(struct bat_priv *bat_priv, struct orig_node *orig_node,
-		  const unsigned char *addr, uint8_t ttvn, bool roaming,
-		  bool wifi);
+		  const unsigned char *addr, uint8_t flags, uint8_t ttvn);
 int tt_global_seq_print_text(struct seq_file *seq, void *offset);
 void tt_global_del_orig(struct bat_priv *bat_priv,
 			struct orig_node *orig_node, const char *message);
-- 
1.7.9.4

