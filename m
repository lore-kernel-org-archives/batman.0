Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA034C56208
	for <batman-adv@archiver.kernel.org>; Thu,  6 Aug 2026 09:46:43 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 546968427F
	for <batman-adv@archiver.kernel.org>; Thu, 06 Aug 2026 11:46:42 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1786009602;
 b=3wOrRE1Tte74wEkmgGjfsA2WbIvul1zJRKBUo0p1WEJFsaggErb2RZD2Ql13Xf1h4ly1W
 UAw1aiiyLn9QgI1F/XhaD4q2O+vJbxI4EixLXw1TrGhfU35xvc8afjuReg4NweJ+na4qkD/
 KYIzEFQ4eLMDoHg/Wx5eoh7ipzOJN10=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1786009602; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=K5tvL5/+2cVvUruEHaCT6c/xAoS19UH9QEYvJgJr/Bc=;
 b=OhQrF+Rga+Nc3/DRfWNbvAIDo6C0x06hkAMRQZkj4iExAcdLtty1hqbsuol3svLqeCG/Y
 aEFGe4ytCbLzUfU4LltVp5MzQ8iglhhagltSX67iH7/40z/cDw9tCCCp/PhQnLfPZ9C/LtU
 0D+uD1rqNUL6ubhJW6Mmyeb2yFDxOLk=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org
 [IPv6:2a00:17d8:100::8b1])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 63CD584219
	for <b.a.t.m.a.n@lists.open-mesh.org>; Thu, 06 Aug 2026 11:45:07 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1786009507;
	b=OppPGBnYWiWlZfu16uSklhMBvgLmFGRseeX/SfF7yu2M4n9IR6JcrJG7ExEwNtKTXalTNV
	jbDxWJme+YJGkhdy3TMOzEMrVBKU3p0IzsexN91JELVo2VZuynfJUPAE9HSWcOEmkeB3Fq
	8YZpIVCF+H7OimNWe+hvJH5uiWjOB1o=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1786009507;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=K5tvL5/+2cVvUruEHaCT6c/xAoS19UH9QEYvJgJr/Bc=;
	b=v0lnxfIY7xGpNMhL5qgcqUb8O6oko2tbR9H9aa37UKMemwya9o3QRAM+52iW0US13pelhm
	C6McO6UB020beTWGF55XzT2YLclPHdqOqe7C0kl+vCXXOztGNNXtHtRwLAy2pQDg2Sc9Z9
	SKHYtIDJ1kEyenN2m0OfBBbl2rmT8UU=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b="QfS/0Gh+";
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id F192920590;
	Thu, 06 Aug 2026 09:45:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1786009503;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=K5tvL5/+2cVvUruEHaCT6c/xAoS19UH9QEYvJgJr/Bc=;
	b=QfS/0Gh+oSyj4tAanFUADmnzWK1U1x4nDHdKbugxDQyxhz5KoxOGI+MQsPochDU8zDZUjh
	bAajvjc/NzO2yML1Mb2QQSw7WX4UfHgaItlBgNl5yWgqDmXWI3knYlf/UucgYB42RP5bhW
	qLZ+v6nN0Um2AHIKCk48eo5pFDrOjGQ=
From: Sven Eckelmann <sven@narfation.org>
Date: Thu, 06 Aug 2026 11:44:16 +0200
Subject: [PATCH RFC batadv 03/12] batman-adv: tt: replace forward gotos in
 batadv_tt_local_add()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260806-tt-add-cleanup-v1-3-ffcad65bccc4@narfation.org>
References: <20260806-tt-add-cleanup-v1-0-ffcad65bccc4@narfation.org>
In-Reply-To: <20260806-tt-add-cleanup-v1-0-ffcad65bccc4@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3474; i=sven@narfation.org;
 h=from:subject:message-id; bh=4jZdhWPXZ9wlahmM78ASgFlCcc4EsFkci5lCNQjIAhQ=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFkl4c25wX9i76/ZaXh1/uzqVw1vYr8an2bfc9gx4fy7u
 NPbRJe96yhlYRDjYpAVU2TZcyX//Gb2t/Kfp308CjOHlQlkCAMXpwBMpGE7I8N7fWuto5Me7WRf
 vX+X+1NGgy7BWtclC1uvf9r7+tzBdzulGRleLGv0fbvAxoiri/+zd98i58mp6jXTub5oPAxgsZ8
 t3sEMAA==
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: DOXHXDUF5NEXH534HOYOWZTGRX7RSX2O
X-Message-ID-Hash: DOXHXDUF5NEXH534HOYOWZTGRX7RSX2O
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/DOXHXDUF5NEXH534HOYOWZTGRX7RSX2O/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

