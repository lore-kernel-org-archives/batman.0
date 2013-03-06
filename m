Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Wed,  6 Mar 2013 11:33:01 +0100
Message-Id: <1362565981-31117-2-git-send-email-ordex@autistici.org>
In-Reply-To: <1362565981-31117-1-git-send-email-ordex@autistici.org>
References: <1362565981-31117-1-git-send-email-ordex@autistici.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [RFC 2/2] batman-adv: enable/disable promiscuous
	mode on interface when needed
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
Cc: =?UTF-8?q?Martin=20Hundeb=C3=B8ll?= <martin@hundeboll.net>

The recently introduce network coding component needs the
hard interfaces to be in promiscuous mode when used in
batman-adv. This patch enable promiscuous mode automatically
when an interface is added to batman-adv and disables it
when the interface is removed.

Cc: Martin Hundebøll <martin@hundeboll.net>
Signed-off-by: Antonio Quartulli <ordex@autistici.org>
---

* compiled test only *
will do some tests after being sure I'm not doing an idiot thing :P


 hard-interface.c |  7 +++++
 network-coding.c | 81 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 network-coding.h | 23 ++++++++++++++++
 sysfs.c          |  3 ++-
 4 files changed, 113 insertions(+), 1 deletion(-)

diff --git a/hard-interface.c b/hard-interface.c
index fd99e42..40f04f9 100644
--- a/hard-interface.c
+++ b/hard-interface.c
@@ -26,6 +26,7 @@
 #include "routing.h"
 #include "sysfs.h"
 #include "originator.h"
+#include "network-coding.h"
 #include "hash.h"
 #include "bridge_loop_avoidance.h"
 
@@ -371,6 +372,10 @@ int batadv_hardif_enable_interface(struct batadv_hard_iface *hard_iface,
 		goto err_upper;
 	}
 
+	ret = batadv_nc_init_hard_iface(bat_priv, hard_iface);
+	if (ret < 0)
+		goto err_upper;
+
 	hard_iface->batman_adv_ptype.type = ethertype;
 	hard_iface->batman_adv_ptype.func = batadv_batman_skb_recv;
 	hard_iface->batman_adv_ptype.dev = hard_iface->net_dev;
@@ -458,6 +463,8 @@ void batadv_hardif_disable_interface(struct batadv_hard_iface *hard_iface,
 	if (!bat_priv->num_ifaces && autodel == BATADV_IF_CLEANUP_AUTO)
 		batadv_softif_destroy_sysfs(hard_iface->soft_iface);
 
+	batadv_nc_clean_hard_iface(bat_priv, hard_iface);
+
 	netdev_upper_dev_unlink(hard_iface->net_dev, hard_iface->soft_iface);
 	hard_iface->soft_iface = NULL;
 	batadv_hardif_free_ref(hard_iface);
diff --git a/network-coding.c b/network-coding.c
index e6b192c..9dab71a 100644
--- a/network-coding.c
+++ b/network-coding.c
@@ -1827,3 +1827,84 @@ int batadv_nc_init_debugfs(struct batadv_priv *bat_priv)
 out:
 	return -ENOMEM;
 }
