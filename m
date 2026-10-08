Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D40DCA600C
	for <batman@archiver.kernel.org>; Thu,  8 Oct 2026 15:42:22 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id CE02484341
	for <batman@archiver.kernel.org>; Thu, 08 Oct 2026 17:42:20 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1791474140;
 b=NEz02nf/9XGavpgks8zlPMdPFG/qPyZ5f0a6RDMV5TS6h12TW2GcvjBY1Gj/NP7I2LAnP
 TdBHKLg2OeCPeF3r9kXyRaOyeg90cHEYOWmBm/zTsr/DcRQfnnSz4U8mEiTw9yESZQHMBWN
 ESg6NILMMX+Ez+Y1/JXB/dEdW0bVyIQ=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1791474140; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=hvKZ7etShGv/2S6leT8a/nYXWJN74CQpaqhTevzI2GY=;
 b=qlMKe4mxDvFcPleFW1I84GBZH3Y1FEU7E+MjnPXVu80kb9ywDDReZiN5S4h51LKnUw82c
 4hvmaw/ERz69NcTgwAAmS0UKH3jRgzoVUVMI8FQ3gnmjOF+Jqs5fZWsy0ZcM4pAt47X9fr5
 nVeWYelxT8mvqf3FYq0hmao16xEWUko=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org
 [IPv6:2a00:17d8:100::8b1])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 2939B80731
	for <b.a.t.m.a.n@lists.open-mesh.org>; Thu, 08 Oct 2026 17:42:01 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1791474131;
	b=VJnoa0gemY8EEN8mWnfujB3zk9fwelRQtiqgESb8cQoqqKtz/jnQ2hEPorQh5sRzukIaew
	IkG4F6/eXiW4jP6IQN82lAqgf6UoyM6TthvL55k/L4JYYv89/EVpMeKvPiEQKXKnhI5zEH
	6Es39sUUmS/mt2uSRdMi+RdPtl6vLuM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1791474131;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:dkim-signature;
	bh=hvKZ7etShGv/2S6leT8a/nYXWJN74CQpaqhTevzI2GY=;
	b=Xm1d/XKkm0q7KmLEufxgo+vhIBzDh0hWMVtdtRNzHaPBS3LgX5QLUDYhzIbHLuG0gjapKO
	Y00l4vdfdSoC4sU2xDu0mjayvbmLYlaAdvdce2i4VVMSRjkQPjz9kHwAsRS4bsq4xy+rwy
	hzBiPI+o/S4FnIRioW/SPt9u8JvWwxw=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=sIQmW+oN;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id 4DE311FEA4;
	Thu, 08 Oct 2026 15:42:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1791474120;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=hvKZ7etShGv/2S6leT8a/nYXWJN74CQpaqhTevzI2GY=;
	b=sIQmW+oNQlRXFNtD6ndTFjPXUPRZjhMfrlzXhQr7k87KtRqTrfnMTUd7GNg0q37XgqVbTm
	2J8zh9D73A8TXiijxFRAqlgQm97uJPZp2u8/i2AXmyjKlphpca3SP9ciuGGLEpZ0Z8Fd+r
	Nw+io0l0LycOefWl6OSVttKx2zcH8To=
From: Sven Eckelmann <sven@narfation.org>
Date: Thu, 08 Oct 2026 17:41:24 +0200
Subject: [PATCH batadv] batman-adv: tt: don't drop local events queued
 during TVLV update
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261008-tt-atomic-tt-event-v1-1-b4f3503c5ac1@narfation.org>
X-B4-Tracking: v=1; b=H4sIAKO5x2oC/yWMWwqDMBQFtyL3u4EYaZBupfQjj1O9grEkt6Eg7
 r2x/TtzYGangswodOt2yqhceEsN+ktHYXZpguLYmIw2ttd6VCLKybZyOBcqkiiLwQSLOA7+Sk1
 8ZTz584veyTtxsdLj/5e3XxDkLNJxfAFMhm00fgAAAA==
X-Change-ID: 20261008-tt-atomic-tt-event-6e32c6ed83b5
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sashiko <sashiko-bot@kernel.org>, Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3969; i=sven@narfation.org;
 h=from:subject:message-id; bh=gnC/0yikCqCVmXxlX102A5Q6ipByD4y5lHG3jy0OQxE=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFnHd66ULzmw1iUj7BWX1Z8Lh0urHFX3/bY4u/9Y++UC5
 QqrOi31jlIWBjEuBlkxRZY9V/LPb2Z/K/952sejMHNYmUCGMHBxCsBEdGUY/pc9vtCy5ObZtW84
 K+9y3RDZ0CrpvMwgMcOEy9Avbe4NpisM/yyUU3P3zFkQoDX3Sde53vef+6W96z4sX+w2y7jv1IM
 pq/gB
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: SNXEYF2RWM6CHTQ2OHLU6VBLMF6BACB3
X-Message-ID-Hash: SNXEYF2RWM6CHTQ2OHLU6VBLMF6BACB3
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/SNXEYF2RWM6CHTQ2OHLU6VBLMF6BACB3/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

