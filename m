Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Tue,  5 Jul 2011 17:23:05 +0200
Message-Id: <1309879385-21224-7-git-send-email-ordex@autistici.org>
In-Reply-To: <1309879385-21224-1-git-send-email-ordex@autistici.org>
References: <1309879385-21224-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCH 6/6] batman-adv: global entries are marked as
	PENDING in case of roaming
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

To keep consistency of other originator tables, new clients detected as
roamed, are kept in the global table but are marked as TT_CLIENT_PENDING
as well. They are purged as well once the new ttvn is received by the
corresponding originator. Moreover they need to be considered as removed
in case of global transtable lookup.

Signed-off-by: Antonio Quartulli <ordex@autistici.org>
---
 translation-table.c |   23 ++++++++++++++++-------
 1 files changed, 16 insertions(+), 7 deletions(-)

diff --git a/translation-table.c b/translation-table.c
index fb48f04..6efa72c 100644
--- a/translation-table.c
+++ b/translation-table.c
@@ -227,8 +227,9 @@ void tt_local_add(struct net_device *soft_iface, const uint8_t *addr)
 	if (tt_global_entry) {
 		/* This node is probably going to update its tt table */
 		tt_global_entry->orig_node->tt_poss_change = true;
-		_tt_global_del(bat_priv, tt_global_entry,
-			       "local tt received");
+		/* The global entry has to be marked as PENDING and has to be
+		 * kept for consistency purpose */
+		tt_global_entry->flags |= TT_CLIENT_PENDING;
 		send_roam_adv(bat_priv, tt_global_entry->addr,
 			      tt_global_entry->orig_node);
 	}
@@ -771,6 +772,11 @@ struct orig_node *transtable_search(struct bat_priv *bat_priv,
 	if (!atomic_inc_not_zero(&tt_global_entry->orig_node->refcount))
 		goto free_tt;
 
+	/* A global client marked as PENDING has already moved from that
+	 * originator */
+	if (tt_global_entry->flags & TT_CLIENT_PENDING)
+		goto free_tt;
+
 	orig_node = tt_global_entry->orig_node;
 
 free_tt:
@@ -1644,9 +1650,10 @@ static void tt_purge_flags(struct hashtable_t *hash, uint16_t flags)
 
 }
 
-static void tt_purge_local_pending_clients(struct bat_priv *bat_priv)
+static void tt_purge_pending_clients(struct bat_priv *bat_priv,
+				     struct hashtable_t *hash,
+				     const char *table_name)
 {
-	struct hashtable_t *hash = bat_priv->tt_local_hash;
 	struct tt_local_entry *tt_local_entry;
 	struct hlist_node *node, *node_tmp;
 	struct hlist_head *head;
@@ -1663,8 +1670,9 @@ static void tt_purge_local_pending_clients(struct bat_priv *bat_priv)
 			if (!(tt_local_entry->flags & TT_CLIENT_PENDING))
 				continue;
 
-			bat_dbg(DBG_TT, bat_priv, "Deleting local tt entry "
-				"(%pM): pending\n", tt_local_entry->addr);
+			bat_dbg(DBG_TT, bat_priv, "Deleting %s tt entry "
+				"(%pM): pending\n", tt_local_entry->addr,
+				table_name);
 
 			atomic_dec(&bat_priv->num_local_tt);
 			hlist_del_rcu(node);
@@ -1678,7 +1686,8 @@ static void tt_purge_local_pending_clients(struct bat_priv *bat_priv)
 void tt_commit_changes(struct bat_priv *bat_priv)
 {
 	tt_purge_flags(bat_priv->tt_local_hash, TT_CLIENT_ROAM);
-	tt_purge_local_pending_clients(bat_priv);
+	tt_purge_pending_clients(bat_priv, bat_priv->tt_local_hash, "local");
+	tt_purge_pending_clients(bat_priv, bat_priv->tt_global_hash, "global");
 
 	/* Increment the TTVN only once per OGM interval */
 	atomic_inc(&bat_priv->ttvn);
-- 
1.7.3.4

