Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C3C7CA5FFC
	for <batman@archiver.kernel.org>; Tue,  6 Oct 2026 16:50:15 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id BD351842E0
	for <batman@archiver.kernel.org>; Tue, 06 Oct 2026 18:50:13 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1791305413;
 b=JSppcrgQ5yqD6qDr0cagnmeEi95vtT0v2gDAMk739oSWm0La4t5NnBOczMgXScMHXxElP
 KYrFF9uFCFFPGi7XUqaHADsVb/Z+Ymd5+J4fDacylJ+Zu1UAZWavl0WqzkaSAY9I5qGlrQP
 lfRe8wD1cmZqkitzQf3b66otC6ZLO7w=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1791305413; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=XuiBm4UXKADyrAZEBf0Ue5AgzqJpVM9XQgmTC96McUc=;
 b=i66iRogP+730tOmpD7x6zqEM/1Ubu7FV8JjF/rEP9AXbt6cSq9x6MiJE3Fe6Zrft8drEy
 uN7HA1l2Xm04y2fDibr2Y6zCz3sglXhXHBkY0RUVnSp9NpISmVMzU3eJ1e+LtBNW/YeNQyN
 dovggLpj4hvCfKCPSMC0tR6O3ct1EuQ=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org
 [IPv6:2a00:17d8:100::8b1])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 28DD183BE2
	for <b.a.t.m.a.n@lists.open-mesh.org>; Tue, 06 Oct 2026 18:48:37 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1791305317;
	b=d6fTgSl/CJgdkYyldjht484ejf9YHNh8i31MF++XL6efdF0rDzkyaVrFkQccuCZd5cTtc1
	YCFhyNb2VlGormaEOxaIUfIBLUW7qsBCMbjfeTvtmrY7WzSPjUM3dbAhgkaLisbfuTEWcs
	eBT6nfY5kF3wobAe0evbyxM3t2GQb2w=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1791305317;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=XuiBm4UXKADyrAZEBf0Ue5AgzqJpVM9XQgmTC96McUc=;
	b=B4GuIArmYNzrUxIbGdw3hws5p7DJ5dty4WCK82+LWCk4yGXFi1Yu3GBh+jntVncDJaXw5u
	cTnmetClvsKvTrp5tm2nEAoJKIKmjAQPuYmLv0dHZP46M0r9Zwx4BUMVXxxJ84taf4JKjp
	UbdBPrmJIrgnFu8fpuFOpkpUUB68e9w=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=wHt2zQhc;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id 796241FE24;
	Tue, 06 Oct 2026 16:48:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1791305316;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XuiBm4UXKADyrAZEBf0Ue5AgzqJpVM9XQgmTC96McUc=;
	b=wHt2zQhcx/rvF+kfHvImVU6My04RsT5qGbYDi1b3BFREZ9PWS0PKMCg77nnmvWUfCzflJj
	smb0juWvsTeS4AeIGhl7H22JQ7b21+AS92q8Gow5p7jVycrwFOFzPZtJBYEnZXhJchK5eJ
	O9bKlLm+Qen6OQzh+eZ2LRU8ddt3WXs=
From: Sven Eckelmann <sven@narfation.org>
Date: Tue, 06 Oct 2026 18:47:06 +0200
Subject: [PATCH batadv v3 4/9] batman-adv: tt: annotate last_seen with
 READ/WRITE_ONCE
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261006-dat-last_update-once-v3-4-316aefdd5f5f@narfation.org>
References: <20261006-dat-last_update-once-v3-0-316aefdd5f5f@narfation.org>
In-Reply-To: <20261006-dat-last_update-once-v3-0-316aefdd5f5f@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2998; i=sven@narfation.org;
 h=from:subject:message-id; bh=CEd2yQjxIXqpkHondk+B5lDrnbZN9vyhYPDo3VIiGv0=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFlH1bgc3ubMm7j5/5TASal/5EUCMn+zvph3JCfvIrdg0
 9XQB/VcHaUsDGJcDLJiiix7ruSf38z+Vv7ztI9HYeawMoEMYeDiFICJfH3M8L84UexCSO2EdrUT
 B45P3st2zd332toHqumay2988bziUBLB8JuF8U4lJ3O8XFXf5EMzxMzmCM2cHHpp7uGG8ydOHef
 wP8MEAA==
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: GVH7TD5G5EOZ7B2N3ZFBZEN7MF7URTJC
X-Message-ID-Hash: GVH7TD5G5EOZ7B2N3ZFBZEN7MF7URTJC
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/GVH7TD5G5EOZ7B2N3ZFBZEN7MF7URTJC/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

