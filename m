Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CA16C61DD7
	for <batman-adv@archiver.kernel.org>; Sat, 29 Aug 2026 06:29:04 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 3B5EC83C3C
	for <batman-adv@archiver.kernel.org>; Sat, 29 Aug 2026 08:29:03 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1787984943;
 b=o6aUuOOTZCjE+1A0MC2to3x/qH950+jJ1SygVt1A7sRAXjmruLnoAirzJvCFvc3h2Ko/L
 4tLrsWOFkWsi4U4XGwNY4tqCMTohqoiAkOnZeYRxlLwvfKjJfThC1GTMQLJPbKwsNiHMlOP
 OG6vvjuUhisDc4GSKwbqhC+1T9XzPrk=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1787984943; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=vLr4w6SOsrY6CSCZqtE9GRE3AXV2IBNsnV7zGuJ/VmM=;
 b=fG/muUM2tfrbAArp6yXHXN3aEaqTyU3ISmEpbL4XLRPn3o7mYlsEq1op8of8VCTWjuc1I
 kz22nr9fAFCpxsbP6eeTiqtxa5/gOHrPHaOx/oiX3Tg2CO40aPqQIQCgFz/rVjAE3yrjvUe
 1H5OmggEGWwUO+6ZWQxfR3nU64tVj08=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org
 [IPv6:2a00:17d8:100::8b1])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id B270283C77
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sat, 29 Aug 2026 08:22:35 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1787984555;
	b=4BudnJH4yKaE5EACDYBmgjLgMyOXyYpV1Ht/kugI0rfZJ1Vh6o+/bi3ZLcly3MxJSfTNMk
	xgCL2sYTXZt0re90/qTowy1ZBZpRg7uuhuhkgvv5yCuIZviekyhLBSAGwIFw67268PEKNt
	2so2O6c0Ix7jtO70XAI1RrsMdbIFwzs=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1787984555;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=vLr4w6SOsrY6CSCZqtE9GRE3AXV2IBNsnV7zGuJ/VmM=;
	b=Q/vb7zytYDX19pFwj+Xb+g6asrZnJy/GonH4zdo97IQ8INkkEWITJOmsl5OnlldXOJ3ntP
	dE/D1wApOK6CU8gJqK2bWFDxxW1kwMwUlRdMLDONFsw+RFh7IuYuttNJBbazBpHJy0Ft4i
	BA1uRSFyB0HlP2/pw+FmCU7qts4zZVg=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b="Y8M/xi5y";
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id 4B6231FEC4;
	Sat, 29 Aug 2026 06:22:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1787984551;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vLr4w6SOsrY6CSCZqtE9GRE3AXV2IBNsnV7zGuJ/VmM=;
	b=Y8M/xi5yF9ZEQYnGOYh/K5xuV2sYSxP1KaHu9dHieZow2c4Sd58OzG2yrwAMMPDJI9lwcd
	Fq+8wvNek2094mbbjdmDaByUTePrFcwt+0Gr5FuqItp1ijs+1W2QexZXb2TKtcO/hAq5zY
	/KUz1/+HeIzaUXOP6anstaP/MG4g/8U=
From: Sven Eckelmann <sven@narfation.org>
Date: Sat, 29 Aug 2026 08:18:30 +0200
Subject: [PATCH batadv v5 19/20] batman-adv: tt: extract immediate purge of
 a local entry
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260829-tt-fixes-v5-19-88fce8fd683d@narfation.org>
References: <20260829-tt-fixes-v5-0-88fce8fd683d@narfation.org>
In-Reply-To: <20260829-tt-fixes-v5-0-88fce8fd683d@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3782; i=sven@narfation.org;
 h=from:subject:message-id; bh=OJ/k2flrvvDE5E3ZzOkHKkyckW6kgNmQP86dsDNNfNA=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFmTKtfZzxRt46mauChhy43Uc5/0r+9dUBD2KmVFws+mG
 xXGJ6OPdZSyMIhxMciKKbLsuZJ/fjP7W/nP0z4ehZnDygQyhIGLUwAmsqqG4Z95lXjl7JkbQ80W
 7pu1+NU9tvlNu+L4vc+Vm/BG+TZ1VpQyMkxYFr1EL2OLgNLMFQ5Prwpcvbf+ddkn7yUp0YsNpga
 ues0PAA==
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: DQRXS2EXARNCDSSZ5XY56MXEN735QR5T
X-Message-ID-Hash: DQRXS2EXARNCDSSZ5XY56MXEN735QR5T
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/DQRXS2EXARNCDSSZ5XY56MXEN735QR5T/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

