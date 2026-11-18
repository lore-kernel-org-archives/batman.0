Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 922B1606A320
	for <batman@archiver.kernel.org>; Wed, 18 Nov 2026 11:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.a=rsa-sha256 header.s=20121 header.b=EArYSJ8Z
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 2466D806CB
	for <batman@archiver.kernel.org>; Wed, 18 Nov 2026 12:45:24 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1795002324;
 b=HlCR5UJ8d9HTHgBawABc75w6B4I0s+ELB0h56FUD5C/bxd5dK5YazFfeAG1px24ScOiJJ
 owocl7mkkB+Ve13qvD10uq4ohUW2GS15ygA2xBwX65yvBEcfQEGmcE1dlpw1SI/xx7/4fAf
 tRncUh4V3TZuJFBWDiDROLSwzHIkt4k=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1795002324; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=+a8rBDrSiRczzjMdAZoWbWl8aJWNJsq2z3BC2+eA5V0=;
 b=uzQ99DBLzH0SAeDdMUB/jjU79JGsQ4dF1N3jltceTLq6CH7Th/MPxtIFogjaLY315A8J/
 l4R9T/yn7/O7p7JIwn94SeZNKDwdt1Oxo8kWHybMkv4xG01nMfNDp6roPnTP0D8IOvsIyje
 NxZ3IUuwX4jSeVjRrr/7ttvyDf3ozzw=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id BAC27842C1
	for <b.a.t.m.a.n@lists.open-mesh.org>; Wed, 18 Nov 2026 12:42:13 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1795002133;
	b=POSA8+DWUDfozZGRTnLn/8fWWNgsp7hwSWwV6FWYMrdkWBbQX+2lpg4j2sjjyELiZz7yDB
	4NIOfd/boMerpr4G4EZRE9boLW/hF4KSjyXyDRy3Rk5jiIsGWl5143FONAZk8FKwQ4mfrt
	6KBb5lft2wuZ4D8eXvnviBDo4kEDuO8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1795002133;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=+a8rBDrSiRczzjMdAZoWbWl8aJWNJsq2z3BC2+eA5V0=;
	b=hRPGQSH+RQ6E14qSGxzMEGiozLAoUjepRT1Eupw3edtKnxdSVJ69tantuCF2/Ff28wODWR
	JO0DURWXnm0P32ElNQ9HWClxgQTfp/xetk8DjSZA2o6TKuGcXAOVJLuwAMo/BbM5mkLoZT
	gfVqAq7rn77QE0p/K/r5V5fO/fsbIBo=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=EArYSJ8Z;
	dmarc=pass (policy=none) header.from=narfation.org;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org
Received: by dvalin.narfation.org (Postfix) id 5CEB11FE9A;
	Wed, 18 Nov 2026 11:42:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1795002133;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+a8rBDrSiRczzjMdAZoWbWl8aJWNJsq2z3BC2+eA5V0=;
	b=EArYSJ8ZfEVxJQItbavGGMIuZ/lpGCqWDqCG9VE2YtPvohgk3EmjRHuK+ZpRRLYYfxfbNa
	VgZiDeuy27wgU5UG4oJN8UdoCB5pCuinTBDLHyubezDNDCuPuubhWAlF0yqPKpISWTKdaD
	uUu82zng93C2DCwaxJ8ZgVNisheR4sU=
From: Sven Eckelmann <sven@narfation.org>
Date: Wed, 18 Nov 2026 12:41:56 +0100
Subject: [PATCH batadv v5 06/11] batman-adv: tt: keep local entry unchanged
 when ADD can't be queued
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261118-tt-avoid-unhashed-event-v5-6-bce9ead803e6@narfation.org>
References: <20261118-tt-avoid-unhashed-event-v5-0-bce9ead803e6@narfation.org>
In-Reply-To: 
 <20261118-tt-avoid-unhashed-event-v5-0-bce9ead803e6@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=12822; i=sven@narfation.org;
 h=from:subject:message-id; bh=JdTSmXECc0p4OG1Nq2KYK60Dvi2BV4Ul32exb1uWW5Q=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFl/+1myTumqr1u7KenyJgXv7EMGCpVXJsQUudz48fik2
 Z2ToVeFOkpYGMS4GGTFFFn2XMk/v5n9rfznaR+PwsxhZQIZwsDFKQATaa5m+PGBU7XjwME5J+bd
 OnH57ZLIu4XBFqctD9la1VckS5ZJfmT4K7I2fMWHs5znHu93nZwZscVu9kId6fnSzw/aXxH+1M8
 eywEA
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: XNXKIPEMLK3ZF3I5LBWSNNRGKI7TSEEZ
X-Message-ID-Hash: XNXKIPEMLK3ZF3I5LBWSNNRGKI7TSEEZ
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/XNXKIPEMLK3ZF3I5LBWSNNRGKI7TSEEZ/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_NONE,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The allocation of a local TT change can fail. __batadv_tt_local_event()
drops the event silently in this case. But the local entry was already
modified at this point: a new entry was inserted, the removal of a pending
entry was cancelled or the flags of the entry were changed. The other nodes
are never informed about this new state and the local table no longer
matches the announced one.

