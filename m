Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4651C4332F
	for <batman-adv@archiver.kernel.org>; Sat,  4 Nov 2023 16:10:51 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 1F72B82E36
	for <batman-adv@archiver.kernel.org>; Sat,  4 Nov 2023 17:10:50 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1699114250;
 b=zYOiBvMHO/xzhar+UgkdAT4b/bbUmpDizB8lFBVrnOuzenWe9PyPsHmdB1k5DbiT09jeE
 ahmNWe7XqeXU2RtKULbSUScZSw7BXQuFS5MMBIk0xGgYK4V57t/kJa5s+f5yPq64mdOlFwh
 EJ2zdSZfuOZ3w/opdN2FebE68kPlqfc=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1699114250; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=6LZ8rV8EBfhcBDd0H516Wqi+losXd/BXNJUpAhYebyM=;
 b=iAkwC0uMWDmw0YorsGXFdM79wGUiBsafMiF05uhJwD0kya2UJqIte1wQpB7if1ktKzMyo
 lBmh5J3f4sPvbprdZVuypbfiY9ixg+lcoX08mKwjkUXZ9EA646a5o0Pj8xW0FyzlEEk+7iH
 yaW6zPgwccWINcoGn8R+wIUGgMLmynk=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
  arc=pass;
  dmarc=pass (Used From Domain Record) header.from=narfation.org
 policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org
 [IPv6:2a00:17d8:100::8b1])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 1285F80D6D
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sat,  4 Nov 2023 17:10:40 +0100 (CET)
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1699114242; a=rsa-sha256;
	cv=none;
	b=QLD3d9mXbg8i+IiuffsjkfBssVmfMgHE4m0iGAODz4IzYo7GXdkKcnFsjaS9gGOndodhL0
	T4+nKMz/n7/su9GD+QpCw/VmwzYfQmQ1HDFyuXub4lhs7O5aOEwgPM74rRG+88D6hx+7lt
	OV3Q0eTZQf0G9SAGPAOCUA1xifLkqzE=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=rzuUsrEA;
	dmarc=pass (policy=none) header.from=narfation.org;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1699114242;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:dkim-signature;
	bh=6LZ8rV8EBfhcBDd0H516Wqi+losXd/BXNJUpAhYebyM=;
	b=VpDetj8ycIvF0JcJDtkHWBZxt1J90p/gT6haIlLiTOW7nVqW3Xa0WGBlIMHuFjKIvpIY7n
	aDjmDWoHbvEGRti/S8/Zckg6pd3nbeKX5EdX5lIlvB/Q8L1UyOOEofDGg5dxkdWT8WOe9i
	H3BAsr1+N11Atv08SGmSTpNA27QOWis=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1699114240;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=6LZ8rV8EBfhcBDd0H516Wqi+losXd/BXNJUpAhYebyM=;
	b=rzuUsrEAryq2/Cvb/Ubz5dFr2yGJuYf1oWc4ptFAYQ619226/V11iiIkjlKqqEl2kGamSd
	MX+ryRcBX/hD3kIn9gRxofXSai9B/29luD8rM8js/E1C2K1MExQOFb1hEfSI5oe9ZVzVlL
	+ruleCjtZ9fzyVY+kCBMSFEDgnhF6b0=
