Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Thu, 21 Jun 2012 22:28:54 +0200
Message-Id: <1340310534-7578-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: prepend BATADV_ to TT flags in
	comments
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

After having added the BATADV_ prefix to all the TT_CLIENT flags, we have to
add the same prefix in every comment where they are mentioned.

Signed-off-by: Antonio Quartulli <ordex@autistici.org>
---

this patch is based on top of next. It should be merged into next in order to fix
the patch adding the prefix in front of the TT flags


 packet.h            |    2 +-
 translation-table.c |   14 +++++++-------
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/packet.h b/packet.h
index c0ed5b4..8d3e55a 100644
--- a/packet.h
+++ b/packet.h
@@ -77,7 +77,7 @@ enum batadv_tt_query_flags {
 	BATADV_TT_FULL_TABLE = 1 << 2,
 };
 
-/* TT_CLIENT flags.
+/* BATADV_TT_CLIENT flags.
  * Flags from 1 to 1 << 7 are sent on the wire, while flags from 1 << 8 to
  * 1 << 15 are used for local computation only
  */
diff --git a/translation-table.c b/translation-table.c
index 2a6d7d6..b6931d0 100644
--- a/translation-table.c
+++ b/translation-table.c
@@ -245,7 +245,7 @@ void batadv_tt_local_add(struct net_device *soft_iface, const uint8_t *addr,
 
 	if (tt_local_entry) {
 		tt_local_entry->last_seen = jiffies;
-		/* possibly unset the TT_CLIENT_PENDING flag */
+		/* possibly unset the BATADV_TT_CLIENT_PENDING flag */
 		tt_local_entry->common.flags &= ~BATADV_TT_CLIENT_PENDING;
 		goto out;
 	}
@@ -713,8 +713,8 @@ int batadv_tt_global_add(struct batadv_priv *bat_priv,
 	} else {
 		/* there is already a global entry, use this one. */
 
-		/* If there is the TT_CLIENT_ROAM flag set, there is only one
-		 * originator left in the list and we previously received a
+		/* If there is the BATADV_TT_CLIENT_ROAM flag set, there is only
+		 * one originator left in the list and we previously received a
 		 * delete + roaming change for this originator.
 		 *
 		 * We should first delete the old originator before adding the
@@ -889,8 +889,8 @@ batadv_tt_global_del_struct(struct batadv_priv *bat_priv,
 }
 
 /* If the client is to be deleted, we check if it is the last origantor entry
- * within tt_global entry. If yes, we set the TT_CLIENT_ROAM flag and the timer,
- * otherwise we simply remove the originator scheduled for deletion.
+ * within tt_global entry. If yes, we set the BATADV_TT_CLIENT_ROAM flag and the
+ * timer, otherwise we simply remove the originator scheduled for deletion.
  */
 static void
 batadv_tt_global_del_roaming(struct batadv_priv *bat_priv,
@@ -958,7 +958,7 @@ static void batadv_tt_global_del(struct batadv_priv *bat_priv,
 	 * event, there are two possibilities:
 	 * 1) the client roamed from node A to node B => if there
 	 *    is only one originator left for this client, we mark
-	 *    it with TT_CLIENT_ROAM, we start a timer and we
+	 *    it with BATADV_TT_CLIENT_ROAM, we start a timer and we
 	 *    wait for node B to claim it. In case of timeout
 	 *    the entry is purged.
 	 *
@@ -2148,7 +2148,7 @@ out:
 	return changed_num;
 }
 
-/* Purge out all the tt local entries marked with TT_CLIENT_PENDING */
+/* Purge out all the tt local entries marked with BATADV_TT_CLIENT_PENDING */
 static void batadv_tt_local_purge_pending_clients(struct batadv_priv *bat_priv)
 {
 	struct batadv_hashtable *hash = bat_priv->tt_local_hash;
-- 
1.7.9.4

