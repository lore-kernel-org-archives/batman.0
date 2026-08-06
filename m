Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F07A6C55ABF
	for <batman-adv@archiver.kernel.org>; Thu,  6 Aug 2026 09:51:33 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 7046984280
	for <batman-adv@archiver.kernel.org>; Thu, 06 Aug 2026 11:51:32 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1786009892;
 b=HZVq/u6c6/XcQINqAZSljb3DZ0/e0RkxDr/wnGczB6uoMoiIxlyM+5E1WLX+1x+wI7ohe
 HTJwkGV7hfn5BjljOnOe2M7hELlNnTuiCOLjxSY6TzsL2kt/UmI49Xk16h2lRuluQ9pVT+1
 uW4Jwogktv3FQLkOx65LOrPrbq1RFpI=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1786009892; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=p+j0Cb9wrW6S+TR2OOFxbHZLJs8aODjXvghSK34NuH4=;
 b=mglxKrWa3WhLxr9xHLAglAxx3c7cJiXH8qQ/RJxohsUCNkozyj8LTU3HMrlPHCbXZUXnC
 NYaJG3Cv7Y5TDAsiXs1oNBxsylx8BMaahNf1P1M/hVntS4p97VJ3goNmzL0RHLTXRR1qIVl
 +WJWzCw5qFljZoDlnYuVGV1MBwuj5J8=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org
 [IPv6:2a00:17d8:100::8b1])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 38F37817DF
	for <b.a.t.m.a.n@lists.open-mesh.org>; Thu, 06 Aug 2026 11:46:03 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1786009563;
	b=IDv0Bza+tkPCcVlhsM6G87+cfRp9PI9TF60HBlexRBdRvUXqGCUj/CbLGcXLsltcKKHNhN
	DQ4jPgMovs/1V8uKWbr/+0Cfi/vopUEr/qamAOoEpqAWpuaOPwEnz0bHoAAELAvsd6OESH
	pKUS3pDufmT0K5H65g/l82cKSVYCa+A=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1786009563;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=p+j0Cb9wrW6S+TR2OOFxbHZLJs8aODjXvghSK34NuH4=;
	b=OsMIuTx9XHY2FEVLM2HhUe56oo3wpOIlBHWY4QxhjMLy5FcpeOApfih7F8z6neqDaZ7NEw
	Ckn1Cix7I22kdwSiLffQOP08RH5pFlSlPHwowsy95km7A1AQy9y7rRi5jQnpsR2A/IiUzN
	0/axKcVaG+F8rk/U+8p2jIoXdmaXDo0=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b="N6Ix/j/M";
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id DB5AA20019;
	Thu, 06 Aug 2026 09:45:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1786009558;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=p+j0Cb9wrW6S+TR2OOFxbHZLJs8aODjXvghSK34NuH4=;
	b=N6Ix/j/Me8Dx0j7Fr+ese23drQZxegluBv9vi+m/5M/bjlpi5isjFv5T/TbB84bZe9W8xv
	q3jAD+91Xa6rULfGi4EGsGhBC7oLoN6UcNm9jy5YDVCnWN79dKJDHHkPBFgCZV2EZPhkI5
	LKQeCSsWu5v6OeQCdIhyEOsxk5RDqWg=
From: Sven Eckelmann <sven@narfation.org>
Date: Thu, 06 Aug 2026 11:44:25 +0200
Subject: [PATCH RFC batadv 12/12] batman-adv: tt: drop the cleanup label
 from batadv_tt_local_remove()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260806-tt-add-cleanup-v1-12-ffcad65bccc4@narfation.org>
References: <20260806-tt-add-cleanup-v1-0-ffcad65bccc4@narfation.org>
In-Reply-To: <20260806-tt-add-cleanup-v1-0-ffcad65bccc4@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2227; i=sven@narfation.org;
 h=from:subject:message-id; bh=tXk2PccT8Y4bE0ShFFWIAX+C7/BG2SHbpTbDcSot5K4=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFkl4S2nV5pLz1Z7O397iNRy16T7bS2WfnvvzWq3/Lspz
 sc3+J9fRykLgxgXg6yYIsueK/nnN7O/lf887eNRmDmsTCBDGLg4BWAiT38y/I+x6JrBsWZlgufS
 m+IJsWUlkk1bOG+vvn31bFtXn+KZPaWMDJ8/aTkzNHOrSd8SrRd9En2WM+HN1bcV1dMtlkyQ5Xh
 6gQUA
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: 27IKITZCHNYDT6QLZN44PHJCQ3EA6MYD
X-Message-ID-Hash: 27IKITZCHNYDT6QLZN44PHJCQ3EA6MYD
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/27IKITZCHNYDT6QLZN44PHJCQ3EA6MYD/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

With both locked sections moved to their own helpers, the only thing left
in the cleanup section is the reference of the looked up entry. The "out"
label is therefore only reached with a valid entry, except for the lookup
failure at the very beginning.

Return BATADV_NO_FLAGS directly when there is no entry and let the two
remaining cases be an if/else.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/translation-table.c | 26 ++++++++++----------------
 1 file changed, 10 insertions(+), 16 deletions(-)

diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index fecf1930..e8ec2b6c 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -1578,13 +1578,12 @@ u16 batadv_tt_local_remove(struct batadv_priv *bat_priv, const u8 *addr,
 			   bool roaming)
 {
 	struct batadv_tt_local_entry *tt_local_entry;
-	u16 curr_flags = BATADV_NO_FLAGS;
-	bool pending = false;
+	u16 curr_flags;
 	u16 flags;
 
 	tt_local_entry = batadv_tt_local_hash_find(bat_priv, addr, vid);
 	if (!tt_local_entry)
-		goto out;
+		return BATADV_NO_FLAGS;
 
 	flags = BATADV_TT_CLIENT_DEL;
 	/* if this global entry addition is due to a roaming, the node has to
@@ -1594,20 +1593,15 @@ u16 batadv_tt_local_remove(struct batadv_priv *bat_priv, const u8 *addr,
 	if (roaming)
 		flags |= BATADV_TT_CLIENT_ROAM;
 
-	pending = batadv_tt_local_mark_removed(tt_local_entry, roaming,
-					       &curr_flags);
-	if (pending) {
-		batadv_tt_local_set_pending_event(bat_priv, tt_local_entry, flags,
-						  message);
-		goto out;
-	}
+	if (batadv_tt_local_mark_removed(tt_local_entry, roaming, &curr_flags))
+		batadv_tt_local_set_pending_event(bat_priv, tt_local_entry,
+						  flags, message);
+	else
+		/* if this client has been added right now, it is possible to
+		 * immediately purge it
+		 */
+		batadv_tt_local_remove_now(bat_priv, tt_local_entry);
 
-	/* if this client has been added right now, it is possible to
-	 * immediately purge it
-	 */
-	batadv_tt_local_remove_now(bat_priv, tt_local_entry);
-
-out:
 	batadv_tt_local_entry_put(tt_local_entry);
 
 	return curr_flags;

-- 
2.47.3

