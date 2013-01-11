Return-Path: <simon.wunderlich@s2003.tu-chemnitz.de>
From: Simon Wunderlich <simon.wunderlich@s2003.tu-chemnitz.de>
Date: Fri, 11 Jan 2013 10:19:51 +0100
Message-Id: <1357895991-2865-1-git-send-email-siwu@hrz.tu-chemnitz.de>
In-Reply-To: <1357837761-30461-1-git-send-email-siwu@hrz.tu-chemnitz.de>
References: <1357837761-30461-1-git-send-email-siwu@hrz.tu-chemnitz.de>
Subject: [B.A.T.M.A.N.] [PATCHv3] batman-adv: postpone sysfs removal when
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
Changes from PATCHv2:
 * kerneldoc for functions

Changes from PATCHv1:
 * INIT_WORK() in respective struct initialization functions
 * kerneldoc

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
 hard-interface.c |   24 ++++++++++++++++++++++--
 soft-interface.c |   32 +++++++++++++++++++++++++++++---
 types.h          |    6 ++++++
 3 files changed, 57 insertions(+), 5 deletions(-)

diff --git a/hard-interface.c b/hard-interface.c
index 78cf350..368219e 100644
--- a/hard-interface.c
+++ b/hard-interface.c
@@ -457,6 +457,24 @@ out:
 		batadv_hardif_free_ref(primary_if);
 }
 
+/**
+ * batadv_hardif_remove_interface_finish - cleans up the remains of a hardif
+ * @work: work queue item
+ *
+ * Free the parts of the hard interface which can not be removed under
+ * rtnl lock (to prevent deadlock situations).
+ */
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
 static struct batadv_hard_iface *
 batadv_hardif_add_interface(struct net_device *net_dev)
 {
@@ -484,6 +502,9 @@ batadv_hardif_add_interface(struct net_device *net_dev)
 	hard_iface->soft_iface = NULL;
 	hard_iface->if_status = BATADV_IF_NOT_IN_USE;
 	INIT_LIST_HEAD(&hard_iface->list);
+	INIT_WORK(&hard_iface->cleanup_work,
+		  batadv_hardif_remove_interface_finish);
+
 	/* extra reference for return */
 	atomic_set(&hard_iface->refcount, 2);
 
@@ -518,8 +539,7 @@ static void batadv_hardif_remove_interface(struct batadv_hard_iface *hard_iface)
 		return;
 
 	hard_iface->if_status = BATADV_IF_TO_BE_REMOVED;
-	batadv_sysfs_del_hardif(&hard_iface->hardif_obj);
-	batadv_hardif_free_ref(hard_iface);
+	queue_work(batadv_event_workqueue, &hard_iface->cleanup_work);
 }
 
 void batadv_hardif_remove_interfaces(void)
diff --git a/soft-interface.c b/soft-interface.c
index e67e013..2711e87 100644
--- a/soft-interface.c
+++ b/soft-interface.c
@@ -449,6 +449,30 @@ static void batadv_interface_setup(struct net_device *dev)
 	memset(priv, 0, sizeof(*priv));
 }
 
+/**
+ * batadv_softif_destroy_finish - cleans up the remains of a softif
+ * @work: work queue item
+ *
+ * Free the parts of the soft interface which can not be removed under
+ * rtnl lock (to prevent deadlock situations).
+ */
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
 struct net_device *batadv_softif_create(const char *name)
 {
 	struct net_device *soft_iface;
@@ -463,6 +487,8 @@ struct net_device *batadv_softif_create(const char *name)
 		goto out;
 
 	bat_priv = netdev_priv(soft_iface);
+	bat_priv->soft_iface = soft_iface;
+	INIT_WORK(&bat_priv->cleanup_work, batadv_softif_destroy_finish);
 
 	/* batadv_interface_stats() needs to be available as soon as
 	 * register_netdevice() has been called
@@ -551,10 +577,10 @@ out:
 
 void batadv_softif_destroy(struct net_device *soft_iface)
 {
-	batadv_debugfs_del_meshif(soft_iface);
-	batadv_sysfs_del_meshif(soft_iface);
+	struct batadv_priv *bat_priv = netdev_priv(soft_iface);
+
 	batadv_mesh_free(soft_iface);
-	unregister_netdevice(soft_iface);
+	queue_work(batadv_event_workqueue, &bat_priv->cleanup_work);
 }
 
 int batadv_softif_is_valid(const struct net_device *net_dev)
diff --git a/types.h b/types.h
index 89ac1fb..4cd87a0 100644
--- a/types.h
+++ b/types.h
@@ -68,6 +68,7 @@ struct batadv_hard_iface_bat_iv {
  * @soft_iface: the batman-adv interface which uses this network interface
  * @rcu: struct used for freeing in an RCU-safe manner
  * @bat_iv: BATMAN IV specific per hard interface data
+ * @cleanup_work: work queue callback item for hard interface deinit
  */
 struct batadv_hard_iface {
 	struct list_head list;
@@ -81,6 +82,7 @@ struct batadv_hard_iface {
 	struct net_device *soft_iface;
 	struct rcu_head rcu;
 	struct batadv_hard_iface_bat_iv bat_iv;
+	struct work_struct cleanup_work;
 };
 
 /**
@@ -428,6 +430,7 @@ struct batadv_priv_dat {
 /**
  * struct batadv_priv - per mesh interface data
  * @mesh_state: current status of the mesh (inactive/active/deactivating)
+ * @soft_iface: net device which holds this struct as private data
  * @stats: structure holding the data for the ndo_get_stats() call
  * @bat_counters: mesh internal traffic statistic counters (see batadv_counters)
  * @aggregated_ogms: bool indicating whether OGM aggregation is enabled
@@ -457,6 +460,7 @@ struct batadv_priv_dat {
  * @forw_bat_list_lock: lock protecting forw_bat_list
  * @forw_bcast_list_lock: lock protecting forw_bcast_list
  * @orig_work: work queue callback item for orig node purging
+ * @cleanup_work: work queue callback item for soft interface deinit
  * @primary_if: one of the hard interfaces assigned to this mesh interface
  *  becomes the primary interface
  * @bat_algo_ops: routing algorithm used by this mesh interface
@@ -469,6 +473,7 @@ struct batadv_priv_dat {
  */
 struct batadv_priv {
 	atomic_t mesh_state;
+	struct net_device *soft_iface;
 	struct net_device_stats stats;
 	uint64_t __percpu *bat_counters; /* Per cpu counters */
 	atomic_t aggregated_ogms;
@@ -502,6 +507,7 @@ struct batadv_priv {
 	spinlock_t forw_bat_list_lock; /* protects forw_bat_list */
 	spinlock_t forw_bcast_list_lock; /* protects forw_bcast_list */
 	struct delayed_work orig_work;
+	struct work_struct cleanup_work;
 	struct batadv_hard_iface __rcu *primary_if;  /* rcu protected pointer */
 	struct batadv_algo_ops *bat_algo_ops;
 #ifdef CONFIG_BATMAN_ADV_BLA
-- 
1.7.10.4

