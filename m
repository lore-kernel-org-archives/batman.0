Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41913CCD1A5
	for <batman@archiver.kernel.org>; Fri, 24 Oct 2025 09:24:10 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id A45FD802F8
	for <batman@archiver.kernel.org>; Fri, 24 Oct 2025 11:24:08 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1761297848;
 b=e5WwsX4L7pjwDYXO7HKeLxkgL/WsT+0PopTL5RqgmK+Hfsw7/bk+KFfotEI3M6WZYcmY8
 0JYbcR6kooIt3cG4cr7kwZmiVWsE4IshVZNiHXC0CfGZhnqwuVfk1LCFqYvZppWg6DcXUvA
 vqHV5Bfv7L/TBuBSD7rWP+709XBtzGs=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1761297848; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=34FUBBuwHN1yJo43OdDeUj5hxtMyvd+SCBOY1ZntpS0=;
 b=OOyw+tb0Rix7ddpwK+Irq0q6kDGivQ58lVRQitGsgMzS2IWLgvf+5m++QJmY9f4sjBbKl
 V97SXGZIhOuj4PZsxjSrypKFdf3HTPLmwKHwkiT1FfkCMq5AgCWs2yX4ewM2dH++cRGbtFp
 3N2+/BG3E/TksnRyjO0h0qNxKnwO1G0=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=fail;
 arc=pass;
 dmarc=fail header.from=simonwunderlich.de policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=fail; arc=pass;
 dmarc=fail (Used From Domain Record) header.from=simonwunderlich.de
 policy.dmarc=none
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de
 [IPv6:2a01:4f8:c17:e8c0::1])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 406EE80079
	for <b.a.t.m.a.n@lists.open-mesh.org>; Fri, 24 Oct 2025 11:23:29 +0200 (CEST)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1761297809;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=34FUBBuwHN1yJo43OdDeUj5hxtMyvd+SCBOY1ZntpS0=;
	b=BpZqpA6MOvVmV/L5xR4nau8zA+0/O/iNphm3Tr3dglD+LUM7gX61yiXEaa8YDKNo/fDAzt
	aW3KZ6dxtwW/GUYppEaNz1CknhK8bhQxgRktsodrscCwwvA5c3GnBppLmAD4AsthtRs8Fa
	cuJzfDxEtr1iB19jO4vbyVjlwThi5TM=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=none;
	spf=pass (diktynna.open-mesh.org: domain of sw@simonwunderlich.de designates
 2a01:4f8:c17:e8c0::1 as permitted sender)
 smtp.mailfrom=sw@simonwunderlich.de;
	dmarc=pass (policy=none) header.from=simonwunderlich.de
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1761297809; a=rsa-sha256;
	cv=none;
	b=wER2yeDu1lnQUhAQ54wfNCun0S5YspfVY+dqlDTpPsd8x/Ka5R1sRRr4pmE+cVzyMt6YKw
	dXCK4bKBTSSefyHbsUElNy89uTGefJHAxWM85WhjpGvDqVJqfMXbMdHTr5+IVYPbGf20kV
	gpS2F5n35ENDW8e+UcuANYowlvzWzOE=
Received: from kero.packetmixer.de
 (p200300c5970781d8b076411bb4C554A3.dip0.t-ipconnect.de
 [IPv6:2003:c5:9707:81d8:b076:411b:b4c5:54a3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits)
 server-digest SHA256)
	(No client certificate requested)
	by mail.simonwunderlich.de (Postfix) with ESMTPSA id 970B0FA14B;
	Fri, 24 Oct 2025 11:23:28 +0200 (CEST)
From: Simon Wunderlich <sw@simonwunderlich.de>
To: kuba@kernel.org,
	davem@davemloft.net
Cc: netdev@vger.kernel.org,
	b.a.t.m.a.n@lists.open-mesh.org,
	Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH net-next 1/2] batman-adv: Start new development cycle
Date: Fri, 24 Oct 2025 11:23:14 +0200
Message-ID: <20251024092315.232636-2-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251024092315.232636-1-sw@simonwunderlich.de>
References: <20251024092315.232636-1-sw@simonwunderlich.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: X2WLUB5JWV3JHREFYY7K7AJKXV6CT2KX
X-Message-ID-Hash: X2WLUB5JWV3JHREFYY7K7AJKXV6CT2KX
X-MailFrom: sw@simonwunderlich.de
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/X2WLUB5JWV3JHREFYY7K7AJKXV6CT2KX/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

This version will contain all the (major or even only minor) changes for
Linux 6.19.

The version number isn't a semantic version number with major and minor
information. It is just encoding the year of the expected publishing as
Linux -rc1 and the number of published versions this year (starting at 0).

Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/main.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/batman-adv/main.h b/net/batman-adv/main.h
index 2be1ac17acaa4..af230b017bc17 100644
--- a/net/batman-adv/main.h
+++ b/net/batman-adv/main.h
@@ -13,7 +13,7 @@
 #define BATADV_DRIVER_DEVICE "batman-adv"
 
 #ifndef BATADV_SOURCE_VERSION
-#define BATADV_SOURCE_VERSION "2025.4"
+#define BATADV_SOURCE_VERSION "2025.5"
 #endif
 
 /* B.A.T.M.A.N. parameters */
-- 
2.47.3

