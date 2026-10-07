Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79E2CCA5FF1
	for <batman@archiver.kernel.org>; Wed,  7 Oct 2026 10:33:00 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id CF40583E81
	for <batman@archiver.kernel.org>; Wed, 07 Oct 2026 12:32:58 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1791369178;
 b=IyXZcXcw91DBbkpi3kwG6qIDAr+irZn5hJ8cgQcHwflGoFqqDTHA/alJt0xyES6/ceaT8
 bZ30Kfa9EdiCufo+zBP1lCG/ZhIzqDs8dUTsEsFOfvfYRFtsA3zLp2guv52hLjnFr0E23o0
 mCucB5x+3t1Tii35R8s825S7wfI1v+U=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1791369178; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=1SXif/C9JUP5ocgpXi5mgkVIzLBJJa+lM2kGxyvsKmY=;
 b=XiypRrlNtAfpH0OMNeL0j1cs2efRjUZXmCCiiyYwT8C1gqpNTazgqxi9wHZfwFCUWU3YN
 RJfGi0cIgrFf55XA9Za60f+6T5HLQU0zRVwC7GlJ7uXSr2ncOJlWGOw4MLSECXINmTMfGOY
 reSvv6rq+wp9+20rI2mPP3A3xfcw1Ro=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id C8ED583E15
	for <b.a.t.m.a.n@lists.open-mesh.org>; Wed, 07 Oct 2026 12:30:36 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1791369046;
	b=iKuawi37KNvSa3cIwS+cqYRqQnQmfukp2Bb75E/NPJttJxa4KMBVjDL9SU/YOj3wFHRPU9
	2q4x/26moHeqxM4jAtIGYVd3s9DdBEp16m+pLwEVyhXwpHF4dYZUFdxUjWN3VLEHRILi1Q
	l5z0YSf4UIAksnhZUQuARCync8NtYTU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1791369046;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=1SXif/C9JUP5ocgpXi5mgkVIzLBJJa+lM2kGxyvsKmY=;
	b=PUScS3p2Vm7C5u7djQh8hiDplGGY7TsyEu3taUSBtLMQOrTPEznpoht+8OY08LD8WCnz47
	2jZ4ipUl+ItmZQKyAUWyzTZbK0m/4Uk0YtSPKfLJyk7tz/isplzzVSbn82zjovfGUteR32
	NpJhH08MXJPv2xiHQoakmX3MhlHCTTU=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=OMG19BII;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id 746A620C4F;
	Wed, 07 Oct 2026 10:30:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1791369036;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1SXif/C9JUP5ocgpXi5mgkVIzLBJJa+lM2kGxyvsKmY=;
	b=OMG19BIIVau5Qme5pLMcnn48da/y0E7BlZgP6nA0XbAZAJnVYmr8/uRZ1JOsqmd/RdBa/d
	S+kf6s3KtvVxWr4gsOMvXka7SoaKh1dzKT782mXO/z7gwJiPjr0iLkhYGI2hGqeZ0cmID8
	xFHFMTnjH905weixH0f8TpowR+axqaQ=
From: Sven Eckelmann <sven@narfation.org>
Date: Wed, 07 Oct 2026 12:29:48 +0200
Subject: [PATCH batadv 4/4] batman-adv: tt: drop ADD+DEL events of never
 announced clients
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261007-tt-avoid-unhashed-event-v1-4-01c763657916@narfation.org>
References: <20261007-tt-avoid-unhashed-event-v1-0-01c763657916@narfation.org>
In-Reply-To: 
 <20261007-tt-avoid-unhashed-event-v1-0-01c763657916@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=7033; i=sven@narfation.org;
 h=from:subject:message-id; bh=j2Veq4a5AXTT75ghSj3iyU+hQ6Qmkh6uNx7XXPzxCdg=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFnH5FV4Ls47fr6thTc1Ysa0Sb9+P42d8OZa1a99wl2ri
 rzYpXbf6yhlYRDjYpAVU2TZcyX//Gb2t/Kfp308CjOHlQlkCAMXpwBMRKmckeG82rsDLa4XHPjz
 D21nk+ExeigR5nQ9x7vLavMsh00lW8sY/unHPvufON0uNCZb4t1J3oA7IcZX5t+df7WC//qv0Ff
 LvHkB
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: 7DVK22ZWNSCPJD356RPXVAPAAELEA44D
X-Message-ID-Hash: 7DVK22ZWNSCPJD356RPXVAPAAELEA44D
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/7DVK22ZWNSCPJD356RPXVAPAAELEA44D/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