From: Sven Eckelmann <sven@narfation.org>
Date: Sat, 04 Nov 2023 17:10:09 +0100
Subject: [PATCH RFC] batman-adv: Drop support for Linux < 4.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231104-drop-compat-4-14-v1-1-d2453b1cfd45@narfation.org>
X-B4-Tracking: v=1; b=H4sIAOBsRmUC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI2NDQwMT3ZSi/ALd5PzcgsQSXRNdQyBKSko0MElKTLY0M1YCaisoSk3LrAA
 bGa0U5OasFFtbCwBSORt/ZwAAAA==
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=5860; i=sven@narfation.org;
 h=from:subject:message-id; bh=g1lLO4ONmhiCKab63TDUDSv3oN0wFzLNi9ZHzYC6EA0=;
 b=owEBbQKS/ZANAwAKAV2HCgfBJntGAcsmYgBlRmz0jzyyGtAwk9HOOnBOwak6fpTAk8ID1YwPw
 4DTjF+WKliJAjMEAAEKAB0WIQQXXSuHYSVz3OMy4AJdhwoHwSZ7RgUCZUZs9AAKCRBdhwoHwSZ7
 Rp4eEACLowwQC11/JmmHtwFUmUwDqSyL7/KvGcCOnej65nGW7O3AHqy/FbMHpoRS586HVr/rB8u
 AhRBpGlRLA3ly1GK1ilTZWsQRIpOFvOitiCUd6gmDN1R43XuPy22pZKKGMdKUJtWpLA/DZmpqqA
 xQDm5csvIF1DsmvkeLTjfKeWD/AJvhf2tklINRwpWKn6d7pGeEyjn2V6R1p5IEYe+p+6wq9/vrL
 lpvrZrMVABM2cGxufiZhdvN8z6sFzAmFHrO0zIpJqitv5GCslX8MmxMYmEDW2s2fssMgqcqNrvA
 1M5ZP1pd71E7CYqhn0sLa0GH2mCIKzdW504C1lR2t2E5GrSQdQFx9zcyzqu5VRbxYRmDx9NqGxS
 fCr/+zmB9iOlz1Smzd0QvJrWiRgv6PyKHpsb2yP5adjrkXnUf7u42X/p95w93YakEusorVdSLtX
 mJGOMDkFbX58pL16LpBp/MsdaPpQCJIm7tvLDS9qDgWiO2hd7vcsMBIEwCs9UaYKO27RYFoHXQ4
 rMOyNl4yC6K5IVKfjJDwFeXTRq9F62zZM63WU2upYh9agQZ83Mt1up1hox5sJ9XGLG2vY1j5RPD
 oR5H2ncliCXvJ6vAIT4djiMVDHBhOTwLNfGG/Z3Mahm2oRtmfXnz2q1pWmHB+4W2X64iYX39NGs
 WM7apqiyYaG4r/A==
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: RHPNUAKSHZNITDK3OHMIULC3QKUNE4TS
X-Message-ID-Hash: RHPNUAKSHZNITDK3OHMIULC3QKUNE4TS
X-MailFrom: sven@narfation.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-0;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-1;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-2; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/RHPNUAKSHZNITDK3OHMIULC3QKUNE4TS/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

The Linux Kernel 4.14 reached its end of life [1] after 6 years. Instead it
is recommended to use at least kernel 4.19. It is also over 5 years
old but still maintained by the stable kernel team. All older kernels
(4.14 - v4.18) will be dropped to reduce the support overhead.

[1] TODO: https://lore.kernel.org/r/

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
The last 4.14 version was not yet released but is announced to be in Jan,
2024: https://kernel.org/category/releases.html
---
 README.external.rst              |  2 +-
 compat-include/linux/netdevice.h |  8 --------
 compat-include/linux/stddef.h    | 24 ------------------------
 compat-include/net/cfg80211.h    | 40 ----------------------------------------
 compat-include/net/genetlink.h   | 18 ------------------
 compat.h                         |  7 -------
 6 files changed, 1 insertion(+), 98 deletions(-)

diff --git a/README.external.rst b/README.external.rst
index 58e8fc7a..62a8cf06 100644
--- a/README.external.rst
+++ b/README.external.rst
@@ -12,7 +12,7 @@ and as an external module. The external  module   allows  to  get
 new    features without  upgrading  to  a  newer  kernel  version
 and to get batman-adv specific bug fixes for  kernels  that   are
 not   supported   anymore.  It compiles  against  and should work
-with  Linux 4.14  -  6.5.  Supporting  older  versions   is   not
+with  Linux 4.19  -  6.5.  Supporting  older  versions   is   not
 planned,  but it's probably easy to backport it. If you work on a
 backport, feel free to contact us.  :-)
 
diff --git a/compat-include/linux/netdevice.h b/compat-include/linux/netdevice.h
index 3188ad3d..a489ac9b 100644
--- a/compat-include/linux/netdevice.h
+++ b/compat-include/linux/netdevice.h
@@ -13,14 +13,6 @@
 #include <linux/version.h>
 #include_next <linux/netdevice.h>
 
-#if LINUX_VERSION_IS_LESS(4, 15, 0)
-
-#define netdev_master_upper_dev_link(dev, upper_dev, upper_priv, upper_info, extack) \
-	netdev_master_upper_dev_link(dev, upper_dev, upper_priv, upper_info)
-
-#endif /* LINUX_VERSION_IS_LESS(4, 15, 0) */
-
-
 #if LINUX_VERSION_IS_LESS(5, 15, 0)
 
 static inline void batadv_dev_put(struct net_device *dev)
