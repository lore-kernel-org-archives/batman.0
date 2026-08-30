Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9C74C61DD9
	for <batman-adv@archiver.kernel.org>; Sun, 30 Aug 2026 15:24:49 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id EFDE8803D9
	for <batman-adv@archiver.kernel.org>; Sun, 30 Aug 2026 17:24:47 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1788103487;
 b=tQLEqmFwK5a/gi2uiF4TV8OOgVe0KHNMw/tQsLe5M59AvbBD3JivRwKvTbAoB0aMm9epa
 xAsJxrMm5NQktY6fi8MEc6IYHk04g6KJxylAyJuI6NGOpZcry/OWzuuRHYCMkEahdiXG4VT
 6nauxwhVoEXNaILidzlS5PEJ0ftDCT8=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1788103487; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=5L8Zg2L3ObNu5iPmImE4gVfhPxx4WIqUmeuHc8PWVWk=;
 b=jEavcv2ngT19grFlY442EJgMEIQRE6WXGQ540bVQ2RnfZ+wRLFlp+WUAJk80Is4a/SXeZ
 ncDpkbuVogO58NdD1WY8nETB4ALRhloq5Fx6kyyZoY2Nd6OZ2MfDfIWUTAt7AhxCXWEu520
 d7Unk/RDoVGq3BpnCxOALXMmSQ6cwCM=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 631FD80335
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sun, 30 Aug 2026 17:22:12 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1788103332;
	b=oHYcG6EaFrpRe39CbEL+eovg1PN3FZO9KcuzdpQw89/+BEjx5MeGhGvOfi4A/EsoIWu2kF
	eVOWSkz5xIe16h02tF7JuEiiUv8UfHnXfAtjbqFoW6QlRe+t56uiuhRGX8ggulz/qniwXd
	Lnb/08MP4BVKm9hyKX4anfEOwoK8OxI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1788103332;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=5L8Zg2L3ObNu5iPmImE4gVfhPxx4WIqUmeuHc8PWVWk=;
	b=yUeee4cMrXisCd1qjSbm3vmDn0XR8cv8yEUMb5KeuqlLTEG2z6YBQ8zB3N7WxEqY359k1c
	hou5zkXBBqKWudE/AdSzAlq1xZ4eI9ZIwE6pE6RfNzREFQpeMXtXah/OhOf+rBXYYhsCzC
	WlQK42LbD23tBvLndIqGrtSEIvJp3Pw=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=qO0TxHo4;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id 01BB3203BC;
	Sun, 30 Aug 2026 15:22:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1788103328;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5L8Zg2L3ObNu5iPmImE4gVfhPxx4WIqUmeuHc8PWVWk=;
	b=qO0TxHo466T3S251whys6a9lmdJp/HLIr25gnj2FRDiU9JAwmRIM3z+ZM5LX6gE9jxHf4m
	FUBo2niYtg+NYy0ok8zylMTEBJvtGP/KDp2xFwkQFwgtFKSZ8VpPwgova1ls6IlyiO7jr8
	GNSZzAxTI6rENj9s0r14XRM8UifgZ1g=
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 30 Aug 2026 17:21:42 +0200
Subject: [PATCH batadv v6 05/20] batman-adv: tt: use protected flag
 modifications
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260830-tt-fixes-v6-5-a56568a15041@narfation.org>
References: <20260830-tt-fixes-v6-0-a56568a15041@narfation.org>
In-Reply-To: <20260830-tt-fixes-v6-0-a56568a15041@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=30427; i=sven@narfation.org;
 h=from:subject:message-id; bh=2Sv4/Wd6pukjbimIf81eZ571JzeIAJ4FGeDRfPmS24E=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFlTvNpmR8hFBko9+df0N+mJvYDSa51o/vP/ft1X2xTnt
 uJ4/aapHaUsDGJcDLJiiix7ruSf38z+Vv7ztI9HYeawMoEMYeDiFICJcPcxMkzXL3MU6RZWvZ72
 dobIHjMbKYv4J5a2bR8rjt69v8uD5TEjw5k7X3P50jK9fv2VkFoWrfLQVLZ9XneYjN1Fs83f3TW
 8OQA=
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: KKBTLLZIURZFKJ3AJ6HVGQ2CEEGOO5GG
X-Message-ID-Hash: KKBTLLZIURZFKJ3AJ6HVGQ2CEEGOO5GG
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/KKBTLLZIURZFKJ3AJ6HVGQ2CEEGOO5GG/>
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
 net/batman-adv/translation-table.c | 351 ++++++++++++++++++++++++++-----------
 net/batman-adv/types.h             |  11 +-
 2 files changed, 255 insertions(+), 107 deletions(-)

diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index 2dcee14d..ec72c391 100644
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
@@ -486,6 +487,22 @@ batadv_tt_orig_list_entry_put(struct batadv_tt_orig_list_entry *orig_entry)
 	kref_put(&orig_entry->refcount, batadv_tt_orig_list_entry_release);
 }
 
+/**
+ * batadv_tt_flags_get() - get a snapshot of the flags of a TT entry
+ * @common: tt local & tt global common data
+ *
+ * Return: the flags of the TT entry as observed under its flags_lock.
+ */
+static u16 batadv_tt_flags_get(struct batadv_tt_common_entry *common)
+{
+	u16 flags;
+
+	scoped_guard(spinlock_bh, &common->flags_lock)
+		flags = common->flags;
+
+	return flags;
+}
+
 /**
  * batadv_tt_local_event() - store a local TT event (ADD/DEL)
  * @bat_priv: the bat priv with all the mesh interface information
@@ -498,23 +515,25 @@ static void batadv_tt_local_event(struct batadv_priv *bat_priv,
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
 
+	flags = batadv_tt_flags_get(common) | event_flags;
+
+	tt_change_node->change.flags = flags;
 	del_op_requested = flags & BATADV_TT_CLIENT_DEL;
 
 	/* check for ADD+DEL, DEL+ADD, ADD+ADD or DEL+DEL events */
@@ -686,8 +705,23 @@ static void batadv_tt_local_add_roam(struct batadv_priv *bat_priv,
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
+			tt_global->common.flags |= BATADV_TT_CLIENT_ROAM;
+		}
+	}
 
 	/* These node are probably going to update their tt table */
 	head = &tt_global->orig_list;
