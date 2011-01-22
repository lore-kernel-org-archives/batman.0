Return-Path: <linus.luessing@web.de>
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@saxnet.de>
Date: Sat, 22 Jan 2011 02:21:28 +0100
Message-Id: <1295659302-7171-6-git-send-email-linus.luessing@saxnet.de>
In-Reply-To: <1295659302-7171-1-git-send-email-linus.luessing@saxnet.de>
References: <1295659302-7171-1-git-send-email-linus.luessing@saxnet.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linus.luessing@web.de
Subject: [B.A.T.M.A.N.] [PATCH 05/19] batman-adv: Add periodic multicast
	tracker timer
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
Cc: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@saxnet.de>

This commit adds a timer for sending periodic tracker packets (the
sending is not in the scope of this patch). Furthermore, the timer gets
restarted if the tracker interval gets changed or if the originator
interval changed and we have selected auto mode for the tracker
interval.

Signed-off-by: Linus Lüssing <linus.luessing@saxnet.de>
---
 bat_sysfs.c |   13 +++++++++++--
 main.c      |    5 +++++
 multicast.c |   57 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 multicast.h |    3 +++
 types.h     |    1 +
 5 files changed, 77 insertions(+), 2 deletions(-)

diff --git a/batman-adv/bat_sysfs.c b/batman-adv/bat_sysfs.c
index f627d70..8f688db 100644
--- a/batman-adv/bat_sysfs.c
+++ b/batman-adv/bat_sysfs.c
@@ -357,8 +357,16 @@ static ssize_t store_gw_bwidth(struct kobject *kobj, struct attribute *attr,
 	return gw_bandwidth_set(net_dev, buff, count);
 }
 
+void update_mcast_tracker(struct net_device *net_dev)
+{
+	struct bat_priv *bat_priv = netdev_priv(net_dev);
+
+	if (!atomic_read(&bat_priv->mcast_tracker_interval))
+		mcast_tracker_reset(bat_priv);
+}
+
 static ssize_t show_mcast_mode(struct kobject *kobj, struct attribute *attr,
-				 char *buff)
+			       char *buff)
 {
 	struct device *dev = to_dev(kobj->parent);
 	struct bat_priv *bat_priv = netdev_priv(to_net_dev(dev));
@@ -509,7 +517,8 @@ BAT_ATTR_BOOL(bonding, S_IRUGO | S_IWUSR, NULL);
 BAT_ATTR_BOOL(fragmentation, S_IRUGO | S_IWUSR, update_min_mtu);
 static BAT_ATTR(vis_mode, S_IRUGO | S_IWUSR, show_vis_mode, store_vis_mode);
 static BAT_ATTR(gw_mode, S_IRUGO | S_IWUSR, show_gw_mode, store_gw_mode);
-BAT_ATTR_UINT(orig_interval, S_IRUGO | S_IWUSR, 2 * JITTER, INT_MAX, NULL);
+BAT_ATTR_UINT(orig_interval, S_IRUGO | S_IWUSR, 2 * JITTER, INT_MAX,
+	      update_mcast_tracker);
 BAT_ATTR_UINT(hop_penalty, S_IRUGO | S_IWUSR, 0, TQ_MAX_VALUE, NULL);
 BAT_ATTR_UINT(gw_sel_class, S_IRUGO | S_IWUSR, 1, TQ_MAX_VALUE,
 	      post_gw_deselect);
diff --git a/batman-adv/main.c b/batman-adv/main.c
index cb3c3a3..1641075 100644
--- a/batman-adv/main.c
+++ b/batman-adv/main.c
@@ -32,6 +32,7 @@
 #include "gateway_client.h"
 #include "types.h"
 #include "vis.h"
+#include "multicast.h"
 #include "hash.h"
 
 struct list_head if_list;
@@ -108,6 +109,9 @@ int mesh_init(struct net_device *soft_iface)
 	if (vis_init(bat_priv) < 1)
 		goto err;
 
+	if (mcast_init(bat_priv) < 1)
+		goto err;
+
 	atomic_set(&bat_priv->mesh_state, MESH_ACTIVE);
 	goto end;
 
@@ -138,6 +142,7 @@ void mesh_free(struct net_device *soft_iface)
 	hna_global_free(bat_priv);
 
 	softif_neigh_purge(bat_priv);
+	mcast_free(bat_priv);
 
 	atomic_set(&bat_priv->mesh_state, MESH_INACTIVE);
 }
