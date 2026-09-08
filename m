Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8875C79F82
	for <batman-adv@archiver.kernel.org>; Tue,  8 Sep 2026 17:24:33 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 080F383169
	for <batman-adv@archiver.kernel.org>; Tue, 08 Sep 2026 19:24:32 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1788888272;
 b=gyvZ/hft0eKSJ5CgQJxH8KE2oWquRX3YXhNVKFZ1oRA/GxWSg/Y7vaPAuNpE+30x5HLIY
 tPnCAcmdlY4jGAe3iG+Sne/1IKNeyowVyszxtLkNWAx9565a6ecWJmI5jye5hV4vTOLUPVz
 vEwuN/JqsJ6sPfF05hrxYBFYsZrxGSA=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1788888272; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=KNTtvWQN6gERPrPjIe3MWdboW7hjHT/xsg/g2YlrFic=;
 b=cSwFIPLBZlzbhvIOo4hPHlGmOm6g4cbyb6Xsypg7HUuhb5X8UevebPB7YX5tjwiuSfUco
 o3G0gjkPYUO+vllW39xpTYsj8BeClLUdFZF49f/0mnFe5dfDcppilvUYs9ONgWTNz4ae3FB
 ViShzMU/E3c30/DMIiNRKjauR1Hi/4Q=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id B5C8E80F8E
	for <b.a.t.m.a.n@lists.open-mesh.org>; Tue, 08 Sep 2026 19:23:46 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1788888231;
	b=nc+fR31DF3KI4qH7ZeZUkw99TSL7h7t5/zrQG3Pnf8hH/AIC+7dmdNqwS8kKKjmTwX2grh
	crQIvjx73C/BXdehqELfbF8vfia8EFDx5xBU1/3QR+lwVjuwz5D4xoDuoWIXW3M335V52Y
	Z6Aa3W+OEHx/IXqFLuvLXxjawpAW8G0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1788888231;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=KNTtvWQN6gERPrPjIe3MWdboW7hjHT/xsg/g2YlrFic=;
	b=fARoozjtgw6J4auhTs2icSzs8FCA5668cUtyL9kiBlzJmWe1RInYXAL+EBkG5SWs/4+hQL
	DOtnPCQHpZTRiy549q0q4ugm71cn/mh1/ndcmBvENjRFLm9zQAQLt8JSAsRdAPv/2W3Hrc
	OsKQduyc/APQgrrqlgPGipj6K5NS8fM=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=i1IiX7Eu;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id 37FC620317;
	Tue, 08 Sep 2026 17:23:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1788888226;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KNTtvWQN6gERPrPjIe3MWdboW7hjHT/xsg/g2YlrFic=;
	b=i1IiX7EuwwM14LhPw3CRtElRFDlyX5TAh2h/qV9vkrCkUInX1ggjPWQYKjgVwoemtO3Ah9
	KNOWgnV9Adi+J7TGSinzg/ZBTa+dO0B+s3wgaq0umSlnidD/49KyDNyGUslaAubXYsdZJh
	PvjN1U3XbUTZUXgPuqpfH7zv6iGnR4s=
From: Sven Eckelmann <sven@narfation.org>
Date: Tue, 08 Sep 2026 19:23:35 +0200
Subject: [PATCH batadv 1/3] batman-adv: tt: clarify kernel-doc for
 batadv_tt_global_purge_local
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260908-sashiko-kdoc-v1-1-535b498f2519@narfation.org>
References: <20260908-sashiko-kdoc-v1-0-535b498f2519@narfation.org>
In-Reply-To: <20260908-sashiko-kdoc-v1-0-535b498f2519@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>, Sashiko <sashiko-bot@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1511; i=sven@narfation.org;
 h=from:subject:message-id; bh=uXLUO6OPvOUO9L9j+XNymk5SAXO3m5fzKmDos0aiNEI=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFkLXOaUb+8Wkt0cdOD8/l99PdYqa9Wnpu1v7Tr2YtvGW
 T8Tu38yd5SyMIhxMciKKbLsuZJ/fjP7W/nP0z4ehZnDygQyhIGLUwAmImnHyDBJpeDMc+WrpxhC
 nk1Lf2La/833/gKHA/bSa+VM3AwTf4YxMtyctvn4rcWnI2ekzt8posFm57rStsxXZEoj9+3ct1a
 hJ9gA
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: XHIAKZRLWXLOFO6SCDCYWKKAELERZ4HX
X-Message-ID-Hash: XHIAKZRLWXLOFO6SCDCYWKKAELERZ4HX
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/XHIAKZRLWXLOFO6SCDCYWKKAELERZ4HX/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

The new kernel-doc didn't mention the "non-multicast clients" limitation.
It was also not clear that the roaming flag gets cleared when the
announcement didn't contain the roaming flag.

Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260907081824.2474040-1-sw%40simonwunderlich.de?part=9
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/translation-table.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index 775e60dd..b3b9ac59 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -1923,9 +1923,10 @@ batadv_tt_global_orig_entry_add(struct batadv_tt_global_entry *tt_global,
  * @tt_global_entry: the global TT entry of the announced client
  * @flags: TT flags announced for this non-mesh client
  *
- * A client which is announced by another originator is no longer a local
- * client. Remove it from the local table and take over the WIFI flag it was
- * tracked with.
+ * A non-multicast client which is announced by another originator is no longer
+ * a local client. Remove it from the local table and (for the global entry)
+ * take over the WIFI flag it was tracked with. Reset the roaming flag in case\
+ * the announcement didn't contain the roaming flag.
  */
 static void
 batadv_tt_global_purge_local(struct batadv_priv *bat_priv,

-- 
2.47.3

