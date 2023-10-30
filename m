Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F11FC4332F
	for <batman@archiver.kernel.org>; Mon, 30 Oct 2023 15:28:16 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 4648B82ECC
	for <batman@archiver.kernel.org>; Mon, 30 Oct 2023 16:28:14 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1698679694;
 b=FrJIDbvYvR1tNcFGiWxKzKCVFq924rS2pY5VzZaJRRbPQcbDq8GR00JklWVLaxS6w5G2E
 n5fjpdRXFrQqcPa0X3OPW15khd3QYtaNXWQtD2dn3tLNVjslMGTFElsoEV75PhgXULA6mYz
 7DUxNuMYLh9Kpbr789PE6A4+TJAUssQ=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1698679694; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=X7mlZOjbCntUhpYkXClNLB70GlWossq38yXxpwQz0Kc=;
 b=BgaxSGCRjW4EBUpR8e2Fq+O2x+YWO6FIKwl82JkH1beOjMGyz8Bt7PNMdKO73TJL80KUB
 WHkdioRjjxHVcKddntpbNYLGlYUNcmeoiRoRwPYOUAJZza+ie3QxCNct3+15/evumcl4bJu
 uGRWOSJswDk/QhFEvJaPibwl780YwaI=
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
	by diktynna.open-mesh.org (Postfix) with ESMTPS id CD5F8802B8
	for <b.a.t.m.a.n@lists.open-mesh.org>; Mon, 30 Oct 2023 16:28:08 +0100 (CET)
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1698679689; a=rsa-sha256;
	cv=none;
	b=EH+OERk1su2gQ3x/8CZE0CN91/QrZmcpNoiJ4TRKKi4EfCJfgQ+Hj9wHZ6tPFXMbCcXP+/
	4ju4BPi5Q6/05eh3dHgWAtPFfJNqz11ugFxIPlUOYWgaAo9t1c9rjZHX87NKfrwMCFpH3x
	/blY1IdLWru8WdUIP564HhKwWj438Qk=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=s9XnzBmA;
	dmarc=pass (policy=none) header.from=narfation.org;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1698679689;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:dkim-signature;
	bh=X7mlZOjbCntUhpYkXClNLB70GlWossq38yXxpwQz0Kc=;
	b=oLeQFN+vRKC8eaf7awqw8aJgfIxWwHAQ9L+UXZRvGE9d/CGUWMZb3J4KOUand8CQBF72vQ
	v6Pg5hW7Y8O0l3MfvFRhMahTSL651QNYHWb29H1hbyF0kf0IYqGmWjb5/4Kp3CEfAQt7Oj
	JSYIsVJEj6vqoVz/1qn/FD+pk3hQ0Uo=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1698679688;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=X7mlZOjbCntUhpYkXClNLB70GlWossq38yXxpwQz0Kc=;
	b=s9XnzBmAIr2x44UcCl1MShYWrNdgPf7n/30lBtSPJaJVONlS53lwfvLSK6RIF1oUS62BqJ
	RTtEOoHoiBwm2jJ8K/r8JL0yXRuhdh+0ugk0pHwXfSxoZlnhuoSrx//j4HC4eCP9Ga3KzN
	YAmnB482eveokQi+cBzLct+D1B3/V3k=
