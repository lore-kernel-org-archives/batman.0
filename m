Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64A8DC61DD6
	for <batman-adv@archiver.kernel.org>; Sat, 29 Aug 2026 06:29:41 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id E919980C66
	for <batman-adv@archiver.kernel.org>; Sat, 29 Aug 2026 08:29:39 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1787984979;
 b=xW8sajti04UByqI80uJRp3eqjg9RZ8r7wjeUOb4hRrwR8FVTrk5P+NnZGDJlpbnoZOJF3
 zk/EwPuGqFLysmmwdVoNEoUOw8F/ehHjBBFp0Tz3VXbxkF/9mWm67b541oGjr3hj6jhkNQY
 UQv/yuBR6QU7SiiMBOSRJq0155ijlKo=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1787984979; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=p+j0Cb9wrW6S+TR2OOFxbHZLJs8aODjXvghSK34NuH4=;
 b=SPqE4CHVXIZ6pqN+aIfm5/k4DEX0rHPA6GoQvWQayHM0A6JfHJWfxcUH9OvTKwqtC6yF/
 5FdtgZ2rAhTZMxxqUvOBTC7387b/L7OO2VZEkCWlyJLOcHwEOPT6miqfczsk36sr0RmEJL1
 KSNuNIT4rDKrUtxrs4GfayUMqOrCTs8=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id AF8F680917
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sat, 29 Aug 2026 08:22:58 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1787984578;
	b=yaeNS2okPontKol5/iEn4b8xSb6/Mm8MA1c6NkhR2nnI8v9tSr2ClpnSAA44U732NGwqLC
	UAzYkOSNvtXHWKauQzMwvlVJbGy+ry51mfk98kETjMHohr/PNgL11VdkMJQsApeHMh0M2b
	KgBj/9WxjJDvFBxW6kUarwoSz8Uf0mc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1787984578;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=p+j0Cb9wrW6S+TR2OOFxbHZLJs8aODjXvghSK34NuH4=;
	b=sKEgKLayaRkK81nZUxpFIJMbTgDAC9pkUrWow1I0zRHPzsJLDbxsuDO26T7oUACp94/VP2
	BASdvPtpb/9oHEwahyy6Jjv4LDbMPuqjy+a+H7PrOz8xtEbVbt+JiA+zAq5e4kIJv9T9lu
	pz08XHbr0XFhmj4E6b3ikqN4qf+ycmk=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=Y7P3tISi;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id 3E927200E4;
	Sat, 29 Aug 2026 06:22:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1787984574;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=p+j0Cb9wrW6S+TR2OOFxbHZLJs8aODjXvghSK34NuH4=;
	b=Y7P3tISiYjtwvOVulOHFtMSfxB2DtiOO3TNL4k+yL976lBWVhRC7gH2PWJsYWVSdsZSPim
	AMgFryxD4X+JQamotv/2hl1ydUgnGKk/K0/dZduINhKI3gAzK8HI3hxRpI82NsTT7FhcC6
	GjzWE5tl9czHq8kof6VlnKEjQAbDN+4=
From: Sven Eckelmann <sven@narfation.org>
Date: Sat, 29 Aug 2026 08:18:31 +0200
Subject: [PATCH batadv v5 20/20] batman-adv: tt: drop the cleanup label
 from batadv_tt_local_remove()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260829-tt-fixes-v5-20-88fce8fd683d@narfation.org>
References: <20260829-tt-fixes-v5-0-88fce8fd683d@narfation.org>
In-Reply-To: <20260829-tt-fixes-v5-0-88fce8fd683d@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2227; i=sven@narfation.org;
 h=from:subject:message-id; bh=tXk2PccT8Y4bE0ShFFWIAX+C7/BG2SHbpTbDcSot5K4=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFmTKtfly4ULp/n8fFwppx3KvPFT+yP1KQd1NjL2Cjhcn
 LXAburdjlIWBjEuBlkxRZY9V/LPb2Z/K/952sejMHNYmUCGMHBxCsBE+nwYGd4+8Pxjt/apfMlH
 x59i92NzM/ZMlMos+8vy/6ag6slW+0uMDB1CLE8Kdfx5NZfNWLBVTq5jx8U+LbmYKbt/mQryKR9
 OZgAA
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: 5JSLDRDBZ2QG2MAUEDNVEOFCCQWYSGTV
X-Message-ID-Hash: 5JSLDRDBZ2QG2MAUEDNVEOFCCQWYSGTV
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/5JSLDRDBZ2QG2MAUEDNVEOFCCQWYSGTV/>
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

