Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Tue,  3 Apr 2012 23:50:19 +0200
Message-Id: <1333489822-27692-3-git-send-email-ordex@autistici.org>
In-Reply-To: <1333489822-27692-1-git-send-email-ordex@autistici.org>
References: <1333489822-27692-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCH 2/5] batman-adv: clear the PENDING flag in
	case of client re-addition
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

During an OGM interval (time between two successive OGM sendings) a client
could be deleted (e.g. due to roaming) and then be re-added immediately after.
After the deletion, the client is marked with the TT_CLIENT_PENDING flag.
Therefore, in case of re-addition, the latter flag has to be reset

Signed-off-by: Antonio Quartulli <ordex@autistici.org>
---
 translation-table.c |   19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/translation-table.c b/translation-table.c
index 438b786..fa1ac3a 100644
--- a/translation-table.c
+++ b/translation-table.c
@@ -248,15 +248,26 @@ void tt_local_add(struct net_device *soft_iface, const uint8_t *addr,
 		tt_local_entry->common.flags |= TT_CLIENT_WIFI;
 	atomic_set(&tt_local_entry->common.refcount, 2);
 	tt_local_entry->last_seen = jiffies;
+	tt_local_entry->common.added_at = tt_local_entry->last_seen;
+
 
 	/* the batman interface mac address should never be purged */
 	if (compare_eth(addr, soft_iface->dev_addr))
 		tt_local_entry->common.flags |= TT_CLIENT_NOPURGE;
 
-	/* The local entry has to be marked as NEW to avoid to send it in
-	 * a full table response going out before the next ttvn increment
-	 * (consistency check) */
-	tt_local_entry->common.flags |= TT_CLIENT_NEW;
+	/* if the client is marked as PENDING means that it has been marked for
+	 * deletion during THIS OGM interval and the event has not been
+	 * announced yet. Therefore we can simply unset the flag. The event from
+	 * the event queue will be automatically be removed from the queue.
+	 * Otherwise we can set the NEW flag */
+	 if (tt_local_entry->common.flags & TT_CLIENT_PENDING)
+		tt_local_entry->common.flags &= ~TT_CLIENT_PENDING;
+	else
+		/* The local entry has to be marked as NEW to avoid to send it
+		 * in a full table response going out before the next ttvn
+		 * increment (consistency check) */
+		tt_local_entry->common.flags |= TT_CLIENT_NEW;
+
 
 	hash_added = hash_add(bat_priv->tt_local_hash, compare_tt, choose_orig,
 			 &tt_local_entry->common,
-- 
1.7.9.4

