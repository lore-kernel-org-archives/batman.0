Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9185CD4F3C
	for <batman-adv@archiver.kernel.org>; Wed, 20 May 2026 12:02:39 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 3B62183F97
	for <batman-adv@archiver.kernel.org>; Wed, 20 May 2026 14:02:38 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1779278558;
 b=i9l/2qVkRcWxbug6EoD+uYcWvof/AiVCk1NVP/q5ZESTvZj/j7NCQjRkXISaKVmxu4rA4
 aev9sBmnvFLeZGMu3Rw62AHACkdGAAdVBpYfIrmieEeoMqeBDGaeOhw+8xfATO9VFlePtCy
 /MR/9wj6+h3x+OAuZ2/islWugNIi/2A=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1779278558; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=A7AMNlxNCfrXS6C83QuAzwpr6kuDrvcNxT639h1EKgo=;
 b=FVhdNQACPKZi45qDSn1CDGS3ChGsU4sM//WjDVjQHSBCbnt2sLlOsLY9vrhlEqbtxxDHZ
 XBemVNXP2WV5ykOipU+x3KzJwwryKCd2HVJtkbX/ln1lAhYeiyFyG3idfkGOdCJtqq5K48a
 TYYdau6m3s+rYfvkEAYgq2PqGAg6FKk=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass header.from=simonwunderlich.de policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=simonwunderlich.de policy.dmarc=none
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de
 [IPv6:2a01:4f8:c17:e8c0::1])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 0698A823C1
	for <b.a.t.m.a.n@lists.open-mesh.org>; Wed, 20 May 2026 13:54:45 +0200 (CEST)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1779278085;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=A7AMNlxNCfrXS6C83QuAzwpr6kuDrvcNxT639h1EKgo=;
	b=FByW3jHLM0ba5tQiIMOIjkwctjo7EfNRkGqqvpZVoRyGgycGO9hgN2Waafw8d04l8BDZTc
	b+3QCWxHJrvqSZYoSkF3NK32tZp+r+ppJUe7gjQhNHAGCGCGp/H4HP72xXvb7NND4/klmr
	PjYGa/dfY/lPkhJTBV2tb76ZrI4XB5M=
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1779278085;
	b=YvT06wdt3iCkl8lfWt4UptJMIhjlGlDKNySDUGCheNViT5X75rLJdaeWmG8m9PP50ZFk9/
	tX1uGpfdHV1e3zE6T1e8cjiog7faqYn0AsEx5BD4N0pLayZtX7GBZK/8lIvpx4kb3vKg+9
	/ro53+tmibfqv7M0crt+Bog7x8O2X4s=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=simonwunderlich.de header.s=09092022 header.b="YZYOXHG/";
	spf=pass (diktynna.open-mesh.org: domain of sw@simonwunderlich.de designates
 2a01:4f8:c17:e8c0::1 as permitted sender)
 smtp.mailfrom=sw@simonwunderlich.de;
	dmarc=pass (policy=none) header.from=simonwunderlich.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1779278084;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=A7AMNlxNCfrXS6C83QuAzwpr6kuDrvcNxT639h1EKgo=;
	b=YZYOXHG/MpFDtfynUPUNM2YxlXv0TDxTxJ3+xZq6y4R8MoXQe5SSSJYlv+6ib85Nz9z75f
	LQW1VPC+8LYEu+i5I7oC3kLOxI19HLZFRvWmIPICRif243Dmny3o6tCcb9ucJkDUa4UdkI
	HQecpprH3Fj8VMrIZbFW12iIoj9Sl1oWxQEQgLzkLeG4JfUWmirUU18JnINsHg7LUBXarp
	2g6EUHLE638J1t9gu0hcmQHyBfXN6yiq5sLqkdxu2O1mWNJNiaA7k71KpEUJoqmjZYmd6k
	atOIWqOMg85L3ry48VQTQ4uA6ICA3CBPN5HF41PllWDSTkSlv6NQan+e1cmLuw==
From: Simon Wunderlich <sw@simonwunderlich.de>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	b.a.t.m.a.n@lists.open-mesh.org,
	Sven Eckelmann <sven@narfation.org>,
	stable@kernel.org,
	Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH net 09/11] batman-adv: bla: fix report_work leak on
 backbone_gw purge
Date: Wed, 20 May 2026 13:54:20 +0200
Message-ID: <20260520115422.53552-10-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260520115422.53552-1-sw@simonwunderlich.de>
References: <20260520115422.53552-1-sw@simonwunderlich.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: HJWODFFH5IL2OCVLTY46EXWNPVEKBMOM
X-Message-ID-Hash: HJWODFFH5IL2OCVLTY46EXWNPVEKBMOM
X-MailFrom: sw@simonwunderlich.de
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/HJWODFFH5IL2OCVLTY46EXWNPVEKBMOM/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

From: Sven Eckelmann <sven@narfation.org>

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

Cc: stable@kernel.org
Fixes: 23721387c409 ("batman-adv: add basic bridge loop avoidance code")
Reviewed-by: Simon Wunderlich <sw@simonwunderlich.de>
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/bridge_loop_avoidance.c | 54 +++++++++++++++++---------
 1 file changed, 35 insertions(+), 19 deletions(-)

diff --git a/net/batman-adv/bridge_loop_avoidance.c b/net/batman-adv/bridge_loop_avoidance.c
index cec11f1251d66..df1dfdf4a1a12 100644
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

