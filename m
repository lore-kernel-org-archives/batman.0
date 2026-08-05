Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26064C55ABA
	for <batman-adv@archiver.kernel.org>; Wed,  5 Aug 2026 15:11:51 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id B9BF184270
	for <batman-adv@archiver.kernel.org>; Wed, 05 Aug 2026 17:11:49 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1785942709;
 b=t2bbIP4ONhsFwt/d5RIlIOiZN2oqC4uTkDFSZ7AbtRUUY/v+hrI5RMUJimo7ljP/94TaJ
 iOS4T+WRLGXqzuuIUC0qIszQSNOANl+9i1liMsaSwt89dWYhSbCB7xgaLoD7CpN3a2MPSAt
 bgYtoPLZmJYiyWgodh054aM5Hj0R1jI=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1785942709; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=ySyPelc7Z0vx8SSFi15BU5TocuNea9dhUMNWabrGkDw=;
 b=KR9hchLYH+NXRYAo2CwKhozGoQYjo8RkVU5jQRvi9206Z84lbiBzwTHJA03k7XUWeIumZ
 GOYCtUX/f+jP3/3ROqzPYjc8c+SnEFkjzBbEooaDVd3NWRxXOHZo4aIFthHVvFW0pI4GH4J
 GosskDeGXkPGCJXjvM10fnQ9wYCtb04=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org
 [IPv6:2a00:17d8:100::8b1])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 7C4708421C
	for <b.a.t.m.a.n@lists.open-mesh.org>; Wed, 05 Aug 2026 17:10:24 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1785942624;
	b=lxLlQosnwI6siZwaIHdc5vCNC3x8/518jO1To2sTDQj5J2u6V6KyKHfmDzSPoHQzuVb9Rq
	XEWutrG6YF1cF+R8QyhOSQrHs5AG4YJcdpGJHz8VcmrveS5E7eEPX6fEX3OSCTWcRPhB3e
	MUhHk97bAUd9+2WLH0GEl0nv1DQCccQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1785942624;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=ySyPelc7Z0vx8SSFi15BU5TocuNea9dhUMNWabrGkDw=;
	b=poRogIlbSZVx19oGqppekpaGhUUkKEFyFFC+BJb0F3abp5T4QRIKDR1J8HJN+6LxlXMTbx
	E+W+8j1jo6uxhpKq63xDTsqwbSG+wsDeJ6xJQ6zMtB8fCd4da1nW3JvgktMT3yfmRZfTnu
	yGJk7aJ84P2BtyHdZ3SeQqV9VdJ1UH8=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=XSWpULIi;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id 1AD1D20E0D;
	Wed, 05 Aug 2026 15:10:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1785942620;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ySyPelc7Z0vx8SSFi15BU5TocuNea9dhUMNWabrGkDw=;
	b=XSWpULIiwYJ2xuggPXSQlwO/JvtiqAFfswp3uzcDJfPHZRYoBMlgsmbo4XB5CNQbIvUZP3
	2ozVxBVdSGPVq7I5pzJD6bRUmmdpv//6mYZHLYHXjBYpI5m+ZVzbVW5USAsw9uyTnotSK7
	DY01oDpUrWNY/ULeJhZ7fSqrL42Aueo=
From: Sven Eckelmann <sven@narfation.org>
Date: Wed, 05 Aug 2026 17:09:37 +0200
Subject: [PATCH RFC batadv v3 3/6] batman-adv: tt: simplify NEW flag
 transition code
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260805-tt-fixes-v3-3-25b00b558470@narfation.org>
References: <20260805-tt-fixes-v3-0-25b00b558470@narfation.org>
In-Reply-To: <20260805-tt-fixes-v3-0-25b00b558470@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2662; i=sven@narfation.org;
 h=from:subject:message-id; bh=hGkYlfEMJKwYcVg2ekLUL+5O8TOQCG+hggRkrQOAtAo=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFnFQaZm2hkp3s8W9uuFZ5rYzlJ5c3fh0+cZkxc+3WMlr
 TDxUvqCjlIWBjEuBlkxRZY9V/LPb2Z/K/952sejMHNYmUCGMHBxCsBEvjIwMmwrDxO67XRrw7p0
 7sf7nQIlxYJ2bpzZ+Lo6wnNH2pH8PbsY/kqGvWTTf7fr3wJ7Ie2Pei+NMr90GIg1TFTdWqH1/Yr
 nc1YA
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: DEE2Z25MT7WY42KZMWVE7FPKOS6YFEA6
X-Message-ID-Hash: DEE2Z25MT7WY42KZMWVE7FPKOS6YFEA6
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/DEE2Z25MT7WY42KZMWVE7FPKOS6YFEA6/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

The function batadv_tt_local_set_flags() implements support for various
flags and to set/unset them. It is also possible to decide whether this
change should increase the TT size or not.

But in reality, this function is only used to transition tt local entries
from the NEW state and count these entries. Remove the rest of the code to
simplify the function.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/translation-table.c | 26 +++++++-------------------
 1 file changed, 7 insertions(+), 19 deletions(-)

diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index 2a1d8963..5f0f7fb6 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -3868,15 +3868,11 @@ void batadv_tt_free(struct batadv_priv *bat_priv)
 }
 
 /**
- * batadv_tt_local_set_flags() - set or unset the specified flags on the local
- *  table and possibly count them in the TT size
+ * batadv_tt_local_transition_new() - unset the NEW flag on the local
+ *  table and count them in the TT size
  * @bat_priv: the bat priv with all the mesh interface information
- * @flags: the flag to switch
- * @enable: whether to set or unset the flag
- * @count: whether to increase the TT size by the number of changed entries
  */
-static void batadv_tt_local_set_flags(struct batadv_priv *bat_priv, u16 flags,
-				      bool enable, bool count)
+static void batadv_tt_local_transition_new(struct batadv_priv *bat_priv)
 {
 	struct batadv_hashtable *hash = bat_priv->tt.local_hash;
 	struct batadv_tt_common_entry *tt_common_entry;
@@ -3892,19 +3888,11 @@ static void batadv_tt_local_set_flags(struct batadv_priv *bat_priv, u16 flags,
 		rcu_read_lock();
 		hlist_for_each_entry_rcu(tt_common_entry,
 					 head, hash_entry) {
-			if (enable) {
-				if ((tt_common_entry->flags & flags) == flags)
-					continue;
-				tt_common_entry->flags |= flags;
-			} else {
-				if (!(tt_common_entry->flags & flags))
-					continue;
-				tt_common_entry->flags &= ~flags;
-			}
-
-			if (!count)
+			if (!(tt_common_entry->flags & BATADV_TT_CLIENT_NEW))
 				continue;
 
+			tt_common_entry->flags &= ~BATADV_TT_CLIENT_NEW;
+
 			batadv_tt_local_size_inc(bat_priv,
 						 tt_common_entry->vid);
 		}
@@ -3977,7 +3965,7 @@ static void batadv_tt_local_commit_changes_nolock(struct batadv_priv *bat_priv)
 		return;
 	}
 
-	batadv_tt_local_set_flags(bat_priv, BATADV_TT_CLIENT_NEW, false, true);
+	batadv_tt_local_transition_new(bat_priv);
 
 	batadv_tt_local_purge_pending_clients(bat_priv);
 	batadv_tt_local_update_crc(bat_priv);

-- 
2.47.3

