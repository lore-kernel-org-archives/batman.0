Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02B3BC55ABF
	for <batman-adv@archiver.kernel.org>; Thu,  6 Aug 2026 09:51:02 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 7E5F384261
	for <batman-adv@archiver.kernel.org>; Thu, 06 Aug 2026 11:51:01 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1786009861;
 b=iG5IrlfDHeLiIKDmvQ/ApcsuC3mF16qrv7bF2C+/M8yNvHbYCbXu14UlDC/UP8ansGxuX
 acqMjQn9wBfPRM3WaO+L2tPqRXOIVy5e8C6aXqCV3iTb1FunbT+RMSYsOapCE3b/Qbg5yOt
 DLc+KqaS48nkwZJyl/N1KvJ2fhvMTMo=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1786009861; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=vLr4w6SOsrY6CSCZqtE9GRE3AXV2IBNsnV7zGuJ/VmM=;
 b=kXnMZsp4M1rzn3mTNMKqzQKyq88QnIwB9w6h+h1uXWIFZ7NPIYzmUIdjW12bDrjeiMeAq
 89XWHVZV9bfQHmMBdN7RQGaZSFfc7LCoGzJ7q5hzD4q4CRrSrqyjcWz//3ZQxBGWyCPiHqJ
 3Xj47QrnBlGpaaoE8YZZ6MlyFTQmc2M=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org
 [IPv6:2a00:17d8:100::8b1])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 2B3D584244
	for <b.a.t.m.a.n@lists.open-mesh.org>; Thu, 06 Aug 2026 11:45:57 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1786009557;
	b=ygWYT3PXHLXdFh8Z16qUp/M8dWfJ8FR+0naLgr/Zkl2pXrHSWIymt/kD6oBGPxbkvke7DX
	xk0ch3DlsyLLRrJekA+BybygMN7abWPW58NsJ30PhZau7M6+/Gu5YQA85kPm2ovk4xQfhZ
	klToiCRB/MtSk5H64FQtH4R59DJupUY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1786009557;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=vLr4w6SOsrY6CSCZqtE9GRE3AXV2IBNsnV7zGuJ/VmM=;
	b=ycrsmx076+uEJshQtVV078AgTnbL230AGL6E/VyGI4VlsCT77+mcKQxbO5cFcDxIGYiRNg
	3XTgLHqsXkkGoPwrO2h4j90s7bWE2T3FFxi/BjTvrDByfLZlC0TsSz3Fln42lS90tZAJuG
	hQ7j2Un34n0+SDwTQqxwJlWpJDxtyNA=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=iQmGUR+6;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id ACA0B20019;
	Thu, 06 Aug 2026 09:45:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1786009552;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vLr4w6SOsrY6CSCZqtE9GRE3AXV2IBNsnV7zGuJ/VmM=;
	b=iQmGUR+6tR6rC+fBKe7NT3IBc6NA0C3nUIryz2gjUlLbywizL9waPKvD2XxWCfZlTmuGor
	NFEdPvezE23D/XN0k+s2Q61d0jZcqJbwRll9++LwNCy63huenGiZTYamjRCtEWxfMkMQPt
	OvHeZFJ5DzGH3RMh+PrQ1WrHgGZcvJU=
From: Sven Eckelmann <sven@narfation.org>
Date: Thu, 06 Aug 2026 11:44:24 +0200
Subject: [PATCH RFC batadv 11/12] batman-adv: tt: extract immediate purge
 of a local entry
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260806-tt-add-cleanup-v1-11-ffcad65bccc4@narfation.org>
References: <20260806-tt-add-cleanup-v1-0-ffcad65bccc4@narfation.org>
In-Reply-To: <20260806-tt-add-cleanup-v1-0-ffcad65bccc4@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3782; i=sven@narfation.org;
 h=from:subject:message-id; bh=OJ/k2flrvvDE5E3ZzOkHKkyckW6kgNmQP86dsDNNfNA=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFkl4S337tTzlARY7DXd9D//UXty7MfI2u+VyQLKj37zn
 j7GnqfaUcrCIMbFICumyLLnSv75zexv5T9P+3gUZg4rE8gQBi5OAZjIY25Ghm0zTctM+FUOCpfx
 rHVgn2PL96J+R6r/7/WTV3+ebn7rbSojw7TvO6avnn+goPU/r/t8sR/PHqguy2PgfaC7pl6tf91
 NTWYA
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: 2X2IMAZQLGFZTM4A6WMWHJKYAS5JIATI
X-Message-ID-Hash: 2X2IMAZQLGFZTM4A6WMWHJKYAS5JIATI
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/2X2IMAZQLGFZTM4A6WMWHJKYAS5JIATI/>
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

