Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16C63CD98CF
	for <batman-adv@archiver.kernel.org>; Sat, 13 Jun 2026 20:58:09 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id AD775842BA
	for <batman-adv@archiver.kernel.org>; Sat, 13 Jun 2026 22:58:07 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1781384287;
 b=bgXBHV4EFf/AGJX6rzDznO1QnTdS5gCtdrKmsJgrV9dv03I3G8ZwYzlKmMZRpcQn5bsZn
 MUZZL3OeKptSrYIYPrAKFy0Mcfc5RVvIyUpWlgZ/fhKnxpC9cptQ4O/GGjFJP/NFdM5t91v
 JVtc0LwPA+0h1/lyOXkChi7UJHTRKIk=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1781384287; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=+KaNbKIMJykmOXrg/jugaeyPYw+R9XzW3udhwy8n93s=;
 b=oplZ8xqIJvPG6uRrm4ubmmFwqM+4klIBmRxkfYMtfxus0HLuJlFsskkb3AFijzt3VK/9C
 gHEVTLN+Fu6p3FPrN/LPQu4jRVXD7dl5DhAM5zlw4K11R8mNXucwlYAmWheQFsU+XwXzsCx
 yzBweRjIxtCHkbjt/GjrqEMzoWLE0aY=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id A093383DA9
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sat, 13 Jun 2026 22:56:55 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1781384220;
	b=GKokUhuNrYKPuGABxhWPHeHARXOHOkYQKHXhswAM0lmq307sutLX3keXbV2uhBsAqtrZDR
	wD2CHr7JvFtSoy4jVsTrlf33aXsglBQyLnCAjcNdeCQ4WW60MYiP/+Fkk2LkJNHVZgIUns
	BC6lCmo/ce6/pCQjLpAUvhUQlKFC8Co=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1781384220;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=+KaNbKIMJykmOXrg/jugaeyPYw+R9XzW3udhwy8n93s=;
	b=CZWvdYmpVC/4B5335ICalt602eBLwRrEdZPkuEfZQRA42fafxDlpdACxdktztOsWwL4lVv
	/PmJel3x85frxuF2kwgdXPoPxLcpc9Tv3NEyzzDfEWzoyq0pkmtCmOhUzSni/ga36O8kpr
	Zy5Prc3GL+WxjIdXkuA7SRi5pwL2p18=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b="Y/a47KT5";
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id 46A56200C6;
	Sat, 13 Jun 2026 20:56:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1781384215;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+KaNbKIMJykmOXrg/jugaeyPYw+R9XzW3udhwy8n93s=;
	b=Y/a47KT5B694iN+kWY6YcAGkB4yws4SEMQ7Yz0wJKUT5Nk56zeBfODZU6evhLX8Z/MbxpS
	Qum/gYy6UyRvsDV79QVFr8Ut4R5I4+80WnLMkEVhP5j/co0JniGQHQpJA8junjY1FHQKFK
	EgmKU+ZcfKnl52XDOQxIgA1VsUwmKd4=
From: Sven Eckelmann <sven@narfation.org>
Date: Sat, 13 Jun 2026 22:56:41 +0200
Subject: [PATCH RFC batadv 1/3] batman-adv: tt: don't merge change entries
 with different VIDs
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260613-tt-atomic-refactor-v1-1-9f6a762c5d24@narfation.org>
References: <20260613-tt-atomic-refactor-v1-0-9f6a762c5d24@narfation.org>
In-Reply-To: <20260613-tt-atomic-refactor-v1-0-9f6a762c5d24@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1424; i=sven@narfation.org;
 h=from:subject:message-id; bh=N0ecrvQdmbY4yWHUqWP2nZ3oq9aXMJmKsVbcVAU1cdA=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFm6RwR/fMg7obq0sFi1acnq9utmuy4HPP/0h/nEzc4Xp
 hr/5kXs6ChlYRDjYpAVU2TZcyX//Gb2t/Kfp308CjOHlQlkCAMXpwBM5LAEI8OKT3oHTi2bsPHs
 bLfg7QuTp8QGv9pxLLX5Ie/0r4JT2SXvMDKsUYxOvvz4kEJ5u3XjVPfNgqqfL0y0z/r/Zb5f7YH
 +VbeZAQ==
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: TLUEJVKM57KWZFPVDHPT6AYNPXZFP2QU
X-Message-ID-Hash: TLUEJVKM57KWZFPVDHPT6AYNPXZFP2QU
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/TLUEJVKM57KWZFPVDHPT6AYNPXZFP2QU/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

batadv_tt_local_event() merges/cancels events for the same client which
would conflict or be duplicates. The matching of the queued events only
compares the MAC address - the VLAN ID stored in each event is ignored.

If a MAC would now appear on multiple VID, the two ADD change events (for
VID 1 and VID 2) would be merged to a single vid event. The remote can
therefore not calculate the correct TT table and desync. A full translation
table exchange is required to recover from this state.

A check of VID is therefore necessary to avoid such wrong merges/cancels.

Fixes: 580d7919f19e ("batman-adv: add the VLAN ID attribute to the TT entry")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/translation-table.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index 884bb0c0..4517356e 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -487,6 +487,9 @@ static void batadv_tt_local_event(struct batadv_priv *bat_priv,
 		if (!batadv_compare_eth(entry->change.addr, common->addr))
 			continue;
 
+		if (entry->change.vid != tt_change_node->change.vid)
+			continue;
+
 		del_op_entry = entry->change.flags & BATADV_TT_CLIENT_DEL;
 		if (del_op_requested != del_op_entry) {
 			/* DEL+ADD in the same orig interval have no effect and

-- 
2.47.3