From: Sven Eckelmann <sven@narfation.org>
Date: Mon, 30 Oct 2023 16:28:02 +0100
Subject: [PATCH v2] batman-adv: Switch to linux/sprintf.h
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231030-sprintf_header-v2-1-a5b4041f55b4@narfation.org>
X-B4-Tracking: v=1; b=H4sIAILLP2UC/3WOywqDMBBFf0Vm3ZQ8NFZX/Y8iJTQTnU2USQgt4
 r83dd/lOXAPd4eETJhgbHZgLJRojRX0pYHX4uKMgnxl0FIbJY0UaWOKOTwXdB5ZtL23nTV2aO0
 N6mhjDPQ+g4+p8kIpr/w5+0X97N9UUUIJ3RvprRk64/EeHQeX66PryjNMx3F8Aal4heOwAAAA
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=3874; i=sven@narfation.org;
 h=from:subject:message-id; bh=i6e21iqYAadG67nVRfpEcJ5gNi8e/5IushVboRahhZY=;
 b=owEBbQKS/ZANAwAKAV2HCgfBJntGAcsmYgBlP8uDXj64PwkZQjViawTBpCPjmt0JAvAQx3tK1
 bHET/VA1i6JAjMEAAEKAB0WIQQXXSuHYSVz3OMy4AJdhwoHwSZ7RgUCZT/LgwAKCRBdhwoHwSZ7
 RqXUEAC/k6Ocy/YoN6gMB7Utmf4pdi7DpCWHKO5PTAUlefn9PNZ733NwiI8FXR0utf6deiVZMjJ
 p8KCQF9Wu34hhbY4Fy0AqG4iCqxwVCZ0JQZYYxlWEGWBRwnpyRfUI0AQsz1f/noUSmfMRhSYl3/
 rI5v5ikc3ZXvnQh5zJBVQb+xgOeOHEejUDS8vEItXCDqg/ipQQkSvNVzhHSQtxn8c5kiH4YVKxe
 KG/lDLUXAhRogvqWACjKY5Z5vDs/XCpG6/8axXjHMWX13gVyTzoYI1sAmOhoLBJhoRdT4pXiXZu
 XfmjhfiL2jqO5cmcyLGrupsL1M2K416RRtVstfiqqfxgy31aY4U8SIYTw43Yy9xB8PGY9tv9f0U
 tPsRmd4rzk3WuWG8le2b9txW+xpFFrJkvImBfWIP2LJc9W4wAf3XgWdfCf0tbdymeb7nOCn/9ZN
 cbD1WkClQytoR3eWtrsv/0dJYkXWgAG4GWhRQsETAfQdeOl5NGUP69yl+sas7MmxdGHNLrsW3zq
 r6pzthf2jktTdPIeHNMMbaG55OrFlGzBTTHiUhZY/ii98Vhujj8r3TvnoeuJyO+bj/KjLZ0pKou
 wLHd61dbJ0HMjNPfXLReQ+lCDU+bUra01lt22uTJL6xk5wmRnsyfyv09dlAF9Arl7nJQRVOA/QM
 roeS1BQXq3jnnow==
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: 3RW4LWGQQTMN2KZP2GCEAWTSAWKAONP7
X-Message-ID-Hash: 3RW4LWGQQTMN2KZP2GCEAWTSAWKAONP7
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/3RW4LWGQQTMN2KZP2GCEAWTSAWKAONP7/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

The commit 39ced19b9e60 ("lib/vsprintf: split out sprintf() and friends")
introduced a new header for the sprintf related functions which were
previously exposed via linux/kernel.h.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
Changes in v2:
- version for out-of-tree kernel with compat header
- Link to v1: https://lore.kernel.org/r/20231030-sprintf_header-v1-1-2730d63953de@narfation.org
---
 compat-include/linux/sprintf.h         | 20 ++++++++++++++++++++
 net/batman-adv/bridge_loop_avoidance.c |  2 +-
 net/batman-adv/gateway_client.c        |  2 +-
 net/batman-adv/main.c                  |  1 +
 net/batman-adv/multicast.c             |  2 +-
 5 files changed, 24 insertions(+), 3 deletions(-)