Let __batadv_tt_local_event() report whether the event was stored and only
modify the entry afterwards:

* batadv_tt_local_refresh_locked() prepares the new flags, queues the ADD
  and only then stores the flags in the entry. The entry stays untouched
  when the ADD could not be queued and the refresh is retried with the next
  packet of the client.
* batadv_tt_local_insert() queues the initial ADD before it inserts the
  entry in the hash. Both still happen under the same hash bucket
  list_lock. A new entry is not inserted when its ADD could not be queued
  and batadv_tt_local_add() fails.
* batadv_tt_local_refresh() reports the failed refresh to
  batadv_tt_local_add() which fails too. The caller would otherwise
  continue with an entry which is still in its previous state: the
  multicast code would stop to retry the add of a listener whose entry is
  still pending to be removed and batadv_interface_tx() would forward a
  packet of a client with outdated flags. A client which came back is also
  still marked as BATADV_TT_CLIENT_ROAM. batadv_tt_local_add_roam() is
  therefore skipped. It would otherwise treat the client as newly roamed
  instead of cancelling the roaming.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/translation-table.c | 139 ++++++++++++++++++++++++++-----------
 1 file changed, 98 insertions(+), 41 deletions(-)

diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index ab8b9699..3bb74e05 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -706,10 +706,18 @@ static u16 batadv_tt_flags_get(struct batadv_tt_common_entry *common)
  * Only a single change per client is queued. It describes the latest state of
  * the client and a new event therefore replaces an already queued one.
  *
+ * The other nodes only learn about the modification of a local entry through
+ * the queued change. The caller must therefore not modify the entry in a way
+ * which depends on this change (e.g. hash it as BATADV_TT_CLIENT_NEW or mark it
+ * as BATADV_TT_CLIENT_PENDING) when the event could not be stored.
+ *
  * The caller must hold the flags_lock of @common. The events of an entry are
  * then queued in the same order in which its flags were modified.
+ *
+ * Return: true if the event was stored, false if the memory for it could not
+ * be allocated.
  */
