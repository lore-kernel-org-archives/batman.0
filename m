Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDBAACD6E55
	for <batman-adv@archiver.kernel.org>; Wed,  3 Jun 2026 04:29:09 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 4DEA283E78
	for <batman-adv@archiver.kernel.org>; Wed, 03 Jun 2026 06:29:08 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1780460948;
 b=cfka3tD0Um1SXqO5pKk9sRSmi24VM6u9a6jpEgQZrorz1J4AIT41nVB+QlKznCrVzrEKr
 X4HMlEtkdegVAqFICFgYnGKD1/rRmcM0xLR7ZG2GtRSZ0B/NWrEGtZIyDB8a9gwQQgMoPLi
 dA2IuLimJLQ7KFh4waiqm1j9+lNZW8U=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1780460948; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=LPRDAnkz2Z38ljkyNOSbudooO/LtAKRvep0wyYjcCHE=;
 b=UukOs67gOBqjtPWM3JDOLxe38S5YYEjq0mOAk/3lpiGsvjJW4O9l6M88SDVKQ+oYXH7Av
 uJ84j3BxBCU2MQ1gC8wqaoAPCXSSPA5rYtWqtpdO4G+74B5JMWKXQOKD/LgHc1yR1gPIFzv
 XgfFo5TZrT5jIbe9jTdx8ckpZTJRiuU=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org
 [IPv6:2a00:17d8:100::8b1])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 3E1B380794
	for <b.a.t.m.a.n@lists.open-mesh.org>; Wed, 03 Jun 2026 06:21:58 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1780460518;
	b=U8WBzDLrGLwhyLRddH6QS2L9Shbdw6baCIeRLJEImRvK/uIVbR+S2X2Tzcba6BcAPMYipy
	h0rZZoPUm+/7SwhZKHVW6++AsrPgVEPm+qP5DBHCKKBzBnsNz8ANxG25JL1HTp2qgXSRVS
	Lx9Ux4aei+XBOahUtbr1H98aQ4bV0G8=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=M2OIuUPy;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1780460518;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=LPRDAnkz2Z38ljkyNOSbudooO/LtAKRvep0wyYjcCHE=;
	b=aXSZfF6yFBa8laNtmiY8xvreJIu/OgQuvVSYQeea+0PB2cdJdTKg8GXcbSpkV6o63oflZE
	baBEaWCMb08PrVF8QSWkm10jyp+/xDz1/FwiZw8MgHnVTVvSgaGqBwZfTSVIbY8/UL+Utr
	APfaTS8fF7Aa7xRhawqU00Azn1IW3vE=
Received: by dvalin.narfation.org (Postfix) id D851F1FEA4;
	Wed, 03 Jun 2026 04:21:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1780460517;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LPRDAnkz2Z38ljkyNOSbudooO/LtAKRvep0wyYjcCHE=;
	b=M2OIuUPyJI/3TUOeoMsw2BPYbaZ3i2+Khx6gFSdlME0xDaKTywUinmvWpUVv8ixlX6fjPC
	QggSNN1ypQuCIqtu9YUu0/a8GvUdmHNsQzimw4art+icvaiXySKgDk6dyIn2YlKQX3h1Fd
	6UAz/vQzOOlZcUqE+HOHFufzRxNuW+4=
From: Sven Eckelmann <sven@narfation.org>
Date: Wed, 03 Jun 2026 06:21:39 +0200
Subject: [PATCH batadv 2/3] batman-adv: drop duplicated wifi_flags assigned
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260603-wifi-cache-cleanup-v1-2-d5ed08075c96@narfation.org>
References: <20260603-wifi-cache-cleanup-v1-0-d5ed08075c96@narfation.org>
In-Reply-To: <20260603-wifi-cache-cleanup-v1-0-d5ed08075c96@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=874; i=sven@narfation.org;
 h=from:subject:message-id; bh=w+JT++rAte7ImM+EsHFRVDvS9hgXrT7yZuDeUElH5e4=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFnyqy9Pll36/YiNr3iI4ZZCh+B0af1FOrGXz59WOxMbo
 Mdz5GldRykLgxgXg6yYIsueK/nnN7O/lf887eNRmDmsTCBDGLg4BWAia+oY/pc8PRnGwSXYGVpc
 ry5jYcFkWW307lXWysyr6z46bL/nN5Xhr4SRzm/Thv/5/050O9ZPPazaupxjusWCc6kbw9TeOKz
 XYgcA
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: PU3YYPMDAQFBDBYYM5MPJ6K7XCTPPKRZ
X-Message-ID-Hash: PU3YYPMDAQFBDBYYM5MPJ6K7XCTPPKRZ
X-MailFrom: sven@narfation.org
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/PU3YYPMDAQFBDBYYM5MPJ6K7XCTPPKRZ/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

During the initialization of the batadv_wifi_net_device_state, it is enough
to write the wifi_flags once before the batadv_wifi_net_device_state is
added to the batadv_wifi_net_devices rhashtable.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/hard-interface.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/net/batman-adv/hard-interface.c b/net/batman-adv/hard-interface.c
index 213d4609..80eaac0e 100644
--- a/net/batman-adv/hard-interface.c
+++ b/net/batman-adv/hard-interface.c
@@ -976,7 +976,6 @@ batadv_wifi_net_device_insert(struct net_device *net_dev, u32 wifi_flags)
 	if (!device_state)
 		return -ENOMEM;
 
-	device_state->wifi_flags = wifi_flags;
 	netdev_hold(net_dev, &device_state->dev_tracker, GFP_ATOMIC);
 	device_state->netdev = net_dev;
 	WRITE_ONCE(device_state->wifi_flags, wifi_flags);

-- 
2.47.3

