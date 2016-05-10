Return-Path: <a@unstable.cc>
From: Antonio Quartulli <a@unstable.cc>
Date: Tue, 10 May 2016 18:06:05 +0800
Message-Id: <1462874769-5077-1-git-send-email-a@unstable.cc>
Subject: [B.A.T.M.A.N.] [PATCH v2 1/5] batman-adv: make the GW selection
	class algorithm specific
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
Cc: Antonio Quartulli <a@unstable.cc>

The B.A.T.M.A.N. V algorithm uses a different metric compared to its
predecessor and for this reason the logic used to compute the best
Gateway is also changed. This means that the GW selection class
fed to this logic has a semantics that depends on the algorithm being
used.

Make the parsing and printing routine of the GW selection class
routing algorithm specific. Each algorithm can now parse (and print)
this value independently.

If no API is provided by any algorithm, the default is to use the
current mechanism of considering such value like an integer between
1 and 255.

Signed-off-by: Antonio Quartulli <a@unstable.cc>
---

Changes from v1:
- add missing includes
- create non-anonymous struct to store GW specific calls (makes it
  easier to provide working kernel-doc)


 net/batman-adv/bat_v.c | 34 ++++++++++++++++++++++++++++++++++
 net/batman-adv/sysfs.c | 36 ++++++++++++++++++++++++++++++++++--
 net/batman-adv/types.h | 13 +++++++++++++
 3 files changed, 81 insertions(+), 2 deletions(-)

diff --git a/net/batman-adv/bat_v.c b/net/batman-adv/bat_v.c
index c16cd44..e4eb221 100644
--- a/net/batman-adv/bat_v.c
+++ b/net/batman-adv/bat_v.c
@@ -21,8 +21,10 @@
 #include <linux/atomic.h>
 #include <linux/bug.h>
 #include <linux/cache.h>
+#include <linux/errno.h>
 #include <linux/init.h>
 #include <linux/jiffies.h>
+#include <linux/kernel.h>
 #include <linux/netdevice.h>
 #include <linux/rculist.h>
 #include <linux/rcupdate.h>
@@ -33,6 +35,8 @@
 
 #include "bat_v_elp.h"
 #include "bat_v_ogm.h"
+#include "gateway_client.h"
+#include "gateway_common.h"
 #include "hard-interface.h"
 #include "hash.h"
 #include "originator.h"
@@ -324,6 +328,32 @@ err_ifinfo1:
 	return ret;
 }
 
