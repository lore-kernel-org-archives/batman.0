Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D14D6C61DD9
	for <batman-adv@archiver.kernel.org>; Sun, 30 Aug 2026 15:30:12 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 74D3280470
	for <batman-adv@archiver.kernel.org>; Sun, 30 Aug 2026 17:30:11 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1788103811;
 b=a9pqQZ/PlzKOLLfSwN9CrveCY6OGU7O+u/lMS6scQJvjFMPHI9vd5huQSevz+7lvd13EY
 FIDVspbCj1A0KF8zu0Cdml7DlcAtqX2UyJTr94gtPX9nKEkIaJof6oZfvVZVo1Zz6ZikNm8
 +lpMaxk/U6MFgXFsFM6ejtRSvvH3TyI=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1788103811; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=DBzmOE6LhhwiU26quLjAncsfhAdrhBU3qOxc/PVTjrU=;
 b=wSB+dGnNlkMwZpWLy6nJAq+YBPLEwFe7HuwpXl+4r5PVaRxgBtizWUObLsfnVR+f8RAVd
 DMc9T1iUyzwzOow6IMQSyJG6FwZcQZWTyoLuZX0nxf+hmg/vmRpEVfTnAQmsldgK2Meut/C
 edZrsl4KWDxcBJxTmQtTxxLQjQdAvCc=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 50C4A804AB
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sun, 30 Aug 2026 17:22:58 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1788103378;
	b=i34t/vfnWd+eoxUlJpCB+DxrnIZFrUGiQ9B+U0fj8aEz/St30+WGLQBX8/PNcDr0WE09hV
	GsnhBh80TnXZle8ttYBgfDVR+Vu6r7rXtylFE2UVHJGpxed+iGJUh4iThJyXDfc3HR5+aE
	C7uIoUgQ+66pTZbaXQ8MoNFemdVO/os=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1788103378;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=DBzmOE6LhhwiU26quLjAncsfhAdrhBU3qOxc/PVTjrU=;
	b=GpXYfQaT6YGU6IrtRjCcM5+ku8iFDUd279E72MWAW9IZ5BzCliVF71sW0NxOSxPtBiC0Gi
	osLmJMrYI8BJXVQsnjwyCPlsqD4P3udtjfxEVL90sDKe6Eppz6G93tuXq7bxaLLmSFP2vQ
	+Vnqqo63n1FNPvX6pdwyBiXv3Y26vSo=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=Cq2scQNn;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id E7CE62083E;
	Sun, 30 Aug 2026 15:22:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1788103374;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DBzmOE6LhhwiU26quLjAncsfhAdrhBU3qOxc/PVTjrU=;
	b=Cq2scQNnvfM/SFq9+CQJVqXObYyIQFlaiuDIL6L0vS9cBnAdGrW3tu1Ja6iYXCOXN63x3T
	jAZlWefIvM12RmkP5dcJ8Ijn2vbCb1d9KuVEFL9kJX/Gkx3a1mOyFQLhcAfaadJqUQJuNL
	DM7WkBW5/A8lHU9RikEgmd/BObS+DVA=
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 30 Aug 2026 17:21:52 +0200
Subject: [PATCH batadv v6 15/20] batman-adv: tt: extract merging of flags
 into existing global entries
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260830-tt-fixes-v6-15-a56568a15041@narfation.org>
References: <20260830-tt-fixes-v6-0-a56568a15041@narfation.org>
In-Reply-To: <20260830-tt-fixes-v6-0-a56568a15041@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4363; i=sven@narfation.org;
 h=from:subject:message-id; bh=vRcblX1jnnhcc/eVNURszvdxihacN9CZD7XU2NkolCg=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFlTvNq5ZizOkFT5avnv4c6bm1c+/qEmvSDHZcKxc4ftW
 /f7Cd9i7ShlYRDjYpAVU2TZcyX//Gb2t/Kfp308CjOHlQlkCAMXpwBM5KQ8I8Oj3qrExaxcZ3RP
 bLDsn66jpZSltDe+tibacvatVfGTfrcz/E+ce19lKoPa0lgeDnN9Wyn9/SdjUpb6H79y5pm8g8t
 0U2YA
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: 2HBY3KAIKM7NA5VUK3DO624ECIZUPWHQ
X-Message-ID-Hash: 2HBY3KAIKM7NA5VUK3DO624ECIZUPWHQ
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/2HBY3KAIKM7NA5VUK3DO624ECIZUPWHQ/>
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
index e81923c9..deb7c1af 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -1885,6 +1885,57 @@ batadv_tt_global_orig_entry_add(struct batadv_tt_global_entry *tt_global,
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
@@ -2027,41 +2078,7 @@ static bool batadv_tt_global_add(struct batadv_priv *bat_priv,
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

