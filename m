Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E2AFC5AC67
	for <batman-adv@archiver.kernel.org>; Sat,  8 Aug 2026 18:06:27 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 35F018413A
	for <batman-adv@archiver.kernel.org>; Sat, 08 Aug 2026 20:06:25 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1786212385;
 b=O1QwFAyQMj2AtGXN3PMV22sPORjvBkea+jHYoUmX6EASmIivlq2iFHF+weQYuzU7ir5B7
 17JZ/3ISgUOs10ek+ZXNOObxPQ/2rPBfSW5vEolxVy2eLKP1dcsEBBFPPY6qwhm33wPpDN9
 jqfsiO1DIJfq2SXGneVpWR3mTG9rPZw=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1786212385; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=YdiE8VGypJpv5HBuXnBa8KkgnNDJXFc7/hQuHCpKGkQ=;
 b=fk7sRxRIGIODHuajOYO35jcSrZJOgd4bZwQfU+z05zTA6BS3xtdXRlP5I78mk+BY5ErMr
 5XJgaIgDDcq/ZzLD0M/NnxnZjEd7g1OM/6Gd3Hu2CAW9sYCueBpcnQjTtxEiUZQebFNgfLY
 L4lmtwEh9ejh5HlAQpzbqVl1OgipHNc=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org
 [IPv6:2a00:17d8:100::8b1])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id AF8AA811A3
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sat, 08 Aug 2026 20:05:57 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1786212367;
	b=1a2RWT649xdDlNQy1Fz87qGSoY5Ov2U9IkV2mVyvE+kTNCz1IyGJGwSFKHAIRepOig5IvQ
	ud7mAr9586W8lqlAMImwhKPry/G0t5x0/CiGUzHuXnfJlheI2xugUfNvMyc1RJoCCn6yKy
	VFzyuQuwWW8MOvINj91w4S5UgQOojSw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1786212367;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:dkim-signature;
	bh=YdiE8VGypJpv5HBuXnBa8KkgnNDJXFc7/hQuHCpKGkQ=;
	b=OZaRZ3IZ+Ql/CQmV/wiAw+dp9kewbwZKULSOb/ie7A5A4MTAUSqEgUptp79D9yiQzMhS+q
	/UX97449l+U6qaD99qh+Rf6/xXxo7/BibH8DIkWUu//JLH7U6fjMhWF8fS5m2aRWrrsXE0
	PvhrfmG4+ILo8xkEGP0M5/ms6H+eXNQ=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=MfHmyUNO;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id 98C8721B87;
	Sat, 08 Aug 2026 18:05:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1786212352;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=YdiE8VGypJpv5HBuXnBa8KkgnNDJXFc7/hQuHCpKGkQ=;
	b=MfHmyUNOad7fHE39KRHST7nSr+FkaLfkb5lbFTmem000rcEUoxsyTwmlRpbikZRzGzXcFG
	jo2+BiHKsYop0X1HReS0VK8gW4r9ox563Hr+1Tz0UezX2IV3RXVTORGHKcyLrmXPlrRKDa
	10D2iMV84NpfxxLPanoxYfPgvOO7fbU=
From: Sven Eckelmann <sven@narfation.org>
Date: Sat, 08 Aug 2026 20:05:49 +0200
Subject: [PATCH batadv] batman-adv: compat: drop support for Linux < 5.15
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260808-compat-5-14-removal-v1-1-112aae788fc7@narfation.org>
X-B4-Tracking: v=1; b=H4sIAPxvd2oC/yWMQQrCMBAAv1L27EIajKR+RTxsN6uu2KYkaRBK/
 27U4wzMbJAlqWQ4dxskqZo1zg36Qwf8oPkuqKExWGNPxhuPHKeFCjrsj5hkipVeOLB31oSBWRy
 0ckly0/fveoGRCoUK17/P6/gULt8l7PsHJlvbJn8AAAA=
X-Change-ID: 20260808-compat-5-14-removal-9c8520d9cce5
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=10128; i=sven@narfation.org;
 h=from:subject:message-id; bh=EEmexGiHgDuxKqWiS2r/+KQGHNwoEF5i/q5ZjkSaCo4=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFnl+X/bHCZunPNWYf/caa4Rh7TrQt8szCk7EL6yhNH1a
 JZeRlxnRwkLgxgXg6yYIsueK/nnN7O/lf887eNRmDmsTCBDGLg4BWAi9Z8ZfqybkJq6vqqRkefT
 isspGWur7mzO/edzc4Utn63V0RydE4wMExgyHMJb1h05UvS6T471178stuATWz+JsZcaZRfOK+t
 kAAA=
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: F5YDONR23UJ6QYM2IPYPIEZSP4MEJJKX
X-Message-ID-Hash: F5YDONR23UJ6QYM2IPYPIEZSP4MEJJKX
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/F5YDONR23UJ6QYM2IPYPIEZSP4MEJJKX/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

