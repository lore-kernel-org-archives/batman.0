Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81D4CC55174
	for <batman-adv@archiver.kernel.org>; Wed,  5 Aug 2026 15:08:08 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 1F2858421C
	for <batman-adv@archiver.kernel.org>; Wed, 05 Aug 2026 17:08:07 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1785942487;
 b=MBOj9TL6bWQLR1OhuMN50K4/Z/IdhQu6nVNedoo04bCdzP0pKIGX1s9L9siJ7VaUVc9/j
 mVPr0ISv7gecfRTZJU+JLSogKji+bOIFxfJ8EofPuH8QkSFDvQjDQNGcWDBxfMiyTTbbypj
 8qiQWCHH3SGaupsfZcBPI4AGtfaXr6o=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1785942487; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=z+8AmhGBE2zziXT2MsA/VPOe1PR/2oG8nCPKKkXAMXw=;
 b=KiugG0mnz8yPXzbKCtoFzaWyepELSVKIxp2ay08yNqqwgAya+Lf6+b2vG/zuxZxU2WqZl
 /KDUjDLUyfYrgi9wauqWuvWbnTfxL4U6m050udfBGpd50pm4A85DKKdia+qJC+T+7lZUjDJ
 j/fje1dm6MLar2UmSABqaVkCFoZa4Cs=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 80C4181698
	for <b.a.t.m.a.n@lists.open-mesh.org>; Wed, 05 Aug 2026 17:07:25 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1785942445;
	b=LMNp2ux+LGoFLs5XZUcD53+d0Feg2cAGVQJlcKyEWtg6TzND2lRSPsylY8JIOq1CMfGBVB
	rXMbR6roJ7XjVnWHR4AOkmxZqN7IdJE35am7zgwqEnZDqTecFKGzJCShib43nRP/dcQMm1
	C3u5zNsAgR+ljjbajNLuDxXlqNRpY3U=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1785942445;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=z+8AmhGBE2zziXT2MsA/VPOe1PR/2oG8nCPKKkXAMXw=;
	b=UELUDiiI+hXyZp4zuPogl61IpCalHiPrsvCZEn7mr8P+ucxfZ5kWkfuLz3yLkrajLSEipU
	5UY6p68MUagzXNlw56V5lODlJ9JKv2UmTTg9RSCY9cnka8+4qAcYjHeQZfx5FhFuk0Iwv3
	rVVXKWtiueDCBWvafDxdAWvh/xp0D+8=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=ghdy8AOm;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id EF1E5204D0;
	Wed, 05 Aug 2026 15:07:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1785942441;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=z+8AmhGBE2zziXT2MsA/VPOe1PR/2oG8nCPKKkXAMXw=;
	b=ghdy8AOm1pTDA44rKDnmF3NhF0wWHPxyeufj7yBkSoKnOh83V6WZJrIc/8pvyd0uBlsp0Q
	gmU/i/k0gJcgqBILJyW9WdkXvFr49jbJ1/ailF6Ki6VNAOPitsqkch+5GnDLq+qy7sTlxr
	7YvPsWq0KqhJ2opfZbEVmTpqp3TBFeo=
