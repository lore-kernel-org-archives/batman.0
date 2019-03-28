Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Thu, 28 Mar 2019 16:41:44 +0100
Message-Id: <20190328154152.20552-5-sw@simonwunderlich.de>
In-Reply-To: <20190328154152.20552-1-sw@simonwunderlich.de>
References: <20190328154152.20552-1-sw@simonwunderlich.de>
Subject: [B.A.T.M.A.N.] [PATCH 04/12] batman-adv: Make sysfs support optional
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, Sven Eckelmann <sven@narfation.org>, Simon Wunderlich <sw@simonwunderlich.de>

From: Sven Eckelmann <sven@narfation.org>

The sysfs files will be marked as deprecated in the near future. They are
already replaced by the batadv generic netlink family. Add an Kconfig
option to disable the sysfs support for users who want to test their tools
or want to safe some space. This setting should currently still be enabled
by default to keep backward compatible with legacy tools.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/Kconfig                 | 12 ++++++
 net/batman-adv/Makefile                |  2 +-
 net/batman-adv/bridge_loop_avoidance.c |  1 -
 net/batman-adv/gateway_client.c        |  1 -
 net/batman-adv/main.c                  | 73 ++++++++++++++++++++++++++++++++++
 net/batman-adv/main.h                  |  2 +
 net/batman-adv/sysfs.c                 | 70 --------------------------------
 net/batman-adv/sysfs.h                 | 38 +++++++++++++++++-
 8 files changed, 124 insertions(+), 75 deletions(-)

diff --git a/net/batman-adv/Kconfig b/net/batman-adv/Kconfig
index 17595ec0961a..a3d188dfbe75 100644
--- a/net/batman-adv/Kconfig
+++ b/net/batman-adv/Kconfig
@@ -97,6 +97,18 @@ config BATMAN_ADV_DEBUG
 	  buffer. The output is controlled via the batadv netdev specific
 	  log_level setting.
 
+config BATMAN_ADV_SYSFS
+	bool "batman-adv sysfs entries"
+	depends on BATMAN_ADV
+	default y
+	help
+	  Say Y here if you want to enable batman-adv device configuration and
+	  status interface through sysfs attributes. It is replaced by the
+	  batadv generic netlink family but still used by various userspace
+	  tools and scripts.
+
+	  If unsure, say Y.
+
 config BATMAN_ADV_TRACING
 	bool "B.A.T.M.A.N. tracing support"
 	depends on BATMAN_ADV
diff --git a/net/batman-adv/Makefile b/net/batman-adv/Makefile
index 1bf7acfea17a..fd63e116d9ff 100644
--- a/net/batman-adv/Makefile
+++ b/net/batman-adv/Makefile
@@ -28,7 +28,7 @@ batman-adv-y += originator.o
 batman-adv-y += routing.o
 batman-adv-y += send.o
 batman-adv-y += soft-interface.o
-batman-adv-y += sysfs.o
+batman-adv-$(CONFIG_BATMAN_ADV_SYSFS) += sysfs.o
 batman-adv-$(CONFIG_BATMAN_ADV_TRACING) += trace.o
 batman-adv-y += tp_meter.o
 batman-adv-y += translation-table.o
diff --git a/net/batman-adv/bridge_loop_avoidance.c b/net/batman-adv/bridge_loop_avoidance.c
index ee92bbc25058..8d6b7c9c2a7e 100644
--- a/net/batman-adv/bridge_loop_avoidance.c
+++ b/net/batman-adv/bridge_loop_avoidance.c
@@ -47,7 +47,6 @@
 #include "netlink.h"
 #include "originator.h"
 #include "soft-interface.h"
-#include "sysfs.h"
 #include "translation-table.h"
 
 static const u8 batadv_announce_mac[4] = {0x43, 0x05, 0x43, 0x05};
diff --git a/net/batman-adv/gateway_client.c b/net/batman-adv/gateway_client.c
index be63d6706659..47df4c678988 100644
--- a/net/batman-adv/gateway_client.c
+++ b/net/batman-adv/gateway_client.c
@@ -41,7 +41,6 @@
 #include "originator.h"
 #include "routing.h"
 #include "soft-interface.h"
