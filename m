Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Sat, 18 Sep 2010 21:01:18 +0200
Message-Id: <1284836482-23431-9-git-send-email-sven.eckelmann@gmx.de>
In-Reply-To: <1284836482-23431-1-git-send-email-sven.eckelmann@gmx.de>
References: <1284836482-23431-1-git-send-email-sven.eckelmann@gmx.de>
Subject: [B.A.T.M.A.N.] [PATCH 08/12] Staging: batman-adv: Use
	synchronize_rcu instead of call_rcu
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
Cc: b.a.t.m.a.n@lists.open-mesh.org

It is recommended [1] to use synchronize_rcu to simplify the code -
especially when otherwise extra locking is needed to protect other code
from picking stale elements. It also protects us for emitting to many
callbacks which may results in OOM conditions.

The only reason not to use it, would be in performance critical sections
or when we are not allowed to block.

[1] Documentation/RCU/checklist.txt

Signed-off-by: Sven Eckelmann <sven.eckelmann@gmx.de>
---
 drivers/staging/batman-adv/TODO             |    1 -
 drivers/staging/batman-adv/hard-interface.c |   10 ++--------
 drivers/staging/batman-adv/types.h          |    1 -
 3 files changed, 2 insertions(+), 10 deletions(-)

diff --git a/drivers/staging/batman-adv/TODO b/drivers/staging/batman-adv/TODO
index 76b2acd..cb6b026 100644
--- a/drivers/staging/batman-adv/TODO
+++ b/drivers/staging/batman-adv/TODO
@@ -1,7 +1,6 @@
  * Rework usage of RCU
     - don't leak pointers from rcu out of rcu critical area which may
       get freed
-    - check were synchronize_rcu must be used
     - go through Documentation/RCU/checklist.txt
  * Request a new review
  * Process the comments from the review
diff --git a/drivers/staging/batman-adv/hard-interface.c b/drivers/staging/batman-adv/hard-interface.c
index 35b198c..376ac48 100644
--- a/drivers/staging/batman-adv/hard-interface.c
+++ b/drivers/staging/batman-adv/hard-interface.c
@@ -418,13 +418,6 @@ out:
 	return NULL;
 }
 
-static void hardif_free_interface(struct rcu_head *rcu)
-{
-	struct batman_if *batman_if = container_of(rcu, struct batman_if, rcu);
-
-	kfree(batman_if);
-}
-
 static void hardif_remove_interface(struct batman_if *batman_if)
 {
 	/* first deactivate interface */
@@ -438,9 +431,10 @@ static void hardif_remove_interface(struct batman_if *batman_if)
 
 	/* caller must take if_list_lock */
 	list_del_rcu(&batman_if->list);
+	synchronize_rcu();
 	sysfs_del_hardif(&batman_if->hardif_obj);
 	dev_put(batman_if->net_dev);
-	call_rcu(&batman_if->rcu, hardif_free_interface);
+	kfree(batman_if);
 }
 
 void hardif_remove_interfaces(void)
diff --git a/drivers/staging/batman-adv/types.h b/drivers/staging/batman-adv/types.h
index 478277f..b162644 100644
--- a/drivers/staging/batman-adv/types.h
+++ b/drivers/staging/batman-adv/types.h
@@ -44,7 +44,6 @@ struct batman_if {
 	unsigned char *packet_buff;
 	int packet_len;
 	struct kobject *hardif_obj;
-	struct rcu_head rcu;
 	struct packet_type batman_adv_ptype;
 	struct net_device *soft_iface;
 };
-- 
1.7.2.3

