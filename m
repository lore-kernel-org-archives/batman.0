Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7142606A322
	for <batman@archiver.kernel.org>; Mon, 16 Nov 2026 20:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.a=rsa-sha256 header.s=20121 header.b=rDJIdtLd
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 3560580893
	for <batman@archiver.kernel.org>; Mon, 16 Nov 2026 21:09:33 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1794859773;
 b=tl0kQ8E3JcdeY54dA1RmKB2KyxE9ksZm39TbkWKmAjvPIcr94AfVQSdEDrd/1+/LP/qWn
 UFT0Zk6zRcaid/P+Ql12RIHleIoBe8/1GH/PzBoHqWHLzMLiziR8Ef6O3iKnUphgF+sQ+U9
 muJIIxbo5jHN+Jt9nRJpiCfzgFQwDOI=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1794859773; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=qeJP578SoOOOEePaNlZqDWif6NyH22EC7sfZzZLCOro=;
 b=Q3qOknNhY4TJxCAt8+qRClXILbx2++Ku3SYOIzFf68ECw0Llvm4iT2IoRkVEW9Mbcoh+Q
 tsehpNETJKQHSAzf3Xso8QTokPGSq1aYxyX+kO2Tf7NIARbQiC7mVCnA5REgpuSxTJzUSMS
 p258VPOEeRkYzpbpU3bfG7lF/uyK1tg=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 32F788429D
	for <b.a.t.m.a.n@lists.open-mesh.org>; Mon, 16 Nov 2026 21:03:41 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1794859431;
	b=gESmwYXZow8VKf+d0wohh/0MW4WjLV2JP3tzV9XbRkVtytHhdBzPGGz47QsNvVLiRcxMso
	DEp3kiHICHGNhKKRogVtIbuLbj6hxl07d15dtmdq6FLj7qWPqiICTjujl06cJDLupURBEt
	d5X5IkF3pMbFan/5H0ddkYYsVulKqJ4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1794859431;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=qeJP578SoOOOEePaNlZqDWif6NyH22EC7sfZzZLCOro=;
	b=j3a+iV4XBRwy4SvWJ9RXiei48BICTtdK4FUOkLHMn9nvSr9oztm9AoL10u1D9YwiGRNZ2D
	kfJiTzh1r14A/jLccanwh3Usw1ysToT7oAPnD7SqgvG43ae+oXExJ7yq+8FhwAuwJayC5D
	ijwi5i1ah/eu9vjjV4eQCj+cBdd9+/A=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=rDJIdtLd;
	dmarc=pass (policy=none) header.from=narfation.org;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org
Received: by dvalin.narfation.org (Postfix) id C858A20F67;
	Mon, 16 Nov 2026 20:03:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1794859420;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qeJP578SoOOOEePaNlZqDWif6NyH22EC7sfZzZLCOro=;
	b=rDJIdtLdfbzAdrdWPqOkDKd2x0lIs28bPxplwSdOpjDd4e8vBEIOD7kWNWSJipDASwb+Tw
	LHw6hP7DtsmcOVVXM48hYdRMZzoehg53zs5SHAOwV4nVuuK9N1L3HYuzuJJv43CaCKkLsF
	BB3JuyIXlU+OP7qZOEhVRRnhAM6ZHCA=
From: Sven Eckelmann <sven@narfation.org>
Date: Mon, 16 Nov 2026 21:03:12 +0100
Subject: [PATCH batadv v4 11/11] batman-adv: tt: drop ADD+DEL events of
 never announced clients
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: 
 <20261116-tt-avoid-unhashed-event-v4-11-42c6bb518123@narfation.org>
References: <20261116-tt-avoid-unhashed-event-v4-0-42c6bb518123@narfation.org>
In-Reply-To: 
 <20261116-tt-avoid-unhashed-event-v4-0-42c6bb518123@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=13156; i=sven@narfation.org;
 h=from:subject:message-id; bh=u7RHbydpPYQRMN+/NoMrqM36KfwpICxxNLWGpkTEZYE=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFm/E+sPrYze03Xq9dM94U81fFqDVBbEfvMrud+iP2XOe
 uH0BVdFO0pZGMS4GGTFFFn2XMk/v5n9rfznaR+PwsxhZQIZwsDFKQATuXGCkeFVzMwfnco1/++7
 xwW5vn5170aazfZmSRv5vki/6H+W8qoM//S/zAzftYWBzet/uUqF5JPgCRndE58dTfr2snzVb7Y
 KHjYA
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: 7Y5XYMU5G5WZRNW5YFCX3455IAPHOTGI
X-Message-ID-Hash: 7Y5XYMU5G5WZRNW5YFCX3455IAPHOTGI
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/7Y5XYMU5G5WZRNW5YFCX3455IAPHOTGI/>
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