batadv_tt_local_add() used two labels in the middle of the function to
express which parts of the common tail have to be executed: "add_event" to
announce a (re-)added client and "check_roaming" to skip that announcement.
Jumping forward into the middle of a function makes it hard to see which
path ends up sending an ADD event. Especially since the PENDING branch
reached "add_event" while the branch right below it reached "check_roaming"
instead.

Express the same in an "added" variable and turn the two client cases into
a plain if/else. The PENDING check returned early before the ROAM check
could run, so it becomes an "else if".

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/translation-table.c | 47 ++++++++++++++++++--------------------
 1 file changed, 22 insertions(+), 25 deletions(-)

diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index 8726bbba..5405be65 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -870,6 +870,7 @@ bool batadv_tt_local_add(struct net_device *mesh_iface, const u8 *addr,
 	struct batadv_tt_global_entry *tt_global = NULL;
 	struct batadv_tt_local_entry *tt_local;
 	bool roamed_back = false;
+	bool added = false;
 	bool iif_is_wifi;
 	bool ret = false;
 	u8 remote_flags;
@@ -898,12 +899,8 @@ bool batadv_tt_local_add(struct net_device *mesh_iface, const u8 *addr,
 			 * flag can be reset like it was never enqueued
 			 */
 			tt_local->common.flags &= ~BATADV_TT_CLIENT_PENDING;
-			spin_unlock_bh(&tt_local->common.flags_lock);
-
-			goto add_event;
-		}
-
-		if (tt_local->common.flags & BATADV_TT_CLIENT_ROAM) {
+			added = true;
+		} else if (tt_local->common.flags & BATADV_TT_CLIENT_ROAM) {
 			batadv_dbg(BATADV_DBG_TT, bat_priv,
 				   "Roaming client %pM (vid: %d) came back to its original location\n",
 				   addr, batadv_print_vid(vid));
@@ -916,29 +913,29 @@ bool batadv_tt_local_add(struct net_device *mesh_iface, const u8 *addr,
 			roamed_back = true;
 		}
 		spin_unlock_bh(&tt_local->common.flags_lock);
+	} else {
+		tt_local = batadv_tt_local_create(mesh_iface, addr, vid, iif_is_wifi);
+		if (!tt_local)
+			goto out;
 
-		goto check_roaming;
+		kref_get(&tt_local->common.refcount);
+		hash_added = batadv_hash_add(bat_priv->tt.local_hash, batadv_compare_tt,
+					     batadv_choose_tt, &tt_local->common,
+					     &tt_local->common.hash_entry);
+
+		if (unlikely(hash_added != 0)) {
+			/* remove the reference for the hash */
+			batadv_tt_local_entry_put(tt_local);
+			goto out;
+		}
+
+		added = true;
 	}
 
-	tt_local = batadv_tt_local_create(mesh_iface, addr, vid, iif_is_wifi);
-	if (!tt_local)
-		goto out;
+	/* announce the (re-)added client to the mesh */
+	if (added)
+		batadv_tt_local_event(bat_priv, tt_local, BATADV_NO_FLAGS);
 
-	kref_get(&tt_local->common.refcount);
-	hash_added = batadv_hash_add(bat_priv->tt.local_hash, batadv_compare_tt,
-				     batadv_choose_tt, &tt_local->common,
-				     &tt_local->common.hash_entry);
-
-	if (unlikely(hash_added != 0)) {
-		/* remove the reference for the hash */
-		batadv_tt_local_entry_put(tt_local);
-		goto out;
-	}
-
-add_event:
-	batadv_tt_local_event(bat_priv, tt_local, BATADV_NO_FLAGS);
-
-check_roaming:
 	batadv_tt_local_add_roam(bat_priv, tt_global, roamed_back);
 
 	spin_lock_bh(&tt_local->common.flags_lock);

-- 
2.47.3

