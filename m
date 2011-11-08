Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Tue,  8 Nov 2011 12:13:29 +0100
Message-Id: <1320750809-12445-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: correct usage of TT_CLIENT_ROAM
	flag
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

The TT_CLIENT_ROAM flag has to be set in tt_global_del() only if the latter has
been invoked by the roaming_advertisement receiving routine. In case of changes
update (normal operation done on OGM/TT_QUERY receiving) this doesn't have to
happen. Moreover, a client which roamed to us has to be marked as ROAMED, not
PENDING. This will make it to be kept for consistency purposes until the related
change is received within the next OGM.

Signed-off-by: Antonio Quartulli <ordex@autistici.org>
---
 translation-table.c |   12 ++++++++----
 1 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/translation-table.c b/translation-table.c
index 379529d..633b35b 100644
--- a/translation-table.c
+++ b/translation-table.c
@@ -234,9 +234,11 @@ void tt_local_add(struct net_device *soft_iface, const uint8_t *addr,
 	if (tt_global_entry) {
 		/* This node is probably going to update its tt table */
 		tt_global_entry->orig_node->tt_poss_change = true;
-		/* The global entry has to be marked as PENDING and has to be
+		/* The global entry has to be marked as ROAMING and has to be
 		 * kept for consistency purpose */
-		tt_global_entry->common.flags |= TT_CLIENT_PENDING;
+		tt_global_entry->common.flags |= TT_CLIENT_ROAM;
+		tt_global_entry->roam_at = jiffies;
+
 		send_roam_adv(bat_priv, tt_global_entry->common.addr,
 			      tt_global_entry->orig_node);
 	}
@@ -357,12 +359,14 @@ static void tt_local_set_pending(struct bat_priv *bat_priv,
 				 uint16_t flags)
 {
 	tt_local_event(bat_priv, tt_local_entry->common.addr,
-		       tt_local_entry->common.flags | flags);
+		       TT_CLIENT_DEL);
 
 	/* The local client has to be marked as "pending to be removed" but has
 	 * to be kept in the table in order to send it in a full table
 	 * response issued before the net ttvn increment (consistency check) */
 	tt_local_entry->common.flags |= TT_CLIENT_PENDING;
+	/* if this is a roaming deletion, mark the local entry accordingly */
+	tt_local_entry->common.flags |= flags & TT_CLIENT_ROAM;
 }
 
 void tt_local_remove(struct bat_priv *bat_priv, const uint8_t *addr,
@@ -1404,7 +1408,7 @@ static void _tt_update_changes(struct bat_priv *bat_priv,
 			tt_global_del(bat_priv, orig_node,
 				      (tt_change + i)->addr,
 				      "tt removed by changes",
-				      (tt_change + i)->flags & TT_CLIENT_ROAM);
+				      false);
 		else
 			if (!tt_global_add(bat_priv, orig_node,
 					   (tt_change + i)->addr, ttvn, false,
-- 
1.7.3.4

