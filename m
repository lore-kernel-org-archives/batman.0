Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAF1DC44506
	for <batman-adv@archiver.kernel.org>; Fri, 10 Jul 2026 20:01:56 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 37834839CB
	for <batman-adv@archiver.kernel.org>; Fri, 10 Jul 2026 22:01:55 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1783713715;
 b=y5hFKq/HpAIsJKtIvHm7b71QAJjhQmSyttIKbGFsHVt2YMzBJf7a8QlOmsAHHIqW50And
 PUoJ971T4ir6HbXA98mWuYqia8VAyDfxh7NXeX2b6IkYWzOcClbrzuZkuMbl7rNL+BsORmI
 WoAJF9qgXz7RVu2izwYfsL7tpF6PntQ=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1783713715; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=7fFZl6cR6yJ1E0qC7Ojntbx6BoRWi2TDZrKor93CJYU=;
 b=rVmLIf229cKfPLolUt54p/vWVzCsyCSh9HGeYkSs0lD8JShCfBHrnLshWpM13EIoJApSC
 3C0MYcBrZ9vXbqzT62lkGoAprEQglwlr6ba6OxPTWj+s2DXdeNX5U24q3Hj/VzlGOYhCBnH
 jS1qREkldL/WOJdLIDEvKowO+TtL8Dc=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org
 [IPv6:2a00:17d8:100::8b1])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id A17AF8195C
	for <b.a.t.m.a.n@lists.open-mesh.org>; Fri, 10 Jul 2026 22:01:26 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1783713686;
	b=jvKcwSATFWo5n7qkXHMv47ILyDdQIiI2ToNeWRiG3m4HucMYzRTgr4FaMVrykp4dHglllR
	OjTjpCQvHjK6pzichK+xe4CbWzQXtmzJk0kpBDMsKLHbLyIflbZe2H04+GdHW9Eour12+M
	FafjVYNMD5SRtLkmDc2LlmRMowfs/po=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1783713686;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=7fFZl6cR6yJ1E0qC7Ojntbx6BoRWi2TDZrKor93CJYU=;
	b=vzbOYDnzUfvxCu0NF3xIsU4xm2OIa5yXo7tsXjjty36aVE62uY4J6OGoQssXnIjeNmatEB
	Lout+MD+ff5ugTjxhZWkTRLlEdWzsJvHHQ24g+yRlP5tAHYg9V0l/5Iljxdapa6rhAFiFP
	5n4mApiQkRMqFOsq5WrEI3hGs7xqkOI=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=Wazw9yke;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id 37ED22058C;
	Fri, 10 Jul 2026 20:01:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1783713686;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7fFZl6cR6yJ1E0qC7Ojntbx6BoRWi2TDZrKor93CJYU=;
	b=Wazw9ykeph8xFVYcD+ncanym90L0NyvCNS60JqnZpHJEJZPmUZ1+YTloSHQ5BsRV9mDo6U
	GwsCLWe7tafiq0TtBalLz9iHe/Qa5V9fF/9cfn2OcBRQ0noTXITzY07/HVK90zriX3Q5a5
	ohYMXl8gigkxW7930p3Uw8z1hZexYmQ=
From: Sven Eckelmann <sven@narfation.org>
Date: Fri, 10 Jul 2026 22:01:16 +0200
Subject: [PATCH batadv v2 2/3] batman-adv: mcast: ensure unshared skb for
 multicast packets
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: 
 <20260710-mcast-header-generation-bugs-v2-2-06cd83c0f534@narfation.org>
References: 
 <20260710-mcast-header-generation-bugs-v2-0-06cd83c0f534@narfation.org>
In-Reply-To: 
 <20260710-mcast-header-generation-bugs-v2-0-06cd83c0f534@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1073; i=sven@narfation.org;
 h=from:subject:message-id; bh=dfABjvIHlTgEg16wDCrHhwR6iRePazqbgA9CvHcQab0=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFmB/n1bbs/o/Srss7Bid9w1032ntIM6GtTitON2eOyYv
 dhpfYplRykLgxgXg6yYIsueK/nnN7O/lf887eNRmDmsTCBDGLg4BWAiu10Z/tnc43wn9aDxwcLu
 XO/8c1/YDutJHj2srPytZ5J32pPLtVEMf+XzFs7drbzgo4emuvuJzxXdWrobJP5+nKDj58/t9km
 SiQMA
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: H6XMWQQ7FHT3P3J3QA4C35YGK2KE53MB
X-Message-ID-Hash: H6XMWQQ7FHT3P3J3QA4C35YGK2KE53MB
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/H6XMWQQ7FHT3P3J3QA4C35YGK2KE53MB/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

When a packet is transmitted via a batman-adv interface and has already
enough room for the header then the nothing will make sure that the skbuff
is unshared. But it is now allowed to modify a currently shared skbuff.

Always make sure that the pskb_expand_head() is not only called for a too
small header but also for shared skbuffs.

Fixes: be9b0169c840 ("batman-adv: mcast: implement multicast packet generation")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/multicast_forw.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/net/batman-adv/multicast_forw.c b/net/batman-adv/multicast_forw.c
index 60ad3a55..c5b8e2e3 100644
--- a/net/batman-adv/multicast_forw.c
+++ b/net/batman-adv/multicast_forw.c
@@ -1100,8 +1100,7 @@ static int batadv_mcast_forw_expand_head(struct batadv_priv *bat_priv,
 		return -EINVAL;
 	}
 
-	if (skb_headroom(skb) < hdr_size &&
-	    pskb_expand_head(skb, hdr_size, 0, GFP_ATOMIC) < 0)
+	if (skb_cow(skb, hdr_size) < 0)
 		return -ENOMEM;
 
 	return 0;

-- 
2.47.3

