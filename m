Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C5A1C4167B
	for <batman@archiver.kernel.org>; Mon, 13 Nov 2023 17:41:50 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 5184F83B87
	for <batman@archiver.kernel.org>; Mon, 13 Nov 2023 18:41:48 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1699897308;
 b=cZJezPVR4UWiP9YK9O9DjpswxE5mmDwwoAKeK1RjF7SNWd7dHQI4i7baoxAagfnTRXkqS
 YAaZQgJndWmBJPFeR2gOElxQkViYRXoiArN9U4resr9RZLa9k2Tegb89qM6sTqQOc/49zZt
 9yDiHR8Y/C9EZ98LeZKrZR7UargPNso=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1699897308; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=gCgt63eG86yDZGLMKoHnO/fF1ixsc6UWu2hW7IjPg3A=;
 b=BpsR1TAfE9JY9f90b/L5B3sA5qzbg1HhBgfoy3RFjI8siiKLDIyvHxnBzRhL9xdZIbRr8
 VT2c84zbRsj2vVQxFmUA8Ix8juhIkuUV+jwxwzmxO2wF7x9qrfcubjAh/ecxBXvNc7vRhUl
 XQuW2ieJjjmnOMArvP1kW56gNvBvYvo=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
  arc=pass;
  dmarc=pass (Used From Domain Record) header.from=narfation.org
 policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 3D76280467
	for <b.a.t.m.a.n@lists.open-mesh.org>; Mon, 13 Nov 2023 18:41:43 +0100 (CET)
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1699897303; a=rsa-sha256;
	cv=none;
	b=dDT0/dVg4vSZ87CMFmfUyRe7ovGQ+rZEA9O2OmUlsytGvYtyH1eODhT+pTyFBVP/W91rq+
	dNxlIP203q93nYeWtT632zQOv+lIbhO49AuwYDLdYEFGDU0XBz7fEFXD3Kj4hpA4A0iV0a
	X7GG4ZFZWoqWyAC34fdTfmhjR4VyQpE=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=nonDqOh2;
	dmarc=pass (policy=none) header.from=narfation.org;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1699897303;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:dkim-signature;
	bh=gCgt63eG86yDZGLMKoHnO/fF1ixsc6UWu2hW7IjPg3A=;
	b=DL3E5X0IPS9axuLZxDG4Jrllurw3zKfG2qOz8DkCmKwU/qUbd1NjSyQGGHB71OzpQLSX/A
	m+Awx5j2ox9+fF6xc3eKi+pWI2JlkfTQBlDLjVQrapeTNG/3xaqM00gHHazGcA0NwQcfAW
	YPodzXGBtZdGmkV9HlrrqXWO8DGh7B8=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1699897302;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=gCgt63eG86yDZGLMKoHnO/fF1ixsc6UWu2hW7IjPg3A=;
	b=nonDqOh2wLfu63vIW9oDS3obkNT/FJVCIBVPj0gmrph7YYJsB2MpLDiwjR4xwE/ySKUZop
	0kK1L4y/xdzqD7nX6OUlZG8tWsj9Blke1NaH7d+nCPiXYUWNeDX7JGQa20NljINRsKbG/U
	k2FSa/LZInbH32VDOBSVpqwzE+9c4HE=
