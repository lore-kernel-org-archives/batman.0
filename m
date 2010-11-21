Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Mon, 22 Nov 2010 00:55:44 +0100
Message-Id: <1290383767-32602-7-git-send-email-sven.eckelmann@gmx.de>
In-Reply-To: <1290383767-32602-1-git-send-email-sven.eckelmann@gmx.de>
References: <1290383767-32602-1-git-send-email-sven.eckelmann@gmx.de>
Subject: [B.A.T.M.A.N.] [PATCH 06/29] Staging: batman-adv: use rcu callbacks
	when freeing batman_if
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
Cc: b.a.t.m.a.n@lists.open-mesh.org, Marek Lindner <lindner_marek@yahoo.de>

From: Marek Lindner <lindner_marek@yahoo.de>

Signed-off-by: Marek Lindner <lindner_marek@yahoo.de>
Signed-off-by: Sven Eckelmann <sven.eckelmann@gmx.de>
---
 drivers/staging/batman-adv/hard-interface.c |   12 ++++++++++--
 drivers/staging/batman-adv/hard-interface.h |    1 -
 drivers/staging/batman-adv/types.h          |    1 +
 3 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/batman-adv/hard-interface.c b/drivers/staging/batman-adv/hard-interface.c
index 6d5b748..c2ff294 100644
--- a/drivers/staging/batman-adv/hard-interface.c
+++ b/drivers/staging/batman-adv/hard-interface.c
@@ -36,6 +36,15 @@
 /* protect update critical side of if_list - but not the content */
 static DEFINE_SPINLOCK(if_list_lock);
 
+static void hardif_free_rcu(struct rcu_head *rcu)
+{
+	struct batman_if *batman_if;
+
+	batman_if = container_of(rcu, struct batman_if, rcu);
+	dev_put(batman_if->net_dev);
+	kref_put(&batman_if->refcount, hardif_free_ref);
+}
+
 struct batman_if *get_batman_if_by_netdev(struct net_device *net_dev)
 {
 	struct batman_if *batman_if;
@@ -462,9 +471,8 @@ static void hardif_remove_interface(struct batman_if *batman_if)
 		return;
 
 	batman_if->if_status = IF_TO_BE_REMOVED;
-	synchronize_rcu();
 	sysfs_del_hardif(&batman_if->hardif_obj);
-	kref_put(&batman_if->refcount, hardif_free_ref);
+	call_rcu(&batman_if->rcu, hardif_free_rcu);
 }
 
 void hardif_remove_interfaces(void)
diff --git a/drivers/staging/batman-adv/hard-interface.h b/drivers/staging/batman-adv/hard-interface.h
index 1d1cd9f..30ec3b8 100644
--- a/drivers/staging/batman-adv/hard-interface.h
+++ b/drivers/staging/batman-adv/hard-interface.h
@@ -47,7 +47,6 @@ static inline void hardif_free_ref(struct kref *refcount)
 	struct batman_if *batman_if;
 
 	batman_if = container_of(refcount, struct batman_if, refcount);
-	dev_put(batman_if->net_dev);
 	kfree(batman_if);
 }
 
diff --git a/drivers/staging/batman-adv/types.h b/drivers/staging/batman-adv/types.h
index d89ec70..8f6ba1c 100644
--- a/drivers/staging/batman-adv/types.h
+++ b/drivers/staging/batman-adv/types.h
@@ -46,6 +46,7 @@ struct batman_if {
 	struct kref refcount;
 	struct packet_type batman_adv_ptype;
 	struct net_device *soft_iface;
+	struct rcu_head rcu;
 };
 
 /**
-- 
1.7.2.3