diff --git a/compat-include/linux/stddef.h b/compat-include/linux/stddef.h
deleted file mode 100644
index c4558f81..00000000
--- a/compat-include/linux/stddef.h
+++ /dev/null
@@ -1,24 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/* Copyright (C) B.A.T.M.A.N. contributors:
- *
- * Marek Lindner, Simon Wunderlich
- *
- * This file contains macros for maintaining compatibility with older versions
- * of the Linux kernel.
- */
-
-#ifndef _NET_BATMAN_ADV_COMPAT_LINUX_STDDEF_H_
-#define _NET_BATMAN_ADV_COMPAT_LINUX_STDDEF_H_
-
-#include <linux/version.h>
-#include_next <linux/stddef.h>
-
-#if LINUX_VERSION_IS_LESS(4, 16, 0)
-
-#ifndef sizeof_field
-#define sizeof_field(TYPE, MEMBER) sizeof((((TYPE *)0)->MEMBER))
-#endif
-
-#endif /* LINUX_VERSION_IS_LESS(4, 16, 0) */
-
-#endif	/* _NET_BATMAN_ADV_COMPAT_LINUX_STDDEF_H_ */
diff --git a/compat-include/net/cfg80211.h b/compat-include/net/cfg80211.h
deleted file mode 100644
index 4bfcd5a3..00000000
--- a/compat-include/net/cfg80211.h
+++ /dev/null
@@ -1,40 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/* Copyright (C) B.A.T.M.A.N. contributors:
- *
- * Marek Lindner, Simon Wunderlich
- *
- * This file contains macros for maintaining compatibility with older versions
- * of the Linux kernel.
- */
-
-#ifndef _NET_BATMAN_ADV_COMPAT_NET_CFG80211_H_
-#define _NET_BATMAN_ADV_COMPAT_NET_CFG80211_H_
-
-#include <linux/version.h>
-#include_next <net/cfg80211.h>
-
-
-#if LINUX_VERSION_IS_LESS(4, 18, 0) && IS_ENABLED(CONFIG_CFG80211)
-
-/* cfg80211 fix: https://patchwork.kernel.org/patch/10449857/ */
-static inline int batadv_cfg80211_get_station(struct net_device *dev,
-					      const u8 *mac_addr,
-					      struct station_info *sinfo)
-{
-	memset(sinfo, 0, sizeof(*sinfo));
-	return cfg80211_get_station(dev, mac_addr, sinfo);
-}
-
-#define cfg80211_get_station(dev, mac_addr, sinfo) \
-	batadv_cfg80211_get_station(dev, mac_addr, sinfo)
-
-#endif /* LINUX_VERSION_IS_LESS(4, 18, 0) && IS_ENABLED(CONFIG_CFG80211) */
-
-
-#if LINUX_VERSION_IS_LESS(4, 18, 0)
-
-#define cfg80211_sinfo_release_content(sinfo)
-
-#endif /* LINUX_VERSION_IS_LESS(4, 18, 0) */
-
-#endif	/* _NET_BATMAN_ADV_COMPAT_NET_CFG80211_H_ */
diff --git a/compat-include/net/genetlink.h b/compat-include/net/genetlink.h
index 05c57ce0..85376044 100644
--- a/compat-include/net/genetlink.h
+++ b/compat-include/net/genetlink.h
@@ -13,24 +13,6 @@
 #include <linux/version.h>
 #include_next <net/genetlink.h>
 
-#if LINUX_VERSION_IS_LESS(4, 15, 0)
-
-static inline
-void batadv_genl_dump_check_consistent(struct netlink_callback *cb,
-				       void *user_hdr)
-{
-	struct genl_family genl_family = {
-		.hdrsize = 0,
-	};
-
-	genl_dump_check_consistent(cb, user_hdr, &genl_family);
-}
-
-#define genl_dump_check_consistent batadv_genl_dump_check_consistent
-
-#endif /* LINUX_VERSION_IS_LESS(4, 15, 0) */
-
-
 #if LINUX_VERSION_IS_LESS(5, 10, 0)
 
 #if LINUX_VERSION_IS_LESS(5, 2, 0)
diff --git a/compat.h b/compat.h
index 8e19f9bb..638bfc54 100644
--- a/compat.h
+++ b/compat.h
@@ -16,13 +16,6 @@
 #include "compat-autoconf.h"
 
 
-#if LINUX_VERSION_IS_LESS(4, 15, 0)
-
-#define batadv_softif_slave_add(__dev, __slave_dev, __extack) \
-	batadv_softif_slave_add(__dev, __slave_dev)
-
-#endif /* LINUX_VERSION_IS_LESS(4, 15, 0) */
-
 #endif /* __KERNEL__ */
 
 #endif /* _NET_BATMAN_ADV_COMPAT_H_ */

---
base-commit: 5fecd4a389cea1b9719e9ec480d7257887e0dfdf
change-id: 20231104-drop-compat-4-14-1bba04bac963

Best regards,
-- 
Sven Eckelmann <sven@narfation.org>

