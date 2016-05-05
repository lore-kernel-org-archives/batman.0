Return-Path: <a@unstable.cc>
From: Antonio Quartulli <a@unstable.cc>
Date: Fri,  6 May 2016 02:46:39 +0800
Message-Id: <1462474003-25279-3-git-send-email-a@unstable.cc>
In-Reply-To: <1462474003-25279-1-git-send-email-a@unstable.cc>
References: <1462474003-25279-1-git-send-email-a@unstable.cc>
Subject: [B.A.T.M.A.N.] [PATCH 3/7] batman-adv: make the GW selection class
	algorithm specific
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
Cc: Antonio Quartulli <a@unstable.cc>, mareklindner@neomailbox.ch

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
 net/batman-adv/bat_v.c | 32 ++++++++++++++++++++++++++++++++
 net/batman-adv/sysfs.c | 36 ++++++++++++++++++++++++++++++++++--
 net/batman-adv/types.h |  8 ++++++++
 3 files changed, 74 insertions(+), 2 deletions(-)

diff --git a/net/batman-adv/bat_v.c b/net/batman-adv/bat_v.c
index 927d405..932cd56 100644
--- a/net/batman-adv/bat_v.c
+++ b/net/batman-adv/bat_v.c
@@ -32,6 +32,8 @@
 
 #include "bat_v_elp.h"
 #include "bat_v_ogm.h"
+#include "gateway_client.h"
+#include "gateway_common.h"
 #include "hard-interface.h"
 #include "hash.h"
 #include "originator.h"
@@ -292,6 +294,32 @@ static bool batadv_v_neigh_is_sob(struct batadv_neigh_node *neigh1,
 	return ifinfo2->bat_v.throughput > threshold;
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
@@ -304,6 +332,10 @@ static struct batadv_algo_ops batadv_batman_v __read_mostly = {
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
index 6f664a2..e7404a4 100644
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
index 32c6d0e..d4ca4c0 100644
--- a/net/batman-adv/types.h
+++ b/net/batman-adv/types.h
@@ -1283,6 +1283,8 @@ struct batadv_forw_packet {
  *  the orig_node due to a new hard-interface being added into the mesh
  * @bat_orig_del_if: ask the routing algorithm to apply the needed changes to
  *  the orig_node due to an hard-interface being removed from the mesh
+ * @gw.bat_store_sel_class: parse and stores a new GW selection class
+ * @gw.bat_show_sel_class: prints the current GW selection class
  */
 struct batadv_algo_ops {
 	struct hlist_node list;
@@ -1312,6 +1314,12 @@ struct batadv_algo_ops {
 			       int max_if_num);
 	int (*bat_orig_del_if)(struct batadv_orig_node *orig_node,
 			       int max_if_num, int del_if_num);
+	struct {
+		ssize_t (*bat_store_sel_class)(struct batadv_priv *bat_priv,
+					       char *buff, size_t count);
+		ssize_t (*bat_show_sel_class)(struct batadv_priv *bat_priv,
+					      char *buff);
+	} gw;
 };
 
 /**
-- 
2.8.2

