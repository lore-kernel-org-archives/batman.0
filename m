Return-Path: <linus.luessing@web.de>
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@web.de>
Date: Mon,  6 Sep 2010 01:29:53 +0200
Message-Id: <1283729393-13842-1-git-send-email-linus.luessing@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linus.luessing@web.de
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: Always synchronize rcu's on
	module shutdown
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

During the module shutdown procedure in batman_exit(), a rcu callback is
being scheduled (batman_exit -> hardif_remove_interfaces ->
hardif_remove_interfae -> call_rcu). However, when the kernel unloads
the module, the rcu callback might not have been executed yet, resulting
in a "unable to handle kernel paging request" in __rcu_process_callback
afterwards, causing the kernel to freeze.
Therefore, we should always flush all rcu callback functions scheduled
during the shutdown procedure.

Signed-off-by: Linus Lüssing <linus.luessing@web.de>
---
 main.c |    5 ++---
 1 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/main.c b/main.c
index 209a46b..e8acb46 100644
--- a/main.c
+++ b/main.c
@@ -73,6 +73,8 @@ static void __exit batman_exit(void)
 	flush_workqueue(bat_event_workqueue);
 	destroy_workqueue(bat_event_workqueue);
 	bat_event_workqueue = NULL;
+
+	synchronize_net();
 }
 
 int mesh_init(struct net_device *soft_iface)
@@ -135,9 +137,6 @@ void mesh_free(struct net_device *soft_iface)
 	hna_local_free(bat_priv);
 	hna_global_free(bat_priv);
 
-	synchronize_net();
-
-	synchronize_rcu();
 	atomic_set(&bat_priv->mesh_state, MESH_INACTIVE);
 }
 
-- 
1.7.1

