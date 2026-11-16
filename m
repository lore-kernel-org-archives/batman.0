Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05FE7606A33D
	for <batman@archiver.kernel.org>; Mon, 16 Nov 2026 20:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.a=rsa-sha256 header.s=20121 header.b=vkgeBTQu
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 885A680807
	for <batman@archiver.kernel.org>; Mon, 16 Nov 2026 21:07:20 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1794859640;
 b=kskYCcEqKP6fHnS7FCI6VKqoS2ss35omjQUWaw+yVJj5MKSmHXulyDDzNl6m1zdYkYpjK
 UJIm8pLvN+GOVu9dDsLGpWFYTPIi3o30BskPWg0WA2tVh/UXlCTa2RV7Z0ws+PiZd5x+reL
 8TNTMfw1oeGJ/s6OFM3FTeGfhPg+g8E=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1794859640; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=jYbT4TjHCdDkoEyg3oK2uzB/7tUV072SlI4KdPPQ+sE=;
 b=raFMuUlRffYojnxgT8zJVmMaEbMga3LBQ4R/U6IubitvNoyJBWEy08CJ7g1GZhS18lsbO
 JpfRZXO4wUrkbxi5JzMUzyCnI3paQHGRGg2qoBnfE5V+7Fyhze7rzBRf+5Gi9D+KlsUWjZk
 z/YY6uB6CWMicPHYtQ6pQrerpxlu7LU=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 6BF5F84115
	for <b.a.t.m.a.n@lists.open-mesh.org>; Mon, 16 Nov 2026 21:03:31 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1794859421;
	b=DQg8oocya5tA4H6MLLj7cUxUpA3SyCmcxGq1Feum4wsV2e/aqYl47E0XmcXXtLtOyZzh7O
	yPY4SXXMgTIUWJixqhT0J2DVN5p2w9VgQpZZ0sgA8RsyGkcJE0epoZCmBVFMZL2uOwb/gt
	3NVD3LR4ce+gZu2sJrD+cXplH6ZlTo8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1794859421;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=jYbT4TjHCdDkoEyg3oK2uzB/7tUV072SlI4KdPPQ+sE=;
	b=IHGL0jmezGiXdz0HbMzIWHWmkxmfRiEpmvpRW9C3fiiNrzZVq2OJIosCls7Bjtx8+06Dq1
	R4b2E0HuRBzW7O/41CeJmOfWqbXyqn4G3dPHkZmB0cpQbCpxiun72a2DDIgAjM0VdRw3bj
	4P9bLKhPHNXBKr8029bc5tpIyZgu/P0=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=vkgeBTQu;
	dmarc=pass (policy=none) header.from=narfation.org;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org
Received: by dvalin.narfation.org (Postfix) id DFDAF2103D;
	Mon, 16 Nov 2026 20:03:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1794859411;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jYbT4TjHCdDkoEyg3oK2uzB/7tUV072SlI4KdPPQ+sE=;
	b=vkgeBTQu5ZBkXDYeIjGglgIdoHQPeJ7jTNxW/8Tq6m2g6FZCDCpSIYb1C3Q1gYkUTads26
	aNz5y9p7fsutPgnVzHOlBRKTtVi3Zb5XYl0U+Y268g7NY07lsg0voAWWP/X7Fmh7kMTmw2
	QWFEFJ6WKhDnrN6gfe/tLKgvEXX0mMs=
From: Sven Eckelmann <sven@narfation.org>
Date: Mon, 16 Nov 2026 21:03:07 +0100
Subject: [PATCH batadv v4 06/11] batman-adv: tt: keep local entry unchanged
 when ADD can't be queued
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261116-tt-avoid-unhashed-event-v4-6-42c6bb518123@narfation.org>
References: <20261116-tt-avoid-unhashed-event-v4-0-42c6bb518123@narfation.org>
In-Reply-To: 
 <20261116-tt-avoid-unhashed-event-v4-0-42c6bb518123@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=12396; i=sven@narfation.org;
 h=from:subject:message-id; bh=XGwMcc0yUkul3tiqeEAqpaINNVUY+EYA255M8YiGBm8=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFm/E+tmpilPOlO4skrLauEvFkWRv24RWfliU7IdHl1Vv
 LRj65eLHaUsDGJcDLJiiix7ruSf38z+Vv7ztI9HYeawMoEMYeDiFICJnJnByHBXXjz3nusT5ZoO
 zn3ds37ZZNe/tizc+qTg/ekVl2+LqC1j+B/W8OaHtJ7gvVqHl8Xb84tXZMg2Lb3rHP9yw8n+9pN
 dcTwA
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: LWTJULSDMMGLJ3LWZPD2HPQERRAFHUEN
X-Message-ID-Hash: LWTJULSDMMGLJ3LWZPD2HPQERRAFHUEN
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/LWTJULSDMMGLJ3LWZPD2HPQERRAFHUEN/>
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
  batadv_tt_local_add(). A client which came back is still marked as
  BATADV_TT_CLIENT_ROAM in this case. The roaming handling of
  batadv_tt_local_add_roam() is therefore skipped. It would otherwise treat
  the client as newly roamed instead of cancelling the roaming. It is done
  together with the retried refresh.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/translation-table.c | 139 ++++++++++++++++++++++++++-----------
 1 file changed, 98 insertions(+), 41 deletions(-)

diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index 00e22c4c..6fe04996 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -705,8 +705,16 @@ static u16 batadv_tt_flags_get(struct batadv_tt_common_entry *common)
  *
  * Only a single change per client is queued. It describes the latest state of
  * the client and a new event therefore replaces an already queued one.
+ *
+ * The other nodes only learn about the modification of a local entry through
+ * the queued change. The caller must therefore not modify the entry in a way
+ * which depends on this change (e.g. hash it as BATADV_TT_CLIENT_NEW or mark it
+ * as BATADV_TT_CLIENT_PENDING) when the event could not be stored.
+ *
+ * Return: true if the event was stored, false if the memory for it could not
+ * be allocated.
  */
-static void __batadv_tt_local_event(struct batadv_priv *bat_priv,
+static bool __batadv_tt_local_event(struct batadv_priv *bat_priv,
 				    const struct batadv_tt_common_entry *common,
 				    u8 flags)
 {
@@ -718,7 +726,7 @@ static void __batadv_tt_local_event(struct batadv_priv *bat_priv,
 
 	tt_change_node = kmem_cache_alloc(batadv_tt_change_cache, GFP_ATOMIC);
 	if (!tt_change_node)
-		return;
+		return false;
 
 	memset(tt_change_node->change.reserved, 0,
 	       sizeof(tt_change_node->change.reserved));
@@ -765,6 +773,8 @@ static void __batadv_tt_local_event(struct batadv_priv *bat_priv,
 update_changes:
 	WRITE_ONCE(bat_priv->tt.local_changes, changes);
 	spin_unlock_bh(&bat_priv->tt.changes_list_lock);
+
+	return true;
 }
 
 /**
@@ -1013,7 +1023,7 @@ batadv_tt_local_create(struct net_device *mesh_iface, const u8 *addr,
 }
 
 /**
- * batadv_tt_local_refresh_locked() - refresh a hashed local TT entry
+ * batadv_tt_local_refresh_locked() - refresh a local TT entry
  * @bat_priv: the bat priv with all the mesh interface information
  * @tt_local: the local TT entry to refresh
  * @iif_is_wifi: whether the client is connected via a wifi interface
@@ -1027,10 +1037,19 @@ batadv_tt_local_create(struct net_device *mesh_iface, const u8 *addr,
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
@@ -1038,51 +1057,49 @@ batadv_tt_local_refresh_locked(struct batadv_priv *bat_priv,
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
@@ -1091,17 +1108,38 @@ batadv_tt_local_refresh_locked(struct batadv_priv *bat_priv,
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
@@ -1115,8 +1153,11 @@ batadv_tt_local_refresh_locked(struct batadv_priv *bat_priv,
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
@@ -1126,6 +1167,7 @@ batadv_tt_local_refresh(struct batadv_priv *bat_priv,
 	spinlock_t *list_lock; /* protects write access to the hash lists */
 	struct batadv_tt_common_entry *common = &tt_local->common;
 	struct batadv_hashtable *hash = bat_priv->tt.local_hash;
+	int ret = 0;
 	u32 i;
 
 	i = batadv_choose_tt(&common->key, hash->size);
@@ -1141,12 +1183,13 @@ batadv_tt_local_refresh(struct batadv_priv *bat_priv,
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
@@ -1158,14 +1201,17 @@ batadv_tt_local_refresh(struct batadv_priv *bat_priv,
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
@@ -1193,15 +1239,18 @@ static bool batadv_tt_local_insert(struct batadv_priv *bat_priv,
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
@@ -1245,6 +1294,14 @@ bool batadv_tt_local_add(struct net_device *mesh_iface, const u8 *addr,
 			/* stale entry which has to be replaced by a new one */
 			batadv_tt_local_entry_put(tt_local);
 			tt_local = NULL;
+		} else if (err) {
+			/* The client is still part of the local table but its
+			 * entry is in the previous state. The roaming must be
+			 * handled together with the refresh which is retried
+			 * with the next packet of the client.
+			 */
+			ret = true;
+			goto out;
 		}
 	}
 

-- 
2.47.3

