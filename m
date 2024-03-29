Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE511C6FD1F
	for <batman@archiver.kernel.org>; Fri, 29 Mar 2024 12:35:33 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 2136C81FBB
	for <batman@archiver.kernel.org>; Fri, 29 Mar 2024 13:35:32 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1711715732;
 b=ZkEhTp9wph7BmmTwTEAaPObDNDgNrKfCHCPghegL/LjP7KZuFjchYMF+LnzL+xOKaa0My
 CporxBlp4fgsUGs2w/C1tI/GwZ2/XL+xYIUnVjrQLYLFo7kcaSDoFvkjqkDaF7+80dvLBRf
 DdkpaVTIFSWpht7UBuT+AuRqCzL8MHQ=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1711715732; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=sgi/pf5V7aYciCMxavG6dyw4O67quPKAwvhEprFEDHI=;
 b=ljLwwWKINZFAI0CbAG7zc+Dmgkrr10lo1mgm3G4WivrKDcYE5DqBGbMjcAjn65rqd2twm
 5+qafc5HOV+1auT52MGkvmoxDjXeR2dnv+M2ESX+qH0kPRopqb07v8O0gyMvc9uVqDbXgmc
 9seu0Ww+JuvMeD47drPsBzxJPCMjccY=
ARC-Authentication-Results: i=2; open-mesh.org; dkim=pass header.d=kernel.org;
  arc=pass;
  dmarc=pass (Used From Domain Record) header.from=kernel.org
 policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=kernel.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=kernel.org policy.dmarc=none
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 2E7F081BBB
	for <b.a.t.m.a.n@lists.open-mesh.org>; Fri, 29 Mar 2024 13:34:10 +0100 (CET)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1711715650;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=sgi/pf5V7aYciCMxavG6dyw4O67quPKAwvhEprFEDHI=;
	b=MTlv/NcypdakE6/FUnTmBmMptx907ItDPHYjoOTzbIMEZ8viw06ric3PyLrpZKOv5cl9U6
	LPD1QqBI+tD4aQ+kJu7ZDmXqg4mcGHhLP08XN9qaLaPcHHLFzxO3PMDUHmwX5g/qXOdzfI
	YPDEnDqhFg3qsSEZG4PGWv2FWmKYYxo=
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1711715650; a=rsa-sha256;
	cv=none;
	b=HlqIyzV3kqaHb+UowceG6hqsVixBD5cM+BOpQKLt92psc3us/jQhGujyQJdfHnnhWpaIgX
	ZUOS2c16cSMrycGDPLHOoB/JC8zGjLT97lFFl54m03jAYxJKhAsvRwnGhlHo08dT3StLtO
	YIXnOw2shrhHzql06gpcGFwDnJipRwc=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=kernel.org header.s=k20201202 header.b=ot06NQDM;
	spf=pass (diktynna.open-mesh.org: domain of sashal@kernel.org designates
 145.40.73.55 as permitted sender) smtp.mailfrom=sashal@kernel.org;
	dmarc=pass (policy=none) header.from=kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 79714CE296F;
	Fri, 29 Mar 2024 12:34:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 490A2C433C7;
	Fri, 29 Mar 2024 12:34:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711715647;
	bh=WXr6Pj9tx3rS/dc47u7x06zimCghNHXN33j+WnQrsX4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ot06NQDMzmi3vqtLMyGBH5K2rladNJqwNGG9eiypg5FLZcHBiX4TuEsf6yyRV/rmD
	 J5+I7BdnJFOao82nMfU3iJ9Oo8idp5DlbKP2wp9ib6AeiC1C8A+Tocg0E4TANxodeI
	 w0zAfjDp2f/RbVSepm6F5wdrezxcFAvSvma2/8LCr5+FPIZOVFNh3FbNJleMN8+1Rg
	 kfXoVE4TaWiPwXQl0JK52B89gohlfvdvhDP3t4XLQfgcnSYmX9uo+Bx4UT64f6t/uv
	 yR9I1OrcQeGK8WE0NAzcO7A6nmV13cn+O36j6Nn7K8N7KHJeHLtqcYAX8NgV+F9EyA
	 aJuoYjWNeaI7Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Markus Elfring <elfring@users.sourceforge.net>,
	Sven Eckelmann <sven@narfation.org>,
	Simon Wunderlich <sw@simonwunderlich.de>,
	Sasha Levin <sashal@kernel.org>,
	mareklindner@neomailbox.ch,
	a@unstable.cc,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	b.a.t.m.a.n@lists.open-mesh.org,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 02/17] batman-adv: Return directly after a failed
 batadv_dat_select_candidates() in batadv_dat_forward_data()
Date: Fri, 29 Mar 2024 08:33:41 -0400
Message-ID: <20240329123405.3086155-2-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329123405.3086155-1-sashal@kernel.org>
References: <20240329123405.3086155-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.214
Content-Transfer-Encoding: 8bit
Message-ID-Hash: Z4L3UVSZQTYWCOUWKORYWZIWKGVRIE7C
X-Message-ID-Hash: Z4L3UVSZQTYWCOUWKORYWZIWKGVRIE7C
X-MailFrom: sashal@kernel.org
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/Z4L3UVSZQTYWCOUWKORYWZIWKGVRIE7C/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

From: Markus Elfring <elfring@users.sourceforge.net>

[ Upstream commit ffc15626c861f811f9778914be004fcf43810a91 ]

The kfree() function was called in one case by
the batadv_dat_forward_data() function during error handling
even if the passed variable contained a null pointer.
This issue was detected by using the Coccinelle software.

* Thus return directly after a batadv_dat_select_candidates() call failed
  at the beginning.

* Delete the label “out” which became unnecessary with this refactoring.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
Acked-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/batman-adv/distributed-arp-table.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/net/batman-adv/distributed-arp-table.c b/net/batman-adv/distributed-arp-table.c
index ddd3b4c70a516..b1cb6ecffceb9 100644
--- a/net/batman-adv/distributed-arp-table.c
+++ b/net/batman-adv/distributed-arp-table.c
@@ -687,7 +687,7 @@ static bool batadv_dat_forward_data(struct batadv_priv *bat_priv,
 
 	cand = batadv_dat_select_candidates(bat_priv, ip, vid);
 	if (!cand)
-		goto out;
+		return ret;
 
 	batadv_dbg(BATADV_DBG_DAT, bat_priv, "DHT_SEND for %pI4\n", &ip);
 
@@ -731,7 +731,6 @@ static bool batadv_dat_forward_data(struct batadv_priv *bat_priv,
 		batadv_orig_node_put(cand[i].orig_node);
 	}
 
-out:
 	kfree(cand);
 	return ret;
 }
-- 
2.43.0

