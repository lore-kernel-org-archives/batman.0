Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89E36CD4851
	for <batman@archiver.kernel.org>; Thu, 14 May 2026 15:44:49 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 17A4285D22
	for <batman@archiver.kernel.org>; Thu, 14 May 2026 17:44:48 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1778773488;
 b=vZPVGram97hAsNoXHrI4Xvlb+zBiSv833nEEsHT9kLHK+KlKpTLiDGxINxMHGAoCfDbiN
 UH6QlU2BESFGR1QdZGSjeb6hVTxcsGalb/llRCUv/Q2X567I2PxdZDW796SqPY/z3w+iFCF
 QxQl+G1Q3FePml9dyPBLGhLOUpSobPU=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1778773488; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=gt2S5syziJdkxqfKYMn2Uy4pDKjZgaU/bKCTW+wRz5c=;
 b=MRmbgYIX8EUOu0luWdJZ7w4+y8R/FCvesTMoUyVx7A8Kd5/Sn4lVKKyAIys0UQK7pRbmM
 HTap37ED3+8PsZha5enZxl8yn1UeLKtP2sAyBCFsSHTEn4mV3GnF1H6ANge0fHhun3Pbbq0
 spgKPCGHy2Ho3ZaE8rr51daiHjmNXOc=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id D55F785BC3
	for <b.a.t.m.a.n@lists.open-mesh.org>; Thu, 14 May 2026 17:43:42 +0200 (CEST)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1778773422;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=gt2S5syziJdkxqfKYMn2Uy4pDKjZgaU/bKCTW+wRz5c=;
	b=dfunCaCmSjI1tAqD8uOAXsKA7njKw95SAy3pciJas1GxoES5EUPiLJOdvtjc6DeY4PTB08
	MW/6uIBkal0LqjjUhxVLNbjSykpWOzJbwC9OjmkHoEglocbR0JyI+achcwUi/CA+b3XsP7
	9aiVjgqV0i1uqidQNBS6/4GgjzWAZBM=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=GSxv+JNS;
	dmarc=pass (policy=none) header.from=narfation.org;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1778773422;
	b=WhRjYh2FVOeJaotU6cCt2elsDEoFNfZz3T2DrCUwGvhbSW9f/FnI3z6jjrXbfRr39+esmv
	TqbIeewfucA2SU5Ey+K0lU/L0mte9XmtrZm/dvDsqbpVAf/VVJaxcstdal9aiMkbpqBjVN
	WTq9Fhxy/9EeHhxr/CHwbpQyvJg82V4=
Received: by dvalin.narfation.org (Postfix) id 3D6AC1FD98;
	Thu, 14 May 2026 15:43:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1778773422;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gt2S5syziJdkxqfKYMn2Uy4pDKjZgaU/bKCTW+wRz5c=;
	b=GSxv+JNSDhMfII/kSa91SQ6tCGsQYI7BDJnxZEzVm1xCKffYeIT8TkZeDC3RK47omOZqPF
	9Qva4qcigVZYD/IxCZoNfJf5XXnAB2hZdN6U6R5EK4P8UiSd4rHSpAqvdrSZMyX2mGpn3d
	7q4pWN0oUXZ5JkgazpljumcM0QJt1yA=
From: Sven Eckelmann <sven@narfation.org>
Date: Thu, 14 May 2026 17:43:12 +0200
Subject: [PATCH batadv v3 1/2] batman-adv: bla: fix report_work leak on
 backbone_gw purge
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260514-bla-cancel-work-v3-1-dc65d3485e11@narfation.org>
References: <20260514-bla-cancel-work-v3-0-dc65d3485e11@narfation.org>
In-Reply-To: <20260514-bla-cancel-work-v3-0-dc65d3485e11@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>,
 Simon Wunderlich <sw@simonwunderlich.de>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3768; i=sven@narfation.org;
 h=from:subject:message-id; bh=NirVm14j8UtMcZyAKcjYubuLNFLUABRgahHP0giwDF8=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFmsbyeX/GK5/OcFi4dlo39ozHVfHbZnFkrrjhR8+f+c/
 52DXrBZRykLgxgXg6yYIsueK/nnN7O/lf887eNRmDmsTCBDGLg4BWAiVx8z/LP7d1GQ6WT698nc
 1juSrfXDP77m/pTXGCiwv7eXu3G5ZDjD/5iQO88n/dcw/yqm/dbRPlr9wn0XrQVnDvO9ZNaOVcl
 qZwQA
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: RLZLAOEUMGY4KCQ66XV3LU3UZMIFCOVB
X-Message-ID-Hash: RLZLAOEUMGY4KCQ66XV3LU3UZMIFCOVB
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/RLZLAOEUMGY4KCQ66XV3LU3UZMIFCOVB/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

