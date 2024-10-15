Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F16BCFC271
	for <batman@archiver.kernel.org>; Tue, 15 Oct 2024 07:43:00 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id BBAA383AE7
	for <batman@archiver.kernel.org>; Tue, 15 Oct 2024 09:42:58 +0200 (CEST)
ARC-Seal: i=2; cv=fail; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1728978178;
 b=iApoOyYbIBQZA01wjnEPRLIXbWrJgBS0+XH20S0xb7MWWwVqpsDbuqpFsFaBfLc6sORn6
 Qj8467PYcFe9g5vJANKqAxa1CnuUAKvoEjhMPqv+fBPI+FvJo6uBBWBKSqlay1AnhbufcNv
 IltekN6JsuJB+q2O769AiFY9+i5DuuY=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1728978178; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=8i0zeFvOhWQBIg9YF1oVE+KxFX2fepdvEeBZtHuYgaY=;
 b=gZi8DOOyqQs0iTSgYZ3Nk4Jx5waTdcjqyzJV0oDCYaDG8wN5cGdYOnSlnppMHZ94TAdjf
 Oq9ADjs1RkRJ/zJpXhtOzrPQEh7xm2qD5SEsZ41EvHw3/DlYN8lT07dU9khZT6QUTzAqiiW
 /+RlOX5oX+dgYmTNqi+D2hr0kohCX5A=
ARC-Authentication-Results: i=2; open-mesh.org; dkim=fail;
  arc=fail (ARC-Seal[1] did not validate);
  dmarc=fail (Used From Domain Record) header.from=simonwunderlich.de
 policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=fail;
 arc=fail (ARC-Seal[1] did not validate);
 dmarc=fail (Used From Domain Record) header.from=simonwunderlich.de
 policy.dmarc=none
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 16B9B83B8D
	for <b.a.t.m.a.n@lists.open-mesh.org>; Tue, 15 Oct 2024 09:39:52 +0200 (CEST)
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1728977992; a=rsa-sha256;
	cv=none;
	b=cTms/ZF48y+LzQV0alUV0SGVmiNA/BHsYn7fjBLzTpN20B25lgAJOTtRkDcDMF9ke9QNMS
	51lafBoRJnV/PPTAqYpDRCNaBxzUlq+25tVzCElLcsNQE2Z4a/xypdGtiicu7Zch4pzZRT
	zSCw7NmX0v+POYReviu4YC/ZFgLQ6hw=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=none;
	dmarc=pass (policy=none) header.from=simonwunderlich.de;
	spf=pass (diktynna.open-mesh.org: domain of sw@simonwunderlich.de designates
 23.88.38.48 as permitted sender) smtp.mailfrom=sw@simonwunderlich.de
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1728977992;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8i0zeFvOhWQBIg9YF1oVE+KxFX2fepdvEeBZtHuYgaY=;
	b=jsMix2TskX10WWcGhYNfAhzdMwO9DJr9Co/kGeiGMgzLkkI/6u1t1vRCUoiPSvdqqDAYWr
	RGnqI7tT1TjNximMBS2D6iZTdIFmXvH3xdRtwMJDnX2S4fYcw8iImFjm9pk/p2vFoxJ1xs
	L57gH5LxNpv9zdEJzoTSgmom2kADLzo=
Received: from kero.packetmixer.de (p5480b09e.dip0.t-ipconnect.de
 [84.128.176.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits)
 server-digest SHA256)
	(No client certificate requested)
	by mail.simonwunderlich.de (Postfix) with ESMTPSA id E13F7FAA33;
	Tue, 15 Oct 2024 09:39:50 +0200 (CEST)
From: Simon Wunderlich <sw@simonwunderlich.de>
To: kuba@kernel.org,
	davem@davemloft.net
Cc: netdev@vger.kernel.org,
	b.a.t.m.a.n@lists.open-mesh.org,
	Julia Lawall <Julia.Lawall@inria.fr>,
	Sven Eckelmann <sven@narfation.org>,
	Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH 4/4] batman-adv: replace call_rcu by kfree_rcu for simple
 kmem_cache_free callback
Date: Tue, 15 Oct 2024 09:39:46 +0200
Message-Id: <20241015073946.46613-5-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241015073946.46613-1-sw@simonwunderlich.de>
References: <20241015073946.46613-1-sw@simonwunderlich.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: CSTEUV5M7SQCQ6I26EGZTLEA6PQRMXRL
X-Message-ID-Hash: CSTEUV5M7SQCQ6I26EGZTLEA6PQRMXRL
X-MailFrom: sw@simonwunderlich.de
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-0;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-1;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-2; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/CSTEUV5M7SQCQ6I26EGZTLEA6PQRMXRL/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

