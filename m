Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26381CD6E5D
	for <batman-adv@archiver.kernel.org>; Fri,  5 Jun 2026 07:20:25 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 960BD81194
	for <batman-adv@archiver.kernel.org>; Fri, 05 Jun 2026 09:20:23 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1780644023;
 b=IYPM/7qIg3kT1Iq+vG4gD8HndudNLe1BVgJ+EYzMxwyoE4xKeQmDSv+Alb9cohW2YjcfK
 GGWGjgQ+YJcazMet4ybux6DGpGJLnUnxU4mfQJ+e+D2jngrVE5oQiBh6sKZHP/mYK7N4E5j
 enGnmbBHSyApTnnx8jJDtPCApQiCJjI=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1780644023; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=t5VjgMR6R+zmUaoqlylF20/UjikHzP0+tYEYge+V4aQ=;
 b=qJbcOWdHHg9+xWDn7NNP9hGqcIARv28euYcXb3KxwZpykc+50lqs70p48RYpXPvXF3JEE
 Qcy88Sbtufulu0E6PwbGrmCaSWa30L1MFMCfy9ZUiQlr2PD8Wa5PaYQzB5qVEFfV4VFhTAH
 mu7XxpadYg+IhQL0g80gwAcoU1i3mGg=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass header.from=simonwunderlich.de policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=simonwunderlich.de policy.dmarc=none
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 3DB1F8026D
	for <b.a.t.m.a.n@lists.open-mesh.org>; Fri, 05 Jun 2026 09:20:13 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1780644014;
	b=xovVWO80VKeSKCUK1NIqn5LMNz4LckGgZePChGXiZgzOYBOvIrioozAVc+f0bNqtbUtzRX
	s1AtsdJvmsKXz6clZVoz7uMoUfeHK007aU83Hhrjdxp7+QI3C6/8sCmw88btmQEV+L+f4U
	4FndaGwbnUEBssfbM92G8DsVZOFFvl8=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=simonwunderlich.de header.s=09092022 header.b="k/zYiKnl";
	spf=pass (diktynna.open-mesh.org: domain of sw@simonwunderlich.de designates
 23.88.38.48 as permitted sender) smtp.mailfrom=sw@simonwunderlich.de;
	dmarc=pass (policy=none) header.from=simonwunderlich.de
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1780644014;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=t5VjgMR6R+zmUaoqlylF20/UjikHzP0+tYEYge+V4aQ=;
	b=c3qHRyZIvAWG0KYWUoKYw1l6oy2gcklAl4e2zA6YXUV5tVOmIyJYMriID9vqa23Hcztwyv
	lwbSqezbMOZDA0rel0XJvXHhI/41gZYYLE75wMJlba3pa3iEgZqVfINkOCT2RdOc0qqQwf
	ZOHUJdf7b3XYOapm0MMvLKLfj29Vhv4=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1780644013;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=t5VjgMR6R+zmUaoqlylF20/UjikHzP0+tYEYge+V4aQ=;
	b=k/zYiKnlGSijjO53aH3e9I0c/Rcyd75R9R5vr9LMGh+BLm162CyI5A/q28zQ0Qg8HBI9q6
	rKTWtEUtQBEJVj+pPHF33UN0QkPc7nPM4lLJHCcIIIun6Pmz4LEXk1mCXT+NUQWf1bwJSk
	yzMWH0v13R+LdHKSyfuRzy5ZzImInKViqyL9e6RQ3LuiAxrC16E4Xzcstk6ewWmcgtZ5B+
	ADoNPYRgQ8vy64ufaowBvYvvJAU+ii+7Kc+f9OJDERSqfwqmZeXojuN3mG4zhCqxtDG5fx
	EBUMfrtHxzk1B0KmFXzN8i92tdh3os4pbe5ok/d6g7kW3ogfP16WtW8z3iAuZA==
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
Subject: [PATCH net-next 03/11] batman-adv: drop duplicated wifi_flags
 assignments
Date: Fri,  5 Jun 2026 09:19:57 +0200
Message-ID: <20260605072005.490368-4-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260605072005.490368-1-sw@simonwunderlich.de>
References: <20260605072005.490368-1-sw@simonwunderlich.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: WM4VOXSTTYBOJHJBC5QEEXBKKHXYXNKW
X-Message-ID-Hash: WM4VOXSTTYBOJHJBC5QEEXBKKHXYXNKW
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/WM4VOXSTTYBOJHJBC5QEEXBKKHXYXNKW/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

From: Sven Eckelmann <sven@narfation.org>

During the initialization of the batadv_wifi_net_device_state, it is enough
to write the wifi_flags once before the batadv_wifi_net_device_state is
added to the batadv_wifi_net_devices rhashtable.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/hard-interface.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/net/batman-adv/hard-interface.c b/net/batman-adv/hard-interface.c
index 43ebf86e7b368..96b8130375a3a 100644
--- a/net/batman-adv/hard-interface.c
+++ b/net/batman-adv/hard-interface.c
@@ -987,7 +987,6 @@ batadv_wifi_net_device_insert(struct net_device *net_dev, u32 wifi_flags)
 	if (!device_state)
 		return -ENOMEM;
 
-	device_state->wifi_flags = wifi_flags;
 	netdev_hold(net_dev, &device_state->dev_tracker, GFP_ATOMIC);
 	device_state->netdev = net_dev;
 	WRITE_ONCE(device_state->wifi_flags, wifi_flags);
-- 
2.47.3

