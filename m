Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Tue, 28 Feb 2012 19:32:22 +0800
Message-Id: <1330428748-23137-3-git-send-email-lindner_marek@yahoo.de>
In-Reply-To: <1330428748-23137-1-git-send-email-lindner_marek@yahoo.de>
References: <1330428748-23137-1-git-send-email-lindner_marek@yahoo.de>
Subject: [B.A.T.M.A.N.] [PATCH 2/8] batman-adv: refactor tt_global_del() to
	avoid misalignment
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
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, Marek Lindner <lindner_marek@yahoo.de>

From: Sven Eckelmann <sven@narfation.org>

Signed-off-by: Sven Eckelmann <sven@narfation.org>
Acked-by: Antonio Quartulli <ordex@autistici.org>
Signed-off-by: Marek Lindner <lindner_marek@yahoo.de>
---
 net/batman-adv/translation-table.c |   42 ++++++++++++++++++-----------------
 1 files changed, 22 insertions(+), 20 deletions(-)

diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index ff9a1b3..30c2d1b 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -657,29 +657,31 @@ void tt_global_del(struct bat_priv *bat_priv,
 	struct tt_local_entry *tt_local_entry = NULL;
 
 	tt_global_entry = tt_global_hash_find(bat_priv, addr);
-	if (!tt_global_entry)
+	if (!tt_global_entry || tt_global_entry->orig_node != orig_node)
 		goto out;
 
-	if (tt_global_entry->orig_node == orig_node) {
-		if (roaming) {
-			/* if we are deleting a global entry due to a roam
-			 * event, there are two possibilities:
-			 * 1) the client roamed from node A to node B => we mark
-			 *    it with TT_CLIENT_ROAM, we start a timer and we
-			 *    wait for node B to claim it. In case of timeout
-			 *    the entry is purged.
-			 * 2) the client roamed to us => we can directly delete
-			 *    the global entry, since it is useless now. */
-			tt_local_entry = tt_local_hash_find(bat_priv,
-							    tt_global_entry->common.addr);
-			if (!tt_local_entry) {
-				tt_global_entry->common.flags |= TT_CLIENT_ROAM;
-				tt_global_entry->roam_at = jiffies;
-				goto out;
-			}
-		}
-		_tt_global_del(bat_priv, tt_global_entry, message);
+	if (!roaming)
+		goto out_del;
+
+	/* if we are deleting a global entry due to a roam
+	 * event, there are two possibilities:
+	 * 1) the client roamed from node A to node B => we mark
+	 *    it with TT_CLIENT_ROAM, we start a timer and we
+	 *    wait for node B to claim it. In case of timeout
+	 *    the entry is purged.
+	 * 2) the client roamed to us => we can directly delete
+	 *    the global entry, since it is useless now. */
+	tt_local_entry = tt_local_hash_find(bat_priv,
+					    tt_global_entry->common.addr);
+	if (!tt_local_entry) {
+		tt_global_entry->common.flags |= TT_CLIENT_ROAM;
+		tt_global_entry->roam_at = jiffies;
+		goto out;
 	}
+
+out_del:
+	_tt_global_del(bat_priv, tt_global_entry, message);
+
 out:
 	if (tt_global_entry)
 		tt_global_entry_free_ref(tt_global_entry);
-- 
1.7.9

