Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48228CD5BD1
	for <batman-adv@archiver.kernel.org>; Mon,  1 Jun 2026 12:42:45 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id CBBC9803F6
	for <batman-adv@archiver.kernel.org>; Mon, 01 Jun 2026 14:42:43 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1780317763;
 b=NzCvzOuCBngCyMiXR1a/8K9rr6VwerCAI88NSgjzshZldi05FbM/6FjwZm8dfPtvf4CBc
 9FQfOJmgmzaX9hKb/OX6+okGNEhWOVjO1YohuLHSKWdt+95mMmmm5RrnL8SNSzTyhYB0Pb1
 GXV7H/62xXchqV3E0A4icVmSIzWsFms=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1780317763; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=Yp/Xnj4hCfTUVqMv2VJy6JybAPXxCdd9ZKa9fvVgolM=;
 b=rPVkvQbSOp4O3U2XVwxuYhKfn9aXXR1iXv5zcmFfAGCLqHWVBQiKL8GmcwUmg+ZQUc7np
 I0c6D8T+/vz5aZlNBgxBmfIpmqhS2XbSYA1a0hmQkj9mLgzhT/p/m5hdSPHMlu1PjZI/vT7
 XaUy1MvFOjm19rtawsO/hU1l5ZxBcOE=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass header.from=simonwunderlich.de policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=simonwunderlich.de policy.dmarc=none
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 7D53C80468
	for <b.a.t.m.a.n@lists.open-mesh.org>; Mon, 01 Jun 2026 14:36:44 +0200 (CEST)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1780317409;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=Yp/Xnj4hCfTUVqMv2VJy6JybAPXxCdd9ZKa9fvVgolM=;
	b=HtKpbSUzRJgQbCsRb/1IhZKjDqrpAWMS6nXglxfA0qe+aCl0U5CYhk2U9QMx6sx8PvlGgf
	ZgJa1mHuD9O2nrYCfkYFVPA/sVOIxAYs2fVgBJ0uvLU0TE+pxWLVVn2mUVg/HnntrKgbqI
	W8nJ9iySTyiri3SNsD1JFCjl2QO3jTs=
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1780317409;
	b=F5ITFkZUzftTbkpgueuxALXhSfX0Mnsj06IRu5gtZC5kAwnfRXuvWkDFe3h24o9HxR8cJr
	7dk4ol1WuoWerF26Q49oh2uupc76PkChcH1dMLc4Z0APP25C9bOtM1u9w9c2TL8GAQjeE9
	BqxCU3bCGsUvPnz/UBC0+w0i59mN/nE=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=simonwunderlich.de header.s=09092022 header.b=bujwBLA2;
	spf=pass (diktynna.open-mesh.org: domain of sw@simonwunderlich.de designates
 23.88.38.48 as permitted sender) smtp.mailfrom=sw@simonwunderlich.de;
	dmarc=pass (policy=none) header.from=simonwunderlich.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1780317403;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Yp/Xnj4hCfTUVqMv2VJy6JybAPXxCdd9ZKa9fvVgolM=;
	b=bujwBLA22/4J4QnCYH51HUFM8LWsbe6Us+QFp+ZJZNUgkOPu8zgaxTOyHo/Y5xOfv+41fF
	lnJolyiSOIQXjq3sQ3jfyRipdtmAxQxMhPxPMNfyQRg65AlDy3oSPKp6uNlrHD2A5ej7h8
	F38StW6+IgdNyMTy8eGU+cU4R3ls5iHpzyUtjcR68v3TZjCkXXFBSlVYGWKBu7TrpV8Fjq
	Nil27il2VARGyODLmO5ItKWQbIx6Y8QUACIOQQYjLN7gkDZ322DAg35ODDe+WydPfC/eaN
	lNk9QQ8ZCV/5OApDA0zhQmFryLQbLx2oPpmIRjpwcnv+8hEdxYidLV4vuqekSg==
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
Subject: [PATCH net-next v2 01/15] batman-adv: drop batman-adv specific
 version
Date: Mon,  1 Jun 2026 14:36:15 +0200
Message-ID: <20260601123629.707089-2-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260601123629.707089-1-sw@simonwunderlich.de>
References: <20260601123629.707089-1-sw@simonwunderlich.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: MP4N34G2R2QQI4PQLJMHIFV4R7WSOGSO
X-Message-ID-Hash: MP4N34G2R2QQI4PQLJMHIFV4R7WSOGSO
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/MP4N34G2R2QQI4PQLJMHIFV4R7WSOGSO/>
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

