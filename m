Return-Path: <linus.luessing@c0d3.blue>
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@c0d3.blue>
Date: Mon,  7 May 2018 03:38:23 +0200
Message-Id: <20180507013823.739-3-linus.luessing@c0d3.blue>
In-Reply-To: <20180507013823.739-1-linus.luessing@c0d3.blue>
References: <20180507013823.739-1-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCH v3 2/2] batman-adv: Introduce no noflood mark
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

This mark prevents a multicast packet being flooded through the whole
mesh. The advantage of marking certain multicast packets via e.g.
ebtables instead of dropping is then the following:

This allows an administrator to let specific multicast packets pass as
long as they are forwarded to a limited number of nodes only and are
therefore creating no burdon to unrelated nodes.

For instance when applied to ARP Requests then this allows ARP Requests
to be forwarded to the three DHT candidates via unicast. But it disables
the broadcast fallback if the unicast attempts were left unanswered.

Signed-off-by: Linus Lüssing <linus.luessing@c0d3.blue>
---
Changes in v3:
* Newly added
---
 Documentation/ABI/testing/sysfs-class-net-mesh |   8 ++
 net/batman-adv/soft-interface.c                |  20 +++++
 net/batman-adv/sysfs.c                         | 103 +++++++++++++++++++++----
 net/batman-adv/types.h                         |  12 +++
 4 files changed, 128 insertions(+), 15 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-class-net-mesh b/Documentation/ABI/testing/sysfs-class-net-mesh
index c2b956d4..93fc8d03 100644
--- a/Documentation/ABI/testing/sysfs-class-net-mesh
+++ b/Documentation/ABI/testing/sysfs-class-net-mesh
@@ -76,6 +76,14 @@ Description:
 		is used to classify clients as "isolated" by the
 		Extended Isolation feature.
 
+What:		/sys/class/net/<mesh_iface>/mesh/noflood_mark
+Date:		Mar 2018
+Contact:	Linus Lüssing <linus.luessing@c0d3.blue>
+Description:
+		Defines the noflood mark (and its bitmask) which
+		will drop frames with a matching mark if they were
+		to be flooded.
+
 What:           /sys/class/net/<mesh_iface>/mesh/multicast_mode
 Date:           Feb 2014
 Contact:        Linus Lüssing <linus.luessing@web.de>
diff --git a/net/batman-adv/soft-interface.c b/net/batman-adv/soft-interface.c
index a8559629..e9fe6388 100644
--- a/net/batman-adv/soft-interface.c
+++ b/net/batman-adv/soft-interface.c
@@ -188,6 +188,23 @@ static void batadv_interface_set_rx_mode(struct net_device *dev)
 {
 }
 
