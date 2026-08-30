Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9DD2C61DE1
	for <batman-adv@archiver.kernel.org>; Sun, 30 Aug 2026 15:28:03 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 4B7428043F
	for <batman-adv@archiver.kernel.org>; Sun, 30 Aug 2026 17:28:02 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1788103682;
 b=QnLztHF69qBfezGIxftjTdesrU3Dgbgnz5H27kb95BUPWF1/F7/rJVS1dsXRW4dj2YN30
 ar1e87Ir+AbUkpc0k9cZMa2PqOwFvNg9Kzp+L9SMmV+2vqr9g0fPR6FYWtoYiJAShfiw9m2
 b8qN9wkgDRqRSrjTA/ruyoxvMYKeqrA=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1788103682; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=kKBV0TE1EcrcLr7QEWIdlL1jfEdB9mE/R/ul/CvnWFU=;
 b=Nvza4DOSIMyVraLLDWBi2zAaV1xx4ZN4uL2rGttbkzcodn+J366yU4IOa/GEvk1XZ3MFQ
 QA4yivBSmXriNVDs4f8o7mlZqL+bG6FDcbAAauBrzzT6sJyDO1DAw9gR277hBWxOODQVIFM
 y6EeTlQkBL59RAs6f/iMZFaYuO2JM6g=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id E0F2A803EA
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sun, 30 Aug 2026 17:22:39 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1788103359;
	b=wu4wtIbXeGwN/FnfAaBFwAHHxThn+X372eNLQ7UKbjEkqs+rUHMLtTQR5hikeGl4GvBRKp
	2bpLlwYtybAN5n+y8B1PuIzq/HAo9BQusVpSqPlzxj5Oi64ylnqqXqjKJsry67ogz0Ah5z
	o/4ZAcqjpihDZSgIykBaOA/dFukbVXE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1788103359;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=kKBV0TE1EcrcLr7QEWIdlL1jfEdB9mE/R/ul/CvnWFU=;
	b=QSDM7ivoV/pmxH6zLNyx3W+9qbysLAe1thN9kHVCdOUm18McRG+yQgEj/48gA5GwVJPEl3
	cpGuiW6A/rNn7wKqY8J8NSf5zfhZXlhV3RFSAJzOlstT6fDbLqruxYN8NIX3a3Mf5TxZAi
	+hnr3+gB//B9yXC9gg5FMj9q7V/Wf8I=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b="jE/ekGIA";
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id 7E91C2083E;
	Sun, 30 Aug 2026 15:22:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1788103355;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kKBV0TE1EcrcLr7QEWIdlL1jfEdB9mE/R/ul/CvnWFU=;
	b=jE/ekGIAIgIF0DQn7wWkkY4+9RRzCM2XnQMCWBVzpG6x1Aav1luHzpZjcP38dpXHkI3qGD
	GyHzYrh56qAwwFjW0xYB/oebrEirKlyjmAMWbHMDh+ariAMwG9eXUvl8S+4mIbPIc4R3oe
	Vg06Hoonfv4tatcjZ//1kEAyXsT8aI8=
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 30 Aug 2026 17:21:48 +0200
Subject: [PATCH batadv v6 11/20] batman-adv: tt: replace forward gotos in
 batadv_tt_local_add()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260830-tt-fixes-v6-11-a56568a15041@narfation.org>
References: <20260830-tt-fixes-v6-0-a56568a15041@narfation.org>
In-Reply-To: <20260830-tt-fixes-v6-0-a56568a15041@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3474; i=sven@narfation.org;
 h=from:subject:message-id; bh=9B34otVksE6+85a4GRoVJ/j2edCS9EHDNEghs8VgIo8=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFlTvNovGZwWVPoRIH57i6n0/9Vv0tVjwzXcN5ke7Artc
 eTrEC/pKGVhEONikBVTZNlzJf/8Zva38p+nfTwKM4eVCWQIAxenAExkTRgjw6W2/bNmhtVvEXvF
 u+vcWa+AH0+4Wbq5ltq4eokq8x9/OYXhn+HDBWm5E+c3nbv8uZ/vyEzJVxMPCIatrDO7cU0u5ED
 DDQYA
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: ROXNUKWCIOCK2366U2QWZFTWQ2VVYC2H
X-Message-ID-Hash: ROXNUKWCIOCK2366U2QWZFTWQ2VVYC2H
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/ROXNUKWCIOCK2366U2QWZFTWQ2VVYC2H/>
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
index 4b7708ca..a242523f 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -871,6 +871,7 @@ bool batadv_tt_local_add(struct net_device *mesh_iface, const u8 *addr,
 	struct batadv_tt_global_entry *tt_global = NULL;
 	struct batadv_tt_local_entry *tt_local;
 	bool roamed_back = false;
+	bool added = false;
 	bool iif_is_wifi;
 	bool ret = false;
 	u8 remote_flags;
@@ -899,12 +900,8 @@ bool batadv_tt_local_add(struct net_device *mesh_iface, const u8 *addr,
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
@@ -917,29 +914,29 @@ bool batadv_tt_local_add(struct net_device *mesh_iface, const u8 *addr,
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

