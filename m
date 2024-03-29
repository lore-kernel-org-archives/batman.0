Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A554FC6FD1F
	for <batman@archiver.kernel.org>; Fri, 29 Mar 2024 12:37:46 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 1D303824B7
	for <batman@archiver.kernel.org>; Fri, 29 Mar 2024 13:37:45 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1711715865;
 b=w/JjdTqpYlLL8UlBFoyP8zNe/REujoQPJMK4TF2fvWfHQz5Kiq9fImsxO92L//aUtNLTD
 kaetDFpcjnZF1s/cpd4kIuaSXv7c/6xZSkzGyGwpRQEUe3nPehZnphcbu8zsXde5/rouY+a
 FIwFk3Nfs6/hQrxT6CBFTlML0Ox0y+4=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1711715865; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=L5l2lXQGgDaiRJOEpQ4lWDkJti5TrvgbY1mmU4dW2Zo=;
 b=ak0V37Nq0kjdXq5ZxNC1SX4a9aSrmGc9b8slEItffqHOpjIOfeaPRDZUQ4PRGWafyQb/z
 P0XRTppfJLyZuPAxmBQXutCrUyzf53FnqaL2tRthyAgPKc1kmSfOPWsQfXI5/eBlO7bDn30
 CP+CJbMCvzOEQd+WRuzWHmZAIPo53xU=
ARC-Authentication-Results: i=2; open-mesh.org; dkim=pass header.d=kernel.org;
  arc=pass;
  dmarc=pass (Used From Domain Record) header.from=kernel.org
 policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=kernel.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=kernel.org policy.dmarc=none
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 76E5D81D80
	for <b.a.t.m.a.n@lists.open-mesh.org>; Fri, 29 Mar 2024 13:34:51 +0100 (CET)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1711715692;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=L5l2lXQGgDaiRJOEpQ4lWDkJti5TrvgbY1mmU4dW2Zo=;
	b=hIHdXpeKYwmB2sdSVZbRnnQQUYGYEQ/3rn/af9TtRncvYEhWPG3oW7puaZ8z6TPRij8aSG
	YXpZyGV/yXgfHMQ9lZ8tZUtIBiE6RjqB6R9RcX5phHHYvguiLh2xs00+9ragg76ZYgCfre
	TZFGlv7iG6/JnCS69cZJGpm3VUrIg7A=
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1711715692; a=rsa-sha256;
	cv=none;
	b=PvkIPIJ/iv49Ugc0dh9GhxLGIoJJeqpeSqzUH79hq63NN7TAzZLyWZS2mU4fb66Aaw0DmE
	Q5YTTgDUKej50W3Rzmby/cgTFzL3yOfzcSBM0nlvG2GTNBl7IXhpi0j4PGh4UJNFQYvssu
	v+UxvqIoK9EvB4WHjbg9NPIHhnIKArw=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=kernel.org header.s=k20201202 header.b=Rwnii0iI;
	spf=pass (diktynna.open-mesh.org: domain of sashal@kernel.org designates
 2604:1380:4641:c500::1 as permitted sender) smtp.mailfrom=sashal@kernel.org;
	dmarc=pass (policy=none) header.from=kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 5B40C6192C;
	Fri, 29 Mar 2024 12:34:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E81DC433F1;
	Fri, 29 Mar 2024 12:34:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711715690;
	bh=VzxgSt9qr0sgRrcyGHyXM3zzqjFvvX/PIaRhKFdq/l8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Rwnii0iIV0qySSYOb1wU81wvuYilwB33l2jDT5GB2D8Z/n1PrwbiAJX6iwFmAyIyT
	 iU5Y84FR1y/uNuYrDiMAlcL2J8rzlv0voS7Kkgs4eB1VionphStmaFLDy/ftlb2Qez
	 yM5s+zwiNI7gt49s3vjFbI10iOOzFjz8kRrjo8bHS69Rwv0F45HAks3nmLp198UOvT
	 NWueQbDt989+hGXd0OzeO/K8+eOeKHCKSS7mqPw4L7rg+tLjdARNdISw8p+DTyZbPq
	 T0t+SxtjsW5k7OigChvBAMNXHplWFeIETW87r/0AbP66VrmOp3VlT+0lwdXP6DhChl
	 1UR4fdGWL/LGA==
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
Subject: [PATCH AUTOSEL 5.4 03/15] batman-adv: Improve exception handling in
 batadv_throw_uevent()
Date: Fri, 29 Mar 2024 08:34:26 -0400
Message-ID: <20240329123445.3086536-3-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329123445.3086536-1-sashal@kernel.org>
References: <20240329123445.3086536-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.273
Content-Transfer-Encoding: 8bit
Message-ID-Hash: ODJSUFBGR4JPSRPPWXFLCU5BQ2TTPEXG
X-Message-ID-Hash: ODJSUFBGR4JPSRPPWXFLCU5BQ2TTPEXG
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/ODJSUFBGR4JPSRPPWXFLCU5BQ2TTPEXG/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

From: Markus Elfring <elfring@users.sourceforge.net>

[ Upstream commit 5593e9abf1cf2bf096366d8c7fd933bc69d561ce ]

The kfree() function was called in up to three cases by
the batadv_throw_uevent() function during error handling
even if the passed variable contained a null pointer.
This issue was detected by using the Coccinelle software.

* Thus adjust jump targets.

* Reorder kfree() calls at the end.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
Acked-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/batman-adv/main.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/net/batman-adv/main.c b/net/batman-adv/main.c
index 6a183c94cdeb4..62425d19bd598 100644
--- a/net/batman-adv/main.c
+++ b/net/batman-adv/main.c
@@ -733,29 +733,31 @@ int batadv_throw_uevent(struct batadv_priv *bat_priv, enum batadv_uev_type type,
 				  "%s%s", BATADV_UEV_TYPE_VAR,
 				  batadv_uev_type_str[type]);
 	if (!uevent_env[0])
-		goto out;
+		goto report_error;
 
 	uevent_env[1] = kasprintf(GFP_ATOMIC,
 				  "%s%s", BATADV_UEV_ACTION_VAR,
 				  batadv_uev_action_str[action]);
 	if (!uevent_env[1])
-		goto out;
+		goto free_first_env;
 
 	/* If the event is DEL, ignore the data field */
 	if (action != BATADV_UEV_DEL) {
 		uevent_env[2] = kasprintf(GFP_ATOMIC,
 					  "%s%s", BATADV_UEV_DATA_VAR, data);
 		if (!uevent_env[2])
-			goto out;
+			goto free_second_env;
 	}
 
 	ret = kobject_uevent_env(bat_kobj, KOBJ_CHANGE, uevent_env);
-out:
-	kfree(uevent_env[0]);
-	kfree(uevent_env[1]);
 	kfree(uevent_env[2]);
+free_second_env:
+	kfree(uevent_env[1]);
+free_first_env:
+	kfree(uevent_env[0]);
 
 	if (ret)
+report_error:
 		batadv_dbg(BATADV_DBG_BATMAN, bat_priv,
 			   "Impossible to send uevent for (%s,%s,%s) event (err: %d)\n",
 			   batadv_uev_type_str[type],
-- 
2.43.0

