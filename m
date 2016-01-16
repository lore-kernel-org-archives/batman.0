Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Sat, 16 Jan 2016 16:40:14 +0800
Message-Id: <1452933619-6712-7-git-send-email-mareklindner@neomailbox.ch>
In-Reply-To: <8047297.0qIFjkW2bL@voltaire>
References: <8047297.0qIFjkW2bL@voltaire>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCH v2 07/12] batman-adv: add throughput override
	attribute to hard_ifaces
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
Cc: Antonio Quartulli <antonio@open-mesh.com>

From: Antonio Quartulli <antonio@open-mesh.com>

This attribute is exported to user space to disable the link
throughput auto-detection by setting a fixed value.
The throughput override value is used when batman-adv is
computing the link throughput towards a neighbour.

If the value is set to 0 then batman-adv will try to detect
the throughput by itself.

Signed-off-by: Antonio Quartulli <antonio@open-mesh.com>
---
 .../ABI/testing/sysfs-class-net-batman-adv         |  9 +++
 net/batman-adv/bat_v.c                             |  6 ++
 net/batman-adv/gateway_common.c                    |  4 +-
 net/batman-adv/gateway_common.h                    |  2 +
 net/batman-adv/sysfs.c                             | 74 ++++++++++++++++++++++
 net/batman-adv/types.h                             |  2 +
 6 files changed, 95 insertions(+), 2 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-class-net-batman-adv b/Documentation/ABI/testing/sysfs-class-net-batman-adv
index aea78db..518f6a1 100644
--- a/Documentation/ABI/testing/sysfs-class-net-batman-adv
+++ b/Documentation/ABI/testing/sysfs-class-net-batman-adv
@@ -1,4 +1,13 @@
 
+What:		/sys/class/net/<iface>/batman-adv/throughput_override
+Date:		Feb 2014
+Contact:	Antonio Quartulli <antonio@meshcoding.com>
+description:
+		Defines the throughput value to be used by B.A.T.M.A.N. V
+		when estimating the link throughput using this interface.
+		If the value is set to 0 then batman-adv will try to
+		estimate the throughput by itself.
+
 What:           /sys/class/net/<iface>/batman-adv/elp_interval
 Date:           Feb 2014
 Contact:        Linus Lüssing <linus.luessing@web.de>
diff --git a/net/batman-adv/bat_v.c b/net/batman-adv/bat_v.c
index b90a4df..d9cb5c4 100644
--- a/net/batman-adv/bat_v.c
+++ b/net/batman-adv/bat_v.c
@@ -18,6 +18,7 @@
 #include "bat_algo.h"
 #include "main.h"
 
+#include <linux/atomic.h>
 #include <linux/cache.h>
 #include <linux/init.h>
 
@@ -37,6 +38,11 @@ static int batadv_v_iface_enable(struct batadv_hard_iface *hard_iface)
 	if (ret < 0)
 		batadv_v_elp_iface_disable(hard_iface);
 
+	/* enable link throughput auto-detection by setting the throughput
+	 * override to zero
+	 */
+	atomic_set(&hard_iface->bat_v.throughput_override, 0);
+
 	return ret;
 }
 
diff --git a/net/batman-adv/gateway_common.c b/net/batman-adv/gateway_common.c
index 5ee04f7..4423047 100644
--- a/net/batman-adv/gateway_common.c
+++ b/net/batman-adv/gateway_common.c
@@ -40,8 +40,8 @@
  *
  * Return: false on parse error and true otherwise.
  */
