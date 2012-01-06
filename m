Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Fri,  6 Jan 2012 21:31:34 +0100
Message-Id: <1325881894-18603-2-git-send-email-ordex@autistici.org>
In-Reply-To: <1325881894-18603-1-git-send-email-ordex@autistici.org>
References: <1325881894-18603-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCH 2/2] batman-adv: move debug print into
	tt_local_set_pending
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

Each tt_local_set_pending is always followed by a bat_dbg invocation. This patch
moves the latter into the function body in order to avoid to rewrite it all the
times.

Signed-off-by: Antonio Quartulli <ordex@autistici.org>
---
 translation-table.c |   15 ++++++---------
 1 files changed, 6 insertions(+), 9 deletions(-)

diff --git a/translation-table.c b/translation-table.c
index b493ab4..d105cbd 100644
--- a/translation-table.c
+++ b/translation-table.c
@@ -355,7 +355,7 @@ out:
 
 static void tt_local_set_pending(struct bat_priv *bat_priv,
 				 struct tt_local_entry *tt_local_entry,
-				 uint16_t flags)
+				 uint16_t flags, const char *message)
 {
 	tt_local_event(bat_priv, tt_local_entry->common.addr,
 		       tt_local_entry->common.flags | flags);
@@ -364,6 +364,9 @@ static void tt_local_set_pending(struct bat_priv *bat_priv,
 	 * to be kept in the table in order to send it in a full table
 	 * response issued before the net ttvn increment (consistency check) */
 	tt_local_entry->common.flags |= TT_CLIENT_PENDING;
+
+	bat_dbg(DBG_TT, bat_priv, "Local tt entry (%pM) pending to be removed: "
+		"%s\n", tt_local_entry->common.addr, message);
 }
 
 void tt_local_remove(struct bat_priv *bat_priv, const uint8_t *addr,
@@ -376,10 +379,7 @@ void tt_local_remove(struct bat_priv *bat_priv, const uint8_t *addr,
 		goto out;
 
 	tt_local_set_pending(bat_priv, tt_local_entry, TT_CLIENT_DEL |
-			     (roaming ? TT_CLIENT_ROAM : NO_FLAGS));
-
-	bat_dbg(DBG_TT, bat_priv, "Local tt entry (%pM) pending to be removed: "
-		"%s\n", tt_local_entry->common.addr, message);
+			     (roaming ? TT_CLIENT_ROAM : NO_FLAGS), message);
 out:
 	if (tt_local_entry)
 		tt_local_entry_free_ref(tt_local_entry);
@@ -417,10 +417,7 @@ static void tt_local_purge(struct bat_priv *bat_priv)
 				continue;
 
 			tt_local_set_pending(bat_priv, tt_local_entry,
-					     TT_CLIENT_DEL);
-			bat_dbg(DBG_TT, bat_priv, "Local tt entry (%pM) "
-				"pending to be removed: timed out\n",
-				tt_local_entry->common.addr);
+					     TT_CLIENT_DEL, "timed out");
 		}
 		spin_unlock_bh(list_lock);
 	}
-- 
1.7.3.4

