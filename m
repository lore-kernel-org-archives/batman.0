Return-Path: <mpa@pengutronix.de>
From: Markus Pargmann <mpa@pengutronix.de>
Date: Tue,  2 Dec 2014 12:16:20 +0100
Message-Id: <1417519009-20699-3-git-send-email-mpa@pengutronix.de>
In-Reply-To: <1417519009-20699-1-git-send-email-mpa@pengutronix.de>
References: <1417519009-20699-1-git-send-email-mpa@pengutronix.de>
Subject: [B.A.T.M.A.N.] [PATCH 02/31] batman-adv: Separate logging header
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
To: Marek Lindner <mareklindner@neomailbox.ch>, Simon Wunderlich <sw@simonwunderlich.de>, Antonio Quartulli <antonio@meshcoding.com>
Cc: b.a.t.m.a.n@lists.open-mesh.org

This patch creates a separate header file for logging related functions
and definitions.

Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
---
 bat_iv_ogm.c            |  1 +
 bitarray.c              |  1 +
 bridge_loop_avoidance.c |  1 +
 debugfs.c               |  1 +
 debugfs.h               |  5 +++
 distributed-arp-table.c |  1 +
 gateway_client.c        |  1 +
 gateway_common.c        |  1 +
 hard-interface.c        |  1 +
 icmp_socket.c           |  1 +
 log.h                   | 82 +++++++++++++++++++++++++++++++++++++++++++++++++
 main.c                  |  1 +
 main.h                  | 62 -------------------------------------
 network-coding.c        |  1 +
 originator.c            |  1 +
 routing.c               |  1 +
 send.c                  |  1 +
 sysfs.c                 |  1 +
 translation-table.c     |  1 +
 19 files changed, 103 insertions(+), 62 deletions(-)
 create mode 100644 log.h

diff --git a/bat_iv_ogm.c b/bat_iv_ogm.c
index 00e00e09b000..2d064a71613f 100644
--- a/bat_iv_ogm.c
+++ b/bat_iv_ogm.c
@@ -25,6 +25,7 @@
 #include "send.h"
 #include "bat_algo.h"
 #include "network-coding.h"
