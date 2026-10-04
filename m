Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C001CA5FCE
	for <batman@archiver.kernel.org>; Sun,  4 Oct 2026 10:12:58 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id BF0DB844AF
	for <batman@archiver.kernel.org>; Sun, 04 Oct 2026 12:12:56 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1791108776;
 b=PCBnkBWDItiqGWtK7O0QdIO7QLuP4CEkNkC7ej+BOgGzfAtS54IhMFp6O5KRd5G/kecAt
 l3Bi+xdkJQlEi2eLRO/wBE3oWeYNzY8Lq4IANg4917VXn4AqRuHyZHtH0AQVjx2V39XT25c
 N6PsBpVD3ei/QneV779To3TqSBOc/BM=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1791108776; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=aNYT+D7ESX9GQnBOAYx/ckb93QpDNvm2kqBT3Z7AzLI=;
 b=dFgql/C0Edbqi8qUKee/rDwGesMni7EyCBvtegSaoEGdqlA01y2ac0iobsL3/9R8sYcNW
 ps/6hitik1FKB9Fz7VFeRpWAK5aWPHWQmpC6woZ2WmVHBzo6zJ/NLhBM9eldnhFlRYdR34M
 ZcUuBqkTpc6VprY2ks/VQjnRL4HpoDE=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org
 [IPv6:2a00:17d8:100::8b1])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 2F75A84270
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sun, 04 Oct 2026 12:09:09 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1791108559;
	b=eQcgG82wPSVtYCF8tQIp+RkX0Z7Dd5c2vx3hjxCYhRn400GkwvJa9/bIW/DHWb/oZzCqbd
	qlATol2ofluMSetXNodbJQrFvpGxZe93xZxjIjmdhS3vtoU/npf7bfVSlzLTMKuUuiEAwo
	jR/lHstXgnz6Pwl2cHPmcftvXh53DF8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1791108559;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=aNYT+D7ESX9GQnBOAYx/ckb93QpDNvm2kqBT3Z7AzLI=;
	b=cWZtkCYblaO4nUNkDVSlPPOZiRg4Z9PBKqgNYQR1ko86FY6084QEUxArZr4eNk44EKgDB7
	Ln8uWhTt1nD+nEOpTnyUYsotwJSSEwLq0MuxclU0EX1qePXc9iTr3LezOuAgjBrctQHY22
	FSrjYUbVHJ2Y1cA11HBI2TNl6gBqkC4=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=JcGVLZXw;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id CBA79205A6;
	Sun, 04 Oct 2026 10:09:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1791108548;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aNYT+D7ESX9GQnBOAYx/ckb93QpDNvm2kqBT3Z7AzLI=;
	b=JcGVLZXwjAF1yb4PHqOWpdLPFjiAMEGwrlYcx2S/WIUX0s5qtX7OZ4T10n+uHyg5Y3lgHo
	t5Si5fbOF0k8Cb5A/la5eTBPVHITrsD8liadA8h5HxiSLkFZHVr7KEVLbbsaa9xPixfXz/
	j+EfQ7kESvMmqI3a5iZSmTXiUIfYzlA=
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 04 Oct 2026 12:08:39 +0200
Subject: [PATCH batadv v2 4/9] batman-adv: tt: annotate last_seen with
 READ/WRITE_ONCE
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261004-dat-last_update-once-v2-4-ab012a4b18ed@narfation.org>
References: <20261004-dat-last_update-once-v2-0-ab012a4b18ed@narfation.org>
In-Reply-To: <20261004-dat-last_update-once-v2-0-ab012a4b18ed@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2907; i=sven@narfation.org;
 h=from:subject:message-id; bh=9nJiQAa9k5dtxZDa08AFh1HFAtO7N2gkBcoA7En6HPc=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFmHVLcoXTr4cF9OfPnDWzvlI3LeNR/d5h+zZWdF2jrGp
 X9dptWld5SyMIhxMciKKbLsuZJ/fjP7W/nP0z4ehZnDygQyhIGLUwAm0hzF8E9drHDH5G/Hpbos
 nty+z1Xn5zZp78/ae1WsC2T2GFYqMrEy/NM5tDfW/VG2xqo/OtPtFzqnzyzneqDf8ff4lMLVRob
 2tnwA
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: LRJDCKCCQQMTVG6OMPZATG2G6JI3RLYH
X-Message-ID-Hash: LRJDCKCCQQMTVG6OMPZATG2G6JI3RLYH
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/LRJDCKCCQQMTVG6OMPZATG2G6JI3RLYH/>
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
index f2377ef6..99fd5fca 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -927,7 +927,7 @@ static bool batadv_tt_local_add_existing(struct batadv_priv *bat_priv,
 {
 	struct batadv_tt_common_entry *common = &tt_local->common;
 
-	tt_local->last_seen = jiffies;
+	WRITE_ONCE(tt_local->last_seen, jiffies);
 
 	scoped_guard(spinlock_bh, &common->flags_lock) {
 		if (common->flags & BATADV_TT_CLIENT_PENDING) {
@@ -982,6 +982,7 @@ batadv_tt_local_create(struct net_device *mesh_iface, const u8 *addr,
 	struct batadv_priv *bat_priv = netdev_priv(mesh_iface);
 	struct batadv_tt_local_entry *tt_local;
 	struct batadv_meshif_vlan *vlan;
+	unsigned long last_seen;
 
 	if (!batadv_tt_local_reserve_entry(bat_priv, addr))
 		return NULL;
@@ -1011,8 +1012,9 @@ batadv_tt_local_create(struct net_device *mesh_iface, const u8 *addr,
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
 
@@ -1467,12 +1469,14 @@ batadv_tt_local_dump_entry(struct sk_buff *msg, u32 portid,
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
@@ -1780,7 +1784,8 @@ static void batadv_tt_local_purge_list(struct batadv_priv *bat_priv,
 				break;
 			}
 
-			if (!batadv_has_timed_out(tt_local_entry->last_seen, timeout)) {
+			if (!batadv_has_timed_out(READ_ONCE(tt_local_entry->last_seen),
+						  timeout)) {
 				cont = true;
 				break;
 			}

-- 
2.47.3

