Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0B88C61DBE
	for <batman-adv@archiver.kernel.org>; Sat, 29 Aug 2026 06:26:27 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 55FBD814AF
	for <batman-adv@archiver.kernel.org>; Sat, 29 Aug 2026 08:26:26 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1787984786;
 b=Oj6FLZ6aQDsXyT9IK60NehjRS5XYCsFV1GX5Ajw/dk7XTYFzvu15UmI1dcBh/4le4XOtj
 rQUCIVzDz+o19vtVsahwdy2kPkZmZm3j44895W6odJJPkRg9iIaYUYBLdoszISWzN3FIVZY
 TkEhrhosPzjRXiDTMyGnsjPWaQxyjNo=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1787984786; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=J2sS4K16BkQksSoAnDDJrezYmrYDHH0BG4sohJU/J6U=;
 b=ANPnXBDXwcsy7JVmKrQdGQFa+BSqdUwON3mLclS1KfxwpibPKQUiODKyGfeYd7eMOBRyY
 BHJ08YgyFEN7H19wUVEXdwdX85+tJzHV5kS5RdeLpGQeVFsh9nJSI7PmXttzf+J/BYUuoq5
 Un8q2IuFMvnis24xM50Orh61bM+ABhw=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org
 [IPv6:2a00:17d8:100::8b1])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id E4659842E6
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sat, 29 Aug 2026 08:21:46 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1787984506;
	b=bNwwRQpYgYn+6+4yIneko2kbz4epx/xCYIAz/GGH+PtRfkJuTiXPEq3KbVYw7RfnSS+2gx
	k2uXmiI4GcKJHhocSkvOoPDO1Ay0y2bQNRxvskcdJtBR+MJBljsL9A3N7pbEIkAotaoWOz
	L6vGVf6ByfYISp+mn+2vzl/Vx/rKADQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1787984506;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=J2sS4K16BkQksSoAnDDJrezYmrYDHH0BG4sohJU/J6U=;
	b=nMs7cLC+XIVwpGz5E3RtbAlKCVkPlwhSNlVASY55bCRZypOjWBH/1+H7N9IRV/V7O3MB2X
	I+TE0ZMrmXZH5+1pOew/v3kGersB7q/tBaVtthP8u0BxuQsMgpxnb7r+ia7XHkLJA90Qq2
	EQ4RQElRp8jDLlKG74l/SXOREmQx4EA=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=aurrZV6U;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id 748C3200E4;
	Sat, 29 Aug 2026 06:21:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1787984502;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=J2sS4K16BkQksSoAnDDJrezYmrYDHH0BG4sohJU/J6U=;
	b=aurrZV6UW9PUG+/UwaxJKxHlzv3m6TK2hBQwl7y2XlU3mrmn7ux7hkSEdlyG/Q6LfOmG+W
	spJC9dkyH/lpXmPNy7u8x1GdegBC/53YC5ee7Y3yICyc7Ea8u9vTeZ4n7TEbBwREileQmo
	5I+wWA5fQdwFFt7IYWeAo1nj6bIX2rs=
From: Sven Eckelmann <sven@narfation.org>
Date: Sat, 29 Aug 2026 08:18:25 +0200
Subject: [PATCH batadv v5 14/20] batman-adv: tt: extract allocation of new
 global entries
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260829-tt-fixes-v5-14-88fce8fd683d@narfation.org>
References: <20260829-tt-fixes-v5-0-88fce8fd683d@narfation.org>
In-Reply-To: <20260829-tt-fixes-v5-0-88fce8fd683d@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3917; i=sven@narfation.org;
 h=from:subject:message-id; bh=GMTY8FfVyhnGoz89dfXpuY2KKqdKKdAAXIGUacxkGHY=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFmTKtcWZa/WeTx5c9OMkiN/p5+vP8Cjmvl9Bncve0jBi
 inf51R4dZSyMIhxMciKKbLsuZJ/fjP7W/nP0z4ehZnDygQyhIGLUwAm0nuDkWG14eqmJyF+By7v
 dq/u6D97Tydh40GBbz7vX87vKNNaNt+akeHq7/DkM3qiTCs07x9d57LoTMhMnj/Kyj8Uvis+nj7
 DxIMfAA==
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: SA2WBDJPVNS5CA7ZZARBNKDUXFLFYGAG
X-Message-ID-Hash: SA2WBDJPVNS5CA7ZZARBNKDUXFLFYGAG
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/SA2WBDJPVNS5CA7ZZARBNKDUXFLFYGAG/>
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
index ba2a5188..d9055d07 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -1884,6 +1884,56 @@ batadv_tt_global_orig_entry_add(struct batadv_tt_global_entry *tt_global,
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
@@ -1935,35 +1985,11 @@ static bool batadv_tt_global_add(struct batadv_priv *bat_priv,
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

