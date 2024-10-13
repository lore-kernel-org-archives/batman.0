Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 974BACF259D
	for <batman@archiver.kernel.org>; Mon, 14 Oct 2024 06:56:59 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id B02C483CA0
	for <batman@archiver.kernel.org>; Mon, 14 Oct 2024 08:56:57 +0200 (CEST)
ARC-Seal: i=2; cv=fail; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1728889017;
 b=Bbm5A43SPVCS06i74x2MMw6dUd6RCjwwlstAImRXQtqdX/ktg97fuT+xsRdqPBG1yvK6W
 OR3UhIYFXlD80xUZPZt8xR3DRl/YsMbtDQp53bc0aBdFRuV1rTWP9/8p2g8WXgcoOo3WPtr
 Bu2dU5B8Ryd9jWOtp1+H4jbaXIkr+uE=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1728889017; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=CLSnrUkA/mLqsKxxUG6thrG2qHqY5krv2SYxozk1k4c=;
 b=Iaa2DaBB7WH5gYVadgTt3wqkVO9B8pBOFLtZdKhq+5oRWBVi+XS2OeEe8ER6IttA9LWL3
 4gtZpNllCRY03bTRwJzufbkjThO5yh5arYv4CdLdqiiOboNVW3/yTaZXaJHxLs6PtZzwXdb
 SY4ZUPKSaJDHafcwk0DJ5+3/vE4kWWk=
ARC-Authentication-Results: i=2; open-mesh.org; dkim=pass header.d=inria.fr;
  arc=fail (ARC-Seal[1] did not validate);
  dmarc=pass (Used From Domain Record) header.from=inria.fr policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=inria.fr;
 arc=fail (ARC-Seal[1] did not validate);
 dmarc=pass (Used From Domain Record) header.from=inria.fr policy.dmarc=none
Received: from mail3-relais-sop.national.inria.fr
 (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 1A32282509
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sun, 13 Oct 2024 22:18:00 +0200 (CEST)
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1728850680; a=rsa-sha256;
	cv=none;
	b=2Bn5oFXcl0Sta+31ByC/5AN8QmASRk9lfUelhVR2xitq4o/hDfkeA4rPqL4gG+Kh1TX1Mt
	X+wutFze4eG+iiOm/PQuiMpxadpeArfD1dvUTP65/e3RYLaN84O4nmMi9ZVS2bbginch8f
	/fxMEXZBh37ZHiymurDNuSFhR/vxXIE=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=inria.fr header.s=dc header.b=kXXFX4IR;
	dmarc=pass (policy=none) header.from=inria.fr;
	spf=pass (diktynna.open-mesh.org: domain of Julia.Lawall@inria.fr designates
 192.134.164.104 as permitted sender) smtp.mailfrom=Julia.Lawall@inria.fr
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1728850680;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=CLSnrUkA/mLqsKxxUG6thrG2qHqY5krv2SYxozk1k4c=;
	b=JBg0afgg3kr5f38f9XwhpU+9VyVksC/U6z3iq4kWoNStF60krJjL4lnSSZQglaPASlTH+P
	uptlL5gId7YTAa+AKKpwWjbKY/PU9A8L+yamqZ2hHtlmQ8+Wod9HqUMBfQpQN+PO0AQweU
	dvlftMtu2iPEqxh7lYDp1DrtnmRk2U0=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=CLSnrUkA/mLqsKxxUG6thrG2qHqY5krv2SYxozk1k4c=;
  b=kXXFX4IRCytaJ+MTepjAKZ93wQGatywXpWWN05HVq5drkzKt5IqJD6D3
   8hhgyv0Kx6yGhOOx97YtBcrkuWywMK/wQ0Mhv6XZpex5uHrP0BW1QQ7eX
   1HhVF0IULT8QHAzGQ+VlKN2wpf88tru1deXGO5PGqNfBvoeccjzxWD4xg
   Y=;
X-IronPort-AV: E=Sophos;i="6.11,201,1725314400";
   d="scan'208";a="98968281"
Received: from i80.paris.inria.fr (HELO i80.paris.inria.fr.) ([128.93.90.48])
  by mail3-relais-sop.national.inria.fr with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2024 22:17:59 +0200
From: Julia Lawall <Julia.Lawall@inria.fr>
To: Marek Lindner <mareklindner@neomailbox.ch>
Cc: kernel-janitors@vger.kernel.org,
	vbabka@suse.cz,
	paulmck@kernel.org,
	Simon Wunderlich <sw@simonwunderlich.de>,
	Antonio Quartulli <a@unstable.cc>,
	Sven Eckelmann <sven@narfation.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	b.a.t.m.a.n@lists.open-mesh.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 06/17] batman-adv: replace call_rcu by kfree_rcu for simple
 kmem_cache_free callback
Date: Sun, 13 Oct 2024 22:16:53 +0200
Message-Id: <20241013201704.49576-7-Julia.Lawall@inria.fr>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20241013201704.49576-1-Julia.Lawall@inria.fr>
References: <20241013201704.49576-1-Julia.Lawall@inria.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MailFrom: Julia.Lawall@inria.fr
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-0;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-1;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-2
Message-ID-Hash: GEP7IEFIC4Y4O5JQMQPVAEDEZDAY3ESH
X-Message-ID-Hash: GEP7IEFIC4Y4O5JQMQPVAEDEZDAY3ESH
X-Mailman-Approved-At: Mon, 14 Oct 2024 08:56:06 +0200
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/GEP7IEFIC4Y4O5JQMQPVAEDEZDAY3ESH/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

Since SLOB was removed and since
commit 6c6c47b063b5 ("mm, slab: call kvfree_rcu_barrier() from kmem_cache_destroy()"),
it is not necessary to use call_rcu when the callback only performs
kmem_cache_free. Use kfree_rcu() directly.

The changes were made using Coccinelle.

Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>

---
 net/batman-adv/translation-table.c |   47 ++-----------------------------------
 1 file changed, 3 insertions(+), 44 deletions(-)

diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index 2243cec18ecc..b21ff3c36b07 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -208,20 +208,6 @@ batadv_tt_global_hash_find(struct batadv_priv *bat_priv, const u8 *addr,
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
@@ -236,7 +222,7 @@ static void batadv_tt_local_entry_release(struct kref *ref)
 
 	batadv_softif_vlan_put(tt_local_entry->vlan);
 
-	call_rcu(&tt_local_entry->common.rcu, batadv_tt_local_entry_free_rcu);
+	kfree_rcu(tt_local_entry, common.rcu);
 }
 
 /**
@@ -254,20 +240,6 @@ batadv_tt_local_entry_put(struct batadv_tt_local_entry *tt_local_entry)
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
@@ -282,7 +254,7 @@ void batadv_tt_global_entry_release(struct kref *ref)
 
 	batadv_tt_global_del_orig_list(tt_global_entry);
 
-	call_rcu(&tt_global_entry->common.rcu, batadv_tt_global_entry_free_rcu);
+	kfree_rcu(tt_global_entry, common.rcu);
 }
 
 /**
@@ -407,19 +379,6 @@ static void batadv_tt_global_size_dec(struct batadv_orig_node *orig_node,
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
@@ -433,7 +392,7 @@ static void batadv_tt_orig_list_entry_release(struct kref *ref)
 				  refcount);
 
 	batadv_orig_node_put(orig_entry->orig_node);
-	call_rcu(&orig_entry->rcu, batadv_tt_orig_list_entry_free_rcu);
+	kfree_rcu(orig_entry, rcu);
 }
 
 /**

