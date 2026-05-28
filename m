Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10856CD4F54
	for <batman-adv@archiver.kernel.org>; Thu, 28 May 2026 14:30:01 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 2F1D483ED1
	for <batman-adv@archiver.kernel.org>; Thu, 28 May 2026 16:29:59 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1779978599;
 b=HZtH6a4QT3JJN+EHIgb3/srG+IG1bDvbzjIJAXGLCeKW116Wi9ZHLY8dvPA4nhPcUY7iI
 EcCNpA6/8auwc/LV34RCgPFolXdUAJlZ6NrzKj8tsukw4XA1B6iMYbuILyOq3YcOWS5jsUx
 vwtY96M/w5JsDeQb05X9TvnnPCPbx9A=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1779978599; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=LWv8MafdPzKxu026SvAgMIOfMz0Utuf87oDhnSVFpeA=;
 b=w04aTHszPXVGjJ5DOUqAAfjom/7D94MH2m4FAR5Bz5SLxxsqY8zZ79KrFnwtiXzGLuO/R
 qcZtEK3c+h1af1iAI7EGqOfFTaHTeoWK/QsFCAwjuvtm+3xuT3jC2Z+ecUr+82TFoiTaSEV
 hlI1BD59ktciDrb+/ct+bdz09RUw/Us=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass header.from=simonwunderlich.de policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=simonwunderlich.de policy.dmarc=none
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 6944E835FB
	for <b.a.t.m.a.n@lists.open-mesh.org>; Thu, 28 May 2026 16:29:29 +0200 (CEST)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1779978569;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=LWv8MafdPzKxu026SvAgMIOfMz0Utuf87oDhnSVFpeA=;
	b=hHFO5nmHjLVS6foUWa3ymNgg86EI3N9Erswt6rsf6Y+tryj8Ycv1tkFKvfZqU8TABBdcnS
	ZUkTGEs6ZImAW0EhbSLfsAyBWHv2eCP2p6EbRSWuf7EGc+NX1OMVBUrY5hbRUWqvnm9X0h
	xKD6TAfP+Wd445foWod41XxcKb/ndlw=
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1779978569;
	b=tLBKglMjDD9uEFZFOyQE6jPgu/NsC2enD4YYhQJvwwIte59VKVpYdV+aCqT/uUL/p0DApD
	sODgaUsyxSbwofqVs+UAnWRmS+t9HnOsG/vhELIkK1SzvsueTt7ws7OFMCavHth5Ej+jw4
	7dQUZptwvFOjLgstAF2Er26Y//L+Nao=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=simonwunderlich.de header.s=09092022 header.b=XuReeURn;
	spf=pass (diktynna.open-mesh.org: domain of sw@simonwunderlich.de designates
 23.88.38.48 as permitted sender) smtp.mailfrom=sw@simonwunderlich.de;
	dmarc=pass (policy=none) header.from=simonwunderlich.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1779978567;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LWv8MafdPzKxu026SvAgMIOfMz0Utuf87oDhnSVFpeA=;
	b=XuReeURnPmos9GVoiIehsZ4NOFQyIXEOLSxJKjVMjf2AbmHFaOzxdtyQohk8M3YIGCC1IC
	b0ZmpNPdb+s6UMYfOisArRdF55wpoRpL4u9RBmTyS0ZCBw1nB0ixHFYnjkGj70e6vcbSlU
	LCfVdxHvLx8i203DNqu3Scr9hRAkNdMmGoMhiGs28eWgX8jpWx1CAjIBTi0bupI9LYKc1u
	Zaqgmt9k60yKwQV9fX55tJ00HkFKYVbokzXil2eC/Jqo6VuvbCDYg/o+9rcBv3WoGpD5df
	wsp9wyTkuK6Am/EKnpF8rRNij5GBkOM1LFYB73g3Pi4kXKptF2sxsNOQ4mOMbQ==
From: Simon Wunderlich <sw@simonwunderlich.de>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	b.a.t.m.a.n@lists.open-mesh.org,
	Sven Eckelmann <sven@narfation.org>,
	Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH net-next 01/15] batman-adv: drop batman-adv specific version