+/**
+ * batadv_send_skb_has_noflood_mark() - check if packet has a noflood mark
+ * @bat_priv: the bat priv with all the soft interface information
+ * @skb: the packet to check
+ *
+ * Return: True if the skb's mark matches a configured noflood mark and
+ * noflood mark mask. False otherwise.
+ */
+static bool
+batadv_skb_has_noflood_mark(struct batadv_priv *bat_priv, struct sk_buff *skb)
+{
+	u32 match_mark = skb->mark & bat_priv->noflood_mark_mask;
+
+	return bat_priv->noflood_mark_mask &&
+	       match_mark == bat_priv->noflood_mark;
+}
+
 static netdev_tx_t batadv_interface_tx(struct sk_buff *skb,
 				       struct net_device *soft_iface)
 {
@@ -333,6 +350,9 @@ static netdev_tx_t batadv_interface_tx(struct sk_buff *skb,
 		if (batadv_dat_snoop_outgoing_arp_request(bat_priv, skb))
 			brd_delay = msecs_to_jiffies(ARP_REQ_DELAY);
 
+		if (batadv_skb_has_noflood_mark(bat_priv, skb))
+			goto dropped;
+
 		if (batadv_skb_head_push(skb, sizeof(*bcast_packet)) < 0)
 			goto dropped;
 
diff --git a/net/batman-adv/sysfs.c b/net/batman-adv/sysfs.c
index f2eef43b..7b57e4b4 100644
--- a/net/batman-adv/sysfs.c
+++ b/net/batman-adv/sysfs.c
@@ -618,28 +618,24 @@ static ssize_t batadv_show_isolation_mark(struct kobject *kobj,
 }
 
 /**
- * batadv_store_isolation_mark() - parse and store the isolation mark/mask
- *  entered by the user
- * @kobj: kobject representing the private mesh sysfs directory
- * @attr: the batman-adv attribute the user is interacting with
+ * batadv_store_parse_mark() - parse a mark and mask
  * @buff: the buffer containing the user data
- * @count: number of bytes in the buffer
+ * @mark: the variable to store the mark in
+ * @mask: the variable to store the mask in
  *
- * Return: 'count' on success or a negative error code in case of failure
+ * Parses a string for a mark and mask. The format is expected to consist of
+ * two 32 bit hexadecimal numbers delimited by a '/'.
+ *
+ * Return: 0 on success, -EINVAL on error.
  */
-static ssize_t batadv_store_isolation_mark(struct kobject *kobj,
-					   struct attribute *attr, char *buff,
-					   size_t count)
+static int batadv_store_parse_mark(char *buff, u32 *mark, u32 *mask)
 {
-	struct net_device *net_dev = batadv_kobj_to_netdev(kobj);
-	struct batadv_priv *bat_priv = netdev_priv(net_dev);
-	u32 mark, mask;
 	char *mask_ptr;
 
 	/* parse the mask if it has been specified, otherwise assume the mask is
 	 * the biggest possible
 	 */
-	mask = 0xFFFFFFFF;
+	*mask = 0xFFFFFFFF;
 	mask_ptr = strchr(buff, '/');
 	if (mask_ptr) {
 		*mask_ptr = '\0';
@@ -648,12 +644,36 @@ static ssize_t batadv_store_isolation_mark(struct kobject *kobj,
 		/* the mask must be entered in hex base as it is going to be a
 		 * bitmask and not a prefix length
 		 */
-		if (kstrtou32(mask_ptr, 16, &mask) < 0)
+		if (kstrtou32(mask_ptr, 16, mask) < 0)
 			return -EINVAL;
 	}
 
 	/* the mark can be entered in any base */
-	if (kstrtou32(buff, 0, &mark) < 0)
+	if (kstrtou32(buff, 0, mark) < 0)
+		return -EINVAL;
+
+	return 0;
+}
+
+/**
+ * batadv_store_isolation_mark() - parse and store the isolation mark/mask
+ *  entered by the user
+ * @kobj: kobject representing the private mesh sysfs directory
+ * @attr: the batman-adv attribute the user is interacting with
+ * @buff: the buffer containing the user data
+ * @count: number of bytes in the buffer
+ *
+ * Return: 'count' on success or a negative error code in case of failure
+ */
+static ssize_t batadv_store_isolation_mark(struct kobject *kobj,
+					   struct attribute *attr, char *buff,
+					   size_t count)
+{
+	struct net_device *net_dev = batadv_kobj_to_netdev(kobj);
+	struct batadv_priv *bat_priv = netdev_priv(net_dev);
+	u32 mark, mask;
+
+	if (batadv_store_parse_mark(buff, &mark, &mask) < 0)
 		return -EINVAL;
 
 	bat_priv->isolation_mark_mask = mask;
@@ -667,6 +687,56 @@ static ssize_t batadv_store_isolation_mark(struct kobject *kobj,
 	return count;
 }
 
+/**
+ * batadv_show_noflood_mark() - print the current noflood mark/mask
+ * @kobj: kobject representing the private mesh sysfs directory
+ * @attr: the batman-adv attribute the user is interacting with
+ * @buff: the buffer that will contain the data to send back to the user
+ *
+ * Return: the number of bytes written into 'buff' on success or a negative
+ * error code in case of failure
+ */
+static ssize_t batadv_show_noflood_mark(struct kobject *kobj,
+					struct attribute *attr, char *buff)
+{
+	struct batadv_priv *bat_priv = batadv_kobj_to_batpriv(kobj);
+
+	return sprintf(buff, "%#.8x/%#.8x\n", bat_priv->noflood_mark,
+		       bat_priv->noflood_mark_mask);
+}
+
+/**
+ * batadv_store_noflood_mark() - parse and store the noflood mark/mask
+ *  entered by the user
+ * @kobj: kobject representing the private mesh sysfs directory
+ * @attr: the batman-adv attribute the user is interacting with
+ * @buff: the buffer containing the user data
+ * @count: number of bytes in the buffer
+ *
+ * Return: 'count' on success or a negative error code in case of failure
+ */
+static ssize_t batadv_store_noflood_mark(struct kobject *kobj,
+					 struct attribute *attr, char *buff,
+					 size_t count)
+{
+	struct net_device *net_dev = batadv_kobj_to_netdev(kobj);
+	struct batadv_priv *bat_priv = netdev_priv(net_dev);
+	u32 mark, mask;
+
+	if (batadv_store_parse_mark(buff, &mark, &mask) < 0)
+		return -EINVAL;
+
+	bat_priv->noflood_mark_mask = mask;
+	/* erase bits not covered by the mask */
+	bat_priv->noflood_mark = mark & bat_priv->noflood_mark_mask;
+
+	batadv_info(net_dev,
+		    "New skb noflood mark: %#.8x/%#.8x\n",
+		    bat_priv->noflood_mark, bat_priv->noflood_mark_mask);
+
+	return count;
+}
+
 BATADV_ATTR_SIF_BOOL(aggregated_ogms, 0644, NULL);
 BATADV_ATTR_SIF_BOOL(bonding, 0644, NULL);
 #ifdef CONFIG_BATMAN_ADV_BLA
@@ -697,6 +767,8 @@ BATADV_ATTR_SIF_BOOL(network_coding, 0644, batadv_nc_status_update);
 #endif
 static BATADV_ATTR(isolation_mark, 0644, batadv_show_isolation_mark,
 		   batadv_store_isolation_mark);
+static BATADV_ATTR(noflood_mark, 0644, batadv_show_noflood_mark,
+		   batadv_store_noflood_mark);
 
 static struct batadv_attribute *batadv_mesh_attrs[] = {
 	&batadv_attr_aggregated_ogms,
@@ -724,6 +796,7 @@ static struct batadv_attribute *batadv_mesh_attrs[] = {
 	&batadv_attr_network_coding,
 #endif
 	&batadv_attr_isolation_mark,
+	&batadv_attr_noflood_mark,
 	NULL,
 };
 
diff --git a/net/batman-adv/types.h b/net/batman-adv/types.h
index 360357f8..7d5d9987 100644
--- a/net/batman-adv/types.h
+++ b/net/batman-adv/types.h
@@ -1584,6 +1584,18 @@ struct batadv_priv {
 	 */
 	u32 isolation_mark_mask;
 
+	/**
+	 * @noflood_mark: the skb->mark value used to allow directed targeting
+	 *  only
+	 */
+	u32 noflood_mark;
+
+	/**
+	 * @noflood_mark_mask: bitmask identifying the bits in skb->mark to be
+	 *  used for the noflood mark
+	 */
+	u32 noflood_mark_mask;
+
 	/** @bcast_seqno: last sent broadcast packet sequence number */
 	atomic_t bcast_seqno;
 
-- 
2.11.0