batadv_tt_tvlv_container_update() read the number of local changes without
holding changes_list_lock. batadv_tt_local_event() is not serialized by
the commit_lock and can queue new events before the changes_list is
flushed:

  CPU0                          CPU1
  batadv_tt_tvlv_container_update()
    num = ...local_changes;
                                batadv_tt_local_event()
                                  list_add_tail(...);
                                  ...local_changes++;
    spin_lock_bh(&...changes_list_lock);
    /* only num events copied but all freed */

The additional events were freed without ever being sent. Other nodes will
only notice this via a CRC mismatch and must request the full table.

The number of changes and the changes_list must therefore be taken
atomically. Events queued afterwards then stay in the tt.changes_list for
the next TT round.

The changes can no longer be kept for the next round when the TVLV buffer
allocation fails. But they would be sent with a skipped TTVN anyway, so the
other nodes have to request the full table in this case either way.

Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://sashiko.dev/#/bug/linux-fc286ddd-5bed-4683-b842-ee7a307eeb19
Fixes: cea194d90b11 ("batman-adv: improved client announcement mechanism")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/translation-table.c | 24 +++++++++++++++++-------
 1 file changed, 17 insertions(+), 7 deletions(-)

diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index e46040fd..80f2cc63 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -1383,11 +1383,18 @@ static void batadv_tt_tvlv_container_update(struct batadv_priv *bat_priv)
 	int tt_diff_entries_num = 0;
 	bool drop_changes = false;
 	size_t tt_extra_len = 0;
+	LIST_HEAD(changes_list);
 	int tt_change_len = 0;
 	int tt_diff_len;
 	u16 tvlv_len;
 
+	/* atomically get the list of changes */
+	spin_lock_bh(&bat_priv->tt.changes_list_lock);
+	list_splice_init(&bat_priv->tt.changes_list, &changes_list);
 	tt_diff_entries_num = READ_ONCE(bat_priv->tt.local_changes);
+	WRITE_ONCE(bat_priv->tt.local_changes, 0);
+	spin_unlock_bh(&bat_priv->tt.changes_list_lock);
+
 	tt_diff_len = batadv_tt_len(tt_diff_entries_num);
 
 	/* if we have too many changes for one packet don't send any
@@ -1405,19 +1412,23 @@ static void batadv_tt_tvlv_container_update(struct batadv_priv *bat_priv)
 
 	tvlv_len = batadv_tt_prepare_tvlv_local_data(bat_priv, &tt_data,
 						     &tt_change, &tt_diff_len);
-	if (!tvlv_len)
+	if (!tvlv_len) {
+		/* the TTVN of the changes is lost and the other nodes will
+		 * have to request the full table anyway
+		 */
+		list_for_each_entry_safe(entry, safe, &changes_list, list) {
+			list_del(&entry->list);
+			kmem_cache_free(batadv_tt_change_cache, entry);
+		}
 		return;
+	}
 
 	tt_data->flags = BATADV_TT_OGM_DIFF;
 
 	if (!drop_changes && tt_diff_len == 0)
 		goto container_register;
 
-	spin_lock_bh(&bat_priv->tt.changes_list_lock);
-	WRITE_ONCE(bat_priv->tt.local_changes, 0);
-
-	list_for_each_entry_safe(entry, safe, &bat_priv->tt.changes_list,
-				 list) {
+	list_for_each_entry_safe(entry, safe, &changes_list, list) {
 		if (tt_diff_entries_count < tt_diff_entries_num) {
 			memcpy(tt_change + tt_diff_entries_count,
 			       &entry->change,
@@ -1427,7 +1438,6 @@ static void batadv_tt_tvlv_container_update(struct batadv_priv *bat_priv)
 		list_del(&entry->list);
 		kmem_cache_free(batadv_tt_change_cache, entry);
 	}
-	spin_unlock_bh(&bat_priv->tt.changes_list_lock);
 
 	tt_extra_len = batadv_tt_len(tt_diff_entries_num -
 				     tt_diff_entries_count);

---
base-commit: 0eaac0f4187bc9b69b41d90998fd7b93ab07e53e
change-id: 20261008-tt-atomic-tt-event-6e32c6ed83b5

Best regards,
--  
Sven Eckelmann <sven@narfation.org>