-static bool batadv_parse_throughput(struct net_device *net_dev, char *buff,
-				    const char *description, u32 *throughput)
+bool batadv_parse_throughput(struct net_device *net_dev, char *buff,
+			     const char *description, u32 *throughput)
 {
 	enum batadv_bandwidth_units bw_unit_type = BATADV_BW_UNIT_KBIT;
 	u64 lthroughput;
diff --git a/net/batman-adv/gateway_common.h b/net/batman-adv/gateway_common.h
index b583463..8a5e1dd 100644
--- a/net/batman-adv/gateway_common.h
+++ b/net/batman-adv/gateway_common.h
@@ -49,5 +49,7 @@ ssize_t batadv_gw_bandwidth_set(struct net_device *net_dev, char *buff,
 void batadv_gw_tvlv_container_update(struct batadv_priv *bat_priv);
 void batadv_gw_init(struct batadv_priv *bat_priv);
 void batadv_gw_free(struct batadv_priv *bat_priv);
+bool batadv_parse_throughput(struct net_device *net_dev, char *buff,
+			     const char *description, u32 *throughput);
 
 #endif /* _NET_BATMAN_ADV_GATEWAY_COMMON_H_ */
diff --git a/net/batman-adv/sysfs.c b/net/batman-adv/sysfs.c
index e860143..e7cf513 100644
--- a/net/batman-adv/sysfs.c
+++ b/net/batman-adv/sysfs.c
@@ -917,12 +917,85 @@ static ssize_t batadv_show_iface_status(struct kobject *kobj,
 	return length;
 }
 
+#ifdef CONFIG_BATMAN_ADV_BATMAN_V
+
+/**
+ * batadv_store_throughput_override - parse and store throughput override
+ *  entered by the user
+ * @kobj: kobject representing the private mesh sysfs directory
+ * @attr: the batman-adv attribute the user is interacting with
+ * @buff: the buffer containing the user data
+ * @count: number of bytes in the buffer
+ *
+ * Return: 'count' on success or a negative error code in case of failure
+ */
+static ssize_t batadv_store_throughput_override(struct kobject *kobj,
+						struct attribute *attr,
+						char *buff, size_t count)
+{
+	struct net_device *net_dev = batadv_kobj_to_netdev(kobj);
+	struct batadv_hard_iface *hard_iface;
+	u32 tp_override;
+	u32 old_tp_override;
+	bool ret;
+
+	hard_iface = batadv_hardif_get_by_netdev(net_dev);
+	if (!hard_iface)
+		return -EINVAL;
+
+	if (buff[count - 1] == '\n')
+		buff[count - 1] = '\0';
+
+	ret = batadv_parse_throughput(net_dev, buff, "throughput_override",
+				      &tp_override);
+	if (!ret)
+		return count;
+
+	old_tp_override = atomic_read(&hard_iface->bat_v.throughput_override);
+	if (old_tp_override == tp_override)
+		goto out;
+
+	batadv_info(net_dev, "%s: Changing from: %u.%u MBit to: %u.%u MBit\n",
+		    "throughput_override",
+		    old_tp_override / 10, old_tp_override % 10,
+		    tp_override / 10, tp_override % 10);
+
+	atomic_set(&hard_iface->bat_v.throughput_override, tp_override);
+
+out:
+	batadv_hardif_put(hard_iface);
+	return count;
+}
+
+static ssize_t batadv_show_throughput_override(struct kobject *kobj,
+					       struct attribute *attr,
+					       char *buff)
+{
+	struct net_device *net_dev = batadv_kobj_to_netdev(kobj);
+	struct batadv_hard_iface *hard_iface;
+	u32 tp_override;
+
+	hard_iface = batadv_hardif_get_by_netdev(net_dev);
+	if (!hard_iface)
+		return -EINVAL;
+
+	tp_override = atomic_read(&hard_iface->bat_v.throughput_override);
+
+	return sprintf(buff, "%u.%u MBit\n", tp_override / 10,
+		       tp_override % 10);
+}
+
+#endif
+
 static BATADV_ATTR(mesh_iface, S_IRUGO | S_IWUSR, batadv_show_mesh_iface,
 		   batadv_store_mesh_iface);
 static BATADV_ATTR(iface_status, S_IRUGO, batadv_show_iface_status, NULL);
 #ifdef CONFIG_BATMAN_ADV_BATMAN_V
 BATADV_ATTR_HIF_UINT(elp_interval, bat_v.elp_interval, S_IRUGO | S_IWUSR,
 		     2 * BATADV_JITTER, INT_MAX, NULL);
+static BATADV_ATTR(throughput_override, S_IRUGO | S_IWUSR,
+		   batadv_show_throughput_override,
+		   batadv_store_throughput_override);
 #endif
 
 static struct batadv_attribute *batadv_batman_attrs[] = {
@@ -930,6 +1003,7 @@ static struct batadv_attribute *batadv_batman_attrs[] = {
 	&batadv_attr_iface_status,
 #ifdef CONFIG_BATMAN_ADV_BATMAN_V
 	&batadv_attr_elp_interval,
+	&batadv_attr_throughput_override,
 #endif
 	NULL,
 };
diff --git a/net/batman-adv/types.h b/net/batman-adv/types.h
index cf55cd0..a6f0952 100644
--- a/net/batman-adv/types.h
+++ b/net/batman-adv/types.h
@@ -92,12 +92,14 @@ struct batadv_hard_iface_bat_iv {
  * @elp_seqno: current ELP sequence number
  * @elp_skb: base skb containing the ELP message to send
  * @elp_wq: workqueue used to schedule ELP transmissions
+ * @throughput_override: throughput override to disable link auto-detection
  */
 struct batadv_hard_iface_bat_v {
 	atomic_t elp_interval;
 	atomic_t elp_seqno;
 	struct sk_buff *elp_skb;
 	struct delayed_work elp_wq;
+	atomic_t throughput_override;
 };
 
 /**
-- 
2.7.0.rc3

