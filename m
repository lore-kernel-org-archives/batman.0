Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6036606A332
	for <batman@archiver.kernel.org>; Mon, 16 Nov 2026 20:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.a=rsa-sha256 header.s=20121 header.b=FZjexhp7
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 771CB843A0
	for <batman@archiver.kernel.org>; Mon, 16 Nov 2026 21:05:11 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1794859511;
 b=v4m48rBBx49kjsT+pqlTuYkc0+oT1WZoUfKwKM7WhJ73gMob6J/+kMPKFJ8JgILJ0EXO9
 WM/+98f6Cwy8YVXmilb0Dvzlf2oT1Tz1oG9ysWrUTGGLHVRXIeAjhDmp7g7woBlcQ9+6+X+
 VZG5LI4RRmM4770SdRhzMocgDYo39J8=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1794859511; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=d7jy0gprNEcFnUByS2OSMOKDyHJ6DQfeFGlGrIgVeM0=;
 b=McJhcP8JKYS94usVYLS9jc5dlUHpEze9SXgcJ/SqOppSMb/GDyVIhKhui/3wClRZ5cem6
 vfLWZ4+HRD/C9mOO44OpEPJwdMXwQrmsKEXKtUcipW7MQ6FtLrQbhn3VK6F9rkxaNJqCTSp
 gbkuD/lUcL0tiO/2OvNp2I7UmvdaOn8=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org
 [IPv6:2a00:17d8:100::8b1])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 5F70282702
	for <b.a.t.m.a.n@lists.open-mesh.org>; Mon, 16 Nov 2026 21:03:25 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1794859415;
	b=R3/zKKu1iec2Rfca/gejo4rFJr7j9D8cFqtW2HVaQQ75xp16C/Y3wmY3icT0CjOLo6ar7d
	q9EoZopJajI7qypA7yZyvLvURljX3mKo9liIqUiyKaGZSoaEazXxeWJgiY88f23F9Bm3YM
	YX+rYbgVcYVCWwgWGAS2D0ETptNUa9c=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1794859415;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=d7jy0gprNEcFnUByS2OSMOKDyHJ6DQfeFGlGrIgVeM0=;
	b=itxFFj+nA8omqKYLj0l2U8JA9OuSV3hfNfXG00pCHd6VHX4dgNjNFD6vh+IxjI2XoEASLZ
	eCm8SflhJ7bd0yreyoe6yNDql62KE7gsbglQYg6pa+q1w/rDrePhoB5m/bN/vGt5fznfqg
	rQtC6K8iV6RVd0jnn2UZwxwSFcIHGio=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=FZjexhp7;
	dmarc=pass (policy=none) header.from=narfation.org;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org
Received: by dvalin.narfation.org (Postfix) id 035D120F6B;
	Mon, 16 Nov 2026 20:03:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1794859405;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=d7jy0gprNEcFnUByS2OSMOKDyHJ6DQfeFGlGrIgVeM0=;
	b=FZjexhp7Ym58o7MXw8aJCF1AOqoNsb1nSGugJlKvTXO5jprHdtwiG8SDzynVElT/VXFV4a
	510BfOBTLCKASi3Zcia5Ng0xW7nrwc6274hU//I9YSqHncyrLZe9bpeyjsR7a9BPzi7WXO
	9OuM0AAk5JTV5YNG9DL/o7du4xp83C0=
From: Sven Eckelmann <sven@narfation.org>
Date: Mon, 16 Nov 2026 21:03:04 +0100
Subject: [PATCH batadv v4 03/11] batman-adv: tt: don't remove unhashed
 local entries
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261116-tt-avoid-unhashed-event-v4-3-42c6bb518123@narfation.org>
References: <20261116-tt-avoid-unhashed-event-v4-0-42c6bb518123@narfation.org>
In-Reply-To: 
 <20261116-tt-avoid-unhashed-event-v4-0-42c6bb518123@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=10077; i=sven@narfation.org;
 h=from:subject:message-id; bh=/vCpAMEe8A54JUrHgQQTCl+fhM/j3ROfsa2CApp4f/k=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFm/E+tmWp/YKlWxkDnz7nop7R3fOoVXpq3jNX9esvvMz
 fmVndcfdpSyMIhxMciKKbLsuZJ/fjP7W/nP0z4ehZnDygQyhIGLUwAmkiTK8E8jLKyD/aG39GVB
 ToFtKjdvW07k5rpVm2/E05M658SjNUIMf8WX+9xlvNFndGNup/HGX90LH9yqflVxxOZd5vJd9+S
 f7OYAAA==
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: OD3K6JKL5AY6N5SRLEUDIJG42T5AASQ4
X-Message-ID-Hash: OD3K6JKL5AY6N5SRLEUDIJG42T5AASQ4
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/OD3K6JKL5AY6N5SRLEUDIJG42T5AASQ4/>
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