Date: Thu, 28 May 2026 16:29:10 +0200
Message-ID: <20260528142924.329658-2-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260528142924.329658-1-sw@simonwunderlich.de>
References: <20260528142924.329658-1-sw@simonwunderlich.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: GBLL6426YDZXXVB7WESGHU4ITDQB4TYT
X-Message-ID-Hash: GBLL6426YDZXXVB7WESGHU4ITDQB4TYT
X-MailFrom: sw@simonwunderlich.de
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/GBLL6426YDZXXVB7WESGHU4ITDQB4TYT/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

From: Sven Eckelmann <sven@narfation.org>

Bumping the version number on the first pull request after each merge
window was deemed inappropriate for an in-tree component. The version
number carries little meaningful information in the context of the Linux
kernel release model, where stable and distribution might all carry
slightly different patches (without any change to the batman-adv version).

Instead, expose a UTS_RELEASE-based string to consumers of the netlink
and ethtool interfaces. But keep it in a separate file to avoid whole
batman-adv recompilations when generated/utsrelease.h is recreated.

Link: https://lore.kernel.org/r/20210203163302.13e8a2a7@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com
Link: https://lore.kernel.org/r/YnfjtpuAaH+Zkf9S@unreal
Link: https://lore.kernel.org/r/Y9faTA0rNSXg%2FsLD@nanopsycho
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/Makefile         |  1 +
 net/batman-adv/main.c           |  4 ++--
 net/batman-adv/main.h           |  4 ----
 net/batman-adv/mesh-interface.c |  3 ++-
 net/batman-adv/netlink.c        |  3 ++-
 net/batman-adv/version.c        | 18 ++++++++++++++++++
 net/batman-adv/version.h        |  8 ++++++++
 7 files changed, 33 insertions(+), 8 deletions(-)
 create mode 100644 net/batman-adv/version.c
 create mode 100644 net/batman-adv/version.h

diff --git a/net/batman-adv/Makefile b/net/batman-adv/Makefile
index d3c4d4143c144..5d7456f1240d7 100644
--- a/net/batman-adv/Makefile
+++ b/net/batman-adv/Makefile
@@ -30,5 +30,6 @@ batman-adv-$(CONFIG_BATMAN_ADV_TRACING) += trace.o
 batman-adv-y += tp_meter.o
 batman-adv-y += translation-table.o
 batman-adv-y += tvlv.o
+batman-adv-y += version.o
 
 CFLAGS_trace.o := -I$(src)
diff --git a/net/batman-adv/main.c b/net/batman-adv/main.c
index a4d33ee0fda59..b7acccdf3ce05 100644
--- a/net/batman-adv/main.c
+++ b/net/batman-adv/main.c
@@ -57,6 +57,7 @@
 #include "send.h"
 #include "tp_meter.h"
 #include "translation-table.h"
+#include "version.h"
 
 /* List manipulations on hardif_list have to be rtnl_lock()'ed,
  * list traversals just rcu-locked
@@ -112,7 +113,7 @@ static int __init batadv_init(void)
 	batadv_netlink_register();
 
 	pr_info("B.A.T.M.A.N. advanced %s (compatibility version %i) loaded\n",
-		BATADV_SOURCE_VERSION, BATADV_COMPAT_VERSION);
+		batadv_version, BATADV_COMPAT_VERSION);
 
 	return 0;
 
@@ -684,6 +685,5 @@ MODULE_LICENSE("GPL");
 
 MODULE_AUTHOR(BATADV_DRIVER_AUTHOR);
 MODULE_DESCRIPTION(BATADV_DRIVER_DESC);
-MODULE_VERSION(BATADV_SOURCE_VERSION);
 MODULE_ALIAS_RTNL_LINK("batadv");
 MODULE_ALIAS_GENL_FAMILY(BATADV_NL_NAME);
diff --git a/net/batman-adv/main.h b/net/batman-adv/main.h
index af230b017bc17..f68fc8b7239cd 100644
--- a/net/batman-adv/main.h
+++ b/net/batman-adv/main.h
@@ -12,10 +12,6 @@
 #define BATADV_DRIVER_DESC   "B.A.T.M.A.N. advanced"
 #define BATADV_DRIVER_DEVICE "batman-adv"
 
-#ifndef BATADV_SOURCE_VERSION
-#define BATADV_SOURCE_VERSION "2025.5"
-#endif
-
 /* B.A.T.M.A.N. parameters */
 
 #define BATADV_TQ_MAX_VALUE 255
