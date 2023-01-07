Return-Path: <b.a.t.m.a.n-bounces@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38A7AC54EBC;
	Sat,  7 Jan 2023 13:14:04 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 7778E846E9;
	Sat,  7 Jan 2023 14:14:00 +0100 (CET)
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 42EB88143B
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sat,  7 Jan 2023 14:13:57 +0100 (CET)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1673097237;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:dkim-signature;
	bh=mCCJ7vDUseFHAotQYO62pol7LVpV3jR78Z6rXkiKpf8=;
	b=A1qs3LQKF9ryrP9NNwqZH3HFbHOpzTw7AS5li21lQNzbVbKlr86gM8eH+8muaLqJZZpBRk
	U2HIOw2MhhlULa2h2ysW75NE7I89EFHkq5Oa2Kn6Ykd8FWEmYsC81s5rHZFTJ1M0uwk5xH
	ZsaCKgeOW2wkBy50wu7S0HIYfL+7PBU=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=x5n6pcEo;
	dmarc=pass (policy=none) header.from=narfation.org;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1673097237; a=rsa-sha256;
	cv=none;
	b=ez2x4hLEuecMebuXiaVUYsv9ZKEcGdZPOFSMZCt0a1oln6D8RrtvUh65yxLAQrg3FL7Lvp
	A3sgANir6navAxuJv7oBCxZSybTOjdvVWA6yMZKpwUM4b/KROzsudZZGtPOxUphRqMPAiq
	P+VaDqTeR9byA7DoWQkX26LJ1fu2+zM=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1673097236;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=mCCJ7vDUseFHAotQYO62pol7LVpV3jR78Z6rXkiKpf8=;
	b=x5n6pcEodgbmygrwMLfiXbMcoEtOQmus/pWZdPYqX4/9/cBjUGhc7HkZC7CQPqKoFuL9XK
	yGY6d0GU1nw46oHWscOpGSJaraDMeFGnIaKrLwxkdftBavfOI/5xNAEeuziEdMT43rF06K
	XYe9UnuA2ES2NIrhDQCbdGqT3X+jTRA=
From: Sven Eckelmann <sven@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
Subject: [PATCH] batman-adv: Drop support for Linux < 4.14
Date: Sat,  7 Jan 2023 14:13:30 +0100
Message-Id: <20230107131330.1746092-1-sven@narfation.org>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Message-ID-Hash: 2KC355NKC7BWNAIDT5KRJIM2QS3GVWLR
X-Message-ID-Hash: 2KC355NKC7BWNAIDT5KRJIM2QS3GVWLR
X-MailFrom: sven@narfation.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-b.a.t.m.a.n.lists.open-mesh.org-0; header-match-b.a.t.m.a.n.lists.open-mesh.org-1; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
X-Mailman-Version: 3.2.1
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/2KC355NKC7BWNAIDT5KRJIM2QS3GVWLR/>
List-Archive: <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

The Linux Kernel 4.9 reached its end of life [1] after 6 years. Instead i=
t
is recommended to use at least kernel 4.14. It is also over 5 years
old but still maintained by the stable kernel team. All older kernels
(4.9 - v4.13) will be dropped to reduce the support overhead.

[1] https://lore.kernel.org/r/Y7lbu6%2F0P7Q%2FP3oj@kroah.com

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
@@ -12,7 +12,7 @@ and as an external module. The external  module   allow=
s  to  get
 new    features without  upgrading  to  a  newer  kernel  version
 and to get batman-adv specific bug fixes for  kernels  that   are
 not   supported   anymore.  It compiles  against  and should work
-with  Linux 4.9  -  6.1.  Supporting  older   versions   is   not
+with  Linux 4.14  -  6.1.  Supporting  older  versions   is   not
 planned,  but it's probably easy to backport it. If you work on a
 backport, feel free to contact us.  :-)
