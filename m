Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Thu,  9 May 2013 12:56:47 +0200
Message-Id: <1368097007-817-5-git-send-email-ordex@autistici.org>
In-Reply-To: <1368097007-817-1-git-send-email-ordex@autistici.org>
References: <1368097007-817-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCH 4/4] batman-adv: reorder clean up routine in
	order to avoid race conditions
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
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, Marek Lindner <lindner_marek@yahoo.de>, Antonio Quartulli <ordex@autistici.org>

nc_worker accesses the originator table during its periodic
work, but since the originator table is freed before
stopping the worker this leads to a global protection fault.

Fix this by killing the worker (in nc_free) before freeing
the originator table.

Moreover tidy up the entire clean up routine by running all
the subcomponents freeing procedures first and then killing
the TT and the originator tables at the end.

Signed-off-by: Antonio Quartulli <ordex@autistici.org>
Signed-off-by: Marek Lindner <lindner_marek@yahoo.de>
---
 net/batman-adv/main.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/net/batman-adv/main.c b/net/batman-adv/main.c
index 9c620cd..1240f07 100644
--- a/net/batman-adv/main.c
+++ b/net/batman-adv/main.c
@@ -163,14 +163,22 @@ void batadv_mesh_free(struct net_device *soft_iface)
 	batadv_vis_quit(bat_priv);
 
 	batadv_gw_node_purge(bat_priv);
-	batadv_originator_free(bat_priv);
 	batadv_nc_free(bat_priv);
-
-	batadv_tt_free(bat_priv);
-
-	batadv_bla_free(bat_priv);
-
 	batadv_dat_free(bat_priv);
+	batadv_bla_free(bat_priv);
+
+	/* Free the TT and the originator tables only after having terminated
+	 * all the other depending components which may use these structures for
+	 * their purposes.
+	 */
+	batadv_tt_free(bat_priv);
+
+	/* Since the originator table clean up routine is accessing the TT
+	 * tables as well, it has to be invoked after the TT tables have been
+	 * freed and marked as empty. This ensures that no cleanup RCU callbacks
+	 * accessing the TT data are scheduled for later execution.
+	 */
+	batadv_originator_free(bat_priv);
 
 	free_percpu(bat_priv->bat_counters);
 
-- 
1.8.1.5