Instead, expose a UTS_RELEASE-based string to consumers of the netlink and
ethtool interfaces. To avoid recompilation for each (re)generate of
generated/utsrelease.h, init_utsname()->release is used in code which can
dynamically retrieve the version string. The MODULE_VERSION is moved to a
separate file because it doesn't support dynamic retrieval of the version
string (but constant "at compile time" string) and it is required for the
/sys/module/batman_adv/version. The latter is unfortunately still required
by userspace tools.

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
 net/batman-adv/version.c        | 12 ++++++++++++
 6 files changed, 19 insertions(+), 8 deletions(-)
 create mode 100644 net/batman-adv/version.c

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
index a4d33ee0fda59..82bba34893788 100644
--- a/net/batman-adv/main.c
+++ b/net/batman-adv/main.c
@@ -33,6 +33,7 @@
 #include <linux/sprintf.h>
 #include <linux/stddef.h>
 #include <linux/string.h>
+#include <linux/utsname.h>
 #include <linux/workqueue.h>
 #include <net/dsfield.h>
 #include <net/genetlink.h>
@@ -112,7 +113,7 @@ static int __init batadv_init(void)
 	batadv_netlink_register();
 
 	pr_info("B.A.T.M.A.N. advanced %s (compatibility version %i) loaded\n",
-		BATADV_SOURCE_VERSION, BATADV_COMPAT_VERSION);
+		init_utsname()->release, BATADV_COMPAT_VERSION);
 
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
index e7aa45bc6b7ad..f25b861029575 100644
--- a/net/batman-adv/mesh-interface.c
+++ b/net/batman-adv/mesh-interface.c
@@ -36,6 +36,7 @@
 #include <linux/stddef.h>
 #include <linux/string.h>
 #include <linux/types.h>
+#include <linux/utsname.h>
 #include <net/netlink.h>
 #include <net/rtnetlink.h>
 #include <uapi/linux/batadv_packet.h>
@@ -892,7 +893,7 @@ static void batadv_get_drvinfo(struct net_device *dev,
 			       struct ethtool_drvinfo *info)
 {
 	strscpy(info->driver, "B.A.T.M.A.N. advanced", sizeof(info->driver));
-	strscpy(info->version, BATADV_SOURCE_VERSION, sizeof(info->version));
+	strscpy(info->version, init_utsname()->release, sizeof(info->version));
 	strscpy(info->fw_version, "N/A", sizeof(info->fw_version));
 	strscpy(info->bus_info, "batman", sizeof(info->bus_info));
 }
diff --git a/net/batman-adv/netlink.c b/net/batman-adv/netlink.c
index 78c651f634cd3..b30f018740fcc 100644
--- a/net/batman-adv/netlink.c
+++ b/net/batman-adv/netlink.c
@@ -28,6 +28,7 @@
 #include <linux/skbuff.h>
 #include <linux/stddef.h>
 #include <linux/types.h>
+#include <linux/utsname.h>
 #include <net/genetlink.h>
 #include <net/net_namespace.h>
 #include <net/netlink.h>
@@ -233,7 +234,7 @@ static int batadv_netlink_mesh_fill(struct sk_buff *msg,
 	if (!hdr)
 		return -ENOBUFS;
 
-	if (nla_put_string(msg, BATADV_ATTR_VERSION, BATADV_SOURCE_VERSION) ||
+	if (nla_put_string(msg, BATADV_ATTR_VERSION, init_utsname()->release) ||
 	    nla_put_string(msg, BATADV_ATTR_ALGO_NAME,
 			   bat_priv->algo_ops->name) ||
 	    nla_put_u32(msg, BATADV_ATTR_MESH_IFINDEX, mesh_iface->ifindex) ||
diff --git a/net/batman-adv/version.c b/net/batman-adv/version.c
new file mode 100644
index 0000000000000..2b8006fe85b56
--- /dev/null
+++ b/net/batman-adv/version.c
@@ -0,0 +1,12 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <generated/utsrelease.h>
+#include <linux/module.h>
+
+/* WARNING userspace tools like batctl were relying on
+ * /sys/module/batman_adv/version to check if the module was loaded. If it
+ * isn't present, they usually error out before finishing setup of the batadv
+ * interface. It should be kept until it is unlikely that there are active
+ * installations of these "broken" versions of these tools with recent kernels.
+ */
+MODULE_VERSION(UTS_RELEASE);
-- 
2.47.3

