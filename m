Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Wed,  7 Nov 2012 15:05:33 +0100
Message-Id: <1352297133-17652-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: fix tt_global_entries flags
	update
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: b.a.t.m.a.n@lists.open-mesh.org

Flags carried by a change_entry have to be always copied into the
client entry as they may contain important attributes (e.g.
TT_CLIENT_WIFI).

For instance, a client added by means of the "early detection
mechanism" has no flag set at the beginning, so they must be updated once the
proper ADD event is received.

This was introduced by ("batman-adv: detect not yet announced clients")

Signed-off-by: Antonio Quartulli <ordex@autistici.org>
---

This patch is based on "maint"


 translation-table.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/translation-table.c b/translation-table.c
index 112edd3..64c0012 100644
--- a/translation-table.c
+++ b/translation-table.c
@@ -769,6 +769,12 @@ int batadv_tt_global_add(struct batadv_priv *bat_priv,
 		 */
 		tt_global_entry->common.flags &= ~BATADV_TT_CLIENT_TEMP;
 
+		/* the change can carry possible "attribute" flags like the
+		 * TT_CLIENT_WIFI, therefore they have to be copied in the
+		 * client entry
+		 */
+		tt_global_entry->common.flags |= flags;
+
 		/* If there is the BATADV_TT_CLIENT_ROAM flag set, there is only
 		 * one originator left in the list and we previously received a
 		 * delete + roaming change for this originator.
-- 
1.8.0

