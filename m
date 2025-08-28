Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0F2BC8303F
	for <batman-adv@archiver.kernel.org>; Thu, 28 Aug 2025 20:19:39 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 10D9883070
	for <batman-adv@archiver.kernel.org>; Thu, 28 Aug 2025 22:19:38 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1756412378;
 b=FV/UKj5DaMAU+p77hRNNHFeU6n9cGXKe8I4IyN1I1ECdq5L6nYKp3D6vANq5c2f+ZDJpI
 HJkcPM7UgPBNwpYG55mkTjH3jXPYVUm5Aa+1pbuSA71IP/reP1b6zrgGmWaVovM//HYixIU
 V6JqFpra7rOGZrpFDg7BpOnxOgUbOII=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1756412378; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=TwlwIvKwWee9wro1eHcFq01lw6zGYutS26JkLPZAPGM=;
 b=V2ckhMbHYyEBPuFdobAQ81AJRl6iBqreaBDuPPboE06GKnLhgVOG3+3VaILMmy4pJ5V2B
 Mx+ikebT+rxRF48qMA+SwCZSF5Ew33+NivXg2Bh42JNoybcRe7e+vy9YChCPBTTptKGz1pd
 1NORmComI8cE+Q0A9Fg4l3QLhpmP5P4=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org
 [IPv6:2a00:17d8:100::8b1])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 9FE31804A8
	for <b.a.t.m.a.n@lists.open-mesh.org>; Thu, 28 Aug 2025 22:17:56 +0200 (CEST)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1756412287;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:dkim-signature;
	bh=TwlwIvKwWee9wro1eHcFq01lw6zGYutS26JkLPZAPGM=;
	b=uxb3056DauKwznNso73UhmvqepliyX6TBThiQVntFMTj9NsJV796iS6jZIv7tABJyfFN48
	qpNh1ae2RPQawubs7FOQfB6NpU4BglMS+xkpo8tdX/kDWgwDDh5Cmxda3/g5slSSJe8RY6
	6179yhi2rGZEBnEDpuDfdI2WfX6XEFI=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=DwjvgD2T;
	dmarc=pass (policy=none) header.from=narfation.org;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1756412287; a=rsa-sha256;
	cv=none;
	b=DJUB/aWo0Xaai5JBolGkIy77Y8KyAIdc+kw/CtxoiaaWaiqnJX2j8yha9HM3OZC2BjiJsU
	fblOdgpXSrNgEeaoJKmPvJxN5R/yn5BjhVUkMfuy9wWi9OWsjK90V8QntK0RcNySi2gKEg
	x3UYFYifnJtWXoyLzu4H8LX88EVuvhU=
Received: by dvalin.narfation.org (Postfix) id 272782005F;
	Thu, 28 Aug 2025 20:17:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1756412272;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=TwlwIvKwWee9wro1eHcFq01lw6zGYutS26JkLPZAPGM=;
	b=DwjvgD2TZ7HsT9u9RWOa3z0iRdjA1b7ShsREJz6uUOvNH6r4Yg1gI3S1MWRgPBcTG6hM6l
	ZEWtitX0dpSYtcrS6cA0BQP65dSUKLaZ0Qe0hMXnxFeRjGJd2sm4S5oPM9L7KgDV/fFRmd
	1ZUbT9khv8N9z7S9U9YsZcMZSDJQD/w=
From: Sven Eckelmann <sven@narfation.org>
Date: Thu, 28 Aug 2025 22:17:34 +0200
Subject: [PATCH] batman-adv: remove includes for extern declarations
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250828-cleanup-header-v1-1-aac9d38d14bc@narfation.org>
X-B4-Tracking: v=1; b=H4sIAF25sGgC/x3MQQqAIBBA0avIrBNMMqWrRAvTKQfCRCkC6e5Jy
 7f4v0LBTFhgYhUy3lTojA19x8AFG3fk5JtBCqmEkYa7A228Eg9oPWau7eDVuGqlhYQWpYwbPf9
 wXt73A8woNBBgAAAA
X-Change-ID: 20250828-cleanup-header-7a4d56b75702
To: b.a.t.m.a.n@lists.open-mesh.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3506; i=sven@narfation.org;
 h=from:subject:message-id; bh=NETgJ7R17Ip/La1K+XyPwbwmUgALaEnTxC8HdK3IhY0=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDBkbdma1aGp75usyzLzKsV3Ie7uOf41ERfusgIeft89bn
 qr2vOl3RykLgxgXg6yYIsueK/nnN7O/lf887eNRmDmsTCBDGLg4BWAi6XyMDHMsZ7ObqR2xLT6y
 wjNjfw5D94H1u5fpNgjVpO7a/X2dJjMjQ0tu0vRjN4wzpX3c43zuWPzyPq0qVqaUZJganLBq9bo
 Z/AA=
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: 4LTSLQURJQJ74MWMOCDZFYGNEZ5EPNID
X-Message-ID-Hash: 4LTSLQURJQJ74MWMOCDZFYGNEZ5EPNID
X-MailFrom: sven@narfation.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-b.a.t.m.a.n.lists.open-mesh.org-0;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-1;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-2; emergency; member-moderation;
 nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size;
 news-moderation; no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/4LTSLQURJQJ74MWMOCDZFYGNEZ5EPNID/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