If a detected client was not yet announced, a DEL event can directly drop
the ADD event. The other nodes never heard about the client and don't need
a DEL for it. The entry can then also be removed from the local table
immediately instead of waiting for the commit of its DEL.

Only the initial ADD queued by batadv_tt_local_insert() can be cancelled.
The BATADV_TT_CLIENT_NEW flag of the entry is not enough to identify such a
change: batadv_tt_local_commit_changes_nolock() takes the queued changes
before it clears this flag. An ADD queued by batadv_tt_local_refresh() in
this window (for example for a changed BATADV_TT_CLIENT_WIFI flag) must
still be announced together with a following DEL because the initial ADD is
already on its way to the other nodes. Each change entry therefore stores
whether it is the initial ADD of its client.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/translation-table.c | 129 +++++++++++++++++++++++++++++--------
 net/batman-adv/types.h             |   7 ++
 2 files changed, 110 insertions(+), 26 deletions(-)

diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index 218e3d26..ebc5b401 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -698,13 +698,20 @@ static u16 batadv_tt_flags_get(struct batadv_tt_common_entry *common)
 }
 
 /**
- * __batadv_tt_local_event() - store a local TT event (ADD/DEL) with given flags
+ * batadv_tt_local_event() - store a local TT event (ADD/DEL) with given flags
  * @bat_priv: the bat priv with all the mesh interface information
  * @common: the TT entry involved in the event
  * @flags: flags of the TT entry combined with the event flags
+ * @initial_add: whether the ADD is the first one of a client which was never
+ *  announced to the other nodes
+ * @cancelled: set to true if a DEL cancelled the initial ADD of the client and
+ *  to false otherwise (optional)
  *
  * Only a single change per client is queued. It describes the latest state of
- * the client and a new event therefore replaces an already queued one.
+ * the client and a new event therefore replaces an already queued one. The
+ * only exception is a DEL for a client whose initial ADD is still queued. The
+ * other nodes don't need to know anything about such a client and the ADD is
+ * cancelled instead.
  *
  * The other nodes only learn about the modification of a local entry through
  * the queued change. The caller must therefore not modify the entry in a way
@@ -713,12 +720,12 @@ static u16 batadv_tt_flags_get(struct batadv_tt_common_entry *common)
  * batadv_tt_local_set_pending(). Its entry is marked as del_unqueued to get the
  * DEL requeued by batadv_tt_local_purge_list().
  *
- * Return: true if the event was stored, false if the memory for it could not
- * be allocated.
+ * Return: true if the event was stored (or cancelled a queued ADD), false if
+ * the memory for it could not be allocated.
  */
