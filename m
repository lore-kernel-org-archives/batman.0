Return-Path: <linus.luessing@web.de>
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@web.de>
Date: Tue, 24 Sep 2013 15:40:33 +0200
Message-Id: <1380030033-11533-1-git-send-email-linus.luessing@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: introduce 'no_rebroadcast' option
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

This patch introduces a new sysfs option named "no_rebroadcast" on
a per hard interface basis. It allows manually enabling a split-horizon
like behaviour for the layer 2 multicast payload frames, in that
incoming multicast payload frames on such a hard interface are only
being rebroadcasted on all interfaces except the incoming one instead
of being rebroadcasted on all interfaces.

Such an option should only be enabled if you are certain that these
rebroadcasts are unnecessary. This is usually the case for instance
for point-to-point wifi longshots or wired links.

This option can especially safe a significant amount of upload overhead
if the neighbourhood on a link is rather large, for instance in some
transitive, symmetric VPN configurations.

Using this option wrongly will break your mesh network, use this option
wisely and at your own risk!

Signed-off-by: Linus Lüssing <linus.luessing@web.de>
---
 hard-interface.c           |    2 ++
 send.c                     |    4 +++
 sysfs-class-net-batman-adv |   10 ++++++++
 sysfs.c                    |   59 ++++++++++++++++++++++++++++++++++++++++++++
 types.h                    |    1 +
 5 files changed, 76 insertions(+)

diff --git a/hard-interface.c b/hard-interface.c
index c60d3ed..4c27f05 100644
--- a/hard-interface.c
+++ b/hard-interface.c
@@ -602,6 +602,8 @@ batadv_hardif_add_interface(struct net_device *net_dev)
 	/* extra reference for return */
 	atomic_set(&hard_iface->refcount, 2);
 
+	atomic_set(&hard_iface->no_rebroadcast, 0);
+
 	batadv_check_known_mac_addr(hard_iface->net_dev);
 	list_add_tail_rcu(&hard_iface->list, &batadv_hardif_list);
 
diff --git a/send.c b/send.c
index c83be5e..2a0e0cc 100644
--- a/send.c
+++ b/send.c
@@ -496,6 +496,10 @@ static void batadv_send_outstanding_bcast_packet(struct work_struct *work)
 		if (forw_packet->num_packets >= hard_iface->num_bcasts)
 			continue;
 
+		if (atomic_read(&hard_iface->no_rebroadcast) &&
+		    forw_packet->skb->dev == hard_iface->net_dev)
+			continue;
+
 		/* send a copy of the saved skb */
 		skb1 = skb_clone(forw_packet->skb, GFP_ATOMIC);
 		if (skb1)
diff --git a/sysfs-class-net-batman-adv b/sysfs-class-net-batman-adv
index bdc0070..88f6f70 100644
--- a/sysfs-class-net-batman-adv
+++ b/sysfs-class-net-batman-adv
@@ -13,3 +13,13 @@ Description:
                 displays the batman mesh interface this <iface>
                 currently is associated with.
 
+What:           /sys/class/net/<iface>/batman-adv/no_rebroadcast
+Date:           Sep 2013
+Contact:        Linus Lüssing <linus.luessing@web.de>
+Description:
+                With this option set incoming multicast payload frames on
+                <iface> are not being rebroadcasted on <iface> again. This
+                option should be set on links which are known to be transitive
+                and symmetric only, for instance point-to-point wifi longshots
+                or wired links. Using this option wrongly is going to
+                break your mesh network, use at your own risk!
diff --git a/sysfs.c b/sysfs.c
index 096b511..5e2cd21 100644
--- a/sysfs.c
+++ b/sysfs.c
@@ -110,6 +110,17 @@ struct batadv_attribute batadv_attr_vlan_##_name = {	\
 	.store  = _store,				\
 };
 
