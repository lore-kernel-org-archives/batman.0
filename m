Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EA71C54F4C
	for <batman@archiver.kernel.org>; Tue, 28 Jul 2026 14:29:57 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 770C8846D5
	for <batman@archiver.kernel.org>; Tue, 28 Jul 2026 16:29:51 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1785248991;
 b=eFGt+FQlqRYtYVMv/xjQLwwOW210BAHPie2QMIgqHtR3ViKCcwKQgG0w4Y53H/QuZFDSE
 lwb7/Iwf32kLBOijBn390Z58o6ooCKrDwizes07mdSERmbI++gvojHAwyci4lJDeWrQ1vZn
 FHv4J9NB+6e/Y4IRo252WtoIfIYCScc=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1785248991; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=2scb0MMEjb4q0hgIfzPuocbsXIa3fBhKJBpVoVGupFs=;
 b=PXoOvrmKM+2eg8A+mpGSA5fEFHboAuGlfphJNAskTvEyezC2NPPrjR+1Xq8Z7pzXW1rHV
 Gfrefrla4/CvxLO8K36R1lX8uXSMDxNG9n31hBf9jHheG/skFe0Pk2dYU7el7yIfgnOuH6X
 auIiN7FysOOVbX3/X8YpHUmO22IrmXQ=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass header.from=simonwunderlich.de policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=simonwunderlich.de policy.dmarc=none
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id D2F6A846EF
	for <b.a.t.m.a.n@lists.open-mesh.org>; Tue, 28 Jul 2026 15:39:29 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1785245969;
	b=r5eRyMPhSxe/YBeAOyb9OGEmLV9J6EKHroOLDP6o3LjNsKVFhPM04IXR+cR+qo/YRhcVE2
	tzfwWtUe6XtQ0iQXs/truJLk6MkS/rtiNb79mI0QwfHuMdO4szoaq8m5sVO/3vMdKqz1ph
	Pv3CBeri6dgDfzb0a48SpNbB0eocrVU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1785245969;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=2scb0MMEjb4q0hgIfzPuocbsXIa3fBhKJBpVoVGupFs=;
	b=Jzd6BUkse+Hv+J+nf/m9iSPHwxjdA4OxM8xwtL/9Wl88zYf7YSp0e8qgMSDTqdpqptLU4N
	2OBwx5DUPLwYqdfXTC2A95IJrOgT4aj8yAMKj+1jfQ5JNc5xXT01+zLckT3ngmfpgryni/
	sr9qccL4K9bGsb8GV4E4Cr30nAh7gJg=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=simonwunderlich.de header.s=09092022 header.b=oqyMGWs5;
	spf=pass (diktynna.open-mesh.org: domain of sw@simonwunderlich.de designates
 23.88.38.48 as permitted sender) smtp.mailfrom=sw@simonwunderlich.de;
	dmarc=pass (policy=none) header.from=simonwunderlich.de