+#include "log.h"
 
 /**
  * enum batadv_dup_status - duplicate status
diff --git a/bitarray.c b/bitarray.c
index e3da07a64026..3fbaf540d56d 100644
--- a/bitarray.c
+++ b/bitarray.c
@@ -17,6 +17,7 @@
 
 #include "main.h"
 #include "bitarray.h"
+#include "log.h"
 
 #include <linux/bitops.h>
 
diff --git a/bridge_loop_avoidance.c b/bridge_loop_avoidance.c
index 4fc6cab7ed46..d93288377f80 100644
--- a/bridge_loop_avoidance.c
+++ b/bridge_loop_avoidance.c
@@ -22,6 +22,7 @@
 #include "bridge_loop_avoidance.h"
 #include "translation-table.h"
 #include "send.h"
+#include "log.h"
 
 #include <linux/etherdevice.h>
 #include <linux/crc16.h>
diff --git a/debugfs.c b/debugfs.c
index 026a25ce364c..3f21e855a13d 100644
--- a/debugfs.c
+++ b/debugfs.c
@@ -30,6 +30,7 @@
 #include "bridge_loop_avoidance.h"
 #include "distributed-arp-table.h"
 #include "network-coding.h"
+#include "log.h"
 
 static struct dentry *batadv_debugfs;
 
diff --git a/debugfs.h b/debugfs.h
index 5db336a6ef57..1fda474defe8 100644
--- a/debugfs.h
+++ b/debugfs.h
@@ -20,6 +20,11 @@
 
 #define BATADV_DEBUGFS_SUBDIR "batman_adv"
 
+#ifdef CONFIG_BATMAN_ADV_DEBUG
+int batadv_debug_log(struct batadv_priv *bat_priv, const char *fmt, ...)
+__printf(2, 3);
+#endif
+
 #if IS_ENABLED(CONFIG_DEBUG_FS)
 
 void batadv_debugfs_init(void);
diff --git a/distributed-arp-table.c b/distributed-arp-table.c
index aad022dd15df..e2f0677a5a01 100644
--- a/distributed-arp-table.c
+++ b/distributed-arp-table.c
@@ -28,6 +28,7 @@
 #include "send.h"
 #include "types.h"
 #include "translation-table.h"
+#include "log.h"
 
 static void batadv_dat_purge(struct work_struct *work);
 
diff --git a/gateway_client.c b/gateway_client.c
index 27649e85f3f6..d4aa578c78f9 100644
--- a/gateway_client.c
+++ b/gateway_client.c
@@ -23,6 +23,7 @@
 #include "originator.h"
 #include "translation-table.h"
 #include "routing.h"
+#include "log.h"
 #include <linux/ip.h>
 #include <linux/ipv6.h>
 #include <linux/udp.h>
diff --git a/gateway_common.c b/gateway_common.c
index 6f5e621f220a..cbef7fd97971 100644
--- a/gateway_common.c
+++ b/gateway_common.c
@@ -18,6 +18,7 @@
 #include "main.h"
 #include "gateway_common.h"
 #include "gateway_client.h"
+#include "log.h"
 
 /**
  * batadv_parse_gw_bandwidth - parse supplied string buffer to extract download
diff --git a/hard-interface.c b/hard-interface.c
index fbda6b54baff..5138f11babb4 100644
--- a/hard-interface.c
+++ b/hard-interface.c
@@ -28,6 +28,7 @@
 #include "hash.h"
 #include "bridge_loop_avoidance.h"
 #include "gateway_client.h"
+#include "log.h"
 
 #include <linux/if_arp.h>
 #include <linux/if_ether.h>
diff --git a/icmp_socket.c b/icmp_socket.c
index 161ef8f17d2e..520b2f4739d1 100644
--- a/icmp_socket.c
+++ b/icmp_socket.c
@@ -23,6 +23,7 @@
 #include "hash.h"
 #include "originator.h"
 #include "hard-interface.h"
+#include "log.h"
 
 static struct batadv_socket_client *batadv_socket_client_hash[256];
 
diff --git a/log.h b/log.h
new file mode 100644
index 000000000000..05b0b9d15883
--- /dev/null
+++ b/log.h
@@ -0,0 +1,82 @@
+/* Copyright (C) 2007-2014 B.A.T.M.A.N. contributors:
+ *
+ * Marek Lindner, Simon Wunderlich
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of version 2 of the GNU General Public
+ * License as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, see <http://www.gnu.org/licenses/>.
+ */
+
+#ifndef _NET_BATMAN_ADV_LOG_H_
+#define _NET_BATMAN_ADV_LOG_H_
+
+#include "debugfs.h"
+
+/**
+ * enum batadv_dbg_level - available log levels
+ * @BATADV_DBG_BATMAN: OGM and TQ computations related messages
+ * @BATADV_DBG_ROUTES: route added / changed / deleted
+ * @BATADV_DBG_TT: translation table messages
+ * @BATADV_DBG_BLA: bridge loop avoidance messages
+ * @BATADV_DBG_DAT: ARP snooping and DAT related messages
+ * @BATADV_DBG_NC: network coding related messages
+ * @BATADV_DBG_ALL: the union of all the above log levels
+ */
+enum batadv_dbg_level {
+	BATADV_DBG_BATMAN = BIT(0),
+	BATADV_DBG_ROUTES = BIT(1),
+	BATADV_DBG_TT	  = BIT(2),
+	BATADV_DBG_BLA    = BIT(3),
+	BATADV_DBG_DAT    = BIT(4),
+	BATADV_DBG_NC	  = BIT(5),
+	BATADV_DBG_ALL    = 63,
+};
+
+#ifdef CONFIG_BATMAN_ADV_DEBUG
+/* possibly ratelimited debug output */
+#define _batadv_dbg(type, bat_priv, ratelimited, fmt, arg...)	\
+	do {							\
+		if (atomic_read(&bat_priv->log_level) & type && \
+		    (!ratelimited || net_ratelimit()))		\
+			batadv_debug_log(bat_priv, fmt, ## arg);\
+	}							\
+	while (0)
+#else /* !CONFIG_BATMAN_ADV_DEBUG */
+__printf(4, 5)
+static inline void _batadv_dbg(int type __always_unused,
+			       struct batadv_priv *bat_priv __always_unused,
+			       int ratelimited __always_unused,
+			       const char *fmt __always_unused, ...)
+{
+}
+#endif
+
+#define batadv_dbg(type, bat_priv, arg...) \
+	_batadv_dbg(type, bat_priv, 0, ## arg)
+#define batadv_dbg_ratelimited(type, bat_priv, arg...) \
+	_batadv_dbg(type, bat_priv, 1, ## arg)
+
+#define batadv_info(net_dev, fmt, arg...)				\
+	do {								\
+		struct net_device *_netdev = (net_dev);                 \
+		struct batadv_priv *_batpriv = netdev_priv(_netdev);    \
+		batadv_dbg(BATADV_DBG_ALL, _batpriv, fmt, ## arg);	\
+		pr_info("%s: " fmt, _netdev->name, ## arg);		\
+	} while (0)
+#define batadv_err(net_dev, fmt, arg...)				\
+	do {								\
+		struct net_device *_netdev = (net_dev);                 \
+		struct batadv_priv *_batpriv = netdev_priv(_netdev);    \
+		batadv_dbg(BATADV_DBG_ALL, _batpriv, fmt, ## arg);	\
+		pr_err("%s: " fmt, _netdev->name, ## arg);		\
+	} while (0)
+
+#endif  /* _NET_BATMAN_ADV_LOG_H_ */
diff --git a/main.c b/main.c
index 3bcd847a8f9f..a9e09e852c4b 100644
--- a/main.c
+++ b/main.c
@@ -40,6 +40,7 @@
 #include "bat_algo.h"
 #include "network-coding.h"
 #include "fragmentation.h"
+#include "log.h"
 
 /* List manipulations on hardif_list have to be rtnl_lock()'ed,
  * list traversals just rcu-locked
diff --git a/main.h b/main.h
index 52cb0072bfc8..1cd4ebdbe060 100644
--- a/main.h
+++ b/main.h
@@ -214,68 +214,6 @@ int batadv_algo_select(struct batadv_priv *bat_priv, char *name);
 int batadv_algo_seq_print_text(struct seq_file *seq, void *offset);
 __be32 batadv_skb_crc32(struct sk_buff *skb, u8 *payload_ptr);
 
-/**
- * enum batadv_dbg_level - available log levels
- * @BATADV_DBG_BATMAN: OGM and TQ computations related messages
- * @BATADV_DBG_ROUTES: route added / changed / deleted
- * @BATADV_DBG_TT: translation table messages
- * @BATADV_DBG_BLA: bridge loop avoidance messages
- * @BATADV_DBG_DAT: ARP snooping and DAT related messages
- * @BATADV_DBG_NC: network coding related messages
- * @BATADV_DBG_ALL: the union of all the above log levels
- */
-enum batadv_dbg_level {
-	BATADV_DBG_BATMAN = BIT(0),
-	BATADV_DBG_ROUTES = BIT(1),
-	BATADV_DBG_TT	  = BIT(2),
-	BATADV_DBG_BLA    = BIT(3),
-	BATADV_DBG_DAT    = BIT(4),
-	BATADV_DBG_NC	  = BIT(5),
-	BATADV_DBG_ALL    = 63,
-};
-
-#ifdef CONFIG_BATMAN_ADV_DEBUG
-int batadv_debug_log(struct batadv_priv *bat_priv, const char *fmt, ...)
-__printf(2, 3);
-
-/* possibly ratelimited debug output */
-#define _batadv_dbg(type, bat_priv, ratelimited, fmt, arg...)	\
-	do {							\
-		if (atomic_read(&bat_priv->log_level) & type && \
-		    (!ratelimited || net_ratelimit()))		\
-			batadv_debug_log(bat_priv, fmt, ## arg);\
-	}							\
-	while (0)
-#else /* !CONFIG_BATMAN_ADV_DEBUG */
-__printf(4, 5)
-static inline void _batadv_dbg(int type __always_unused,
-			       struct batadv_priv *bat_priv __always_unused,
-			       int ratelimited __always_unused,
-			       const char *fmt __always_unused, ...)
-{
-}
-#endif
-
-#define batadv_dbg(type, bat_priv, arg...) \
-	_batadv_dbg(type, bat_priv, 0, ## arg)
-#define batadv_dbg_ratelimited(type, bat_priv, arg...) \
-	_batadv_dbg(type, bat_priv, 1, ## arg)
-
-#define batadv_info(net_dev, fmt, arg...)				\
-	do {								\
-		struct net_device *_netdev = (net_dev);                 \
-		struct batadv_priv *_batpriv = netdev_priv(_netdev);    \
-		batadv_dbg(BATADV_DBG_ALL, _batpriv, fmt, ## arg);	\
-		pr_info("%s: " fmt, _netdev->name, ## arg);		\
-	} while (0)
-#define batadv_err(net_dev, fmt, arg...)				\
-	do {								\
-		struct net_device *_netdev = (net_dev);                 \
-		struct batadv_priv *_batpriv = netdev_priv(_netdev);    \
-		batadv_dbg(BATADV_DBG_ALL, _batpriv, fmt, ## arg);	\
-		pr_err("%s: " fmt, _netdev->name, ## arg);		\
-	} while (0)
-
 /* returns 1 if they are the same ethernet addr
  *
  * note: can't use ether_addr_equal() as it requires aligned memory
diff --git a/network-coding.c b/network-coding.c
index 127cc4d7380a..93190fc25f76 100644
--- a/network-coding.c
+++ b/network-coding.c
@@ -24,6 +24,7 @@
 #include "originator.h"
 #include "hard-interface.h"
 #include "routing.h"
+#include "log.h"
 
 static struct lock_class_key batadv_nc_coding_hash_lock_class_key;
 static struct lock_class_key batadv_nc_decoding_hash_lock_class_key;
diff --git a/originator.c b/originator.c
index 6c2cb2da9865..3386ae54ede5 100644
--- a/originator.c
+++ b/originator.c
@@ -28,6 +28,7 @@
 #include "network-coding.h"
 #include "fragmentation.h"
 #include "multicast.h"
+#include "log.h"
 
 /* hash class keys */
 static struct lock_class_key batadv_orig_hash_lock_class_key;
diff --git a/routing.c b/routing.c
index 139d2f65728e..07205591b05f 100644
--- a/routing.c
+++ b/routing.c
@@ -27,6 +27,7 @@
 #include "distributed-arp-table.h"
 #include "network-coding.h"
 #include "fragmentation.h"
+#include "log.h"
 
 #include <linux/if_vlan.h>
 
diff --git a/send.c b/send.c
index d27161e1088d..043ee89596be 100644
--- a/send.c
+++ b/send.c
@@ -28,6 +28,7 @@
 #include "network-coding.h"
 #include "fragmentation.h"
 #include "multicast.h"
+#include "log.h"
 
 static void batadv_send_outstanding_bcast_packet(struct work_struct *work);
 
diff --git a/sysfs.c b/sysfs.c
index a63c3ebfbf53..6e39cdef1e1f 100644
--- a/sysfs.c
+++ b/sysfs.c
@@ -25,6 +25,7 @@
 #include "soft-interface.h"
 #include "gateway_common.h"
 #include "gateway_client.h"
+#include "log.h"
 
 static struct net_device *batadv_kobj_to_netdev(struct kobject *obj)
 {
diff --git a/translation-table.c b/translation-table.c
index 84e6f01b734f..be75a2ac543e 100644
--- a/translation-table.c
+++ b/translation-table.c
@@ -25,6 +25,7 @@
 #include "routing.h"
 #include "bridge_loop_avoidance.h"
 #include "multicast.h"
+#include "log.h"
 
 #include <linux/crc32c.h>
 
-- 
2.1.3

