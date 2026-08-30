Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F106BC61DE1
	for <batman-adv@archiver.kernel.org>; Sun, 30 Aug 2026 15:29:34 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 67E7380454
	for <batman-adv@archiver.kernel.org>; Sun, 30 Aug 2026 17:29:33 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1788103773;
 b=ryfbuFUivdh7PDZ1Hsdt10KsBILoVXGtEs7/mjMtCsziWGJpWesjuAOzqDTUIQeOVBI42
 uoBp6T5mweZkdCrmNRwXkbGZzXUPwA5CqoQ6nF49YNKu/8vDh5KQnvdhgvk2yZ6z4dnftoL
 jjwX5W3x7V2A66F2Ncrb6glJTL3jJ/o=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1788103773; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=WoWLEOL/dpjnyphI/21omom80GjD8fjfFWHvBlCltUk=;
 b=cgzjrEDgcUa5Cs6q/dhTJVsUaTRhu87m9xlLHi/1E66u+7VgzMRF9/k9/Zyf1maDDpMSJ
 kXv/mn+RheUUAoEc/7SkQrv+e5wGYBRyMJ61Ll8+L4ox6HfqbSKCWhTovwLqoxOCq1wVQPc
 drT4Sz334CqC3jXLFbEh3j1ag1U2ZAk=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org
 [IPv6:2a00:17d8:100::8b1])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id BEE8080452
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sun, 30 Aug 2026 17:22:53 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1788103373;
	b=Tnw/M0ZudNxj5bHYEje5IgXCwrGzRUt2grCU3aRB4jo/AsUUK69pGkJKmFT33yiNPro3Si
	pfeU9Xe24t64005bbmffBmgS0AUTA76Ve1Lpo9IxUiG0eS6FC7Nhnlzrhzz9S+9bo7EVw6
	VZOblhBlFYyWiDNIGm0ef1zBG/YDgpQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1788103373;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=WoWLEOL/dpjnyphI/21omom80GjD8fjfFWHvBlCltUk=;
	b=dJgQvGhsDNsZiwfVZLaWldqDtbCQ2QZYC+JJUUbV1GpqUEi2sH+3alSQfTi83+4aXEfz3+
	X/akgy6JyM0JUTWvyTzGLvCdDQCxMomd8wC0MScil5NcfE1Tw3pkFhUqu3UD1/sMxcCfqV
	ybnwduE5RKk3k6ruuXWYxHL9hTcasdw=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=Boqd8tlU;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id 573DE20131;
	Sun, 30 Aug 2026 15:22:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1788103369;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WoWLEOL/dpjnyphI/21omom80GjD8fjfFWHvBlCltUk=;
	b=Boqd8tlUXigwrargvGdh54e9v9utg/sXipJk6/opSVsWOw47+RlYweAgPaIwq5/wJsEuEz
	/oCqZAQPRd/oguaKY8QrqjPRl2XKZCe31tT3+VmTL+AsJeXyhOHJfxg/vRVZFF1Ba36mLp
	ilrl4eMII8l3y4VwDAGgx0SLIznBKJg=
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 30 Aug 2026 17:21:51 +0200
Subject: [PATCH batadv v6 14/20] batman-adv: tt: extract allocation of new
 global entries
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260830-tt-fixes-v6-14-a56568a15041@narfation.org>
References: <20260830-tt-fixes-v6-0-a56568a15041@narfation.org>
In-Reply-To: <20260830-tt-fixes-v6-0-a56568a15041@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3917; i=sven@narfation.org;
 h=from:subject:message-id; bh=CgiqeKB9bPrlN7GAC00V0/rvh1cKrDxpLxdQhC+zGTQ=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFlTvNpfBis/OBNf+yDH8t/6I64zQ7wymm71zJ70LItFL
 HFS5ccZHaUsDGJcDLJiiix7ruSf38z+Vv7ztI9HYeawMoEMYeDiFICJvE9gZGifI+gpxKxvYR1q
 fdgmQ23eYdbOixmNSSqbM7Y0PvlxQ46R4cXUYimzvtTww3NvZ0zjWCq34+zlm8x2X008H37JPvm
 vhBUA
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: 5G76VE5SGW5VCFKHWND5ZEU5NFBSYA2U
X-Message-ID-Hash: 5G76VE5SGW5VCFKHWND5ZEU5NFBSYA2U
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/5G76VE5SGW5VCFKHWND5ZEU5NFBSYA2U/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

