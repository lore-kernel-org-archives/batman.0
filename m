Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C19B3C47073
	for <batman@archiver.kernel.org>; Wed, 10 Jan 2024 21:14:54 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id B3B1483E0F
	for <batman@archiver.kernel.org>; Wed, 10 Jan 2024 22:14:52 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1704921292;
 b=JZtOxSNm1B17XmtBuzPBvbq51UKx2E++FnwyhhQ4xIzW58YH6IsgjtQ0yYIsLeUNN7v10
 j6xkWK2Dqi0/GyT2iX6KA+R/H32QuMy2nM5Ev8Ez92MebTitejUKRQNGFERZBCHiX1nkSm+
 QBgKMwSBcZOXZp68D/XmsOwXMXbF1BY=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1704921292; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=gNUTWf6EeLOiC1AD5s+ZM0YW2AqE6VjQaGxpJGZN33s=;
 b=Oi0pmpKhlZeYSG7FJc9+P4lnsVlSA7gsriN31EAnCrw8EauExCrOx6y/7gvrIMBsSdlFk
 wXDvYi2c14rj5hp/P02vPF4cq0emDzMEJiAX+bAmTU30rZKQ+NiAUoqeKvnJF90263ic9oo
 gFw+GNAgozw5QKuqvqRihK74SM3rNnU=
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
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 008F380C67
	for <b.a.t.m.a.n@lists.open-mesh.org>; Wed, 10 Jan 2024 22:14:45 +0100 (CET)
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1704921286; a=rsa-sha256;
	cv=none;
	b=inSU/3qK49I6IurXzrQGbO9mbg3xtyPXZDwUbdTwKeKuVhSows0CCnUuIAHFghCpqVP6iX
	MM3NitDgFEmGWyyyYYVKhadAisDoRiLmiE3/sWHqRiLAueJCUPyfyrF4oPkX6OF3PXLIGE
	GeUUfSOLCMNEHcqmsZsRQz9B7RFIVJs=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=ZiVEYdO4;
	dmarc=pass (policy=none) header.from=narfation.org;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1704921286;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:dkim-signature;
	bh=gNUTWf6EeLOiC1AD5s+ZM0YW2AqE6VjQaGxpJGZN33s=;
	b=xdNpAvVf4KitatN/bBWWVrHbKPOhzzYDNq8nQTETsvTJoLwyYtqhdfuA8TuiyzgOVCj3Z0
	EBgl5R49M+CjLGku4KZeJT33eEHkxXtCXYOs/LBbf602+QhOgOfJMhsA7+BT423VogXhVo
	eXjncm8TqG6qN9VHDzVyq8DC3bAhTzY=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1704921285;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=gNUTWf6EeLOiC1AD5s+ZM0YW2AqE6VjQaGxpJGZN33s=;
	b=ZiVEYdO4lipS7l/tkgq14rfiEDG+TdXodVefJtPMvRA12pmxDordrHGMKOX0eoJKQ+6CeO
	p2Tmsm1bLOxOAMCIgysyPlkJMtLEbEEcdrWXGBIja3HZwbH8I85Oc0ZAS3YvA3pLZvmCEa
	90kvUbtE0Ravt/Ms8HPizjgFsIAMB+I=