If a detected client was not yet announced, a DEL event can directly drop
the ADD event. The BATADV_TT_CLIENT_NEW flag must be checked to identify
clients which were or were not yet announced.

Since this would be only the case for clients which appeared and directly
disappeared, this behavior must only be triggered by
batadv_tt_local_remove_now().

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/translation-table.c | 81 +++++++++++++++++++++-----------------
 1 file changed, 45 insertions(+), 36 deletions(-)

diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index e8b0de51..984a55cd 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -671,21 +671,28 @@ static u16 batadv_tt_flags_get(struct batadv_tt_common_entry *common)
 }
 
 /**
- * __batadv_tt_local_event() - store a local TT event (ADD/DEL) with given flags
+ * batadv_tt_local_event() - store a local TT event (ADD/DEL) with given flags
  * @bat_priv: the bat priv with all the mesh interface information
  * @common: the TT entry involved in the event
  * @flags: flags of the TT entry combined with the event flags
+ * @cancel_add: whether a DEL may cancel a queued ADD because the entry was
+ *  never announced to the other nodes
  *
  * Only a single change per client is queued. It describes the latest state of
- * the client and a new event therefore replaces an already queued one.
+ * the client and a new event therefore replaces an already queued one. The
+ * only exception is a DEL for an entry which was never announced. It cancels
+ * the ADD of this entry because the other nodes don't need to know anything
+ * about it.
  */