diff --git a/batman-adv/multicast.c b/batman-adv/multicast.c
index 0598873..cc83937 100644
--- a/batman-adv/multicast.c
+++ b/batman-adv/multicast.c
@@ -22,6 +22,48 @@
 #include "main.h"
 #include "multicast.h"
 
+/* how long to wait until sending a multicast tracker packet */
+static int tracker_send_delay(struct bat_priv *bat_priv)
+{
+	int tracker_interval = atomic_read(&bat_priv->mcast_tracker_interval);
+
+	/* auto mode, set to 1/2 ogm interval */
+	if (!tracker_interval)
+		tracker_interval = atomic_read(&bat_priv->orig_interval) / 2;
+
+	/* multicast tracker packets get half as much jitter as ogms as they're
+	 * limited down to JITTER and not JITTER*2 */
+	return msecs_to_jiffies(tracker_interval -
+		   JITTER/2 + (random32() % JITTER));
+}
+
+static void start_mcast_tracker(struct bat_priv *bat_priv)
+{
+	/* adding some jitter */
+	unsigned long tracker_interval = tracker_send_delay(bat_priv);
+	queue_delayed_work(bat_event_workqueue, &bat_priv->mcast_tracker_work,
+			   tracker_interval);
+}
+
+static void stop_mcast_tracker(struct bat_priv *bat_priv)
+{
+	cancel_delayed_work_sync(&bat_priv->mcast_tracker_work);
+}
+
+void mcast_tracker_reset(struct bat_priv *bat_priv)
+{
+	stop_mcast_tracker(bat_priv);
+	start_mcast_tracker(bat_priv);
+}
+
+static void mcast_tracker_timer(struct work_struct *work)
+{
+	struct bat_priv *bat_priv = container_of(work, struct bat_priv,
+						 mcast_tracker_work.work);
+
+	start_mcast_tracker(bat_priv);
+}
+
 int mcast_tracker_interval_set(struct net_device *net_dev, char *buff,
 			       size_t count)
 {
@@ -68,6 +110,8 @@ ok:
 
 	atomic_set(&bat_priv->mcast_tracker_interval, new_tracker_interval);
 
+	mcast_tracker_reset(bat_priv);
+
 	return count;
 }
 
@@ -119,3 +163,16 @@ ok:
 
 	return count;
 }
+
+int mcast_init(struct bat_priv *bat_priv)
+{
+	INIT_DELAYED_WORK(&bat_priv->mcast_tracker_work, mcast_tracker_timer);
+	start_mcast_tracker(bat_priv);
+
+	return 1;
+}
+
+void mcast_free(struct bat_priv *bat_priv)
+{
+	stop_mcast_tracker(bat_priv);
+}
diff --git a/batman-adv/multicast.h b/batman-adv/multicast.h
index 12a3376..26ce6d8 100644
--- a/batman-adv/multicast.h
+++ b/batman-adv/multicast.h
@@ -26,5 +26,8 @@ int mcast_tracker_interval_set(struct net_device *net_dev, char *buff,
 			       size_t count);
 int mcast_tracker_timeout_set(struct net_device *net_dev, char *buff,
 			       size_t count);
+void mcast_tracker_reset(struct bat_priv *bat_priv);
+int mcast_init(struct bat_priv *bat_priv);
+void mcast_free(struct bat_priv *bat_priv);
 
 #endif /* _NET_BATMAN_ADV_MULTICAST_H_ */
diff --git a/batman-adv/types.h b/batman-adv/types.h
index 3abf6d9..c4ae252 100644
--- a/batman-adv/types.h
+++ b/batman-adv/types.h
@@ -173,6 +173,7 @@ struct bat_priv {
 	struct delayed_work hna_work;
 	struct delayed_work orig_work;
 	struct delayed_work vis_work;
+	struct delayed_work mcast_tracker_work;
 	struct gw_node *curr_gw;
 	struct vis_info *my_vis_info;
 };
-- 
1.7.2.3

