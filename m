Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Subject: batman-adv: Drop support for Linux < 4.4
Date: Sat, 20 Jun 2020 16:13:33 +0200
Message-Id: <20200620141333.25351-1-sven@narfation.org>
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
Cc: Sven Eckelmann <sven@narfation.org>

The Linux Kernel 3.16 reached its end of life [1] after 6 years. Instead it
is recommended to use at least kernel 4.4. It is also already over 4 years
old but still maintained by the stable kernel team. All older kernels
(v3.16 - v4.3) should therefore be dropped to reduce the support overhead.

[1] https://lkml.kernel.org/r/lsq.1591898928.276150302@decadent.org.uk

Signed-off-by: Sven Eckelmann <sven@narfation.org>

diff --git a/Makefile b/Makefile
index b518db1fbfee64bd2771402a13dd4e09219665ec..afdbc03c368e5ea267c325090dc2a14f5e6a95f0 100644
--- a/Makefile
+++ b/Makefile
@@ -49,8 +49,6 @@ ifneq ($(REVISION),)
 NOSTDINC_FLAGS += -DBATADV_SOURCE_VERSION=\"$(REVISION)\"
 endif
 
-include $(PWD)/compat-sources/Makefile
-
 obj-y += net/batman-adv/
 
 export batman-adv-y
diff --git a/README.external.rst b/README.external.rst
index d8465aa836529f7a6bb277a720c0f58c64b778c3..b4d07e64fbeca95c58b4d436c8d08e0767ceba72 100644
--- a/README.external.rst
+++ b/README.external.rst
@@ -12,7 +12,7 @@ and as external module. The external  module   allows   to    get
 new    features without  upgrading  to  a  newer  kernel  version
 and to get batman-adv specific bugfixes  for  kernels  that   are
 not   supported   anymore.  It compiles  against  and should work
-with Linux 3.16  -  5.7.  Supporting  older   versions   is   not
+with  Linux 4.4  -  5.7.  Supporting  older   versions   is   not
 planned,  but it's probably easy to backport it. If you work on a
 backport, feel free to contact us.  :-)
 
diff --git a/compat-include/linux/average.h b/compat-include/linux/average.h
index 046e9cb5161ae1abefb0da933656027a361e352a..347fdeae5af0058c8ff45ccdf4871c367310b44a 100644
--- a/compat-include/linux/average.h
+++ b/compat-include/linux/average.h
@@ -10,16 +10,13 @@
 #ifndef _NET_BATMAN_ADV_COMPAT_LINUX_AVERAGE_H
 #define _NET_BATMAN_ADV_COMPAT_LINUX_AVERAGE_H
 
-#include <linux/version.h>
 #include_next <linux/average.h>
 
 #include <linux/bug.h>
 #include <linux/compiler.h>
 #include <linux/log2.h>
 
-#if LINUX_VERSION_IS_GEQ(4, 3, 0)
 #undef DECLARE_EWMA
-#endif /* LINUX_VERSION_IS_LESS(4, 3, 0) */
 
 /*
  * Exponentially weighted moving average (EWMA)
diff --git a/compat-include/linux/compiler.h b/compat-include/linux/compiler.h
index 89ed29299ba3cc4e78270d408a37a3c9f9fefa8e..43e12a788ad17a4537c35797b267c95edfd734f1 100644
--- a/compat-include/linux/compiler.h
+++ b/compat-include/linux/compiler.h
@@ -13,21 +13,6 @@
 #include <linux/version.h>
 #include_next <linux/compiler.h>
 
-#if LINUX_VERSION_IS_LESS(3, 19, 0)
-
-#ifndef READ_ONCE
-#define READ_ONCE(x) ACCESS_ONCE(x)
-#endif
-
-#ifndef WRITE_ONCE
-#define WRITE_ONCE(x, val) ({ \
-	ACCESS_ONCE(x) = (val); \
-})
-#endif
-
-#endif /* LINUX_VERSION_IS_LESS(3, 19, 0) */
-
-
 #if LINUX_VERSION_IS_LESS(5, 4, 0)
 
 #ifndef fallthrough
diff --git a/compat-include/linux/if_bridge.h b/compat-include/linux/if_bridge.h
deleted file mode 100644
index 8dfcef19c0e00f005e109e8f34b6e403536fd2a1..0000000000000000000000000000000000000000
--- a/compat-include/linux/if_bridge.h
+++ /dev/null
@@ -1,77 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/* Copyright (C) 2007-2020  B.A.T.M.A.N. contributors:
- *
- * Marek Lindner, Simon Wunderlich
- *
- * This file contains macros for maintaining compatibility with older versions
- * of the Linux kernel.
- */
-
-#ifndef _NET_BATMAN_ADV_COMPAT_LINUX_IF_BRIDGE_H_
-#define _NET_BATMAN_ADV_COMPAT_LINUX_IF_BRIDGE_H_
-
-#include <linux/version.h>
-#include_next <linux/if_bridge.h>
-
-#if LINUX_VERSION_IS_LESS(3, 16, 0)
-
-struct br_ip {
-	union {
-		__be32  ip4;
-#if IS_ENABLED(CONFIG_IPV6)
-		struct in6_addr ip6;
-#endif
-	} u;
-	__be16          proto;
-	__u16           vid;
-};
-
-struct br_ip_list {
-	struct list_head list;
-	struct br_ip addr;
-};
-
-#endif /* LINUX_VERSION_IS_LESS(3, 16, 0) */
-
-#if LINUX_VERSION_IS_LESS(3, 16, 0) || \
-    LINUX_VERSION_CODE == KERNEL_VERSION(3, 16, 0) && \
-    (!IS_ENABLED(CONFIG_BRIDGE) || \
-     !IS_ENABLED(CONFIG_BRIDGE_IGMP_SNOOPING))
-
-#define br_multicast_list_adjacent(dev, br_ip_list) \
-	batadv_br_multicast_list_adjacent(dev, br_ip_list)
-
-#define br_multicast_has_querier_adjacent(dev, proto) \
-	batadv_br_multicast_has_querier_adjacent(dev, proto)
-
-static inline int
-batadv_br_multicast_list_adjacent(struct net_device *dev,
-				  struct list_head *br_ip_list)
-{
-	return 0;
-}
-
-static inline bool
-batadv_br_multicast_has_querier_adjacent(struct net_device *dev, int proto)
-{
-	return false;
-}
-
-#endif /* LINUX_VERSION_IS_LESS(3, 16, 0) ||
-	* == KERNEL_VERSION(3, 16, 0) &&
-	* (!IS_ENABLED(CONFIG_BRIDGE) ||
-	* !IS_ENABLED(CONFIG_BRIDGE_IGMP_SNOOPING)) */
-
-#if LINUX_VERSION_IS_LESS(3, 17, 0)
-
-static inline bool br_multicast_has_querier_anywhere(struct net_device *dev,
-						     int proto)
-{
-	pr_warn_once("Old kernel detected (< 3.17) - multicast optimizations disabled\n");
-
-	return false;
-}
-
-#endif /* LINUX_VERSION_IS_LESS(3, 17, 0) */
-
-#endif	/* _NET_BATMAN_ADV_COMPAT_LINUX_IF_BRIDGE_H_ */
diff --git a/compat-include/linux/igmp.h b/compat-include/linux/igmp.h
index 9875d6d4e7392c23faf8fec73d059bbc87c57e22..cea5bfe9f5f03617608672bf6eceec4bf6a04b83 100644
--- a/compat-include/linux/igmp.h
+++ b/compat-include/linux/igmp.h
@@ -13,11 +13,7 @@
 #include <linux/version.h>
 #include_next <linux/igmp.h>
 
