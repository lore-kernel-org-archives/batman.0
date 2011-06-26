Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Mon, 27 Jun 2011 00:25:57 +0200
Message-Id: <1309127157-32507-1-git-send-email-ordex@autistici.org>
In-Reply-To: <1309091169-27226-1-git-send-email-ordex@autistici.org>
References: <1309091169-27226-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCHv2] batman-adv: pass a unique flag arg instead
	of a sequence of bool ones
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

now tt_local_event() takes a flags argument instead of a sequence of
boolean values which would grow up with the time.

Signed-off-by: Antonio Quartulli <ordex@autistici.org>
---

tt_local_remove() wasn't using the "bool roaming" parameter into account.

 translation-table.c |   22 ++++++++++++----------
 1 files changed, 12 insertions(+), 10 deletions(-)

diff --git a/translation-table.c b/translation-table.c
index 4208dc7..4537f02 100644
--- a/translation-table.c
+++ b/translation-table.c
@@ -143,8 +143,8 @@ static void tt_global_entry_free_ref(struct tt_global_entry *tt_global_entry)
 		kfree_rcu(tt_global_entry, rcu);
 }
 
-static void tt_local_event(struct bat_priv *bat_priv, uint8_t op,
-			   const uint8_t *addr, bool roaming)
+static void tt_local_event(struct bat_priv *bat_priv, const uint8_t *addr,
+			   int flags)
 {
 	struct tt_change_node *tt_change_node;
 
@@ -153,10 +153,10 @@ static void tt_local_event(struct bat_priv *bat_priv, uint8_t op,
 	if (!tt_change_node)
 		return;
 
-	tt_change_node->change.flags = op;
-	if (roaming)
-		tt_change_node->change.flags |= TT_CLIENT_ROAM;
+	/* NOPURGE flag has not to go on the wire */
+	flags &= ~TT_CLIENT_NOPURGE;
 
+	tt_change_node->change.flags = flags;
 	memcpy(tt_change_node->change.addr, addr, ETH_ALEN);
 
 	spin_lock_bh(&bat_priv->tt_changes_list_lock);
@@ -203,8 +203,6 @@ void tt_local_add(struct net_device *soft_iface, const uint8_t *addr)
 	if (!tt_local_entry)
 		goto out;
 
-	tt_local_event(bat_priv, NO_FLAGS, addr, false);
-
 	bat_dbg(DBG_TT, bat_priv,
 		"Creating new local tt entry: %pM (ttvn: %d)\n", addr,
 		(uint8_t)atomic_read(&bat_priv->ttvn));
@@ -218,6 +216,8 @@ void tt_local_add(struct net_device *soft_iface, const uint8_t *addr)
 	if (compare_eth(addr, soft_iface->dev_addr))
 		tt_local_entry->flags |= TT_CLIENT_NOPURGE;
 
+	tt_local_event(bat_priv, addr, tt_local_entry->flags);
+
 	hash_add(bat_priv->tt_local_hash, compare_ltt, choose_orig,
 		 tt_local_entry, &tt_local_entry->hash_entry);
 
@@ -386,7 +386,9 @@ void tt_local_remove(struct bat_priv *bat_priv, const uint8_t *addr,
 	if (!tt_local_entry)
 		goto out;
 
-	tt_local_event(bat_priv, TT_CLIENT_DEL, tt_local_entry->addr, roaming);
+	tt_local_event(bat_priv, tt_local_entry->addr,
+		       tt_local_entry->flags | TT_CLIENT_DEL |
+		       (roaming ? TT_CLIENT_ROAM : NO_FLAGS));
 	tt_local_del(bat_priv, tt_local_entry, message);
 out:
 	if (tt_local_entry)
@@ -416,8 +418,8 @@ static void tt_local_purge(struct bat_priv *bat_priv)
 					    TT_LOCAL_TIMEOUT * 1000))
 				continue;
 
-			tt_local_event(bat_priv, TT_CLIENT_DEL,
-				       tt_local_entry->addr, false);
+			tt_local_event(bat_priv, tt_local_entry->addr,
+				       tt_local_entry->flags | TT_CLIENT_DEL);
 			atomic_dec(&bat_priv->num_local_tt);
 			bat_dbg(DBG_TT, bat_priv, "Deleting local "
 				"tt entry (%pM): timed out\n",
-- 
1.7.3.4

