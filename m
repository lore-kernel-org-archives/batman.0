Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Thu, 30 Sep 2010 14:08:44 +0200
Message-Id: <1285848524-13469-5-git-send-email-lindner_marek@yahoo.de>
In-Reply-To: <1285848524-13469-1-git-send-email-lindner_marek@yahoo.de>
References: <1285848524-13469-1-git-send-email-lindner_marek@yahoo.de>
Subject: [B.A.T.M.A.N.] [PATCH 4/4] batman-adv: use rcu callbacks when
	freeing batman_if
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
Cc: Marek Lindner <lindner_marek@yahoo.de>

Signed-off-by: Marek Lindner <lindner_marek@yahoo.de>
---
 batman-adv/hard-interface.c |   13 ++++++++++---
 batman-adv/types.h          |    1 +
 2 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/batman-adv/hard-interface.c b/batman-adv/hard-interface.c
index 87693db..ec16dc9 100644
--- a/batman-adv/hard-interface.c
+++ b/batman-adv/hard-interface.c
@@ -38,6 +38,15 @@
 /* protect update critical side of if_list - but not the content */
 static DEFINE_SPINLOCK(if_list_lock);
 
+static void hardif_free_rcu(struct rcu_head *rcu)
+{
+	struct batman_if *batman_if;
+
+	batman_if = container_of(rcu, struct batman_if, rcu);
+	sysfs_del_hardif(&batman_if->hardif_obj);
+	kref_put(&batman_if->refcount, hardif_free_ref);
+}
+
 struct batman_if *get_batman_if_by_netdev(struct net_device *net_dev)
 {
 	struct batman_if *batman_if;
@@ -464,9 +473,7 @@ static void hardif_remove_interface(struct batman_if *batman_if)
 
 	/* caller must take if_list_lock */
 	list_del_rcu(&batman_if->list);
-	synchronize_rcu();
-	sysfs_del_hardif(&batman_if->hardif_obj);
-	kref_put(&batman_if->refcount, hardif_free_ref);
+	call_rcu(&batman_if->rcu, hardif_free_rcu);
 }
 
 void hardif_remove_interfaces(void)
diff --git a/batman-adv/types.h b/batman-adv/types.h
index 585647b..9a6f464 100644
--- a/batman-adv/types.h
+++ b/batman-adv/types.h
@@ -47,6 +47,7 @@ struct batman_if {
 	struct kref refcount;
 	struct packet_type batman_adv_ptype;
 	struct net_device *soft_iface;
+	struct rcu_head rcu;
 };
 
 /**
-- 
1.7.1

