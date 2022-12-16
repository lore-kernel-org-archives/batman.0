Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Subject: [RFC PATCH] batman-adv: Drop support for Linux < 4.14
Date: Fri, 16 Dec 2022 20:08:23 +0100
Message-Id: <20221216190823.574479-1-sven@narfation.org>
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

The Linux Kernel 4.9 reached its end of life [1] after 6 years. Instead it
is recommended to use at least kernel 4.14. It is also over 5 years
old but still maintained by the stable kernel team. All older kernels
(4.9 - v4.13) will be dropped to reduce the support overhead.

[1] TODO: https://lore.kernel.org/r/XXXX

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 README.external.rst                  |  2 +-
 compat-include/linux/build_bug.h     | 31 -------------------------
 compat-include/linux/netdevice.h     | 19 ----------------
 compat-include/linux/prandom.h       |  1 -
 compat-include/linux/skbuff.h        | 29 ------------------------
 compat-include/linux/timer.h         | 34 ----------------------------
 compat-include/uapi/linux/if_ether.h | 25 --------------------
 compat.h                             | 10 --------
 8 files changed, 1 insertion(+), 150 deletions(-)
 delete mode 100644 compat-include/linux/build_bug.h
 delete mode 100644 compat-include/linux/timer.h
 delete mode 100644 compat-include/uapi/linux/if_ether.h

diff --git a/README.external.rst b/README.external.rst
index 34f3a8d4..e9f00ee0 100644
--- a/README.external.rst
+++ b/README.external.rst
@@ -12,7 +12,7 @@ and as an external module. The external  module   allows  to  get
 new    features without  upgrading  to  a  newer  kernel  version
 and to get batman-adv specific bug fixes for  kernels  that   are
 not   supported   anymore.  It compiles  against  and should work
-with  Linux 4.9  -  6.1.  Supporting  older   versions   is   not
+with  Linux 4.14  -  6.1.  Supporting  older  versions   is   not
 planned,  but it's probably easy to backport it. If you work on a
 backport, feel free to contact us.  :-)
 
diff --git a/compat-include/linux/build_bug.h b/compat-include/linux/build_bug.h
deleted file mode 100644
index 8ec79069..00000000
--- a/compat-include/linux/build_bug.h
+++ /dev/null
@@ -1,31 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/* Copyright (C) B.A.T.M.A.N. contributors:
- *
- * Marek Lindner, Simon Wunderlich
- *
- * This file contains macros for maintaining compatibility with older versions
- * of the Linux kernel.
- */
-
-#ifndef _NET_BATMAN_ADV_COMPAT_LINUX_BUILD_BUG_H_
-#define _NET_BATMAN_ADV_COMPAT_LINUX_BUILD_BUG_H_
-
-#include <linux/version.h>
-#if LINUX_VERSION_IS_GEQ(4, 13, 0)
-#include_next <linux/build_bug.h>
-#else
-#include <linux/bug.h>
-
-/* Linux 4.9.297 doesn't provide BUILD_BUG_ON anymore in linux/bug.h
- * also identified itself with the version number 4.9.255 when decoding the
- * LINUX_VERSION_CODE. So we have to try to guess now if we need to include
- * linux/build_bug.h based on whether BUILD_BUG_ON is defined  or not after
- * including linux/bug.h
- */
-#ifndef BUILD_BUG_ON
-#include_next <linux/build_bug.h>
-#endif
-
-#endif
-
-#endif /* _NET_BATMAN_ADV_COMPAT_LINUX_BUILD_BUG_H_ */
diff --git a/compat-include/linux/netdevice.h b/compat-include/linux/netdevice.h
index eeb31bed..3188ad3d 100644
--- a/compat-include/linux/netdevice.h
+++ b/compat-include/linux/netdevice.h
@@ -20,25 +20,6 @@
 
 #endif /* LINUX_VERSION_IS_LESS(4, 15, 0) */
 
-#if LINUX_VERSION_IS_LESS(4, 11, 9)
-
-/* work around missing attribute needs_free_netdev and priv_destructor in
- * net_device
- */
-#define ether_setup(dev) \
-	void batadv_softif_free2(struct net_device *dev) \
-	{ \
-		batadv_softif_free(dev); \
-		free_netdev(dev); \
-	} \
-	void (*t1)(struct net_device *dev) __attribute__((unused)); \
-	bool t2 __attribute__((unused)); \
-	ether_setup(dev)
-#define needs_free_netdev destructor = batadv_softif_free2; t2
-#define priv_destructor destructor = batadv_softif_free2; t1
-
-#endif /* LINUX_VERSION_IS_LESS(4, 11, 9) */
-
 
 #if LINUX_VERSION_IS_LESS(5, 15, 0)
 
diff --git a/compat-include/linux/prandom.h b/compat-include/linux/prandom.h
index dc227e61..ec2f5244 100644
--- a/compat-include/linux/prandom.h
+++ b/compat-include/linux/prandom.h
@@ -12,7 +12,6 @@
 
 #include <linux/version.h>
 #if LINUX_VERSION_IS_GEQ(5, 8, 1) || \
