Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Subject: [RFC PATCH] batman-adv: Drop support for Linux < 4.9
Date: Fri, 21 Jan 2022 16:53:28 +0100
Message-Id: <20220121155328.22117-1-sven@narfation.org>
MIME-Version: 1.0
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

The Linux Kernel 4.4 reached its end of life [1] after 6 years. Instead it
is recommended to use at least kernel 4.9. It is also over 5 years
old but still maintained by the stable kernel team. All older kernels
(4.4 - v4.8) will be dropped to reduce the support overhead.

[1] TODO

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 README.external.rst                   |   2 +-
 compat-include/linux/cache.h          |  22 ------
 compat-include/linux/ethtool.h        |  51 -------------
 compat-include/linux/netdevice.h      |  17 +----
 compat-include/linux/netlink.h        | 102 --------------------------
 compat-include/linux/prandom.h        |   1 -
 compat-include/linux/skbuff.h         |  15 ----
 compat-include/net/cfg80211.h         |  18 -----
 compat-include/uapi/linux/genetlink.h |  22 ------
 9 files changed, 2 insertions(+), 248 deletions(-)
 delete mode 100644 compat-include/linux/cache.h
 delete mode 100644 compat-include/linux/ethtool.h
 delete mode 100644 compat-include/linux/netlink.h
 delete mode 100644 compat-include/uapi/linux/genetlink.h

diff --git a/README.external.rst b/README.external.rst
index 217abdd4..95991d0e 100644
--- a/README.external.rst
+++ b/README.external.rst
@@ -12,7 +12,7 @@ and as an external module. The external  module   allows  to  get
 new    features without  upgrading  to  a  newer  kernel  version
 and to get batman-adv specific bug fixes for  kernels  that   are
 not   supported   anymore.  It compiles  against  and should work
-with  Linux 4.4  -  5.16. Supporting  older   versions   is   not
+with  Linux 4.9  -  5.16. Supporting  older   versions   is   not
 planned,  but it's probably easy to backport it. If you work on a
 backport, feel free to contact us.  :-)
 
diff --git a/compat-include/linux/cache.h b/compat-include/linux/cache.h
deleted file mode 100644
index 9d7efab5..00000000
--- a/compat-include/linux/cache.h
+++ /dev/null
@@ -1,22 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/* Copyright (C) B.A.T.M.A.N. contributors:
- *
- * Marek Lindner, Simon Wunderlich
- *
- * This file contains macros for maintaining compatibility with older versions
- * of the Linux kernel.
- */
-
-#ifndef _NET_BATMAN_ADV_COMPAT_LINUX_CACHE_H
-#define _NET_BATMAN_ADV_COMPAT_LINUX_CACHE_H
-
-#include <linux/version.h>
-#include_next <linux/cache.h>
-
-#if LINUX_VERSION_IS_LESS(4, 6, 0)
-
-#define __ro_after_init
-
-#endif /* LINUX_VERSION_IS_LESS(4, 6, 0) */
-
-#endif /* _NET_BATMAN_ADV_COMPAT_LINUX_CACHE_H */
diff --git a/compat-include/linux/ethtool.h b/compat-include/linux/ethtool.h
deleted file mode 100644
index 0a69fc16..00000000
--- a/compat-include/linux/ethtool.h
+++ /dev/null
@@ -1,51 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/* Copyright (C) B.A.T.M.A.N. contributors:
- *
- * Antonio Quartulli
- *
- * This file contains macros for maintaining compatibility with older versions
- * of the Linux kernel.
- */
-
-#ifndef _NET_BATMAN_ADV_COMPAT_LINUX_ETHTOOL_H_
-#define _NET_BATMAN_ADV_COMPAT_LINUX_ETHTOOL_H_
-
-#include <linux/version.h>
-#include_next <linux/ethtool.h>
-
-#if LINUX_VERSION_IS_LESS(4, 6, 0)
-
-#define ethtool_link_ksettings batadv_ethtool_link_ksettings
-
-struct batadv_ethtool_link_ksettings {
-	struct {
-		__u32	speed;
-		__u8	duplex;
-	} base;
-};
-
-#define __ethtool_get_link_ksettings(__dev, __link_settings) \
-	batadv_ethtool_get_link_ksettings(__dev, __link_settings)
-
-static inline int
-batadv_ethtool_get_link_ksettings(struct net_device *dev,
-				  struct ethtool_link_ksettings *link_ksettings)
-{
-	struct ethtool_cmd cmd;
-	int ret;
-
-	memset(&cmd, 0, sizeof(cmd));
-	ret = __ethtool_get_settings(dev, &cmd);
-
-	if (ret != 0)
-		return ret;
-
-	link_ksettings->base.duplex = cmd.duplex;
-	link_ksettings->base.speed = ethtool_cmd_speed(&cmd);
-
-	return 0;
-}
-
-#endif /* LINUX_VERSION_IS_LESS(4, 6, 0) */
-
-#endif	/* _NET_BATMAN_ADV_COMPAT_LINUX_ETHTOOL_H_ */
diff --git a/compat-include/linux/netdevice.h b/compat-include/linux/netdevice.h
index 9a62afcc..6ee0d21c 100644
--- a/compat-include/linux/netdevice.h
+++ b/compat-include/linux/netdevice.h
@@ -13,28 +13,13 @@
 #include <linux/version.h>
 #include_next <linux/netdevice.h>
 
