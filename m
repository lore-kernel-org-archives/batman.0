Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73E37CD342C
	for <batman-adv@archiver.kernel.org>; Wed,  6 May 2026 20:25:41 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 03A0E846BD
	for <batman-adv@archiver.kernel.org>; Wed, 06 May 2026 22:25:40 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1778099140;
 b=oMZVasQzd4x7Ov+4xnHolsI3gSPbPUxj6aKrAptJWgxUguiXHkhhQGnywJD+1SzepzkDB
 dJJ+YLVUQcL3aQqxyxIYZ0hZlp3mUQjihmbITwaD0a/l1QkTROKaut++owyDTuxt3GQh6r5
 Glbd0wGkOOvLMKkEBdVVFDBm+ns3Cpw=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1778099140; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=O5AWQoBYufMDBnlGATMozmqGS76eKQ9NwTA10Anus0M=;
 b=PjAjwzrPKds13gwOZ1n1JwEdFuoHGOBHKoszzdVtPr42irIW1LDudL9jzokaNn8GtUC7T
 Kpo/I1+CXwVSVPvaRoYWhGAi9Aoi/FiGCWodK1clfkpqNeyWWwfYwEd2kfNK130LlFDQIdx
 mtJyZH5DX3q+AulElWQeOC4V9ToPVuY=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org
 [IPv6:2a00:17d8:100::8b1])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id D44068454A
	for <b.a.t.m.a.n@lists.open-mesh.org>; Wed, 06 May 2026 22:22:16 +0200 (CEST)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1778098936;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=O5AWQoBYufMDBnlGATMozmqGS76eKQ9NwTA10Anus0M=;
	b=U5cYiYqBJg9VQoBmT2XEAxWARBjJT+dUQHApwwMEd5xsvIb+bUkNp/8T5SZ68JkjfULL4d
	XmJ8ljE0V6jlaRFS8XQEyEN6sdHohhElQkXlCS0hoFTsIRVb6B6bkTGVsMxg8wd8aJYfY0
	u+jsdQlaiuF8WkK9ptfGdzw4MTlzSFg=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=IeCIX8TW;
	dmarc=pass (policy=none) header.from=narfation.org;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1778098936;
	b=Px4EYqvnGjxT2bHqHHA0ZhaQ/PkJBG/MNdVdFkMjtWPZAl6hccB7121LDmf9Cl2hYJTUSW
	y4IyXHC+oCfhCdno9JAIZTS6jdctz4DQ5HKwXio5oQgQomjHEjYV4oZ6MD5ZBJk01mmUe3
	jks2LAc74OvpgM9wVx6AzDKxpTAr19M=
Received: by dvalin.narfation.org (Postfix) id 8CB9221721;
	Wed, 06 May 2026 20:22:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1778098936;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=O5AWQoBYufMDBnlGATMozmqGS76eKQ9NwTA10Anus0M=;
	b=IeCIX8TWw0wKjxcdN+Wb/RNF40b/5rgo4iFixtM85FMG+K3fnoetCPSnIWscml2e9ftfd/
	iTZvgY9NpRwgLh5Lfo1TmFvF0ljED7OG7DOwaekbxzjtBsGWAnYnPxIVbod2UEhcaqVblb
	B9Nm2O6B6gq7hDtEZtXxXDmmJttZxWA=
From: Sven Eckelmann <sven@narfation.org>
Date: Wed, 06 May 2026 22:20:52 +0200
Subject: [PATCH batadv v2 05/11] batman-adv: bla: put backbone reference on
 failed claim hash insert
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260506-fixes-followup-v2-5-ce32a2d8d4da@narfation.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=966; i=sven@narfation.org;
 h=from:subject:message-id; bh=xHZ9i0+jmVjJHDkS9AmGUYQr0OW/pgCEiErDRA6aAIQ=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDJm/Fx1wvxWVtndZwdGVd1wbI/5KdF2c9Pacz4FjjCaal
 7Yvzucu7ihlYRDjYpAVU2TZcyX//Gb2t/Kfp308CjOHlQlkCAMXpwBMROYsw//8ti7zX2wvj3f9
 etGQO2u1F2vJDFedZSy7X2lKMbqsbmZgZHiZ/3/nx56w0IVi20qucZnvDQraXDXlRqziBTvDM6Z
 /2TkB
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: JQULD2R2STAKTICYBOCZW7BIFWJ33Z4P
X-Message-ID-Hash: JQULD2R2STAKTICYBOCZW7BIFWJ33Z4P
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/JQULD2R2STAKTICYBOCZW7BIFWJ33Z4P/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

When batadv_bla_add_claim() fails to insert a new claim into the hash, it
leaked a reference to the backbone_gw for which the claim was intended.
Call batadv_backbone_gw_put() on the error path to release the reference
and avoid leaking the backbone_gw object.

Fixes: e401297e3a39 ("batman-adv: Fix non-atomic bla_claim::backbone_gw access")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/bridge_loop_avoidance.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/batman-adv/bridge_loop_avoidance.c b/net/batman-adv/bridge_loop_avoidance.c
index 879ab043..cec11f12 100644
--- a/net/batman-adv/bridge_loop_avoidance.c
+++ b/net/batman-adv/bridge_loop_avoidance.c
@@ -723,6 +723,7 @@ static void batadv_bla_add_claim(struct batadv_priv *bat_priv,
 
 		if (unlikely(hash_added != 0)) {
 			/* only local changes happened. */
+			batadv_backbone_gw_put(backbone_gw);
 			kfree(claim);
 			return;
 		}

-- 
2.47.3

