Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89B30CD342C
	for <batman-adv@archiver.kernel.org>; Wed,  6 May 2026 20:24:11 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 2868484764
	for <batman-adv@archiver.kernel.org>; Wed, 06 May 2026 22:24:10 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1778099050;
 b=JsTD5bZm0Uk2y7dAFc9Q3dQWCQF3qDF18Y5nWVYrrOz+o9ZSlg7ZA0NP86I3ttOiXkWU0
 jVwOFhEmdoO34XyngmZEQErdODqRcu+wBh7QUmV/Bkgf9q7N8Z/iJGXJdbSAIO+7J3l0V67
 FSRaRjtuWwFPIfBC513ZAEY22F6qjBY=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1778099050; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=CR89lGGyHpjx+JkV3AnqDI9MxrmadO6Anq4RY2o6Drk=;
 b=hGBKdNpWSlycMbLP02n69hrcMDPI6MomUYQU5eA4SG5Qxw8DNNAi9gks7Ar+sgKYNG61d
 LLyF/XXNXerwkAPaVnae4vR32fgCjqwyOnKuLVsQo9S1Z2pv0Gkxrzcv2cNJwhSQcmpGDNk
 zd/SMtRfiOW+NMMgkj/d++xYhiVPLt0=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org
 [IPv6:2a00:17d8:100::8b1])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 6657184472
	for <b.a.t.m.a.n@lists.open-mesh.org>; Wed, 06 May 2026 22:22:12 +0200 (CEST)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1778098932;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=CR89lGGyHpjx+JkV3AnqDI9MxrmadO6Anq4RY2o6Drk=;
	b=uW1k8BuqKb/ltXGXGRoe7lrqARumEG7x0QFWK1k2O1c8/9PcFQTYTSnBjSP/Yi6ia74Is5
	kiQ6daO+gBHQvsQFz+4Zm+1KmqzijRVg8OSlcL3080YVtDMnttQg52eCU2xOWS7LGy+7oa
	bJaZdhPSfpWJPjfKbzcvUCsb9DfNAzw=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=enOdzJc8;
	dmarc=pass (policy=none) header.from=narfation.org;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1778098932;
	b=aw33QsllpFqSzRlVG6/0Pri+GbwRF+z9Lp+Y+ab4ocUOVUWUUM4w20reoJpzogeGpbr4e6
	Zad1AKK6TSBdgyp/S32k1NPKhU3xhZfYeLQVNvOwem8yc1zbtccyVlpO1Qeg59SpI5oXPJ
	vUYReDdZUyUQBVJjjqd66lEZVc563w8=
Received: by dvalin.narfation.org (Postfix) id 216D920DD3;
	Wed, 06 May 2026 20:22:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1778098932;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CR89lGGyHpjx+JkV3AnqDI9MxrmadO6Anq4RY2o6Drk=;
	b=enOdzJc8k7Jiyf/D2pmRETO0NdBObH8IlCJVm3mRVbkl7P0h1/pmBR+UwdJWVwDSpMcXjJ
	w3mJI4rGQ61CEqOyVLaTp9x9/Ic9jKrSBrYtTi7UHhkOu3vnANonq7FWHGzFujVzqM69p1
	j+BkWGyVg5VmBd7YNvQ/GYQzti61tu0=
From: Sven Eckelmann <sven@narfation.org>
Date: Wed, 06 May 2026 22:20:50 +0200
Subject: [PATCH batadv v2 03/11] batman-adv: bla: prevent use-after-free
 when deleting claims
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260506-fixes-followup-v2-3-ce32a2d8d4da@narfation.org>
References: <20260506-fixes-followup-v2-0-ce32a2d8d4da@narfation.org>
In-Reply-To: <20260506-fixes-followup-v2-0-ce32a2d8d4da@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Ao Zhou <n05ec@lzu.edu.cn>, Haoze Xie <royenheart@gmail.com>,
 Jiexun Wang <wangjiexun2025@gmail.com>, Juefei Pu <tomapufckgml@gmail.com>,
 Luxing Yin <tr0jan@lzu.edu.cn>, Ren Wei <n05ec@lzu.edu.cn>,
 Ruide Cao <caoruide123@gmail.com>, Xin Liu <bird@lzu.edu.cn>,
 Yifan Wu <yifanwucs@gmail.com>, Yuan Tan <yuantan098@gmail.com>,
 Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1243; i=sven@narfation.org;
 h=from:subject:message-id; bh=HjUBQFGF5nZVsWEVvWVuMw7bo6M8+Cc+cDTZzdS7Cpg=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDJm/Fx2wbb3hzn7624tPMgG7d3t91W7YFTZndsacnHuJQ
 mIZ/nvmdpSyMIhxMciKKbLsuZJ/fjP7W/nP0z4ehZnDygQyhIGLUwAmUvOQkaHr5oHHZodVe2M/
 zT49fVHIMzMVjZLLzx7/cVRrjM9XP7aakeFwjPdj+ymST4/efl65w+GacKeE70r7D/b7/czXWjp
 eWMgKAA==
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: MLL4FPWWCSZTW7LA3JI7V5BN3BCYMLZF
X-Message-ID-Hash: MLL4FPWWCSZTW7LA3JI7V5BN3BCYMLZF
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/MLL4FPWWCSZTW7LA3JI7V5BN3BCYMLZF/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

When batadv_bla_del_backbone_claims() removes all claims for a backbone, it
does this by dropping the link entry in the hash list. This list entry
itself was one of the references which need to be dropped at the same time
via batadv_claim_put().

But the batadv_claim_put() must not be done before the last access to the
claim object in this function. Otherwise the claim might be freed already
by the batadv_claim_release() function before the list entry was dropped.

Fixes: a9ce0dc43e2c ("batman-adv: add basic bridge loop avoidance code")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/bridge_loop_avoidance.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/batman-adv/bridge_loop_avoidance.c b/net/batman-adv/bridge_loop_avoidance.c
index 51fe028b..8b77dd2e 100644
--- a/net/batman-adv/bridge_loop_avoidance.c
+++ b/net/batman-adv/bridge_loop_avoidance.c
@@ -318,8 +318,8 @@ batadv_bla_del_backbone_claims(struct batadv_bla_backbone_gw *backbone_gw)
 			if (claim->backbone_gw != backbone_gw)
 				continue;
 
-			batadv_claim_put(claim);
 			hlist_del_rcu(&claim->hash_entry);
+			batadv_claim_put(claim);
 		}
 		spin_unlock_bh(list_lock);
 	}

-- 
2.47.3