-#if LINUX_VERSION_IS_LESS(4, 5, 0)
-
-#define netdev_master_upper_dev_link(dev, upper_dev, upper_priv, upper_info, extack) \
-	netdev_master_upper_dev_link(dev, upper_dev)
-
-#elif LINUX_VERSION_IS_LESS(4, 15, 0)
+#if LINUX_VERSION_IS_LESS(4, 15, 0)
 
 #define netdev_master_upper_dev_link(dev, upper_dev, upper_priv, upper_info, extack) \
 	netdev_master_upper_dev_link(dev, upper_dev, upper_priv, upper_info)
 
 #endif /* LINUX_VERSION_IS_LESS(4, 15, 0) */
 
-#if LINUX_VERSION_IS_LESS(4, 7, 0)
-
-#define netif_trans_update batadv_netif_trans_update
-static inline void batadv_netif_trans_update(struct net_device *dev)
-{
-	dev->trans_start = jiffies;
-}
-
-#endif /* LINUX_VERSION_IS_LESS(4, 7, 0) */
-
 #if LINUX_VERSION_IS_LESS(4, 11, 9)
 
 /* work around missing attribute needs_free_netdev and priv_destructor in
diff --git a/compat-include/linux/netlink.h b/compat-include/linux/netlink.h
deleted file mode 100644
index ef6a0358..00000000
--- a/compat-include/linux/netlink.h
+++ /dev/null
@@ -1,102 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/* Copyright (C) B.A.T.M.A.N. contributors:
- *
- * Marek Lindner, Simon Wunderlich
- *
- * This file contains macros for maintaining compatibility with older versions
- * of the Linux kernel.
- */
-
-#ifndef _NET_BATMAN_ADV_COMPAT_LINUX_NETLINK_H_
-#define _NET_BATMAN_ADV_COMPAT_LINUX_NETLINK_H_
-
-#include <linux/version.h>
-#include_next <linux/netlink.h>
-
-#if LINUX_VERSION_IS_LESS(4, 7, 0)
-
-#include_next <net/netlink.h>
-
-static inline bool batadv_nla_need_padding_for_64bit(struct sk_buff *skb);
-
-static inline int batadv_nla_align_64bit(struct sk_buff *skb, int padattr)
-{
-	if (batadv_nla_need_padding_for_64bit(skb) &&
-	    !nla_reserve(skb, padattr, 0))
-		return -EMSGSIZE;
-
-	return 0;
-}
-
-static inline struct nlattr *batadv__nla_reserve_64bit(struct sk_buff *skb,
-						       int attrtype,
-						       int attrlen, int padattr)
-{
-	if (batadv_nla_need_padding_for_64bit(skb))
-		batadv_nla_align_64bit(skb, padattr);
-
-	return __nla_reserve(skb, attrtype, attrlen);
-}
-
-static inline void batadv__nla_put_64bit(struct sk_buff *skb, int attrtype,
-					 int attrlen, const void *data,
-					 int padattr)
-{
-	struct nlattr *nla;
-
-	nla = batadv__nla_reserve_64bit(skb, attrtype, attrlen, padattr);
-	memcpy(nla_data(nla), data, attrlen);
-}
-
-static inline bool batadv_nla_need_padding_for_64bit(struct sk_buff *skb)
-{
-#ifndef CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS
-	/* The nlattr header is 4 bytes in size, that's why we test
-	 * if the skb->data _is_ aligned.  A NOP attribute, plus
-	 * nlattr header for next attribute, will make nla_data()
-	 * 8-byte aligned.
-	 */
-	if (IS_ALIGNED((unsigned long)skb_tail_pointer(skb), 8))
-		return true;
-#endif
-	return false;
-}
-
-static inline int batadv_nla_total_size_64bit(int payload)
-{
-	return NLA_ALIGN(nla_attr_size(payload))
-#ifndef CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS
-		+ NLA_ALIGN(nla_attr_size(0))
-#endif
-		;
-}
-
-static inline int batadv_nla_put_64bit(struct sk_buff *skb, int attrtype,
-				       int attrlen, const void *data,
-				       int padattr)
-{
-	size_t len;
-
-	if (batadv_nla_need_padding_for_64bit(skb))
-		len = batadv_nla_total_size_64bit(attrlen);
-	else
-		len = nla_total_size(attrlen);
-	if (unlikely(skb_tailroom(skb) < len))
-		return -EMSGSIZE;
-
-	batadv__nla_put_64bit(skb, attrtype, attrlen, data, padattr);
-	return 0;
-}
-
-#define nla_put_u64_64bit(_skb, _attrtype, _value, _padattr) \
-	batadv_nla_put_u64_64bit(_skb, _attrtype, _value, _padattr)
-static inline int batadv_nla_put_u64_64bit(struct sk_buff *skb, int attrtype,
-					   u64 value, int padattr)
-{
-	return batadv_nla_put_64bit(skb, attrtype, sizeof(u64), &value,
-				    padattr);
-}
-
-#endif /* LINUX_VERSION_IS_LESS(4, 7, 0) */
-
-#endif	/* _NET_BATMAN_ADV_COMPAT_LINUX_NETLINK_H_ */
diff --git a/compat-include/linux/prandom.h b/compat-include/linux/prandom.h
index 7dd51ac7..dc227e61 100644
--- a/compat-include/linux/prandom.h
+++ b/compat-include/linux/prandom.h
@@ -12,7 +12,6 @@
 
 #include <linux/version.h>
 #if LINUX_VERSION_IS_GEQ(5, 8, 1) || \
