Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C700CA6007
	for <batman@archiver.kernel.org>; Thu,  8 Oct 2026 14:35:05 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 09C6E80D4F
	for <batman@archiver.kernel.org>; Thu, 08 Oct 2026 16:35:04 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1791470104;
 b=OtGYTDEs6CziWkdyB6GrdJL28ouyc+LqeSlxtotUZv1smKARXj08iLe+Ty5NN+TvEUbl7
 zz+Lcto7GVHO5o834waCCdk9TJ14tAQg0VMwaM4CKV+fYMgilzwRmBzBiAEg/bCPrbflto+
 Tze5jRyAnvJoxjyNXbmuJu5dJfU/opM=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1791470104; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=zHd9aiQ/zzTgzTISs8lVwjdf2Aqb7FdY9OnVdx8eaXc=;
 b=oSqUoF/LgviI0pBDCNikHk0d1Hp67exQl3jxMOxuNfqtxka3tMOpjZT8ordm8hyou18OH
 aTI1GrN2Q0wG99jDxPq+oxbJSQKsAFWl+wJMF1ms5rdPbtMHoWS4iuT7LzdOPSnRyjKQoN/
 knmAyU3uS9wISUVGcpDy4Uov+sqQcwY=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 9CE868427E
	for <b.a.t.m.a.n@lists.open-mesh.org>; Thu, 08 Oct 2026 16:30:55 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1791469865;
	b=4Eo+kGt7nLa5jXBexl4/KCLTtggWBqM89x6f3BBfVSzhJu3Bcphr2WEP6JKulwEKvGbMJR
	+1sXE4HEqN+K62Ypai5PTzdQg88UxM07LeyUk9GJK/jeIIfjp+4ETTYdS05KlP53E6x1U6
	N03ICozmF2phw83i9jAsCroDZLq/9hg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1791469865;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=zHd9aiQ/zzTgzTISs8lVwjdf2Aqb7FdY9OnVdx8eaXc=;
	b=gCRCqfPMVc4+VyymA2aVFNIgw2Kllaffpy37JKHeLKAMGv2yY6ERVvm5E7UpNbA8cRNno/
	GFUayJ344bS60xK5Q8AsJwUWpO9A0lqJl2m4cKO+PgcAQOCctHb1Sk/UthdZeRY1mxcMTq
	zRs+Vkw/WsipJKNUfnS4Y7qWRMSiHnI=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=o9Ajr6N0;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id 2549E202AD;
	Thu, 08 Oct 2026 14:30:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1791469855;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zHd9aiQ/zzTgzTISs8lVwjdf2Aqb7FdY9OnVdx8eaXc=;
	b=o9Ajr6N0yJvuQs3epPc0O860c0F+mpTP1bBHMB8pI4sqw6mnzX97Jwx1dMx3cX7uqwTrlE
	U4oWkmufcdKcNqFCCcemvyEN/9HacKl++patEN3aBv3xWfujZWO7RSDoQzVnRaKBn0Mmtc
	sIml7PG5gmPpXLaHXeWjNMYh3wyl+9U=
From: Sven Eckelmann <sven@narfation.org>
Date: Thu, 08 Oct 2026 16:30:13 +0200
Subject: [PATCH batadv v2 8/8] batman-adv: tt: drop ADD+DEL events of never
 announced clients
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261008-tt-avoid-unhashed-event-v2-8-7c4eed81606d@narfation.org>
References: <20261008-tt-avoid-unhashed-event-v2-0-7c4eed81606d@narfation.org>
In-Reply-To: 
 <20261008-tt-avoid-unhashed-event-v2-0-7c4eed81606d@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=7010; i=sven@narfation.org;
 h=from:subject:message-id; bh=d03+wvYQIFTq6ibP4nYDBYtE+Tc1ID4/eAdCaBd6HAI=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFnHV3wUlpu3QTPu4NRw5Q11z7cz5+zV3v1Y8Ixlk87zv
 4Ji0dILO0pZGMS4GGTFFFn2XMk/v5n9rfznaR+PwsxhZQIZwsDFKQATqb/EyDChLvb9Dueu0/XZ
 q6evcCj0c/Qzqb1ZVVNsaKH55CmjsT7D/1KdV5yHd940keTZ8aGx60hr6Ol5/9a3hx+8/zpS6/m
 pXl4A
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: KMAYQ7TSX4BRARNSVCCS3C2ZKUJENQUZ
X-Message-ID-Hash: KMAYQ7TSX4BRARNSVCCS3C2ZKUJENQUZ
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/KMAYQ7TSX4BRARNSVCCS3C2ZKUJENQUZ/>
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
 1 file changed, 44 insertions(+), 37 deletions(-)

diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index f6b50abf..d2eb3744 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -671,22 +671,28 @@ static u16 batadv_tt_flags_get(struct batadv_tt_common_entry *common)
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
 	bool del_op_requested;
+	bool del_op_entry;
 	size_t changes;
 
 	tt_change_node = kmem_cache_alloc(batadv_tt_change_cache, GFP_ATOMIC);
@@ -708,6 +714,7 @@ static void __batadv_tt_local_event(struct batadv_priv *bat_priv,
 		flags &= ~BATADV_TT_CLIENT_ROAM;
 
 	tt_change_node->change.flags = flags;
+	del_op_requested = flags & BATADV_TT_CLIENT_DEL;
 
 	/* check for ADD+DEL, DEL+ADD, ADD+ADD or DEL+DEL events */
 	spin_lock_bh(&bat_priv->tt.changes_list_lock);
@@ -720,12 +727,23 @@ static void __batadv_tt_local_event(struct batadv_priv *bat_priv,
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
@@ -740,23 +758,6 @@ static void __batadv_tt_local_event(struct batadv_priv *bat_priv,
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
@@ -1157,8 +1158,8 @@ batadv_tt_local_refresh(struct batadv_priv *bat_priv,
 			announce = true;
 
 		if (announce)
-			__batadv_tt_local_event(bat_priv, common,
-						common->flags);
+			batadv_tt_local_event(bat_priv, common,
+					      common->flags, false);
 	}
 
 	spin_unlock_bh(list_lock);
@@ -1718,7 +1719,7 @@ batadv_tt_local_set_pending(struct batadv_priv *bat_priv,
 	lockdep_assert_held(&hash->list_locks[i]);
 	lockdep_assert_held(&common->flags_lock);
 
-	__batadv_tt_local_event(bat_priv, common, common->flags | flags);
+	batadv_tt_local_event(bat_priv, common, common->flags | flags, false);
 	common->flags |= BATADV_TT_CLIENT_PENDING;
 
 	batadv_dbg(BATADV_DBG_TT, bat_priv,
@@ -1816,6 +1817,7 @@ batadv_tt_local_remove_now(struct batadv_priv *bat_priv,
 	spinlock_t *list_lock; /* protects write access to the hash lists */
 	struct batadv_tt_common_entry *common = &tt_local_entry->common;
 	struct batadv_hashtable *hash = bat_priv->tt.local_hash;
+	u16 flags;
 	u32 i;
 
 	i = batadv_choose_tt(common, hash->size);
@@ -1832,13 +1834,18 @@ batadv_tt_local_remove_now(struct batadv_priv *bat_priv,
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

