Return-Path: <antonio@meshcoding.com>
From: Antonio Quartulli <antonio@meshcoding.com>
Date: Tue, 12 Nov 2013 10:18:18 +0100
Message-Id: <1384247902-789-2-git-send-email-antonio@meshcoding.com>
In-Reply-To: <1384247902-789-1-git-send-email-antonio@meshcoding.com>
References: <1384247902-789-1-git-send-email-antonio@meshcoding.com>
Subject: [B.A.T.M.A.N.] [PATCH 1/5] batman-adv: add isolation_mark sysfs
	attribute
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
Cc: Antonio Quartulli <antonio@open-mesh.com>

From: Antonio Quartulli <antonio@open-mesh.com>

This attribute can be used to set and read the value and the
mask of the skb mark which will be used to classify the
source non-mesh client as ISOLATED. In this way a client can
be advertised as such and the mark can potentially be
restored at the receiving node before delivering the skb.

This can be helpful for creating network wide netfilter
policies.

This sysfs file expects a string of the shape "$mark/$mask".
Where $mark has to be a 32-bit number in any base, while
$mask must be a 32bit mask expressed in hex base. Only bits
in $mark covered by the bitmask are really stored.

Signed-off-by: Antonio Quartulli <antonio@open-mesh.com>
---
 soft-interface.c |  2 ++
 sysfs.c          | 68 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 types.h          |  2 ++
 3 files changed, 72 insertions(+)

diff --git a/soft-interface.c b/soft-interface.c
index a3797c5..c945cea 100644
--- a/soft-interface.c
+++ b/soft-interface.c
@@ -692,6 +692,8 @@ static int batadv_softif_init_late(struct net_device *dev)
 #endif
 	bat_priv->tt.last_changeset = NULL;
 	bat_priv->tt.last_changeset_len = 0;
+	bat_priv->isolation_mark = 0;
+	bat_priv->isolation_mark_mask = 0;
 
 	/* randomize initial seqno to avoid collision */
 	get_random_bytes(&random_seqno, sizeof(random_seqno));
diff --git a/sysfs.c b/sysfs.c
index 98f8568..af4d661 100644
--- a/sysfs.c
+++ b/sysfs.c
@@ -447,6 +447,71 @@ static ssize_t batadv_store_gw_bwidth(struct kobject *kobj,
 	return batadv_gw_bandwidth_set(net_dev, buff, count);
 }
 
+/**
+ * batadv_store_isolation_mark - parse and store the isolation mark/mask entered by
+ *  the user
+ * @kobj: kobject representing the private mesh sysfs directory
+ * @attr: the batman-adv attribute the user is interacting with
+ * @buf: the buffer containing the user data
+ * @count: number of bytes in the buffer
+ *
+ * Returns 'count' on success or a negative error code in case of failure
+ */
+static ssize_t batadv_store_isolation_mark(struct kobject *kobj,
+					   struct attribute *attr, char *buff,
+					   size_t count)
+{
+	struct net_device *net_dev = batadv_kobj_to_netdev(kobj);
+	struct batadv_priv *bat_priv = netdev_priv(net_dev);
+	uint32_t mark, mask;
+	char *mask_ptr;
+
+	mask_ptr = strchr(buff, '/');
+	if (!mask_ptr)
+		return -EINVAL;
+
+	*mask_ptr = '\0';
+	mask_ptr++;
+
+	/* the mark can be entered in any base */
+	if (kstrtou32(buff, 0, &mark) < 0)
+		return -EINVAL;
+
+	/* the mask must be entered in hex base as it is going to be a bitmask
+	 * and not a prefix length
+	 */
+	if (kstrtou32(mask_ptr, 16, &mask) < 0)
+		return -EINVAL;
+
+	bat_priv->isolation_mark_mask = mask;
+	/* erase bits not covered by the mask */
+	bat_priv->isolation_mark = mark & bat_priv->isolation_mark_mask;
+
+	batadv_info(net_dev,
+		    "New skb mark for extended isolation: %#.8x/%#.8x\n",
+		    bat_priv->isolation_mark, bat_priv->isolation_mark_mask);
+
+	return count;
+}
+
+/**
+ * batadv_show_isolation_mark - print the current isolation mark/mask
+ * @kobj: kobject representing the private mesh sysfs directory
+ * @attr: the batman-adv attribute the user is interacting with
+ * @buf: the buffer that will contain the data to send back to the user
+ *
+ * Returns the number of bytes written into 'buf' on success or a negative error
+ * code in case of failure
+ */
+static ssize_t batadv_show_isolation_mark(struct kobject *kobj,
+				          struct attribute *attr, char *buff)
+{
+	struct batadv_priv *bat_priv = batadv_kobj_to_batpriv(kobj);
+
+	return sprintf(buff, "%#.8x/%#.8x\n", bat_priv->isolation_mark,
+		       bat_priv->isolation_mark_mask);
+}
+
 BATADV_ATTR_SIF_BOOL(aggregated_ogms, S_IRUGO | S_IWUSR, NULL);
 BATADV_ATTR_SIF_BOOL(bonding, S_IRUGO | S_IWUSR, NULL);
 #ifdef CONFIG_BATMAN_ADV_BLA
@@ -475,6 +540,8 @@ BATADV_ATTR_SIF_UINT(log_level, S_IRUGO | S_IWUSR, 0, BATADV_DBG_ALL, NULL);
 BATADV_ATTR_SIF_BOOL(network_coding, S_IRUGO | S_IWUSR,
 		     batadv_nc_status_update);
 #endif
+static BATADV_ATTR(isolation_mark, S_IRUGO | S_IWUSR,
+		   batadv_show_isolation_mark, batadv_store_isolation_mark);
 
 static struct batadv_attribute *batadv_mesh_attrs[] = {
 	&batadv_attr_aggregated_ogms,
@@ -498,6 +565,7 @@ static struct batadv_attribute *batadv_mesh_attrs[] = {
 #ifdef CONFIG_BATMAN_ADV_NC
 	&batadv_attr_network_coding,
 #endif
+	&batadv_attr_isolation_mark,
 	NULL,
 };
 
diff --git a/types.h b/types.h
index a87bc10..0504040 100644
--- a/types.h
+++ b/types.h
@@ -706,6 +706,8 @@ struct batadv_priv {
 #ifdef CONFIG_BATMAN_ADV_DEBUG
 	atomic_t log_level;
 #endif
+	uint32_t isolation_mark;
+	uint32_t isolation_mark_mask;
 	atomic_t bcast_seqno;
 	atomic_t bcast_queue_left;
 	atomic_t batman_queue_left;
-- 
1.8.4.3

