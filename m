Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B08DC55174
	for <batman-adv@archiver.kernel.org>; Wed,  5 Aug 2026 15:12:26 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id A2C9B82E52
	for <batman-adv@archiver.kernel.org>; Wed, 05 Aug 2026 17:12:24 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1785942744;
 b=jffh+FWQ7R47V1Jg/c5AWXbxXVs+0COTvO+nJKgDoXdAsBfx/ZvUjsZ4vITWMqJ/FNiMb
 ZXHVA9uUZHsjnrBUgw1bA85ZBBjC+5bPDjthG0v5Dvfr5xyA/3lTFJDU2QbeJtxbLkfUi0N
 XJu/nxMWxTqWtKuJVhTLLzOpbQG+MdU=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1785942744; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=8WDGguifRTNIFpsqAQ4f581lM3eSt2QabsK9I5YOukg=;
 b=xYIhZxx1xn9ef1ptUY1e56y1YI7UcP9iwVAk00/Yyq3IBcTCRmYLXxFM5AFkwqgjaFwkj
 F6/9CeaQG7BJnDqRZBZR2pYe8Uma6EPBU1kCcGO2jfEQkmOnf1MzEkrZqaOQEK+ZiIACwJc
 uEZX9F4Tgxlk3HhDGiguKZkl+pPVp7o=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 76F9784214
	for <b.a.t.m.a.n@lists.open-mesh.org>; Wed, 05 Aug 2026 17:10:31 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1785942631;
	b=PgHKSvVNT/sTeSf9oIKPJj2Cw62mfYohLZ4yjpXMH66KFwwQiQUW+xhcheGEYo+d+ITJCx
	fpquGhRsgNczZT6ImiRm5MVrrFud5OcrRWv2tE3xy5bGw/nlS8DYDNoZegMssVArkyP5tt
	NsjMDSA3+m8kT4RbweLs/M+DOZ07Rjs=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1785942631;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=8WDGguifRTNIFpsqAQ4f581lM3eSt2QabsK9I5YOukg=;
	b=e2PHJeus0pQdGvnFx5zYGMKk2gyL+HVZKhSf++7yJnu3V2gxE0tf2prHCfJwueSqW8igS3
	GK/7gYZ0JUAG0KHMVZ19+rW/rGzFzfQxcKA5EvxMQpTXs21f5rIParSpDRSfdf41p/NZbb
	gKwERDuuzCVF57WWzx8+uaOBJyIPj/I=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=wXuaRiXY;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id EAF2920E0D;
	Wed, 05 Aug 2026 15:10:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1785942627;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8WDGguifRTNIFpsqAQ4f581lM3eSt2QabsK9I5YOukg=;
	b=wXuaRiXYqDxrKjG9RwiWycw5FZy0QOwG/jvwSnyvn9TWOZwlNUG8J+fq7rvNWSu0dodp3D
	YvbFgfhIM8U8d/XyT/KAxI7FKrRQxTRr6Pb74DIYhqAWVnt295a/AXaegKkZQ05W51U+PS
	AdJM7y7H4W8evwxgB4mQR4bUcc8RRI0=
From: Sven Eckelmann <sven@narfation.org>
Date: Wed, 05 Aug 2026 17:09:38 +0200
Subject: [PATCH RFC batadv v3 4/6] batman-adv: tt: use atomic flag
 modifications
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260805-tt-fixes-v3-4-25b00b558470@narfation.org>
References: <20260805-tt-fixes-v3-0-25b00b558470@narfation.org>
In-Reply-To: <20260805-tt-fixes-v3-0-25b00b558470@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=36135; i=sven@narfation.org;
 h=from:subject:message-id; bh=Izh5Bd+MX1M98HbiBoCWTcQjRLdafU5+9hiT/km3SE8=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFnFQaY8+bM+nM9d8zpso5djbnCih5JLq9qxcxJHKu4uT
 awV0zHrKGVhEONikBVTZNlzJf/8Zva38p+nfTwKM4eVCWQIAxenAEykg5nhr3zc3SWXrfgnXTTm
 /VmwaaeSjEBxT1oF/57X++av27LKJIjhf3zFzosr/b+9UxS4PZtFf/a2uX7X15esDD9/RSJl6gm
 BaGYA
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: CTJSEHMVTGUUT3FQBDIJ5A6FHIHADIHG
X-Message-ID-Hash: CTJSEHMVTGUUT3FQBDIJ5A6FHIHADIHG
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/CTJSEHMVTGUUT3FQBDIJ5A6FHIHADIHG/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

The flags of translation table entries are modified in various places using
RMW operations like:

* read flags + add flag + store
* read flags + remove flag + store

These were done without making sure that no other context is doing a
similar operation at the same time. If another context does modify the
flags then it could happen that a store of the flag modifications is simply
lost. This problem can usually be fixed at a later point when the flags are
tried to be adjusted again.

To reduce the time the wrong flags are used, it is better to use a TT entry
specific spinlock when accessing the u16.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/translation-table.c | 569 +++++++++++++++++++++++--------------
 net/batman-adv/types.h             |   8 +-
 2 files changed, 366 insertions(+), 211 deletions(-)

diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index 5f0f7fb6..df99c67e 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -13,6 +13,7 @@
 #include <linux/build_bug.h>
 #include <linux/byteorder/generic.h>
 #include <linux/cache.h>
+#include <linux/cleanup.h>
 #include <linux/compiler.h>
 #include <linux/container_of.h>
 #include <linux/crc32.h>
