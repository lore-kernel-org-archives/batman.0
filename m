Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A57CFCD3439
	for <batman-adv@archiver.kernel.org>; Wed,  6 May 2026 20:27:18 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 31CBF84642
	for <batman-adv@archiver.kernel.org>; Wed, 06 May 2026 22:27:17 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1778099237;
 b=DeFopH49ezzvFlezmGxbUyJ+GWjy0oE8kUNTF30bA2AOtZHuBmYhGZg8bCh0KUWD7TOly
 sPFrHc9oYQdeZcBjIxT1vA6oNhXU02Kij0l2AT1m/0qwnaIp4tOnOYOskdb+Ztk5GnZxAS4
 1pIKjE+c8QRmPMtCen6x5zsJsLp+wKE=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1778099237; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=E7oeW+d2kTwQUAiPKP99mh83CAh/EVd6tcUzolSnDz8=;
 b=KVau49FkY2zS1zmJHHOpOnpNzyAebnmuzsHr2eiSB309pAS48ozBnwHcF+bmsA2JVW8aV
 C45pXhH7S5bdxrgBNecpCFLRa7P7yBBaMyQksiEfQy30eR1XG0tJFm6qVpICRmG72+/JqPa
 I963OGZlxDo2U6ME4jT2CUJbMkZ7mW4=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org
 [IPv6:2a00:17d8:100::8b1])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 69F09844EE
	for <b.a.t.m.a.n@lists.open-mesh.org>; Wed, 06 May 2026 22:22:21 +0200 (CEST)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1778098941;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=E7oeW+d2kTwQUAiPKP99mh83CAh/EVd6tcUzolSnDz8=;
	b=Niayo1lNnvF01fOCsEF0bsmJFG4USEHlaXc2yn25TRYD09B7+Fvcjg7l8StX3mqD9NsNZX
	WDiH8BU5CplJiG3NZJVgXuzFpTR8BNe+25FTNUEl5EXKcbt+3pOoXYFYdf2qcw0/wO2Ntu
	z7ZzbJNz8stP7WwMNWx4FljRhxW0wZ0=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b="j2r/dDFr";
	dmarc=pass (policy=none) header.from=narfation.org;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1778098941;
	b=DbGZErGCWNSkCVHOpbe9lKeUcqHcQgOY1jO66d07N9N6sNP8HMPYpr9OMrmxOGUCMv/LUU
	2DxaehRmSvILkEXWzy8WwAo92xPAtVQPZUhqqjmtPwr486t1HueflgAxyBlBnG95H/Ddu/
	mlCTab1zYTTBwO1pscOa4xr5kY5wThA=
Received: by dvalin.narfation.org (Postfix) id 26AAB20245;
	Wed, 06 May 2026 20:22:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1778098941;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=E7oeW+d2kTwQUAiPKP99mh83CAh/EVd6tcUzolSnDz8=;
	b=j2r/dDFrIPcAYonmGVsheLmUbUzIsvKftQMFdzL6eZxD1hjvFDlXf1YGAV9zzeCgwxG2qN
	z7KS4D+uVYM6CQgmFWC5TPTupztyroH8G9f2VegxjEF0AIHpbt4H2+zPSoBpkkzpvOdfCv
	r6OlMxK1TJnzTWNHmM4BuEeWHhkLlzk=
From: Sven Eckelmann <sven@narfation.org>
Date: Wed, 06 May 2026 22:20:54 +0200
Subject: [PATCH batadv v2 07/11] batman-adv: tt: fix negative
 last_changeset_len
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260506-fixes-followup-v2-7-ce32a2d8d4da@narfation.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1330; i=sven@narfation.org;
 h=from:subject:message-id; bh=yi60lbuycw7okgeAErpbOVkSJ72iiXwdg0ZPDtPalvI=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDJm/Fx3U6n9UlbXS9HvSDIlMkW/WHz9PXnTveNOC/QYLb
 fYZfdZ26yhlYRDjYpAVU2TZcyX//Gb2t/Kfp308CjOHlQlkCAMXpwBMZPllRoaf3q8/MhqHfcrh
 Of9szayL679yL365v7VEeOPbi1yXL6VfYGT4IlB0SjyjZEfcl2I18ePrLN/y/woLfMZVcswmPuL
 CqvlcAA==
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: H7HGYHSTZGT5SDB27AJHAJZLWSEA4Q4A
X-Message-ID-Hash: H7HGYHSTZGT5SDB27AJHAJZLWSEA4Q4A
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/H7HGYHSTZGT5SDB27AJHAJZLWSEA4Q4A/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

batadv_piv_tt::last_changeset_len len was declared as s16, but the field is
never intended to hold a negative value. When a value greater than 32767 is
assigned, it wraps to a negative signed integer.

In batadv_send_my_tt_response(), last_changeset_len is temporarily widened
to s32. The incorrectly negative s16 value propagates into the s32, causing
batadv_tt_prepare_tvlv_local_data() to allocate a full sized buffer but
populates only a small portion of it with the collected changeset. All
remaining bits are kept uninitialized.

Using an u16 avoids this type confusion and ensures that no (negative) sign
extension is performed in batadv_send_my_tt_response().

Fixes: cea194d90b11 ("batman-adv: improved client announcement mechanism")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/types.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/batman-adv/types.h b/net/batman-adv/types.h
index 0f3814b4..179b90c1 100644
--- a/net/batman-adv/types.h
+++ b/net/batman-adv/types.h
@@ -993,7 +993,7 @@ struct batadv_priv_tt {
 	 * @last_changeset_len: length of last tt changeset this host has
 	 *  generated
 	 */
-	s16 last_changeset_len;
+	u16 last_changeset_len;
 
 	/**
 	 * @last_changeset_lock: lock protecting last_changeset &

-- 
2.47.3

