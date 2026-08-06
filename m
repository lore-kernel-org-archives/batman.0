Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 425E9C55ABF
	for <batman-adv@archiver.kernel.org>; Thu,  6 Aug 2026 09:48:22 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id D6A0984261
	for <batman-adv@archiver.kernel.org>; Thu, 06 Aug 2026 11:48:20 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1786009700;
 b=LCYQHKhWHYRI4hU+FDN1xPTS33rw6Sy8tvDcJ1jkPXfEDe0v2RBuM1Qq43Jr6bB217HlW
 895P7O/HdxwyhCFOYJeI/C3SZ0hORSpL/Aofve9S1gSZmwODDCuRxmdJqXnhAqVM1GmpzU9
 z/+8WEl5/ueh3B73U9SuGOb5O3Dkc28=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1786009700; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=J2sS4K16BkQksSoAnDDJrezYmrYDHH0BG4sohJU/J6U=;
 b=36+B/PX/qYK/zPcrQl9bOA9sqSXR/D6frPsYtxIPKBxxEqIo9fc116aZ+YulaUwn968PO
 oikpNcfZXemTwQG/Lzh2AMMt5GReFD0FLu4ADQFR4u2Psk+JpSsD3LfuGidGTUb+hmF+jxk
 wsBHrEzMb6ml7dDvHB//atf+jhqkCgI=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org
 [IPv6:2a00:17d8:100::8b1])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id E101E84222
	for <b.a.t.m.a.n@lists.open-mesh.org>; Thu, 06 Aug 2026 11:45:25 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1786009525;
	b=TqKtOKajlCV+tcN+9eW6c2B4l8k10RjhJ+trmhGVxh8G8LRx4/IdwKkjeDDu2VxYemAuHl
	2Hl8tmljoRPrjGvkgq5jD4KPhOpK3i3SofmrPo28ztjsDAzX1+R1xNm+icPuQZduIRzWiF
	fqOK72objkdSMrBbslK90XdH3TyLPZg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1786009525;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=J2sS4K16BkQksSoAnDDJrezYmrYDHH0BG4sohJU/J6U=;
	b=Plxl57Wvr/rAoEfgsuTB2uRxAt/1nuSlLL23C2iIDC3wSlc1khqUubNfrDt5beiaGRRhMH
	/0Z4f7g6Hy82Ai2ufZ9d6ON+dCSIPfNcs1zcawZpnmHJ2Yrd/oOyy3u11sCZqYLCVW3RdP
	xTTTG1RdAh/oWGL5cPJDXFPrCB6PDDA=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=OTL1pYG5;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id 8DD0920590;
	Thu, 06 Aug 2026 09:45:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1786009521;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=J2sS4K16BkQksSoAnDDJrezYmrYDHH0BG4sohJU/J6U=;
	b=OTL1pYG5bsWD1M94s7mCPkOlnoznumRzX1Pcuqt0gNw4cWQv/9FEeKzkwYC5XZ2pjvpGOh
	mk82h5lBg8WY+Wsaa5E59EKm75gumVSztIix/mhtfdEbm9IZNRYwK/LjyLgL++z8Yd20z/
	eUmPCitKJuzngnOFk8mY924u3rahjX8=
From: Sven Eckelmann <sven@narfation.org>
Date: Thu, 06 Aug 2026 11:44:19 +0200
Subject: [PATCH RFC batadv 06/12] batman-adv: tt: extract allocation of new
 global entries
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260806-tt-add-cleanup-v1-6-ffcad65bccc4@narfation.org>
References: <20260806-tt-add-cleanup-v1-0-ffcad65bccc4@narfation.org>
In-Reply-To: <20260806-tt-add-cleanup-v1-0-ffcad65bccc4@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3917; i=sven@narfation.org;
 h=from:subject:message-id; bh=GMTY8FfVyhnGoz89dfXpuY2KKqdKKdAAXIGUacxkGHY=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFkl4c1PYrZdONivvaP65NUnanozl7+2DJ95/av5vV+fF
 6eecGxb2VHKwiDGxSArpsiy50r++c3sb+U/T/t4FGYOKxPIEAYuTgGYSHQxI8O+bVPmKIqfPP6J
 0+lejVpWwZzvTVbM1ifEjWxnfJkda/ue4X8wx9UJKnv313jvbJs/4eMD6VcJ93k71yee9e2Rv96
 u1s8JAA==
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: F22RVS75K7QJVOFSUCFQRSQSPZYZB7MZ
X-Message-ID-Hash: F22RVS75K7QJVOFSUCFQRSQSPZYZB7MZ
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/F22RVS75K7QJVOFSUCFQRSQSPZYZB7MZ/>
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

