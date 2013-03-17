Return-Path: <linus.luessing@web.de>
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@web.de>
Date: Sun, 17 Mar 2013 03:30:57 +0100
Message-Id: <1363487457-5413-1-git-send-email-linus.luessing@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: Fix general protection fault in
	batadv_tt_global_del_orig()
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

On shutdown a race condition where we access a just freed global TT hash
might occure:

batadv_mesh_free()->batadv_originator_free() schedules the
batadv_orig_node_free_rcu().

Before batadv_orig_node_free_rcu() is executed (which happens on the
rcu_barrier() call in batadv_exit() the latest),
batadv_mesh_free()->batadv_tt_free()->batadv_tt_global_table_free()->
batadv_hash_destroy(hash)->kfree(hash)
is called, freeing the global tt hash.

When batadv_orig_node_free_rcu()->batadv_tt_global_del_orig() now gets
executed it tries to access this just freed global tt hash, causing a
kernel panic.

This patch tries to fix this by waiting for any just scheduled
batadv_orig_node_free_rcu() to finish via an extra rcu_barrier() call
before freeing the global TT hash.

Signed-off-by: Linus Lüssing <linus.luessing@web.de>
---
Ref: #169

 main.c |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/main.c b/main.c
index 62b1f89..0afc171 100644
--- a/main.c
+++ b/main.c
@@ -164,6 +164,11 @@ void batadv_mesh_free(struct net_device *soft_iface)
 
 	batadv_gw_node_purge(bat_priv);
 	batadv_originator_free(bat_priv);
+
+	/* Wait for any batadv_orig_node_free_rcu() to finish,
+	 * they access the soon to be freed global TT hash */
+	rcu_barrier();
+
 	batadv_nc_free(bat_priv);
 
 	batadv_tt_free(bat_priv);
-- 
1.7.10.4