A client which was added after the last ttvn increment was never announced
and can be dropped from the local table right away. The code doing so is
the second half of batadv_tt_local_remove() and needed a goto to skip the
accounting when the entry was already gone from the hash.

Move it to batadv_tt_local_remove_now().

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/translation-table.c | 57 +++++++++++++++++++++++++-------------
 1 file changed, 37 insertions(+), 20 deletions(-)

diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index 52c7cb90..fecf1930 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -1527,6 +1527,42 @@ batadv_tt_local_mark_removed(struct batadv_tt_local_entry *tt_local_entry,
 	return pending;
 }
 
+/**
+ * batadv_tt_local_remove_now() - purge a local entry which was never announced
+ * @bat_priv: the bat priv with all the mesh interface information
+ * @tt_local_entry: local TT entry to purge
+ *
+ * A client which was added right after the last ttvn increment was never sent
+ * to the other nodes. It can therefore be dropped from the local table without
+ * waiting for the next ttvn increment.
+ */
+static void
+batadv_tt_local_remove_now(struct batadv_priv *bat_priv,
+			   struct batadv_tt_local_entry *tt_local_entry)
+{
+	struct batadv_tt_common_entry *common = &tt_local_entry->common;
+	struct hlist_node *tt_removed_node;
+
+	batadv_tt_local_event(bat_priv, tt_local_entry, BATADV_TT_CLIENT_DEL);
+
+	/* remove exactly this object when still present in hash */
+	tt_removed_node = batadv_hash_remove(bat_priv->tt.local_hash,
+					     batadv_compare_tt_entry,
+					     batadv_choose_tt, common);
+	if (!tt_removed_node)
+		return;
+
+	/* batadv_tt_local_transition_new() may have committed the entry and
+	 * thus counted it in the local table size since the
+	 * BATADV_TT_CLIENT_NEW check in batadv_tt_local_mark_removed().
+	 */
+	if (!(batadv_tt_flags_get(common) & BATADV_TT_CLIENT_NEW))
+		batadv_tt_local_size_dec(bat_priv, common->vid);
+
+	/* drop reference of remove hash entry */
+	batadv_tt_local_entry_put(tt_local_entry);
+}
+
 /**
  * batadv_tt_local_remove() - logically remove an entry from the local table
  * @bat_priv: the bat priv with all the mesh interface information
@@ -1542,7 +1578,6 @@ u16 batadv_tt_local_remove(struct batadv_priv *bat_priv, const u8 *addr,
 			   bool roaming)
 {
 	struct batadv_tt_local_entry *tt_local_entry;
-	struct hlist_node *tt_removed_node;
 	u16 curr_flags = BATADV_NO_FLAGS;
 	bool pending = false;
 	u16 flags;
@@ -1570,25 +1605,7 @@ u16 batadv_tt_local_remove(struct batadv_priv *bat_priv, const u8 *addr,
 	/* if this client has been added right now, it is possible to
 	 * immediately purge it
 	 */
-	batadv_tt_local_event(bat_priv, tt_local_entry, BATADV_TT_CLIENT_DEL);
-
-	/* remove exactly this object when still present in hash */
-	tt_removed_node = batadv_hash_remove(bat_priv->tt.local_hash,
-					     batadv_compare_tt_entry,
-					     batadv_choose_tt,
-					     &tt_local_entry->common);
-	if (!tt_removed_node)
-		goto out;
-
-	/* batadv_tt_local_transition_new() may have committed the entry and
-	 * thus counted it in the local table size since the BATADV_TT_CLIENT_NEW
-	 * check above.
-	 */
-	if (!(batadv_tt_flags_get(&tt_local_entry->common) & BATADV_TT_CLIENT_NEW))
-		batadv_tt_local_size_dec(bat_priv, tt_local_entry->common.vid);
-
-	/* drop reference of remove hash entry */
-	batadv_tt_local_entry_put(tt_local_entry);
+	batadv_tt_local_remove_now(bat_priv, tt_local_entry);
 
 out:
 	batadv_tt_local_entry_put(tt_local_entry);

-- 
2.47.3