From: Sven Eckelmann <sven@narfation.org>
Date: Mon, 13 Nov 2023 18:41:19 +0100
Subject: [PATCH] batman-adv: Switch to linux/array_size.h
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231113-new-6-7-headers-v1-1-80b1492175c2@narfation.org>
X-B4-Tracking: v=1; b=H4sIAL5fUmUC/x3MPQqAMAxA4atIZgMmxd+riENpo2ap0oIK0rtbH
 L/hvReSRJUEU/VClEuTHqGA6grcbsMmqL4YuGFDRAaD3Nhhj7tYLzEhWzcMjfEtjwylOqOs+vz
 Hecn5AzNpm7thAAAA
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2466; i=sven@narfation.org;
 h=from:subject:message-id; bh=NT6QNcD1LhPPifWxHURqvQ8XT4iBF1PnrA+tibrs8HU=;
 b=owEBbQKS/ZANAwAKAV2HCgfBJntGAcsmYgBlUl/TbP7pzhpH6H0tbz/FJvFohMrqlL+WFBKvS
 CcsML/IosmJAjMEAAEKAB0WIQQXXSuHYSVz3OMy4AJdhwoHwSZ7RgUCZVJf0wAKCRBdhwoHwSZ7
 RtGyEACkSh+pjNKz1XWYDW5EsFve9Vj0gKGXIOf3E5mXTrDmZzoeMix2tZanNdlOyZr+v/m0KXT
 QxqoURJnSUdehNHQ0rbetNvafPwnRyANn6WvH3LOFyR/JO/Vab2PrER3FjeiXKwEj8Pn6dRBckJ
 93gZ/NQGYTkYmJT+9miQHuPEavDML9s+TJBCNF4PXXGSWvI+PRJqs9uLMvEfT1o0QfyceQynSkE
 9Ym/jqYOUzJ+r4eaEDNvQ9sdGpDITZzUhjg0nCbfOhs7oG4TBVMNjx0udOih5cILLXVDoBibyZO
 Hn7YwYOstdGJQTzmYsazQvzzyuJ0OMzNnWnHxn9c9qkO0htSRC9IjBpUuIg+l82UTsvucfJAEoE
 lBmZmVE0ZeFvkTJNkajhhCAlZz4asz68br/B/xcji5Ew1z3xuQE9azhxhq4F9uX0mZxwBkXUgUn
 uGIkm6x6dqz/gXPXvr71Yd4Td0i94kuqY53OsCLKpDPWPG92HjJIt8q4/Eca2GAuKiKXwajlQ31
 sP0x/2i9qR9f9uQENgiEJzmp1dmwCjX0B+Qi7XnPLZh3zFiOuYEMIcOxjs2PXA5UvVo/YGkgI2J
 ubGsLMWKZxuVIguM6/6LpKObGDy+kPgDHkOe/jzZv0aLDTsPWcHKnroV5wQNDcPmi/4hD7NNoqs
 T90iByLVeUjjWFw==
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: AY6HOK2XH6FW444FOC6DVJHMMF6VO3LX
X-Message-ID-Hash: AY6HOK2XH6FW444FOC6DVJHMMF6VO3LX
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/AY6HOK2XH6FW444FOC6DVJHMMF6VO3LX/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

The commit 3cd39bc3b11b ("kernel.h: Move ARRAY_SIZE() to a separate
header") introduced a new header for the ARRAY_SIZE macro which was
previously exposed via linux/kernel.h.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 compat-include/linux/array_size.h | 20 ++++++++++++++++++++
 net/batman-adv/main.c             |  2 +-
 net/batman-adv/netlink.c          |  2 +-
 3 files changed, 22 insertions(+), 2 deletions(-)

diff --git a/compat-include/linux/array_size.h b/compat-include/linux/array_size.h
new file mode 100644
index 00000000..824ad011
--- /dev/null
+++ b/compat-include/linux/array_size.h
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
+#ifndef _NET_BATMAN_ADV_COMPAT_LINUX_ARRAY_SIZE_H_
+#define _NET_BATMAN_ADV_COMPAT_LINUX_ARRAY_SIZE_H_
+
+#include <linux/version.h>
+#if LINUX_VERSION_IS_GEQ(6, 7, 0)
+#include_next <linux/array_size.h>
+#else
+#include <linux/kernel.h>
+#endif
+
+#endif /* _NET_BATMAN_ADV_COMPAT_LINUX_ARRAY_SIZE_H_ */
diff --git a/net/batman-adv/main.c b/net/batman-adv/main.c
index e8a44991..357b3a6a 100644
--- a/net/batman-adv/main.c
+++ b/net/batman-adv/main.c
@@ -6,6 +6,7 @@
 
 #include "main.h"
 
+#include <linux/array_size.h>
 #include <linux/atomic.h>
 #include <linux/build_bug.h>
 #include <linux/byteorder/generic.h>
@@ -20,7 +21,6 @@
 #include <linux/init.h>
 #include <linux/ip.h>
 #include <linux/ipv6.h>
-#include <linux/kernel.h>
 #include <linux/kobject.h>
 #include <linux/kref.h>
 #include <linux/list.h>
diff --git a/net/batman-adv/netlink.c b/net/batman-adv/netlink.c
index 2b3da616..cda99753 100644
--- a/net/batman-adv/netlink.c
+++ b/net/batman-adv/netlink.c
@@ -7,6 +7,7 @@
 #include "netlink.h"
 #include "main.h"
 
+#include <linux/array_size.h>
 #include <linux/atomic.h>
 #include <linux/bitops.h>
 #include <linux/bug.h>
@@ -20,7 +21,6 @@
 #include <linux/if_ether.h>
 #include <linux/if_vlan.h>
 #include <linux/init.h>
-#include <linux/kernel.h>
 #include <linux/limits.h>
 #include <linux/list.h>
 #include <linux/minmax.h>

---
base-commit: 5fecd4a389cea1b9719e9ec480d7257887e0dfdf
change-id: 20231113-new-6-7-headers-2ac8803d5292

Best regards,
-- 
Sven Eckelmann <sven@narfation.org>

