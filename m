Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7665DC43327
	for <batman-adv@archiver.kernel.org>; Fri, 26 Jun 2026 16:30:52 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id E618C84197
	for <batman-adv@archiver.kernel.org>; Fri, 26 Jun 2026 18:30:50 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1782491450;
 b=4B7JjZUSJAHB6bgvrJK/KUaqHOCVHxAVFpVbyTbTLBxiacPKvTWtLk66X6d1/8qUz0/3r
 vgpV4rOkq8rufPPAn5KpwSO5y5ywPUpwo+tFD/24oHADVu4UWOPuf3tPD9h4NGvB5LIAH2q
 AOydGDxmuJ2OMQfPPBonj+vEaNMiBs0=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1782491450; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=Xp89RSupua1UtvxjeM66VzWjEsYV6r4LzuwJ2OPUKFE=;
 b=kQOGWnph71/nCp3jHA2pVWNHfOGhVTP+WDNZQsvO8xZDfw66b2nR5j0578D62uGuudCvH
 c1GRLAVwXLEhDt0FmAeNwguP0pHEJGC3hLSSSbKlRSXpTmZ+46uKf1mxMmwfBN5k9+0L/7V
 u5QL++PoYYeq3+2P/wTiyOMx94yusLw=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org
 [IPv6:2a00:17d8:100::8b1])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id A7EC380342
	for <b.a.t.m.a.n@lists.open-mesh.org>; Fri, 26 Jun 2026 18:28:51 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1782491331;
	b=EwDMhDLaqPZVOqvmWH+5kZtcicKbllRVk95Tw8euN6XJh4XGtBrKopFpkYpAfipLDgY0p2
	KqMGZU25dYZX8r8d5XBOieiMOmQnLuAII+DbFK1/t3JQbO95pkOkLBdxgxkMNeRsZl8QJo
	W5HVJlUombaOpB2tteex4aDNr7YBkXI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1782491331;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=Xp89RSupua1UtvxjeM66VzWjEsYV6r4LzuwJ2OPUKFE=;
	b=1OWRLts4CWiu3UqScMWNheRrwhomWOV6LwD/atkLYpmPGyzQVVG6Sh6PH7WZQ9GtAyumDn
	FiEkfk5fOJ/YwBwB1xLGudHbdYPt2dpat4o38qmbVHyLVO5tw2saKAloyg0y7qrK+ial7a
	M4eunnVTYmXG67+6anKmM7zwrE1/gEk=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=ZUdAEFH1;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id 2C9ED203D3;
	Fri, 26 Jun 2026 16:28:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1782491331;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Xp89RSupua1UtvxjeM66VzWjEsYV6r4LzuwJ2OPUKFE=;
	b=ZUdAEFH1t8YYzfdhE8U7PsTqWxPUL3MsStj7hPeIr0gKn5VU8YJNoiGD8B0/MRXT40QJ2p
	Fimo6SW9ieXDm+shviGRQLqIMfHuNtg8RVnyE8Y0HrWMn8QOlMw++umd/q722pORlYKGNt
	0vNT3/6xk8sv5dYdTrlEWHwJNeoW5VI=
From: Sven Eckelmann <sven@narfation.org>
Date: Fri, 26 Jun 2026 18:28:34 +0200
Subject: [PATCH batadv v2 2/2] batman-adv: tt: simplify NEW flag transition
 code
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260626-tt-atomic-refactor-v2-2-b6b9c99d3bfb@narfation.org>
References: <20260626-tt-atomic-refactor-v2-0-b6b9c99d3bfb@narfation.org>
In-Reply-To: <20260626-tt-atomic-refactor-v2-0-b6b9c99d3bfb@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2958; i=sven@narfation.org;
 h=from:subject:message-id; bh=yJ7V3PnhI7WedC/THvWg1vkiuvI+KvGRppd83rAL0A0=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFl2Kzat/2n3U4d1iXxmwxubhoq374/ZzuEqNLtV67DbX
 sJHx1iro5SFQYyLQVZMkWXPlfzzm9nfyn+e9vEozBxWJpAhDFycAjAR5UCG/yVPJNUlvno8P+9V
 ZHpH8UxKw7p93+YvCRU9tW1SkYEGHzvD/1R356qrj7Ym9P22NF822zd/GqPx76PXDI6/UnffsfM
 ZFy8A
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: QI2PJ7AAMRHVZEW4GCOINUYMVOS5CNMN
X-Message-ID-Hash: QI2PJ7AAMRHVZEW4GCOINUYMVOS5CNMN
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/QI2PJ7AAMRHVZEW4GCOINUYMVOS5CNMN/>
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
 net/batman-adv/translation-table.c | 37 +++++++++----------------------------
 1 file changed, 9 insertions(+), 28 deletions(-)

diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index 00873f75..fbc37b22 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -3908,15 +3908,11 @@ void batadv_tt_free(struct batadv_priv *bat_priv)
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
@@ -3937,27 +3933,12 @@ static void batadv_tt_local_set_flags(struct batadv_priv *bat_priv, u16 flags,
 			entry_flags = &tt_common_entry->flags;
 			old_flags = atomic_read(entry_flags);
 
-			/* the old_flags value of the atomic test-and-
-			 * set/clear decides whether this entry counts as
-			 * changed.
-			 */
-			if (enable) {
-				if ((old_flags & flags) == flags)
-					continue;
+			if (!(old_flags & BATADV_TT_CLIENT_NEW))
+				continue;
 
-				old_flags = atomic_fetch_or(flags, entry_flags);
-				if ((old_flags & flags) == flags)
-					continue;
-			} else {
-				if (!(old_flags & flags))
-					continue;
-
-				old_flags = atomic_fetch_andnot(flags, entry_flags);
-				if (!(old_flags & flags))
-					continue;
-			}
-
-			if (!count)
+			old_flags = atomic_fetch_andnot(BATADV_TT_CLIENT_NEW,
+							entry_flags);
+			if (!(old_flags & BATADV_TT_CLIENT_NEW))
 				continue;
 
 			batadv_tt_local_size_inc(bat_priv,
@@ -4032,7 +4013,7 @@ static void batadv_tt_local_commit_changes_nolock(struct batadv_priv *bat_priv)
 		return;
 	}
 
-	batadv_tt_local_set_flags(bat_priv, BATADV_TT_CLIENT_NEW, false, true);
+	batadv_tt_local_transition_new(bat_priv);
 
 	batadv_tt_local_purge_pending_clients(bat_priv);
 	batadv_tt_local_update_crc(bat_priv);

-- 
2.47.3

