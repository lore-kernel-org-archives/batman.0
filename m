Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D22FC61DD6
	for <batman-adv@archiver.kernel.org>; Sat, 29 Aug 2026 06:28:34 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id D3F868039A
	for <batman-adv@archiver.kernel.org>; Sat, 29 Aug 2026 08:28:32 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1787984912;
 b=yaCCOsFh9Ou4tM+acICf9x1JPCyzDNllCxoHV/bXEsxujuW3b8TNR75S7D+3VDXWkJk8M
 XdiWh/uMir8fynWIMLLtIbx7wvcFMAcUc6jAVTHR/hKGjq972HqMlOPSNXgZpmszDn2YzjF
 TFARRy67WjHzM4pdCEsQgd03BQBSMog=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1787984912; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=IuOrxdKHDePlsiuw0EGLI0W8CPSEymNLU1jUZjHa5dY=;
 b=W3fiv+1UModZIzoquU0LizzNOJBTAGsJtr0tLlweeth6epwqJpe4VRcLtH4O/2JsFN7Ys
 Ab3sK9sTQUl9hy9Ab96fIQnzxzKsdvCaCNBuP9sPqEny6C0w3SPHrfPd1uh9Lo1QNGVCvE7
 aqz7q8h0mkGJz+JzLR8nll5FQeW7fZc=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org
 [IPv6:2a00:17d8:100::8b1])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 8B05F83C77
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sat, 29 Aug 2026 08:22:28 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1787984548;
	b=PirfIO6lDrAcQ9DT3R9Yh58G3r8oxHKCZu7WJ1q7JaDnPH9vOjtnJwvJ3k4I9VQXx4maIV
	YN8L8y5LK5EZyg/8KabSQM2pEioA2N1vBXZt/3Pcgt1mbsNrbiAL2zFzfuDix3PLXvVwPq
	ylHh0ifj1+yctuGBGXvQ56S5jgPMWbk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1787984548;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=IuOrxdKHDePlsiuw0EGLI0W8CPSEymNLU1jUZjHa5dY=;
	b=lHA1AwDDv+ky0+fAxdoibFV9tLSOO+5YDrL5GsziK9oBbtnN7aEvoQpiMgeS4FvjPz+IbB
	khUDb2XxZSSZoDw5j0Wivxq03r8OaSVI/nu2TAqoLY90WKOg5Sy27+i91Rb026R9B0INS3
	KHznddMTt+CpTYvE9hCyWx+p27dBdtM=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b="F4mL/7Xi";
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id 33B2D1FEC4;
	Sat, 29 Aug 2026 06:22:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1787984544;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IuOrxdKHDePlsiuw0EGLI0W8CPSEymNLU1jUZjHa5dY=;
	b=F4mL/7Xih4MLli2xJ9nPrrA4wi2SdBJ5sbzpQc6VNTuoIkLYMddka1Nu5vzI7fuy4zNcJy
	bImH+5GHNW2AxDOAbtnRgWyaO1e6EOOSwgyEaENkJuqfPklCyDLPcMuo7B29R0JzmLH2ZS
	ze7JLhU5dtcCICPd8yGfP9O1MsndeU0=
From: Sven Eckelmann <sven@narfation.org>
Date: Sat, 29 Aug 2026 08:18:29 +0200
Subject: [PATCH batadv v5 18/20] batman-adv: tt: extract marking of a
 removed local entry
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260829-tt-fixes-v5-18-88fce8fd683d@narfation.org>
References: <20260829-tt-fixes-v5-0-88fce8fd683d@narfation.org>
In-Reply-To: <20260829-tt-fixes-v5-0-88fce8fd683d@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3356; i=sven@narfation.org;
 h=from:subject:message-id; bh=c8nYyLjFa7JP042WyANTf4x3wuSVsHOdCJGBRScOnEo=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFmTKtc5c2edeS2t8v7xMdUH3Ia7uk9O+q/+5jvXF+lb7
 zZGGRxa3FHKwiDGxSArpsiy50r++c3sb+U/T/t4FGYOKxPIEAYuTgGYCMNshv95+mEHpFl9Jr2L
 7hK7u++bt1t6ldjRNbmTejkaD7cvCq1gZLgY+rSwUspAxO7H7m9hIQkX05MWavxyy9RsedFt4RL
 qwAkA
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: OKE5ZMEILLVX5AG3T3DH2YHL6XPN454L
X-Message-ID-Hash: OKE5ZMEILLVX5AG3T3DH2YHL6XPN454L
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/OKE5ZMEILLVX5AG3T3DH2YHL6XPN454L/>
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