+
+/**
+ * _batadv_nc_init_hard_iface - init an hard interface
+ * @hard_iface: interface to be initialised
+ *
+ * Init the interface without checking for the NC to be enabled or not and
+ * return 0 on success, a negatove value representing the error otherwise
+ */
+static int _batadv_nc_init_hard_iface(struct batadv_hard_iface *hard_iface)
+{
+	return drv_set_promiscuity(hard_iface->net_dev, 1);
+}
+
+/**
+ * batadv_nc_init_hard_iface - performs init operations on an hard_iface
+ * @bat_priv:
+ * @hard_iface: interface to initialise for network coding
+ *
+ * Set promiscuous mode on for the given interface and return 0 on success, a
+ * negative value representing the error otherwise
+ */
+int batadv_nc_init_hard_iface(struct batadv_priv *bat_priv,
+			      struct batadv_hard_iface *hard_iface)
+{
+	if (!atomic_read(&bat_priv->network_coding))
+		return 0;
+
+	return _batadv_nc_init_hard_iface(hard_iface);
+}
+
+/**
+ * _batadv_nc_clean_hard_iface - clean up the interface
+ * @hard_iface: the interface to clean up
+ *
+ * Clean up the interface without checking for NC to be enabled or not and
+ * return 0 on success, a negative value representing the error otherwise
+ */
+static int _batadv_nc_clean_hard_iface(struct batadv_hard_iface *hard_iface)
+{
+	return drv_set_promiscuity(hard_iface->net_dev, -1);
+}
+
+
+/**
+ * batadv_nc_clean_hard_iface - performs clean up operations on an hard_iface
+ * @bat_priv:
+ * @hard_iface: interface to clean up for network coding
+ *
+ * Unset promiscuous mode on for the given interface and return 0 on success, a
+ * negative value representing the error otherwise
+ */
+int batadv_nc_clean_hard_iface(struct batadv_priv *bat_priv,
+			       struct batadv_hard_iface *hard_iface)
+{
+	if (!atomic_read(&bat_priv->network_coding))
+		return 0;
+
+	return _batadv_nc_clean_hard_iface(hard_iface);
+}
+
+/**
+ * batadv_nc_switch - performs operations on NC runtime switch
+ * @soft_iface: the involved soft interface
+ */
+void batadv_nc_switch(struct net_device *soft_iface)
+{
+	struct batadv_hard_iface *hard_iface_tmp;
+	bool enabled = atomic_read(&bat_priv->network_coding);
+
+	rcu_read_lock();
+	list_for_each_entry_rcu(hard_iface_tmp, &batadv_hardif_list, list) {
+		if (hard_iface_tmp->soft_iface != soft_iface)
+			continue;
+
+		if (enabled)
+			_batadv_nc_init_hard_iface(hard_iface_tmp);
+		else
+			_batadv_nc_clean_hard_iface(hard_iface_tmp);
+	}
+	rcu_read_unlock();
+}
diff --git a/network-coding.h b/network-coding.h
index 352c693..8d61e53 100644
--- a/network-coding.h
+++ b/network-coding.h
@@ -44,6 +44,11 @@ void batadv_nc_skb_store_sniffed_unicast(struct batadv_priv *bat_priv,
 					 struct sk_buff *skb);
 int batadv_nc_nodes_seq_print_text(struct seq_file *seq, void *offset);
 int batadv_nc_init_debugfs(struct batadv_priv *bat_priv);
+int batadv_nc_init_hard_iface(struct batadv_priv *bat_priv,
+			      struct batadv_hard_iface *hard_iface);
+int batadv_nc_clean_hard_iface(struct batadv_priv *bat_priv,
+			       struct batadv_hard_iface *hard_iface);
+void batadv_nc_switch(struct net_device *soft_iface);
 
 #else /* ifdef CONFIG_BATMAN_ADV_NC */
 
@@ -118,6 +123,24 @@ static inline int batadv_nc_init_debugfs(struct batadv_priv *bat_priv)
 	return 0;
 }
 
+static inline int
+batadv_nc_init_hard_iface(struct batadv_priv *bat_priv,
+			  struct batadv_hard_iface *hard_iface)
+{
+	return 0;
+}
+
+static inline int
+batadv_nc_clean_hard_iface(struct batadv_priv *bat_priv,
+			   struct batadv_hard_iface *hard_iface)
+{
+	return 0;
+}
+
+static inline void batadv_nc_switch(struct net_device *soft_iface)
+{
+}
+
 #endif /* ifdef CONFIG_BATMAN_ADV_NC */
 
 #endif /* _NET_BATMAN_ADV_NETWORK_CODING_H */
diff --git a/sysfs.c b/sysfs.c
index c9b5257..f0e930c 100644
--- a/sysfs.c
+++ b/sysfs.c
@@ -25,6 +25,7 @@
 #include "hard-interface.h"
 #include "gateway_common.h"
 #include "gateway_client.h"
+#include "network-coding.h"
 #include "vis.h"
 
 static struct net_device *batadv_kobj_to_netdev(struct kobject *obj)
@@ -443,7 +444,7 @@ static BATADV_ATTR(gw_bandwidth, S_IRUGO | S_IWUSR, batadv_show_gw_bwidth,
 BATADV_ATTR_SIF_UINT(log_level, S_IRUGO | S_IWUSR, 0, BATADV_DBG_ALL, NULL);
 #endif
 #ifdef CONFIG_BATMAN_ADV_NC
-BATADV_ATTR_SIF_BOOL(network_coding, S_IRUGO | S_IWUSR, NULL);
+BATADV_ATTR_SIF_BOOL(network_coding, S_IRUGO | S_IWUSR, batadv_nc_switch);
 #endif
 
 static struct batadv_attribute *batadv_mesh_attrs[] = {
-- 
1.8.1.5