-#include "sysfs.h"
 #include "translation-table.h"
 
 /* These are the offsets of the "hw type" and "hw address length" in the dhcp
diff --git a/net/batman-adv/main.c b/net/batman-adv/main.c
index 33b9b38b82da..dabcaff87e34 100644
--- a/net/batman-adv/main.c
+++ b/net/batman-adv/main.c
@@ -10,6 +10,7 @@
 #include <linux/build_bug.h>
 #include <linux/byteorder/generic.h>
 #include <linux/crc32c.h>
+#include <linux/device.h>
 #include <linux/errno.h>
 #include <linux/genetlink.h>
 #include <linux/gfp.h>
@@ -19,6 +20,7 @@
 #include <linux/ip.h>
 #include <linux/ipv6.h>
 #include <linux/kernel.h>
+#include <linux/kobject.h>
 #include <linux/kref.h>
 #include <linux/list.h>
 #include <linux/module.h>
@@ -28,6 +30,7 @@
 #include <linux/rcupdate.h>
 #include <linux/seq_file.h>
 #include <linux/skbuff.h>
+#include <linux/slab.h>
 #include <linux/spinlock.h>
 #include <linux/stddef.h>
 #include <linux/string.h>
@@ -72,6 +75,22 @@ struct workqueue_struct *batadv_event_workqueue;
 
 static void batadv_recv_handler_init(void);
 
+#define BATADV_UEV_TYPE_VAR	"BATTYPE="
+#define BATADV_UEV_ACTION_VAR	"BATACTION="
+#define BATADV_UEV_DATA_VAR	"BATDATA="
+
+static char *batadv_uev_action_str[] = {
+	"add",
+	"del",
+	"change",
+	"loopdetect",
+};
+
+static char *batadv_uev_type_str[] = {
+	"gw",
+	"bla",
+};
+
 static int __init batadv_init(void)
 {
 	int ret;
@@ -666,6 +685,60 @@ bool batadv_vlan_ap_isola_get(struct batadv_priv *bat_priv, unsigned short vid)
 	return ap_isolation_enabled;
 }
 
+/**
+ * batadv_throw_uevent() - Send an uevent with batman-adv specific env data
+ * @bat_priv: the bat priv with all the soft interface information
+ * @type: subsystem type of event. Stored in uevent's BATTYPE
+ * @action: action type of event. Stored in uevent's BATACTION
+ * @data: string with additional information to the event (ignored for
+ *  BATADV_UEV_DEL). Stored in uevent's BATDATA
+ *
+ * Return: 0 on success or negative error number in case of failure
+ */
+int batadv_throw_uevent(struct batadv_priv *bat_priv, enum batadv_uev_type type,
+			enum batadv_uev_action action, const char *data)
+{
+	int ret = -ENOMEM;
+	struct kobject *bat_kobj;
+	char *uevent_env[4] = { NULL, NULL, NULL, NULL };
+
+	bat_kobj = &bat_priv->soft_iface->dev.kobj;
+
+	uevent_env[0] = kasprintf(GFP_ATOMIC,
+				  "%s%s", BATADV_UEV_TYPE_VAR,
+				  batadv_uev_type_str[type]);
+	if (!uevent_env[0])
+		goto out;
+
+	uevent_env[1] = kasprintf(GFP_ATOMIC,
+				  "%s%s", BATADV_UEV_ACTION_VAR,
+				  batadv_uev_action_str[action]);
+	if (!uevent_env[1])
+		goto out;
+
+	/* If the event is DEL, ignore the data field */
+	if (action != BATADV_UEV_DEL) {
+		uevent_env[2] = kasprintf(GFP_ATOMIC,
+					  "%s%s", BATADV_UEV_DATA_VAR, data);
+		if (!uevent_env[2])
+			goto out;
+	}
+
+	ret = kobject_uevent_env(bat_kobj, KOBJ_CHANGE, uevent_env);
+out:
+	kfree(uevent_env[0]);
+	kfree(uevent_env[1]);
+	kfree(uevent_env[2]);
+
+	if (ret)
+		batadv_dbg(BATADV_DBG_BATMAN, bat_priv,
+			   "Impossible to send uevent for (%s,%s,%s) event (err: %d)\n",
+			   batadv_uev_type_str[type],
+			   batadv_uev_action_str[action],
+			   (action == BATADV_UEV_DEL ? "NULL" : data), ret);
+	return ret;
+}
+
 module_init(batadv_init);
 module_exit(batadv_exit);
 
diff --git a/net/batman-adv/main.h b/net/batman-adv/main.h
index c5de987778d1..f827e441025f 100644
--- a/net/batman-adv/main.h
+++ b/net/batman-adv/main.h
@@ -382,5 +382,7 @@ static inline void batadv_add_counter(struct batadv_priv *bat_priv, size_t idx,
 
 unsigned short batadv_get_vid(struct sk_buff *skb, size_t header_len);
 bool batadv_vlan_ap_isola_get(struct batadv_priv *bat_priv, unsigned short vid);
+int batadv_throw_uevent(struct batadv_priv *bat_priv, enum batadv_uev_type type,
+			enum batadv_uev_action action, const char *data);
 
 #endif /* _NET_BATMAN_ADV_MAIN_H_ */
diff --git a/net/batman-adv/sysfs.c b/net/batman-adv/sysfs.c
index 4fc9f7305174..7d289e50de71 100644
--- a/net/batman-adv/sysfs.c
+++ b/net/batman-adv/sysfs.c
@@ -102,22 +102,6 @@ batadv_kobj_to_vlan(struct batadv_priv *bat_priv, struct kobject *obj)
 	return vlan;
 }
 
