Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Sun, 10 Jul 2011 01:50:57 +0200
Message-Id: <1310255457-26009-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: handle hash_add() return value
	in the TT code
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
To: "B.A.T.M.A.N" <b.a.t.m.a.n@lists.open-mesh.org>

hash_add() can fail and for this reason its return value has to be
correctly interpreted to avoid memory leaks.

Signed-off-by: Antonio Quartulli <ordex@autistici.org>
---

This patch needs
"[PATCH] batman-adv: hash_add() has to discriminate on the return value"
to work

 translation-table.c |   27 +++++++++++++++++++++------
 1 files changed, 21 insertions(+), 6 deletions(-)

diff --git a/translation-table.c b/translation-table.c
index fb6931d..267a287 100644
--- a/translation-table.c
+++ b/translation-table.c
@@ -188,6 +188,7 @@ void tt_local_add(struct net_device *soft_iface, const uint8_t *addr)
 	struct bat_priv *bat_priv = netdev_priv(soft_iface);
 	struct tt_local_entry *tt_local_entry = NULL;
 	struct tt_global_entry *tt_global_entry = NULL;
+	int hash_added;
 
 	tt_local_entry = tt_local_hash_find(bat_priv, addr);
 
@@ -220,8 +221,14 @@ void tt_local_add(struct net_device *soft_iface, const uint8_t *addr)
 	 * (consistency check) */
 	tt_local_entry->flags |= TT_CLIENT_NEW;
 
-	hash_add(bat_priv->tt_local_hash, compare_ltt, choose_orig,
-		 tt_local_entry, &tt_local_entry->hash_entry);
+	hash_added = hash_add(bat_priv->tt_local_hash, compare_ltt,
+			      choose_orig, tt_local_entry,
+			      &tt_local_entry->hash_entry);
+	if (hash_added != 0)
+		tt_local_entry_free_ref(tt_local_entry);
+
+	if (hash_added < 0)
+		goto out;
 
 	/* remove address from global hash if present */
 	tt_global_entry = tt_global_hash_find(bat_priv, addr);
@@ -500,6 +507,7 @@ int tt_global_add(struct bat_priv *bat_priv, struct orig_node *orig_node,
 	struct tt_global_entry *tt_global_entry;
 	struct orig_node *orig_node_tmp;
 	int ret = 0;
+	int hash_added;
 
 	tt_global_entry = tt_global_hash_find(bat_priv, tt_addr);
 
@@ -519,10 +527,17 @@ int tt_global_add(struct bat_priv *bat_priv, struct orig_node *orig_node,
 		tt_global_entry->roam_at = 0;
 		atomic_set(&tt_global_entry->refcount, 2);
 
-		hash_add(bat_priv->tt_global_hash, compare_gtt,
-			 choose_orig, tt_global_entry,
-			 &tt_global_entry->hash_entry);
-		atomic_inc(&orig_node->tt_size);
+		hash_added = hash_add(bat_priv->tt_global_hash, compare_gtt,
+				      choose_orig, tt_global_entry,
+				      &tt_global_entry->hash_entry);
+		if (hash_added != 0)
+			tt_global_entry_free_ref(tt_global_entry);
+
+		if (hash_added < 0)
+			goto out;
+
+		if (!hash_added)
+			atomic_inc(&orig_node->tt_size);
 	} else {
 		if (tt_global_entry->orig_node != orig_node) {
 			atomic_dec(&tt_global_entry->orig_node->tt_size);
-- 
1.7.3.4

