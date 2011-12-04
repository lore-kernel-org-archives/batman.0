Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Sun,  4 Dec 2011 22:38:27 +0100
Message-Id: <1323034707-25325-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: delete global entry in case of
	roaming
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

When receiving a DEL change for a client due to a roaming event (change is
marked with TT_CLIENT_ROAM), each node  has to check if the client roamed
to itself or somewhere else.

In the latter case the global entry is kept to avoid having no route at all
otherwise we can safely delete the global entry

Signed-off-by: Antonio Quartulli <ordex@autistici.org>
---
 translation-table.c |   21 ++++++++++++++++++---
 1 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/translation-table.c b/translation-table.c
index cf3e2c2..6e01079 100644
--- a/translation-table.c
+++ b/translation-table.c
@@ -663,6 +663,7 @@ void tt_global_del(struct bat_priv *bat_priv,
 		   const char *message, bool roaming)
 {
 	struct tt_global_entry *tt_global_entry = NULL;
+	struct tt_local_entry *tt_local_entry = NULL
 
 	tt_global_entry = tt_global_hash_find(bat_priv, addr);
 	if (!tt_global_entry)
@@ -670,15 +671,29 @@ void tt_global_del(struct bat_priv *bat_priv,
 
 	if (tt_global_entry->orig_node == orig_node) {
 		if (roaming) {
-			tt_global_entry->common.flags |= TT_CLIENT_ROAM;
-			tt_global_entry->roam_at = jiffies;
-			goto out;
+			/* if we are deleting a global entry due to a roam
+			 * event, there are two possibilities:
+			 * 1) the client roamed from node A to node B => we mark
+			 *    it with TT_CLIENT_ROAM, we start a timer and we
+			 *    wait for node B to claim it. In case of timeout
+			 *    the entry is purged.
+			 * 2) the client roamed to us => we can directly delete
+			 *    the global entry, since it is useless now. */
+			tt_local_entry = tt_local_hash_find(bat_priv,
+							tt_global_entry->addr);
+			if (!tt_local_entry) {
+				tt_global_entry->common.flags |= TT_CLIENT_ROAM;
+				tt_global_entry->roam_at = jiffies;
+				goto out;
+			}
 		}
 		_tt_global_del(bat_priv, tt_global_entry, message);
 	}
 out:
 	if (tt_global_entry)
 		tt_global_entry_free_ref(tt_global_entry);
+	if (tt_local_entry)
+		tt_local_entry_free_ref(tt_local_entry);
 }
 
 void tt_global_del_orig(struct bat_priv *bat_priv,
-- 
1.7.3.4