-    (LINUX_VERSION_IS_GEQ(4, 9, 233) && LINUX_VERSION_IS_LESS(4, 10, 0)) || \
     (LINUX_VERSION_IS_GEQ(4, 14, 193) && LINUX_VERSION_IS_LESS(4, 15, 0)) || \
     (LINUX_VERSION_IS_GEQ(4, 19, 138) && LINUX_VERSION_IS_LESS(4, 20, 0)) || \
     (LINUX_VERSION_IS_GEQ(5, 4, 57) && LINUX_VERSION_IS_LESS(5, 5, 0)) || \
diff --git a/compat-include/linux/skbuff.h b/compat-include/linux/skbuff.h
index 77c4e99f..eda2d181 100644
--- a/compat-include/linux/skbuff.h
+++ b/compat-include/linux/skbuff.h
@@ -13,35 +13,6 @@
 #include <linux/version.h>
 #include_next <linux/skbuff.h>
 
-#if LINUX_VERSION_IS_LESS(4, 13, 0)
-
-static inline void *batadv_skb_put(struct sk_buff *skb, unsigned int len)
-{
-	return (void *)skb_put(skb, len);
-}
-#define skb_put batadv_skb_put
-
-static inline void *skb_put_zero(struct sk_buff *skb, unsigned int len)
-{
-	void *tmp = skb_put(skb, len);
-
-	memset(tmp, 0, len);
-
-	return tmp;
-}
-
-static inline void *skb_put_data(struct sk_buff *skb, const void *data,
-				 unsigned int len)
-{
-	void *tmp = skb_put(skb, len);
-
-	memcpy(tmp, data, len);
-
-	return tmp;
-}
-
-#endif /* LINUX_VERSION_IS_LESS(4, 13, 0) */
-
 #if LINUX_VERSION_IS_LESS(5, 4, 0)
 
 #define nf_reset_ct nf_reset
diff --git a/compat-include/linux/timer.h b/compat-include/linux/timer.h
deleted file mode 100644
index 36da61f7..00000000
--- a/compat-include/linux/timer.h
+++ /dev/null
@@ -1,34 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/* Copyright (C) B.A.T.M.A.N. contributors:
- *
- * Marek Lindner, Simon Wunderlich
- *
- * This file contains macros for maintaining compatibility with older versions
- * of the Linux kernel.
- */
-
-#ifndef _NET_BATMAN_ADV_COMPAT_LINUX_TIMER_H
-#define _NET_BATMAN_ADV_COMPAT_LINUX_TIMER_H
-
-#include <linux/version.h>
-#include_next <linux/timer.h>
-
-#if LINUX_VERSION_IS_LESS(4, 14, 0)
-
-#define TIMER_DATA_TYPE		unsigned long
-#define TIMER_FUNC_TYPE		void (*)(TIMER_DATA_TYPE)
-
-static inline void timer_setup(struct timer_list *timer,
-			       void (*callback)(struct timer_list *),
-			       unsigned int flags)
-{
-	__setup_timer(timer, (TIMER_FUNC_TYPE)callback,
-		      (TIMER_DATA_TYPE)timer, flags);
-}
-
-#define from_timer(var, callback_timer, timer_fieldname) \
-	container_of(callback_timer, typeof(*var), timer_fieldname)
-
-#endif /* LINUX_VERSION_IS_LESS(4, 14, 0) */
-
-#endif /* _NET_BATMAN_ADV_COMPAT_LINUX_TIMER_H */
diff --git a/compat-include/uapi/linux/if_ether.h b/compat-include/uapi/linux/if_ether.h
deleted file mode 100644
index a23fa4d8..00000000
--- a/compat-include/uapi/linux/if_ether.h
+++ /dev/null
@@ -1,25 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/* Copyright (C) B.A.T.M.A.N. contributors:
- *
- * Marek Lindner, Simon Wunderlich
- *
- * This file contains macros for maintaining compatibility with older versions
- * of the Linux kernel.
- */
-
-#ifndef _NET_BATMAN_ADV_COMPAT_UAPI_LINUX_IF_ETHER_H_
-#define _NET_BATMAN_ADV_COMPAT_UAPI_LINUX_IF_ETHER_H_
-
-#include <linux/version.h>
-#include_next <uapi/linux/if_ether.h>
-
-
-#if LINUX_VERSION_IS_LESS(4, 10, 0)
-
-#ifndef ETH_MIN_MTU
-#define ETH_MIN_MTU	68
-#endif
-
-#endif /* LINUX_VERSION_IS_LESS(4, 10, 0) */
-
-#endif	/* _NET_BATMAN_ADV_COMPAT_UAPI_LINUX_IF_ETHER_H_ */
diff --git a/compat.h b/compat.h
index 86e68d83..8e19f9bb 100644
--- a/compat.h
+++ b/compat.h
@@ -15,16 +15,6 @@
 
 #include "compat-autoconf.h"
 
-#if LINUX_VERSION_IS_LESS(4, 13, 0)
-
-#define batadv_softif_validate(__tb, __data, __extack) \
-	batadv_softif_validate(__tb, __data)
-
-#define batadv_softif_newlink(__src_net, __dev, __tb, __data, __extack) \
-	batadv_softif_newlink(__src_net, __dev, __tb, __data)
-
-#endif /* LINUX_VERSION_IS_LESS(4, 13, 0) */
-
 
 #if LINUX_VERSION_IS_LESS(4, 15, 0)
 
-- 
2.35.1