The code which allocates and initializes a brand new global TT entry makes
up a third of batadv_tt_global_add() and only needs the tt_addr, vid and
flags arguments. It is also the only part of the "new entry" branch which
does not deal with the global hash.

Move it to batadv_tt_global_create() and let it return the initialized
entry.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/translation-table.c | 76 +++++++++++++++++++++++++-------------
 1 file changed, 51 insertions(+), 25 deletions(-)

diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index cc4c4963..e81923c9 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -1885,6 +1885,56 @@ batadv_tt_global_orig_entry_add(struct batadv_tt_global_entry *tt_global,
 	spin_unlock_bh(&tt_global->list_lock);
 }
 
+/**
+ * batadv_tt_global_create() - allocate and initialize a global TT entry
+ * @tt_addr: the mac address of the non-mesh client
+ * @vid: VLAN identifier
+ * @flags: TT flags that have to be set for this non-mesh client
+ *
+ * The returned entry is not yet part of bat_priv->tt.global_hash and has an
+ * empty originator list.
+ *
+ * Return: the new entry with an initialized reference counter on success, NULL
+ * otherwise.
+ */
+static struct batadv_tt_global_entry *
+batadv_tt_global_create(const unsigned char *tt_addr, unsigned short vid,
+			u16 flags)
+{
+	struct batadv_tt_global_entry *tt_global_entry;
+	struct batadv_tt_common_entry *common;
+
+	tt_global_entry = kmem_cache_zalloc(batadv_tg_cache, GFP_ATOMIC);
+	if (!tt_global_entry)
+		return NULL;
+
+	common = &tt_global_entry->common;
+	ether_addr_copy(common->addr, tt_addr);
+	common->vid = vid;
+	spin_lock_init(&common->flags_lock);
+
+	if (!is_multicast_ether_addr(common->addr)) {
+		scoped_guard(spinlock_bh, &common->flags_lock)
+			common->flags = flags & (~BATADV_TT_SYNC_MASK);
+	}
+
+	tt_global_entry->roam_at = 0;
+	/* node must store current time in case of roaming. This is
+	 * needed to purge this entry out on timeout (if nobody claims
+	 * it)
+	 */
+	if (flags & BATADV_TT_CLIENT_ROAM)
+		tt_global_entry->roam_at = jiffies;
+	kref_init(&common->refcount);
+	common->added_at = jiffies;
+
+	INIT_HLIST_HEAD(&tt_global_entry->orig_list);
+	atomic_set(&tt_global_entry->orig_list_count, 0);
+	spin_lock_init(&tt_global_entry->list_lock);
+
+	return tt_global_entry;
+}
+
 /**
  * batadv_tt_global_add() - add a new TT global entry or update an existing one
  * @bat_priv: the bat priv with all the mesh interface information
@@ -1936,35 +1986,11 @@ static bool batadv_tt_global_add(struct batadv_priv *bat_priv,
 	}
 
 	if (!tt_global_entry) {
-		tt_global_entry = kmem_cache_zalloc(batadv_tg_cache,
-						    GFP_ATOMIC);
+		tt_global_entry = batadv_tt_global_create(tt_addr, vid, flags);
 		if (!tt_global_entry)
 			goto out;
 
 		common = &tt_global_entry->common;
-		ether_addr_copy(common->addr, tt_addr);
-		common->vid = vid;
-		spin_lock_init(&common->flags_lock);
-
-		if (!is_multicast_ether_addr(common->addr)) {
-			spin_lock_bh(&common->flags_lock);
-			common->flags = flags & (~BATADV_TT_SYNC_MASK);
-			spin_unlock_bh(&common->flags_lock);
-		}
-
-		tt_global_entry->roam_at = 0;
-		/* node must store current time in case of roaming. This is
-		 * needed to purge this entry out on timeout (if nobody claims
-		 * it)
-		 */
-		if (flags & BATADV_TT_CLIENT_ROAM)
-			tt_global_entry->roam_at = jiffies;
-		kref_init(&common->refcount);
-		common->added_at = jiffies;
-
-		INIT_HLIST_HEAD(&tt_global_entry->orig_list);
-		atomic_set(&tt_global_entry->orig_list_count, 0);
-		spin_lock_init(&tt_global_entry->list_lock);
 
 		kref_get(&common->refcount);
 		hash_added = batadv_hash_add(bat_priv->tt.global_hash,

-- 
2.47.3

