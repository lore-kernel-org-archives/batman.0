Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DECFC61DE1
	for <batman-adv@archiver.kernel.org>; Sun, 30 Aug 2026 15:31:43 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id E07F4803FA
	for <batman-adv@archiver.kernel.org>; Sun, 30 Aug 2026 17:31:41 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1788103901;
 b=tJ5CHgtOEqYSfIZsOG+j23hC+iuZ8HaEeJ3Nd6845xk+c4bdECSESIWGu7Bo2lEuWJzw8
 s1XdsP8wnaAYdin45RRmWGlnRcchJP7n8kZaP8Yl6Z7J0QRIhIOdRsOJaYtffMxtdQK1BMC
 pLWOPD3sV8e9icLiiCOMIcchRu8iGqI=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1788103901; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=VpALmJtR0snrVLasRV4Mc2ZW2w9KuKiV/uIMPKEPIB0=;
 b=f5JppZQCnxGvO9R5UXUJ4c1N+bBbH198OQUZTXc4BEjJ3FcxR28u54ddZHMQP93ZbDQEg
 2IgPVCTF3N4830byXG3OrUSmODMbgjkc4jdubRgsJ62TeMX7wFmIUsKcxK6Xtee5ISQ7vqd
 5hF6DYzgpVOf9Ms0vw4xSG0sDjjbrjg=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org
 [IPv6:2a00:17d8:100::8b1])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 11446804AA
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sun, 30 Aug 2026 17:23:12 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1788103392;
	b=jHWa/1Vb/90Y+7Jj6jzxjHa7MXZdD5UnLeL0GlOhZQCNBcMSflKPphZdmIry54fXTWTIEp
	LLTGEWi5ybNMUKSvOQjO11WO2AhcGAd8iC0/hXsfApPu6wjp/H7Qu3KNjui31TtuqzTvoS
	9KUZOgqNJvlJcXUxXK0YbFzAyFR7I9g=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1788103392;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=VpALmJtR0snrVLasRV4Mc2ZW2w9KuKiV/uIMPKEPIB0=;
	b=wP9bGtuxXPLLFrgubJxyCK+dxLE6Qg+R4blFm6xPUbBEf5UwGfx5WUjZzx7eFR8ITPkmr5
	AzsmZCriFh298/CV+7mSiD8PGMdzhlG5NoX/7GP/rI9np9NSll1u2Rbl2qNZhNEic4ID8a
	xHkU0owVhVNOmDsD/UgI/yrz7Qnibow=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=GElJ3WRX;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id 9F8472083E;
	Sun, 30 Aug 2026 15:23:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1788103387;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VpALmJtR0snrVLasRV4Mc2ZW2w9KuKiV/uIMPKEPIB0=;
	b=GElJ3WRXf50yNYbdIe3CwNSVtEdr3Lo3OXKKGIafF8lyNaIxGkzhAICNSe0M7bNr1WqWk2
	C8V4fdvsQNiu71+lJD/bWDDANzh1ofvvVR1PnsDGwk92lqlCzbnes9ds6panOX3PQ/y1NR
	Qieq+WAT2r3o9Jg2U769JHV4MWeCKUM=
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 30 Aug 2026 17:21:55 +0200
Subject: [PATCH batadv v6 18/20] batman-adv: tt: extract marking of a
 removed local entry
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260830-tt-fixes-v6-18-a56568a15041@narfation.org>
References: <20260830-tt-fixes-v6-0-a56568a15041@narfation.org>
In-Reply-To: <20260830-tt-fixes-v6-0-a56568a15041@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3356; i=sven@narfation.org;
 h=from:subject:message-id; bh=dADlXvj5IHVoxTYVwglauTydSKW5vRMqgPN+hlJhVrw=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFlTvDr0yq7O9TrLuvC/u/Qr098iUyU5JFJ10wT0l22bv
 YX9cfCmjlIWBjEuBlkxRZY9V/LPb2Z/K/952sejMHNYmUCGMHBxCsBEHn5m+GdryyHVri3KlhLS
 9YozRyn05ePtEhMSRXcftUw5u+n+5TyGf2ZrAi7atMwNCdfhutf4ceG89XVsB4v8DzvWvGOInxW
 gwg4A
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: BA6E6KJFRQHC2QHB4YEUP7IUQ3SZORP3
X-Message-ID-Hash: BA6E6KJFRQHC2QHB4YEUP7IUQ3SZORP3
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/BA6E6KJFRQHC2QHB4YEUP7IUQ3SZORP3/>
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
be written as scoped_guard() due to goto's in this routine.

Move it to batadv_tt_local_mark_removed() and report the decision via its
return value. But leave the batadv_tt_local_set_pending_event() flag
assembly outside the function because it has no locking requirements.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/translation-table.c | 48 +++++++++++++++++++++++++++-----------
 1 file changed, 35 insertions(+), 13 deletions(-)

diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index eaf8f48f..5ae47d6a 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -1496,6 +1496,38 @@ batadv_tt_local_set_pending_event(struct batadv_priv *bat_priv,
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
@@ -1520,26 +1552,16 @@ u16 batadv_tt_local_remove(struct batadv_priv *bat_priv, const u8 *addr,
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