From: Sven Eckelmann <sven@narfation.org>
Date: Wed, 05 Aug 2026 17:06:57 +0200
Subject: [PATCH batadv 1/2] batman-adv: compat: drop support for pre-C11
 kernels
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260805-scoped_guard-compat-v1-1-3067f6013b62@narfation.org>
References: <20260805-scoped_guard-compat-v1-0-3067f6013b62@narfation.org>
In-Reply-To: <20260805-scoped_guard-compat-v1-0-3067f6013b62@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=13253; i=sven@narfation.org;
 h=from:subject:message-id; bh=kePJXAETwtP1LH6IfXaOkltiOSsxf5o34PEmDYpWt1Y=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFnFgZNmvdn+gPv9v4l3BNP43jBIfXxUtuvE55DFjy/Lp
 p52vXR1YkcpC4MYF4OsmCLLniv55zezv5X/PO3jUZg5rEwgQxi4OAVgIvmzGP5puIWWZO0rlru9
 1zniDy/X77v+Dn5zOaJPqOw1Zvx3eYkyI8PRC7N138T3n7nZtCltY2q778kYffNJwjyskutTirw
 TYnkA
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: JUAL5ZXJ5VEOGOSISFX2ZO2YCFRGYO7A
X-Message-ID-Hash: JUAL5ZXJ5VEOGOSISFX2ZO2YCFRGYO7A
X-MailFrom: sven@narfation.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-b.a.t.m.a.n.lists.open-mesh.org-0;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-1;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-2;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-3; emergency; member-moderation;
 nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size;
 news-moderation; no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/JUAL5ZXJ5VEOGOSISFX2ZO2YCFRGYO7A/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

batman-adv will rely on C99/C11 features but the kernel enabled it only
since Linux 5.18. The support for Linux 5.10-5.17 is therefore no longer
possible. But these LTS kernels will be EoL at the end of the year anyway.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 README.external.rst                   |  2 +-
 compat-include/linux/array_size.h     |  3 +-
 compat-include/linux/container_of.h   | 13 -----
 compat-include/linux/etherdevice.h    | 20 --------
 compat-include/linux/if_bridge.h      | 51 -------------------
 compat-include/linux/if_vlan.h        |  2 -
 compat-include/linux/kstrtox.h        | 14 ------
 compat-include/linux/netdevice.h      | 49 +-----------------
 compat-include/linux/stdarg.h         | 13 -----
 compat-include/linux/string_choices.h | 12 -----
 compat-include/linux/timer.h          |  1 -
 compat-include/net/addrconf.h         | 94 -----------------------------------
 net/batman-adv/multicast.c            |  7 ---
 13 files changed, 4 insertions(+), 277 deletions(-)

diff --git a/README.external.rst b/README.external.rst
index f988986f..fb4eaae0 100644
--- a/README.external.rst
+++ b/README.external.rst
@@ -12,7 +12,7 @@ and as an external module. The external  module   allows  to  get
 new    features without  upgrading  to  a  newer  kernel  version
 and to get batman-adv specific bug fixes for  kernels  that   are
 not   supported   anymore.  It compiles  against  and should work
-with  Linux 5.10  -   7.2.  Supporting  older  versions  is   not
+with  Linux 5.18  -   7.2.  Supporting  older  versions  is   not
 planned,  but it's probably easy to backport it. If you work on a
 backport, feel free to contact us.  :-)
 
diff --git a/compat-include/linux/array_size.h b/compat-include/linux/array_size.h
index 418deb68..9cb8d6c2 100644
--- a/compat-include/linux/array_size.h
+++ b/compat-include/linux/array_size.h
@@ -4,8 +4,7 @@
 #define _NET_BATMAN_ADV_COMPAT_LINUX_ARRAY_SIZE_H_
 
 #include <linux/version.h>
-#if (LINUX_VERSION_IS_GEQ(5, 15, 197) && LINUX_VERSION_IS_LESS(5, 16, 0)) || \
-    (LINUX_VERSION_IS_GEQ(6, 1, 159) && LINUX_VERSION_IS_LESS(6, 2, 0)) || \
+#if (LINUX_VERSION_IS_GEQ(6, 1, 159) && LINUX_VERSION_IS_LESS(6, 2, 0)) || \
     (LINUX_VERSION_IS_GEQ(6, 6, 118) && LINUX_VERSION_IS_LESS(6, 7, 0)) || \
     LINUX_VERSION_IS_GEQ(6, 7, 0)
 #include_next <linux/array_size.h>
