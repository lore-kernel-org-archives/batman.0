Return-Path: <linus.luessing@c0d3.blue>
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@c0d3.blue>
Subject: [PATCH v2] net: bridge: mcast: rename br_ip's u member to dst
Date: Mon, 28 Sep 2020 18:15:43 +0200
Message-Id: <20200928161543.28331-1-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
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
Cc: Nikolay Aleksandrov <nikolay@nvidia.com>, Marek Lindner <mareklindner@neomailbox.ch>, Simon Wunderlich <sw@simonwunderlich.de>, Antonio Quartulli <a@unstable.cc>, Sven Eckelmann <sven@narfation.org>, =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@c0d3.blue>

From: Nikolay Aleksandrov <nikolay@nvidia.com>

Since now we have src in br_ip, u no longer makes sense so rename
it to dst. No functional changes.

v2: fix build with CONFIG_BATMAN_ADV_MCAST

CC: Marek Lindner <mareklindner@neomailbox.ch>
CC: Simon Wunderlich <sw@simonwunderlich.de>
CC: Antonio Quartulli <a@unstable.cc>
CC: Sven Eckelmann <sven@narfation.org>
CC: b.a.t.m.a.n@lists.open-mesh.org
Signed-off-by: Nikolay Aleksandrov <nikolay@nvidia.com>
[linus.luessing@c0d3.blue: Add compat code]
Signed-off-by: Linus Lüssing <linus.luessing@c0d3.blue>
---
Compat v2:
* added BUILD_BUG_ON size+offset checks as suggested by Sven (thanks!)

 compat-include/linux/if_bridge.h | 56 ++++++++++++++++++++++++++++++++
 net/batman-adv/multicast.c       | 14 ++++----
 2 files changed, 63 insertions(+), 7 deletions(-)
 create mode 100644 compat-include/linux/if_bridge.h

diff --git a/compat-include/linux/if_bridge.h b/compat-include/linux/if_bridge.h
new file mode 100644
index 00000000..45585003
--- /dev/null
+++ b/compat-include/linux/if_bridge.h
@@ -0,0 +1,56 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (C) 2007-2020  B.A.T.M.A.N. contributors:
+ *
+ * Marek Lindner, Simon Wunderlich
+ *
+ * This file contains macros for maintaining compatibility with older versions
+ * of the Linux kernel.
+ */
+
+#ifndef _NET_BATMAN_ADV_COMPAT_LINUX_IF_BRIDGE_H_
+#define _NET_BATMAN_ADV_COMPAT_LINUX_IF_BRIDGE_H_
+
+#include <linux/version.h>
+#include_next <linux/if_bridge.h>
+
+#if LINUX_VERSION_IS_LESS(5, 10, 0)
+
+struct batadv_br_ip {
+	union {
+		__be32  ip4;
+#if IS_ENABLED(CONFIG_IPV6)
+		struct in6_addr ip6;
+#endif
+	} dst;
+	__be16          proto;
+	__u16           vid;
+};
+
+struct batadv_br_ip_list {
+	struct list_head list;
+	struct batadv_br_ip addr;
+};
+
+/* "static" dropped to force compiler to evaluate it as part of multicast.c
+ * might need to be added again and then called in some kind of dummy
+ * compat.c in case this header is included in multiple files.
+ */
+inline void __batadv_br_ip_list_check(void)
+{
+	BUILD_BUG_ON(sizeof(struct batadv_br_ip_list) != sizeof(struct br_ip_list));
+	BUILD_BUG_ON(offsetof(struct batadv_br_ip_list, list) != offsetof(struct br_ip_list, list));
+	BUILD_BUG_ON(offsetof(struct batadv_br_ip_list, addr) != offsetof(struct br_ip_list, addr));
+
+	BUILD_BUG_ON(sizeof(struct batadv_br_ip) != sizeof(struct br_ip));
+	BUILD_BUG_ON(offsetof(struct batadv_br_ip, dst.ip4) != offsetof(struct br_ip, u.ip4));
+	BUILD_BUG_ON(offsetof(struct batadv_br_ip, dst.ip6) != offsetof(struct br_ip, u.ip6));
+	BUILD_BUG_ON(offsetof(struct batadv_br_ip, proto) != offsetof(struct br_ip, proto));
+	BUILD_BUG_ON(offsetof(struct batadv_br_ip, vid) != offsetof(struct br_ip, vid));
+}
+
+#define br_ip batadv_br_ip
+#define br_ip_list batadv_br_ip_list
+
+#endif /* LINUX_VERSION_IS_LESS(5, 10, 0) */
+
+#endif /* _NET_BATMAN_ADV_COMPAT_LINUX_IF_BRIDGE_H_ */
diff --git a/net/batman-adv/multicast.c b/net/batman-adv/multicast.c
index 0746fe2c..9af99c39 100644
--- a/net/batman-adv/multicast.c
+++ b/net/batman-adv/multicast.c
@@ -221,7 +221,7 @@ static u8 batadv_mcast_mla_rtr_flags_bridge_get(struct batadv_priv *bat_priv,
 		 * address here, only IPv6 ones
 		 */
 		if (br_ip_entry->addr.proto == htons(ETH_P_IPV6) &&
-		    ipv6_addr_is_ll_all_routers(&br_ip_entry->addr.u.ip6))
+		    ipv6_addr_is_ll_all_routers(&br_ip_entry->addr.dst.ip6))
 			flags &= ~BATADV_MCAST_WANT_NO_RTR6;
 
 		list_del(&br_ip_entry->list);
