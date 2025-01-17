Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73928C02183
	for <batman-adv@archiver.kernel.org>; Fri, 17 Jan 2025 12:40:54 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 0507484332
	for <batman-adv@archiver.kernel.org>; Fri, 17 Jan 2025 13:40:53 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1737117653;
 b=JV7B9O2v4khj4Q6mVndiWL/+072UIsNx0Y55eAM2/rPrq50CLfMhPzJf4dwZyhjhabwl5
 YivdgmxRIuOHmV3ObCpxYtzhpV7Poe6d43HMd7YptWETOoqfxz6dro9h+Zrdclgz4kFX2pQ
 2wch8HuTlxDzxcHezgn4zLY3DBGvG8Y=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1737117653; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=kzyYis+zFVndXDUZG1gDUv/IOsqg7n8Yc1NA6yxfGJ8=;
 b=DfFPKrhWM6B+b/0g12GHOjm5Kmt//BG6GPKI8HssJ+mzyw2lGvG9olyTwGCo7ZewuwUZq
 FDfkSF06OAhAJTjSUOzgbBfh5U2UJIWDvJUmFu3IThtSoIrhp8wF83QlZYmwRLas3eGXmH2
 Q5SCvp1plmJi1UNl8MmjIKVQB84SCQk=
ARC-Authentication-Results: i=2; open-mesh.org; dkim=fail;
  arc=pass;
  dmarc=fail (Used From Domain Record) header.from=simonwunderlich.de
 policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=fail; arc=pass;
 dmarc=fail (Used From Domain Record) header.from=simonwunderlich.de
 policy.dmarc=none
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de
 [IPv6:2a01:4f8:c17:e8c0::1])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 433FE83F93
	for <b.a.t.m.a.n@lists.open-mesh.org>; Fri, 17 Jan 2025 13:39:32 +0100 (CET)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1737117572;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kzyYis+zFVndXDUZG1gDUv/IOsqg7n8Yc1NA6yxfGJ8=;
	b=AtcsQ1h12r+cddhHjermv9q8jfjMTcbFcl2TDnHCVN7D3Xayd/EFDrAtA8qK9mk5ruQvZT
	tkz5D7eSSAafb5ShTmasgimuoBodNMdBglnK7Zu/qQFHSMJpmWQvY0qDI/IO7HxfnASMqf
	5frNU4FmqGPRUa36J7u9STngUFj/Wzk=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=none;
	spf=pass (diktynna.open-mesh.org: domain of sw@simonwunderlich.de designates
 2a01:4f8:c17:e8c0::1 as permitted sender)
 smtp.mailfrom=sw@simonwunderlich.de;
	dmarc=pass (policy=none) header.from=simonwunderlich.de
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1737117572; a=rsa-sha256;
	cv=none;
	b=O5oak7eutLJzAeVuanDl7m+9hN1nx0CaMyZ9SGcOJPXvAFVGGRJJ0XE9cmJ6hqGsK7OHQQ
	ttggq89uCEWdUi3CY3SHKEHEhq+KccXmIXMGEveO1J9maO5WRWgPjVwU8ir3iCr0pwwxdl
	aA6nwBLIGnGEOXvQs70OH8Is2Di2764=
Received: from kero.packetmixer.de
 (p200300c5973c90d8a96Dd71A2E03F697.dip0.t-ipconnect.de
 [IPv6:2003:c5:973c:90d8:a96d:d71a:2e03:f697])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits)
 server-digest SHA256)
	(No client certificate requested)
	by mail.simonwunderlich.de (Postfix) with ESMTPSA id 443D5FA197;
	Fri, 17 Jan 2025 13:39:31 +0100 (CET)
From: Simon Wunderlich <sw@simonwunderlich.de>
To: kuba@kernel.org,
	davem@davemloft.net
Cc: netdev@vger.kernel.org,
	b.a.t.m.a.n@lists.open-mesh.org,
	Sven Eckelmann <sven@narfation.org>,
	Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH 02/10] batman-adv: Reorder includes for
 distributed-arp-table.c
Date: Fri, 17 Jan 2025 13:39:02 +0100
Message-Id: <20250117123910.219278-3-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250117123910.219278-1-sw@simonwunderlich.de>
References: <20250117123910.219278-1-sw@simonwunderlich.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: BEOBBGGZEZ77TAHGML7MYJST6EGOA5VT
X-Message-ID-Hash: BEOBBGGZEZ77TAHGML7MYJST6EGOA5VT
X-MailFrom: sw@simonwunderlich.de
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/BEOBBGGZEZ77TAHGML7MYJST6EGOA5VT/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

From: Sven Eckelmann <sven@narfation.org>

The commit 5f60d5f6bbc1 ("move asm/unaligned.h to linux/unaligned.h")
changed the include without adjusting the order (to match the rest of the
file).

Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/distributed-arp-table.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/batman-adv/distributed-arp-table.c b/net/batman-adv/distributed-arp-table.c
index 801eff8a40e5..48b72c2be098 100644
--- a/net/batman-adv/distributed-arp-table.c
+++ b/net/batman-adv/distributed-arp-table.c
@@ -7,7 +7,6 @@
 #include "distributed-arp-table.h"
 #include "main.h"
 
-#include <linux/unaligned.h>
 #include <linux/atomic.h>
 #include <linux/bitops.h>
 #include <linux/byteorder/generic.h>
@@ -32,6 +31,7 @@
 #include <linux/stddef.h>
 #include <linux/string.h>
 #include <linux/udp.h>
+#include <linux/unaligned.h>
 #include <linux/workqueue.h>
 #include <net/arp.h>
 #include <net/genetlink.h>
-- 
2.39.5