From: Sven Eckelmann <sven@narfation.org>
Date: Wed, 10 Jan 2024 22:14:37 +0100
Subject: [PATCH v2] batman-adv: Drop support for Linux < 4.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240110-drop-compat-4-14-v2-1-0581c371c90f@narfation.org>
X-B4-Tracking: v=1; b=H4sIALwIn2UC/32OTQqDMBCFryKz7hQnxkK76j3ERf7ULJqESQgt4
 t2beoDC23wP3s8O2bF3GR7dDuyqzz6GBuLSgdlUWB162xhELwaiXqLlmNDEV1IFJVKT1qqXWpn
 7bYAWS+wW/z4rp7nx5nOJ/DkXKv3cP2WVkNAKOQ6azGLl+AyKF1Xaq2vkFebjOL5bhOsRtAAAA
 A==
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=5971; i=sven@narfation.org;
 h=from:subject:message-id; bh=oybuCQFwgupWzc43MNHwE45v1UGF4d4s9UGjtqoZcUo=;
 b=owEBbQKS/ZANAwAKAV2HCgfBJntGAcsmYgBlnwjAOgVMhSzWayas0Po0DREEM0fgkGl2NMSm9
 gGj1JKpVjSJAjMEAAEKAB0WIQQXXSuHYSVz3OMy4AJdhwoHwSZ7RgUCZZ8IwAAKCRBdhwoHwSZ7
 RvlZEADElN8AiDlveupCoMZRC7tqgHmhqg3hlrKBW87gsy4a4KUTCjs/g05S9m39MV91BqRUzNc
 jhKQvElmJbzgmNMd13LL1mRusDG4uMhbHg5UKffEr3khnrLlBhAm7rFxcUUAzrl4HtSnyDgYRXx
 9dNmHQFaX2AktAhBy3SVRbnTMrslUGcZEtdVLPJfEqwJMtDYahZz5XhosRaDpet/bJPa9pE43UY
 IkZJ+01ThhUZumNS7A2sN0gVYlJHWf76+swwZMgBFpsAKGSaVBmxOFTT5hsV/5wITMYh4urscNS
 kN7bQzkVWf1yc9J1BRGGTOqQ9s74B7fiavOmyRNRP0eRjgG2DEgqZbpA0eMZyjgW8CtKJW1pLjH
 KBZmrXnSNxSjwGX3t2b05yej93YOS6qUS8NcbXx+LGTL8E+Uahktn1cRHjcL9kN7GGV23/d3H/Z
 3eGhghYqpiX5m64108qITNq9jRVbrNAyTCfCqXNDOy4aUdsPdeoYAokAeRL5/wvqou3sGoCnLar
 Jz6OndG5wua1P0Oa6yQx3hGfjEGPc0wNYgSvARrkkdu2Q2Ro0Wqr5uScVdLUVicTypn+dsq9e+K
 3IohR8eZ1LAnOrMaxUTSFV0z2e2hA2rtXjtSPJTFeiSHiq3JrE091hW12/Z9V5WDmyyLloVjQCX
 r7q9rNdiofLLr0g==
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: TRPJX6LQIMT77DRGZ4JCMPQLVXX6NYOG
X-Message-ID-Hash: TRPJX6LQIMT77DRGZ4JCMPQLVXX6NYOG
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/TRPJX6LQIMT77DRGZ4JCMPQLVXX6NYOG/>
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

[1] https://lore.kernel.org/r/2024011046-ecology-tiptoeing-ce50@gregkh/

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
Changes in v2:
- Add EOL announcement URL to commit message
- Fix conflict in README.external.rst
- Link to v1: https://lore.kernel.org/r/20231104-drop-compat-4-14-v1-1-d2453b1cfd45@narfation.org
---
 README.external.rst              |  2 +-
 compat-include/linux/netdevice.h |  8 --------
 compat-include/linux/stddef.h    | 24 ------------------------
 compat-include/net/cfg80211.h    | 40 ----------------------------------------
 compat-include/net/genetlink.h   | 18 ------------------
 compat.h                         |  7 -------
 6 files changed, 1 insertion(+), 98 deletions(-)

diff --git a/README.external.rst b/README.external.rst
index 3b014af8..4e1de973 100644
--- a/README.external.rst
+++ b/README.external.rst
@@ -12,7 +12,7 @@ and as an external module. The external  module   allows  to  get
 new    features without  upgrading  to  a  newer  kernel  version
 and to get batman-adv specific bug fixes for  kernels  that   are
 not   supported   anymore.  It compiles  against  and should work
-with  Linux 4.14  -  6.7.  Supporting  older  versions   is   not
+with  Linux 4.19  -  6.7.  Supporting  older  versions   is   not
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
base-commit: e6fbde1250b73c3c9f49fc5a22ad9a8b10f864d5
change-id: 20231104-drop-compat-4-14-1bba04bac963

Best regards,
-- 
Sven Eckelmann <sven@narfation.org>