Received: from kero.packetmixer.de
 (p200300C59717EAd808F168c97E5563A8.dip0.t-ipconnect.de
 [IPv6:2003:c5:9717:ead8:8f1:68c9:7e55:63a8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by mail.simonwunderlich.de (Postfix) with ESMTPSA id 3167AFA15C;
	Tue, 28 Jul 2026 15:39:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1785245969;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2scb0MMEjb4q0hgIfzPuocbsXIa3fBhKJBpVoVGupFs=;
	b=oqyMGWs5eqMClP6V+sHD2rnFj8gx40RJFaF72Vj58ykQA0vSBQJKX3XB81bjKM4XHXOf6u
	YRjc9YoIQ6XUEZynXNwN/Gt2pWunaa0NqpErUZ8voSyCcR9C7rEtrPjp+3zTpRD/Rb4DYz
	HQpBbl3CRh6VWJv/M1ckhBts/AhobTS9fm8BYS0KVOJcpagroxo51KZQ2dR/s2dtKPFPIX
	i/VSy06LiwsYytlBanZMYLt5QwSAnjga66E2yqMzVIIUTQI9+1efYGaDnCxtzKOpfWZNpu
	CvWYUKEag1fxX8w4Uq1mFY/GfLVmti+IW/M+cm57ugRsg7myP0rsJ5cG/MiOZA==
From: Simon Wunderlich <sw@simonwunderlich.de>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	b.a.t.m.a.n@lists.open-mesh.org,
	Sven Eckelmann <sven@narfation.org>,
	Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH net-next 14/15] batman-adv: tt: use atomic flag modifications
Date: Tue, 28 Jul 2026 15:39:17 +0200
Message-ID: <20260728133918.643267-15-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260728133918.643267-1-sw@simonwunderlich.de>
References: <20260728133918.643267-1-sw@simonwunderlich.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: L27NXXJUSJPSXIOXBKWGB37DNWWOKWJ6
X-Message-ID-Hash: L27NXXJUSJPSXIOXBKWGB37DNWWOKWJ6
X-MailFrom: sw@simonwunderlich.de
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/L27NXXJUSJPSXIOXBKWGB37DNWWOKWJ6/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

From: Sven Eckelmann <sven@narfation.org>

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
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/translation-table.c | 246 +++++++++++++++++++----------
 net/batman-adv/types.h             |   2 +-
 2 files changed, 167 insertions(+), 81 deletions(-)

diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index 96bfd5f303c1e..5295e3a59906f 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -424,8 +424,8 @@ static void batadv_tt_local_event(struct batadv_priv *bat_priv,
 				  u8 event_flags)
 {
 	struct batadv_tt_common_entry *common = &tt_local_entry->common;
+	u8 flags = atomic_read(&common->flags) | event_flags;
 	struct batadv_tt_change_node *tt_change_node;
-	u8 flags = common->flags | event_flags;
 	struct batadv_tt_change_node *entry;
 	struct batadv_tt_change_node *safe;
 	bool del_op_requested;
@@ -624,11 +624,16 @@ bool batadv_tt_local_add(struct net_device *mesh_iface, const u8 *addr,
 	bool iif_is_wifi = false;
 	struct hlist_head *head;
 	int packet_size_max;
+	u8 new_remote_flags;
 	bool ret = false;
 	u8 remote_flags;
 	int hash_added;
 	int table_size;
 	u32 match_mark;
+	u8 clear_flags;
+	u16 old_flags;
+	u8 set_flags;
+	u16 flags;
 
 	if (ifindex != BATADV_NULL_IFINDEX)
 		in_dev = dev_get_by_index(net, ifindex);
@@ -646,7 +651,9 @@ bool batadv_tt_local_add(struct net_device *mesh_iface, const u8 *addr,
 
 	if (tt_local) {
 		tt_local->last_seen = jiffies;
-		if (tt_local->common.flags & BATADV_TT_CLIENT_PENDING) {
+
+		flags = atomic_read(&tt_local->common.flags);
+		if (flags & BATADV_TT_CLIENT_PENDING) {
 			batadv_dbg(BATADV_DBG_TT, bat_priv,
 				   "Re-adding pending client %pM (vid: %d)\n",
 				   addr, batadv_print_vid(vid));
@@ -655,11 +662,11 @@ bool batadv_tt_local_add(struct net_device *mesh_iface, const u8 *addr,
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
@@ -668,7 +675,7 @@ bool batadv_tt_local_add(struct net_device *mesh_iface, const u8 *addr,
 			 * that the client popped up again at its original
 			 * location such flag can be unset
 			 */
-			tt_local->common.flags &= ~BATADV_TT_CLIENT_ROAM;
+			atomic_andnot(BATADV_TT_CLIENT_ROAM, &tt_local->common.flags);
 			roamed_back = true;
 		}
 		goto check_roaming;
@@ -705,26 +712,29 @@ bool batadv_tt_local_add(struct net_device *mesh_iface, const u8 *addr,
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
@@ -742,9 +752,17 @@ bool batadv_tt_local_add(struct net_device *mesh_iface, const u8 *addr,
 
 check_roaming:
 	/* Check whether it is a roaming, but don't do anything if the roaming
-	 * process has already been handled
+	 * process has already been handled. The ROAM flag is claimed via an
+	 * atomic test-and-set to make sure that only a single context handles
+	 * the advertisement for a client
 	 */
-	if (tt_global && !(tt_global->common.flags & BATADV_TT_CLIENT_ROAM)) {
+	old_flags = BATADV_TT_CLIENT_ROAM;
+	if (tt_global &&
+	    !(atomic_read(&tt_global->common.flags) & BATADV_TT_CLIENT_ROAM))
+		old_flags = atomic_fetch_or(BATADV_TT_CLIENT_ROAM,
+					    &tt_global->common.flags);
+
+	if (tt_global && !(old_flags & BATADV_TT_CLIENT_ROAM)) {
 		/* These node are probably going to update their tt table */
 		head = &tt_global->orig_list;
 		rcu_read_lock();
@@ -754,27 +772,30 @@ bool batadv_tt_local_add(struct net_device *mesh_iface, const u8 *addr,
 					     orig_entry->orig_node);
 		}
 		rcu_read_unlock();
-		if (roamed_back) {
-			batadv_tt_global_free(bat_priv, tt_global,
-					      "Roaming canceled");
-		} else {
-			/* The global entry has to be marked as ROAMING and
+
+		if (!roamed_back) {
+			/* The global entry was marked as ROAMING and
 			 * has to be kept for consistency purpose
 			 */
-			tt_global->common.flags |= BATADV_TT_CLIENT_ROAM;
 			tt_global->roam_at = jiffies;
 		}
 	}
 
+	/* clean up independent of the roaming advertisement handler */
+	if (tt_global && roamed_back)
+		batadv_tt_global_free(bat_priv, tt_global, "Roaming canceled");
+
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
@@ -783,14 +804,22 @@ bool batadv_tt_local_add(struct net_device *mesh_iface, const u8 *addr,
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
@@ -1115,10 +1144,12 @@ batadv_tt_local_dump_entry(struct sk_buff *msg, u32 portid,
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
@@ -1139,10 +1170,10 @@ batadv_tt_local_dump_entry(struct sk_buff *msg, u32 portid,
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
 
@@ -1270,7 +1301,7 @@ batadv_tt_local_set_pending(struct batadv_priv *bat_priv,
 	 * to be kept in the table in order to send it in a full table
 	 * response issued before the net ttvn increment (consistency check)
 	 */
-	tt_local_entry->common.flags |= BATADV_TT_CLIENT_PENDING;
+	atomic_or(BATADV_TT_CLIENT_PENDING, &tt_local_entry->common.flags);
 
 	batadv_dbg(BATADV_DBG_TT, bat_priv,
 		   "Local tt entry (%pM, vid: %d) pending to be removed: %s\n",
@@ -1296,13 +1327,14 @@ u16 batadv_tt_local_remove(struct batadv_priv *bat_priv, const u8 *addr,
 	struct batadv_tt_local_entry *tt_local_entry;
 	struct hlist_node *tt_removed_node;
 	u16 curr_flags = BATADV_NO_FLAGS;
+	u16 old_flags;
 	u16 flags;
 
 	tt_local_entry = batadv_tt_local_hash_find(bat_priv, addr, vid);
 	if (!tt_local_entry)
 		goto out;
 
-	curr_flags = tt_local_entry->common.flags;
+	curr_flags = atomic_read(&tt_local_entry->common.flags);
 
 	flags = BATADV_TT_CLIENT_DEL;
 	/* if this global entry addition is due to a roaming, the node has to
@@ -1312,10 +1344,12 @@ u16 batadv_tt_local_remove(struct batadv_priv *bat_priv, const u8 *addr,
 	if (roaming) {
 		flags |= BATADV_TT_CLIENT_ROAM;
 		/* mark the local client as ROAMed */
-		tt_local_entry->common.flags |= BATADV_TT_CLIENT_ROAM;
+		atomic_or(BATADV_TT_CLIENT_ROAM, &tt_local_entry->common.flags);
 	}
 
-	if (!(tt_local_entry->common.flags & BATADV_TT_CLIENT_NEW)) {
+	old_flags = atomic_fetch_andnot(BATADV_TT_CLIENT_NEW,
+					&tt_local_entry->common.flags);
+	if (!(old_flags & BATADV_TT_CLIENT_NEW)) {
 		batadv_tt_local_set_pending(bat_priv, tt_local_entry, flags,
 					    message);
 		goto out;
@@ -1358,17 +1392,21 @@ static void batadv_tt_local_purge_list(struct batadv_priv *bat_priv,
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
@@ -1574,6 +1612,8 @@ batadv_tt_global_sync_flags(struct batadv_tt_global_entry *tt_global)
 	struct batadv_tt_orig_list_entry *orig_entry;
 	const struct hlist_head *head;
 	u16 flags = BATADV_NO_FLAGS;
+	int new_flags;
+	int old_flags;
 
 	rcu_read_lock();
 	head = &tt_global->orig_list;
@@ -1581,8 +1621,15 @@ batadv_tt_global_sync_flags(struct batadv_tt_global_entry *tt_global)
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
@@ -1665,7 +1712,9 @@ static bool batadv_tt_global_add(struct batadv_priv *bat_priv,
 	struct batadv_tt_common_entry *common;
 	bool ret = false;
 	u16 local_flags;
+	u16 clear_flags;
 	int hash_added;
+	u16 old_flags;
 
 	/* ignore global entries from backbone nodes */
 	if (batadv_bla_is_backbone_gw_orig(bat_priv, orig_node->orig, vid))
@@ -1679,7 +1728,7 @@ static bool batadv_tt_global_add(struct batadv_priv *bat_priv,
 	 * table
 	 */
 	if ((flags & BATADV_TT_CLIENT_TEMP) && tt_local_entry &&
-	    !(tt_local_entry->common.flags & BATADV_TT_CLIENT_NEW))
+	    !(atomic_read(&tt_local_entry->common.flags) & BATADV_TT_CLIENT_NEW))
 		goto out;
 
 	if (!tt_global_entry) {
@@ -1693,7 +1742,7 @@ static bool batadv_tt_global_add(struct batadv_priv *bat_priv,
 		common->vid = vid;
 
 		if (!is_multicast_ether_addr(common->addr))
-			common->flags = flags & (~BATADV_TT_SYNC_MASK);
+			atomic_set(&common->flags, flags & (~BATADV_TT_SYNC_MASK));
 
 		tt_global_entry->roam_at = 0;
 		/* node must store current time in case of roaming. This is
@@ -1722,6 +1771,8 @@ static bool batadv_tt_global_add(struct batadv_priv *bat_priv,
 		}
 	} else {
 		common = &tt_global_entry->common;
+		clear_flags = 0;
+
 		/* If there is already a global entry, we can use this one for
 		 * our processing.
 		 * But if we are trying to add a temporary client then here are
@@ -1733,7 +1784,7 @@ static bool batadv_tt_global_add(struct batadv_priv *bat_priv,
 		 *    originator list and add the new one orig_entry
 		 */
 		if (flags & BATADV_TT_CLIENT_TEMP) {
-			if (!(common->flags & BATADV_TT_CLIENT_TEMP))
+			if (!(atomic_read(&common->flags) & BATADV_TT_CLIENT_TEMP))
 				goto out;
 			if (batadv_tt_global_entry_has_orig(tt_global_entry,
 							    orig_node, NULL))
@@ -1742,24 +1793,26 @@ static bool batadv_tt_global_add(struct batadv_priv *bat_priv,
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
@@ -1767,11 +1820,14 @@ static bool batadv_tt_global_add(struct batadv_priv *bat_priv,
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
@@ -1795,13 +1851,15 @@ static bool batadv_tt_global_add(struct batadv_priv *bat_priv,
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
@@ -1871,7 +1929,7 @@ batadv_tt_global_dump_subentry(struct sk_buff *msg, u32 portid, u32 seq,
 			       struct batadv_tt_orig_list_entry *orig,
 			       bool best)
 {
-	u16 flags = (common->flags & (~BATADV_TT_SYNC_MASK)) | orig->flags;
+	u16 flags = (atomic_read(&common->flags) & (~BATADV_TT_SYNC_MASK)) | orig->flags;
 	struct batadv_orig_node_vlan *vlan;
 	u8 last_ttvn;
 	void *hdr;
@@ -2180,7 +2238,7 @@ batadv_tt_global_del_roaming(struct batadv_priv *bat_priv,
 
 	if (last_entry) {
 		/* its the last one, mark for roaming. */
-		tt_global_entry->common.flags |= BATADV_TT_CLIENT_ROAM;
+		atomic_or(BATADV_TT_CLIENT_ROAM, &tt_global_entry->common.flags);
 		tt_global_entry->roam_at = jiffies;
 	} else {
 		/* there is another entry, we can simply delete this
@@ -2328,15 +2386,16 @@ static bool batadv_tt_global_to_purge(struct batadv_tt_global_entry *tt_global,
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
@@ -2448,13 +2507,16 @@ static bool
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
@@ -2487,7 +2549,7 @@ struct batadv_orig_node *batadv_transtable_search(struct batadv_priv *bat_priv,
 	if (src && batadv_vlan_ap_isola_get(bat_priv, vid)) {
 		tt_local_entry = batadv_tt_local_hash_find(bat_priv, src, vid);
 		if (!tt_local_entry ||
-		    (tt_local_entry->common.flags & BATADV_TT_CLIENT_PENDING))
+		    (atomic_read(&tt_local_entry->common.flags) & BATADV_TT_CLIENT_PENDING))
 			goto out;
 	}
 
@@ -2551,6 +2613,7 @@ static u32 batadv_tt_global_crc(struct batadv_priv *bat_priv,
 	struct batadv_tt_common_entry *tt_common;
 	struct batadv_tt_global_entry *tt_global;
 	struct hlist_head *head;
+	u16 entry_flags;
 	__be16 tmp_vid;
 	u32 crc_tmp;
 	u32 crc = 0;
@@ -2571,18 +2634,20 @@ static u32 batadv_tt_global_crc(struct batadv_priv *bat_priv,
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
@@ -2631,6 +2696,7 @@ static u32 batadv_tt_local_crc(struct batadv_priv *bat_priv,
 	struct batadv_hashtable *hash = bat_priv->tt.local_hash;
 	struct batadv_tt_common_entry *tt_common;
 	struct hlist_head *head;
+	u16 entry_flags;
 	__be16 tmp_vid;
 	u32 crc_tmp;
 	u32 crc = 0;
@@ -2648,10 +2714,12 @@ static u32 batadv_tt_local_crc(struct batadv_priv *bat_priv,
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
@@ -2663,7 +2731,7 @@ static u32 batadv_tt_local_crc(struct batadv_priv *bat_priv,
 			/* compute the CRC on flags that have to be kept in sync
 			 * among nodes
 			 */
-			flags = tt_common->flags & BATADV_TT_SYNC_MASK;
+			flags = entry_flags & BATADV_TT_SYNC_MASK;
 			crc_tmp = crc32c(crc_tmp, &flags, sizeof(flags));
 
 			crc ^= crc32c(crc_tmp, tt_common->addr, ETH_ALEN);
@@ -2826,12 +2894,13 @@ static bool batadv_tt_local_valid(const void *entry_ptr,
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
@@ -2855,9 +2924,10 @@ static bool batadv_tt_global_valid(const void *entry_ptr,
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
@@ -3512,6 +3582,7 @@ bool batadv_is_my_client(struct batadv_priv *bat_priv, const u8 *addr,
 {
 	struct batadv_tt_local_entry *tt_local_entry;
 	bool ret = false;
+	u16 entry_flags;
 
 	tt_local_entry = batadv_tt_local_hash_find(bat_priv, addr, vid);
 	if (!tt_local_entry)
@@ -3519,8 +3590,8 @@ bool batadv_is_my_client(struct batadv_priv *bat_priv, const u8 *addr,
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
@@ -3795,6 +3866,8 @@ static void batadv_tt_local_set_flags(struct batadv_priv *bat_priv, u16 flags,
 	struct batadv_hashtable *hash = bat_priv->tt.local_hash;
 	struct batadv_tt_common_entry *tt_common_entry;
 	struct hlist_head *head;
+	atomic_t *entry_flags;
+	u16 old_flags;
 	u32 i;
 
 	if (!hash)
@@ -3806,14 +3879,27 @@ static void batadv_tt_local_set_flags(struct batadv_priv *bat_priv, u16 flags,
 		rcu_read_lock();
 		hlist_for_each_entry_rcu(tt_common_entry,
 					 head, hash_entry) {
+			entry_flags = &tt_common_entry->flags;
+			old_flags = atomic_read(entry_flags);
+
+			/* the old_flags value of the atomic test-and-
+			 * set/clear decides whether this entry counts as
+			 * changed.
+			 */
 			if (enable) {
-				if ((tt_common_entry->flags & flags) == flags)
+				if ((old_flags & flags) == flags)
+					continue;
+
+				old_flags = atomic_fetch_or(flags, entry_flags);
+				if ((old_flags & flags) == flags)
 					continue;
-				tt_common_entry->flags |= flags;
 			} else {
-				if (!(tt_common_entry->flags & flags))
+				if (!(old_flags & flags))
+					continue;
+
+				old_flags = atomic_fetch_andnot(flags, entry_flags);
+				if (!(old_flags & flags))
 					continue;
-				tt_common_entry->flags &= ~flags;
 			}
 
 			if (!count)
@@ -3854,7 +3940,7 @@ static void batadv_tt_local_purge_pending_clients(struct batadv_priv *bat_priv)
 		spin_lock_bh(list_lock);
 		hlist_for_each_entry_safe(tt_common, node_tmp, head,
 					  hash_entry) {
-			if (!(tt_common->flags & BATADV_TT_CLIENT_PENDING))
+			if (!(atomic_read(&tt_common->flags) & BATADV_TT_CLIENT_PENDING))
 				continue;
 
 			batadv_dbg(BATADV_DBG_TT, bat_priv,
@@ -4067,7 +4153,7 @@ bool batadv_tt_global_client_is_roaming(struct batadv_priv *bat_priv,
 	if (!tt_global_entry)
 		goto out;
 
-	ret = tt_global_entry->common.flags & BATADV_TT_CLIENT_ROAM;
+	ret = atomic_read(&tt_global_entry->common.flags) & BATADV_TT_CLIENT_ROAM;
 	batadv_tt_global_entry_put(tt_global_entry);
 out:
 	return ret;
@@ -4093,7 +4179,7 @@ bool batadv_tt_local_client_is_roaming(struct batadv_priv *bat_priv,
 	if (!tt_local_entry)
 		goto out;
 
-	ret = tt_local_entry->common.flags & BATADV_TT_CLIENT_ROAM;
+	ret = atomic_read(&tt_local_entry->common.flags) & BATADV_TT_CLIENT_ROAM;
 	batadv_tt_local_entry_put(tt_local_entry);
 out:
 	return ret;
@@ -4403,7 +4489,7 @@ bool batadv_tt_global_is_isolated(struct batadv_priv *bat_priv,
 	if (!tt)
 		return false;
 
-	ret = tt->common.flags & BATADV_TT_CLIENT_ISOLA;
+	ret = atomic_read(&tt->common.flags) & BATADV_TT_CLIENT_ISOLA;
 
 	batadv_tt_global_entry_put(tt);
 
diff --git a/net/batman-adv/types.h b/net/batman-adv/types.h
index 9bdc5a3e799e2..d6e15d467a8f7 100644
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