The last_seen field for batadv_tt_local_entry tracks the jiffies value of
the most recent activity and is used to detect timeouts. These accesses are
not consistently protected by a lock, so READ_ONCE/WRITE_ONCE must be used
to prevent data races caused by compiler optimizations.

To avoid an underflow due to an non-strict order read of jffies vs
last_seen, use jiffies_delta_to_msecs instead of jiffies_to_msecs to
evaluate the delta.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/translation-table.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index e46040fd..11d9fbdd 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -940,7 +940,7 @@ static bool batadv_tt_local_add_existing(struct batadv_priv *bat_priv,
 {
 	struct batadv_tt_common_entry *common = &tt_local->common;
 
-	tt_local->last_seen = jiffies;
+	WRITE_ONCE(tt_local->last_seen, jiffies);
 
 	scoped_guard(spinlock_bh, &common->flags_lock) {
 		if (common->flags & BATADV_TT_CLIENT_PENDING) {
@@ -995,6 +995,7 @@ batadv_tt_local_create(struct net_device *mesh_iface, const u8 *addr,
 	struct batadv_priv *bat_priv = netdev_priv(mesh_iface);
 	struct batadv_tt_local_entry *tt_local;
 	struct batadv_meshif_vlan *vlan;
+	unsigned long last_seen;
 
 	if (!batadv_tt_local_reserve_entry(bat_priv, addr))
 		return NULL;
@@ -1024,8 +1025,9 @@ batadv_tt_local_create(struct net_device *mesh_iface, const u8 *addr,
 	ether_addr_copy(tt_local->common.addr, addr);
 	tt_local->common.vid = vid;
 	kref_init(&tt_local->common.refcount);
-	tt_local->last_seen = jiffies;
-	tt_local->common.added_at = tt_local->last_seen;
+	last_seen = jiffies;
+	WRITE_ONCE(tt_local->last_seen, last_seen);
+	tt_local->common.added_at = last_seen;
 	tt_local->vlan = vlan;
 	spin_lock_init(&tt_local->common.flags_lock);
 
@@ -1480,12 +1482,14 @@ batadv_tt_local_dump_entry(struct sk_buff *msg, u32 portid,
 	struct batadv_tt_local_entry *local;
 	struct batadv_meshif_vlan *vlan;
 	unsigned int last_seen_msecs;
+	unsigned long last_seen;
 	void *hdr;
 	u16 flags;
 	u32 crc;
 
 	local = container_of(common, struct batadv_tt_local_entry, common);
-	last_seen_msecs = jiffies_to_msecs(jiffies - local->last_seen);
+	last_seen = READ_ONCE(local->last_seen);
+	last_seen_msecs = jiffies_delta_to_msecs(jiffies - last_seen);
 
 	vlan = batadv_meshif_vlan_get(bat_priv, common->vid);
 	if (!vlan)
@@ -1818,7 +1822,8 @@ static void batadv_tt_local_purge_list(struct batadv_priv *bat_priv,
 			if (tt_local_entry->common.flags & BATADV_TT_CLIENT_PENDING)
 				break;
 
-			if (!batadv_has_timed_out(tt_local_entry->last_seen, timeout))
+			if (!batadv_has_timed_out(READ_ONCE(tt_local_entry->last_seen),
+						  timeout))
 				break;
 
 			batadv_tt_local_set_pending(bat_priv, tt_local_entry,

-- 
2.47.3

