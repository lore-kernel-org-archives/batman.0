Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8394CD6E56
	for <batman-adv@archiver.kernel.org>; Mon,  1 Jun 2026 12:38:00 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 80E6180972
	for <batman-adv@archiver.kernel.org>; Mon, 01 Jun 2026 14:37:59 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1780317479;
 b=1J0TkXVfygf0ArP+hyw/jJit1XMrAzMQBonE0OIEGIa9FHETNQW0b9SrGIRQUPmVWAFBn
 yYucDLYTyvSoOrXM8tcakWfkDmSgVIKn9uOWAglcSp4W6Qjz3HaqqrxhvrbKEOWl9b2Ng9R
 LhQCiUtnCDV7j1A+kTfxcvXnRhaR0kM=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1780317479; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=XZBeP4vTh8Sd5u/6vckDGuUugLl6SDqKxF32VE0ES0g=;
 b=mZ2Qb3wpGYu0q6xCtXMomThQROwnVzc3Sghl8IAuyt0SdyofsEUifGdgl4NQIA1Ws5RhW
 IUaXCJMXpwUBw6sm2ZtVm7TNMXsczw6rDzsE7neIO20Xi0e9oFu+5LXWv3abNaxREgUtlqP
 99SHYM1QGzTm+HEcWYJYLPrcb0LEHNk=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass header.from=simonwunderlich.de policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=simonwunderlich.de policy.dmarc=none
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de
 [IPv6:2a01:4f8:c17:e8c0::1])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 6AA8E80454
	for <b.a.t.m.a.n@lists.open-mesh.org>; Mon, 01 Jun 2026 14:36:46 +0200 (CEST)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1780317406;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=XZBeP4vTh8Sd5u/6vckDGuUugLl6SDqKxF32VE0ES0g=;
	b=u5ydD0gnkMr+TFTTCuSOWYaq+ZrUPM77TUCYcDTfUH4e8q4hT64Yy9VJrjVNg20HHbhRmT
	aUyTHFJEcZIfjmEUxQRzzFyvYZS8Jc8hrsQEAIgYEXcGWDPExa/ff+BWNRto+6EncNZqNS
	9n/7VgnM7FrHs/8PmbNibX35IbmXGO8=
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1780317406;
	b=n74JwsTBkzGW0MncH5sVx1edISGWwuwol3gOge+FadW9Fe1qauRZR8rvprYBbrtAEJZKjZ
	YoeGs9bYK8xwnliGb8ZIeNsyxwpbVhWVJsjAExvs+RkS680RGA+ce7jnMw30Z9Ruu6ZDGG
	z4Re7NVlScDiRIceM7+W4yX70ZXEq9A=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=simonwunderlich.de header.s=09092022 header.b=FzN9pYCL;
	spf=pass (diktynna.open-mesh.org: domain of sw@simonwunderlich.de designates
 2a01:4f8:c17:e8c0::1 as permitted sender)
 smtp.mailfrom=sw@simonwunderlich.de;
	dmarc=pass (policy=none) header.from=simonwunderlich.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1780317405;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XZBeP4vTh8Sd5u/6vckDGuUugLl6SDqKxF32VE0ES0g=;
	b=FzN9pYCLJjjbehNl/y/wsoCRLmUIfLlnYuVI+KtYMhwZmnSRIQNEfCQQnCYgFd+R0HMuu/
	sX6yS4Pxy7xfOe2LvJJ9PcM8t2eJBMIYJCxlnA9DLO8x1dpJJ3vBo1mMRfBoLN8GubvoSY
	NMdGSFaqIejgE3sQpOTPlI3nmPlbOCOi0RiN0t5ZoZQ6mj4ds/tYMjkqSsK0SCgiDJ6VB0
	0B0/mVq/qif3Pj9/oorTn52/rJAX7STj2UBavTuEEjp/gxb7KXF0Y0Q1DdquK1roGRmVaL
	ZzbEmZTaBzXDZRwSThoSWY45j3EnKiwb8F3EZiC3eoNNPRBUaQXyoN0lm/aANw==
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
Date: Mon,  1 Jun 2026 14:36:18 +0200
Message-ID: <20260601123629.707089-5-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260601123629.707089-1-sw@simonwunderlich.de>
References: <20260601123629.707089-1-sw@simonwunderlich.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: 7RRTK75IJLUU3P7MAWPE3JC6HT73RB7K
X-Message-ID-Hash: 7RRTK75IJLUU3P7MAWPE3JC6HT73RB7K
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/7RRTK75IJLUU3P7MAWPE3JC6HT73RB7K/>
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
index f25b861029575..d6f40ae3c815a 100644
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

