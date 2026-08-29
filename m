Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 674F6C61DD6
	for <batman-adv@archiver.kernel.org>; Sat, 29 Aug 2026 06:27:03 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 0462180D5F
	for <batman-adv@archiver.kernel.org>; Sat, 29 Aug 2026 08:27:02 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1787984822;
 b=LiklhdehbewaZ/s8z6BnbDtMl0HCN12nbVTr0azLw69muIMV3znzeaCGPxNAhFlrOBg5i
 x8sD3Wmiu8DlJLjlFB/ygFQyhcTN4gLVSSayIgy2a4M/nJznjSt77v8JoC712C1bcrWeGW0
 5rbodrKNySr0T7stHN444SjP+UMWq3Y=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1787984822; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=2B+UoCLKO6t2mGbVM+F0tooy2beKjrAH9RLYJdfI280=;
 b=WACcTbwQBQ1kxKbPgCuYjhCi4Pp98exSv+hgXZgVSH3b32AGQxFF9M9SFL7tlQrjWpN3S
 rkQqEHNDSO10pjuAH+vjKVoXifuw5+aJqW7ae49ihL+LsUQJ0G2nM7CMjELlBgrCz1m15Wg
 ZRGvVMjFb/ZGrLc/KtwismfZdOSbhko=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 48F52842E5
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sat, 29 Aug 2026 08:21:54 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1787984514;
	b=LaI0ljyWFU3SFOcqXyt1J45ZtVm2hJ4biQWOP1nw+m5XaDhoDdjEy1UXrv4etVO78c1oKm
	i606EHjzhNLsTvNkSanFFj7htN8knMx8vE7hQdxwNl8jKBK/sjRAaYLJ5pXI/qBlQ7PKka
	dUfdQKegHzrzoe5S/h/IzJ4ZzkxjG0o=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1787984514;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=2B+UoCLKO6t2mGbVM+F0tooy2beKjrAH9RLYJdfI280=;
	b=w7UiQwpWGmQU72kr1wGDJWdsL+DkL17QKZUtrq3XqNtYrsgvf3oVhzCShgW8DtV/28pmN9
	5TEQt/pBOpHJu3gmub6DVoJgyGC89YoiiTY4pBrDiRg9qUbc4zpXC3zkDKeiuamPu5Kz+w
	rerE3Bm6G1yA/JsQ2fJmSzUbEAPkqb8=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b="0/ph5/eS";
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id D8553200E4;
	Sat, 29 Aug 2026 06:21:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1787984509;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2B+UoCLKO6t2mGbVM+F0tooy2beKjrAH9RLYJdfI280=;
	b=0/ph5/eSr7WtO5cOyWpHKF2nY30grR7GQ0Oh3B68nUGJExcPCWaaYdOn7dhSpYdudhtuFz
	6mT5etX57jC56e0QVFdQnFUeQFruxkZsWS3bK5Omo8gX+9KB9Rm8BEf4Yj/zstog+WGVaA
	j3Bt1C/OC0/BhP0sIrwznwTI248fmm0=
From: Sven Eckelmann <sven@narfation.org>
Date: Sat, 29 Aug 2026 08:18:26 +0200
Subject: [PATCH batadv v5 15/20] batman-adv: tt: extract merging of flags
 into existing global entries
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260829-tt-fixes-v5-15-88fce8fd683d@narfation.org>
References: <20260829-tt-fixes-v5-0-88fce8fd683d@narfation.org>
In-Reply-To: <20260829-tt-fixes-v5-0-88fce8fd683d@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4363; i=sven@narfation.org;
 h=from:subject:message-id; bh=dQRzIPCyONEp5MHLobeWwPOzsUSx+r5mKwKGpepqIJU=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFmTKte+3NAak7QjY+Xr6IMWvJzKLg7ONRMbf2axPkzIV
 Nx8MnR1RykLgxgXg6yYIsueK/nnN7O/lf887eNRmDmsTCBDGLg4BWAim1MY/nAdW3KLhZUjhvF7
 q+qCR5++5Bp4f7JouTndr3hP4K1NGxoY/oqbCV790q9t/DvpbuD622bh7IWMeaXXL4vdfHphcfr
 1u1wA
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: UVDZLVOB4BOAWA4OOPT3N5QSJCRMWZJP
X-Message-ID-Hash: UVDZLVOB4BOAWA4OOPT3N5QSJCRMWZJP
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/UVDZLVOB4BOAWA4OOPT3N5QSJCRMWZJP/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