-static bool __batadv_tt_local_event(struct batadv_priv *bat_priv,
-				    const struct batadv_tt_common_entry *common,
-				    u8 flags)
+static bool batadv_tt_local_event(struct batadv_priv *bat_priv,
+				  const struct batadv_tt_common_entry *common,
+				  u8 flags, bool initial_add, bool *cancelled)
 {
 	struct batadv_tt_change_node *tt_change_node;
 	struct batadv_tt_change_node *entry;
@@ -726,6 +733,9 @@ static bool __batadv_tt_local_event(struct batadv_priv *bat_priv,
 	bool del_op_requested;
 	size_t changes;
 
+	if (cancelled)
+		*cancelled = false;
+
 	tt_change_node = kmem_cache_alloc(batadv_tt_change_cache, GFP_ATOMIC);
 	if (!tt_change_node)
 		return false;
@@ -745,6 +755,7 @@ static bool __batadv_tt_local_event(struct batadv_priv *bat_priv,
 		flags &= ~BATADV_TT_CLIENT_ROAM;
 
 	tt_change_node->change.flags = flags;
+	tt_change_node->initial_add = initial_add && !del_op_requested;
 
 	/* check for ADD+DEL, DEL+ADD, ADD+ADD or DEL+DEL events */
 	spin_lock_bh(&bat_priv->tt.changes_list_lock);
@@ -757,12 +768,31 @@ static bool __batadv_tt_local_event(struct batadv_priv *bat_priv,
 		if (entry->change.vid != tt_change_node->change.vid)
 			continue;
 
-		/* the other nodes may know the client with different
-		 * flags. A DEL+ADD must therefore still announce the
-		 * current flags and an ADD+DEL must still remove the
-		 * client. ADD+ADD and DEL+DEL only update the flags
-		 */
-		entry->change.flags = flags;
+		if (del_op_requested && entry->initial_add) {
+			/* ADD+DEL of a client which was never announced (e.g.
+			 * roaming of a client still in the NEW state) have no
+			 * effect and can be removed.
+			 */
+			list_del(&entry->list);
+			kmem_cache_free(batadv_tt_change_cache, entry);
+			changes--;
+			if (cancelled)
+				*cancelled = true;
+		} else {
+			/* the other nodes may know the client with different
+			 * flags. A DEL+ADD must therefore still announce the
+			 * current flags and an ADD+DEL must still remove the
+			 * client. ADD+ADD and DEL+DEL only update the flags.
+			 *
+			 * The queued change keeps its initial_add state. An
+			 * ADD which only updates the flags of a still queued
+			 * initial ADD stays cancellable. But an ADD queued
+			 * after the initial ADD was committed (and before the
+			 * entry left the NEW state) must not become
+			 * cancellable.
+			 */
+			entry->change.flags = flags;
+		}
 
 		kmem_cache_free(batadv_tt_change_cache, tt_change_node);
 		goto update_changes;
@@ -1104,6 +1134,10 @@ batadv_tt_local_refresh_needed(struct batadv_tt_local_entry *tt_local,
  * updated. An ADD event is queued when @announce is set, the pending removal
  * was cancelled or a flag announced to the other nodes was modified.
  *
+ * @announce is only set for an entry which is just being inserted. Its ADD is
+ * therefore the initial ADD of a client which was never announced to the other
+ * nodes.
+ *
  * The entry is left untouched when the ADD event could not be queued. The
  * other nodes would otherwise never be informed about the new state. An already
  * hashed entry is simply refreshed again when the next packet of the client is
@@ -1124,6 +1158,7 @@ batadv_tt_local_refresh_locked(struct batadv_priv *bat_priv,
 {
 	struct batadv_tt_common_entry *common = &tt_local->common;
 	struct batadv_hashtable *hash = bat_priv->tt.local_hash;
+	bool initial_add = announce;
 	bool readded = false;
 	bool roamed = false;
 	u8 remote_flags;
@@ -1172,7 +1207,8 @@ batadv_tt_local_refresh_locked(struct batadv_priv *bat_priv,
 		 * without a queued change which commits/announces it
 		 */
 		if (announce &&
-		    !__batadv_tt_local_event(bat_priv, common, flags))
+		    !batadv_tt_local_event(bat_priv, common, flags,
+					   initial_add, NULL))
 			return false;
 
 		common->flags = flags;
@@ -1886,6 +1922,11 @@ int batadv_tt_local_dump(struct sk_buff *msg, struct netlink_callback *cb)
  * retry it. Such an entry is marked as del_unqueued instead. It stays in the
  * local table until batadv_tt_local_purge_list() was able to queue its DEL.
  *
+ * A client whose initial ADD is still queued was never announced to the other
+ * nodes. Its DEL cancels the ADD and the entry is removed from the local table
+ * right away. The caller has to drop the hash reference of the entry after it
+ * released the flags_lock.
+ *
  * The caller must hold the flags_lock of @tt_local_entry and must not have
  * released it since it checked that the entry has to be removed. Both the
  * queue-then-mark order and this single flags_lock section are required.
@@ -1894,8 +1935,11 @@ int batadv_tt_local_dump(struct sk_buff *msg, struct netlink_callback *cb)
  * must have ensured that the entry is still part of the local table. A DEL for
  * an entry which was already purged could otherwise cancel the ADD of a new
  * entry for the same client.
+ *
+ * Return: true if the entry was removed from the local table instead of being
+ * marked as pending, false otherwise.
  */
-static void
+static bool
 batadv_tt_local_set_pending(struct batadv_priv *bat_priv,
 			    struct batadv_tt_local_entry *tt_local_entry,
 			    u16 flags, const char *message)
@@ -1903,6 +1947,7 @@ batadv_tt_local_set_pending(struct batadv_priv *bat_priv,
 {
 	struct batadv_tt_common_entry *common = &tt_local_entry->common;
 	struct batadv_hashtable *hash = bat_priv->tt.local_hash;
+	bool cancelled;
 	bool queued;
 	u32 i;
 
@@ -1910,8 +1955,23 @@ batadv_tt_local_set_pending(struct batadv_priv *bat_priv,
 	lockdep_assert_held(&hash->list_locks[i]);
 	lockdep_assert_held(&common->flags_lock);
 
-	queued = __batadv_tt_local_event(bat_priv, common,
-					 common->flags | flags);
+	queued = batadv_tt_local_event(bat_priv, common, common->flags | flags,
+				       false, &cancelled);
+	if (cancelled) {
+		batadv_dbg(BATADV_DBG_TT, bat_priv,
+			   "Deleting local tt entry (%pM, vid: %d): %s\n",
+			   tt_local_entry->common.key.addr,
+			   batadv_print_vid(tt_local_entry->common.key.vid),
+			   message);
+
+		/* The entry was never announced and was therefore never
+		 * counted in the local table size.
+		 */
+		hlist_del_init_rcu(&common->hash_entry);
+		atomic_inc(&hash->generation);
+
+		return true;
+	}
 
 	/* a failed attempt must not hide the still queued DEL of an already
 	 * pending entry
@@ -1927,6 +1987,8 @@ batadv_tt_local_set_pending(struct batadv_priv *bat_priv,
 		   "Local tt entry (%pM, vid: %d) pending to be removed: %s\n",
 		   tt_local_entry->common.key.addr,
 		   batadv_print_vid(tt_local_entry->common.key.vid), message);
+
+	return false;
 }
 
 /**
@@ -1943,6 +2005,9 @@ batadv_tt_local_set_pending(struct batadv_priv *bat_priv,
  * also applies to an entry which still carries BATADV_TT_CLIENT_NEW because its
  * ADD might already have been taken for the next ttvn.
  *
+ * Only an entry whose initial ADD is still queued is removed from the local
+ * table immediately. Nothing was announced about it to the other nodes.
+ *
  * An entry which was already removed from the local table after it was looked
  * up is ignored and BATADV_NO_FLAGS is stored in @curr_flags.
  *
@@ -1959,6 +2024,7 @@ batadv_tt_local_remove_entry(struct batadv_priv *bat_priv,
 	spinlock_t *list_lock; /* protects write access to the hash lists */
 	struct batadv_tt_common_entry *common = &tt_local_entry->common;
 	struct batadv_hashtable *hash = bat_priv->tt.local_hash;
+	bool unhashed = false;
 	u16 flags;
 	u32 i;
 
@@ -1987,11 +2053,15 @@ batadv_tt_local_remove_entry(struct batadv_priv *bat_priv,
 		if (roaming)
 			flags |= BATADV_TT_CLIENT_ROAM;
 
-		batadv_tt_local_set_pending(bat_priv, tt_local_entry, flags,
-					    message);
+		unhashed = batadv_tt_local_set_pending(bat_priv, tt_local_entry,
+						       flags, message);
 	}
 
 	spin_unlock_bh(list_lock);
+
+	/* drop reference of removed hash entry */
+	if (unhashed)
+		batadv_tt_local_entry_put(tt_local_entry);
 }
 
 /**
@@ -2040,6 +2110,8 @@ static void batadv_tt_local_purge_list(struct batadv_priv *bat_priv,
 
 	hlist_for_each_entry_safe(tt_common_entry, node_tmp, head,
 				  hash_entry) {
+		bool unhashed = false;
+
 		tt_local_entry = container_of(tt_common_entry,
 					      struct batadv_tt_local_entry,
 					      common);
@@ -2049,10 +2121,10 @@ static void batadv_tt_local_purge_list(struct batadv_priv *bat_priv,
 			if (tt_local_entry->common.flags & BATADV_TT_CLIENT_PENDING) {
 				/* but its removal must still be announced */
 				if (tt_local_entry->del_unqueued)
-					batadv_tt_local_set_pending(bat_priv,
-								    tt_local_entry,
-								    BATADV_TT_CLIENT_DEL,
-								    "requeued");
+					unhashed = batadv_tt_local_set_pending(bat_priv,
+									       tt_local_entry,
+									       BATADV_TT_CLIENT_DEL,
+									       "requeued");
 				break;
 			}
 
@@ -2063,10 +2135,15 @@ static void batadv_tt_local_purge_list(struct batadv_priv *bat_priv,
 						  timeout))
 				break;
 
-			batadv_tt_local_set_pending(bat_priv, tt_local_entry,
-						    BATADV_TT_CLIENT_DEL,
-						    "timed out");
+			unhashed = batadv_tt_local_set_pending(bat_priv,
+							       tt_local_entry,
+							       BATADV_TT_CLIENT_DEL,
+							       "timed out");
 		}
+
+		/* drop reference of removed hash entry */
+		if (unhashed)
+			batadv_tt_local_entry_put(tt_local_entry);
 	}
 }
 
diff --git a/net/batman-adv/types.h b/net/batman-adv/types.h
index d443143f..0a2db658 100644
--- a/net/batman-adv/types.h
+++ b/net/batman-adv/types.h
@@ -2005,6 +2005,13 @@ struct batadv_tt_change_node {
 
 	/** @change: holds the actual translation table diff data */
 	struct batadv_tvlv_tt_change change;
+
+	/**
+	 * @initial_add: the change is the initial ADD of a client which was
+	 *  never announced to the other nodes. A DEL of this client cancels
+	 *  the change instead of being queued
+	 */
+	bool initial_add:1;
 };
 
 /**

-- 
2.47.3