diff --git a/net/batman-adv/mesh-interface.c b/net/batman-adv/mesh-interface.c
index e7aa45bc6b7ad..a244f5425406b 100644
--- a/net/batman-adv/mesh-interface.c
+++ b/net/batman-adv/mesh-interface.c
@@ -49,6 +49,7 @@
 #include "multicast.h"
 #include "send.h"
 #include "translation-table.h"
+#include "version.h"
 
 /**
  * batadv_skb_head_push() - Increase header size and move (push) head pointer
@@ -892,7 +893,7 @@ static void batadv_get_drvinfo(struct net_device *dev,
 			       struct ethtool_drvinfo *info)
 {
 	strscpy(info->driver, "B.A.T.M.A.N. advanced", sizeof(info->driver));
-	strscpy(info->version, BATADV_SOURCE_VERSION, sizeof(info->version));
+	strscpy(info->version, batadv_version, sizeof(info->version));
 	strscpy(info->fw_version, "N/A", sizeof(info->fw_version));
 	strscpy(info->bus_info, "batman", sizeof(info->bus_info));
 }
diff --git a/net/batman-adv/netlink.c b/net/batman-adv/netlink.c
index 78c651f634cd3..8db29afeaa40b 100644
--- a/net/batman-adv/netlink.c
+++ b/net/batman-adv/netlink.c
@@ -47,6 +47,7 @@
 #include "originator.h"
 #include "tp_meter.h"
 #include "translation-table.h"
+#include "version.h"
 
 struct genl_family batadv_netlink_family;
 
@@ -233,7 +234,7 @@ static int batadv_netlink_mesh_fill(struct sk_buff *msg,
 	if (!hdr)
 		return -ENOBUFS;
 
-	if (nla_put_string(msg, BATADV_ATTR_VERSION, BATADV_SOURCE_VERSION) ||
+	if (nla_put_string(msg, BATADV_ATTR_VERSION, batadv_version) ||
 	    nla_put_string(msg, BATADV_ATTR_ALGO_NAME,
 			   bat_priv->algo_ops->name) ||
 	    nla_put_u32(msg, BATADV_ATTR_MESH_IFINDEX, mesh_iface->ifindex) ||
diff --git a/net/batman-adv/version.c b/net/batman-adv/version.c
new file mode 100644
index 0000000000000..6a7c26e4bc945
--- /dev/null
+++ b/net/batman-adv/version.c
@@ -0,0 +1,18 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include "version.h"
+
+#include <generated/utsrelease.h>
+#include <linux/module.h>
+
+#define BATADV_SOURCE_VERSION "linux-" UTS_RELEASE
+
+const char *batadv_version = BATADV_SOURCE_VERSION;
+
+/* WARNING userspace tools like batctl were relying on
+ * /sys/module/batman_adv/version to check if the module was loaded. If it
+ * isn't present, they usually error out before finishing setup of the batadv
+ * interface. It should be kept until it is unlikely that there are active
+ * installations of these "broken" versions of these tools with recent kernels.
+ */
+MODULE_VERSION(BATADV_SOURCE_VERSION);
diff --git a/net/batman-adv/version.h b/net/batman-adv/version.h
new file mode 100644
index 0000000000000..d8af91f365ff9
--- /dev/null
+++ b/net/batman-adv/version.h
@@ -0,0 +1,8 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef _NET_BATMAN_ADV_VERSION_H_
+#define _NET_BATMAN_ADV_VERSION_H_
+
+extern const char *batadv_version;
+
+#endif /* _NET_BATMAN_ADV_VERSION_H_ */
-- 
2.47.3

