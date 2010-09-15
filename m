Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Wed, 15 Sep 2010 23:09:36 +0200
Message-Id: <1284584976-22596-1-git-send-email-sven.eckelmann@gmx.de>
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: wait for call_rcu before
	unloading module
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

synchronize_rcu respective synchronize_net only waits for the rcu grace
period to elapse and we may fail to finish the calls which were made to
call_rcu in that time. In result the module could be unloaded during the
execution of the RCU callbacks.

rcu_barrier[1] will now wait for all outstanding RCU callbacks to finish
before continuing.

[1] Documentation/RCU/rcubarrier.txt

Signed-off-by: Sven Eckelmann <sven.eckelmann@gmx.de>
---
 batman-adv/main.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/batman-adv/main.c b/batman-adv/main.c
index e8acb46..a067f75 100644
--- a/batman-adv/main.c
+++ b/batman-adv/main.c
@@ -74,7 +74,7 @@ static void __exit batman_exit(void)
 	destroy_workqueue(bat_event_workqueue);
 	bat_event_workqueue = NULL;
 
-	synchronize_net();
+	rcu_barrier();
 }
 
 int mesh_init(struct net_device *soft_iface)
-- 
1.7.2.3