diff --git a/compat-include/linux/container_of.h b/compat-include/linux/container_of.h
deleted file mode 100644
index 771c979c..00000000
--- a/compat-include/linux/container_of.h
+++ /dev/null
@@ -1,13 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-
-#ifndef _NET_BATMAN_ADV_COMPAT_LINUX_CONTAINER_OF_H_
-#define _NET_BATMAN_ADV_COMPAT_LINUX_CONTAINER_OF_H_
-
-#include <linux/version.h>
-#if LINUX_VERSION_IS_GEQ(5, 16, 0)
-#include_next <linux/container_of.h>
-#else
-#include <linux/kernel.h>
-#endif
-
-#endif /* _NET_BATMAN_ADV_COMPAT_LINUX_CONTAINER_OF_H_ */
diff --git a/compat-include/linux/etherdevice.h b/compat-include/linux/etherdevice.h
deleted file mode 100644
index 1e2fdafb..00000000
--- a/compat-include/linux/etherdevice.h
+++ /dev/null
@@ -1,20 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-
-#ifndef _NET_BATMAN_ADV_COMPAT_LINUX_ETHERDEVICE_H_
-#define _NET_BATMAN_ADV_COMPAT_LINUX_ETHERDEVICE_H_
-
-#include <linux/version.h>
-#include_next <linux/etherdevice.h>
-
-#if LINUX_VERSION_IS_LESS(5, 15, 0)
-
-static inline void batadv_eth_hw_addr_set(struct net_device *dev,
-					  const u8 *addr)
-{
-	ether_addr_copy(dev->dev_addr, addr);
-}
-#define eth_hw_addr_set batadv_eth_hw_addr_set
-
-#endif /* LINUX_VERSION_IS_LESS(5, 15, 0) */
-
-#endif	/* _NET_BATMAN_ADV_COMPAT_LINUX_ETHERDEVICE_H_ */
diff --git a/compat-include/linux/if_bridge.h b/compat-include/linux/if_bridge.h
deleted file mode 100644
index 50aa0608..00000000
--- a/compat-include/linux/if_bridge.h
+++ /dev/null
@@ -1,51 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-
-#ifndef _NET_BATMAN_ADV_COMPAT_LINUX_IF_BRIDGE_H_
-#define _NET_BATMAN_ADV_COMPAT_LINUX_IF_BRIDGE_H_
-
-#include <linux/version.h>
-#include_next <linux/if_bridge.h>
-
-#if LINUX_VERSION_IS_LESS(5, 14, 0)
-
-#include <net/addrconf.h>
-
-#if IS_ENABLED(CONFIG_IPV6)
-static inline bool
-br_multicast_has_router_adjacent(struct net_device *dev, int proto)
-{
-	struct list_head bridge_mcast_list = LIST_HEAD_INIT(bridge_mcast_list);
-	struct br_ip_list *br_ip_entry, *tmp;
-	int ret;
-
-	if (proto != ETH_P_IPV6)
-		return true;
-
-	ret = br_multicast_list_adjacent(dev, &bridge_mcast_list);
-	if (ret < 0)
-		return true;
-
-	ret = false;
-
-	list_for_each_entry_safe(br_ip_entry, tmp, &bridge_mcast_list, list) {
-		if (br_ip_entry->addr.proto == htons(ETH_P_IPV6) &&
-		    ipv6_addr_is_ll_all_routers(&br_ip_entry->addr.dst.ip6))
-			ret = true;
-
-		list_del(&br_ip_entry->list);
-		kfree(br_ip_entry);
-	}
-
-	return ret;
-}
-#else
-static inline bool
-br_multicast_has_router_adjacent(struct net_device *dev, int proto)
-{
-	return true;
-}
-#endif
-
-#endif /* LINUX_VERSION_IS_LESS(5, 14, 0) */
-
-#endif /* _NET_BATMAN_ADV_COMPAT_LINUX_IF_BRIDGE_H_ */
diff --git a/compat-include/linux/if_vlan.h b/compat-include/linux/if_vlan.h
index b56b2ac1..7b1dab12 100644
--- a/compat-include/linux/if_vlan.h
+++ b/compat-include/linux/if_vlan.h
@@ -7,8 +7,6 @@
 #include_next <linux/if_vlan.h>
 
 #if LINUX_VERSION_IS_LESS(6, 4, 0) && \
