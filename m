Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37256C61DD6
	for <batman-adv@archiver.kernel.org>; Sat, 29 Aug 2026 06:28:04 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 9C35D83F44
	for <batman-adv@archiver.kernel.org>; Sat, 29 Aug 2026 08:28:02 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1787984882;
 b=HZBX9gJUg6g4TxKmnKetmPDlW5Wzb/4/M5ameRe/Xn/UCdMekmPGIAPmJnAbQ7TaLUytQ
 EHqGhI5RfXSs8JlzBZHovgtavW0Q2q3hGEpnrrMT0oV/z9zkVh/kEqOhlhho0yfTec5d/9s
 O4hcpRwTA18o0PMiWAcqGaUjY8iu4ho=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1787984882; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=BOsg7BAa/16BWQ2RkQwM8NTZ2UzhQOKRGyigq0hqRWQ=;
 b=kWY9ERSqX4i1pkGrYLmpHua6GPhNoWCE8uxVGKSDWyE4pUgaxHjaBqdY3Q+sujkyz/Fek
 U/OqO4+9CNBOslJ/QohICGbZUsK9vawpf4YLHziIBcIgc7aacRvG9DDplCz+MTgReP2TrFw
 kFumQl16FUVXE9MgjHqj8rTDxur2Hpg=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 431D583C5C
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sat, 29 Aug 2026 08:22:22 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1787984542;
	b=g+pPPowsAE2bmZdokRt68K/cCVvrmVZoyJSWpK3JVCxPdeiUY5qUeUttIP9AG/UdSetejb
	2m0OCHzkVqBzNb+fr4YSeY2M0bzn9UQJ+eSk8ttNhjktA+3d+fOCnLxw71/jhBoBetzhYG
	EvBISM3YCnkmdWyptiI8uMrX/5z/dwU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1787984542;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=BOsg7BAa/16BWQ2RkQwM8NTZ2UzhQOKRGyigq0hqRWQ=;
	b=yyGkZIHo4L52PzudAYzlQ8jG+zwC/Gr3cNgQidBDU0xduT8ukFlUzLDsOUQfLsG2OLltW6
	lHdomRr786+9HtNecXoskqsNJm+/D+cg3XpqGlvVp9Dmgrx/s5Difgm+9yzpumtEsde1GL
	CZz4BaZV6gFzk8LaVMBSyntraHmKmpE=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=WGf3u7D9;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id D471D1FEC4;
	Sat, 29 Aug 2026 06:22:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1787984537;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BOsg7BAa/16BWQ2RkQwM8NTZ2UzhQOKRGyigq0hqRWQ=;
	b=WGf3u7D9sbjfcBP7nS5MVy+BcjljDUzN7Gr4Rk/U4OTSvxrVwvF2lN6+fk2oRiPRUTxNVX
	cyA0RuR1KpA3UX3q2VTScjhaxh0SCJ8OjjY9PEWesMoWReFVTxWBC4VRo5ouqQoZYGKlxL
	rLgGscsNvZx2d6FtsmjBsvmGAPJpYYE=
From: Sven Eckelmann <sven@narfation.org>
Date: Sat, 29 Aug 2026 08:18:28 +0200
Subject: [PATCH batadv v5 17/20] batman-adv: tt: extract removal of the
 superseded local entry
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260829-tt-fixes-v5-17-88fce8fd683d@narfation.org>
References: <20260829-tt-fixes-v5-0-88fce8fd683d@narfation.org>
In-Reply-To: <20260829-tt-fixes-v5-0-88fce8fd683d@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3404; i=sven@narfation.org;
 h=from:subject:message-id; bh=5M6pWp53E+AC7diT53aq64DUMwL78bR9jFJ+4mnBIA0=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFmTKted8V56foMYt6TN1prIfc6ajt7B8591ZR20/LZP9
 sWi9YH9HaUsDGJcDLJiiix7ruSf38z+Vv7ztI9HYeawMoEMYeDiFICJzG1hZLiY5esx219zYYqS
 5I1kkR/con7SqRuEdXXMUrjNLn0Q4Gb4w8ex7NuPO7NvGK78FVnw8XJxTN+NmN3HSu79Pr7t7nT
 TOUwA
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: AM7KSK5BJL44W3I5H2W7R3Y75UAYOMG4
X-Message-ID-Hash: AM7KSK5BJL44W3I5H2W7R3Y75UAYOMG4
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/AM7KSK5BJL44W3I5H2W7R3Y75UAYOMG4/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

