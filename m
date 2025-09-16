Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AAECCAC599
	for <batman-adv@archiver.kernel.org>; Tue, 16 Sep 2025 12:25:25 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id A914484681
	for <batman-adv@archiver.kernel.org>; Tue, 16 Sep 2025 14:25:23 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1758025523;
 b=wBIasWf9wowBMasSJKYblbsgYZc0jH50c+Xce+oat/dPAqMN2dVfKhtOP31TSFWhHuKyB
 YRFu+/EtGZtBtOBmv+U5KAESeYfq4sLQcvVi2cwzvyonvON2/MQH7m/G6xKDcGJeW71OU5A
 yfXVcXazli5rhhFKPoMHiaGFbYIuJPc=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1758025523; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=hbs3mzFRrQenZU9aO8mTruY7LIbEng58MZUfp4p243Q=;
 b=O3M+dcTAs236Z+zaeayZymmGuNxLFcZgqeIn23Ar62omC2AbGTsc/F+/Xifbbbpmp4L/g
 iaY5RA3j/55HE1CxbHO0rftJihrepR6wEzx2gBxvLxRvSuiTLwxWWnpRnyXCAY2p9vT1U7k
 c9CBDkRdzA/Zs9oO1NA6PRWPgyKrT54=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=fail;
 arc=pass;
 dmarc=fail header.from=simonwunderlich.de policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=fail; arc=pass;
 dmarc=fail (Used From Domain Record) header.from=simonwunderlich.de
 policy.dmarc=none
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de
 [IPv6:2a01:4f8:c17:e8c0::1])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 12E5F82F18
	for <b.a.t.m.a.n@lists.open-mesh.org>; Tue, 16 Sep 2025 14:24:52 +0200 (CEST)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1758025493;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hbs3mzFRrQenZU9aO8mTruY7LIbEng58MZUfp4p243Q=;
	b=o9qPQAod6Nz4n4tXCkBUK/DHhcoDm4yKRAH9+v3uS68Rfwdc4oygwMPXbqqqu+CbbpH1o/
	v0IbxWTUbcI950H+F8f0SBHzfXEpFupI67A0PLBAzPWJI0Wj+5o8L6JHIRc8iJqv7zNvmq
	yZFKty/id37dATnQNaZXO8YbZ9qhG1A=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=none;
	dmarc=pass (policy=none) header.from=simonwunderlich.de;
	spf=pass (diktynna.open-mesh.org: domain of sw@simonwunderlich.de designates
 2a01:4f8:c17:e8c0::1 as permitted sender) smtp.mailfrom=sw@simonwunderlich.de
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1758025493; a=rsa-sha256;
	cv=none;
	b=n9T7Nr3XJ4xW3bRb65+GcbShuOsKfNikcyv5deWyfvFT3nV7kGcZqLggSk8xTI6+s+Yny9
	Q4l1QD6nSr0cynm2w2lAEFs0XOz3qnVLRr9MqO3lo1IcYDmx/xqBBa+w8xwDLCGgaTMdH7
	ihDjoFCaCScfy8Y8CbM4wMuzM5uXb2g=
Received: from kero.packetmixer.de
 (p200300c5972536D8604E0A64d0d3AAD8.dip0.t-ipconnect.de
 [IPv6:2003:c5:9725:36d8:604e:a64:d0d3:aad8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits)
 server-digest SHA256)
	(No client certificate requested)
	by mail.simonwunderlich.de (Postfix) with ESMTPSA id 81448FA1AE;
	Tue, 16 Sep 2025 14:24:52 +0200 (CEST)
From: Simon Wunderlich <sw@simonwunderlich.de>
To: kuba@kernel.org,
	davem@davemloft.net
Subject: [PATCH net-next 4/4] batman-adv: remove includes for extern
 declarations
Date: Tue, 16 Sep 2025 14:24:41 +0200
Message-ID: <20250916122441.89246-5-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250916122441.89246-1-sw@simonwunderlich.de>
References: <20250916122441.89246-1-sw@simonwunderlich.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: 6G6UXF2ZDQLT5UZAH257HLLTKIJDG6YW
X-Message-ID-Hash: 6G6UXF2ZDQLT5UZAH257HLLTKIJDG6YW
X-MailFrom: sw@simonwunderlich.de
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-b.a.t.m.a.n.lists.open-mesh.org-0;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-1;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-2; emergency; member-moderation;
 nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size;
 news-moderation; no-subject; digests; suspicious-header
CC: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/6G6UXF2ZDQLT5UZAH257HLLTKIJDG6YW/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

From: Sven Eckelmann <sven@narfation.org>

It is not necessary to include the header for the struct definition for an
"extern " declaration. It can simply be dropped from the headers to reduce
the number of includes the preprocessor has to process. If needed, it can
be added to the actual C source file.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/hard-interface.c | 1 +
 net/batman-adv/hard-interface.h | 1 -
 net/batman-adv/mesh-interface.c | 1 +
 net/batman-adv/mesh-interface.h | 1 -
 net/batman-adv/netlink.h        | 1 -
 5 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/net/batman-adv/hard-interface.c b/net/batman-adv/hard-interface.c
index bace57e4f9a51..5113f879736b5 100644
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
index 262a783647427..9db8a310961ea 100644
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
index be55d8d87348c..df7e95811ef56 100644
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
index 7ba055b2bc269..53756c5a45e04 100644
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
index fe4548b974bb0..4eae9e5ff1354 100644
--- a/net/batman-adv/netlink.h
+++ b/net/batman-adv/netlink.h
@@ -11,7 +11,6 @@
 
 #include <linux/netlink.h>
 #include <linux/types.h>
-#include <net/genetlink.h>
 
 void batadv_netlink_register(void);
 void batadv_netlink_unregister(void);
-- 
2.47.3