-    !(LINUX_VERSION_IS_GEQ(5, 10, 205) && LINUX_VERSION_IS_LESS(5, 11, 0)) && \
-    !(LINUX_VERSION_IS_GEQ(5, 15, 144) && LINUX_VERSION_IS_LESS(5, 16, 0)) && \
     !(LINUX_VERSION_IS_GEQ(6, 1, 69) && LINUX_VERSION_IS_LESS(6, 2, 0))
 
 /* Prefer this version in TX path, instead of
diff --git a/compat-include/linux/kstrtox.h b/compat-include/linux/kstrtox.h
deleted file mode 100644
index 800341a8..00000000
--- a/compat-include/linux/kstrtox.h
+++ /dev/null
@@ -1,14 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-
-#ifndef _NET_BATMAN_ADV_COMPAT_LINUX_KSTRTOX_H_
-#define _NET_BATMAN_ADV_COMPAT_LINUX_KSTRTOX_H_
-
-#include <linux/version.h>
-#if (LINUX_VERSION_IS_GEQ(5, 10, 185) && LINUX_VERSION_IS_LESS(5, 11, 0)) || \
-    LINUX_VERSION_IS_GEQ(5, 14, 0)
-#include_next <linux/kstrtox.h>
-#else
-#include <linux/kernel.h>
-#endif
-
-#endif /* _NET_BATMAN_ADV_COMPAT_LINUX_KSTRTOX_H_ */
diff --git a/compat-include/linux/netdevice.h b/compat-include/linux/netdevice.h
index 6963e12d..45df743e 100644
--- a/compat-include/linux/netdevice.h
+++ b/compat-include/linux/netdevice.h
@@ -6,39 +6,7 @@
 #include <linux/version.h>
 #include_next <linux/netdevice.h>
 
-#if LINUX_VERSION_IS_LESS(5, 15, 0)
-
-static inline void batadv_dev_put(struct net_device *dev)
-{
-	if (!dev)
-		return;
-
-	dev_put(dev);
-}
-#define dev_put batadv_dev_put
-
-static inline void batadv_dev_hold(struct net_device *dev)
-{
-	if (!dev)
-		return;
-
-	dev_hold(dev);
-}
-#define dev_hold batadv_dev_hold
-
-#endif /* LINUX_VERSION_IS_LESS(5, 15, 0) */
-
-#if LINUX_VERSION_IS_LESS(5, 17, 0)
-
-typedef struct {} netdevice_tracker;
-
-#define netdev_hold(__dev, __tracker, __gfp) \
-	dev_hold(__dev)
-
-#define netdev_put(__dev, __tracker) \
-	dev_put(__dev)
-
-#elif LINUX_VERSION_IS_LESS(6, 0, 0)
+#if LINUX_VERSION_IS_LESS(6, 0, 0)
 
 #define netdev_hold(__dev, __tracker, __gfp) \
 	dev_hold_track(__dev, __tracker, __gfp)
@@ -46,19 +14,6 @@ typedef struct {} netdevice_tracker;
 #define netdev_put(__dev, __tracker) \
 	dev_put_track(__dev, __tracker)
 
-#endif /* LINUX_VERSION_IS_LESS(5, 17, 0) */
-
-#if LINUX_VERSION_IS_LESS(5, 18, 0)
-
-static inline int batadv_netif_rx(struct sk_buff *skb)
-{
-	if (in_interrupt())
-		return netif_rx(skb);
-	else
-		return netif_rx_ni(skb);
-}
-#define netif_rx batadv_netif_rx
-
-#endif /* LINUX_VERSION_IS_LESS(5, 18, 0) */
+#endif /* LINUX_VERSION_IS_LESS(6, 0, 0) */
 
 #endif	/* _NET_BATMAN_ADV_COMPAT_LINUX_NETDEVICE_H_ */