@@ -699,16 +733,8 @@ static void batadv_tt_local_add_roam(struct batadv_priv *bat_priv,
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
@@ -741,6 +767,7 @@ bool batadv_tt_local_add(struct net_device *mesh_iface, const u8 *addr,
 	int hash_added;
 	int table_size;
 	u32 match_mark;
+	bool modified;
 
 	if (ifindex != BATADV_NULL_IFINDEX)
 		in_dev = dev_get_by_index(net, ifindex);
@@ -758,6 +785,8 @@ bool batadv_tt_local_add(struct net_device *mesh_iface, const u8 *addr,
 
 	if (tt_local) {
 		tt_local->last_seen = jiffies;
+
+		spin_lock_bh(&tt_local->common.flags_lock);
 		if (tt_local->common.flags & BATADV_TT_CLIENT_PENDING) {
 			batadv_dbg(BATADV_DBG_TT, bat_priv,
 				   "Re-adding pending client %pM (vid: %d)\n",
@@ -768,6 +797,8 @@ bool batadv_tt_local_add(struct net_device *mesh_iface, const u8 *addr,
 			 * flag can be reset like it was never enqueued
 			 */
 			tt_local->common.flags &= ~BATADV_TT_CLIENT_PENDING;
+			spin_unlock_bh(&tt_local->common.flags_lock);
+
 			goto add_event;
 		}
 
@@ -783,6 +814,8 @@ bool batadv_tt_local_add(struct net_device *mesh_iface, const u8 *addr,
 			tt_local->common.flags &= ~BATADV_TT_CLIENT_ROAM;
 			roamed_back = true;
 		}
+		spin_unlock_bh(&tt_local->common.flags_lock);
+
 		goto check_roaming;
 	}
 
@@ -818,18 +851,21 @@ bool batadv_tt_local_add(struct net_device *mesh_iface, const u8 *addr,
 		   (u8)atomic_read(&bat_priv->tt.vn));
 
 	ether_addr_copy(tt_local->common.addr, addr);
+	tt_local->common.vid = vid;
+	kref_init(&tt_local->common.refcount);
+	tt_local->last_seen = jiffies;
+	tt_local->common.added_at = tt_local->last_seen;
+	tt_local->vlan = vlan;
+	spin_lock_init(&tt_local->common.flags_lock);
+
+	spin_lock_bh(&tt_local->common.flags_lock);
 	/* The local entry has to be marked as NEW to avoid to send it in
 	 * a full table response going out before the next ttvn increment
 	 * (consistency check)
 	 */
 	tt_local->common.flags = BATADV_TT_CLIENT_NEW;
-	tt_local->common.vid = vid;
 	if (iif_is_wifi)
 		tt_local->common.flags |= BATADV_TT_CLIENT_WIFI;
-	kref_init(&tt_local->common.refcount);
-	tt_local->last_seen = jiffies;
-	tt_local->common.added_at = tt_local->last_seen;
-	tt_local->vlan = vlan;
 
 	/* the batman interface mac and multicast addresses should never be
 	 * purged
@@ -837,6 +873,7 @@ bool batadv_tt_local_add(struct net_device *mesh_iface, const u8 *addr,
 	if (batadv_compare_eth(addr, mesh_iface->dev_addr) ||
 	    is_multicast_ether_addr(addr))
 		tt_local->common.flags |= BATADV_TT_CLIENT_NOPURGE;
+	spin_unlock_bh(&tt_local->common.flags_lock);
 
 	kref_get(&tt_local->common.refcount);
 	hash_added = batadv_hash_add(bat_priv->tt.local_hash, batadv_compare_tt,
@@ -855,6 +892,7 @@ bool batadv_tt_local_add(struct net_device *mesh_iface, const u8 *addr,
 check_roaming:
 	batadv_tt_local_add_roam(bat_priv, tt_global, roamed_back);
 
+	spin_lock_bh(&tt_local->common.flags_lock);
 	/* store the current remote flags before altering them. This helps
 	 * understanding is flags are changing or not
 	 */
@@ -876,10 +914,13 @@ bool batadv_tt_local_add(struct net_device *mesh_iface, const u8 *addr,
 	else
 		tt_local->common.flags &= ~BATADV_TT_CLIENT_ISOLA;
 
+	modified = remote_flags ^ (tt_local->common.flags & BATADV_TT_REMOTE_MASK);
+	spin_unlock_bh(&tt_local->common.flags_lock);
+
 	/* if any "dynamic" flag has been modified, resend an ADD event for this
 	 * entry so that all the nodes can get the new flags
 	 */
-	if (remote_flags ^ (tt_local->common.flags & BATADV_TT_REMOTE_MASK))
+	if (modified)
 		batadv_tt_local_event(bat_priv, tt_local, BATADV_NO_FLAGS);
 
 	ret = true;
@@ -1204,6 +1245,7 @@ batadv_tt_local_dump_entry(struct sk_buff *msg, u32 portid,
 	struct batadv_meshif_vlan *vlan;
 	unsigned int last_seen_msecs;
 	void *hdr;
+	u16 flags;
 	u32 crc;
 
 	local = container_of(common, struct batadv_tt_local_entry, common);
@@ -1225,13 +1267,15 @@ batadv_tt_local_dump_entry(struct sk_buff *msg, u32 portid,
 
 	genl_dump_check_consistent(cb, hdr);
 
+	flags = batadv_tt_flags_get(common);
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
 
@@ -1338,29 +1382,23 @@ int batadv_tt_local_dump(struct sk_buff *msg, struct netlink_callback *cb)
 }
 
 /**
- * batadv_tt_local_set_pending() - mark a local TT entry as pending removal
+ * batadv_tt_local_set_pending_event() - trigger events for TT pending removal
  * @bat_priv: the bat priv with all the mesh interface information
  * @tt_local_entry: local TT entry to mark
  * @flags: TT change flags to announce together with the pending removal
  * @message: debug message describing the reason for the change
  *
- * Schedule the TT change announcement and set BATADV_TT_CLIENT_PENDING on the
- * entry. The entry is kept in the local table until the next TTVN increment
- * so that a consistency-check response can still be answered.
+ * Schedule the TT change announcement for the entry. The entry is kept in the
+ * local table until the next TTVN increment so that a consistency-check
+ * response can still be answered.
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
@@ -1384,12 +1422,14 @@ u16 batadv_tt_local_remove(struct batadv_priv *bat_priv, const u8 *addr,
 	struct batadv_tt_local_entry *tt_local_entry;
 	struct hlist_node *tt_removed_node;
 	u16 curr_flags = BATADV_NO_FLAGS;
+	bool pending = false;
 	u16 flags;
 
 	tt_local_entry = batadv_tt_local_hash_find(bat_priv, addr, vid);
 	if (!tt_local_entry)
 		goto out;
 
+	spin_lock_bh(&tt_local_entry->common.flags_lock);
 	curr_flags = tt_local_entry->common.flags;
 
 	flags = BATADV_TT_CLIENT_DEL;
@@ -1404,10 +1444,17 @@ u16 batadv_tt_local_remove(struct batadv_priv *bat_priv, const u8 *addr,
 	}
 
 	if (!(tt_local_entry->common.flags & BATADV_TT_CLIENT_NEW)) {
-		batadv_tt_local_set_pending(bat_priv, tt_local_entry, flags,
-					    message);
+		tt_local_entry->common.flags |= BATADV_TT_CLIENT_PENDING;
+		pending = true;
+	}
+	spin_unlock_bh(&tt_local_entry->common.flags_lock);
+
+	if (pending) {
+		batadv_tt_local_set_pending_event(bat_priv, tt_local_entry, flags,
+						  message);
 		goto out;
 	}
+
 	/* if this client has been added right now, it is possible to
 	 * immediately purge it
 	 */
@@ -1447,21 +1494,37 @@ static void batadv_tt_local_purge_list(struct batadv_priv *bat_priv,
 
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
 
@@ -1667,8 +1730,10 @@ batadv_tt_global_sync_flags(struct batadv_tt_global_entry *tt_global)
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
@@ -1750,8 +1815,10 @@ static bool batadv_tt_global_add(struct batadv_priv *bat_priv,
 	struct batadv_tt_local_entry *tt_local_entry;
 	struct batadv_tt_common_entry *common;
 	bool ret = false;
+	u16 global_flags;
 	u16 local_flags;
 	int hash_added;
+	bool delete;
 
 	/* ignore global entries from backbone nodes */
 	if (batadv_bla_is_backbone_gw_orig(bat_priv, orig_node->orig, vid))
@@ -1764,9 +1831,11 @@ static bool batadv_tt_global_add(struct batadv_priv *bat_priv,
 	 * for a roaming advertisement instead of manually messing up the global
 	 * table
 	 */
-	if ((flags & BATADV_TT_CLIENT_TEMP) && tt_local_entry &&
-	    !(tt_local_entry->common.flags & BATADV_TT_CLIENT_NEW))
-		goto out;
+	if ((flags & BATADV_TT_CLIENT_TEMP) && tt_local_entry) {
+		local_flags = batadv_tt_flags_get(&tt_local_entry->common);
+		if (!(local_flags & BATADV_TT_CLIENT_NEW))
+			goto out;
+	}
 
 	if (!tt_global_entry) {
 		tt_global_entry = kmem_cache_zalloc(batadv_tg_cache,
@@ -1777,9 +1846,13 @@ static bool batadv_tt_global_add(struct batadv_priv *bat_priv,
 		common = &tt_global_entry->common;
 		ether_addr_copy(common->addr, tt_addr);
 		common->vid = vid;
+		spin_lock_init(&common->flags_lock);
 
-		if (!is_multicast_ether_addr(common->addr))
+		if (!is_multicast_ether_addr(common->addr)) {
+			spin_lock_bh(&common->flags_lock);
 			common->flags = flags & (~BATADV_TT_SYNC_MASK);
+			spin_unlock_bh(&common->flags_lock);
+		}
 
 		tt_global_entry->roam_at = 0;
 		/* node must store current time in case of roaming. This is
@@ -1819,8 +1892,10 @@ static bool batadv_tt_global_add(struct batadv_priv *bat_priv,
 		 *    originator list and add the new one orig_entry
 		 */
 		if (flags & BATADV_TT_CLIENT_TEMP) {
-			if (!(common->flags & BATADV_TT_CLIENT_TEMP))
+			global_flags = batadv_tt_flags_get(common);
+			if (!(global_flags & BATADV_TT_CLIENT_TEMP))
 				goto out;
+
 			if (batadv_tt_global_entry_has_orig(tt_global_entry,
 							    orig_node, NULL))
 				goto out_remove;
@@ -1828,6 +1903,9 @@ static bool batadv_tt_global_add(struct batadv_priv *bat_priv,
 			goto add_orig_entry;
 		}
 
+		delete = false;
+
+		spin_lock_bh(&common->flags_lock);
 		/* if the client was temporary added before receiving the first
 		 * OGM announcing it, we have to clear the TEMP flag. Also,
 		 * remove the previous temporary orig node and re-add it
@@ -1835,7 +1913,7 @@ static bool batadv_tt_global_add(struct batadv_priv *bat_priv,
 		 * is a non-temporary entry is preferred.
 		 */
 		if (common->flags & BATADV_TT_CLIENT_TEMP) {
-			batadv_tt_global_del_orig_list(tt_global_entry);
+			delete = true;
 			common->flags &= ~BATADV_TT_CLIENT_TEMP;
 		}
 
@@ -1854,10 +1932,14 @@ static bool batadv_tt_global_add(struct batadv_priv *bat_priv,
 		 * new one.
 		 */
 		if (common->flags & BATADV_TT_CLIENT_ROAM) {
-			batadv_tt_global_del_orig_list(tt_global_entry);
-			common->flags &= ~BATADV_TT_CLIENT_ROAM;
+			delete = true;
 			tt_global_entry->roam_at = 0;
+			common->flags &= ~BATADV_TT_CLIENT_ROAM;
 		}
+		spin_unlock_bh(&common->flags_lock);
+
+		if (delete)
+			batadv_tt_global_del_orig_list(tt_global_entry);
 	}
 add_orig_entry:
 	/* add the new orig_entry (if needed) or update it */
@@ -1881,6 +1963,8 @@ static bool batadv_tt_global_add(struct batadv_priv *bat_priv,
 	local_flags = batadv_tt_local_remove(bat_priv, tt_addr, vid,
 					     "global tt received",
 					     flags & BATADV_TT_CLIENT_ROAM);
+
+	spin_lock_bh(&tt_global_entry->common.flags_lock);
 	tt_global_entry->common.flags |= local_flags & BATADV_TT_CLIENT_WIFI;
 
 	if (!(flags & BATADV_TT_CLIENT_ROAM))
@@ -1888,6 +1972,7 @@ static bool batadv_tt_global_add(struct batadv_priv *bat_priv,
 		 * roaming state anymore.
 		 */
 		tt_global_entry->common.flags &= ~BATADV_TT_CLIENT_ROAM;
+	spin_unlock_bh(&tt_global_entry->common.flags_lock);
 
 out:
 	batadv_tt_global_entry_put(tt_global_entry);
@@ -1957,9 +2042,9 @@ batadv_tt_global_dump_subentry(struct sk_buff *msg, u32 portid, u32 seq,
 			       struct batadv_tt_orig_list_entry *orig,
 			       bool best)
 {
-	u16 flags = (common->flags & (~BATADV_TT_SYNC_MASK)) | orig->flags;
 	struct batadv_orig_node_vlan *vlan;
 	u8 last_ttvn;
+	u16 flags;
 	void *hdr;
 	u32 crc;
 
@@ -1978,6 +2063,7 @@ batadv_tt_global_dump_subentry(struct sk_buff *msg, u32 portid, u32 seq,
 	if (!hdr)
 		return -ENOBUFS;
 
+	flags = (batadv_tt_flags_get(common) & (~BATADV_TT_SYNC_MASK)) | orig->flags;
 	last_ttvn = READ_ONCE(orig->orig_node->last_ttvn);
 
 	if (nla_put(msg, BATADV_ATTR_TT_ADDRESS, ETH_ALEN, common->addr) ||
@@ -2265,9 +2351,12 @@ batadv_tt_global_del_roaming(struct batadv_priv *bat_priv,
 	rcu_read_unlock();
 
 	if (last_entry) {
-		/* its the last one, mark for roaming. */
-		tt_global_entry->common.flags |= BATADV_TT_CLIENT_ROAM;
-		tt_global_entry->roam_at = jiffies;
+		scoped_guard(spinlock_bh, &tt_global_entry->common.flags_lock) {
+			/* its the last one, mark for roaming. */
+			tt_global_entry->roam_at = jiffies;
+
+			tt_global_entry->common.flags |= BATADV_TT_CLIENT_ROAM;
+		}
 	} else {
 		/* there is another entry, we can simply delete this
 		 * one and can still use the other one.
@@ -2416,16 +2505,18 @@ static bool batadv_tt_global_to_purge(struct batadv_tt_global_entry *tt_global,
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
@@ -2534,13 +2625,19 @@ static bool
 _batadv_is_ap_isolated(struct batadv_tt_local_entry *tt_local_entry,
 		       struct batadv_tt_global_entry *tt_global_entry)
 {
-	if (tt_local_entry->common.flags & BATADV_TT_CLIENT_WIFI &&
-	    tt_global_entry->common.flags & BATADV_TT_CLIENT_WIFI)
+	u16 global_flags;
+	u16 local_flags;
+
+	global_flags = batadv_tt_flags_get(&tt_global_entry->common);
+	local_flags = batadv_tt_flags_get(&tt_local_entry->common);
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
@@ -2569,11 +2666,15 @@ struct batadv_orig_node *batadv_transtable_search(struct batadv_priv *bat_priv,
 	struct batadv_tt_local_entry *tt_local_entry = NULL;
 	struct batadv_tt_orig_list_entry *best_entry;
 	struct batadv_orig_node *orig_node = NULL;
+	u16 flags;
 
 	if (src && batadv_vlan_ap_isola_get(bat_priv, vid)) {
 		tt_local_entry = batadv_tt_local_hash_find(bat_priv, src, vid);
-		if (!tt_local_entry ||
-		    (tt_local_entry->common.flags & BATADV_TT_CLIENT_PENDING))
+		if (!tt_local_entry)
+			goto out;
+
+		flags = batadv_tt_flags_get(&tt_local_entry->common);
+		if (flags & BATADV_TT_CLIENT_PENDING)
 			goto out;
 	}
 
@@ -2648,6 +2749,8 @@ static u32 batadv_tt_global_crc(struct batadv_priv *bat_priv,
 
 		rcu_read_lock();
 		hlist_for_each_entry_rcu(tt_common, head, hash_entry) {
+			u16 tt_flags;
+
 			tt_global = container_of(tt_common,
 						 struct batadv_tt_global_entry,
 						 common);
@@ -2657,18 +2760,21 @@ static u32 batadv_tt_global_crc(struct batadv_priv *bat_priv,
 			if (tt_common->vid != vid)
 				continue;
 
+			tt_flags = batadv_tt_flags_get(tt_common);
+
 			/* Roaming clients are in the global table for
 			 * consistency only. They don't have to be
 			 * taken into account while computing the
 			 * global crc
 			 */
-			if (tt_common->flags & BATADV_TT_CLIENT_ROAM)
+			if (tt_flags & BATADV_TT_CLIENT_ROAM)
 				continue;
+
 			/* Temporary clients have not been announced yet, so
 			 * they have to be skipped while computing the global
 			 * crc
 			 */
-			if (tt_common->flags & BATADV_TT_CLIENT_TEMP)
+			if (tt_flags & BATADV_TT_CLIENT_TEMP)
 				continue;
 
 			/* find out if this global entry is announced by this
@@ -2728,18 +2834,24 @@ static u32 batadv_tt_local_crc(struct batadv_priv *bat_priv,
 
 		rcu_read_lock();
 		hlist_for_each_entry_rcu(tt_common, head, hash_entry) {
+			u16 tt_flags;
+
 			/* compute the CRC only for entries belonging to the
 			 * VLAN identified by vid
 			 */
 			if (tt_common->vid != vid)
 				continue;
 
+			tt_flags = batadv_tt_flags_get(tt_common);
+
 			/* not yet committed clients have not to be taken into
 			 * account while computing the CRC
 			 */
-			if (tt_common->flags & BATADV_TT_CLIENT_NEW)
+			if (tt_flags & BATADV_TT_CLIENT_NEW)
 				continue;
 
+			flags = tt_flags & BATADV_TT_SYNC_MASK;
+
 			/* use network order to read the VID: this ensures that
 			 * every node reads the bytes in the same order.
 			 */
@@ -2749,7 +2861,6 @@ static u32 batadv_tt_local_crc(struct batadv_priv *bat_priv,
 			/* compute the CRC on flags that have to be kept in sync
 			 * among nodes
 			 */
-			flags = tt_common->flags & BATADV_TT_SYNC_MASK;
 			crc_tmp = crc32c(crc_tmp, &flags, sizeof(flags));
 
 			crc ^= crc32c(crc_tmp, tt_common->addr, ETH_ALEN);
@@ -2907,17 +3018,19 @@ batadv_tt_req_node_new(struct batadv_priv *bat_priv,
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
+	u16 tt_flags;
 
-	if (tt_common_entry->flags & BATADV_TT_CLIENT_NEW)
+	tt_flags = batadv_tt_flags_get(tt_common_entry);
+	if (tt_flags & BATADV_TT_CLIENT_NEW)
 		return false;
 
 	if (flags)
-		*flags = tt_common_entry->flags;
+		*flags = tt_flags;
 
 	return true;
 }
@@ -2934,16 +3047,18 @@ static bool batadv_tt_local_valid(const void *entry_ptr,
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
+	u16 tt_flags;
 
-	if (tt_common_entry->flags & BATADV_TT_CLIENT_ROAM ||
-	    tt_common_entry->flags & BATADV_TT_CLIENT_TEMP)
+	tt_flags = batadv_tt_flags_get(tt_common_entry);
+	if (tt_flags & BATADV_TT_CLIENT_ROAM ||
+	    tt_flags & BATADV_TT_CLIENT_TEMP)
 		return false;
 
 	tt_global_entry = container_of(tt_common_entry,
@@ -2972,7 +3087,7 @@ static bool batadv_tt_global_valid(const void *entry_ptr,
 static u16 batadv_tt_tvlv_generate(struct batadv_priv *bat_priv,
 				   struct batadv_hashtable *hash,
 				   void *tvlv_buff, u16 tt_len,
-				   bool (*valid_cb)(const void *,
+				   bool (*valid_cb)(void *,
 						    const void *,
 						    u8 *flags),
 				   void *cb_data)
@@ -3597,17 +3712,20 @@ bool batadv_is_my_client(struct batadv_priv *bat_priv, const u8 *addr,
 			 unsigned short vid)
 {
 	struct batadv_tt_local_entry *tt_local_entry;
+	u16 tt_flags;
 	bool ret;
 
 	tt_local_entry = batadv_tt_local_hash_find(bat_priv, addr, vid);
 	if (!tt_local_entry)
 		return false;
 
+	tt_flags = batadv_tt_flags_get(&tt_local_entry->common);
+
 	/* Check if the client has been logically deleted (but is kept for
 	 * consistency purpose)
 	 */
-	ret = !((tt_local_entry->common.flags & BATADV_TT_CLIENT_PENDING) ||
-		(tt_local_entry->common.flags & BATADV_TT_CLIENT_ROAM));
+	ret = !((tt_flags & BATADV_TT_CLIENT_PENDING) ||
+		(tt_flags & BATADV_TT_CLIENT_ROAM));
 
 	batadv_tt_local_entry_put(tt_local_entry);
 	return ret;
@@ -3887,10 +4005,19 @@ static void batadv_tt_local_transition_new(struct batadv_priv *bat_priv)
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
@@ -3927,16 +4054,26 @@ static void batadv_tt_local_purge_pending_clients(struct batadv_priv *bat_priv)
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
@@ -4140,7 +4277,8 @@ bool batadv_tt_global_client_is_roaming(struct batadv_priv *bat_priv,
 	if (!tt_global_entry)
 		return false;
 
-	ret = tt_global_entry->common.flags & BATADV_TT_CLIENT_ROAM;
+	ret = batadv_tt_flags_get(&tt_global_entry->common) & BATADV_TT_CLIENT_ROAM;
+
 	batadv_tt_global_entry_put(tt_global_entry);
 
 	return ret;
@@ -4166,7 +4304,8 @@ bool batadv_tt_local_client_is_roaming(struct batadv_priv *bat_priv,
 	if (!tt_local_entry)
 		return false;
 
-	ret = tt_local_entry->common.flags & BATADV_TT_CLIENT_ROAM;
+	ret = batadv_tt_flags_get(&tt_local_entry->common) & BATADV_TT_CLIENT_ROAM;
+
 	batadv_tt_local_entry_put(tt_local_entry);
 
 	return ret;
@@ -4477,7 +4616,7 @@ bool batadv_tt_global_is_isolated(struct batadv_priv *bat_priv,
 	if (!tt)
 		return false;
 
-	ret = tt->common.flags & BATADV_TT_CLIENT_ISOLA;
+	ret = batadv_tt_flags_get(&tt->common) & BATADV_TT_CLIENT_ISOLA;
 
 	batadv_tt_global_entry_put(tt);
 
diff --git a/net/batman-adv/types.h b/net/batman-adv/types.h
index 9bdc5a3e..7443021f 100644
--- a/net/batman-adv/types.h
+++ b/net/batman-adv/types.h
@@ -1851,12 +1851,21 @@ struct batadv_tt_common_entry {
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
 
+	/**
+	 * @flags_lock: protect modifications of @flags and
+	 *  @batadv_tt_global_entry.roam_at
+	 */
+	spinlock_t flags_lock;
+
 	/** @refcount: number of contexts the object is used */
 	struct kref refcount;
 

-- 
2.47.3

