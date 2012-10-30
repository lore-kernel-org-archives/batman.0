Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Tue, 30 Oct 2012 14:09:47 +0100
Message-Id: <1351602589-22844-5-git-send-email-ordex@autistici.org>
In-Reply-To: <1351602589-22844-1-git-send-email-ordex@autistici.org>
References: <1351602589-22844-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCH 4/6] batman-adv: send ROAMING_ADV once
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

If a client roaming has already been advertised, the node should prevent it from
doing the same more than once. To achieve this, the node has to check the ROAM
flag on the global client: if this is set already, then the ROAMING_ADV for this
client has already been sent.

This should be merged with changes done by ("batman-adv: roaming handling
mechanism redesign")

Signed-off-by: Antonio Quartulli <ordex@autistici.org>
---
 translation-table.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/translation-table.c b/translation-table.c
index 59e64bc..517324a 100644
--- a/translation-table.c
+++ b/translation-table.c
@@ -336,8 +336,10 @@ add_event:
 	batadv_tt_local_event(bat_priv, addr, tt_local->common.flags);
 
 check_roaming:
-	/* Check whether it is a roaming! */
-	if (tt_global) {
+	/* Check whether it is a roaming, but don't do anything if the roaming
+	 * process has already been handled
+	 */
+	if (tt_global && !(tt_global->common.flags & BATADV_TT_CLIENT_ROAM)) {
 		/* These node are probably going to update their tt table */
 		head = &tt_global->orig_list;
 		rcu_read_lock();
-- 
1.7.12.4

