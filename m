Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 067D8CD6E4A
	for <batman-adv@archiver.kernel.org>; Wed,  3 Jun 2026 04:29:54 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 956698534D
	for <batman-adv@archiver.kernel.org>; Wed, 03 Jun 2026 06:29:52 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1780460992;
 b=TaI2shYQLtrahywtf+FjE+Ln1G3bRlO6A+loJokUvQYCDKV8ctoE30cfuxAEfGy+pevJr
 hdWxVojR2AxqvBUAIGWSOpmedrz3f7ZVs1z5c5An8KGguozdL+dS/kPATMiUB7wAg3zsaeV
 7A2r96D0/uPVjuKYWX1+7HkG6g+jT2M=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1780460992; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=6X1aQnbDbVTThl3dSzsccbRB8y1El+ULxx1VXc8IfuY=;
 b=JfsckGc+wpyrWnCBUw85vxyNTEtbXvNSvbutJTDawAlPm6fy6w6Xaj3/2YHhmlFvJcwtH
 OxHQ3qN3Voz3eR39AdrD4D8z043PwqbiSblV1mgeEem+JU3zHAuI0/+NOnRba5eo+TA/f2B
 ofFlz/78CbcVLUC3Ajv0fccA4VurRd8=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id D30E680888
	for <b.a.t.m.a.n@lists.open-mesh.org>; Wed, 03 Jun 2026 06:22:00 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1780460520;
	b=FEJOFjX+Pm+40jhQLQC6AQV/pAkdKMdFFEpXmP/v6DVAU1XK0oxZq9P3em2bG1Bt45a10T
	v/5f4uugHCwdr9nSQItuS04qkCVYdcdq4k5R02HYfVHaLxb3hvd2KsJQwVf2cAyxLMnB1C
	ezE9zK+SOe+s0lWPnNrA3poW8jcHvcE=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=nVKLBLqP;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1780460520;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=6X1aQnbDbVTThl3dSzsccbRB8y1El+ULxx1VXc8IfuY=;
	b=VrYGbvnCEXterjBlnzyC+UQ9GqFR4p/MaqiBsqYarjhIkzCAIk8cYKLGEBAEBXcV1T1aJW
	X3lQVWZbk0DszFp/R3axM2vlfmt8dEtRYH5J+IM+aazT8PcPzQ+GtE/hJd6GDUI2fYFFZW
	su23VxcaBlfHm80qMtc8rticfiz5THA=
Received: by dvalin.narfation.org (Postfix) id 98CDC1FEA4;
	Wed, 03 Jun 2026 04:22:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1780460520;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6X1aQnbDbVTThl3dSzsccbRB8y1El+ULxx1VXc8IfuY=;
	b=nVKLBLqPf2Euqwz3dh1EDAA1qeyy/Pn4SSyoEG+aSIL57laB/BO2bFnyVcBk7qSG/g/WOg
	fayaeVsgg504bgwtznlHAqnIourSXqUSj5uh39VGSzv+f84J/TgmbwnU2rZPfQ6SLOr2Ok
	CcaXQwTGDvPm/okL38PAkpc1jmH3KJY=
From: Sven Eckelmann <sven@narfation.org>
Date: Wed, 03 Jun 2026 06:21:40 +0200
Subject: [PATCH batadv 3/3] batman-adv: use GFP_KERNEL allocations for the
 wifi detection cache
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260603-wifi-cache-cleanup-v1-3-d5ed08075c96@narfation.org>
References: <20260603-wifi-cache-cleanup-v1-0-d5ed08075c96@narfation.org>
In-Reply-To: <20260603-wifi-cache-cleanup-v1-0-d5ed08075c96@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1083; i=sven@narfation.org;
 h=from:subject:message-id; bh=yoSEJWujxT3OBjgrWQ0oAH03KYeo+kCZ8ASaMhGEEiY=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFnyqy9HvU25NXPDna7s8tmyG+5yMzAZvZj//dMEDuXIy
 4JHa6tedZSyMIhxMciKKbLsuZJ/fjP7W/nP0z4ehZnDygQyhIGLUwAmkn2KkeFEpJXKVu3+yzV9
 pZzL56lvWOKWveGmz0VBoXMubx5tnvaH4TebzMLWv+t3m7Zvu74+6MOa+mN3wmMs/Rw2l/jdt+Y
 5cooLAA==
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: FE47RWMJZUQY3L52C456VTGVBFP2NA22
X-Message-ID-Hash: FE47RWMJZUQY3L52C456VTGVBFP2NA22
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/FE47RWMJZUQY3L52C456VTGVBFP2NA22/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

The batadv_wifi_net_device_insert() is called with ASSERT_RTNL() held, but
not inside a spinlock or another context which prevents "might_sleep"
functions. To relax the requirements for the allocator, use GFP_KERNEL.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/hard-interface.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/batman-adv/hard-interface.c b/net/batman-adv/hard-interface.c
index 80eaac0e..63caabf5 100644
--- a/net/batman-adv/hard-interface.c
+++ b/net/batman-adv/hard-interface.c
@@ -972,11 +972,11 @@ batadv_wifi_net_device_insert(struct net_device *net_dev, u32 wifi_flags)
 
 	ASSERT_RTNL();
 
-	device_state = kzalloc_obj(*device_state, GFP_ATOMIC);
+	device_state = kzalloc_obj(*device_state, GFP_KERNEL);
 	if (!device_state)
 		return -ENOMEM;
 
-	netdev_hold(net_dev, &device_state->dev_tracker, GFP_ATOMIC);
+	netdev_hold(net_dev, &device_state->dev_tracker, GFP_KERNEL);
 	device_state->netdev = net_dev;
 	WRITE_ONCE(device_state->wifi_flags, wifi_flags);
 

-- 
2.47.3