diff --git a/compat-include/linux/sprintf.h b/compat-include/linux/sprintf.h
new file mode 100644
index 00000000..d3823277
--- /dev/null
+++ b/compat-include/linux/sprintf.h
@@ -0,0 +1,20 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (C) B.A.T.M.A.N. contributors:
+ *
+ * Marek Lindner, Simon Wunderlich
+ *
+ * This file contains macros for maintaining compatibility with older versions
+ * of the Linux kernel.
+ */
+
+#ifndef _NET_BATMAN_ADV_COMPAT_LINUX_SPRINTF_H_
+#define _NET_BATMAN_ADV_COMPAT_LINUX_SPRINTF_H_
+
+#include <linux/version.h>
+#if LINUX_VERSION_IS_GEQ(6, 6, 0)
+#include_next <linux/sprintf.h>
+#else
+#include <linux/kernel.h>
+#endif
+
+#endif /* _NET_BATMAN_ADV_COMPAT_LINUX_SPRINTF_H_ */
diff --git a/net/batman-adv/bridge_loop_avoidance.c b/net/batman-adv/bridge_loop_avoidance.c
index 37ce6cfb..5f46ca3d 100644
--- a/net/batman-adv/bridge_loop_avoidance.c
+++ b/net/batman-adv/bridge_loop_avoidance.c
@@ -20,7 +20,6 @@
 #include <linux/if_vlan.h>
 #include <linux/jhash.h>
 #include <linux/jiffies.h>
-#include <linux/kernel.h>
 #include <linux/kref.h>
 #include <linux/list.h>
 #include <linux/lockdep.h>
@@ -31,6 +30,7 @@
 #include <linux/skbuff.h>
 #include <linux/slab.h>
 #include <linux/spinlock.h>
+#include <linux/sprintf.h>
 #include <linux/stddef.h>
 #include <linux/string.h>
 #include <linux/workqueue.h>
diff --git a/net/batman-adv/gateway_client.c b/net/batman-adv/gateway_client.c
index d26124bc..0ddd8b4b 100644
--- a/net/batman-adv/gateway_client.c
+++ b/net/batman-adv/gateway_client.c
@@ -18,7 +18,6 @@
 #include <linux/in.h>
 #include <linux/ip.h>
 #include <linux/ipv6.h>
-#include <linux/kernel.h>
 #include <linux/kref.h>
 #include <linux/list.h>
 #include <linux/lockdep.h>
@@ -29,6 +28,7 @@
 #include <linux/skbuff.h>
 #include <linux/slab.h>
 #include <linux/spinlock.h>
+#include <linux/sprintf.h>
 #include <linux/stddef.h>
 #include <linux/udp.h>
 #include <net/sock.h>
diff --git a/net/batman-adv/main.c b/net/batman-adv/main.c
index e8a44991..928c78a5 100644
--- a/net/batman-adv/main.c
+++ b/net/batman-adv/main.c
@@ -33,6 +33,7 @@
 #include <linux/skbuff.h>
 #include <linux/slab.h>
 #include <linux/spinlock.h>
+#include <linux/sprintf.h>
 #include <linux/stddef.h>
 #include <linux/string.h>
 #include <linux/workqueue.h>
diff --git a/net/batman-adv/multicast.c b/net/batman-adv/multicast.c
index 27511a06..7686caef 100644
--- a/net/batman-adv/multicast.c
+++ b/net/batman-adv/multicast.c
@@ -25,7 +25,6 @@
 #include <linux/ip.h>
 #include <linux/ipv6.h>
 #include <linux/jiffies.h>
-#include <linux/kernel.h>
 #include <linux/list.h>
 #include <linux/lockdep.h>
 #include <linux/netdevice.h>
@@ -36,6 +35,7 @@
 #include <linux/skbuff.h>
 #include <linux/slab.h>
 #include <linux/spinlock.h>
+#include <linux/sprintf.h>
 #include <linux/stddef.h>
 #include <linux/string.h>
 #include <linux/types.h>

---
base-commit: 5fecd4a389cea1b9719e9ec480d7257887e0dfdf
change-id: 20231030-sprintf_header-47d656369468

Best regards,
-- 
Sven Eckelmann <sven@narfation.org>

