Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 092D5CD4F54
	for <batman-adv@archiver.kernel.org>; Thu, 28 May 2026 14:32:56 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 8577D84002
	for <batman-adv@archiver.kernel.org>; Thu, 28 May 2026 16:32:54 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1779978774;
 b=UnbhdoeR9LyuQBEA3OLTeC6/Nt8t/k5OQz0zAOk0nNY5I7e+QzESa/CEcSh8nSVUuDcB1
 fHo+H4dSHT4RZPC907dbw7U41eR5dkeUgkoZwng6YcoEMwigV8ZuG/vPNFfM9uzO/xzHQFe
 dTw3xSKP0Xieh0QQKV1Y/bVzje4FZHE=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1779978774; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=8ysH7wHe3OLnfSTa5ddiIJH59REJd0deJHXnL0c1j5c=;
 b=CeFe4Pglp71yqoY7ygkXOEOSUxHSx3TcabIRu7qJfktJOLFGjidIFGLLQmMGwRTrCBuYr
 bh1p4RtN1To/xzavM9QEEDWCDOv+ZmAmAD7Bib4zLHp7/QvRKwuXnyKykZJ8owyVOgpIP5A
 cbz/9bxZdJkaiUFdZBI0lPmjc196KPw=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass header.from=simonwunderlich.de policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=simonwunderlich.de policy.dmarc=none
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de
 [IPv6:2a01:4f8:c17:e8c0::1])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 41B1983B9D
	for <b.a.t.m.a.n@lists.open-mesh.org>; Thu, 28 May 2026 16:29:30 +0200 (CEST)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1779978570;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=8ysH7wHe3OLnfSTa5ddiIJH59REJd0deJHXnL0c1j5c=;
	b=k6/7dEfQjSfRpg3caITwswSQPOdgYFceDIU/+xZHN2J+1EuOSHz2wuAoGqiV1jiLO/n6VM
	un3vP1FUCQWzn6ENI8EzvgaZMqfBHUWv2204R8iSyiDRtt2QIuIDOK8HUrpK9aLSICSK4g
	T1ihUP8pvTvJHhS6NSX/qi/0gd4Bon4=
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1779978570;
	b=LhmCio3vqVWODYJCNA1oh7GhIbm3HnO0rKxTBlJH1BYbg5evD2ip4Ok82MvvxWCBvzsEWb
	tKcW7tADnSEdP0epKyQ3626ttGzR7LY1mG5taiLgXVf/s41itx6BOAnbaVaSZyFGss7Qy+
	N1DPR9i+C1KX/ZSteDCSuLaUkEvBQOo=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=simonwunderlich.de header.s=09092022 header.b=Ki9Qf+Si;
	spf=pass (diktynna.open-mesh.org: domain of sw@simonwunderlich.de designates
 2a01:4f8:c17:e8c0::1 as permitted sender)
 smtp.mailfrom=sw@simonwunderlich.de;
	dmarc=pass (policy=none) header.from=simonwunderlich.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1779978569;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8ysH7wHe3OLnfSTa5ddiIJH59REJd0deJHXnL0c1j5c=;
	b=Ki9Qf+SiCdVf4MckY5U3zqfBhz+nm4Rv4Pfz52+d/5++cX2zuCmZwcCTTIzuIuGImWB6MX
	fbgwVvCYhjFvTkx7p7j9Qq9CpyaN5sGlMBeoFjj49g030vmy7tfaauiv24fOAK1RffjbJO
	KYK3pITBJhgK2nft2k0HfKbf9VDVKMwhTVJan4revK0w6bA7puzmujY80xP8LKN7VQyxUE
	RVrIDYiB4fD37CNRNNghtM4732z/axSfRYG9RL5wtesBIfb6uiTaECvShLs1sh9Jjs1tOM
	ZC50foLU6KFArrxEHDDF9kRiemds2CfxEIHBs7IEHnd9q61G+9ohtBFBNFH5WQ==
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
Subject: [PATCH net-next 04/15] batman-adv: add missing includes
Date: Thu, 28 May 2026 16:29:13 +0200
Message-ID: <20260528142924.329658-5-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260528142924.329658-1-sw@simonwunderlich.de>
References: <20260528142924.329658-1-sw@simonwunderlich.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: TV5RSFHOSCRR7UBTJICSSV6QOWSIDZAU
X-Message-ID-Hash: TV5RSFHOSCRR7UBTJICSSV6QOWSIDZAU
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/TV5RSFHOSCRR7UBTJICSSV6QOWSIDZAU/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

From: Sven Eckelmann <sven@narfation.org>