From: Julia Lawall <Julia.Lawall@inria.fr>

Since SLOB was removed and since
commit 6c6c47b063b5 ("mm, slab: call kvfree_rcu_barrier() from kmem_cache_destroy()"),
it is not necessary to use call_rcu when the callback only performs
kmem_cache_free. Use kfree_rcu() directly.

The changes were made using Coccinelle.

Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/translation-table.c | 47 ++----------------------------
 1 file changed, 3 insertions(+), 44 deletions(-)

diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index 6815d1262feb..b44c382226a1 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -209,20 +209,6 @@ batadv_tt_global_hash_find(struct batadv_priv *bat_priv, const u8 *addr,
 	return tt_global_entry;
 }
 
-/**
- * batadv_tt_local_entry_free_rcu() - free the tt_local_entry
- * @rcu: rcu pointer of the tt_local_entry
- */
-static void batadv_tt_local_entry_free_rcu(struct rcu_head *rcu)
-{
-	struct batadv_tt_local_entry *tt_local_entry;
-
-	tt_local_entry = container_of(rcu, struct batadv_tt_local_entry,
-				      common.rcu);
-
-	kmem_cache_free(batadv_tl_cache, tt_local_entry);
-}
-
 /**
  * batadv_tt_local_entry_release() - release tt_local_entry from lists and queue
  *  for free after rcu grace period
@@ -237,7 +223,7 @@ static void batadv_tt_local_entry_release(struct kref *ref)
 
 	batadv_softif_vlan_put(tt_local_entry->vlan);
 
-	call_rcu(&tt_local_entry->common.rcu, batadv_tt_local_entry_free_rcu);
+	kfree_rcu(tt_local_entry, common.rcu);
 }
 
 /**
@@ -255,20 +241,6 @@ batadv_tt_local_entry_put(struct batadv_tt_local_entry *tt_local_entry)
 		 batadv_tt_local_entry_release);
 }
 
-/**
- * batadv_tt_global_entry_free_rcu() - free the tt_global_entry
- * @rcu: rcu pointer of the tt_global_entry
- */
-static void batadv_tt_global_entry_free_rcu(struct rcu_head *rcu)
-{
-	struct batadv_tt_global_entry *tt_global_entry;
-
-	tt_global_entry = container_of(rcu, struct batadv_tt_global_entry,
-				       common.rcu);
-
-	kmem_cache_free(batadv_tg_cache, tt_global_entry);
-}
-
 /**
  * batadv_tt_global_entry_release() - release tt_global_entry from lists and
  *  queue for free after rcu grace period
@@ -283,7 +255,7 @@ void batadv_tt_global_entry_release(struct kref *ref)
 
 	batadv_tt_global_del_orig_list(tt_global_entry);
 
-	call_rcu(&tt_global_entry->common.rcu, batadv_tt_global_entry_free_rcu);
+	kfree_rcu(tt_global_entry, common.rcu);
 }
 
 /**
@@ -408,19 +380,6 @@ static void batadv_tt_global_size_dec(struct batadv_orig_node *orig_node,
 	batadv_tt_global_size_mod(orig_node, vid, -1);
 }
 
-/**
- * batadv_tt_orig_list_entry_free_rcu() - free the orig_entry
- * @rcu: rcu pointer of the orig_entry
- */
-static void batadv_tt_orig_list_entry_free_rcu(struct rcu_head *rcu)
-{
-	struct batadv_tt_orig_list_entry *orig_entry;
-
-	orig_entry = container_of(rcu, struct batadv_tt_orig_list_entry, rcu);
-
-	kmem_cache_free(batadv_tt_orig_cache, orig_entry);
-}
-
 /**
  * batadv_tt_orig_list_entry_release() - release tt orig entry from lists and
  *  queue for free after rcu grace period
@@ -434,7 +393,7 @@ static void batadv_tt_orig_list_entry_release(struct kref *ref)
 				  refcount);
 
 	batadv_orig_node_put(orig_entry->orig_node);
-	call_rcu(&orig_entry->rcu, batadv_tt_orig_list_entry_free_rcu);
+	kfree_rcu(orig_entry, rcu);
 }
 
 /**
-- 
2.39.5

