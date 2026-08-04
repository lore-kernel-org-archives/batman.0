Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB7EFC5518F
	for <batman-adv@archiver.kernel.org>; Tue,  4 Aug 2026 10:21:07 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 5A95884221
	for <batman-adv@archiver.kernel.org>; Tue, 04 Aug 2026 12:21:06 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1785838866;
 b=CaRbU4ZXHK/v2uCUcZqdsUyUeHobwJAW5AK9JlnkZt3gyMaKpXfLCwLc7zjgS17KrYyLx
 zUC36bPy0PICPcGHgW+VD6ZqRmXQRFmbBMm3TluKaOrtAHJoT0TiI9HPtURYG4VOB5ptm+5
 UixVIL+9KYRXbwkjxaU7sUO0Lz0siw0=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1785838866; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=2v392tHEvCgdwZz5w8szUdC9kfSX9KevrH3LFWK9hCE=;
 b=mNklvsHfZcbLUjfyIt2sxG1Iyc0bV6d7N6LYgdAJY7k+dk4kPYgv5fpOyztOsHxQ6shfB
 nwi9x1CNU+3ZxaWzCx+briGwU+y3Iv0bsKxaT8sIqE3y/SBCSikzR1bnOWUkh8YltUAm33f
 cU59+RzkSt6QEFbTyR4BWT2ZKltvB5M=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 169DF84215
	for <b.a.t.m.a.n@lists.open-mesh.org>; Tue, 04 Aug 2026 12:19:27 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1785838767;
	b=zey7f5y/TiNsnr/e53chsAfTiVUPi7Wp6S08+J7QHyJM9QbS32vWuNB0Nk+Xrn8fltloDV
	F4dcZi1FiJi1s0cxIbkbfu/Q+1JMiQMGtIxAsQ0KKy5u5E7pNv/ZO6ziQxcm0bBtFj7DUy
	BaUWmCanLg1K44FQ8fSg8cktmLrr8HA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1785838767;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=2v392tHEvCgdwZz5w8szUdC9kfSX9KevrH3LFWK9hCE=;
	b=Xa/1jR51K7YiAMT8dJ9bEvLPz4Z7m1JXXVwCwJ9C13W7//fPssptwSlbOBNkms9zjTk4zE
	y01EQ/e+wSrGOBHUj+KVvlxsGEypoIOgk6XFl7dZ3CBzPSJoGrWGoxLmg023v/coUfQMJO
	PuVXtDOLMj786k5J/yWkh6WRIAT6xks=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b="YZKcFf4/";
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id B10A620210;
	Tue, 04 Aug 2026 10:19:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1785838762;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2v392tHEvCgdwZz5w8szUdC9kfSX9KevrH3LFWK9hCE=;
	b=YZKcFf4/ADb2YyrOQKzgmOoVGvIvEmg/WzdDzfYI3PFqrTZBANTgeElBbSw8GED+6AX+/v
	4oSbrZcPnmECoLNeRgvQgyD2g+hTsbrvQ+k/lpObdh/owa5qcKAroj1hTsgYYdq0Lm04rz
	j/veIjrsRQPV8bafdguw2zy3mPTyyeM=
From: Sven Eckelmann <sven@narfation.org>
Date: Tue, 04 Aug 2026 12:18:15 +0200
Subject: [PATCH batadv v2 4/6] batman-adv: tt: use atomic flag
 modifications
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260804-tt-fixes-v2-4-487c48fc7fc4@narfation.org>
References: <20260804-tt-fixes-v2-0-487c48fc7fc4@narfation.org>
In-Reply-To: <20260804-tt-fixes-v2-0-487c48fc7fc4@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=27742; i=sven@narfation.org;
 h=from:subject:message-id; bh=p00dXtww/f8pHPRmAmz1gqvJWUi74RxprQLft++45b4=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFmFe7JOrTnuni9uH55wVHFqp8KnlFemeyPeRLEJfS1+2
 XrDQki7o5SFQYyLQVZMkWXPlfzzm9nfyn+e9vEozBxWJpAhDFycAjARK1GG/y6t/75ViS45dae4
 KIY3m3e55wfTtYsWfFxst9Vv8oZV640Y/unenClwxvN5RtfisFYm1WvnJyzS0T/59UZOoEs1l9j
 czzwA
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: 4SQMHMOJECBOTC43QCKYFDHZB262JD74
X-Message-ID-Hash: 4SQMHMOJECBOTC43QCKYFDHZB262JD74
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/4SQMHMOJECBOTC43QCKYFDHZB262JD74/>
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

To reduce the time the wrong flags are used, it is better to change the u16
flags type to use an atomic_t with its atomic helper to perform these
adjustments.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/translation-table.c | 249 +++++++++++++++++++++++++------------
 net/batman-adv/types.h             |   2 +-
 2 files changed, 169 insertions(+), 82 deletions(-)

diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index 5f0f7fb6..cf13ea2f 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -497,8 +497,8 @@ static void batadv_tt_local_event(struct batadv_priv *bat_priv,
 				  u8 event_flags)
 {
 	struct batadv_tt_common_entry *common = &tt_local_entry->common;
+	u8 flags = atomic_read(&common->flags) | event_flags;
 	struct batadv_tt_change_node *tt_change_node;
-	u8 flags = common->flags | event_flags;
 	struct batadv_tt_change_node *entry;
 	struct batadv_tt_change_node *safe;
 	bool del_op_requested;
@@ -679,6 +679,7 @@ static void batadv_tt_local_add_roam(struct batadv_priv *bat_priv,
 {
 	struct batadv_tt_orig_list_entry *orig_entry;
 	struct hlist_head *head;
+	u16 old_flags;
 
 	if (!tt_global)
 		return;
@@ -686,9 +687,29 @@ static void batadv_tt_local_add_roam(struct batadv_priv *bat_priv,
 	/* Check whether it is a roaming, but don't do anything if the roaming
 	 * process has already been handled
 	 */
-	if (tt_global->common.flags & BATADV_TT_CLIENT_ROAM)
+	if (atomic_read(&tt_global->common.flags) & BATADV_TT_CLIENT_ROAM)
 		return;
 
+	if (!roamed_back) {
+		/* The global entry has to be marked as ROAMING and has to be
+		 * kept for consistency purpose.
+		 *
+		 * batadv_tt_global_to_purge() evaluates roam_at as soon as it
+		 * observes BATADV_TT_CLIENT_ROAM, so the timeout has to be
+		 * stamped before the flag is published. Otherwise the entry can
+		 * be deleted right away as "Roaming timeout".
+		 */
+		tt_global->roam_at = jiffies;
+
+		/* The flag is claimed via an atomic test-and-set to make sure
+		 * that only a single context announces the roaming
+		 */
+		old_flags = atomic_fetch_or(BATADV_TT_CLIENT_ROAM,
+					    &tt_global->common.flags);
+		if (old_flags & BATADV_TT_CLIENT_ROAM)
+			return;
+	}
+
 	/* These node are probably going to update their tt table */
 	head = &tt_global->orig_list;
 	rcu_read_lock();
@@ -699,16 +720,8 @@ static void batadv_tt_local_add_roam(struct batadv_priv *bat_priv,
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
@@ -736,11 +749,15 @@ bool batadv_tt_local_add(struct net_device *mesh_iface, const u8 *addr,
 	bool roamed_back = false;
 	bool iif_is_wifi = false;
 	int packet_size_max;
+	u8 new_remote_flags;
 	bool ret = false;
 	u8 remote_flags;
 	int hash_added;
 	int table_size;
 	u32 match_mark;
+	u8 clear_flags;
+	u8 set_flags;
+	u16 flags;
 
 	if (ifindex != BATADV_NULL_IFINDEX)
 		in_dev = dev_get_by_index(net, ifindex);
@@ -758,7 +775,9 @@ bool batadv_tt_local_add(struct net_device *mesh_iface, const u8 *addr,
 
 	if (tt_local) {
 		tt_local->last_seen = jiffies;
-		if (tt_local->common.flags & BATADV_TT_CLIENT_PENDING) {
+
+		flags = atomic_read(&tt_local->common.flags);
+		if (flags & BATADV_TT_CLIENT_PENDING) {
 			batadv_dbg(BATADV_DBG_TT, bat_priv,
 				   "Re-adding pending client %pM (vid: %d)\n",
 				   addr, batadv_print_vid(vid));
@@ -767,11 +786,11 @@ bool batadv_tt_local_add(struct net_device *mesh_iface, const u8 *addr,
 			 * this orig_interval. Since it popped up again, the
 			 * flag can be reset like it was never enqueued
 			 */
-			tt_local->common.flags &= ~BATADV_TT_CLIENT_PENDING;
+			atomic_andnot(BATADV_TT_CLIENT_PENDING, &tt_local->common.flags);
 			goto add_event;
 		}
 
-		if (tt_local->common.flags & BATADV_TT_CLIENT_ROAM) {
+		if (flags & BATADV_TT_CLIENT_ROAM) {
 			batadv_dbg(BATADV_DBG_TT, bat_priv,
 				   "Roaming client %pM (vid: %d) came back to its original location\n",
 				   addr, batadv_print_vid(vid));
@@ -780,7 +799,7 @@ bool batadv_tt_local_add(struct net_device *mesh_iface, const u8 *addr,
 			 * that the client popped up again at its original
 			 * location such flag can be unset
 			 */
-			tt_local->common.flags &= ~BATADV_TT_CLIENT_ROAM;
+			atomic_andnot(BATADV_TT_CLIENT_ROAM, &tt_local->common.flags);
 			roamed_back = true;
 		}
 		goto check_roaming;
@@ -817,26 +836,29 @@ bool batadv_tt_local_add(struct net_device *mesh_iface, const u8 *addr,
 		   addr, batadv_print_vid(vid),
 		   (u8)atomic_read(&bat_priv->tt.vn));
 
+	tt_local->common.vid = vid;
+	kref_init(&tt_local->common.refcount);
+	tt_local->last_seen = jiffies;
+	tt_local->common.added_at = tt_local->last_seen;
+	tt_local->vlan = vlan;
+
 	ether_addr_copy(tt_local->common.addr, addr);
 	/* The local entry has to be marked as NEW to avoid to send it in
 	 * a full table response going out before the next ttvn increment
 	 * (consistency check)
 	 */
-	tt_local->common.flags = BATADV_TT_CLIENT_NEW;
-	tt_local->common.vid = vid;
+	flags = BATADV_TT_CLIENT_NEW;
 	if (iif_is_wifi)
-		tt_local->common.flags |= BATADV_TT_CLIENT_WIFI;
-	kref_init(&tt_local->common.refcount);
-	tt_local->last_seen = jiffies;
-	tt_local->common.added_at = tt_local->last_seen;
-	tt_local->vlan = vlan;
+		flags |= BATADV_TT_CLIENT_WIFI;
 
 	/* the batman interface mac and multicast addresses should never be
 	 * purged
 	 */
 	if (batadv_compare_eth(addr, mesh_iface->dev_addr) ||
 	    is_multicast_ether_addr(addr))
-		tt_local->common.flags |= BATADV_TT_CLIENT_NOPURGE;
+		flags |= BATADV_TT_CLIENT_NOPURGE;
+
+	atomic_set(&tt_local->common.flags, flags);
 
 	kref_get(&tt_local->common.refcount);
 	hash_added = batadv_hash_add(bat_priv->tt.local_hash, batadv_compare_tt,
@@ -858,12 +880,14 @@ bool batadv_tt_local_add(struct net_device *mesh_iface, const u8 *addr,
 	/* store the current remote flags before altering them. This helps
 	 * understanding is flags are changing or not
 	 */
-	remote_flags = tt_local->common.flags & BATADV_TT_REMOTE_MASK;
+	remote_flags = atomic_read(&tt_local->common.flags) & BATADV_TT_REMOTE_MASK;
+
+	new_remote_flags = remote_flags;
 
 	if (iif_is_wifi)
-		tt_local->common.flags |= BATADV_TT_CLIENT_WIFI;
+		new_remote_flags |= BATADV_TT_CLIENT_WIFI;
 	else
-		tt_local->common.flags &= ~BATADV_TT_CLIENT_WIFI;
+		new_remote_flags &= ~BATADV_TT_CLIENT_WIFI;
 
 	/* check the mark in the skb: if it's equal to the configured
 	 * isolation_mark, it means the packet is coming from an isolated
@@ -872,14 +896,22 @@ bool batadv_tt_local_add(struct net_device *mesh_iface, const u8 *addr,
 	match_mark = (mark & bat_priv->isolation_mark_mask);
 	if (bat_priv->isolation_mark_mask &&
 	    match_mark == bat_priv->isolation_mark)
-		tt_local->common.flags |= BATADV_TT_CLIENT_ISOLA;
+		new_remote_flags |= BATADV_TT_CLIENT_ISOLA;
 	else
-		tt_local->common.flags &= ~BATADV_TT_CLIENT_ISOLA;
+		new_remote_flags &= ~BATADV_TT_CLIENT_ISOLA;
+
+	set_flags = new_remote_flags & ~remote_flags;
+	if (set_flags)
+		atomic_or(set_flags, &tt_local->common.flags);
+
+	clear_flags = remote_flags & ~new_remote_flags;
+	if (clear_flags)
+		atomic_andnot(clear_flags, &tt_local->common.flags);
 
 	/* if any "dynamic" flag has been modified, resend an ADD event for this
 	 * entry so that all the nodes can get the new flags
 	 */
-	if (remote_flags ^ (tt_local->common.flags & BATADV_TT_REMOTE_MASK))
+	if (set_flags || clear_flags)
 		batadv_tt_local_event(bat_priv, tt_local, BATADV_NO_FLAGS);
 
 	ret = true;
@@ -1204,10 +1236,12 @@ batadv_tt_local_dump_entry(struct sk_buff *msg, u32 portid,
 	struct batadv_meshif_vlan *vlan;
 	unsigned int last_seen_msecs;
 	void *hdr;
+	u16 flags;
 	u32 crc;
 
 	local = container_of(common, struct batadv_tt_local_entry, common);
 	last_seen_msecs = jiffies_to_msecs(jiffies - local->last_seen);
+	flags = atomic_read(&common->flags);
 
 	vlan = batadv_meshif_vlan_get(bat_priv, common->vid);
 	if (!vlan)
@@ -1228,10 +1262,10 @@ batadv_tt_local_dump_entry(struct sk_buff *msg, u32 portid,
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
 
@@ -1359,7 +1393,7 @@ batadv_tt_local_set_pending(struct batadv_priv *bat_priv,
 	 * to be kept in the table in order to send it in a full table
 	 * response issued before the net ttvn increment (consistency check)
 	 */
-	tt_local_entry->common.flags |= BATADV_TT_CLIENT_PENDING;
+	atomic_or(BATADV_TT_CLIENT_PENDING, &tt_local_entry->common.flags);
 
 	batadv_dbg(BATADV_DBG_TT, bat_priv,
 		   "Local tt entry (%pM, vid: %d) pending to be removed: %s\n",
@@ -1390,7 +1424,7 @@ u16 batadv_tt_local_remove(struct batadv_priv *bat_priv, const u8 *addr,
 	if (!tt_local_entry)
 		goto out;
 
-	curr_flags = tt_local_entry->common.flags;
+	curr_flags = atomic_read(&tt_local_entry->common.flags);
 
 	flags = BATADV_TT_CLIENT_DEL;
 	/* if this global entry addition is due to a roaming, the node has to
@@ -1400,14 +1434,22 @@ u16 batadv_tt_local_remove(struct batadv_priv *bat_priv, const u8 *addr,
 	if (roaming) {
 		flags |= BATADV_TT_CLIENT_ROAM;
 		/* mark the local client as ROAMed */
-		tt_local_entry->common.flags |= BATADV_TT_CLIENT_ROAM;
+		atomic_or(BATADV_TT_CLIENT_ROAM, &tt_local_entry->common.flags);
 	}
 
-	if (!(tt_local_entry->common.flags & BATADV_TT_CLIENT_NEW)) {
+	/* This must stay a read-only test while the entry is still hashed:
+	 * clearing the flag here would make a concurrent remover of the same
+	 * entry pick the branch below and mark a not yet committed entry as
+	 * pending. A parallel batadv_tt_local_purge_pending_clients()
+	 * then calls batadv_tt_local_size_dec() for this entry even when
+	 * it was never counted by via batadv_tt_local_set_flags()
+	 */
+	if (!(atomic_read(&tt_local_entry->common.flags) & BATADV_TT_CLIENT_NEW)) {
 		batadv_tt_local_set_pending(bat_priv, tt_local_entry, flags,
 					    message);
 		goto out;
 	}
+
 	/* if this client has been added right now, it is possible to
 	 * immediately purge it
 	 */
@@ -1444,17 +1486,21 @@ static void batadv_tt_local_purge_list(struct batadv_priv *bat_priv,
 	struct batadv_tt_common_entry *tt_common_entry;
 	struct batadv_tt_local_entry *tt_local_entry;
 	struct hlist_node *node_tmp;
+	u16 flags;
 
 	hlist_for_each_entry_safe(tt_common_entry, node_tmp, head,
 				  hash_entry) {
 		tt_local_entry = container_of(tt_common_entry,
 					      struct batadv_tt_local_entry,
 					      common);
-		if (tt_local_entry->common.flags & BATADV_TT_CLIENT_NOPURGE)
+
+		flags = atomic_read(&tt_local_entry->common.flags);
+
+		if (flags & BATADV_TT_CLIENT_NOPURGE)
 			continue;
 
 		/* entry already marked for deletion */
-		if (tt_local_entry->common.flags & BATADV_TT_CLIENT_PENDING)
+		if (flags & BATADV_TT_CLIENT_PENDING)
 			continue;
 
 		if (!batadv_has_timed_out(tt_local_entry->last_seen, timeout))
@@ -1660,6 +1706,8 @@ batadv_tt_global_sync_flags(struct batadv_tt_global_entry *tt_global)
 	struct batadv_tt_orig_list_entry *orig_entry;
 	const struct hlist_head *head;
 	u16 flags = BATADV_NO_FLAGS;
+	int new_flags;
+	int old_flags;
 
 	rcu_read_lock();
 	head = &tt_global->orig_list;
@@ -1667,8 +1715,15 @@ batadv_tt_global_sync_flags(struct batadv_tt_global_entry *tt_global)
 		flags |= orig_entry->flags;
 	rcu_read_unlock();
 
-	flags |= tt_global->common.flags & (~BATADV_TT_SYNC_MASK);
-	tt_global->common.flags = flags;
+	/* replace the sync flags without dropping concurrent modifications of
+	 * the non-sync flags
+	 */
+	old_flags = atomic_read(&tt_global->common.flags);
+	do {
+		new_flags = (old_flags & ~BATADV_TT_SYNC_MASK) | flags;
+		if (new_flags == old_flags)
+			break;
+	} while (!atomic_try_cmpxchg(&tt_global->common.flags, &old_flags, new_flags));
 }
 
 /**
@@ -1751,7 +1806,9 @@ static bool batadv_tt_global_add(struct batadv_priv *bat_priv,
 	struct batadv_tt_common_entry *common;
 	bool ret = false;
 	u16 local_flags;
+	u16 clear_flags;
 	int hash_added;
+	u16 old_flags;
 
 	/* ignore global entries from backbone nodes */
 	if (batadv_bla_is_backbone_gw_orig(bat_priv, orig_node->orig, vid))
@@ -1765,7 +1822,7 @@ static bool batadv_tt_global_add(struct batadv_priv *bat_priv,
 	 * table
 	 */
 	if ((flags & BATADV_TT_CLIENT_TEMP) && tt_local_entry &&
-	    !(tt_local_entry->common.flags & BATADV_TT_CLIENT_NEW))
+	    !(atomic_read(&tt_local_entry->common.flags) & BATADV_TT_CLIENT_NEW))
 		goto out;
 
 	if (!tt_global_entry) {
@@ -1779,7 +1836,7 @@ static bool batadv_tt_global_add(struct batadv_priv *bat_priv,
 		common->vid = vid;
 
 		if (!is_multicast_ether_addr(common->addr))
-			common->flags = flags & (~BATADV_TT_SYNC_MASK);
+			atomic_set(&common->flags, flags & (~BATADV_TT_SYNC_MASK));
 
 		tt_global_entry->roam_at = 0;
 		/* node must store current time in case of roaming. This is
@@ -1808,6 +1865,8 @@ static bool batadv_tt_global_add(struct batadv_priv *bat_priv,
 		}
 	} else {
 		common = &tt_global_entry->common;
+		clear_flags = 0;
+
 		/* If there is already a global entry, we can use this one for
 		 * our processing.
 		 * But if we are trying to add a temporary client then here are
@@ -1819,7 +1878,7 @@ static bool batadv_tt_global_add(struct batadv_priv *bat_priv,
 		 *    originator list and add the new one orig_entry
 		 */
 		if (flags & BATADV_TT_CLIENT_TEMP) {
-			if (!(common->flags & BATADV_TT_CLIENT_TEMP))
+			if (!(atomic_read(&common->flags) & BATADV_TT_CLIENT_TEMP))
 				goto out;
 			if (batadv_tt_global_entry_has_orig(tt_global_entry,
 							    orig_node, NULL))
@@ -1828,24 +1887,26 @@ static bool batadv_tt_global_add(struct batadv_priv *bat_priv,
 			goto add_orig_entry;
 		}
 
+		/* the change can carry possible "attribute" flags like the
+		 * TT_CLIENT_TEMP, therefore they have to be copied in the
+		 * client entry
+		 */
+		if (!is_multicast_ether_addr(common->addr))
+			atomic_or(flags & (~BATADV_TT_SYNC_MASK), &common->flags);
+
+		old_flags = atomic_read(&common->flags);
+
 		/* if the client was temporary added before receiving the first
 		 * OGM announcing it, we have to clear the TEMP flag. Also,
 		 * remove the previous temporary orig node and re-add it
 		 * if required. If the orig entry changed, the new one which
 		 * is a non-temporary entry is preferred.
 		 */
-		if (common->flags & BATADV_TT_CLIENT_TEMP) {
+		if (old_flags & BATADV_TT_CLIENT_TEMP) {
 			batadv_tt_global_del_orig_list(tt_global_entry);
-			common->flags &= ~BATADV_TT_CLIENT_TEMP;
+			clear_flags |= BATADV_TT_CLIENT_TEMP;
 		}
 
-		/* the change can carry possible "attribute" flags like the
-		 * TT_CLIENT_TEMP, therefore they have to be copied in the
-		 * client entry
-		 */
-		if (!is_multicast_ether_addr(common->addr))
-			common->flags |= flags & (~BATADV_TT_SYNC_MASK);
-
 		/* If there is the BATADV_TT_CLIENT_ROAM flag set, there is only
 		 * one originator left in the list and we previously received a
 		 * delete + roaming change for this originator.
@@ -1853,11 +1914,14 @@ static bool batadv_tt_global_add(struct batadv_priv *bat_priv,
 		 * We should first delete the old originator before adding the
 		 * new one.
 		 */
-		if (common->flags & BATADV_TT_CLIENT_ROAM) {
+		if (old_flags & BATADV_TT_CLIENT_ROAM) {
 			batadv_tt_global_del_orig_list(tt_global_entry);
-			common->flags &= ~BATADV_TT_CLIENT_ROAM;
+			clear_flags |= BATADV_TT_CLIENT_ROAM;
 			tt_global_entry->roam_at = 0;
 		}
+
+		if (clear_flags)
+			atomic_andnot(clear_flags, &common->flags);
 	}
 add_orig_entry:
 	/* add the new orig_entry (if needed) or update it */
@@ -1881,13 +1945,15 @@ static bool batadv_tt_global_add(struct batadv_priv *bat_priv,
 	local_flags = batadv_tt_local_remove(bat_priv, tt_addr, vid,
 					     "global tt received",
 					     flags & BATADV_TT_CLIENT_ROAM);
-	tt_global_entry->common.flags |= local_flags & BATADV_TT_CLIENT_WIFI;
+	if (local_flags & BATADV_TT_CLIENT_WIFI)
+		atomic_or(local_flags & BATADV_TT_CLIENT_WIFI,
+			  &tt_global_entry->common.flags);
 
 	if (!(flags & BATADV_TT_CLIENT_ROAM))
 		/* this is a normal global add. Therefore the client is not in a
 		 * roaming state anymore.
 		 */
-		tt_global_entry->common.flags &= ~BATADV_TT_CLIENT_ROAM;
+		atomic_andnot(BATADV_TT_CLIENT_ROAM, &tt_global_entry->common.flags);
 
 out:
 	batadv_tt_global_entry_put(tt_global_entry);
@@ -1957,7 +2023,7 @@ batadv_tt_global_dump_subentry(struct sk_buff *msg, u32 portid, u32 seq,
 			       struct batadv_tt_orig_list_entry *orig,
 			       bool best)
 {
-	u16 flags = (common->flags & (~BATADV_TT_SYNC_MASK)) | orig->flags;
+	u16 flags = (atomic_read(&common->flags) & (~BATADV_TT_SYNC_MASK)) | orig->flags;
 	struct batadv_orig_node_vlan *vlan;
 	u8 last_ttvn;
 	void *hdr;
@@ -2266,7 +2332,7 @@ batadv_tt_global_del_roaming(struct batadv_priv *bat_priv,
 
 	if (last_entry) {
 		/* its the last one, mark for roaming. */
-		tt_global_entry->common.flags |= BATADV_TT_CLIENT_ROAM;
+		atomic_or(BATADV_TT_CLIENT_ROAM, &tt_global_entry->common.flags);
 		tt_global_entry->roam_at = jiffies;
 	} else {
 		/* there is another entry, we can simply delete this
@@ -2414,15 +2480,16 @@ static bool batadv_tt_global_to_purge(struct batadv_tt_global_entry *tt_global,
 {
 	unsigned long roam_timeout = BATADV_TT_CLIENT_ROAM_TIMEOUT;
 	unsigned long temp_timeout = BATADV_TT_CLIENT_TEMP_TIMEOUT;
+	u16 flags = atomic_read(&tt_global->common.flags);
 	bool purge = false;
 
-	if ((tt_global->common.flags & BATADV_TT_CLIENT_ROAM) &&
+	if ((flags & BATADV_TT_CLIENT_ROAM) &&
 	    batadv_has_timed_out(tt_global->roam_at, roam_timeout)) {
 		purge = true;
 		*msg = "Roaming timeout\n";
 	}
 
-	if ((tt_global->common.flags & BATADV_TT_CLIENT_TEMP) &&
+	if ((flags & BATADV_TT_CLIENT_TEMP) &&
 	    batadv_has_timed_out(tt_global->common.added_at, temp_timeout)) {
 		purge = true;
 		*msg = "Temporary client timeout\n";
@@ -2534,13 +2601,16 @@ static bool
 _batadv_is_ap_isolated(struct batadv_tt_local_entry *tt_local_entry,
 		       struct batadv_tt_global_entry *tt_global_entry)
 {
-	if (tt_local_entry->common.flags & BATADV_TT_CLIENT_WIFI &&
-	    tt_global_entry->common.flags & BATADV_TT_CLIENT_WIFI)
+	u16 global_flags = atomic_read(&tt_global_entry->common.flags);
+	u16 local_flags = atomic_read(&tt_local_entry->common.flags);
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
@@ -2573,7 +2643,7 @@ struct batadv_orig_node *batadv_transtable_search(struct batadv_priv *bat_priv,
 	if (src && batadv_vlan_ap_isola_get(bat_priv, vid)) {
 		tt_local_entry = batadv_tt_local_hash_find(bat_priv, src, vid);
 		if (!tt_local_entry ||
-		    (tt_local_entry->common.flags & BATADV_TT_CLIENT_PENDING))
+		    (atomic_read(&tt_local_entry->common.flags) & BATADV_TT_CLIENT_PENDING))
 			goto out;
 	}
 
@@ -2637,6 +2707,7 @@ static u32 batadv_tt_global_crc(struct batadv_priv *bat_priv,
 	struct batadv_tt_common_entry *tt_common;
 	struct batadv_tt_global_entry *tt_global;
 	struct hlist_head *head;
+	u16 entry_flags;
 	__be16 tmp_vid;
 	u32 crc_tmp;
 	u32 crc = 0;
@@ -2657,18 +2728,20 @@ static u32 batadv_tt_global_crc(struct batadv_priv *bat_priv,
 			if (tt_common->vid != vid)
 				continue;
 
+			entry_flags = atomic_read(&tt_common->flags);
+
 			/* Roaming clients are in the global table for
 			 * consistency only. They don't have to be
 			 * taken into account while computing the
 			 * global crc
 			 */
-			if (tt_common->flags & BATADV_TT_CLIENT_ROAM)
+			if (entry_flags & BATADV_TT_CLIENT_ROAM)
 				continue;
 			/* Temporary clients have not been announced yet, so
 			 * they have to be skipped while computing the global
 			 * crc
 			 */
-			if (tt_common->flags & BATADV_TT_CLIENT_TEMP)
+			if (entry_flags & BATADV_TT_CLIENT_TEMP)
 				continue;
 
 			/* find out if this global entry is announced by this
@@ -2717,6 +2790,7 @@ static u32 batadv_tt_local_crc(struct batadv_priv *bat_priv,
 	struct batadv_hashtable *hash = bat_priv->tt.local_hash;
 	struct batadv_tt_common_entry *tt_common;
 	struct hlist_head *head;
+	u16 entry_flags;
 	__be16 tmp_vid;
 	u32 crc_tmp;
 	u32 crc = 0;
@@ -2734,10 +2808,12 @@ static u32 batadv_tt_local_crc(struct batadv_priv *bat_priv,
 			if (tt_common->vid != vid)
 				continue;
 
+			entry_flags = atomic_read(&tt_common->flags);
+
 			/* not yet committed clients have not to be taken into
 			 * account while computing the CRC
 			 */
-			if (tt_common->flags & BATADV_TT_CLIENT_NEW)
+			if (entry_flags & BATADV_TT_CLIENT_NEW)
 				continue;
 
 			/* use network order to read the VID: this ensures that
@@ -2749,7 +2825,7 @@ static u32 batadv_tt_local_crc(struct batadv_priv *bat_priv,
 			/* compute the CRC on flags that have to be kept in sync
 			 * among nodes
 			 */
-			flags = tt_common->flags & BATADV_TT_SYNC_MASK;
+			flags = entry_flags & BATADV_TT_SYNC_MASK;
 			crc_tmp = crc32c(crc_tmp, &flags, sizeof(flags));
 
 			crc ^= crc32c(crc_tmp, tt_common->addr, ETH_ALEN);
@@ -2912,12 +2988,13 @@ static bool batadv_tt_local_valid(const void *entry_ptr,
 				  u8 *flags)
 {
 	const struct batadv_tt_common_entry *tt_common_entry = entry_ptr;
+	u16 entry_flags = atomic_read(&tt_common_entry->flags);
 
-	if (tt_common_entry->flags & BATADV_TT_CLIENT_NEW)
+	if (entry_flags & BATADV_TT_CLIENT_NEW)
 		return false;
 
 	if (flags)
-		*flags = tt_common_entry->flags;
+		*flags = entry_flags;
 
 	return true;
 }
@@ -2941,9 +3018,10 @@ static bool batadv_tt_global_valid(const void *entry_ptr,
 	const struct batadv_tt_common_entry *tt_common_entry = entry_ptr;
 	const struct batadv_tt_global_entry *tt_global_entry;
 	const struct batadv_orig_node *orig_node = data_ptr;
+	u16 entry_flags;
 
-	if (tt_common_entry->flags & BATADV_TT_CLIENT_ROAM ||
-	    tt_common_entry->flags & BATADV_TT_CLIENT_TEMP)
+	entry_flags = atomic_read(&tt_common_entry->flags);
+	if (entry_flags & (BATADV_TT_CLIENT_ROAM | BATADV_TT_CLIENT_TEMP))
 		return false;
 
 	tt_global_entry = container_of(tt_common_entry,
@@ -3598,6 +3676,7 @@ bool batadv_is_my_client(struct batadv_priv *bat_priv, const u8 *addr,
 {
 	struct batadv_tt_local_entry *tt_local_entry;
 	bool ret = false;
+	u16 entry_flags;
 
 	tt_local_entry = batadv_tt_local_hash_find(bat_priv, addr, vid);
 	if (!tt_local_entry)
@@ -3605,8 +3684,8 @@ bool batadv_is_my_client(struct batadv_priv *bat_priv, const u8 *addr,
 	/* Check if the client has been logically deleted (but is kept for
 	 * consistency purpose)
 	 */
-	if ((tt_local_entry->common.flags & BATADV_TT_CLIENT_PENDING) ||
-	    (tt_local_entry->common.flags & BATADV_TT_CLIENT_ROAM))
+	entry_flags = atomic_read(&tt_local_entry->common.flags);
+	if (entry_flags & (BATADV_TT_CLIENT_PENDING | BATADV_TT_CLIENT_ROAM))
 		goto out;
 	ret = true;
 out:
@@ -3877,6 +3956,8 @@ static void batadv_tt_local_transition_new(struct batadv_priv *bat_priv)
 	struct batadv_hashtable *hash = bat_priv->tt.local_hash;
 	struct batadv_tt_common_entry *tt_common_entry;
 	struct hlist_head *head;
+	atomic_t *entry_flags;
+	u16 old_flags;
 	u32 i;
 
 	if (!hash)
@@ -3888,10 +3969,16 @@ static void batadv_tt_local_transition_new(struct batadv_priv *bat_priv)
 		rcu_read_lock();
 		hlist_for_each_entry_rcu(tt_common_entry,
 					 head, hash_entry) {
-			if (!(tt_common_entry->flags & BATADV_TT_CLIENT_NEW))
+			entry_flags = &tt_common_entry->flags;
+			old_flags = atomic_read(entry_flags);
+
+			if (!(old_flags & BATADV_TT_CLIENT_NEW))
 				continue;
 
-			tt_common_entry->flags &= ~BATADV_TT_CLIENT_NEW;
+			old_flags = atomic_fetch_andnot(BATADV_TT_CLIENT_NEW,
+							entry_flags);
+			if (!(old_flags & BATADV_TT_CLIENT_NEW))
+				continue;
 
 			batadv_tt_local_size_inc(bat_priv,
 						 tt_common_entry->vid);
@@ -3928,7 +4015,7 @@ static void batadv_tt_local_purge_pending_clients(struct batadv_priv *bat_priv)
 		spin_lock_bh(list_lock);
 		hlist_for_each_entry_safe(tt_common, node_tmp, head,
 					  hash_entry) {
-			if (!(tt_common->flags & BATADV_TT_CLIENT_PENDING))
+			if (!(atomic_read(&tt_common->flags) & BATADV_TT_CLIENT_PENDING))
 				continue;
 
 			batadv_dbg(BATADV_DBG_TT, bat_priv,
@@ -4141,7 +4228,7 @@ bool batadv_tt_global_client_is_roaming(struct batadv_priv *bat_priv,
 	if (!tt_global_entry)
 		goto out;
 
-	ret = tt_global_entry->common.flags & BATADV_TT_CLIENT_ROAM;
+	ret = atomic_read(&tt_global_entry->common.flags) & BATADV_TT_CLIENT_ROAM;
 	batadv_tt_global_entry_put(tt_global_entry);
 out:
 	return ret;
@@ -4167,7 +4254,7 @@ bool batadv_tt_local_client_is_roaming(struct batadv_priv *bat_priv,
 	if (!tt_local_entry)
 		goto out;
 
-	ret = tt_local_entry->common.flags & BATADV_TT_CLIENT_ROAM;
+	ret = atomic_read(&tt_local_entry->common.flags) & BATADV_TT_CLIENT_ROAM;
 	batadv_tt_local_entry_put(tt_local_entry);
 out:
 	return ret;
@@ -4478,7 +4565,7 @@ bool batadv_tt_global_is_isolated(struct batadv_priv *bat_priv,
 	if (!tt)
 		return false;
 
-	ret = tt->common.flags & BATADV_TT_CLIENT_ISOLA;
+	ret = atomic_read(&tt->common.flags) & BATADV_TT_CLIENT_ISOLA;
 
 	batadv_tt_global_entry_put(tt);
 
diff --git a/net/batman-adv/types.h b/net/batman-adv/types.h
index 9bdc5a3e..d6e15d46 100644
--- a/net/batman-adv/types.h
+++ b/net/batman-adv/types.h
@@ -1852,7 +1852,7 @@ struct batadv_tt_common_entry {
 	struct hlist_node hash_entry;
 
 	/** @flags: various state handling flags (see batadv_tt_client_flags) */
-	u16 flags;
+	atomic_t flags;
 
 	/** @added_at: timestamp used for purging stale tt common entries */
 	unsigned long added_at;

-- 
2.47.3