Linux 5.10.261 added commit 676457fe5ad1 ("mld: convert ifmcaddr6 to RCU")
to backport the mld access behavior from Linux 5.13. But this fixes/stable
backport version cannot be represented in the LINUX_VERSION_CODE. It is
therefore hard to identify this version when trying to compile batman-adv
against it. Supporting this versions is therefore unnecessary hard.

This LTS kernel will be EoL at the end of the year anyway. There is not a
big loss in dropping the support for this kernel version already with this
batman-adv version.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 README.external.rst                |  2 +-
 compat-include/linux/etherdevice.h | 20 --------
 compat-include/linux/if_bridge.h   | 51 ---------------------
 compat-include/linux/if_vlan.h     |  1 -
 compat-include/linux/kstrtox.h     | 14 ------
 compat-include/linux/netdevice.h   | 22 ---------
 compat-include/linux/stdarg.h      | 13 ------
 compat-include/net/addrconf.h      | 94 --------------------------------------
 net/batman-adv/multicast.c         |  3 +-
 9 files changed, 2 insertions(+), 218 deletions(-)

diff --git a/README.external.rst b/README.external.rst
index f988986f..0b1bef15 100644
--- a/README.external.rst
+++ b/README.external.rst
@@ -12,7 +12,7 @@ and as an external module. The external  module   allows  to  get
 new    features without  upgrading  to  a  newer  kernel  version
 and to get batman-adv specific bug fixes for  kernels  that   are
 not   supported   anymore.  It compiles  against  and should work
-with  Linux 5.10  -   7.2.  Supporting  older  versions  is   not
+with  Linux 5.15  -   7.2.  Supporting  older  versions  is   not
 planned,  but it's probably easy to backport it. If you work on a
 backport, feel free to contact us.  :-)
 
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
index b56b2ac1..db8d473c 100644
--- a/compat-include/linux/if_vlan.h
+++ b/compat-include/linux/if_vlan.h
@@ -7,7 +7,6 @@
 #include_next <linux/if_vlan.h>
 
 #if LINUX_VERSION_IS_LESS(6, 4, 0) && \
-    !(LINUX_VERSION_IS_GEQ(5, 10, 205) && LINUX_VERSION_IS_LESS(5, 11, 0)) && \
     !(LINUX_VERSION_IS_GEQ(5, 15, 144) && LINUX_VERSION_IS_LESS(5, 16, 0)) && \
     !(LINUX_VERSION_IS_GEQ(6, 1, 69) && LINUX_VERSION_IS_LESS(6, 2, 0))
 
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
index 6963e12d..a31d0168 100644
--- a/compat-include/linux/netdevice.h
+++ b/compat-include/linux/netdevice.h
@@ -6,28 +6,6 @@
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
 #if LINUX_VERSION_IS_LESS(5, 17, 0)
 
 typedef struct {} netdevice_tracker;
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
index 61410364..155592ab 100644
--- a/net/batman-adv/multicast.c
+++ b/net/batman-adv/multicast.c
@@ -133,8 +133,7 @@ static u8 batadv_mcast_mla_rtr_flags_meshif_get_ipv6(struct net_device *dev)
 {
 	struct inet6_dev *in6_dev = __in6_dev_get(dev);
 
-#if (LINUX_VERSION_IS_GEQ(5, 10, 111) && LINUX_VERSION_IS_LESS(5, 11, 0)) || /* UGLY_HACK */ \
-    (LINUX_VERSION_IS_GEQ(5, 15, 34) && LINUX_VERSION_IS_LESS(5, 16, 0)) || /* UGLY_HACK */ \
+#if (LINUX_VERSION_IS_GEQ(5, 15, 34) && LINUX_VERSION_IS_LESS(5, 16, 0)) || /* UGLY_HACK */ \
     (LINUX_VERSION_IS_GEQ(5, 16, 20) && LINUX_VERSION_IS_LESS(5, 17, 0)) || /* UGLY_HACK */ \
     LINUX_VERSION_IS_GEQ(5, 17, 3) // UGLY_HACK_NEW
 	if (in6_dev && atomic_read(&in6_dev->cnf.mc_forwarding))

---
base-commit: 6ff21902725ca4c437f6d60774e903ecdca2e645
change-id: 20260808-compat-5-14-removal-9c8520d9cce5

Best regards,
--  
Sven Eckelmann <sven@narfation.org>