diff --git a/compat-include/linux/stdarg.h b/compat-include/linux/stdarg.h
deleted file mode 100644
index 3137c428..00000000
--- a/compat-include/linux/stdarg.h
+++ /dev/null
@@ -1,13 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-
-#ifndef _NET_BATMAN_ADV_COMPAT_LINUX_STDARG_H_
-#define _NET_BATMAN_ADV_COMPAT_LINUX_STDARG_H_
-
-#include <linux/version.h>
-#if LINUX_VERSION_IS_GEQ(5, 15, 0)
-#include_next <linux/stdarg.h>
-#else
-#include <stdarg.h>
-#endif
-
-#endif
diff --git a/compat-include/linux/string_choices.h b/compat-include/linux/string_choices.h
index 3c6dcf54..ff9783d0 100644
--- a/compat-include/linux/string_choices.h
+++ b/compat-include/linux/string_choices.h
@@ -8,18 +8,6 @@
 #include_next <linux/string_choices.h>
 #elif LINUX_VERSION_IS_GEQ(5, 18, 0)
 #include <linux/string_helpers.h>
-#else
-
-static inline const char *str_yes_no(bool v)
-{
-	return v ? "yes" : "no";
-}
-
-static inline const char *str_on_off(bool v)
-{
-	return v ? "on" : "off";
-}
-
 #endif
 
 #endif /* _NET_BATMAN_ADV_COMPAT_LINUX_STRING_CHOICES_H_ */
diff --git a/compat-include/linux/timer.h b/compat-include/linux/timer.h
index add50f58..659a2575 100644
--- a/compat-include/linux/timer.h
+++ b/compat-include/linux/timer.h
@@ -7,7 +7,6 @@
 #include_next <linux/timer.h>
 
 #if LINUX_VERSION_IS_LESS(6, 2, 0) && \
-    !(LINUX_VERSION_IS_GEQ(5, 15, 200) && LINUX_VERSION_IS_LESS(5, 16, 0)) && \
     !(LINUX_VERSION_IS_GEQ(6, 1, 158) && LINUX_VERSION_IS_LESS(6, 2, 0))
 
 #define timer_delete_sync(_timer) del_timer_sync(_timer)
