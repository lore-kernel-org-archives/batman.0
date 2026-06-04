Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61990CD6E68
	for <batman-adv@archiver.kernel.org>; Thu,  4 Jun 2026 04:46:40 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 0401C8109D
	for <batman-adv@archiver.kernel.org>; Thu, 04 Jun 2026 06:46:39 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1780548399;
 b=EytH6GznK8eA98b+fBmQZO4UNHGOGoef+xKGt6b9RYACtrR5B9C8uXm/sfmc5evPT3IAP
 NX4sMBrTlo7TqvqP78sftyE+7OdMzbB8slMR8p4S0K4HbOuR2kcCktyikP2YJUYGBgUnXVV
 ZDGfnxwzXPGkSFloYA9V/F6DOikCjVs=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1780548399; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=vL02Q2tMbAVZTjtlGIQ64DMpF09wEPrElo0xJmGnQUM=;
 b=pGs0GAiMhiKzfq47+TyyWu4lIpojth4VCuhQKHGHkoDUEIOD9oAd5Utzt/W48mOQz4ay3
 BdlyHyc+Zyl7C/Fy/kTOk5IHxr0AMZuyUehfe8HZg+/diYoZd/DI+dP7sE2VohPmroXk3eK
 rnQ0PG9r0Chj/BFS87bBv4+TPT68azg=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 163E88475F
	for <b.a.t.m.a.n@lists.open-mesh.org>; Thu, 04 Jun 2026 06:41:21 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1780548081;
	b=ooZtK26O9wxWXUW9S3XRjB+opk79Q2vOu4OOrYf63cfVGUs9D2LB/5ekGCemXVYiApMS5x
	nHI9B2QrC3ofv+S8uNyO/lW8Lbtr/HOD4Y9OD8O+GquF0waqaLkQ8/8vhDqHk7x7fLgUmR
	EKV9AvWs4rn1waI1RA37l5m+p72Geuk=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=tZZQ7BxP;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1780548081;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=vL02Q2tMbAVZTjtlGIQ64DMpF09wEPrElo0xJmGnQUM=;
	b=bpIfzCkiWxbKVdOxMV/QXIx5w+5OBrS58IOuIhokGUHdak6Nwvno4LSBCMaNbSqNFlSx4r
	Iu1U4J9yDrHJZq3q5nKXWZ5eK/sGFaEPn1R7CuvLJ4ZIkaHQLW7FxUHNAtQzYU32qbTBKX
	CVm6PsPaUGMau8k7r0TM1HvLk25QFl8=
Received: by dvalin.narfation.org (Postfix) id B7D4A1FEF0;
	Thu, 04 Jun 2026 04:41:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1780548080;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vL02Q2tMbAVZTjtlGIQ64DMpF09wEPrElo0xJmGnQUM=;
	b=tZZQ7BxPNSSeZjjZmCOct+uDsNz76KiIOoJIRVTy0oxUp4cW/HS9t3PAYPZMb3dxQoR5hE
	kLvx60KrY+A/RJlpEn4GGWSGXhjLMLlqgqzSSRTxvK+aPFrXGdFZA/Zq3o5XVfXElmK4A5
	+eJNpbH36MocfwtkYwuqTu9EZwx2XUM=
From: Sven Eckelmann <sven@narfation.org>
Date: Thu, 04 Jun 2026 06:40:53 +0200
Subject: [PATCH batadv v2 4/4] batman-adv: use GFP_KERNEL allocations for
 the wifi detection cache
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260604-wifi-cache-cleanup-v2-4-c89d32c02471@narfation.org>
References: <20260604-wifi-cache-cleanup-v2-0-c89d32c02471@narfation.org>
In-Reply-To: <20260604-wifi-cache-cleanup-v2-0-c89d32c02471@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1083; i=sven@narfation.org;
 h=from:subject:message-id; bh=LGyiYIAXPOnlsBw28iYTtyUl5L7Z+vFPhdwD5WYUIM4=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFmKjJcrT0psWuWVf52/ZNvq4wduBXxLTdqYbJRnbnk//
 uPK12tCOkpZGMS4GGTFFFn2XMk/v5n9rfznaR+PwsxhZQIZwsDFKQAT+WnI8FeWJ+72LY1mgaab
 V5647+E21o+zFU/+/S3E5sha5Tvm5ZcZ/qf+KRY6LuSoq7e8hfFqmoDGy4Wy8uIOmwM++xSmHWZ
 W5wIA
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: FPQXSLNLBQPWH5IWBI2LWD56B3ZWWGRZ
X-Message-ID-Hash: FPQXSLNLBQPWH5IWBI2LWD56B3ZWWGRZ
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/FPQXSLNLBQPWH5IWBI2LWD56B3ZWWGRZ/>
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
index 041df554..60cee2c2 100644
--- a/net/batman-adv/hard-interface.c
+++ b/net/batman-adv/hard-interface.c
@@ -983,11 +983,11 @@ batadv_wifi_net_device_insert(struct net_device *net_dev, u32 wifi_flags)
 
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

