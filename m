Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Sun, 12 Sep 2010 23:21:52 +0200
Message-Id: <1284326516-30540-2-git-send-email-sven.eckelmann@gmx.de>
In-Reply-To: <1284326516-30540-1-git-send-email-sven.eckelmann@gmx.de>
References: <1284326516-30540-1-git-send-email-sven.eckelmann@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCH 1/5] Staging: batman-adv: Always synchronize
	rcu's on module shutdown
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
To: greg@kroah.com
Cc: b.a.t.m.a.n@lists.open-mesh.net

From: Linus Lüssing <linus.luessing@web.de>

During the module shutdown procedure in batman_exit(), a rcu callback is
being scheduled (batman_exit -> hardif_remove_interfaces ->
hardif_remove_interfae -> call_rcu). However, when the kernel unloads
the module, the rcu callback might not have been executed yet, resulting
in a "unable to handle kernel paging request" in __rcu_process_callback
afterwards, causing the kernel to freeze.

The synchronize_net and synchronize_rcu in mesh_free are currently
called before the call_rcu in hardif_remove_interface and have no real
effect on it.

Therefore, we should always flush all rcu callback functions scheduled
during the shutdown procedure using synchronize_net. The call to
synchronize_rcu can be omitted because synchronize_net already calls it.

Signed-off-by: Linus Lüssing <linus.luessing@web.de>
Signed-off-by: Sven Eckelmann <sven.eckelmann@gmx.de>
---
 drivers/staging/batman-adv/main.c |    5 ++---
 1 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/batman-adv/main.c b/drivers/staging/batman-adv/main.c
index 498861f..b3e23e1 100644
--- a/drivers/staging/batman-adv/main.c
+++ b/drivers/staging/batman-adv/main.c
@@ -71,6 +71,8 @@ static void __exit batman_exit(void)
 	flush_workqueue(bat_event_workqueue);
 	destroy_workqueue(bat_event_workqueue);
 	bat_event_workqueue = NULL;
+
+	synchronize_net();
 }
 
 int mesh_init(struct net_device *soft_iface)
@@ -132,9 +134,6 @@ void mesh_free(struct net_device *soft_iface)
 	hna_local_free(bat_priv);
 	hna_global_free(bat_priv);
 
-	synchronize_net();
-
-	synchronize_rcu();
 	atomic_set(&bat_priv->mesh_state, MESH_INACTIVE);
 }
 
-- 
1.7.2.3