When an already known global TT entry is announced again, its flags have to
be merged with the announced ones. Two of the merge steps also decide
whether the originator list has to be purged before the announced
originator is added.

Move this to batadv_tt_global_merge_flags() and let it report via its
return value whether the originator list has to be purged.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/translation-table.c | 87 +++++++++++++++++++++++---------------
 1 file changed, 52 insertions(+), 35 deletions(-)

diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index d9055d07..71d9fcf6 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -1884,6 +1884,57 @@ batadv_tt_global_orig_entry_add(struct batadv_tt_global_entry *tt_global,
 	spin_unlock_bh(&tt_global->list_lock);
 }
 
+/**
+ * batadv_tt_global_merge_flags() - merge announced flags into a global TT entry
+ * @tt_global_entry: the global TT entry to update
+ * @flags: TT flags announced for this non-mesh client
+ *
+ * Return: true if the originator list of @tt_global_entry has to be purged
+ * before the announced originator is added, false otherwise.
+ */
+static bool
+batadv_tt_global_merge_flags(struct batadv_tt_global_entry *tt_global_entry,
+			     u16 flags)
+{
+	struct batadv_tt_common_entry *common = &tt_global_entry->common;
+	bool delete = false;
+
+	scoped_guard(spinlock_bh, &common->flags_lock) {
+		/* if the client was temporary added before receiving the first
+		 * OGM announcing it, we have to clear the TEMP flag. Also,
+		 * remove the previous temporary orig node and re-add it
+		 * if required. If the orig entry changed, the new one which
+		 * is a non-temporary entry is preferred.
+		 */
+		if (common->flags & BATADV_TT_CLIENT_TEMP) {
+			delete = true;
+			common->flags &= ~BATADV_TT_CLIENT_TEMP;
+		}
+
+		/* the change can carry possible "attribute" flags like the
+		 * TT_CLIENT_TEMP, therefore they have to be copied in the
+		 * client entry
+		 */
+		if (!is_multicast_ether_addr(common->addr))
+			common->flags |= flags & (~BATADV_TT_SYNC_MASK);
+
+		/* If there is the BATADV_TT_CLIENT_ROAM flag set, there is only
+		 * one originator left in the list and we previously received a
+		 * delete + roaming change for this originator.
+		 *
+		 * We should first delete the old originator before adding the
+		 * new one.
+		 */
+		if (common->flags & BATADV_TT_CLIENT_ROAM) {
+			delete = true;
+			tt_global_entry->roam_at = 0;
+			common->flags &= ~BATADV_TT_CLIENT_ROAM;
+		}
+	}
+
+	return delete;
+}
+
 /**
  * batadv_tt_global_create() - allocate and initialize a global TT entry
  * @tt_addr: the mac address of the non-mesh client
@@ -2026,41 +2077,7 @@ static bool batadv_tt_global_add(struct batadv_priv *bat_priv,
 			goto add_orig_entry;
 		}
 
-		delete = false;
-
-		spin_lock_bh(&common->flags_lock);
-		/* if the client was temporary added before receiving the first
-		 * OGM announcing it, we have to clear the TEMP flag. Also,
-		 * remove the previous temporary orig node and re-add it
-		 * if required. If the orig entry changed, the new one which
-		 * is a non-temporary entry is preferred.
-		 */
-		if (common->flags & BATADV_TT_CLIENT_TEMP) {
-			delete = true;
-			common->flags &= ~BATADV_TT_CLIENT_TEMP;
-		}
-
-		/* the change can carry possible "attribute" flags like the
-		 * TT_CLIENT_TEMP, therefore they have to be copied in the
-		 * client entry
-		 */
-		if (!is_multicast_ether_addr(common->addr))
-			common->flags |= flags & (~BATADV_TT_SYNC_MASK);
-
-		/* If there is the BATADV_TT_CLIENT_ROAM flag set, there is only
-		 * one originator left in the list and we previously received a
-		 * delete + roaming change for this originator.
-		 *
-		 * We should first delete the old originator before adding the
-		 * new one.
-		 */
-		if (common->flags & BATADV_TT_CLIENT_ROAM) {
-			delete = true;
-			tt_global_entry->roam_at = 0;
-			common->flags &= ~BATADV_TT_CLIENT_ROAM;
-		}
-		spin_unlock_bh(&common->flags_lock);
-
+		delete = batadv_tt_global_merge_flags(tt_global_entry, flags);
 		if (delete)
 			batadv_tt_global_del_orig_list(tt_global_entry);
 	}

-- 
2.47.3