-static void __batadv_tt_local_event(struct batadv_priv *bat_priv,
-				    const struct batadv_tt_common_entry *common,
-				    u8 flags)
+static void batadv_tt_local_event(struct batadv_priv *bat_priv,
+				  const struct batadv_tt_common_entry *common,
+				  u8 flags, bool cancel_add)
 {
 	struct batadv_tt_change_node *tt_change_node;
 	struct batadv_tt_change_node *entry;
 	struct batadv_tt_change_node *safe;
+	bool del_op_requested;
+	bool del_op_entry;
 	size_t changes;
 
 	tt_change_node = kmem_cache_alloc(batadv_tt_change_cache, GFP_ATOMIC);
@@ -698,6 +705,7 @@ static void __batadv_tt_local_event(struct batadv_priv *bat_priv,
 	tt_change_node->change.vid = htons(common->vid);
 
 	tt_change_node->change.flags = flags;
+	del_op_requested = flags & BATADV_TT_CLIENT_DEL;
 
 	/* check for ADD+DEL, DEL+ADD, ADD+ADD or DEL+DEL events */
 	spin_lock_bh(&bat_priv->tt.changes_list_lock);
@@ -710,12 +718,23 @@ static void __batadv_tt_local_event(struct batadv_priv *bat_priv,
 		if (entry->change.vid != tt_change_node->change.vid)
 			continue;
 
-		/* the other nodes may know the client with different
-		 * flags. A DEL+ADD must therefore still announce the
-		 * current flags and an ADD+DEL must still remove the
-		 * client. ADD+ADD and DEL+DEL only update the flags
-		 */
-		entry->change.flags = flags;
+		del_op_entry = entry->change.flags & BATADV_TT_CLIENT_DEL;
+		if (cancel_add && del_op_requested && !del_op_entry) {
+			/* ADD+DEL of a client which was never announced (e.g.
+			 * roaming of a client still in the NEW state) have no
+			 * effect and can be removed
+			 */
+			list_del(&entry->list);
+			kmem_cache_free(batadv_tt_change_cache, entry);
+			changes--;
+		} else {
+			/* the other nodes may know the client with different
+			 * flags. A DEL+ADD must therefore still announce the
+			 * current flags and an ADD+DEL must still remove the
+			 * client. ADD+ADD and DEL+DEL only update the flags
+			 */
+			entry->change.flags = flags;
+		}
 
 		kmem_cache_free(batadv_tt_change_cache, tt_change_node);
 		goto update_changes;
@@ -730,23 +749,6 @@ static void __batadv_tt_local_event(struct batadv_priv *bat_priv,
 	spin_unlock_bh(&bat_priv->tt.changes_list_lock);
 }
 
-/**
- * batadv_tt_local_event() - store a local TT event (ADD/DEL)
- * @bat_priv: the bat priv with all the mesh interface information
- * @tt_local_entry: the TT entry involved in the event
- * @event_flags: flags to store in the event structure
- */
-static void batadv_tt_local_event(struct batadv_priv *bat_priv,
-				  struct batadv_tt_local_entry *tt_local_entry,
-				  u8 event_flags)
-{
-	struct batadv_tt_common_entry *common = &tt_local_entry->common;
-	u8 flags;
-
-	flags = batadv_tt_flags_get(common) | event_flags;
-	__batadv_tt_local_event(bat_priv, common, flags);
-}
-
 /**
  * batadv_tt_entries() - compute the number of entries fitting in tt_len bytes
  * @tt_len: available space
@@ -1145,7 +1147,8 @@ batadv_tt_local_refresh(struct batadv_priv *bat_priv,
 		 */
 		if (announce) {
 			event_flags = common->flags & ~BATADV_TT_CLIENT_ROAM;
-			__batadv_tt_local_event(bat_priv, common, event_flags);
+			batadv_tt_local_event(bat_priv, common, event_flags,
+					      false);
 		}
 	}
 
@@ -1706,7 +1709,7 @@ batadv_tt_local_set_pending(struct batadv_priv *bat_priv,
 	lockdep_assert_held(&hash->list_locks[i]);
 	lockdep_assert_held(&common->flags_lock);
 
-	__batadv_tt_local_event(bat_priv, common, common->flags | flags);
+	batadv_tt_local_event(bat_priv, common, common->flags | flags, false);
 	common->flags |= BATADV_TT_CLIENT_PENDING;
 
 	batadv_dbg(BATADV_DBG_TT, bat_priv,
@@ -1804,6 +1807,7 @@ batadv_tt_local_remove_now(struct batadv_priv *bat_priv,
 	spinlock_t *list_lock; /* protects write access to the hash lists */
 	struct batadv_tt_common_entry *common = &tt_local_entry->common;
 	struct batadv_hashtable *hash = bat_priv->tt.local_hash;
+	u16 flags;
 	u32 i;
 
 	i = batadv_choose_tt(common, hash->size);
@@ -1820,13 +1824,18 @@ batadv_tt_local_remove_now(struct batadv_priv *bat_priv,
 	hlist_del_init_rcu(&common->hash_entry);
 	atomic_inc(&hash->generation);
 
-	batadv_tt_local_event(bat_priv, tt_local_entry, BATADV_TT_CLIENT_DEL);
-
-	/* batadv_tt_local_transition_new() may have committed the entry and
-	 * thus counted it in the local table size since the
-	 * BATADV_TT_CLIENT_NEW check in batadv_tt_local_mark_removed().
+	/* batadv_tt_local_transition_new() clears BATADV_TT_CLIENT_NEW under
+	 * the list_lock. The flags read here therefore show whether the entry
+	 * was committed (and announced) since the BATADV_TT_CLIENT_NEW check
+	 * in batadv_tt_local_mark_removed(). Only the ADD of an entry which
+	 * was never announced can be cancelled by its DEL.
 	 */
-	if (!(batadv_tt_flags_get(common) & BATADV_TT_CLIENT_NEW))
+	flags = batadv_tt_flags_get(common);
+	batadv_tt_local_event(bat_priv, common, flags | BATADV_TT_CLIENT_DEL,
+			      flags & BATADV_TT_CLIENT_NEW);
+
+	/* a committed entry was counted in the local table size */
+	if (!(flags & BATADV_TT_CLIENT_NEW))
 		batadv_tt_local_size_dec(bat_priv, common->vid);
 
 	spin_unlock_bh(list_lock);

-- 
2.47.3