Some of the recent fixes required features from new header files. There is
currently no build problem because transitive includes take care of it. But
the batman-adv source code tries to avoid the dependency to
transitive/implicite includes because it has no control over them and they
might get removed at some point.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/bat_v_ogm.c             | 1 +
 net/batman-adv/bridge_loop_avoidance.c | 1 +
 net/batman-adv/distributed-arp-table.c | 1 +
 net/batman-adv/fragmentation.c         | 1 +
 net/batman-adv/gateway_client.c        | 1 +
 net/batman-adv/hard-interface.c        | 1 +
 net/batman-adv/mesh-interface.c        | 1 +
 net/batman-adv/translation-table.c     | 1 +
 net/batman-adv/tvlv.c                  | 1 +
 9 files changed, 9 insertions(+)

diff --git a/net/batman-adv/bat_v_ogm.c b/net/batman-adv/bat_v_ogm.c
index d66ca77b1aaa3..6436e9bc079b6 100644
--- a/net/batman-adv/bat_v_ogm.c
+++ b/net/batman-adv/bat_v_ogm.c
@@ -8,6 +8,7 @@
 #include "main.h"
 
 #include <linux/atomic.h>
+#include <linux/bug.h>
 #include <linux/byteorder/generic.h>
 #include <linux/container_of.h>
 #include <linux/errno.h>
diff --git a/net/batman-adv/bridge_loop_avoidance.c b/net/batman-adv/bridge_loop_avoidance.c
index ffe854018bd3a..f6ca69252ff7c 100644
--- a/net/batman-adv/bridge_loop_avoidance.c
+++ b/net/batman-adv/bridge_loop_avoidance.c
@@ -8,6 +8,7 @@
 #include "main.h"
 
 #include <linux/atomic.h>
+#include <linux/bug.h>
 #include <linux/byteorder/generic.h>
 #include <linux/compiler.h>
 #include <linux/container_of.h>
diff --git a/net/batman-adv/distributed-arp-table.c b/net/batman-adv/distributed-arp-table.c
index 0a8bd95e2f99e..c6084ae6760c5 100644
--- a/net/batman-adv/distributed-arp-table.c
+++ b/net/batman-adv/distributed-arp-table.c
@@ -9,6 +9,7 @@
 
 #include <linux/atomic.h>
 #include <linux/bitops.h>
+#include <linux/bug.h>
 #include <linux/byteorder/generic.h>
 #include <linux/container_of.h>
 #include <linux/err.h>
diff --git a/net/batman-adv/fragmentation.c b/net/batman-adv/fragmentation.c
index e9553db423491..14ccf7811bf62 100644
--- a/net/batman-adv/fragmentation.c
+++ b/net/batman-adv/fragmentation.c
@@ -8,6 +8,7 @@
 #include "main.h"
 
 #include <linux/atomic.h>
+#include <linux/bug.h>
 #include <linux/byteorder/generic.h>
 #include <linux/errno.h>
 #include <linux/etherdevice.h>
diff --git a/net/batman-adv/gateway_client.c b/net/batman-adv/gateway_client.c
index a9d0346e8332e..ec743ce39be47 100644
--- a/net/batman-adv/gateway_client.c
+++ b/net/batman-adv/gateway_client.c
@@ -8,6 +8,7 @@
 #include "main.h"
 
 #include <linux/atomic.h>
+#include <linux/bug.h>
 #include <linux/byteorder/generic.h>
 #include <linux/container_of.h>
 #include <linux/err.h>
diff --git a/net/batman-adv/hard-interface.c b/net/batman-adv/hard-interface.c
index d6732c34aeafc..4b3804ef70b6f 100644
--- a/net/batman-adv/hard-interface.c
+++ b/net/batman-adv/hard-interface.c
@@ -8,6 +8,7 @@
 #include "main.h"
 
 #include <linux/atomic.h>
+#include <linux/bug.h>
 #include <linux/byteorder/generic.h>
 #include <linux/compiler.h>
 #include <linux/container_of.h>
diff --git a/net/batman-adv/mesh-interface.c b/net/batman-adv/mesh-interface.c
index a244f5425406b..307874069b84e 100644
--- a/net/batman-adv/mesh-interface.c
+++ b/net/batman-adv/mesh-interface.c
@@ -8,6 +8,7 @@
 #include "main.h"
 
 #include <linux/atomic.h>
+#include <linux/bug.h>
 #include <linux/byteorder/generic.h>
 #include <linux/cache.h>
 #include <linux/compiler.h>
diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index 9f6e67771ffa8..28869f65ada09 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -9,6 +9,7 @@
 
 #include <linux/atomic.h>
 #include <linux/bitops.h>
+#include <linux/bug.h>
 #include <linux/build_bug.h>
 #include <linux/byteorder/generic.h>
 #include <linux/cache.h>
diff --git a/net/batman-adv/tvlv.c b/net/batman-adv/tvlv.c
index cc6ac580c6208..8e8b54e2172ef 100644
--- a/net/batman-adv/tvlv.c
+++ b/net/batman-adv/tvlv.c
@@ -6,6 +6,7 @@
 
 #include "main.h"
 
+#include <linux/bug.h>
 #include <linux/byteorder/generic.h>
 #include <linux/container_of.h>
 #include <linux/errno.h>
-- 
2.47.3