A client which was announced by another originator is no longer a local
client. The code which drops it from the local table and takes over its
WIFI flag is the second cleanup stage of batadv_tt_global_add() and needed
its own goto to skip over the multicast case.

Move it to batadv_tt_global_purge_local().

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/translation-table.c | 61 +++++++++++++++++++++++++-------------
 1 file changed, 41 insertions(+), 20 deletions(-)

diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index 17a92ff4..4a166791 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -1884,6 +1884,46 @@ batadv_tt_global_orig_entry_add(struct batadv_tt_global_entry *tt_global,
 	spin_unlock_bh(&tt_global->list_lock);
 }
 
+/**
+ * batadv_tt_global_purge_local() - drop the local entry of an announced client
+ * @bat_priv: the bat priv with all the mesh interface information
+ * @tt_global_entry: the global TT entry of the announced client
+ * @flags: TT flags announced for this non-mesh client
+ *
+ * A client which is announced by another originator is no longer a local
+ * client. Remove it from the local table and take over the WIFI flag it was
+ * tracked with.
+ */
+static void
+batadv_tt_global_purge_local(struct batadv_priv *bat_priv,
+			     struct batadv_tt_global_entry *tt_global_entry,
+			     u16 flags)
+{
+	struct batadv_tt_common_entry *common = &tt_global_entry->common;
+	u16 local_flags;
+
+	/* Do not remove multicast addresses from the local hash on
+	 * global additions
+	 */
+	if (is_multicast_ether_addr(common->addr))
+		return;
+
+	/* remove address from local hash if present */
+	local_flags = batadv_tt_local_remove(bat_priv, common->addr, common->vid,
+					     "global tt received",
+					     flags & BATADV_TT_CLIENT_ROAM);
+
+	scoped_guard(spinlock_bh, &common->flags_lock) {
+		common->flags |= local_flags & BATADV_TT_CLIENT_WIFI;
+
+		if (!(flags & BATADV_TT_CLIENT_ROAM))
+			/* this is a normal global add. Therefore the client is
+			 * not in a roaming state anymore.
+			 */
+			common->flags &= ~BATADV_TT_CLIENT_ROAM;
+	}
+}
+
 /**
  * batadv_tt_global_merge_flags() - merge announced flags into a global TT entry
  * @tt_global_entry: the global TT entry to update
@@ -2094,26 +2134,7 @@ static bool batadv_tt_global_add(struct batadv_priv *bat_priv,
 	ret = true;
 
 out_remove:
-	/* Do not remove multicast addresses from the local hash on
-	 * global additions
-	 */
-	if (is_multicast_ether_addr(tt_addr))
-		goto out;
-
-	/* remove address from local hash if present */
-	local_flags = batadv_tt_local_remove(bat_priv, tt_addr, vid,
-					     "global tt received",
-					     flags & BATADV_TT_CLIENT_ROAM);
-
-	spin_lock_bh(&tt_global_entry->common.flags_lock);
-	tt_global_entry->common.flags |= local_flags & BATADV_TT_CLIENT_WIFI;
-
-	if (!(flags & BATADV_TT_CLIENT_ROAM))
-		/* this is a normal global add. Therefore the client is not in a
-		 * roaming state anymore.
-		 */
-		tt_global_entry->common.flags &= ~BATADV_TT_CLIENT_ROAM;
-	spin_unlock_bh(&tt_global_entry->common.flags_lock);
+	batadv_tt_global_purge_local(bat_priv, tt_global_entry, flags);
 
 out:
 	batadv_tt_global_entry_put(tt_global_entry);

-- 
2.47.3

