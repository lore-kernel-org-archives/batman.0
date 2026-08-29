Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F41E7C61DD6
	for <batman-adv@archiver.kernel.org>; Sat, 29 Aug 2026 06:24:56 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 980A180A83
	for <batman-adv@archiver.kernel.org>; Sat, 29 Aug 2026 08:24:55 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1787984695;
 b=ksGHQ3ulPQbnKAVmvTz1uETx7KfnRtltCoU6joVjpx90kg4rwLZlk5Ir4lbvieCzc0ftk
 KbEUlwkjcvRC8f86J1eOOwJyjUqJaIB1ys6zrlm7xJK+L8Ps8Z0LqJm9uX7/M0Ohe2llZqK
 btgZfEMXR8EX4j/Jt+8jrn2e1E1DcY4=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1787984695; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=K5tvL5/+2cVvUruEHaCT6c/xAoS19UH9QEYvJgJr/Bc=;
 b=Bgm2hzsi4sZdY3/7CNVRN7OY20xZYMnDmlcTK8C0dTZyh8Ih5pGsCkNw7EOZOmDGtH2qz
 9EOBIKlyTCwNB/tj3hM6Ulm7yg7k8Gg/vi3x00AOFmBM9C16vDy+2MVwaFaV53UcO87WUq6
 ayAP3XTdzUXUc124U3Q7i43YLYTC0n4=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id A6AB283E9A
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sat, 29 Aug 2026 08:21:14 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1787984474;
	b=bKnULWZhwFM/rM/OYeW6mPYbGYAbqtwNx1n89pAxmyohDfQc1xaOoVrMAQOpnwKAuPa6Yl
	BN4IAqfTwkCPfj2e+LfCBMm2P936Vq/83yBj1MivZ/DC1Jupt8C9W4cNvxd1r39YIjY6T+
	JbMmomxq+ir3h2MBS91sQbn98CRzKQQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1787984474;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=K5tvL5/+2cVvUruEHaCT6c/xAoS19UH9QEYvJgJr/Bc=;
	b=kyoFtRCQqyRYfiILkmvUIvyZhI5o+0j8A+hgkPhXdth2I7c2WFresfTwz3exbgDVEhRiC5
	xwTYNNs2Tm5yh/fBCQhvZaCEpigQKLGNypw3O/Chn6oxfjTYtuhlmF3Ame3UDOGOK9byqG
	ilKr70PIPcovhwxu/sOHyErE2FW46GU=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=Uuhkjerx;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id 3DB00200E4;
	Sat, 29 Aug 2026 06:21:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1787984470;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=K5tvL5/+2cVvUruEHaCT6c/xAoS19UH9QEYvJgJr/Bc=;
	b=UuhkjerxBQeyQA776DbbMo/xh+e6NZYuJKjD02hDJja7q9J2tpupWd0AJMUcLl7XcZRNrE
	JV5VcnXop46xN2zQBlW9w/jcidmnvwId8SHb2U1dmQwjk56oLILzxvHRYZSY9ysC6QffL1
	UtWcThjmQA6vj4rlT9pYNc2hnjdj3UA=
From: Sven Eckelmann <sven@narfation.org>
Date: Sat, 29 Aug 2026 08:18:22 +0200
Subject: [PATCH batadv v5 11/20] batman-adv: tt: replace forward gotos in
 batadv_tt_local_add()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260829-tt-fixes-v5-11-88fce8fd683d@narfation.org>
References: <20260829-tt-fixes-v5-0-88fce8fd683d@narfation.org>
In-Reply-To: <20260829-tt-fixes-v5-0-88fce8fd683d@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3474; i=sven@narfation.org;
 h=from:subject:message-id; bh=4jZdhWPXZ9wlahmM78ASgFlCcc4EsFkci5lCNQjIAhQ=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFmTKtfqMOyLm2YuejbxrIluqpHYzpPejy49ehelWjhdW
 eNJ2Tv3jlIWBjEuBlkxRZY9V/LPb2Z/K/952sejMHNYmUCGMHBxCsBE7sxlZFgfKLx5ammmd5Xf
 U40prb9t8vm3lyjNzV7AcYu9qbIx+zUjw+q661kaVct8p8/c1H1HbX6CbdXG/O5evl1/i2abb2C
 czQYA
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: VGM4WQBB54W3SOCZNGPNOJBGLP7IA7VG
X-Message-ID-Hash: VGM4WQBB54W3SOCZNGPNOJBGLP7IA7VG
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/VGM4WQBB54W3SOCZNGPNOJBGLP7IA7VG/>
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

