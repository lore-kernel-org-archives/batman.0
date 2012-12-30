Return-Path: <simon.wunderlich@s2003.tu-chemnitz.de>
From: Simon Wunderlich <simon.wunderlich@s2003.tu-chemnitz.de>
Date: Mon, 31 Dec 2012 00:40:50 +0100
Message-Id: <1356910850-17542-1-git-send-email-siwu@hrz.tu-chemnitz.de>
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: postpone sysfs removal when
	unregistering
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
Cc: Simon Wunderlich <siwu@hrz.tu-chemnitz.de>

When processing the unregister notify for a hard interface, removing
the sysfs files may lead to a circular deadlock (rtnl mutex <->
s_active).

To overcome this problem, postpone the sysfs removal in a worker.

Reported-by: Sasha Levin <sasha.levin@oracle.com>
Reported-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <siwu@hrz.tu-chemnitz.de>
---
Changes from RFCv1:
 * use work_struct properly, instead of delayed_work
 * postpone for softifs as well as for hardifs

Postponing the sysfs removal for the hardif unregister is easier than
other alternatives involving deferring. This should bring us to the
same level to the bridge code, which also messes with sysfs in the
notifier processing function, and uses rtnl_trylock when called
from within sysfs.

As far as I could understand the net/core code, only the unregister
case is the critical one, so the original bug should hopefully be
fixed.
---
 hard-interface.c |   16 ++++++++++++++--
 soft-interface.c |   26 +++++++++++++++++++++++---
 types.h          |    3 +++
 3 files changed, 40 insertions(+), 5 deletions(-)

diff --git a/hard-interface.c b/hard-interface.c
index f1d37cd..eb3a12d 100644
--- a/hard-interface.c
+++ b/hard-interface.c
@@ -506,6 +506,17 @@ out:
 	return NULL;
 }
 
+static void batadv_hardif_remove_interface_finish(struct work_struct *work)
+{
+	struct batadv_hard_iface *hard_iface;
+
+	hard_iface = container_of(work, struct batadv_hard_iface,
+				  cleanup_work);
+
+	batadv_sysfs_del_hardif(&hard_iface->hardif_obj);
+	batadv_hardif_free_ref(hard_iface);
+}
+
 static void batadv_hardif_remove_interface(struct batadv_hard_iface *hard_iface)
 {
 	ASSERT_RTNL();
@@ -518,8 +529,9 @@ static void batadv_hardif_remove_interface(struct batadv_hard_iface *hard_iface)
 		return;
 
 	hard_iface->if_status = BATADV_IF_TO_BE_REMOVED;
-	batadv_sysfs_del_hardif(&hard_iface->hardif_obj);
-	batadv_hardif_free_ref(hard_iface);
+	INIT_WORK(&hard_iface->cleanup_work,
+		  batadv_hardif_remove_interface_finish);
+	queue_work(batadv_event_workqueue, &hard_iface->cleanup_work);
 }
 
 void batadv_hardif_remove_interfaces(void)
diff --git a/soft-interface.c b/soft-interface.c
index a8eb963..b8a307b 100644
--- a/soft-interface.c
+++ b/soft-interface.c
@@ -464,6 +464,7 @@ struct net_device *batadv_softif_create(const char *name)
 		goto out;
 
 	bat_priv = netdev_priv(soft_iface);
+	bat_priv->soft_iface = soft_iface;
 
 	/* batadv_interface_stats() needs to be available as soon as
 	 * register_netdevice() has been called
@@ -550,12 +551,31 @@ out:
 	return NULL;
 }
 
+static void batadv_softif_destroy_finish(struct work_struct *work)
+{
+	struct batadv_priv *bat_priv;
+	struct net_device *soft_iface;
+
+	bat_priv = container_of(work, struct batadv_priv,
+				cleanup_work);
+	soft_iface = bat_priv->soft_iface;
+
+	batadv_debugfs_del_meshif(soft_iface);
+	batadv_sysfs_del_meshif(soft_iface);
+
+	rtnl_lock();
+	unregister_netdevice(soft_iface);
+	rtnl_unlock();
+}
+
 void batadv_softif_destroy(struct net_device *soft_iface)
 {
-	batadv_debugfs_del_meshif(soft_iface);
-	batadv_sysfs_del_meshif(soft_iface);
+	struct batadv_priv *bat_priv = netdev_priv(soft_iface);
+
 	batadv_mesh_free(soft_iface);
-	unregister_netdevice(soft_iface);
+
+	INIT_WORK(&bat_priv->cleanup_work, batadv_softif_destroy_finish);
+	queue_work(batadv_event_workqueue, &bat_priv->cleanup_work);
 }
 
 int batadv_softif_is_valid(const struct net_device *net_dev)
diff --git a/types.h b/types.h
index d8061ac..a9800ee 100644
--- a/types.h
+++ b/types.h
@@ -63,6 +63,7 @@ struct batadv_hard_iface {
 	struct net_device *soft_iface;
 	struct rcu_head rcu;
 	struct batadv_hard_iface_bat_iv bat_iv;
+	struct work_struct cleanup_work;
 };
 
 /**
@@ -266,6 +267,7 @@ struct batadv_priv_dat {
 
 struct batadv_priv {
 	atomic_t mesh_state;
+	struct net_device *soft_iface;
 	struct net_device_stats stats;
 	uint64_t __percpu *bat_counters; /* Per cpu counters */
 	atomic_t aggregated_ogms;	/* boolean */
@@ -302,6 +304,7 @@ struct batadv_priv {
 	spinlock_t forw_bat_list_lock; /* protects forw_bat_list */
 	spinlock_t forw_bcast_list_lock; /* protects forw_bcast_list */
 	struct delayed_work orig_work;
+	struct work_struct cleanup_work;
 	struct batadv_hard_iface __rcu *primary_if;  /* rcu protected pointer */
 	struct batadv_algo_ops *bat_algo_ops;
 #ifdef CONFIG_BATMAN_ADV_BLA
-- 
1.7.10.4

