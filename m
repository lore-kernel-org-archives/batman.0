Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50700C56208
	for <batman-adv@archiver.kernel.org>; Thu,  6 Aug 2026 09:50:32 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id D451D84214
	for <batman-adv@archiver.kernel.org>; Thu, 06 Aug 2026 11:50:30 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1786009830;
 b=VL5vq1hQfQY9ARt68LE37LRthMqQ5/EvJv/NmjMHyjHkzkeCF/bXLDRx2NUPGnQYjox3F
 Rwt4pDR8STdxje/h8BXbS9To/1IUwNLC76may1966DaOBcrk8TAWe5gIFkBkaggGv3Y4qat
 ekCmwsFUCPfDW9a6OXUq17CwrYvnWEc=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1786009830; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=Lf1O5/zROTaDXeMVYjlM48HeXIo5MxMjVBixkekHK9M=;
 b=jRCicaSZTr0O1nGYc293VDLoUf78yomKufHEROKN57iEdYWjjgmR4WhrK/b8gXFxAhOFV
 wJZI3lzL2UBz2xZzwFNQJLVrxYpKFJcEEPuB/OaElV0HI+6gey8IUrOSzSbp9GPGBTenIOA
 TTKS7w/Zz594aLsx/lV8R65a1b13UOg=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id B3D128421C
	for <b.a.t.m.a.n@lists.open-mesh.org>; Thu, 06 Aug 2026 11:45:50 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1786009550;
	b=UJE2DH083+8bX1knMKS7ZRMQr9GWNP/GQUMX9RYFWbgQxeNEoDnMgJx1mDzFPQgKUCz6tM
	bbxcH3ZRakUnOPJ++9KfbagV46ZTHk4U+OGVvk65vTrL/y8vrSQOkXY3sP45YbiqfJy3cr
	n3KHQvSnv+2L26MXcCvNgbL4uR8mM2I=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1786009550;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=Lf1O5/zROTaDXeMVYjlM48HeXIo5MxMjVBixkekHK9M=;
	b=mYo/iW2Z0IWgCsNDRE8rtx3BM2OWDWbvvA06QwVTi4U/75p5LRp97+5dPfvGTfmE7G4b7D
	Lq2Es4vKzRKQ+w6V+Nl6sgmbdgojBr1t2mdCJGmd0TUiZ0rLHncj6cnBZsEl8ljhYotytj
	OtE73/wKzDkFIgmAat5Gospl60Lawdo=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=zhExYR6J;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id 52D6D20019;
	Thu, 06 Aug 2026 09:45:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1786009546;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Lf1O5/zROTaDXeMVYjlM48HeXIo5MxMjVBixkekHK9M=;
	b=zhExYR6Jnp/QMs6jwH75zbWVyi2kyGQhw5N6ITjzPDPRtGILjmfRWgXLBUyVPepd5U792j
	HtfrkgIjk9YsS4faScvn7QwPf+lF3wfR9AG3W2qmKpONGY/M6+EhxjVqsLhFxz8Yb+FDh8
	yxg1mDr3tDag/04skl1n3D7bWkJEOd8=
From: Sven Eckelmann <sven@narfation.org>
Date: Thu, 06 Aug 2026 11:44:23 +0200
Subject: [PATCH RFC batadv 10/12] batman-adv: tt: extract marking of a
 removed local entry
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260806-tt-add-cleanup-v1-10-ffcad65bccc4@narfation.org>
References: <20260806-tt-add-cleanup-v1-0-ffcad65bccc4@narfation.org>
In-Reply-To: <20260806-tt-add-cleanup-v1-0-ffcad65bccc4@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3355; i=sven@narfation.org;
 h=from:subject:message-id; bh=7LrDK2XlDINiN6yN0pMXP0Rqs8cCV19hgvm5VIdyRlI=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFkl4S1qLWE2dd8jPAzDu20cAq87f4idL3Gof8Wqp3J/x
 I1XyU/qKGVhEONikBVTZNlzJf/8Zva38p+nfTwKM4eVCWQIAxenAEzk1AKG/8lv/RJmKqic3LF9
 0XR1S309l+2TpojVZTVMDpX4ydaX95Phv9+xpjhDvqc2ClvOterby7q+592nuGrtgsgktde71vz
 j4AMA
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: FKC3O3VGNFU2RHLHCH3DE3LB52VPLYTQ
X-Message-ID-Hash: FKC3O3VGNFU2RHLHCH3DE3LB52VPLYTQ
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/FKC3O3VGNFU2RHLHCH3DE3LB52VPLYTQ/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