diff --git a/compat-include/net/addrconf.h b/compat-include/net/addrconf.h
deleted file mode 100644
index 7b166c80..00000000
--- a/compat-include/net/addrconf.h
+++ /dev/null
@@ -1,94 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-
-#ifndef _NET_BATMAN_ADV_COMPAT_NET_ADDRCONF_H_
-#define _NET_BATMAN_ADV_COMPAT_NET_ADDRCONF_H_
-
-#include <linux/version.h>
-#include_next <net/addrconf.h>
-
-#if LINUX_VERSION_IS_LESS(5, 13, 0)
-
-static bool batadv_mcast_mla_is_duplicate(u8 *mcast_addr,
-					  struct hlist_head *mcast_list);
-
-static inline int
-compat_batadv_mcast_mla_meshif_get_ipv6(struct net_device *dev,
-				 struct hlist_head *mcast_list,
-				 struct batadv_mcast_mla_flags *flags,
-				 u8 *mcast_addr,
-				struct batadv_hw_addr *new,
-				struct inet6_dev *in6_dev)
-
-{
-	struct ifmcaddr6 *pmc6;
-	int ret = 0;
-
-	if (flags->tvlv_flags & BATADV_MCAST_WANT_ALL_IPV6)
-		return 0;
-
-	rcu_read_lock();
-
-	in6_dev = __in6_dev_get(dev);
-	if (!in6_dev) {
-		rcu_read_unlock();
-		return 0;
-	}
-
-	read_lock_bh(&in6_dev->lock);
-	for (pmc6 = in6_dev->mc_list; pmc6; pmc6 = pmc6->next) {
-		if (IPV6_ADDR_MC_SCOPE(&pmc6->mca_addr) <
-		    IPV6_ADDR_SCOPE_LINKLOCAL)
-			continue;
-
-		if (flags->tvlv_flags & BATADV_MCAST_WANT_ALL_UNSNOOPABLES &&
-		    ipv6_addr_is_ll_all_nodes(&pmc6->mca_addr))
-			continue;
-
-		if (!(flags->tvlv_flags & BATADV_MCAST_WANT_NO_RTR6) &&
-		    IPV6_ADDR_MC_SCOPE(&pmc6->mca_addr) >
-		    IPV6_ADDR_SCOPE_LINKLOCAL)
-			continue;
-
-		ipv6_eth_mc_map(&pmc6->mca_addr, mcast_addr);
-
-		if (batadv_mcast_mla_is_duplicate(mcast_addr, mcast_list))
-			continue;
-
-		new = kmalloc_obj(*new, GFP_ATOMIC);
-		if (!new) {
-			ret = -ENOMEM;
-			break;
-		}
-
-		ether_addr_copy(new->addr, mcast_addr);
-		hlist_add_head(&new->list, mcast_list);
-		ret++;
-	}
-	read_unlock_bh(&in6_dev->lock);
-	rcu_read_unlock();
-
-	return ret;
-}
-
-#define ifmcaddr6 \
-		net_device *orig_dev = dev; \
-		return compat_batadv_mcast_mla_meshif_get_ipv6(orig_dev, \
-							       mcast_list, \
-							       flags, \
-							       mcast_addr, \
-							       new = NULL, \
-							       in6_dev = NULL); \
-	} \
-	static inline int \
-	__unused_batadv_mcast_mla_meshif_get_ipv6(struct net_device *dev, \
-					     struct hlist_head *mcast_list, \
-					     struct batadv_mcast_mla_flags *flags) \
-	{ \
-		struct batadv_hw_addr *new; \
-		struct inet6_dev *in6_dev; \
-		u8 mcast_addr[ETH_ALEN]; \
-		struct ifmcaddr6
-
-#endif /* LINUX_VERSION_IS_LESS(5, 13, 0) */
-
-#endif	/* _NET_BATMAN_ADV_COMPAT_NET_ADDRCONF_H_ */
diff --git a/net/batman-adv/multicast.c b/net/batman-adv/multicast.c
index 61410364..82fd527b 100644
--- a/net/batman-adv/multicast.c
+++ b/net/batman-adv/multicast.c
@@ -133,14 +133,7 @@ static u8 batadv_mcast_mla_rtr_flags_meshif_get_ipv6(struct net_device *dev)
 {
 	struct inet6_dev *in6_dev = __in6_dev_get(dev);
 
-#if (LINUX_VERSION_IS_GEQ(5, 10, 111) && LINUX_VERSION_IS_LESS(5, 11, 0)) || /* UGLY_HACK */ \
-    (LINUX_VERSION_IS_GEQ(5, 15, 34) && LINUX_VERSION_IS_LESS(5, 16, 0)) || /* UGLY_HACK */ \
-    (LINUX_VERSION_IS_GEQ(5, 16, 20) && LINUX_VERSION_IS_LESS(5, 17, 0)) || /* UGLY_HACK */ \
-    LINUX_VERSION_IS_GEQ(5, 17, 3) // UGLY_HACK_NEW
 	if (in6_dev && atomic_read(&in6_dev->cnf.mc_forwarding))
-#else // UGLY_HACK_OLD
-	if (in6_dev && in6_dev->cnf.mc_forwarding)
-#endif // UGLY_HACK_STOP
 		return BATADV_NO_FLAGS;
 	else
 		return BATADV_MCAST_WANT_NO_RTR6;

-- 
2.47.3