-    (LINUX_VERSION_IS_GEQ(4, 4, 233) && LINUX_VERSION_IS_LESS(4, 5, 0)) || \
     (LINUX_VERSION_IS_GEQ(4, 9, 233) && LINUX_VERSION_IS_LESS(4, 10, 0)) || \
     (LINUX_VERSION_IS_GEQ(4, 14, 193) && LINUX_VERSION_IS_LESS(4, 15, 0)) || \
     (LINUX_VERSION_IS_GEQ(4, 19, 138) && LINUX_VERSION_IS_LESS(4, 20, 0)) || \
diff --git a/compat-include/linux/skbuff.h b/compat-include/linux/skbuff.h
index 4c04f165..77c4e99f 100644
--- a/compat-include/linux/skbuff.h
+++ b/compat-include/linux/skbuff.h
@@ -13,21 +13,6 @@
 #include <linux/version.h>
 #include_next <linux/skbuff.h>
 
-#if LINUX_VERSION_IS_LESS(4, 5, 0)
-
-static inline void batadv_skb_postpush_rcsum(struct sk_buff *skb,
-					     const void *start,
-					     unsigned int len)
-{
-	if (skb->ip_summed == CHECKSUM_COMPLETE)
-		skb->csum = csum_block_add(skb->csum,
-					   csum_partial(start, len, 0), 0);
-}
-
-#define skb_postpush_rcsum batadv_skb_postpush_rcsum
-
-#endif /* LINUX_VERSION_IS_LESS(4, 5, 0) */
-
 #if LINUX_VERSION_IS_LESS(4, 13, 0)
 
 static inline void *batadv_skb_put(struct sk_buff *skb, unsigned int len)
diff --git a/compat-include/net/cfg80211.h b/compat-include/net/cfg80211.h
index 6b756007..4bfcd5a3 100644
--- a/compat-include/net/cfg80211.h
+++ b/compat-include/net/cfg80211.h
@@ -13,24 +13,6 @@
 #include <linux/version.h>
 #include_next <net/cfg80211.h>
 
-#if LINUX_VERSION_IS_LESS(4, 8, 0)
-
-#if !IS_ENABLED(CONFIG_CFG80211) && \
-    LINUX_VERSION_IS_GEQ(3, 16, 0)
-
-#define cfg80211_get_station(dev, mac_addr, sinfo) \
-	batadv_cfg80211_get_station(dev, mac_addr, sinfo)
-
-static inline int batadv_cfg80211_get_station(struct net_device *dev,
-					      const u8 *mac_addr,
-					      struct station_info *sinfo)
-{
-	return -ENOENT;
-}
-#endif
-
-#endif /* LINUX_VERSION_IS_LESS(4, 8, 0) */
-
 
 #if LINUX_VERSION_IS_LESS(4, 18, 0) && IS_ENABLED(CONFIG_CFG80211)
 
diff --git a/compat-include/uapi/linux/genetlink.h b/compat-include/uapi/linux/genetlink.h
deleted file mode 100644
index 5fd58e22..00000000
--- a/compat-include/uapi/linux/genetlink.h
+++ /dev/null
@@ -1,22 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/* Copyright (C) B.A.T.M.A.N. contributors:
- *
- * Marek Lindner, Simon Wunderlich
- *
- * This file contains macros for maintaining compatibility with older versions
- * of the Linux kernel.
- */
-
-#ifndef _NET_BATMAN_ADV_COMPAT_UAPI_LINUX_GENETLINK_H_
-#define _NET_BATMAN_ADV_COMPAT_UAPI_LINUX_GENETLINK_H_
-
-#include <linux/version.h>
-#include_next <uapi/linux/genetlink.h>
-
-#if LINUX_VERSION_IS_LESS(4, 6, 0)
-
-#define GENL_UNS_ADMIN_PERM GENL_ADMIN_PERM
-
-#endif /* LINUX_VERSION_IS_LESS(4, 6, 0) */
-
-#endif /* _NET_BATMAN_ADV_COMPAT_UAPI_LINUX_GENETLINK_H_ */
-- 
2.30.2