batadv_bla_purge_backbone_gw() removes stale backbone gateway entries,
but fails to properly handle their associated report_work:

- If report_work is running, the purge must wait for it to finish before
  freeing the backbone_gw, otherwise the worker may access freed memory
  (e.g. bat_priv).
- If report_work is pending, the purge must cancel it and release the
  reference held for that pending work item.

The previous implementation called hlist_for_each_entry_safe() inside a
spin_lock_bh() section, but cancel_work_sync() may sleep and therefore
cannot be called from within a spinlock-protected region.

Restructure the loop to handle one entry per spinlock critical section:
acquire the lock, find the next entry to purge, remove it from the hash
list, then release the lock before calling cancel_work_sync() and
dropping the hash_entry reference. Repeat until no more entries require
purging.

Fixes: a998bf5dfbd7 ("batman-adv: add detection for complex bridge loops")
Reviewed-by: Simon Wunderlich <sw@simonwunderlich.de>
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/bridge_loop_avoidance.c | 54 ++++++++++++++++++++++------------
 1 file changed, 35 insertions(+), 19 deletions(-)

diff --git a/net/batman-adv/bridge_loop_avoidance.c b/net/batman-adv/bridge_loop_avoidance.c
index cec11f12..df1dfdf4 100644
--- a/net/batman-adv/bridge_loop_avoidance.c
+++ b/net/batman-adv/bridge_loop_avoidance.c
@@ -1224,6 +1224,7 @@ static void batadv_bla_purge_backbone_gw(struct batadv_priv *bat_priv, int now)
 	struct hlist_head *head;
 	struct batadv_hashtable *hash;
 	spinlock_t *list_lock;	/* protects write access to the hash lists */
+	bool purged;
 	int i;
 
 	hash = bat_priv->bla.backbone_hash;
@@ -1234,30 +1235,45 @@ static void batadv_bla_purge_backbone_gw(struct batadv_priv *bat_priv, int now)
 		head = &hash->table[i];
 		list_lock = &hash->list_locks[i];
 
-		spin_lock_bh(list_lock);
-		hlist_for_each_entry_safe(backbone_gw, node_tmp,
-					  head, hash_entry) {
-			if (now)
-				goto purge_now;
-			if (!batadv_has_timed_out(backbone_gw->lasttime,
-						  BATADV_BLA_BACKBONE_TIMEOUT))
-				continue;
+		do {
+			purged = false;
 
-			batadv_dbg(BATADV_DBG_BLA, backbone_gw->bat_priv,
-				   "%s(): backbone gw %pM timed out\n",
-				   __func__, backbone_gw->orig);
+			spin_lock_bh(list_lock);
+			hlist_for_each_entry_safe(backbone_gw, node_tmp,
+						  head, hash_entry) {
+				if (now)
+					goto purge_now;
+				if (!batadv_has_timed_out(backbone_gw->lasttime,
+							  BATADV_BLA_BACKBONE_TIMEOUT))
+					continue;
+
+				batadv_dbg(BATADV_DBG_BLA, backbone_gw->bat_priv,
+					   "%s(): backbone gw %pM timed out\n",
+					   __func__, backbone_gw->orig);
 
 purge_now:
-			/* don't wait for the pending request anymore */
-			if (atomic_read(&backbone_gw->request_sent))
-				atomic_dec(&bat_priv->bla.num_requests);
+				purged = true;
 
-			batadv_bla_del_backbone_claims(backbone_gw);
+				/* don't wait for the pending request anymore */
+				if (atomic_read(&backbone_gw->request_sent))
+					atomic_dec(&bat_priv->bla.num_requests);
 
-			hlist_del_rcu(&backbone_gw->hash_entry);
-			batadv_backbone_gw_put(backbone_gw);
-		}
-		spin_unlock_bh(list_lock);
+				batadv_bla_del_backbone_claims(backbone_gw);
+
+				hlist_del_rcu(&backbone_gw->hash_entry);
+				break;
+			}
+			spin_unlock_bh(list_lock);
+
+			if (purged) {
+				/* reference for pending report_work */
+				if (cancel_work_sync(&backbone_gw->report_work))
+					batadv_backbone_gw_put(backbone_gw);
+
+				/* reference for hash_entry */
+				batadv_backbone_gw_put(backbone_gw);
+			}
+		} while (purged);
 	}
 }
 

-- 
2.47.3