-static void __batadv_tt_local_event(struct batadv_priv *bat_priv,
+static bool __batadv_tt_local_event(struct batadv_priv *bat_priv,
 				    const struct batadv_tt_common_entry *common,
 				    u8 flags)
 	__must_hold(&common->flags_lock)
@@ -724,7 +732,7 @@ static void __batadv_tt_local_event(struct batadv_priv *bat_priv,
 
 	tt_change_node = kmem_cache_alloc(batadv_tt_change_cache, GFP_ATOMIC);
 	if (!tt_change_node)
-		return;
+		return false;
 
 	memset(tt_change_node->change.reserved, 0,
 	       sizeof(tt_change_node->change.reserved));
@@ -771,6 +779,8 @@ static void __batadv_tt_local_event(struct batadv_priv *bat_priv,
 update_changes:
 	WRITE_ONCE(bat_priv->tt.local_changes, changes);
 	spin_unlock_bh(&bat_priv->tt.changes_list_lock);
+
+	return true;
 }
 
 /**
@@ -1019,7 +1029,7 @@ batadv_tt_local_create(struct net_device *mesh_iface, const u8 *addr,
 }
 
 /**
- * batadv_tt_local_refresh_locked() - refresh a hashed local TT entry
+ * batadv_tt_local_refresh_locked() - refresh a local TT entry
  * @bat_priv: the bat priv with all the mesh interface information
  * @tt_local: the local TT entry to refresh
  * @iif_is_wifi: whether the client is connected via a wifi interface
@@ -1033,10 +1043,19 @@ batadv_tt_local_create(struct net_device *mesh_iface, const u8 *addr,
  * updated. An ADD event is queued when @announce is set, the pending removal
  * was cancelled or a flag announced to the other nodes was modified.
  *
+ * The entry is left untouched when the ADD event could not be queued. The
+ * other nodes would otherwise never be informed about the new state. An already
+ * hashed entry is simply refreshed again when the next packet of the client is
+ * received.
+ *
  * The caller must hold the hash bucket list_lock of the entry and must have
- * checked that the entry is still part of the local table.
+ * checked that the entry is still part of the local table or is inserting it
+ * under this list_lock.
+ *
+ * Return: true if the entry was refreshed, false if the required ADD event
+ * could not be queued.
  */
-static void
+static bool
 batadv_tt_local_refresh_locked(struct batadv_priv *bat_priv,
 			       struct batadv_tt_local_entry *tt_local,
 			       bool iif_is_wifi, u32 mark, bool announce,
@@ -1044,51 +1063,49 @@ batadv_tt_local_refresh_locked(struct batadv_priv *bat_priv,
 {
 	struct batadv_tt_common_entry *common = &tt_local->common;
 	struct batadv_hashtable *hash = bat_priv->tt.local_hash;
+	bool readded = false;
+	bool roamed = false;
 	u8 remote_flags;
 	u32 match_mark;
+	u16 flags;
 	u32 i;
 
 	i = batadv_choose_tt(&common->key, hash->size);
 	lockdep_assert_held(&hash->list_locks[i]);
 
 	scoped_guard(spinlock_bh, &common->flags_lock) {
-		if (common->flags & BATADV_TT_CLIENT_PENDING) {
-			batadv_dbg(BATADV_DBG_TT, bat_priv,
-				   "Re-adding pending client %pM (vid: %d)\n",
-				   common->key.addr,
-				   batadv_print_vid(common->key.vid));
+		flags = common->flags;
+
+		if (flags & BATADV_TT_CLIENT_PENDING) {
 			/* whatever the reason why the PENDING flag was set,
 			 * this is a client which was enqueued to be removed in
 			 * this orig_interval. Since it popped up again, the
 			 * flag can be reset like it was never enqueued
 			 */
-			common->flags &= ~BATADV_TT_CLIENT_PENDING;
+			flags &= ~BATADV_TT_CLIENT_PENDING;
+			readded = true;
 			announce = true;
 		}
 
-		if (common->flags & BATADV_TT_CLIENT_ROAM) {
-			batadv_dbg(BATADV_DBG_TT, bat_priv,
-				   "Roaming client %pM (vid: %d) came back to its original location\n",
-				   common->key.addr,
-				   batadv_print_vid(common->key.vid));
+		if (flags & BATADV_TT_CLIENT_ROAM) {
 			/* the ROAM flag is set because this client roamed away
 			 * and the node got a roaming_advertisement message. Now
 			 * that the client popped up again at its original
 			 * location such flag can be unset
 			 */
-			common->flags &= ~BATADV_TT_CLIENT_ROAM;
-			*roamed_back = true;
+			flags &= ~BATADV_TT_CLIENT_ROAM;
+			roamed = true;
 		}
 
 		/* store the current remote flags before altering them. This
 		 * helps understanding is flags are changing or not
 		 */
-		remote_flags = common->flags & BATADV_TT_REMOTE_MASK;
+		remote_flags = flags & BATADV_TT_REMOTE_MASK;
 
 		if (iif_is_wifi)
-			common->flags |= BATADV_TT_CLIENT_WIFI;
+			flags |= BATADV_TT_CLIENT_WIFI;
 		else
-			common->flags &= ~BATADV_TT_CLIENT_WIFI;
+			flags &= ~BATADV_TT_CLIENT_WIFI;
 
 		/* check the mark in the skb: if it's equal to the configured
 		 * isolation_mark, it means the packet is coming from an
@@ -1097,17 +1114,38 @@ batadv_tt_local_refresh_locked(struct batadv_priv *bat_priv,
 		match_mark = (mark & bat_priv->isolation_mark_mask);
 		if (bat_priv->isolation_mark_mask &&
 		    match_mark == bat_priv->isolation_mark)
-			common->flags |= BATADV_TT_CLIENT_ISOLA;
+			flags |= BATADV_TT_CLIENT_ISOLA;
 		else
-			common->flags &= ~BATADV_TT_CLIENT_ISOLA;
+			flags &= ~BATADV_TT_CLIENT_ISOLA;
 
-		if (remote_flags ^ (common->flags & BATADV_TT_REMOTE_MASK))
+		if (remote_flags ^ (flags & BATADV_TT_REMOTE_MASK))
 			announce = true;
 
-		if (announce)
-			__batadv_tt_local_event(bat_priv, common,
-						common->flags);
+		/* queue-then-modify: the new state must not become visible
+		 * without a queued change which commits/announces it
+		 */
+		if (announce &&
+		    !__batadv_tt_local_event(bat_priv, common, flags))
+			return false;
+
+		common->flags = flags;
 	}
+
+	if (readded)
+		batadv_dbg(BATADV_DBG_TT, bat_priv,
+			   "Re-adding pending client %pM (vid: %d)\n",
+			   common->key.addr,
+			   batadv_print_vid(common->key.vid));
+
+	if (roamed) {
+		batadv_dbg(BATADV_DBG_TT, bat_priv,
+			   "Roaming client %pM (vid: %d) came back to its original location\n",
+			   common->key.addr,
+			   batadv_print_vid(common->key.vid));
+		*roamed_back = true;
+	}
+
+	return true;
 }
 
 /**
@@ -1121,8 +1159,11 @@ batadv_tt_local_refresh_locked(struct batadv_priv *bat_priv,
  *
  * See batadv_tt_local_refresh_locked() for the actual refresh.
  *
+ * An entry whose modification could not be announced stays in its previous
+ * state. The refresh is then retried with the next packet of the client.
+ *
  * Return: 0 if the entry was refreshed, -ENOENT if the entry is no longer part
- * of the local table.
+ * of the local table, -ENOMEM if the required ADD event could not be queued.
  */
 static int
 batadv_tt_local_refresh(struct batadv_priv *bat_priv,
@@ -1132,6 +1173,7 @@ batadv_tt_local_refresh(struct batadv_priv *bat_priv,
 	spinlock_t *list_lock; /* protects write access to the hash lists */
 	struct batadv_tt_common_entry *common = &tt_local->common;
 	struct batadv_hashtable *hash = bat_priv->tt.local_hash;
+	int ret = 0;
 	u32 i;
 
 	i = batadv_choose_tt(&common->key, hash->size);
@@ -1147,12 +1189,13 @@ batadv_tt_local_refresh(struct batadv_priv *bat_priv,
 		return -ENOENT;
 	}
 
-	batadv_tt_local_refresh_locked(bat_priv, tt_local, iif_is_wifi, mark,
-				       false, roamed_back);
+	if (!batadv_tt_local_refresh_locked(bat_priv, tt_local, iif_is_wifi,
+					    mark, false, roamed_back))
+		ret = -ENOMEM;
 
 	spin_unlock_bh(list_lock);
 
-	return 0;
+	return ret;
 }
 
 /**
@@ -1164,14 +1207,17 @@ batadv_tt_local_refresh(struct batadv_priv *bat_priv,
  *  any)
  * @roamed_back: set to true when the client returned to its original location
  *
- * The entry is inserted into the local hash and its initial ADD event is
- * queued under the same hash bucket list_lock. A concurrent
- * batadv_tt_local_commit_changes() can therefore not count the entry in the
- * CRC of a ttvn before its ADD was queued and a concurrent
- * batadv_tt_local_remove() can not unhash it before the ADD was queued.
+ * The initial ADD event is queued and the entry is inserted into the local
+ * hash under the same hash bucket list_lock. A concurrent
+ * batadv_tt_local_commit_changes() can therefore not commit the entry without
+ * its ADD (or the ADD without the entry) and a concurrent
+ * batadv_tt_local_remove() can not unhash the entry before the ADD was queued.
+ *
+ * The entry is not inserted when its ADD could not be queued. The other nodes
+ * would otherwise never be informed about the new client.
  *
  * Return: true if the entry was added, false if the client already has an
- * entry in the local table.
+ * entry in the local table or the ADD event could not be queued.
  */
 static bool batadv_tt_local_insert(struct batadv_priv *bat_priv,
 				   struct batadv_tt_local_entry *tt_local,
@@ -1199,15 +1245,18 @@ static bool batadv_tt_local_insert(struct batadv_priv *bat_priv,
 		return false;
 	}
 
+	/* announce the added client to the mesh */
+	if (!batadv_tt_local_refresh_locked(bat_priv, tt_local, iif_is_wifi,
+					    mark, true, roamed_back)) {
+		spin_unlock_bh(list_lock);
+		return false;
+	}
+
 	/* reference for the hash */
 	kref_get(&common->refcount);
 	hlist_add_head_rcu(&common->hash_entry, head);
 	atomic_inc(&hash->generation);
 
-	/* announce the added client to the mesh */
-	batadv_tt_local_refresh_locked(bat_priv, tt_local, iif_is_wifi, mark,
-				       true, roamed_back);
-
 	spin_unlock_bh(list_lock);
 
 	return true;
@@ -1251,6 +1300,14 @@ bool batadv_tt_local_add(struct net_device *mesh_iface, const u8 *addr,
 			/* stale entry which has to be replaced by a new one */
 			batadv_tt_local_entry_put(tt_local);
 			tt_local = NULL;
+		} else if (err) {
+			/* The entry is still in its previous state (e.g.
+			 * pending to be removed). The caller must not treat
+			 * the client as added and the roaming is handled
+			 * together with the refresh which is retried with the
+			 * next packet of the client.
+			 */
+			goto out;
 		}
 	}
 

-- 
2.47.3