-#if LINUX_VERSION_IS_LESS(4, 2, 0)
-
-int ip_mc_check_igmp(struct sk_buff *skb);
-
-#elif LINUX_VERSION_IS_LESS(5, 1, 0)
+#if LINUX_VERSION_IS_LESS(5, 1, 0)
 
 static inline int batadv_ip_mc_check_igmp(struct sk_buff *skb)
 {
@@ -27,6 +23,6 @@ static inline int batadv_ip_mc_check_igmp(struct sk_buff *skb)
 #define ip_mc_check_igmp(skb) \
 	batadv_ip_mc_check_igmp(skb)
 
-#endif /* LINUX_VERSION_IS_LESS(4, 2, 0) */
+#endif /* LINUX_VERSION_IS_LESS(5, 1, 0) */
 
 #endif	/* _NET_BATMAN_ADV_COMPAT_LINUX_IGMP_H_ */
diff --git a/compat-include/linux/list.h b/compat-include/linux/list.h
deleted file mode 100644
index 1bd85d0d73d99700fd491c7f5830cfad6f976cbe..0000000000000000000000000000000000000000
--- a/compat-include/linux/list.h
+++ /dev/null
@@ -1,31 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/* Copyright (C) 2007-2020  B.A.T.M.A.N. contributors:
- *
- * Marek Lindner, Simon Wunderlich
- *
- * This file contains macros for maintaining compatibility with older versions
- * of the Linux kernel.
- */
-
-#ifndef _NET_BATMAN_ADV_COMPAT_LINUX_LIST_H_
-#define _NET_BATMAN_ADV_COMPAT_LINUX_LIST_H_
-
-#include <linux/version.h>
-#include_next <linux/list.h>
-
-#if LINUX_VERSION_IS_LESS(3, 17, 0)
-
-#define hlist_add_behind(n, prev) hlist_add_after(prev, n)
-
-#endif /* LINUX_VERSION_IS_LESS(3, 17, 0) */
-
-#if LINUX_VERSION_IS_LESS(4, 3, 0)
-
-static inline bool hlist_fake(struct hlist_node *h)
-{
-	return h->pprev == &h->next;
-}
-
-#endif /* LINUX_VERSION_IS_LESS(4, 3, 0) */
-
-#endif	/* _NET_BATMAN_ADV_COMPAT_LINUX_LIST_H_ */
diff --git a/compat-include/linux/netdevice.h b/compat-include/linux/netdevice.h
index ae7fb906833e04dcb93952c7e73f37b3584a2f54..5dd273412d60cd0b77086ee6d810784626407ec6 100644
--- a/compat-include/linux/netdevice.h
+++ b/compat-include/linux/netdevice.h
@@ -13,21 +13,6 @@
 #include <linux/version.h>
 #include_next <linux/netdevice.h>
 
-#if LINUX_VERSION_IS_LESS(3, 17, 0)
-
-/* alloc_netdev() was defined differently before 2.6.38 */
-#undef alloc_netdev
-#define alloc_netdev(sizeof_priv, name, name_assign_type, setup) \
-	alloc_netdev_mqs(sizeof_priv, name, setup, 1, 1)
-
-#endif /* LINUX_VERSION_IS_LESS(3, 17, 0) */
-
-#if LINUX_VERSION_IS_LESS(4, 1, 0)
-
-#define dev_get_iflink(_net_dev) ((_net_dev)->iflink)
-
-#endif /* LINUX_VERSION_IS_LESS(3, 19, 0) */
-
 #if LINUX_VERSION_IS_LESS(4, 5, 0)
 
 #define netdev_master_upper_dev_link(dev, upper_dev, upper_priv, upper_info, extack) \
diff --git a/compat-include/linux/nl80211.h b/compat-include/linux/nl80211.h
deleted file mode 100644
index bea92d1b73768ae2236bb67a0d554e341ad722ac..0000000000000000000000000000000000000000
--- a/compat-include/linux/nl80211.h
+++ /dev/null
@@ -1,23 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/* Copyright (C) 2007-2020  B.A.T.M.A.N. contributors:
- *
- * Marek Lindner, Simon Wunderlich
- *
- * This file contains macros for maintaining compatibility with older versions
- * of the Linux kernel.
- */
-
-#ifndef _NET_BATMAN_ADV_COMPAT_LINUX_NL80211_H_
-#define _NET_BATMAN_ADV_COMPAT_LINUX_NL80211_H_
-
-#include <linux/version.h>
-#include_next <linux/nl80211.h>
-
-#if LINUX_VERSION_IS_LESS(3, 16, 0)
-
-/* Linux 3.15 misses the uapi include.... */
-#include <uapi/linux/nl80211.h>
-
-#endif /* LINUX_VERSION_IS_LESS(3, 16, 0) */
-
-#endif	/* _NET_BATMAN_ADV_COMPAT_LINUX_NL80211_H_ */
diff --git a/compat-include/linux/seq_file.h b/compat-include/linux/seq_file.h
deleted file mode 100644
index 74854f563c7025628ef8df05258a9fbb93137c11..0000000000000000000000000000000000000000
--- a/compat-include/linux/seq_file.h
+++ /dev/null
@@ -1,25 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/* Copyright (C) 2007-2020  B.A.T.M.A.N. contributors:
- *
- * Marek Lindner, Simon Wunderlich
- *
- * This file contains macros for maintaining compatibility with older versions
- * of the Linux kernel.
- */
-
-#ifndef _NET_BATMAN_ADV_COMPAT_LINUX_SEQ_FILE_H_
-#define _NET_BATMAN_ADV_COMPAT_LINUX_SEQ_FILE_H_
-
-#include <linux/version.h>
-#include_next <linux/seq_file.h>
-
-#if LINUX_VERSION_IS_LESS(3, 19, 0)
-
-static inline bool seq_has_overflowed(struct seq_file *m)
-{
-	return m->count == m->size;
-}
-
-#endif /* LINUX_VERSION_IS_LESS(3, 19, 0) */
-
-#endif	/* _NET_BATMAN_ADV_COMPAT_LINUX_SEQ_FILE_H_ */
diff --git a/compat-include/linux/skbuff.h b/compat-include/linux/skbuff.h
index e92f3422a45c6c7bc0a2ffc4a5661bc25b160fc7..0d3631d2cf426692bbd20e0be039453acaf24c98 100644
--- a/compat-include/linux/skbuff.h
+++ b/compat-include/linux/skbuff.h
@@ -13,26 +13,6 @@
 #include <linux/version.h>
 #include_next <linux/skbuff.h>
 
-#if LINUX_VERSION_IS_LESS(3, 16, 0)
-
-#define pskb_copy_for_clone pskb_copy
-
-__sum16 skb_checksum_simple_validate(struct sk_buff *skb);
-
-__sum16
-skb_checksum_validate(struct sk_buff *skb, int proto,
-		      __wsum (*compute_pseudo)(struct sk_buff *skb, int proto));
-
-#endif /* LINUX_VERSION_IS_LESS(3, 16, 0) */
-
-#if LINUX_VERSION_IS_LESS(4, 2, 0)
-
-struct sk_buff *skb_checksum_trimmed(struct sk_buff *skb,
-				     unsigned int transport_len,
-				     __sum16(*skb_chkf)(struct sk_buff *skb));
-
-#endif /* LINUX_VERSION_IS_LESS(4, 2, 0) */
-
 #if LINUX_VERSION_IS_LESS(4, 5, 0)
 
 static inline void batadv_skb_postpush_rcsum(struct sk_buff *skb,
diff --git a/compat-include/linux/string.h b/compat-include/linux/string.h
deleted file mode 100644
index 7197803100f600dfe2dd705f597a65dd73a129f2..0000000000000000000000000000000000000000
--- a/compat-include/linux/string.h
+++ /dev/null
@@ -1,51 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/* Copyright (C) 2015  Chris Metcalf <cmetcalf@ezchip.com>
- *
- * This file contains macros for maintaining compatibility with older versions
- * of the Linux kernel.
- */
-
-#ifndef _NET_BATMAN_ADV_COMPAT_LINUX_STRING_H_
-#define _NET_BATMAN_ADV_COMPAT_LINUX_STRING_H_
-
-#include <linux/version.h>
-#include_next <linux/string.h>
-#include <asm-generic/errno-base.h>
-
-#if LINUX_VERSION_IS_LESS(4, 3, 0)
-
-#ifndef __HAVE_ARCH_STRSCPY
-
-static inline ssize_t batadv_strscpy(char *dest, const char *src, size_t count)
-{
-	long res = 0;
-
-	if (count == 0)
-		return -E2BIG;
-
-	while (count) {
-		char c;
-
-		c = src[res];
-		dest[res] = c;
-		if (!c)
-			return res;
-		res++;
-		count--;
-	}
-
-	/* Hit buffer length without finding a NUL; force NUL-termination. */
-	if (res)
-		dest[res-1] = '\0';
-
-	return -E2BIG;
-}
-
-#define strscpy(_dest, _src, _count) \
-	batadv_strscpy((_dest), (_src), (_count))
-
-#endif
-
-#endif /* LINUX_VERSION_IS_LESS(4, 3, 0) */
-
-#endif	/* _NET_BATMAN_ADV_COMPAT_LINUX_STRING_H_ */
diff --git a/compat-include/net/addrconf.h b/compat-include/net/addrconf.h
index 5430811a25e8007d2c985e6252f99fcba4ab6791..8914a66b0f30d813dfd716c94e147a185a667e7c 100644
--- a/compat-include/net/addrconf.h
+++ b/compat-include/net/addrconf.h
@@ -13,11 +13,7 @@
 #include <linux/version.h>
 #include_next <net/addrconf.h>
 
-#if LINUX_VERSION_IS_LESS(4, 2, 0)
-
-int ipv6_mc_check_mld(struct sk_buff *skb);
-
-#elif LINUX_VERSION_IS_LESS(5, 1, 0)
+#if LINUX_VERSION_IS_LESS(5, 1, 0)
 
 static inline int batadv_ipv6_mc_check_mld(struct sk_buff *skb)
 {
@@ -27,6 +23,6 @@ static inline int batadv_ipv6_mc_check_mld(struct sk_buff *skb)
 #define ipv6_mc_check_mld(skb) \
 	batadv_ipv6_mc_check_mld(skb)
 
-#endif /* LINUX_VERSION_IS_LESS(4, 2, 0) */
+#endif /* LINUX_VERSION_IS_LESS(5, 1, 0) */
 
 #endif	/* _NET_BATMAN_ADV_COMPAT_NET_ADDRCONF_H_ */
diff --git a/compat-include/net/cfg80211.h b/compat-include/net/cfg80211.h
index 241f44e060f977231f6d3e7ab07b407264dbb26c..288c1be132f64f13b7888cd72923e7813afecbf1 100644
--- a/compat-include/net/cfg80211.h
+++ b/compat-include/net/cfg80211.h
@@ -13,25 +13,6 @@
 #include <linux/version.h>
 #include_next <net/cfg80211.h>
 
-#if LINUX_VERSION_IS_LESS(3, 16, 0)
-
-static inline int cfg80211_get_station(struct net_device *dev,
-				       const u8 *mac_addr,
-				       struct station_info *sinfo)
-{
-	pr_warn_once("cfg80211 based throughput metric is only supported with Linux 3.16+\n");
-	return -ENOENT;
-}
-
-/* The following define substitutes the expected_throughput field with a random
- * one existing in the station_info struct. It can be random because due to the
- * function above it will never be used. Only needed to make the code compile
- */
-#define expected_throughput filled
-
-#endif /* LINUX_VERSION_IS_LESS(3, 16, 0) */
-
-
 #if LINUX_VERSION_IS_LESS(4, 8, 0)
 
 #if !IS_ENABLED(CONFIG_CFG80211) && \
diff --git a/compat-include/net/ip6_checksum.h b/compat-include/net/ip6_checksum.h
deleted file mode 100644
index 8997cbf9e6db9cbb3ad4b5d6f71eb0956c29f517..0000000000000000000000000000000000000000
--- a/compat-include/net/ip6_checksum.h
+++ /dev/null
@@ -1,27 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/* Copyright (C) 2007-2020  B.A.T.M.A.N. contributors:
- *
- * Marek Lindner, Simon Wunderlich
- *
- * This file contains macros for maintaining compatibility with older versions
- * of the Linux kernel.
- */
-
-#ifndef _NET_BATMAN_ADV_COMPAT_NET_IP6_CHECKSUM_H_
-#define _NET_BATMAN_ADV_COMPAT_NET_IP6_CHECKSUM_H_
-
-#include <linux/version.h>
-#include_next <net/ip6_checksum.h>
-
-#if LINUX_VERSION_IS_LESS(3, 16, 0)
-
-static inline __wsum ip6_compute_pseudo(struct sk_buff *skb, int proto)
-{
-	return ~csum_unfold(csum_ipv6_magic(&ipv6_hdr(skb)->saddr,
-					    &ipv6_hdr(skb)->daddr,
-					    skb->len, proto, 0));
-}
-
-#endif /* LINUX_VERSION_IS_LESS(3, 16, 0) */
-
-#endif	/* _NET_BATMAN_ADV_COMPAT_NET_IP6_CHECKSUM_H_ */
diff --git a/compat-include/net/netlink.h b/compat-include/net/netlink.h
deleted file mode 100644
index c7419e155daf0a31576b67e07aca28cc4fc1ad88..0000000000000000000000000000000000000000
--- a/compat-include/net/netlink.h
+++ /dev/null
@@ -1,28 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/* Copyright (C) 2007-2020  B.A.T.M.A.N. contributors:
- *
- * Marek Lindner, Simon Wunderlich
- *
- * This file contains macros for maintaining compatibility with older versions
- * of the Linux kernel.
- */
-
-#ifndef _NET_BATMAN_ADV_COMPAT_NET_NETLINK_H_
-#define _NET_BATMAN_ADV_COMPAT_NET_NETLINK_H_
-
-#include <linux/version.h>
-#include_next <net/netlink.h>
-
-#if LINUX_VERSION_IS_LESS(4, 1, 0)
-
-static inline int nla_put_in_addr(struct sk_buff *skb, int attrtype,
-				  __be32 addr)
-{
-	__be32 tmp = addr;
-
-	return nla_put_be32(skb, attrtype, tmp);
-}
-
-#endif /* LINUX_VERSION_IS_LESS(4, 1, 0) */
-
-#endif /* _NET_BATMAN_ADV_COMPAT_NET_NETLINK_H_ */
diff --git a/compat-include/uapi/linux/nl80211.h b/compat-include/uapi/linux/nl80211.h
deleted file mode 100644
index dff0dd5c6f2f43d46162d46a041f91cb3696c178..0000000000000000000000000000000000000000
--- a/compat-include/uapi/linux/nl80211.h
+++ /dev/null
@@ -1,25 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/* Copyright (C) 2007-2020  B.A.T.M.A.N. contributors:
- *
- * Marek Lindner, Simon Wunderlich
- *
- * This file contains macros for maintaining compatibility with older versions
- * of the Linux kernel.
- */
-
-#ifndef _NET_BATMAN_ADV_COMPAT_UAPI_LINUX_NL80211_H_
-#define _NET_BATMAN_ADV_COMPAT_UAPI_LINUX_NL80211_H_
-
-#include <linux/version.h>
-#include_next <uapi/linux/nl80211.h>
-
-#if LINUX_VERSION_IS_LESS(4, 0, 0)
-
-/* for batadv_v_elp_get_throughput which would have used
- * STATION_INFO_EXPECTED_THROUGHPUT in Linux 4.0.0
- */
-#define NL80211_STA_INFO_EXPECTED_THROUGHPUT    28
-
-#endif /* LINUX_VERSION_IS_LESS(4, 0, 0) */
-
-#endif	/* _NET_BATMAN_ADV_COMPAT_UAPI_LINUX_NL80211_H_ */
diff --git a/compat-sources/Makefile b/compat-sources/Makefile
deleted file mode 100644
index fd2fce8f4f3d46b197f780d519e333cd3b049556..0000000000000000000000000000000000000000
--- a/compat-sources/Makefile
+++ /dev/null
@@ -1,8 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0
-# Copyright (C) 2007-2020  B.A.T.M.A.N. contributors:
-#
-# Marek Lindner, Simon Wunderlich
-
-batman-adv-$(CONFIG_BATMAN_ADV_MCAST) += ../../compat-sources/net/core/skbuff.o
-batman-adv-$(CONFIG_BATMAN_ADV_MCAST) += ../../compat-sources/net/ipv4/igmp.o
-batman-adv-$(CONFIG_BATMAN_ADV_MCAST) += ../../compat-sources/net/ipv6/mcast_snoop.o
diff --git a/compat-sources/net/core/skbuff.c b/compat-sources/net/core/skbuff.c
deleted file mode 100644
index fd2771ae9db3dc72d420a1730633c618a631f99b..0000000000000000000000000000000000000000
--- a/compat-sources/net/core/skbuff.c
+++ /dev/null
@@ -1,195 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- *	Routines having to do with the 'struct sk_buff' memory handlers.
- *
- *	Authors:	Alan Cox <alan@lxorguk.ukuu.org.uk>
- *			Florian La Roche <rzsfl@rz.uni-sb.de>
- *
- *	Fixes:
- *		Alan Cox	:	Fixed the worst of the load
- *					balancer bugs.
- *		Dave Platt	:	Interrupt stacking fix.
- *	Richard Kooijman	:	Timestamp fixes.
- *		Alan Cox	:	Changed buffer format.
- *		Alan Cox	:	destructor hook for AF_UNIX etc.
- *		Linus Torvalds	:	Better skb_clone.
- *		Alan Cox	:	Added skb_copy.
- *		Alan Cox	:	Added all the changed routines Linus
- *					only put in the headers
- *		Ray VanTassle	:	Fixed --skb->lock in free
- *		Alan Cox	:	skb_copy copy arp field
- *		Andi Kleen	:	slabified it.
- *		Robert Olsson	:	Removed skb_head_pool
- *
- *	NOTE:
- *		The __skb_ routines should be called with interrupts
- *	disabled, or you better be *real* sure that the operation is atomic
- *	with respect to whatever list is being frobbed (e.g. via lock_sock()
- *	or via disabling bottom half handlers, etc).
- */
-
-#include <linux/in6.h>
-#include <linux/ipv6.h>
-#include <linux/skbuff.h>
-#include <linux/types.h>
-#include <net/checksum.h>
-#include <net/ip6_checksum.h>
-
-#if LINUX_VERSION_IS_LESS(3, 16, 0)
-
-/* Compare with:
- * "bridge: multicast: call skb_checksum_{simple_, }validate"
- */
-__sum16 skb_checksum_simple_validate(struct sk_buff *skb)
-{
-	switch (skb->ip_summed) {
-	case CHECKSUM_COMPLETE:
-		if (!csum_fold(skb->csum))
-			break;
-		fallthrough;
-	case CHECKSUM_NONE:
-		skb->csum = 0;
-		return skb_checksum_complete(skb);
-	}
-
-	return 0;
-}
-
-/* Watch out: Not as generic as upstream
- * - redefines this method to only fit with ICMPV6
- *
- * Compare with:
- * "bridge: multicast: call skb_checksum_{simple_, }validate"
- */
-__sum16
-skb_checksum_validate(struct sk_buff *skb, int proto,
-		      __wsum (*compute_pseudo)(struct sk_buff *skb, int proto))
-{
-	const struct ipv6hdr *ip6h = ipv6_hdr(skb);
-
-	switch (skb->ip_summed) {
-	case CHECKSUM_COMPLETE:
-		if (!csum_ipv6_magic(&ip6h->saddr, &ip6h->daddr, skb->len,
-				     IPPROTO_ICMPV6, skb->csum))
-			break;
-		fallthrough;
-	case CHECKSUM_NONE:
-		skb->csum = ~csum_unfold(csum_ipv6_magic(&ip6h->saddr,
-							 &ip6h->daddr,
-							 skb->len,
-							 IPPROTO_ICMPV6, 0));
-		return __skb_checksum_complete(skb);
-	}
-
-	return 0;
-}
-
-#endif /* LINUX_VERSION_IS_LESS(3, 16, 0) */
-
-#if LINUX_VERSION_IS_LESS(4, 2, 0)
-
-/**
- *	skb_push_rcsum - push skb and update receive checksum
- *	@skb: buffer to update
- *	@len: length of data pulled
- *
- *	This function performs an skb_push on the packet and updates
- *	the CHECKSUM_COMPLETE checksum.  It should be used on
- *	receive path processing instead of skb_push unless you know
- *	that the checksum difference is zero (e.g., a valid IP header)
- *	or you are setting ip_summed to CHECKSUM_NONE.
- */
-static unsigned char *skb_push_rcsum(struct sk_buff *skb, unsigned len)
-{
-	skb_push(skb, len);
-	skb_postpush_rcsum(skb, skb->data, len);
-	return skb->data;
-}
-
-/**
- * skb_checksum_maybe_trim - maybe trims the given skb
- * @skb: the skb to check
- * @transport_len: the data length beyond the network header
- *
- * Checks whether the given skb has data beyond the given transport length.
- * If so, returns a cloned skb trimmed to this transport length.
- * Otherwise returns the provided skb. Returns NULL in error cases
- * (e.g. transport_len exceeds skb length or out-of-memory).
- *
- * Caller needs to set the skb transport header and release the returned skb.
- * Provided skb is consumed.
- */
-static struct sk_buff *skb_checksum_maybe_trim(struct sk_buff *skb,
-					       unsigned int transport_len)
-{
-	struct sk_buff *skb_chk;
-	unsigned int len = skb_transport_offset(skb) + transport_len;
-	int ret;
-
-	if (skb->len < len) {
-		kfree_skb(skb);
-		return NULL;
-	} else if (skb->len == len) {
-		return skb;
-	}
-
-	skb_chk = skb_clone(skb, GFP_ATOMIC);
-	kfree_skb(skb);
-
-	if (!skb_chk)
-		return NULL;
-
-	ret = pskb_trim_rcsum(skb_chk, len);
-	if (ret) {
-		kfree_skb(skb_chk);
-		return NULL;
-	}
-
-	return skb_chk;
-}
-
-/**
- * skb_checksum_trimmed - validate checksum of an skb
- * @skb: the skb to check
- * @transport_len: the data length beyond the network header
- * @skb_chkf: checksum function to use
- *
- * Applies the given checksum function skb_chkf to the provided skb.
- * Returns a checked and maybe trimmed skb. Returns NULL on error.
- *
- * If the skb has data beyond the given transport length, then a
- * trimmed & cloned skb is checked and returned.
- *
- * Caller needs to set the skb transport header and release the returned skb.
- * Provided skb is consumed.
- */
-struct sk_buff *skb_checksum_trimmed(struct sk_buff *skb,
-				     unsigned int transport_len,
-				     __sum16(*skb_chkf)(struct sk_buff *skb))
-{
-	struct sk_buff *skb_chk;
-	unsigned int offset = skb_transport_offset(skb);
-	__sum16 ret;
-
-	skb_chk = skb_checksum_maybe_trim(skb, transport_len);
-	if (!skb_chk)
-		return NULL;
-
-	if (!pskb_may_pull(skb_chk, offset)) {
-		kfree_skb(skb_chk);
-		return NULL;
-	}
-
-	skb_pull_rcsum(skb_chk, offset);
-	ret = skb_chkf(skb_chk);
-	skb_push_rcsum(skb_chk, offset);
-
-	if (ret) {
-		kfree_skb(skb_chk);
-		return NULL;
-	}
-
-	return skb_chk;
-}
-
-#endif /* LINUX_VERSION_IS_LESS(4, 2, 0) */
diff --git a/compat-sources/net/ipv4/igmp.c b/compat-sources/net/ipv4/igmp.c
deleted file mode 100644
index 6c6396764b977a057ab82ba4a327cf19a2fc8744..0000000000000000000000000000000000000000
--- a/compat-sources/net/ipv4/igmp.c
+++ /dev/null
@@ -1,223 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- *	Linux NET3:	Internet Group Management Protocol  [IGMP]
- *
- *	This code implements the IGMP protocol as defined in RFC1112. There has
- *	been a further revision of this protocol since which is now supported.
- *
- *	If you have trouble with this module be careful what gcc you have used,
- *	the older version didn't come out right using gcc 2.5.8, the newer one
- *	seems to fall out with gcc 2.6.2.
- *
- *	Authors:
- *		Alan Cox <alan@lxorguk.ukuu.org.uk>
- *
- *	Fixes:
- *
- *		Alan Cox	:	Added lots of __inline__ to optimise
- *					the memory usage of all the tiny little
- *					functions.
- *		Alan Cox	:	Dumped the header building experiment.
- *		Alan Cox	:	Minor tweaks ready for multicast routing
- *					and extended IGMP protocol.
- *		Alan Cox	:	Removed a load of inline directives. Gcc 2.5.8
- *					writes utterly bogus code otherwise (sigh)
- *					fixed IGMP loopback to behave in the manner
- *					desired by mrouted, fixed the fact it has been
- *					broken since 1.3.6 and cleaned up a few minor
- *					points.
- *
- *		Chih-Jen Chang	:	Tried to revise IGMP to Version 2
- *		Tsu-Sheng Tsao		E-mail: chihjenc@scf.usc.edu and tsusheng@scf.usc.edu
- *					The enhancements are mainly based on Steve Deering's
- * 					ipmulti-3.5 source code.
- *		Chih-Jen Chang	:	Added the igmp_get_mrouter_info and
- *		Tsu-Sheng Tsao		igmp_set_mrouter_info to keep track of
- *					the mrouted version on that device.
- *		Chih-Jen Chang	:	Added the max_resp_time parameter to
- *		Tsu-Sheng Tsao		igmp_heard_query(). Using this parameter
- *					to identify the multicast router version
- *					and do what the IGMP version 2 specified.
- *		Chih-Jen Chang	:	Added a timer to revert to IGMP V2 router
- *		Tsu-Sheng Tsao		if the specified time expired.
- *		Alan Cox	:	Stop IGMP from 0.0.0.0 being accepted.
- *		Alan Cox	:	Use GFP_ATOMIC in the right places.
- *		Christian Daudt :	igmp timer wasn't set for local group
- *					memberships but was being deleted,
- *					which caused a "del_timer() called
- *					from %p with timer not initialized\n"
- *					message (960131).
- *		Christian Daudt :	removed del_timer from
- *					igmp_timer_expire function (960205).
- *             Christian Daudt :       igmp_heard_report now only calls
- *                                     igmp_timer_expire if tm->running is
- *                                     true (960216).
- *		Malcolm Beattie :	ttl comparison wrong in igmp_rcv made
- *					igmp_heard_query never trigger. Expiry
- *					miscalculation fixed in igmp_heard_query
- *					and random() made to return unsigned to
- *					prevent negative expiry times.
- *		Alexey Kuznetsov:	Wrong group leaving behaviour, backport
- *					fix from pending 2.1.x patches.
- *		Alan Cox:		Forget to enable FDDI support earlier.
- *		Alexey Kuznetsov:	Fixed leaving groups on device down.
- *		Alexey Kuznetsov:	Accordance to igmp-v2-06 draft.
- *		David L Stevens:	IGMPv3 support, with help from
- *					Vinay Kulkarni
- */
-
-#include <linux/igmp.h>
-#include <linux/ip.h>
-#include <linux/skbuff.h>
-#include <net/ip.h>
-
-#if LINUX_VERSION_IS_LESS(4, 2, 0)
-
-static int ip_mc_check_iphdr(struct sk_buff *skb)
-{
-	const struct iphdr *iph;
-	unsigned int len;
-	unsigned int offset = skb_network_offset(skb) + sizeof(*iph);
-
-	if (!pskb_may_pull(skb, offset))
-		return -EINVAL;
-
-	iph = ip_hdr(skb);
-
-	if (iph->version != 4 || ip_hdrlen(skb) < sizeof(*iph))
-		return -EINVAL;
-
-	offset += ip_hdrlen(skb) - sizeof(*iph);
-
-	if (!pskb_may_pull(skb, offset))
-		return -EINVAL;
-
-	iph = ip_hdr(skb);
-
-	if (unlikely(ip_fast_csum((u8 *)iph, iph->ihl)))
-		return -EINVAL;
-
-	len = skb_network_offset(skb) + ntohs(iph->tot_len);
-	if (skb->len < len || len < offset)
-		return -EINVAL;
-
-	skb_set_transport_header(skb, offset);
-
-	return 0;
-}
-
-static int ip_mc_check_igmp_reportv3(struct sk_buff *skb)
-{
-	unsigned int len = skb_transport_offset(skb);
-
-	len += sizeof(struct igmpv3_report);
-
-	return pskb_may_pull(skb, len) ? 0 : -EINVAL;
-}
-
-static int ip_mc_check_igmp_query(struct sk_buff *skb)
-{
-	unsigned int len = skb_transport_offset(skb);
-
-	len += sizeof(struct igmphdr);
-	if (skb->len < len)
-		return -EINVAL;
-
-	/* IGMPv{1,2}? */
-	if (skb->len != len) {
-		/* or IGMPv3? */
-		len += sizeof(struct igmpv3_query) - sizeof(struct igmphdr);
-		if (skb->len < len || !pskb_may_pull(skb, len))
-			return -EINVAL;
-	}
-
-	/* RFC2236+RFC3376 (IGMPv2+IGMPv3) require the multicast link layer
-	 * all-systems destination addresses (224.0.0.1) for general queries
-	 */
-	if (!igmp_hdr(skb)->group &&
-	    ip_hdr(skb)->daddr != htonl(INADDR_ALLHOSTS_GROUP))
-		return -EINVAL;
-
-	return 0;
-}
-
-static int ip_mc_check_igmp_msg(struct sk_buff *skb)
-{
-	switch (igmp_hdr(skb)->type) {
-	case IGMP_HOST_LEAVE_MESSAGE:
-	case IGMP_HOST_MEMBERSHIP_REPORT:
-	case IGMPV2_HOST_MEMBERSHIP_REPORT:
-		/* fall through */
-		return 0;
-	case IGMPV3_HOST_MEMBERSHIP_REPORT:
-		return ip_mc_check_igmp_reportv3(skb);
-	case IGMP_HOST_MEMBERSHIP_QUERY:
-		return ip_mc_check_igmp_query(skb);
-	default:
-		return -ENOMSG;
-	}
-}
-
-static inline __sum16 ip_mc_validate_checksum(struct sk_buff *skb)
-{
-	return skb_checksum_simple_validate(skb);
-}
-
-static int __ip_mc_check_igmp(struct sk_buff *skb)
-
-{
-	struct sk_buff *skb_chk;
-	unsigned int transport_len;
-	unsigned int len = skb_transport_offset(skb) + sizeof(struct igmphdr);
-	int ret;
-
-	transport_len = ntohs(ip_hdr(skb)->tot_len) - ip_hdrlen(skb);
-
-	skb_get(skb);
-	skb_chk = skb_checksum_trimmed(skb, transport_len,
-				       ip_mc_validate_checksum);
-	if (!skb_chk)
-		return -EINVAL;
-
-	if (!pskb_may_pull(skb_chk, len)) {
-		kfree_skb(skb_chk);
-		return -EINVAL;
-	}
-
-	ret = ip_mc_check_igmp_msg(skb_chk);
-	if (ret) {
-		kfree_skb(skb_chk);
-		return ret;
-	}
-
-	kfree_skb(skb_chk);
-
-	return 0;
-}
-
-/**
- * ip_mc_check_igmp - checks whether this is a sane IGMP packet
- * @skb: the skb to validate
- *
- * Checks whether an IPv4 packet is a valid IGMP packet. If so sets
- * skb network and transport headers accordingly and returns zero.
- *
- * -EINVAL: A broken packet was detected, i.e. it violates some internet
- *  standard
- * -ENOMSG: IP header validation succeeded but it is not an IGMP packet.
- * -ENOMEM: A memory allocation failure happened.
- */
-int ip_mc_check_igmp(struct sk_buff *skb)
-{
-	int ret = ip_mc_check_iphdr(skb);
-
-	if (ret < 0)
-		return ret;
-
-	if (ip_hdr(skb)->protocol != IPPROTO_IGMP)
-		return -ENOMSG;
-
-	return __ip_mc_check_igmp(skb);
-}
-
-#endif /* LINUX_VERSION_IS_LESS(4, 2, 0) */
diff --git a/compat-sources/net/ipv6/mcast_snoop.c b/compat-sources/net/ipv6/mcast_snoop.c
deleted file mode 100644
index 651b8e3bc4893e63de0e1e64d8d8561dae73d7e8..0000000000000000000000000000000000000000
--- a/compat-sources/net/ipv6/mcast_snoop.c
+++ /dev/null
@@ -1,189 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/* Copyright (C) 2010: YOSHIFUJI Hideaki <yoshfuji@linux-ipv6.org>
- * Copyright (C) 2015: Linus Lüssing <linus.luessing@c0d3.blue>
- *
- * Based on the MLD support added to br_multicast.c by YOSHIFUJI Hideaki.
- */
-
-#include <linux/skbuff.h>
-#include <net/ipv6.h>
-#include <net/mld.h>
-#include <net/addrconf.h>
-#include <net/ip6_checksum.h>
-
-#if LINUX_VERSION_IS_LESS(4, 2, 0)
-
-static int ipv6_mc_check_ip6hdr(struct sk_buff *skb)
-{
-	const struct ipv6hdr *ip6h;
-	unsigned int len;
-	unsigned int offset = skb_network_offset(skb) + sizeof(*ip6h);
-
-	if (!pskb_may_pull(skb, offset))
-		return -EINVAL;
-
-	ip6h = ipv6_hdr(skb);
-
-	if (ip6h->version != 6)
-		return -EINVAL;
-
-	len = offset + ntohs(ip6h->payload_len);
-	if (skb->len < len || len <= offset)
-		return -EINVAL;
-
-	return 0;
-}
-
-static int ipv6_mc_check_exthdrs(struct sk_buff *skb)
-{
-	const struct ipv6hdr *ip6h;
-	int offset;
-	u8 nexthdr;
-	__be16 frag_off;
-
-	ip6h = ipv6_hdr(skb);
-
-	if (ip6h->nexthdr != IPPROTO_HOPOPTS)
-		return -ENOMSG;
-
-	nexthdr = ip6h->nexthdr;
-	offset = skb_network_offset(skb) + sizeof(*ip6h);
-	offset = ipv6_skip_exthdr(skb, offset, &nexthdr, &frag_off);
-
-	if (offset < 0)
-		return -EINVAL;
-
-	if (nexthdr != IPPROTO_ICMPV6)
-		return -ENOMSG;
-
-	skb_set_transport_header(skb, offset);
-
-	return 0;
-}
-
-static int ipv6_mc_check_mld_reportv2(struct sk_buff *skb)
-{
-	unsigned int len = skb_transport_offset(skb);
-
-	len += sizeof(struct mld2_report);
-
-	return pskb_may_pull(skb, len) ? 0 : -EINVAL;
-}
-
-static int ipv6_mc_check_mld_query(struct sk_buff *skb)
-{
-	struct mld_msg *mld;
-	unsigned int len = skb_transport_offset(skb);
-
-	/* RFC2710+RFC3810 (MLDv1+MLDv2) require link-local source addresses */
-	if (!(ipv6_addr_type(&ipv6_hdr(skb)->saddr) & IPV6_ADDR_LINKLOCAL))
-		return -EINVAL;
-
-	len += sizeof(struct mld_msg);
-	if (skb->len < len)
-		return -EINVAL;
-
-	/* MLDv1? */
-	if (skb->len != len) {
-		/* or MLDv2? */
-		len += sizeof(struct mld2_query) - sizeof(struct mld_msg);
-		if (skb->len < len || !pskb_may_pull(skb, len))
-			return -EINVAL;
-	}
-
-	mld = (struct mld_msg *)skb_transport_header(skb);
-
-	/* RFC2710+RFC3810 (MLDv1+MLDv2) require the multicast link layer
-	 * all-nodes destination address (ff02::1) for general queries
-	 */
-	if (ipv6_addr_any(&mld->mld_mca) &&
-	    !ipv6_addr_is_ll_all_nodes(&ipv6_hdr(skb)->daddr))
-		return -EINVAL;
-
-	return 0;
-}
-
-static int ipv6_mc_check_mld_msg(struct sk_buff *skb)
-{
-	struct mld_msg *mld = (struct mld_msg *)skb_transport_header(skb);
-
-	switch (mld->mld_type) {
-	case ICMPV6_MGM_REDUCTION:
-	case ICMPV6_MGM_REPORT:
-		/* fall through */
-		return 0;
-	case ICMPV6_MLD2_REPORT:
-		return ipv6_mc_check_mld_reportv2(skb);
-	case ICMPV6_MGM_QUERY:
-		return ipv6_mc_check_mld_query(skb);
-	default:
-		return -ENOMSG;
-	}
-}
-
-static inline __sum16 ipv6_mc_validate_checksum(struct sk_buff *skb)
-{
-	return skb_checksum_validate(skb, IPPROTO_ICMPV6, ip6_compute_pseudo);
-}
-
-static int __ipv6_mc_check_mld(struct sk_buff *skb)
-
-{
-	struct sk_buff *skb_chk = NULL;
-	unsigned int transport_len;
-	unsigned int len = skb_transport_offset(skb) + sizeof(struct mld_msg);
-	int ret;
-
-	transport_len = ntohs(ipv6_hdr(skb)->payload_len);
-	transport_len -= skb_transport_offset(skb) - sizeof(struct ipv6hdr);
-
-	skb_get(skb);
-	skb_chk = skb_checksum_trimmed(skb, transport_len,
-				       ipv6_mc_validate_checksum);
-	if (!skb_chk)
-		return -EINVAL;
-
-	if (!pskb_may_pull(skb_chk, len)) {
-		kfree_skb(skb_chk);
-		return -EINVAL;
-	}
-
-	ret = ipv6_mc_check_mld_msg(skb_chk);
-	if (ret) {
-		kfree_skb(skb_chk);
-		return ret;
-	}
-
-	kfree_skb(skb_chk);
-
-	return 0;
-}
-
-/**
- * ipv6_mc_check_mld - checks whether this is a sane MLD packet
- * @skb: the skb to validate
- *
- * Checks whether an IPv6 packet is a valid MLD packet. If so sets
- * skb network and transport headers accordingly and returns zero.
- *
- * -EINVAL: A broken packet was detected, i.e. it violates some internet
- *  standard
- * -ENOMSG: IP header validation succeeded but it is not an MLD packet.
- * -ENOMEM: A memory allocation failure happened.
- */
-int ipv6_mc_check_mld(struct sk_buff *skb)
-{
-	int ret;
-
-	ret = ipv6_mc_check_ip6hdr(skb);
-	if (ret < 0)
-		return ret;
-
-	ret = ipv6_mc_check_exthdrs(skb);
-	if (ret < 0)
-		return ret;
-
-	return __ipv6_mc_check_mld(skb);
-}
-
-#endif /* LINUX_VERSION_IS_LESS(4, 2, 0) */
diff --git a/compat.h b/compat.h
index 21bacc5d3b6d029560c66c67decb7b00c3ddc2aa..e3220e396411d2cb97ca432599a1bf5933da463a 100644
--- a/compat.h
+++ b/compat.h
@@ -15,19 +15,6 @@
 
 #include "compat-autoconf.h"
 
-#if LINUX_VERSION_IS_LESS(4, 0, 0)
-
-/* wild hack for batadv_getlink_net only */
-#define get_link_net get_xstats_size || 1 ? fallback_net : (struct net*)netdev->rtnl_link_ops->get_xstats_size
-
-#endif /* LINUX_VERSION_IS_LESS(4, 0, 0) */
-
-#if LINUX_VERSION_IS_LESS(4, 3, 0)
-
-#define IFF_NO_QUEUE	0; dev->tx_queue_len = 0
-
-#endif /* LINUX_VERSION_IS_LESS(4, 3, 0) */
-
 #if LINUX_VERSION_IS_LESS(4, 15, 0)
 
 #define batadv_softif_slave_add(__dev, __slave_dev, __extack) \