@@ -498,23 +499,26 @@ static void batadv_tt_local_event(struct batadv_priv *bat_priv,
 {
 	struct batadv_tt_common_entry *common = &tt_local_entry->common;
 	struct batadv_tt_change_node *tt_change_node;
-	u8 flags = common->flags | event_flags;
 	struct batadv_tt_change_node *entry;
 	struct batadv_tt_change_node *safe;
 	bool del_op_requested;
 	bool del_op_entry;
 	size_t changes;
+	u8 flags;
 
 	tt_change_node = kmem_cache_alloc(batadv_tt_change_cache, GFP_ATOMIC);
 	if (!tt_change_node)
 		return;
 
-	tt_change_node->change.flags = flags;
 	memset(tt_change_node->change.reserved, 0,
 	       sizeof(tt_change_node->change.reserved));
 	ether_addr_copy(tt_change_node->change.addr, common->addr);
 	tt_change_node->change.vid = htons(common->vid);
 
+	scoped_guard(spinlock_bh, &common->flags_lock)
+		flags = common->flags | event_flags;
+
+	tt_change_node->change.flags = flags;
 	del_op_requested = flags & BATADV_TT_CLIENT_DEL;
 
 	/* check for ADD+DEL, DEL+ADD, ADD+ADD or DEL+DEL events */
@@ -686,8 +690,23 @@ static void batadv_tt_local_add_roam(struct batadv_priv *bat_priv,
 	/* Check whether it is a roaming, but don't do anything if the roaming
 	 * process has already been handled
 	 */
-	if (tt_global->common.flags & BATADV_TT_CLIENT_ROAM)
-		return;
+	scoped_guard(spinlock_bh, &tt_global->common.flags_lock) {
+		if (tt_global->common.flags & BATADV_TT_CLIENT_ROAM)
+			return;
+
+		if (!roamed_back) {
+			/* The global entry has to be marked as ROAMING and has to be
+			 * kept for consistency purpose.
+			 *
+			 * batadv_tt_global_to_purge() evaluates roam_at as soon as it
+			 * observes BATADV_TT_CLIENT_ROAM, so the timeout has to be
+			 * stamped before the flag is published. Otherwise the entry can
+			 * be deleted right away as "Roaming timeout".
+			 */
+			tt_global->roam_at = jiffies;
+			tt_global->common.flags &= ~BATADV_TT_CLIENT_ROAM;
+		}
+	}
 
 	/* These node are probably going to update their tt table */
 	head = &tt_global->orig_list;
@@ -699,16 +718,8 @@ static void batadv_tt_local_add_roam(struct batadv_priv *bat_priv,
 	}
 	rcu_read_unlock();
 
-	if (roamed_back) {
-		batadv_tt_global_free(bat_priv, tt_global,
-				      "Roaming canceled");
-	} else {
-		/* The global entry has to be marked as ROAMING and
-		 * has to be kept for consistency purpose
-		 */
-		tt_global->common.flags |= BATADV_TT_CLIENT_ROAM;
-		tt_global->roam_at = jiffies;
-	}
+	if (roamed_back)
+		batadv_tt_global_free(bat_priv, tt_global, "Roaming canceled");
 }
 
 /**
@@ -741,6 +752,7 @@ bool batadv_tt_local_add(struct net_device *mesh_iface, const u8 *addr,
 	int hash_added;
 	int table_size;
 	u32 match_mark;
+	bool modified;
 
 	if (ifindex != BATADV_NULL_IFINDEX)
 		in_dev = dev_get_by_index(net, ifindex);
@@ -758,30 +770,33 @@ bool batadv_tt_local_add(struct net_device *mesh_iface, const u8 *addr,
 
 	if (tt_local) {
 		tt_local->last_seen = jiffies;
-		if (tt_local->common.flags & BATADV_TT_CLIENT_PENDING) {
-			batadv_dbg(BATADV_DBG_TT, bat_priv,
-				   "Re-adding pending client %pM (vid: %d)\n",
-				   addr, batadv_print_vid(vid));
-			/* whatever the reason why the PENDING flag was set,
-			 * this is a client which was enqueued to be removed in
-			 * this orig_interval. Since it popped up again, the
-			 * flag can be reset like it was never enqueued
-			 */
-			tt_local->common.flags &= ~BATADV_TT_CLIENT_PENDING;
-			goto add_event;
-		}
 
-		if (tt_local->common.flags & BATADV_TT_CLIENT_ROAM) {
-			batadv_dbg(BATADV_DBG_TT, bat_priv,
-				   "Roaming client %pM (vid: %d) came back to its original location\n",
-				   addr, batadv_print_vid(vid));
-			/* the ROAM flag is set because this client roamed away
-			 * and the node got a roaming_advertisement message. Now
-			 * that the client popped up again at its original
-			 * location such flag can be unset
-			 */
-			tt_local->common.flags &= ~BATADV_TT_CLIENT_ROAM;
-			roamed_back = true;
+		scoped_guard(spinlock_bh, &tt_local->common.flags_lock) {
+			if (tt_local->common.flags & BATADV_TT_CLIENT_PENDING) {
+				batadv_dbg(BATADV_DBG_TT, bat_priv,
+					   "Re-adding pending client %pM (vid: %d)\n",
+					   addr, batadv_print_vid(vid));
+				/* whatever the reason why the PENDING flag was set,
+				 * this is a client which was enqueued to be removed in
+				 * this orig_interval. Since it popped up again, the
+				 * flag can be reset like it was never enqueued
+				 */
+				tt_local->common.flags &= ~BATADV_TT_CLIENT_PENDING;
+				goto add_event;
+			}
+
+			if (tt_local->common.flags & BATADV_TT_CLIENT_ROAM) {
+				batadv_dbg(BATADV_DBG_TT, bat_priv,
+					   "Roaming client %pM (vid: %d) came back to its original location\n",
+					   addr, batadv_print_vid(vid));
+				/* the ROAM flag is set because this client roamed away
+				 * and the node got a roaming_advertisement message. Now
+				 * that the client popped up again at its original
+				 * location such flag can be unset
+				 */
+				tt_local->common.flags &= ~BATADV_TT_CLIENT_ROAM;
+				roamed_back = true;
+			}
 		}
 		goto check_roaming;
 	}
@@ -818,25 +833,29 @@ bool batadv_tt_local_add(struct net_device *mesh_iface, const u8 *addr,
 		   (u8)atomic_read(&bat_priv->tt.vn));
 
 	ether_addr_copy(tt_local->common.addr, addr);
-	/* The local entry has to be marked as NEW to avoid to send it in
-	 * a full table response going out before the next ttvn increment
-	 * (consistency check)
-	 */
-	tt_local->common.flags = BATADV_TT_CLIENT_NEW;
 	tt_local->common.vid = vid;
-	if (iif_is_wifi)
-		tt_local->common.flags |= BATADV_TT_CLIENT_WIFI;
 	kref_init(&tt_local->common.refcount);
 	tt_local->last_seen = jiffies;
 	tt_local->common.added_at = tt_local->last_seen;
 	tt_local->vlan = vlan;
+	spin_lock_init(&tt_local->common.flags_lock);
 
-	/* the batman interface mac and multicast addresses should never be
-	 * purged
-	 */
-	if (batadv_compare_eth(addr, mesh_iface->dev_addr) ||
-	    is_multicast_ether_addr(addr))
-		tt_local->common.flags |= BATADV_TT_CLIENT_NOPURGE;
+	scoped_guard(spinlock_bh, &tt_local->common.flags_lock) {
+		/* The local entry has to be marked as NEW to avoid to send it in
+		 * a full table response going out before the next ttvn increment
+		 * (consistency check)
+		 */
+		tt_local->common.flags = BATADV_TT_CLIENT_NEW;
+		if (iif_is_wifi)
+			tt_local->common.flags |= BATADV_TT_CLIENT_WIFI;
+
+		/* the batman interface mac and multicast addresses should never be
+		 * purged
+		 */
+		if (batadv_compare_eth(addr, mesh_iface->dev_addr) ||
+		    is_multicast_ether_addr(addr))
+			tt_local->common.flags |= BATADV_TT_CLIENT_NOPURGE;
+	}
 
 	kref_get(&tt_local->common.refcount);
 	hash_added = batadv_hash_add(bat_priv->tt.local_hash, batadv_compare_tt,
@@ -855,31 +874,35 @@ bool batadv_tt_local_add(struct net_device *mesh_iface, const u8 *addr,
 check_roaming:
 	batadv_tt_local_add_roam(bat_priv, tt_global, roamed_back);
 
-	/* store the current remote flags before altering them. This helps
-	 * understanding is flags are changing or not
-	 */
-	remote_flags = tt_local->common.flags & BATADV_TT_REMOTE_MASK;
+	scoped_guard(spinlock_bh, &tt_local->common.flags_lock) {
+		/* store the current remote flags before altering them. This helps
+		 * understanding is flags are changing or not
+		 */
+		remote_flags = tt_local->common.flags & BATADV_TT_REMOTE_MASK;
 
-	if (iif_is_wifi)
-		tt_local->common.flags |= BATADV_TT_CLIENT_WIFI;
-	else
-		tt_local->common.flags &= ~BATADV_TT_CLIENT_WIFI;
+		if (iif_is_wifi)
+			tt_local->common.flags |= BATADV_TT_CLIENT_WIFI;
+		else
+			tt_local->common.flags &= ~BATADV_TT_CLIENT_WIFI;
 
-	/* check the mark in the skb: if it's equal to the configured
-	 * isolation_mark, it means the packet is coming from an isolated
-	 * non-mesh client
-	 */
-	match_mark = (mark & bat_priv->isolation_mark_mask);
-	if (bat_priv->isolation_mark_mask &&
-	    match_mark == bat_priv->isolation_mark)
-		tt_local->common.flags |= BATADV_TT_CLIENT_ISOLA;
-	else
-		tt_local->common.flags &= ~BATADV_TT_CLIENT_ISOLA;
+		/* check the mark in the skb: if it's equal to the configured
+		 * isolation_mark, it means the packet is coming from an isolated
+		 * non-mesh client
+		 */
+		match_mark = (mark & bat_priv->isolation_mark_mask);
+		if (bat_priv->isolation_mark_mask &&
+		    match_mark == bat_priv->isolation_mark)
+			tt_local->common.flags |= BATADV_TT_CLIENT_ISOLA;
+		else
+			tt_local->common.flags &= ~BATADV_TT_CLIENT_ISOLA;
+
+		modified = remote_flags ^ (tt_local->common.flags & BATADV_TT_REMOTE_MASK);
+	}
 
 	/* if any "dynamic" flag has been modified, resend an ADD event for this
 	 * entry so that all the nodes can get the new flags
 	 */
-	if (remote_flags ^ (tt_local->common.flags & BATADV_TT_REMOTE_MASK))
+	if (modified)
 		batadv_tt_local_event(bat_priv, tt_local, BATADV_NO_FLAGS);
 
 	ret = true;
@@ -1204,6 +1227,7 @@ batadv_tt_local_dump_entry(struct sk_buff *msg, u32 portid,
 	struct batadv_meshif_vlan *vlan;
 	unsigned int last_seen_msecs;
 	void *hdr;
+	u16 flags;
 	u32 crc;
 
 	local = container_of(common, struct batadv_tt_local_entry, common);
@@ -1225,13 +1249,16 @@ batadv_tt_local_dump_entry(struct sk_buff *msg, u32 portid,
 
 	genl_dump_check_consistent(cb, hdr);
 
+	scoped_guard(spinlock_bh, &common->flags_lock)
+		flags = common->flags;
+
 	if (nla_put(msg, BATADV_ATTR_TT_ADDRESS, ETH_ALEN, common->addr) ||
 	    nla_put_u32(msg, BATADV_ATTR_TT_CRC32, crc) ||
 	    nla_put_u16(msg, BATADV_ATTR_TT_VID, common->vid) ||
-	    nla_put_u32(msg, BATADV_ATTR_TT_FLAGS, common->flags))
+	    nla_put_u32(msg, BATADV_ATTR_TT_FLAGS, flags))
 		goto nla_put_failure;
 
-	if (!(common->flags & BATADV_TT_CLIENT_NOPURGE) &&
+	if (!(flags & BATADV_TT_CLIENT_NOPURGE) &&
 	    nla_put_u32(msg, BATADV_ATTR_LAST_SEEN_MSECS, last_seen_msecs))
 		goto nla_put_failure;
 
@@ -1338,7 +1365,7 @@ int batadv_tt_local_dump(struct sk_buff *msg, struct netlink_callback *cb)
 }
 
 /**
- * batadv_tt_local_set_pending() - mark a local TT entry as pending removal
+ * batadv_tt_local_set_pending_event() - trigger events for TT pending removal
  * @bat_priv: the bat priv with all the mesh interface information
  * @tt_local_entry: local TT entry to mark
  * @flags: TT change flags to announce together with the pending removal
@@ -1349,18 +1376,12 @@ int batadv_tt_local_dump(struct sk_buff *msg, struct netlink_callback *cb)
  * so that a consistency-check response can still be answered.
  */
 static void
-batadv_tt_local_set_pending(struct batadv_priv *bat_priv,
-			    struct batadv_tt_local_entry *tt_local_entry,
-			    u16 flags, const char *message)
+batadv_tt_local_set_pending_event(struct batadv_priv *bat_priv,
+				  struct batadv_tt_local_entry *tt_local_entry,
+				  u16 flags, const char *message)
 {
 	batadv_tt_local_event(bat_priv, tt_local_entry, flags);
 
-	/* The local client has to be marked as "pending to be removed" but has
-	 * to be kept in the table in order to send it in a full table
-	 * response issued before the net ttvn increment (consistency check)
-	 */
-	tt_local_entry->common.flags |= BATADV_TT_CLIENT_PENDING;
-
 	batadv_dbg(BATADV_DBG_TT, bat_priv,
 		   "Local tt entry (%pM, vid: %d) pending to be removed: %s\n",
 		   tt_local_entry->common.addr,
@@ -1384,30 +1405,46 @@ u16 batadv_tt_local_remove(struct batadv_priv *bat_priv, const u8 *addr,
 	struct batadv_tt_local_entry *tt_local_entry;
 	struct hlist_node *tt_removed_node;
 	u16 curr_flags = BATADV_NO_FLAGS;
+	bool pending = false;
 	u16 flags;
 
 	tt_local_entry = batadv_tt_local_hash_find(bat_priv, addr, vid);
 	if (!tt_local_entry)
 		goto out;
 
-	curr_flags = tt_local_entry->common.flags;
+	scoped_guard(spinlock_bh, &tt_local_entry->common.flags_lock) {
+		curr_flags = tt_local_entry->common.flags;
 
-	flags = BATADV_TT_CLIENT_DEL;
-	/* if this global entry addition is due to a roaming, the node has to
-	 * mark the local entry as "roamed" in order to correctly reroute
-	 * packets later
-	 */
-	if (roaming) {
-		flags |= BATADV_TT_CLIENT_ROAM;
-		/* mark the local client as ROAMed */
-		tt_local_entry->common.flags |= BATADV_TT_CLIENT_ROAM;
+		flags = BATADV_TT_CLIENT_DEL;
+		/* if this global entry addition is due to a roaming, the node has to
+		 * mark the local entry as "roamed" in order to correctly reroute
+		 * packets later
+		 */
+		if (roaming) {
+			flags |= BATADV_TT_CLIENT_ROAM;
+			/* mark the local client as ROAMed */
+			tt_local_entry->common.flags |= BATADV_TT_CLIENT_ROAM;
+		}
+
+		/* This must stay a read-only test while the entry is still hashed:
+		 * clearing the NEW flag here would make a concurrent remover of the
+		 * same entry pick the branch below and mark a not yet committed entry
+		 * as pending. A parallel batadv_tt_local_purge_pending_clients()
+		 * then calls batadv_tt_local_size_dec() for this entry even when
+		 * it was never counted by via batadv_tt_local_set_flags()
+		 */
+		if (!(tt_local_entry->common.flags & BATADV_TT_CLIENT_NEW)) {
+			tt_local_entry->common.flags |= BATADV_TT_CLIENT_PENDING;
+			pending = true;
+		}
 	}
 
-	if (!(tt_local_entry->common.flags & BATADV_TT_CLIENT_NEW)) {
-		batadv_tt_local_set_pending(bat_priv, tt_local_entry, flags,
-					    message);
+	if (pending) {
+		batadv_tt_local_set_pending_event(bat_priv, tt_local_entry, flags,
+						  message);
 		goto out;
 	}
+
 	/* if this client has been added right now, it is possible to
 	 * immediately purge it
 	 */
@@ -1447,21 +1484,37 @@ static void batadv_tt_local_purge_list(struct batadv_priv *bat_priv,
 
 	hlist_for_each_entry_safe(tt_common_entry, node_tmp, head,
 				  hash_entry) {
+		bool cont = false;
+
 		tt_local_entry = container_of(tt_common_entry,
 					      struct batadv_tt_local_entry,
 					      common);
-		if (tt_local_entry->common.flags & BATADV_TT_CLIENT_NOPURGE)
+
+		scoped_guard(spinlock_bh, &tt_local_entry->common.flags_lock) {
+			if (tt_local_entry->common.flags & BATADV_TT_CLIENT_NOPURGE) {
+				cont = true;
+				break;
+			}
+
+			/* entry already marked for deletion */
+			if (tt_local_entry->common.flags & BATADV_TT_CLIENT_PENDING) {
+				cont = true;
+				break;
+			}
+
+			if (!batadv_has_timed_out(tt_local_entry->last_seen, timeout)) {
+				cont = true;
+				break;
+			}
+
+			tt_local_entry->common.flags |= BATADV_TT_CLIENT_PENDING;
+		}
+
+		if (cont)
 			continue;
 
-		/* entry already marked for deletion */
-		if (tt_local_entry->common.flags & BATADV_TT_CLIENT_PENDING)
-			continue;
-
-		if (!batadv_has_timed_out(tt_local_entry->last_seen, timeout))
-			continue;
-
-		batadv_tt_local_set_pending(bat_priv, tt_local_entry,
-					    BATADV_TT_CLIENT_DEL, "timed out");
+		batadv_tt_local_set_pending_event(bat_priv, tt_local_entry,
+						  BATADV_TT_CLIENT_DEL, "timed out");
 	}
 }
 
@@ -1667,8 +1720,10 @@ batadv_tt_global_sync_flags(struct batadv_tt_global_entry *tt_global)
 		flags |= orig_entry->flags;
 	rcu_read_unlock();
 
-	flags |= tt_global->common.flags & (~BATADV_TT_SYNC_MASK);
-	tt_global->common.flags = flags;
+	scoped_guard(spinlock_bh, &tt_global->common.flags_lock) {
+		flags |= tt_global->common.flags & (~BATADV_TT_SYNC_MASK);
+		tt_global->common.flags = flags;
+	}
 }
 
 /**
@@ -1752,6 +1807,7 @@ static bool batadv_tt_global_add(struct batadv_priv *bat_priv,
 	bool ret = false;
 	u16 local_flags;
 	int hash_added;
+	bool delete;
 
 	/* ignore global entries from backbone nodes */
 	if (batadv_bla_is_backbone_gw_orig(bat_priv, orig_node->orig, vid))
@@ -1764,9 +1820,12 @@ static bool batadv_tt_global_add(struct batadv_priv *bat_priv,
 	 * for a roaming advertisement instead of manually messing up the global
 	 * table
 	 */
-	if ((flags & BATADV_TT_CLIENT_TEMP) && tt_local_entry &&
-	    !(tt_local_entry->common.flags & BATADV_TT_CLIENT_NEW))
-		goto out;
+	if ((flags & BATADV_TT_CLIENT_TEMP) && tt_local_entry) {
+		scoped_guard(spinlock_bh, &tt_local_entry->common.flags_lock) {
+			if (!(tt_local_entry->common.flags & BATADV_TT_CLIENT_NEW))
+				goto out;
+		}
+	}
 
 	if (!tt_global_entry) {
 		tt_global_entry = kmem_cache_zalloc(batadv_tg_cache,
@@ -1777,9 +1836,12 @@ static bool batadv_tt_global_add(struct batadv_priv *bat_priv,
 		common = &tt_global_entry->common;
 		ether_addr_copy(common->addr, tt_addr);
 		common->vid = vid;
+		spin_lock_init(&common->flags_lock);
 
-		if (!is_multicast_ether_addr(common->addr))
-			common->flags = flags & (~BATADV_TT_SYNC_MASK);
+		if (!is_multicast_ether_addr(common->addr)) {
+			scoped_guard(spinlock_bh, &common->flags_lock)
+				common->flags = flags & (~BATADV_TT_SYNC_MASK);
+		}
 
 		tt_global_entry->roam_at = 0;
 		/* node must store current time in case of roaming. This is
@@ -1808,6 +1870,7 @@ static bool batadv_tt_global_add(struct batadv_priv *bat_priv,
 		}
 	} else {
 		common = &tt_global_entry->common;
+
 		/* If there is already a global entry, we can use this one for
 		 * our processing.
 		 * But if we are trying to add a temporary client then here are
@@ -1819,8 +1882,11 @@ static bool batadv_tt_global_add(struct batadv_priv *bat_priv,
 		 *    originator list and add the new one orig_entry
 		 */
 		if (flags & BATADV_TT_CLIENT_TEMP) {
-			if (!(common->flags & BATADV_TT_CLIENT_TEMP))
-				goto out;
+			scoped_guard(spinlock_bh, &common->flags_lock) {
+				if (!(common->flags & BATADV_TT_CLIENT_TEMP))
+					goto out;
+			}
+
 			if (batadv_tt_global_entry_has_orig(tt_global_entry,
 							    orig_node, NULL))
 				goto out_remove;
@@ -1828,36 +1894,42 @@ static bool batadv_tt_global_add(struct batadv_priv *bat_priv,
 			goto add_orig_entry;
 		}
 
-		/* if the client was temporary added before receiving the first
-		 * OGM announcing it, we have to clear the TEMP flag. Also,
-		 * remove the previous temporary orig node and re-add it
-		 * if required. If the orig entry changed, the new one which
-		 * is a non-temporary entry is preferred.
-		 */
-		if (common->flags & BATADV_TT_CLIENT_TEMP) {
-			batadv_tt_global_del_orig_list(tt_global_entry);
-			common->flags &= ~BATADV_TT_CLIENT_TEMP;
+		delete = false;
+		scoped_guard(spinlock_bh, &common->flags_lock) {
+			/* if the client was temporary added before receiving the first
+			 * OGM announcing it, we have to clear the TEMP flag. Also,
+			 * remove the previous temporary orig node and re-add it
+			 * if required. If the orig entry changed, the new one which
+			 * is a non-temporary entry is preferred.
+			 */
+			if (common->flags & BATADV_TT_CLIENT_TEMP) {
+				delete = true;
+				common->flags &= ~BATADV_TT_CLIENT_TEMP;
+			}
+
+			/* the change can carry possible "attribute" flags like the
+			 * TT_CLIENT_TEMP, therefore they have to be copied in the
+			 * client entry
+			 */
+			if (!is_multicast_ether_addr(common->addr))
+				common->flags |= flags & (~BATADV_TT_SYNC_MASK);
+
+			/* If there is the BATADV_TT_CLIENT_ROAM flag set, there is only
+			 * one originator left in the list and we previously received a
+			 * delete + roaming change for this originator.
+			 *
+			 * We should first delete the old originator before adding the
+			 * new one.
+			 */
+			if (common->flags & BATADV_TT_CLIENT_ROAM) {
+				delete = true;
+				common->flags &= ~BATADV_TT_CLIENT_ROAM;
+				tt_global_entry->roam_at = 0;
+			}
 		}
 
-		/* the change can carry possible "attribute" flags like the
-		 * TT_CLIENT_TEMP, therefore they have to be copied in the
-		 * client entry
-		 */
-		if (!is_multicast_ether_addr(common->addr))
-			common->flags |= flags & (~BATADV_TT_SYNC_MASK);
-
-		/* If there is the BATADV_TT_CLIENT_ROAM flag set, there is only
-		 * one originator left in the list and we previously received a
-		 * delete + roaming change for this originator.
-		 *
-		 * We should first delete the old originator before adding the
-		 * new one.
-		 */
-		if (common->flags & BATADV_TT_CLIENT_ROAM) {
+		if (delete)
 			batadv_tt_global_del_orig_list(tt_global_entry);
-			common->flags &= ~BATADV_TT_CLIENT_ROAM;
-			tt_global_entry->roam_at = 0;
-		}
 	}
 add_orig_entry:
 	/* add the new orig_entry (if needed) or update it */
@@ -1881,13 +1953,16 @@ static bool batadv_tt_global_add(struct batadv_priv *bat_priv,
 	local_flags = batadv_tt_local_remove(bat_priv, tt_addr, vid,
 					     "global tt received",
 					     flags & BATADV_TT_CLIENT_ROAM);
-	tt_global_entry->common.flags |= local_flags & BATADV_TT_CLIENT_WIFI;
 
-	if (!(flags & BATADV_TT_CLIENT_ROAM))
-		/* this is a normal global add. Therefore the client is not in a
-		 * roaming state anymore.
-		 */
-		tt_global_entry->common.flags &= ~BATADV_TT_CLIENT_ROAM;
+	scoped_guard(spinlock_bh, &tt_global_entry->common.flags_lock) {
+		tt_global_entry->common.flags |= local_flags & BATADV_TT_CLIENT_WIFI;
+
+		if (!(flags & BATADV_TT_CLIENT_ROAM))
+			/* this is a normal global add. Therefore the client is not in a
+			 * roaming state anymore.
+			 */
+			tt_global_entry->common.flags &= ~BATADV_TT_CLIENT_ROAM;
+	}
 
 out:
 	batadv_tt_global_entry_put(tt_global_entry);
@@ -1957,9 +2032,9 @@ batadv_tt_global_dump_subentry(struct sk_buff *msg, u32 portid, u32 seq,
 			       struct batadv_tt_orig_list_entry *orig,
 			       bool best)
 {
-	u16 flags = (common->flags & (~BATADV_TT_SYNC_MASK)) | orig->flags;
 	struct batadv_orig_node_vlan *vlan;
 	u8 last_ttvn;
+	u16 flags;
 	void *hdr;
 	u32 crc;
 
@@ -1978,6 +2053,9 @@ batadv_tt_global_dump_subentry(struct sk_buff *msg, u32 portid, u32 seq,
 	if (!hdr)
 		return -ENOBUFS;
 
+	scoped_guard(spinlock_bh, &common->flags_lock)
+		flags = (common->flags & (~BATADV_TT_SYNC_MASK)) | orig->flags;
+
 	last_ttvn = READ_ONCE(orig->orig_node->last_ttvn);
 
 	if (nla_put(msg, BATADV_ATTR_TT_ADDRESS, ETH_ALEN, common->addr) ||
@@ -2266,7 +2344,9 @@ batadv_tt_global_del_roaming(struct batadv_priv *bat_priv,
 
 	if (last_entry) {
 		/* its the last one, mark for roaming. */
-		tt_global_entry->common.flags |= BATADV_TT_CLIENT_ROAM;
+		scoped_guard(spinlock_bh, &tt_global_entry->common.flags_lock)
+			tt_global_entry->common.flags |= BATADV_TT_CLIENT_ROAM;
+
 		tt_global_entry->roam_at = jiffies;
 	} else {
 		/* there is another entry, we can simply delete this
@@ -2416,16 +2496,18 @@ static bool batadv_tt_global_to_purge(struct batadv_tt_global_entry *tt_global,
 	unsigned long temp_timeout = BATADV_TT_CLIENT_TEMP_TIMEOUT;
 	bool purge = false;
 
-	if ((tt_global->common.flags & BATADV_TT_CLIENT_ROAM) &&
-	    batadv_has_timed_out(tt_global->roam_at, roam_timeout)) {
-		purge = true;
-		*msg = "Roaming timeout\n";
-	}
+	scoped_guard(spinlock_bh, &tt_global->common.flags_lock) {
+		if ((tt_global->common.flags & BATADV_TT_CLIENT_ROAM) &&
+		    batadv_has_timed_out(tt_global->roam_at, roam_timeout)) {
+			purge = true;
+			*msg = "Roaming timeout\n";
+		}
 
-	if ((tt_global->common.flags & BATADV_TT_CLIENT_TEMP) &&
-	    batadv_has_timed_out(tt_global->common.added_at, temp_timeout)) {
-		purge = true;
-		*msg = "Temporary client timeout\n";
+		if ((tt_global->common.flags & BATADV_TT_CLIENT_TEMP) &&
+		    batadv_has_timed_out(tt_global->common.added_at, temp_timeout)) {
+			purge = true;
+			*msg = "Temporary client timeout\n";
+		}
 	}
 
 	return purge;
@@ -2534,13 +2616,22 @@ static bool
 _batadv_is_ap_isolated(struct batadv_tt_local_entry *tt_local_entry,
 		       struct batadv_tt_global_entry *tt_global_entry)
 {
-	if (tt_local_entry->common.flags & BATADV_TT_CLIENT_WIFI &&
-	    tt_global_entry->common.flags & BATADV_TT_CLIENT_WIFI)
+	u16 global_flags;
+	u16 local_flags;
+
+	scoped_guard(spinlock_bh, &tt_global_entry->common.flags_lock)
+		global_flags = tt_global_entry->common.flags;
+
+	scoped_guard(spinlock_bh, &tt_local_entry->common.flags_lock)
+		local_flags = tt_local_entry->common.flags;
+
+	if (local_flags & BATADV_TT_CLIENT_WIFI &&
+	    global_flags & BATADV_TT_CLIENT_WIFI)
 		return true;
 
 	/* check if the two clients are marked as isolated */
-	if (tt_local_entry->common.flags & BATADV_TT_CLIENT_ISOLA &&
-	    tt_global_entry->common.flags & BATADV_TT_CLIENT_ISOLA)
+	if (local_flags & BATADV_TT_CLIENT_ISOLA &&
+	    global_flags & BATADV_TT_CLIENT_ISOLA)
 		return true;
 
 	return false;
@@ -2572,9 +2663,13 @@ struct batadv_orig_node *batadv_transtable_search(struct batadv_priv *bat_priv,
 
 	if (src && batadv_vlan_ap_isola_get(bat_priv, vid)) {
 		tt_local_entry = batadv_tt_local_hash_find(bat_priv, src, vid);
-		if (!tt_local_entry ||
-		    (tt_local_entry->common.flags & BATADV_TT_CLIENT_PENDING))
+		if (!tt_local_entry)
 			goto out;
+
+		scoped_guard(spinlock_bh, &tt_local_entry->common.flags_lock) {
+			if (tt_local_entry->common.flags & BATADV_TT_CLIENT_PENDING)
+				goto out;
+		}
 	}
 
 	tt_global_entry = batadv_tt_global_hash_find(bat_priv, addr, vid);
@@ -2648,6 +2743,8 @@ static u32 batadv_tt_global_crc(struct batadv_priv *bat_priv,
 
 		rcu_read_lock();
 		hlist_for_each_entry_rcu(tt_common, head, hash_entry) {
+			bool cont = false;
+
 			tt_global = container_of(tt_common,
 						 struct batadv_tt_global_entry,
 						 common);
@@ -2657,18 +2754,28 @@ static u32 batadv_tt_global_crc(struct batadv_priv *bat_priv,
 			if (tt_common->vid != vid)
 				continue;
 
-			/* Roaming clients are in the global table for
-			 * consistency only. They don't have to be
-			 * taken into account while computing the
-			 * global crc
-			 */
-			if (tt_common->flags & BATADV_TT_CLIENT_ROAM)
-				continue;
-			/* Temporary clients have not been announced yet, so
-			 * they have to be skipped while computing the global
-			 * crc
-			 */
-			if (tt_common->flags & BATADV_TT_CLIENT_TEMP)
+			scoped_guard(spinlock_bh, &tt_common->flags_lock) {
+				/* Roaming clients are in the global table for
+				 * consistency only. They don't have to be
+				 * taken into account while computing the
+				 * global crc
+				 */
+				if (tt_common->flags & BATADV_TT_CLIENT_ROAM) {
+					cont = true;
+					break;
+				}
+
+				/* Temporary clients have not been announced yet, so
+				 * they have to be skipped while computing the global
+				 * crc
+				 */
+				if (tt_common->flags & BATADV_TT_CLIENT_TEMP) {
+					cont = true;
+					break;
+				}
+			}
+
+			if (cont)
 				continue;
 
 			/* find out if this global entry is announced by this
@@ -2728,16 +2835,27 @@ static u32 batadv_tt_local_crc(struct batadv_priv *bat_priv,
 
 		rcu_read_lock();
 		hlist_for_each_entry_rcu(tt_common, head, hash_entry) {
+			bool cont = false;
+
 			/* compute the CRC only for entries belonging to the
 			 * VLAN identified by vid
 			 */
 			if (tt_common->vid != vid)
 				continue;
 
-			/* not yet committed clients have not to be taken into
-			 * account while computing the CRC
-			 */
-			if (tt_common->flags & BATADV_TT_CLIENT_NEW)
+			scoped_guard(spinlock_bh, &tt_common->flags_lock) {
+				/* not yet committed clients have not to be taken into
+				 * account while computing the CRC
+				 */
+				if (tt_common->flags & BATADV_TT_CLIENT_NEW) {
+					cont = true;
+					break;
+				}
+
+				flags = tt_common->flags & BATADV_TT_SYNC_MASK;
+			}
+
+			if (cont)
 				continue;
 
 			/* use network order to read the VID: this ensures that
@@ -2749,7 +2867,6 @@ static u32 batadv_tt_local_crc(struct batadv_priv *bat_priv,
 			/* compute the CRC on flags that have to be kept in sync
 			 * among nodes
 			 */
-			flags = tt_common->flags & BATADV_TT_SYNC_MASK;
 			crc_tmp = crc32c(crc_tmp, &flags, sizeof(flags));
 
 			crc ^= crc32c(crc_tmp, tt_common->addr, ETH_ALEN);
@@ -2907,17 +3024,19 @@ batadv_tt_req_node_new(struct batadv_priv *bat_priv,
  *
  * Return: true if the entry is a valid, false otherwise.
  */
-static bool batadv_tt_local_valid(const void *entry_ptr,
+static bool batadv_tt_local_valid(void *entry_ptr,
 				  const void *data_ptr,
 				  u8 *flags)
 {
-	const struct batadv_tt_common_entry *tt_common_entry = entry_ptr;
+	struct batadv_tt_common_entry *tt_common_entry = entry_ptr;
 
-	if (tt_common_entry->flags & BATADV_TT_CLIENT_NEW)
-		return false;
+	scoped_guard(spinlock_bh, &tt_common_entry->flags_lock) {
+		if (tt_common_entry->flags & BATADV_TT_CLIENT_NEW)
+			return false;
 
-	if (flags)
-		*flags = tt_common_entry->flags;
+		if (flags)
+			*flags = tt_common_entry->flags;
+	}
 
 	return true;
 }
@@ -2934,17 +3053,19 @@ static bool batadv_tt_local_valid(const void *entry_ptr,
  *
  * Return: true if the entry is a valid, false otherwise.
  */
-static bool batadv_tt_global_valid(const void *entry_ptr,
+static bool batadv_tt_global_valid(void *entry_ptr,
 				   const void *data_ptr,
 				   u8 *flags)
 {
-	const struct batadv_tt_common_entry *tt_common_entry = entry_ptr;
-	const struct batadv_tt_global_entry *tt_global_entry;
+	struct batadv_tt_common_entry *tt_common_entry = entry_ptr;
 	const struct batadv_orig_node *orig_node = data_ptr;
+	struct batadv_tt_global_entry *tt_global_entry;
 
-	if (tt_common_entry->flags & BATADV_TT_CLIENT_ROAM ||
-	    tt_common_entry->flags & BATADV_TT_CLIENT_TEMP)
-		return false;
+	scoped_guard(spinlock_bh, &tt_common_entry->flags_lock) {
+		if (tt_common_entry->flags & BATADV_TT_CLIENT_ROAM ||
+		    tt_common_entry->flags & BATADV_TT_CLIENT_TEMP)
+			return false;
+	}
 
 	tt_global_entry = container_of(tt_common_entry,
 				       struct batadv_tt_global_entry,
@@ -2972,7 +3093,7 @@ static bool batadv_tt_global_valid(const void *entry_ptr,
 static u16 batadv_tt_tvlv_generate(struct batadv_priv *bat_priv,
 				   struct batadv_hashtable *hash,
 				   void *tvlv_buff, u16 tt_len,
-				   bool (*valid_cb)(const void *,
+				   bool (*valid_cb)(void *,
 						    const void *,
 						    u8 *flags),
 				   void *cb_data)
@@ -3602,12 +3723,16 @@ bool batadv_is_my_client(struct batadv_priv *bat_priv, const u8 *addr,
 	tt_local_entry = batadv_tt_local_hash_find(bat_priv, addr, vid);
 	if (!tt_local_entry)
 		goto out;
+
 	/* Check if the client has been logically deleted (but is kept for
 	 * consistency purpose)
 	 */
-	if ((tt_local_entry->common.flags & BATADV_TT_CLIENT_PENDING) ||
-	    (tt_local_entry->common.flags & BATADV_TT_CLIENT_ROAM))
-		goto out;
+	scoped_guard(spinlock_bh, &tt_local_entry->common.flags_lock) {
+		if ((tt_local_entry->common.flags & BATADV_TT_CLIENT_PENDING) ||
+		    (tt_local_entry->common.flags & BATADV_TT_CLIENT_ROAM))
+			goto out;
+	}
+
 	ret = true;
 out:
 	batadv_tt_local_entry_put(tt_local_entry);
@@ -3888,10 +4013,19 @@ static void batadv_tt_local_transition_new(struct batadv_priv *bat_priv)
 		rcu_read_lock();
 		hlist_for_each_entry_rcu(tt_common_entry,
 					 head, hash_entry) {
-			if (!(tt_common_entry->flags & BATADV_TT_CLIENT_NEW))
-				continue;
+			bool cont = false;
 
-			tt_common_entry->flags &= ~BATADV_TT_CLIENT_NEW;
+			scoped_guard(spinlock_bh, &tt_common_entry->flags_lock) {
+				if (!(tt_common_entry->flags & BATADV_TT_CLIENT_NEW)) {
+					cont = true;
+					break;
+				}
+
+				tt_common_entry->flags &= ~BATADV_TT_CLIENT_NEW;
+			}
+
+			if (cont)
+				continue;
 
 			batadv_tt_local_size_inc(bat_priv,
 						 tt_common_entry->vid);
@@ -3928,16 +4062,26 @@ static void batadv_tt_local_purge_pending_clients(struct batadv_priv *bat_priv)
 		spin_lock_bh(list_lock);
 		hlist_for_each_entry_safe(tt_common, node_tmp, head,
 					  hash_entry) {
-			if (!(tt_common->flags & BATADV_TT_CLIENT_PENDING))
+			bool cont = false;
+
+			scoped_guard(spinlock_bh, &tt_common->flags_lock) {
+				if (!(tt_common->flags & BATADV_TT_CLIENT_PENDING)) {
+					cont = true;
+					break;
+				}
+
+				batadv_dbg(BATADV_DBG_TT, bat_priv,
+					   "Deleting local tt entry (%pM, vid: %d): pending\n",
+					   tt_common->addr,
+					   batadv_print_vid(tt_common->vid));
+
+				batadv_tt_local_size_dec(bat_priv, tt_common->vid);
+				hlist_del_rcu(&tt_common->hash_entry);
+			}
+
+			if (cont)
 				continue;
 
-			batadv_dbg(BATADV_DBG_TT, bat_priv,
-				   "Deleting local tt entry (%pM, vid: %d): pending\n",
-				   tt_common->addr,
-				   batadv_print_vid(tt_common->vid));
-
-			batadv_tt_local_size_dec(bat_priv, tt_common->vid);
-			hlist_del_rcu(&tt_common->hash_entry);
 			tt_local = container_of(tt_common,
 						struct batadv_tt_local_entry,
 						common);
@@ -4141,7 +4285,9 @@ bool batadv_tt_global_client_is_roaming(struct batadv_priv *bat_priv,
 	if (!tt_global_entry)
 		goto out;
 
-	ret = tt_global_entry->common.flags & BATADV_TT_CLIENT_ROAM;
+	scoped_guard(spinlock_bh, &tt_global_entry->common.flags_lock)
+		ret = tt_global_entry->common.flags & BATADV_TT_CLIENT_ROAM;
+
 	batadv_tt_global_entry_put(tt_global_entry);
 out:
 	return ret;
@@ -4167,7 +4313,9 @@ bool batadv_tt_local_client_is_roaming(struct batadv_priv *bat_priv,
 	if (!tt_local_entry)
 		goto out;
 
-	ret = tt_local_entry->common.flags & BATADV_TT_CLIENT_ROAM;
+	scoped_guard(spinlock_bh, &tt_local_entry->common.flags_lock)
+		ret = tt_local_entry->common.flags & BATADV_TT_CLIENT_ROAM;
+
 	batadv_tt_local_entry_put(tt_local_entry);
 out:
 	return ret;
@@ -4478,7 +4626,8 @@ bool batadv_tt_global_is_isolated(struct batadv_priv *bat_priv,
 	if (!tt)
 		return false;
 
-	ret = tt->common.flags & BATADV_TT_CLIENT_ISOLA;
+	scoped_guard(spinlock_bh, &tt->common.flags_lock)
+		ret = tt->common.flags & BATADV_TT_CLIENT_ISOLA;
 
 	batadv_tt_global_entry_put(tt);
 
diff --git a/net/batman-adv/types.h b/net/batman-adv/types.h
index 9bdc5a3e..142169be 100644
--- a/net/batman-adv/types.h
+++ b/net/batman-adv/types.h
@@ -1851,12 +1851,18 @@ struct batadv_tt_common_entry {
 	 */
 	struct hlist_node hash_entry;
 
-	/** @flags: various state handling flags (see batadv_tt_client_flags) */
+	/**
+	 * @flags: various state handling flags (see batadv_tt_client_flags),
+	 * protected by @flags_lock
+	 */
 	u16 flags;
 
 	/** @added_at: timestamp used for purging stale tt common entries */
 	unsigned long added_at;
 
+	/** @flags_lock: protect modifications of @flags */
+	spinlock_t flags_lock;
+
 	/** @refcount: number of contexts the object is used */
 	struct kref refcount;
 

-- 
2.47.3

