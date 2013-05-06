Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Tue,  7 May 2013 01:06:18 +0200
Message-Id: <1367881578-3353-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCHv2 maint] batman-adv: reorder clean up routine
	in order to avoid race conditions
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
Cc: Antonio Quartulli <ordex@autistici.org>

nc_worker accesses the originator table during its periodic
work, but since the originator table is freed before
stopping the worker this leads to a global protection fault.

Fix this by killing the worker (in nc_free) before freeing
the originator table.

Moreover tidy up the entire clean up routine by running all
the subcomponents freeing procedures first and then killing
the TT and the originator tables at the end.

Signed-off-by: Antonio Quartulli <ordex@autistici.org>
---

v2:
- based on top of maint
- commit message reworded

 main.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/main.c b/main.c
index 9c620cd..6fefcb1 100644
--- a/main.c
+++ b/main.c
@@ -163,14 +163,22 @@ void batadv_mesh_free(struct net_device *soft_iface)
 	batadv_vis_quit(bat_priv);
 
 	batadv_gw_node_purge(bat_priv);
-	batadv_originator_free(bat_priv);
 	batadv_nc_free(bat_priv);
+	batadv_dat_free(bat_priv);
+	batadv_bla_free(bat_priv);
 
+	/* free the TT and the originator tables only after having terminated all
+	 * the other minor components which may use these structures for their
+	 * purposes
+	 */
 	batadv_tt_free(bat_priv);
 
-	batadv_bla_free(bat_priv);
-
-	batadv_dat_free(bat_priv);
+	/* since the originator clean up routine is the one accessing the TT
+	 * tables as well, invoke it as last step so that any race condition is
+	 * avoided when the RCU callbacks scheduled by this function access the
+	 * TT data
+	 */
+	batadv_originator_free(bat_priv);
 
 	free_percpu(bat_priv->bat_counters);
 
-- 
1.8.1.5