+/* Use this, if you have customized show and store functions
+ * for hard interface attrs
+ */
+#define BATADV_ATTR_HIF(_name, _mode, _show, _store)	\
+struct batadv_attribute batadv_attr_hif_##_name = {	\
+	.attr = {.name = __stringify(_name),		\
+		 .mode = _mode },			\
+	.show   = _show,				\
+	.store  = _store,				\
+};
+
 /* Use this, if you have customized show and store functions */
 #define BATADV_ATTR(_name, _mode, _show, _store)	\
 struct batadv_attribute batadv_attr_##_name = {		\
@@ -215,6 +226,52 @@ ssize_t batadv_show_vlan_##_name(struct kobject *kobj,			\
 	static BATADV_ATTR_VLAN(_name, _mode, batadv_show_vlan_##_name,	\
 				batadv_store_vlan_##_name)
 
+#define BATADV_ATTR_HIF_STORE_BOOL(_name, _post_func)			\
+ssize_t batadv_store_hif_##_name(struct kobject *kobj,			\
+				 struct attribute *attr, char *buff,	\
+				 size_t count)				\
+{									\
+	struct net_device *net_dev = batadv_kobj_to_netdev(kobj);	\
+	struct batadv_hard_iface *hard_iface;				\
+	size_t res;							\
+									\
+	hard_iface = batadv_hardif_get_by_netdev(net_dev);		\
+	if (!hard_iface)						\
+		return 0;						\
+									\
+	res = __batadv_store_bool_attr(buff, count, _post_func,		\
+					      attr, &hard_iface->_name,	\
+					      hard_iface->soft_iface);	\
+	batadv_hardif_free_ref(hard_iface);				\
+	return res;							\
+}
+
+#define BATADV_ATTR_HIF_SHOW_BOOL(_name)				\
+ssize_t batadv_show_hif_##_name(struct kobject *kobj,			\
+				struct attribute *attr, char *buff)	\
+{									\
+	struct net_device *net_dev = batadv_kobj_to_netdev(kobj);	\
+	struct batadv_hard_iface *hard_iface;				\
+	size_t res;							\
+									\
+	hard_iface = batadv_hardif_get_by_netdev(net_dev);		\
+	if (!hard_iface)						\
+		return 0;						\
+									\
+	res = sprintf(buff, "%s\n",					\
+		      atomic_read(&hard_iface->_name) == 0 ?		\
+				"disabled" : "enabled");		\
+	batadv_hardif_free_ref(hard_iface);				\
+	return res;							\
+}
+
+/* Use this, if you are going to turn a [name] in the vlan struct on or off */
+#define BATADV_ATTR_HIF_BOOL(_name, _mode, _post_func)			\
+	static BATADV_ATTR_HIF_STORE_BOOL(_name, _post_func)		\
+	static BATADV_ATTR_HIF_SHOW_BOOL(_name)				\
+	static BATADV_ATTR_HIF(_name, _mode, batadv_show_hif_##_name,	\
+			       batadv_store_hif_##_name)
+
 static int batadv_store_bool_attr(char *buff, size_t count,
 				  struct net_device *net_dev,
 				  const char *attr_name, atomic_t *attr)
@@ -750,10 +807,12 @@ static ssize_t batadv_show_iface_status(struct kobject *kobj,
 static BATADV_ATTR(mesh_iface, S_IRUGO | S_IWUSR, batadv_show_mesh_iface,
 		   batadv_store_mesh_iface);
 static BATADV_ATTR(iface_status, S_IRUGO, batadv_show_iface_status, NULL);
+BATADV_ATTR_HIF_BOOL(no_rebroadcast, S_IRUGO | S_IWUSR, NULL);
 
 static struct batadv_attribute *batadv_batman_attrs[] = {
 	&batadv_attr_mesh_iface,
 	&batadv_attr_iface_status,
+	&batadv_attr_hif_no_rebroadcast,
 	NULL,
 };
 
diff --git a/types.h b/types.h
index f323822..b5a5824 100644
--- a/types.h
+++ b/types.h
@@ -76,6 +76,7 @@ struct batadv_hard_iface {
 	struct rcu_head rcu;
 	struct batadv_hard_iface_bat_iv bat_iv;
 	struct work_struct cleanup_work;
+	atomic_t no_rebroadcast;
 };
 
 /**
-- 
1.7.10.4

