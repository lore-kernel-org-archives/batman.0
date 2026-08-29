Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E03CC61DBE
	for <batman-adv@archiver.kernel.org>; Sat, 29 Aug 2026 06:21:12 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id C46CB83E53
	for <batman-adv@archiver.kernel.org>; Sat, 29 Aug 2026 08:21:10 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1787984470;
 b=24xYoivGLJL0aDYrh0azr/Oq40XGWtwyt0SY0UwI4/DLNEqQYXiYHZcj/ykzGwjsd+oSI
 34NYM6HyVGmSkllWyVL9e9rIK707H8i1GA6VPfInW5luow7yE9P7QxdiaZL5ZpVbCVbznsb
 X5k6MGyyN33EcI0xBVL9CNZ2W56uA8w=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1787984470; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=1IlOR6C+GPrNQ4aD+/eB2iyxMYj31jzTBcuysIy20Y8=;
 b=yDDfZ1XivbIeK5yXnoIGM+zXGY/dKjU3LBySDo1mZMI/bf+wvEdfz+kzIbkhoLCql0Ix+
 VFgApV3w3XUQS+NAbIbcqDzWvfmaiJXpYgelWuqHGNP0v5uCYKrsZMiAQDg3oxTPwCwgmS0
 kDh1hi0FLKB9u7p37QX7XViW0Yj9j/U=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 992ED84085
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sat, 29 Aug 2026 08:19:31 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1787984371;
	b=Cs97TxBDw7+RhnN7MO2qGTKZ6Rg6qrXT5WJKfvt1fzyom7h5pQWuVwq/qvgDswFyoFsU+u
	pozhWS0kN7L13AdTfY4W/MtKk5T7cxdoimoWIO/o9S8Qzcxk1KfF1bxaFNaCFnpfbivERh
	llhXspPl8ajWDKhTNTgRCbltu3z5Cbw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1787984371;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=1IlOR6C+GPrNQ4aD+/eB2iyxMYj31jzTBcuysIy20Y8=;
	b=FlVffCJ66HDpRbEQKZSxQD98TDAjLbpE98MyZ5L9o7Lv3G7Ctg6MSPvbbLyx2KSItxpGgs
	7AH4UbcyXz69qGXlPSX32QVtWYegNzDkrBdqeCehrxFS0pZz8nE0d4pmO5cJNlulwlRsSF
	Sjd8cHHfkj/DNzZRPlj1J3guTcNaK48=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=k1zZWZ6M;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id 2C8DF1FEC4;
	Sat, 29 Aug 2026 06:19:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1787984367;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1IlOR6C+GPrNQ4aD+/eB2iyxMYj31jzTBcuysIy20Y8=;
	b=k1zZWZ6MaMIwqkdVOn0spaL/Fay/1L01I1/Yzi8+gElBK+KqfF2qQCWG/rs4xHSPdzeRQ/
	TdgHs+r2trHgRYpcrOxvObYmULPkigrrFK8RMa3qRxR+AolyUuhq+5xJAGPbhqr1EiBy8P
	5wva7t4ZKqoOW2TJqHHPuIyVzq1pRwk=
From: Sven Eckelmann <sven@narfation.org>
Date: Sat, 29 Aug 2026 08:18:15 +0200
Subject: [PATCH batadv v5 04/20] batman-adv: tt: drop unnecessary cleanup
 goto in helpers
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260829-tt-fixes-v5-4-88fce8fd683d@narfation.org>
References: <20260829-tt-fixes-v5-0-88fce8fd683d@narfation.org>
In-Reply-To: <20260829-tt-fixes-v5-0-88fce8fd683d@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2546; i=sven@narfation.org;
 h=from:subject:message-id; bh=/kMODKjY1t4GkqfjU9QoPZ9fhD8PHp0kXZ/DXAZKls0=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFmTKtccuOQpwrfLmXF+fN/3/pl3Net+MNZrmMlfmnCB9
 dXT/h25HaUsDGJcDLJiiix7ruSf38z+Vv7ztI9HYeawMoEMYeDiFICJWPcw/M+aNEliZaeO8fmm
 CWr1VlWvwrp+1Js4/z5QbvcsL1lomzDDP13XfS7Z/sJHp2U+vjmzaNLTT0duyDySWHOk/Ygb/4H
 D3xgA
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: BCBOPOEH5VVX2GISFBWVG3QGY3CQ5455
X-Message-ID-Hash: BCBOPOEH5VVX2GISFBWVG3QGY3CQ5455
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/BCBOPOEH5VVX2GISFBWVG3QGY3CQ5455/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

To use scoped_guard(), it is not allowed to use goto in the same routine.
These goto's should only be used for cleanups but are not necessary of
minimal helpers like batadv_is_my_client(),
batadv_tt_global_client_is_roaming() and
batadv_tt_local_client_is_roaming(). Removing the goto's is actually making
these functions more readable.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/translation-table.c | 25 ++++++++++++-------------
 1 file changed, 12 insertions(+), 13 deletions(-)

diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index 5f0f7fb6..2dcee14d 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -3597,19 +3597,18 @@ bool batadv_is_my_client(struct batadv_priv *bat_priv, const u8 *addr,
 			 unsigned short vid)
 {
 	struct batadv_tt_local_entry *tt_local_entry;
-	bool ret = false;
+	bool ret;
 
 	tt_local_entry = batadv_tt_local_hash_find(bat_priv, addr, vid);
 	if (!tt_local_entry)
-		goto out;
+		return false;
+
 	/* Check if the client has been logically deleted (but is kept for
 	 * consistency purpose)
 	 */
-	if ((tt_local_entry->common.flags & BATADV_TT_CLIENT_PENDING) ||
-	    (tt_local_entry->common.flags & BATADV_TT_CLIENT_ROAM))
-		goto out;
-	ret = true;
-out:
+	ret = !((tt_local_entry->common.flags & BATADV_TT_CLIENT_PENDING) ||
+		(tt_local_entry->common.flags & BATADV_TT_CLIENT_ROAM));
+
 	batadv_tt_local_entry_put(tt_local_entry);
 	return ret;
 }
@@ -4135,15 +4134,15 @@ bool batadv_tt_global_client_is_roaming(struct batadv_priv *bat_priv,
 					u8 *addr, unsigned short vid)
 {
 	struct batadv_tt_global_entry *tt_global_entry;
-	bool ret = false;
+	bool ret;
 
 	tt_global_entry = batadv_tt_global_hash_find(bat_priv, addr, vid);
 	if (!tt_global_entry)
-		goto out;
+		return false;
 
 	ret = tt_global_entry->common.flags & BATADV_TT_CLIENT_ROAM;
 	batadv_tt_global_entry_put(tt_global_entry);
-out:
+
 	return ret;
 }
 
@@ -4161,15 +4160,15 @@ bool batadv_tt_local_client_is_roaming(struct batadv_priv *bat_priv,
 				       u8 *addr, unsigned short vid)
 {
 	struct batadv_tt_local_entry *tt_local_entry;
-	bool ret = false;
+	bool ret;
 
 	tt_local_entry = batadv_tt_local_hash_find(bat_priv, addr, vid);
 	if (!tt_local_entry)
-		goto out;
+		return false;
 
 	ret = tt_local_entry->common.flags & BATADV_TT_CLIENT_ROAM;
 	batadv_tt_local_entry_put(tt_local_entry);
-out:
+
 	return ret;
 }
 

-- 
2.47.3