+static ssize_t batadv_v_store_sel_class(struct batadv_priv *bat_priv,
+					char *buff, size_t count)
+{
+	u32 old_class, class;
+
+	if (!batadv_parse_throughput(bat_priv->soft_iface, buff,
+				     "B.A.T.M.A.N. V GW selection class",
+				     &class))
+		return -EINVAL;
+
+	old_class = atomic_read(&bat_priv->gw.sel_class);
+	atomic_set(&bat_priv->gw.sel_class, class);
+
+	if (old_class != class)
+		batadv_gw_reselect(bat_priv);
+
+	return count;
+}
+
+static ssize_t batadv_v_show_sel_class(struct batadv_priv *bat_priv, char *buff)
+{
+	u32 class = atomic_read(&bat_priv->gw.sel_class);
+
+	return sprintf(buff, "%u.%u MBit\n", class / 10, class % 10);
+}
+
 static struct batadv_algo_ops batadv_batman_v __read_mostly = {
 	.name = "BATMAN_V",
 	.bat_iface_activate = batadv_v_iface_activate,
@@ -336,6 +366,10 @@ static struct batadv_algo_ops batadv_batman_v __read_mostly = {
 	.bat_neigh_cmp = batadv_v_neigh_cmp,
 	.bat_neigh_is_similar_or_better = batadv_v_neigh_is_sob,
 	.bat_neigh_print = batadv_v_neigh_print,
+	.gw = {
+		.bat_store_sel_class = batadv_v_store_sel_class,
+		.bat_show_sel_class = batadv_v_show_sel_class,
+	},
 };
 
 /**
diff --git a/net/batman-adv/sysfs.c b/net/batman-adv/sysfs.c
index 233abcf..ad37cb0 100644
--- a/net/batman-adv/sysfs.c
+++ b/net/batman-adv/sysfs.c
@@ -513,6 +513,38 @@ static ssize_t batadv_store_gw_mode(struct kobject *kobj,
 	return count;
 }
 
+static ssize_t batadv_show_gw_sel_class(struct kobject *kobj,
+					struct attribute *attr, char *buff)
+{
+	struct batadv_priv *bat_priv = batadv_kobj_to_batpriv(kobj);
+
+	if (bat_priv->bat_algo_ops->gw.bat_show_sel_class)
+		return bat_priv->bat_algo_ops->gw.bat_show_sel_class(bat_priv,
+								     buff);
+
+	return sprintf(buff, "%i\n", atomic_read(&bat_priv->gw.sel_class));
+}
+
+static ssize_t batadv_store_gw_sel_class(struct kobject *kobj,
+					 struct attribute *attr, char *buff,
+					 size_t count)
+{
+	struct batadv_priv *bat_priv = batadv_kobj_to_batpriv(kobj);
+
+	if (buff[count - 1] == '\n')
+		buff[count - 1] = '\0';
+
+	if (bat_priv->bat_algo_ops->gw.bat_store_sel_class)
+		return bat_priv->bat_algo_ops->gw.bat_store_sel_class(bat_priv,
+								      buff,
+								      count);
+
+	return __batadv_store_uint_attr(buff, count, 0, BATADV_TQ_MAX_VALUE,
+					batadv_post_gw_reselect, attr,
+					&bat_priv->gw.sel_class,
+					bat_priv->soft_iface);
+}
+
 static ssize_t batadv_show_gw_bwidth(struct kobject *kobj,
 				     struct attribute *attr, char *buff)
 {
@@ -624,8 +656,8 @@ BATADV_ATTR_SIF_UINT(orig_interval, orig_interval, S_IRUGO | S_IWUSR,
 		     2 * BATADV_JITTER, INT_MAX, NULL);
 BATADV_ATTR_SIF_UINT(hop_penalty, hop_penalty, S_IRUGO | S_IWUSR, 0,
 		     BATADV_TQ_MAX_VALUE, NULL);
-BATADV_ATTR_SIF_UINT(gw_sel_class, gw.sel_class, S_IRUGO | S_IWUSR, 1,
-		     BATADV_TQ_MAX_VALUE, batadv_post_gw_reselect);
+static BATADV_ATTR(gw_sel_class, S_IRUGO | S_IWUSR, batadv_show_gw_sel_class,
+		   batadv_store_gw_sel_class);
 static BATADV_ATTR(gw_bandwidth, S_IRUGO | S_IWUSR, batadv_show_gw_bwidth,
 		   batadv_store_gw_bwidth);
 #ifdef CONFIG_BATMAN_ADV_MCAST
diff --git a/net/batman-adv/types.h b/net/batman-adv/types.h
index 32c6d0e..f4fdf08 100644
--- a/net/batman-adv/types.h
+++ b/net/batman-adv/types.h
@@ -1259,6 +1259,17 @@ struct batadv_forw_packet {
 };
 
 /**
+ * struct batadv_algo_gw_ops - mesh algorithm callbacks (GW specific)
+ * @bat_store_sel_class: parse and stores a new GW selection class
+ * @bat_show_sel_class: prints the current GW selection class
+ */
+struct batadv_algo_gw_ops {
+	ssize_t (*bat_store_sel_class)(struct batadv_priv *bat_priv, char *buff,
+				       size_t count);
+	ssize_t (*bat_show_sel_class)(struct batadv_priv *bat_priv, char *buff);
+};
+
+/**
  * struct batadv_algo_ops - mesh algorithm callbacks
  * @list: list node for the batadv_algo_list
  * @name: name of the algorithm
@@ -1283,6 +1294,7 @@ struct batadv_forw_packet {
  *  the orig_node due to a new hard-interface being added into the mesh
  * @bat_orig_del_if: ask the routing algorithm to apply the needed changes to
  *  the orig_node due to an hard-interface being removed from the mesh
+ * @gw: callbacks related to GW mode
  */
 struct batadv_algo_ops {
 	struct hlist_node list;
@@ -1312,6 +1324,7 @@ struct batadv_algo_ops {
 			       int max_if_num);
 	int (*bat_orig_del_if)(struct batadv_orig_node *orig_node,
 			       int max_if_num, int del_if_num);
+	struct batadv_algo_gw_ops gw;
 };
 
 /**
-- 
2.8.2