batadv_tt_local_remove() looks up the local entry via RCU only.
batadv_tt_local_purge_pending_clients() can unhash it before
batadv_tt_local_mark_removed() acquired the hash bucket list_lock. The DEL
is then queued for a client which is no longer part of the local table (and
its CRC). And it might replace the queued ADD of a new entry which was
added for the same client in the meantime.

The removal of an entry which still carries BATADV_TT_CLIENT_NEW has a
similar problem. The flag is checked by batadv_tt_local_mark_removed() but
the entry is only unhashed by batadv_tt_local_remove_now() after the
list_lock was released. batadv_tt_local_transition_new() can commit the
entry between both steps.

Merge batadv_tt_local_mark_removed() and batadv_tt_local_remove_now() into
batadv_tt_local_remove_entry() to get a single region which is protected by
the list_lock and the flags_lock of the entry:

* An entry which was unhashed after it was looked up is ignored: no DEL is
  queued and BATADV_NO_FLAGS is reported as previous flags.
* An entry which still carries BATADV_TT_CLIENT_NEW is unhashed under the
  list_lock which was used to check this flag.
  batadv_tt_local_transition_new() can therefore no longer commit the entry
  between the check and the removal. The workaround for the local table
  size is no longer needed.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/translation-table.c | 138 +++++++++++++++----------------------
 1 file changed, 56 insertions(+), 82 deletions(-)

diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index a86a4d70..f8678964 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -767,23 +767,6 @@ static void __batadv_tt_local_event(struct batadv_priv *bat_priv,
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
@@ -1667,10 +1650,14 @@ int batadv_tt_local_dump(struct sk_buff *msg, struct netlink_callback *cb)
  * entry. The entry is kept in the local table until the next TTVN increment
  * so that a consistency-check response can still be answered.
  *
- * Next to the flags_lock of the entry, the caller must hold the hash bucket
- * list_lock of @tt_local_entry. Otherwise
- * batadv_tt_local_purge_pending_clients() could remove the entry before its
- * change was queued.
+ * The caller must hold the flags_lock of @tt_local_entry and must not have
+ * released it since it checked that the entry has to be removed. Both the
+ * queue-then-mark order and this single flags_lock section are required.
+ *
+ * The caller must also hold the hash bucket list_lock of @tt_local_entry and
+ * must have ensured that the entry is still part of the local table. A DEL for
+ * an entry which was already purged could otherwise cancel the ADD of a new
+ * entry for the same client.
  */
 static void
 batadv_tt_local_set_pending(struct batadv_priv *bat_priv,
@@ -1696,31 +1683,39 @@ batadv_tt_local_set_pending(struct batadv_priv *bat_priv,
 }
 
 /**
- * batadv_tt_local_mark_removed() - mark a local entry as removed and queue DEL
+ * batadv_tt_local_remove_entry() - logically remove a local entry
  * @bat_priv: the bat priv with all the mesh interface information
- * @tt_local_entry: local TT entry to mark
+ * @tt_local_entry: local TT entry to remove
  * @message: message to append to the log on deletion
  * @roaming: true if the deletion is due to a roaming event
- * @curr_flags: pointer to store the flags of the entry before it was marked
+ * @curr_flags: pointer to store the flags of the entry before it was removed
  *
- * An already announced entry is marked as BATADV_TT_CLIENT_PENDING and the
- * (roamed) DEL change is queued. Both happen under the hash bucket list_lock
- * of the entry to prevent concurrent batadv_tt_local_purge_pending_clients()
- * from removing the entry and batadv_tt_local_transition_new() from clearing
- * BATADV_TT_CLIENT_NEW after it was checked.
+ * For an already announced entry, the (roamed) DEL change is queued and the
+ * entry is marked as BATADV_TT_CLIENT_PENDING by batadv_tt_local_set_pending().
+ * It stays in the local table until the next ttvn increment.
  *
- * Return: true if the entry has to be kept in the local table until the next
- * ttvn increment, false if it can be purged immediately.
+ * An entry which still carries BATADV_TT_CLIENT_NEW was added right after the
+ * last ttvn increment and was not (yet) announced. It is therefore removed
+ * from the local table immediately.
+ *
+ * An entry which was already removed from the local table after it was looked
+ * up is ignored and BATADV_NO_FLAGS is stored in @curr_flags.
+ *
+ * All checks and modifications happen under the hash bucket list_lock and the
+ * flags_lock of the entry. This prevents a concurrent
+ * batadv_tt_local_purge_pending_clients() from removing the entry,
+ * batadv_tt_local_transition_new() from clearing BATADV_TT_CLIENT_NEW and
+ * batadv_tt_local_refresh() from modifying the entry after it was checked.
  */
-static bool
-batadv_tt_local_mark_removed(struct batadv_priv *bat_priv,
+static void
+batadv_tt_local_remove_entry(struct batadv_priv *bat_priv,
 			     struct batadv_tt_local_entry *tt_local_entry,
 			     const char *message, bool roaming, u16 *curr_flags)
 {
 	spinlock_t *list_lock; /* protects write access to the hash lists */
 	struct batadv_tt_common_entry *common = &tt_local_entry->common;
 	struct batadv_hashtable *hash = bat_priv->tt.local_hash;
-	bool pending = false;
+	bool unhashed = false;
 	u16 flags;
 	u32 i;
 
@@ -1729,6 +1724,12 @@ batadv_tt_local_mark_removed(struct batadv_priv *bat_priv,
 
 	spin_lock_bh(list_lock);
 
+	if (hlist_unhashed(&common->hash_entry)) {
+		*curr_flags = BATADV_NO_FLAGS;
+		spin_unlock_bh(list_lock);
+		return;
+	}
+
 	scoped_guard(spinlock_bh, &common->flags_lock) {
 		*curr_flags = common->flags;
 
@@ -1739,8 +1740,23 @@ batadv_tt_local_mark_removed(struct batadv_priv *bat_priv,
 		if (roaming)
 			common->flags |= BATADV_TT_CLIENT_ROAM;
 
-		if (common->flags & BATADV_TT_CLIENT_NEW)
+		if (common->flags & BATADV_TT_CLIENT_NEW) {
+			batadv_dbg(BATADV_DBG_TT, bat_priv,
+				   "Deleting local tt entry (%pM, vid: %d): %s\n",
+				   common->key.addr,
+				   batadv_print_vid(common->key.vid), message);
+
+			hlist_del_init_rcu(&common->hash_entry);
+			atomic_inc(&hash->generation);
+
+			/* The entry was never announced and was therefore
+			 * never counted in the local table size.
+			 */
+			__batadv_tt_local_event(bat_priv, common,
+						common->flags | BATADV_TT_CLIENT_DEL);
+			unhashed = true;
 			break;
+		}
 
 		flags = BATADV_TT_CLIENT_DEL;
 		if (roaming)
@@ -1748,51 +1764,13 @@ batadv_tt_local_mark_removed(struct batadv_priv *bat_priv,
 
 		batadv_tt_local_set_pending(bat_priv, tt_local_entry, flags,
 					    message);
-		pending = true;
 	}
 
 	spin_unlock_bh(list_lock);
 
-	return pending;
-}
-
-/**
- * batadv_tt_local_remove_now() - purge a local entry which was not (yet) announced
- * @bat_priv: the bat priv with all the mesh interface information
- * @tt_local_entry: local TT entry to purge
- *
- * A client which was added right after the last ttvn increment was not (yet)
- * sent to the other nodes. It can therefore be dropped from the local table
- * without waiting for the next ttvn increment.
- *
- * If it was still announced by a parallel context before it was removed from
- * the hash, then the local TT size adjustment will be handled automatically.
- */
-static void
-batadv_tt_local_remove_now(struct batadv_priv *bat_priv,
-			   struct batadv_tt_local_entry *tt_local_entry)
-{
-	struct batadv_tt_common_entry *common = &tt_local_entry->common;
-	struct hlist_node *tt_removed_node;
-
-	/* remove exactly this object when still present in hash */
-	tt_removed_node = batadv_hash_remove(bat_priv->tt.local_hash,
-					     batadv_compare_tt_entry,
-					     batadv_choose_tt, &common->key);
-	if (!tt_removed_node)
-		return;
-
-	batadv_tt_local_event(bat_priv, tt_local_entry, BATADV_TT_CLIENT_DEL);
-
-	/* batadv_tt_local_transition_new() may have committed the entry and
-	 * thus counted it in the local table size since the
-	 * BATADV_TT_CLIENT_NEW check in batadv_tt_local_mark_removed().
-	 */
-	if (!(batadv_tt_flags_get(common) & BATADV_TT_CLIENT_NEW))
-		batadv_tt_local_size_dec(bat_priv, common->key.vid);
-
-	/* drop reference of remove hash entry */
-	batadv_tt_local_entry_put(tt_local_entry);
+	/* drop reference of removed hash entry */
+	if (unhashed)
+		batadv_tt_local_entry_put(tt_local_entry);
 }
 
 /**
@@ -1816,12 +1794,8 @@ u16 batadv_tt_local_remove(struct batadv_priv *bat_priv, const u8 *addr,
 	if (!tt_local_entry)
 		return BATADV_NO_FLAGS;
 
-	/* if this client has been added right now, it is possible to
-	 * immediately purge it
-	 */
-	if (!batadv_tt_local_mark_removed(bat_priv, tt_local_entry, message,
-					  roaming, &curr_flags))
-		batadv_tt_local_remove_now(bat_priv, tt_local_entry);
+	batadv_tt_local_remove_entry(bat_priv, tt_local_entry, message,
+				     roaming, &curr_flags);
 
 	batadv_tt_local_entry_put(tt_local_entry);
 

-- 
2.47.3