The first locked section of batadv_tt_local_remove() does three things at
once

* it snapshots the flags for the return value
* it marks the client as ROAMed
* it decides whether the entry has to survive until the next ttvn increment

But this complex locked section is in the middle of the function and cannot
be written as scoped_guard() du to goto's in this routine.

Move it to batadv_tt_local_mark_removed() and report the decision via its
return value. But leave the batadv_tt_local_set_pending_event() flag
assembly outside the function because it has no locking requirements.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/translation-table.c | 48 +++++++++++++++++++++++++++-----------
 1 file changed, 35 insertions(+), 13 deletions(-)

diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index 4a166791..52c7cb90 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -1495,6 +1495,38 @@ batadv_tt_local_set_pending_event(struct batadv_priv *bat_priv,
 		   batadv_print_vid(tt_local_entry->common.vid), message);
 }
 
+/**
+ * batadv_tt_local_mark_removed() - mark a local entry as removed
+ * @tt_local_entry: local TT entry to mark
+ * @roaming: true if the deletion is due to a roaming event
+ * @curr_flags: pointer to store the flags of the entry before it was marked
+ *
+ * Return: true if the entry has to be kept in the local table until the next
+ * ttvn increment, false if it can be purged immediately.
+ */
+static bool
+batadv_tt_local_mark_removed(struct batadv_tt_local_entry *tt_local_entry,
+			     bool roaming, u16 *curr_flags)
+{
+	struct batadv_tt_common_entry *common = &tt_local_entry->common;
+	bool pending = false;
+
+	scoped_guard(spinlock_bh, &common->flags_lock) {
+		*curr_flags = common->flags;
+
+		/* mark the local client as ROAMed */
+		if (roaming)
+			common->flags |= BATADV_TT_CLIENT_ROAM;
+
+		if (!(common->flags & BATADV_TT_CLIENT_NEW)) {
+			common->flags |= BATADV_TT_CLIENT_PENDING;
+			pending = true;
+		}
+	}
+
+	return pending;
+}
+
 /**
  * batadv_tt_local_remove() - logically remove an entry from the local table
  * @bat_priv: the bat priv with all the mesh interface information
@@ -1519,26 +1551,16 @@ u16 batadv_tt_local_remove(struct batadv_priv *bat_priv, const u8 *addr,
 	if (!tt_local_entry)
 		goto out;
 
-	spin_lock_bh(&tt_local_entry->common.flags_lock);
-	curr_flags = tt_local_entry->common.flags;
-
 	flags = BATADV_TT_CLIENT_DEL;
 	/* if this global entry addition is due to a roaming, the node has to
 	 * mark the local entry as "roamed" in order to correctly reroute
 	 * packets later
 	 */
-	if (roaming) {
+	if (roaming)
 		flags |= BATADV_TT_CLIENT_ROAM;
-		/* mark the local client as ROAMed */
-		tt_local_entry->common.flags |= BATADV_TT_CLIENT_ROAM;
-	}
-
-	if (!(tt_local_entry->common.flags & BATADV_TT_CLIENT_NEW)) {
-		tt_local_entry->common.flags |= BATADV_TT_CLIENT_PENDING;
-		pending = true;
-	}
-	spin_unlock_bh(&tt_local_entry->common.flags_lock);
 
+	pending = batadv_tt_local_mark_removed(tt_local_entry, roaming,
+					       &curr_flags);
 	if (pending) {
 		batadv_tt_local_set_pending_event(bat_priv, tt_local_entry, flags,
 						  message);

-- 
2.47.3