It is not necessary to include the header for the struct definition for an
"extern " declaration. It can simply be dropped from the headers to reduce
the number of includes the preprocessor has to process. If needed, it can
be added to the actual C source file.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 compat.h                        | 3 +++
 net/batman-adv/hard-interface.c | 1 +
 net/batman-adv/hard-interface.h | 1 -
 net/batman-adv/mesh-interface.c | 1 +
 net/batman-adv/mesh-interface.h | 1 -
 net/batman-adv/netlink.h        | 1 -
 6 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/compat.h b/compat.h
index 638bfc54f3d0f9bd0a11e560a14121f567c5bfc9..11dd0411a6777fcf8b66f6cfae019921a5fa14a7 100644
--- a/compat.h
+++ b/compat.h
@@ -15,6 +15,9 @@
 
 #include "compat-autoconf.h"
 
+#if LINUX_VERSION_IS_LESS(5, 10, 0)
+#include "net/genetlink.h"
+#endif /* LINUX_VERSION_IS_LESS(5, 10, 0) */
 
 #endif /* __KERNEL__ */
 
diff --git a/net/batman-adv/hard-interface.c b/net/batman-adv/hard-interface.c
index bace57e4f9a516331baac04e96abe6ad1b2123dc..5113f879736b54f0231d0a030dd4bef5a320e9ae 100644
--- a/net/batman-adv/hard-interface.c
+++ b/net/batman-adv/hard-interface.c
@@ -22,6 +22,7 @@
 #include <linux/minmax.h>
 #include <linux/mutex.h>
 #include <linux/netdevice.h>
+#include <linux/notifier.h>
 #include <linux/printk.h>
 #include <linux/rculist.h>
 #include <linux/rtnetlink.h>
diff --git a/net/batman-adv/hard-interface.h b/net/batman-adv/hard-interface.h
index 262a7836474277ef2b39e3a2032201cb492b99c9..9db8a310961ead452a9775eb77d01ce51854b9cc 100644
--- a/net/batman-adv/hard-interface.h
+++ b/net/batman-adv/hard-interface.h
@@ -12,7 +12,6 @@
 #include <linux/compiler.h>
 #include <linux/kref.h>
 #include <linux/netdevice.h>
-#include <linux/notifier.h>
 #include <linux/rcupdate.h>
 #include <linux/stddef.h>
 #include <linux/types.h>
diff --git a/net/batman-adv/mesh-interface.c b/net/batman-adv/mesh-interface.c
index 5872818f4e31e52e9c8cf4118d8857e1169b5197..42a442066eb11dfb7c029b5aed81c58370937498 100644
--- a/net/batman-adv/mesh-interface.c
+++ b/net/batman-adv/mesh-interface.c
@@ -37,6 +37,7 @@
 #include <linux/string.h>
 #include <linux/types.h>
 #include <net/netlink.h>
+#include <net/rtnetlink.h>
 #include <uapi/linux/batadv_packet.h>
 #include <uapi/linux/batman_adv.h>
 
diff --git a/net/batman-adv/mesh-interface.h b/net/batman-adv/mesh-interface.h
index 7ba055b2bc269d57719fa5cdd50888155cbd3d44..53756c5a45e0471b82a21d3bbc4fd7d6b68924fb 100644
--- a/net/batman-adv/mesh-interface.h
+++ b/net/batman-adv/mesh-interface.h
@@ -13,7 +13,6 @@
 #include <linux/netdevice.h>
 #include <linux/skbuff.h>
 #include <linux/types.h>
-#include <net/rtnetlink.h>
 
 int batadv_skb_head_push(struct sk_buff *skb, unsigned int len);
 void batadv_interface_rx(struct net_device *mesh_iface,
diff --git a/net/batman-adv/netlink.h b/net/batman-adv/netlink.h
index fe4548b974bb095410bd6389751797d7d012ca85..4eae9e5ff13548e8ad925bc96d46d52274d74dd6 100644
--- a/net/batman-adv/netlink.h
+++ b/net/batman-adv/netlink.h
@@ -11,7 +11,6 @@
 
 #include <linux/netlink.h>
 #include <linux/types.h>
-#include <net/genetlink.h>
 
 void batadv_netlink_register(void);
 void batadv_netlink_unregister(void);

---
base-commit: 702c52a87eab8008e8c88e45a14462445d3f2d3a
change-id: 20250828-cleanup-header-7a4d56b75702

Best regards,
-- 
Sven Eckelmann <sven@narfation.org>

