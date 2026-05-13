Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D33FECD4F21
	for <batman@archiver.kernel.org>; Wed, 13 May 2026 20:37:57 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 5678185C78
	for <batman@archiver.kernel.org>; Wed, 13 May 2026 22:37:56 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1778704676;
 b=hLfRXgQaO7bFw6L48DA3QuNNF0w/QW91yLBTlw3jZc7DiDx8DtBoN6VOy8cpkbhkWhAc6
 lSAWgwraNKrc50CcmH2X3SseS754c79V5983xgqV2vsL6lOCGlwlls/8rdQCarahOUc7e3D
 7BMNe6QAhXVZRXXFQCOW8+TveOOxmac=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1778704676; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=gt2S5syziJdkxqfKYMn2Uy4pDKjZgaU/bKCTW+wRz5c=;
 b=q/0FU+8OsaXUtDDYJ2Bj189fh3f0HNxbHs0cBNjr4NkcjmSHGUvEQ9bMtyVTVv4PHjtRw
 9dmpDOv92vMoNKtwUl+Wu2KRIv9jsS3D4bElSOVRplU97fnlkG+1+aKBhYF9cILI+EVgyne
 cYaTric2XW8FyqBSD1hs/lZcsQVkItg=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id DB3B68474C
	for <b.a.t.m.a.n@lists.open-mesh.org>; Wed, 13 May 2026 22:36:44 +0200 (CEST)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1778704609;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=gt2S5syziJdkxqfKYMn2Uy4pDKjZgaU/bKCTW+wRz5c=;
	b=ZbnyCIqZozzNi742kRuKe0KpB2uGVbdRq4Ys/lzYKlwwC4JejRKPsLm+vwsPiJi1X7AGyf
	uRM6mtacThu4hP1lrafG0bW6Dak96ExH3SltNLMiGCTNxjjTdGrmJLVpx/kB6OLM4j+PdL
	jKxnY+KOmKIMItPxpLzVHOTnQlBmq4s=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b="M20r5S/y";
	dmarc=pass (policy=none) header.from=narfation.org;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1778704609;
	b=J8SGs/ofMBxLQYU8UjAQzz7sieyhRzlo7kjb2WgKl+vdv69oTaSonAIU3JH4JS2MLTvAt4
	KZgFyT3qYLlAQ5/ptxqnPCq6Tp62BHAbaAJ3rKtfL9lNT/zkYnTudAEbiHTbWt2etK/2/U
	iYklJvmRqAkedW0b7dEmmjUj30VxhtY=
Received: by dvalin.narfation.org (Postfix) id 32FC7202A2;
	Wed, 13 May 2026 20:36:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1778704599;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gt2S5syziJdkxqfKYMn2Uy4pDKjZgaU/bKCTW+wRz5c=;
	b=M20r5S/yEB9cZycshywmcf1IMYjk1+mVQbWA8NaC4nxtALE2jPtTXlVRoeAgGo1XiDbeN3
	6J50MjdDbF5G9n1o+yym//EoV8Rm6nP+PA0xIeSIOWJoUbFrHz957nGDyLY3z5QBCLDd9K
	NDXIOd7ojJRN04jusrlbR8RAMuO62q0=
From: Sven Eckelmann <sven@narfation.org>
Date: Wed, 13 May 2026 22:36:25 +0200
Subject: [PATCH batadv v2 1/2] batman-adv: bla: fix report_work leak on
 backbone_gw purge
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260513-bla-cancel-work-v2-1-9c17d82d7e2d@narfation.org>
References: <20260513-bla-cancel-work-v2-0-9c17d82d7e2d@narfation.org>
In-Reply-To: <20260513-bla-cancel-work-v2-0-9c17d82d7e2d@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>,
 Simon Wunderlich <sw@simonwunderlich.de>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3768; i=sven@narfation.org;
 h=from:subject:message-id; bh=NirVm14j8UtMcZyAKcjYubuLNFLUABRgahHP0giwDF8=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFksDy5eemUnL7sqpvHs9qzkw+dZzLj6OCqCvF+J54TcO
 cj7j/t/RykLgxgXg6yYIsueK/nnN7O/lf887eNRmDmsTCBDGLg4BWAia1YyMly4tk5juQqPFIO7
 /eUljNLBStf3sp2tWpTRt+2JstTpwwEM/6zFRZf4+vfM5ZN+cflLaLxuUP3iZlYxa64QzX9u3i8
 rOAE=
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: 3JOFGZWVA7AVUAXEZMEJK74PSUTKFQWK
X-Message-ID-Hash: 3JOFGZWVA7AVUAXEZMEJK74PSUTKFQWK
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/3JOFGZWVA7AVUAXEZMEJK74PSUTKFQWK/>
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