-#define BATADV_UEV_TYPE_VAR	"BATTYPE="
-#define BATADV_UEV_ACTION_VAR	"BATACTION="
-#define BATADV_UEV_DATA_VAR	"BATDATA="
-
-static char *batadv_uev_action_str[] = {
-	"add",
-	"del",
-	"change",
-	"loopdetect",
-};
-
-static char *batadv_uev_type_str[] = {
-	"gw",
-	"bla",
-};
-
 /* Use this, if you have customized show and store functions for vlan attrs */
 #define BATADV_ATTR_VLAN(_name, _mode, _show, _store)	\
 struct batadv_attribute batadv_attr_vlan_##_name = {	\
@@ -1235,57 +1219,3 @@ void batadv_sysfs_del_hardif(struct kobject **hardif_obj)
 	kobject_put(*hardif_obj);
 	*hardif_obj = NULL;
 }
-
-/**
- * batadv_throw_uevent() - Send an uevent with batman-adv specific env data
- * @bat_priv: the bat priv with all the soft interface information
- * @type: subsystem type of event. Stored in uevent's BATTYPE
- * @action: action type of event. Stored in uevent's BATACTION
- * @data: string with additional information to the event (ignored for
- *  BATADV_UEV_DEL). Stored in uevent's BATDATA
- *
- * Return: 0 on success or negative error number in case of failure
- */
-int batadv_throw_uevent(struct batadv_priv *bat_priv, enum batadv_uev_type type,
-			enum batadv_uev_action action, const char *data)
-{
-	int ret = -ENOMEM;
-	struct kobject *bat_kobj;
-	char *uevent_env[4] = { NULL, NULL, NULL, NULL };
-
-	bat_kobj = &bat_priv->soft_iface->dev.kobj;
-
-	uevent_env[0] = kasprintf(GFP_ATOMIC,
-				  "%s%s", BATADV_UEV_TYPE_VAR,
-				  batadv_uev_type_str[type]);
-	if (!uevent_env[0])
-		goto out;
-
-	uevent_env[1] = kasprintf(GFP_ATOMIC,
-				  "%s%s", BATADV_UEV_ACTION_VAR,
-				  batadv_uev_action_str[action]);
-	if (!uevent_env[1])
-		goto out;
-
-	/* If the event is DEL, ignore the data field */
-	if (action != BATADV_UEV_DEL) {
-		uevent_env[2] = kasprintf(GFP_ATOMIC,
-					  "%s%s", BATADV_UEV_DATA_VAR, data);
-		if (!uevent_env[2])
-			goto out;
-	}
-
-	ret = kobject_uevent_env(bat_kobj, KOBJ_CHANGE, uevent_env);
-out:
-	kfree(uevent_env[0]);
-	kfree(uevent_env[1]);
-	kfree(uevent_env[2]);
-
-	if (ret)
-		batadv_dbg(BATADV_DBG_BATMAN, bat_priv,
-			   "Impossible to send uevent for (%s,%s,%s) event (err: %d)\n",
-			   batadv_uev_type_str[type],
-			   batadv_uev_action_str[action],
-			   (action == BATADV_UEV_DEL ? "NULL" : data), ret);
-	return ret;
-}
diff --git a/net/batman-adv/sysfs.h b/net/batman-adv/sysfs.h
index 2d13f59efb1a..83fa808b1871 100644
--- a/net/batman-adv/sysfs.h
+++ b/net/batman-adv/sysfs.h
@@ -45,6 +45,8 @@ struct batadv_attribute {
 			 char *buf, size_t count);
 };
 
+#ifdef CONFIG_BATMAN_ADV_SYSFS
+
 int batadv_sysfs_add_meshif(struct net_device *dev);
 void batadv_sysfs_del_meshif(struct net_device *dev);
 int batadv_sysfs_add_hardif(struct kobject **hardif_obj,
@@ -54,7 +56,39 @@ int batadv_sysfs_add_vlan(struct net_device *dev,
 			  struct batadv_softif_vlan *vlan);
 void batadv_sysfs_del_vlan(struct batadv_priv *bat_priv,
 			   struct batadv_softif_vlan *vlan);
-int batadv_throw_uevent(struct batadv_priv *bat_priv, enum batadv_uev_type type,
-			enum batadv_uev_action action, const char *data);
+
+#else
+
+static inline int batadv_sysfs_add_meshif(struct net_device *dev)
+{
+	return 0;
+}
+
+static inline void batadv_sysfs_del_meshif(struct net_device *dev)
+{
+}
+
+static inline int batadv_sysfs_add_hardif(struct kobject **hardif_obj,
+					  struct net_device *dev)
+{
+	return 0;
+}
+
+static inline void batadv_sysfs_del_hardif(struct kobject **hardif_obj)
+{
+}
+
+static inline int batadv_sysfs_add_vlan(struct net_device *dev,
+					struct batadv_softif_vlan *vlan)
+{
+	return 0;
+}
+
+static inline void batadv_sysfs_del_vlan(struct batadv_priv *bat_priv,
+					 struct batadv_softif_vlan *vlan)
+{
+}
+
+#endif
 
 #endif /* _NET_BATMAN_ADV_SYSFS_H_ */
-- 
2.11.0

