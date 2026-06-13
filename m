Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 524B2CD8CA8
	for <batman-adv@archiver.kernel.org>; Sat, 13 Jun 2026 20:57:26 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 9C5EB83FD5
	for <batman-adv@archiver.kernel.org>; Sat, 13 Jun 2026 22:57:24 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1781384244;
 b=GkNKcMwEI98w/eC192HS85sj5yO/14XtgGlPOZHOUN5qBnVgSTidzDP9lswxKU81BTvwz
 LBNom9BEq/JF+bKO+htehxjfrJHKhstKkgytNu8LeRDlBP4pglGtP/XPElw9RwLlVdvrmpi
 /h2m9XKJfGDltUANAqD+/J9qCehT2/U=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1781384244; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=3yU2ps227CEK2Aq9aakVQOfZU6TiXkfOcAC2H4fwfFQ=;
 b=sy2zwF/jkFknKyVZQeWXZ/Pdb2hEskVFx5AhJretmIyk3l0Vrbouskt4I13O40jENaNJl
 qNtDFPbscJcmNBqlMMOPtRpkNL9PJHrnYWMp3cp9QvH1iOE9aFa2hdAjIkY3mV6zOFzBJSQ
 Jb/Fow94hfDwQbcW55L1SfbMhbG/bhk=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 8296180FAE
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sat, 13 Jun 2026 22:57:00 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1781384220;
	b=nRqnuU3baXOAvSDYzNOa8c7U/exA+ZBvfGkd19yG8Hw5WHldr7lm6zxAgLTiqrETm9ZTan
	N+KSS7dkNfbnoi+A+5ElbK0URA8svp7fSBfQ4DuQCZTglMIrdFSK2+5XP8bemxeSCipsYy
	ZwH9/XQLsEz8+xG7RhJX3UyeTasXeOI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1781384220;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=3yU2ps227CEK2Aq9aakVQOfZU6TiXkfOcAC2H4fwfFQ=;
	b=vEuYAGa0qV6RAHK0cjE0S2q+GDz0www3VIy8ax1pgWWqZm8MAWkqM5vCGaH7w+X20dQqkE
	wDeWWz9FCnKtVu+23RHQQKCn1CwhCpRb3ugRCRoADu+lsPS3vilnjEZDMZAyohWEEn8zJF
	om1zV+RgucR39/0QrQdf6CEn1/OR9Xg=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b="dy9h/dUu";
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id DBBE920131;
	Sat, 13 Jun 2026 20:56:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1781384219;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3yU2ps227CEK2Aq9aakVQOfZU6TiXkfOcAC2H4fwfFQ=;
	b=dy9h/dUuMfpiyCwn+pKOW7N10gEc0NAM9qgsjmFkrHa0u4i8AQ+4NQFNij2mIYp8QfG+BP
	e5sE9sgcpE4S7YEdK2v3HOsRNL9zVm4asoB7uxXjf6pGSRtr/a45N1Va5ARX38uY4p5PbD
	aNaiMykX6+i7rNADCj7vIPavY8LH6vg=
From: Sven Eckelmann <sven@narfation.org>
Date: Sat, 13 Jun 2026 22:56:43 +0200
Subject: [PATCH RFC batadv 3/3] batman-adv: tt: simplify NEW flag
 transition code
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260613-tt-atomic-refactor-v1-3-9f6a762c5d24@narfation.org>
References: <20260613-tt-atomic-refactor-v1-0-9f6a762c5d24@narfation.org>
In-Reply-To: <20260613-tt-atomic-refactor-v1-0-9f6a762c5d24@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2958; i=sven@narfation.org;
 h=from:subject:message-id; bh=FUucQVUhyvp1SVDQyfOKWw5K9GrfyVq8qw/TT1g7Src=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFm6RwTVChY5y/SbdGZXm5gWvrHpmlF/sdKrtLOnX+hzz
 u9SS9WOUhYGMS4GWTFFlj1X8s9vZn8r/3nax6Mwc1iZQIYwcHEKwER+/GD4Kzlv7Uw23T5J/e8H
 ptcc5OksqznCck/q/ppGn6DD5pxSzgz/6w8cWpascPypUMR827uzfiZetMiPk3ra9b9e2ciqc5I
 8AwA=
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: 3AKXJQTQG7QXPA5KNV422QJSN46AUPKH
X-Message-ID-Hash: 3AKXJQTQG7QXPA5KNV422QJSN46AUPKH
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/3AKXJQTQG7QXPA5KNV422QJSN46AUPKH/>
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
index ffe0e9ec..b5c08045 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -3700,15 +3700,11 @@ void batadv_tt_free(struct batadv_priv *bat_priv)
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
@@ -3729,27 +3725,12 @@ static void batadv_tt_local_set_flags(struct batadv_priv *bat_priv, u16 flags,
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
@@ -3817,7 +3798,7 @@ static void batadv_tt_local_commit_changes_nolock(struct batadv_priv *bat_priv)
 		return;
 	}
 
-	batadv_tt_local_set_flags(bat_priv, BATADV_TT_CLIENT_NEW, false, true);
+	batadv_tt_local_transition_new(bat_priv);
 
 	batadv_tt_local_purge_pending_clients(bat_priv);
 	batadv_tt_local_update_crc(bat_priv);

-- 
2.47.3