=20
diff --git a/compat-include/linux/build_bug.h b/compat-include/linux/buil=
d_bug.h
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
- * This file contains macros for maintaining compatibility with older ve=
rsions
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
- * also identified itself with the version number 4.9.255 when decoding =
the
- * LINUX_VERSION_CODE. So we have to try to guess now if we need to incl=
ude
- * linux/build_bug.h based on whether BUILD_BUG_ON is defined  or not af=
ter
- * including linux/bug.h
- */
-#ifndef BUILD_BUG_ON
-#include_next <linux/build_bug.h>
-#endif
-
-#endif
-
-#endif /* _NET_BATMAN_ADV_COMPAT_LINUX_BUILD_BUG_H_ */
diff --git a/compat-include/linux/netdevice.h b/compat-include/linux/netd=
evice.h
index eeb31bed..3188ad3d 100644
--- a/compat-include/linux/netdevice.h
+++ b/compat-include/linux/netdevice.h
@@ -20,25 +20,6 @@
=20
 #endif /* LINUX_VERSION_IS_LESS(4, 15, 0) */
=20
-#if LINUX_VERSION_IS_LESS(4, 11, 9)
-
-/* work around missing attribute needs_free_netdev and priv_destructor i=
n
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
-#define needs_free_netdev destructor =3D batadv_softif_free2; t2
-#define priv_destructor destructor =3D batadv_softif_free2; t1
-
-#endif /* LINUX_VERSION_IS_LESS(4, 11, 9) */
-
=20
 #if LINUX_VERSION_IS_LESS(5, 15, 0)
=20
diff --git a/compat-include/linux/prandom.h b/compat-include/linux/prando=
m.h
index dc227e61..ec2f5244 100644
--- a/compat-include/linux/prandom.h
+++ b/compat-include/linux/prandom.h
@@ -12,7 +12,6 @@
=20
 #include <linux/version.h>
 #if LINUX_VERSION_IS_GEQ(5, 8, 1) || \
-    (LINUX_VERSION_IS_GEQ(4, 9, 233) && LINUX_VERSION_IS_LESS(4, 10, 0))=
 || \
     (LINUX_VERSION_IS_GEQ(4, 14, 193) && LINUX_VERSION_IS_LESS(4, 15, 0)=
) || \
     (LINUX_VERSION_IS_GEQ(4, 19, 138) && LINUX_VERSION_IS_LESS(4, 20, 0)=
) || \
     (LINUX_VERSION_IS_GEQ(5, 4, 57) && LINUX_VERSION_IS_LESS(5, 5, 0)) |=
| \
diff --git a/compat-include/linux/skbuff.h b/compat-include/linux/skbuff.=
h
index 77c4e99f..eda2d181 100644
--- a/compat-include/linux/skbuff.h
+++ b/compat-include/linux/skbuff.h
@@ -13,35 +13,6 @@
 #include <linux/version.h>
 #include_next <linux/skbuff.h>
=20
-#if LINUX_VERSION_IS_LESS(4, 13, 0)
-
-static inline void *batadv_skb_put(struct sk_buff *skb, unsigned int len=
)
-{
-	return (void *)skb_put(skb, len);
-}
-#define skb_put batadv_skb_put
-
-static inline void *skb_put_zero(struct sk_buff *skb, unsigned int len)
-{
-	void *tmp =3D skb_put(skb, len);
-
-	memset(tmp, 0, len);
-
-	return tmp;
-}
-
-static inline void *skb_put_data(struct sk_buff *skb, const void *data,
-				 unsigned int len)
-{
-	void *tmp =3D skb_put(skb, len);
-
-	memcpy(tmp, data, len);
-
-	return tmp;
-}
-
-#endif /* LINUX_VERSION_IS_LESS(4, 13, 0) */
-
 #if LINUX_VERSION_IS_LESS(5, 4, 0)
=20
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
- * This file contains macros for maintaining compatibility with older ve=
rsions
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
diff --git a/compat-include/uapi/linux/if_ether.h b/compat-include/uapi/l=
inux/if_ether.h
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
- * This file contains macros for maintaining compatibility with older ve=
rsions
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
=20
 #include "compat-autoconf.h"
=20
-#if LINUX_VERSION_IS_LESS(4, 13, 0)
-
-#define batadv_softif_validate(__tb, __data, __extack) \
-	batadv_softif_validate(__tb, __data)
-
-#define batadv_softif_newlink(__src_net, __dev, __tb, __data, __extack) =
\
-	batadv_softif_newlink(__src_net, __dev, __tb, __data)
-
-#endif /* LINUX_VERSION_IS_LESS(4, 13, 0) */
-
=20
 #if LINUX_VERSION_IS_LESS(4, 15, 0)
=20

base-commit: a15d3f3c1c2a7c8439643ed37c937750122246b7
--=20
2.39.0