@@ -562,10 +562,10 @@ batadv_mcast_mla_softif_get(struct net_device *dev,
 static void batadv_mcast_mla_br_addr_cpy(char *dst, const struct br_ip *src)
 {
 	if (src->proto == htons(ETH_P_IP))
-		ip_eth_mc_map(src->u.ip4, dst);
+		ip_eth_mc_map(src->dst.ip4, dst);
 #if IS_ENABLED(CONFIG_IPV6)
 	else if (src->proto == htons(ETH_P_IPV6))
-		ipv6_eth_mc_map(&src->u.ip6, dst);
+		ipv6_eth_mc_map(&src->dst.ip6, dst);
 #endif
 	else
 		eth_zero_addr(dst);
@@ -609,11 +609,11 @@ static int batadv_mcast_mla_bridge_get(struct net_device *dev,
 				continue;
 
 			if (tvlv_flags & BATADV_MCAST_WANT_ALL_UNSNOOPABLES &&
-			    ipv4_is_local_multicast(br_ip_entry->addr.u.ip4))
+			    ipv4_is_local_multicast(br_ip_entry->addr.dst.ip4))
 				continue;
 
 			if (!(tvlv_flags & BATADV_MCAST_WANT_NO_RTR4) &&
-			    !ipv4_is_local_multicast(br_ip_entry->addr.u.ip4))
+			    !ipv4_is_local_multicast(br_ip_entry->addr.dst.ip4))
 				continue;
 		}
 
@@ -623,11 +623,11 @@ static int batadv_mcast_mla_bridge_get(struct net_device *dev,
 				continue;
 
 			if (tvlv_flags & BATADV_MCAST_WANT_ALL_UNSNOOPABLES &&
-			    ipv6_addr_is_ll_all_nodes(&br_ip_entry->addr.u.ip6))
+			    ipv6_addr_is_ll_all_nodes(&br_ip_entry->addr.dst.ip6))
 				continue;
 
 			if (!(tvlv_flags & BATADV_MCAST_WANT_NO_RTR6) &&
-			    IPV6_ADDR_MC_SCOPE(&br_ip_entry->addr.u.ip6) >
+			    IPV6_ADDR_MC_SCOPE(&br_ip_entry->addr.dst.ip6) >
 			    IPV6_ADDR_SCOPE_LINKLOCAL)
 				continue;
 		}
-- 
2.28.0

