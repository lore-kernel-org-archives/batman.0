Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D197DC54E5D
	for <batman@archiver.kernel.org>; Tue, 12 Mar 2024 18:23:24 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 96B8C8199D
	for <batman@archiver.kernel.org>; Tue, 12 Mar 2024 19:23:22 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1710267802;
 b=QCYsqXfgg7Sq0lF86ERn5U16GYOHV8Qzc+ZzacQQZdKSPWCpyoiPtZ913FLW+Xr5k9C5o
 jCIAM5CiUhz9vbMnTborIYyGNoosSqPFCbh9E3Z3WCu+D6d8pc2oWpgs3xIZTT9jWlGiKfB
 Nz40E9lm1xfx/wya0/mPv/3gS8o6woA=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1710267802; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=o/jEyIn0N1qjBhCbDmOuWB1YSE6SbgxzJw3WAakd7MI=;
 b=f1LY26H86y2eyAqcV+TVLW2xRGVxwNdUOzeYLOKXoU3Ks93xIKIYu5rV3GCUGF9o2LvvU
 ysMfAjvkSFoZrlYxVF8QSH4iZ9B4Rgk7NK5H1taZJGGH2njQ7kH2oe2g3gE28pvOCxBEmNu
 YGg88/FToeLFo/VV6pgfN2xwbIuVgqw=
ARC-Authentication-Results: i=2; open-mesh.org; dkim=pass header.d=yandex.ru;
  arc=pass;
  dmarc=pass (Used From Domain Record) header.from=yandex.ru policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=yandex.ru; arc=pass;
 dmarc=pass (Used From Domain Record) header.from=yandex.ru policy.dmarc=none
Received: from forward101a.mail.yandex.net (forward101a.mail.yandex.net
 [178.154.239.84])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 15941804D1
	for <b.a.t.m.a.n@lists.open-mesh.org>; Tue, 12 Mar 2024 19:18:19 +0100 (CET)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1710267499;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:dkim-signature;
	bh=o/jEyIn0N1qjBhCbDmOuWB1YSE6SbgxzJw3WAakd7MI=;
	b=rBq0hHCfMsix7xJ6h7bjV5CDMrAdNPtETsfO0mdF/De2sNzd9TJg9YYsUE15M2EMa45a87
	8nq/KHqjXK3WVPLMl3CEsjSX4FLE2SbyD23V5LFzZus/e/nlSLg8vtxJuNpzGWrmy4zwUh
	r4BV70B90nJcwm9P+2xpTv9I4PZV5HY=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=yandex.ru header.s=mail header.b=blukgp81;
	spf=pass (diktynna.open-mesh.org: domain of dmantipov@yandex.ru designates
 178.154.239.84 as permitted sender) smtp.mailfrom=dmantipov@yandex.ru;
	dmarc=pass (policy=none) header.from=yandex.ru
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1710267499; a=rsa-sha256;
	cv=none;
	b=Xem95YDnI3GwB/iK5cztvIW3BXB4wA/DM6gyK80UjpURPIO592axUEfjETLOWblVl2j9hZ
	8NyoufrGc+4RL0DT/ZX/4P426rZUyHFCBkBqtuo/ft6n//2VMTWa+0y8KvfAQVUYA8X0Jo
	2XuWKh8dglQEEP2toeVMC/fOb2Hl//E=
Received: from mail-nwsmtp-smtp-production-main-67.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-production-main-67.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c15:2c95:0:640:f90:0])
	by forward101a.mail.yandex.net (Yandex) with ESMTPS id 45AFD608F2;
	Tue, 12 Mar 2024 21:18:18 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-67.vla.yp-c.yandex.net
 (smtp/Yandex) with ESMTPSA id GIrKTj0ZpGk0-rcqrrxig;
	Tue, 12 Mar 2024 21:18:17 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1710267497; bh=o/jEyIn0N1qjBhCbDmOuWB1YSE6SbgxzJw3WAakd7MI=;
	h=Message-ID:Date:Cc:Subject:To:From;
	b=blukgp81coHZyPihJK8DJqeo+lDXjwExPsAJgZVcsvswHmF42KT9ZlMpZ1rE4Wg/5
	 lNqgdiOcwhVQkDGWR4AGIRIWwvB2w6RxC3FTNZT9jg0jObQFGR4gimARlwz/c6oWig
	 2PqFq2ygGitxF133F64HYtUQt69tMs9lzszovlcQ=
From: Dmitry Antipov <dmantipov@yandex.ru>
To: Sven Eckelmann <sven@narfation.org>
Cc: Simon Wunderlich <sw@simonwunderlich.de>,
	Jakub Kicinski <kuba@kernel.org>,
	b.a.t.m.a.n@lists.open-mesh.org,
	netdev@vger.kernel.org,
	Dmitry Antipov <dmantipov@yandex.ru>
Subject: [PATCH] batman-adv: prefer kfree_rcu() over call_rcu() with free-only
 callbacks
Date: Tue, 12 Mar 2024 21:16:28 +0300
Message-ID: <20240312181628.2013091-1-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.44.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MailFrom: dmantipov@yandex.ru
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-0;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-1;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-2
Message-ID-Hash: XEZRCMXPV57SQEQ2P6PQJTSSL6CSBL5R
X-Message-ID-Hash: XEZRCMXPV57SQEQ2P6PQJTSSL6CSBL5R
X-Mailman-Approved-At: Tue, 12 Mar 2024 19:23:15 +0100
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/XEZRCMXPV57SQEQ2P6PQJTSSL6CSBL5R/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

Drop 'batadv_tt_local_entry_free_rcu()', 'batadv_tt_global_entry_free_rcu()'
and 'batadv_tt_orig_list_entry_free_rcu()' in favor of 'kfree_rcu()' in
'batadv_tt_local_entry_release()', 'batadv_tt_global_entry_release()' and
'batadv_tt_orig_list_entry_release()', respectively.

Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
 net/batman-adv/translation-table.c | 47 ++----------------------------
 1 file changed, 3 insertions(+), 44 deletions(-)

diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index b95c36765d04..0555cb611489 100644
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
-- 
2.44.0

