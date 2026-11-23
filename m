Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0961606A330
	for <batman@archiver.kernel.org>; Mon, 23 Nov 2026 17:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=simonwunderlich.de header.i=@simonwunderlich.de header.a=rsa-sha256 header.s=09092022 header.b=xyW3KxaI
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 3BE09858FD
	for <batman@archiver.kernel.org>; Mon, 23 Nov 2026 18:24:18 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1795454658;
 b=O6FbrdvXQH7ht7Wf0Qeg4SegKoWiXVxB+zDHp0+gqoMg8C2jnhQ2gq4gzXPpI7VT595fl
 quJ7KFFxGSjuN2EN7Y9/0p5ASnesec6aUh+vXEJr7Y8mATWzAs8xchtn6FsKogoNz440d1I
 chQr1KN/upOh1gHqvxVTCPN+iZ+oNPg=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1795454658; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=tpFYyxptcmh7W4CKUccpXpjcq340ACbxBl95A5gMgvY=;
 b=ZjjT+qzKBWVcisgB4qS8LwQzerJqCJ87uo52nIVcq9CAbrm8E+dV5BCYRn5KNW6HO6onP
 iBanpJHo7yAJ2c9BQikGSYNKwsJgbbtzq63SdSC6Si1Tnl6/7u8ru84dwdIBlKIfPKtH5BP
 H7rTB61qwt4j4nO6P+6sNxuP5Rm8X+w=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass header.from=simonwunderlich.de policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=simonwunderlich.de policy.dmarc=none
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de
 [IPv6:2a01:4f8:c17:e8c0::1])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id EB15184642
	for <b.a.t.m.a.n@lists.open-mesh.org>; Mon, 23 Nov 2026 18:18:42 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1795454333;
	b=oRMOa+z+Iv2pRcsEb+8li4dxSetRbfWZafUXavm9gr8ab5MpZ3IL42hrMjZWmdz8ca1WHw
	KsmrXFORoZL7WMMc1cPZ9rhqJ0dPm9YrWwrQ1wQdZZhvfk1R9l6CUQF+BZTinryHK5pJjZ
	f0rPn+84H1kb3m0pDiuX4Y55KprtTQU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1795454333;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=tpFYyxptcmh7W4CKUccpXpjcq340ACbxBl95A5gMgvY=;
	b=4H/0VKqttVYr30lFApsCh1siFOpP+IYIlrywYbODeOlHhuKXZiBdaqV1R08qffyQtL99gZ
	z7E1zUP5oFCe2DwBLybytsY1CS+ygh3Uwsl80HxsRz0oiNjBL3Rs56XexSddDdqqsbA8Cm
	W/FQcT6683FjCcPY1fpsKkcnAKPLBk0=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=simonwunderlich.de header.s=09092022 header.b=xyW3KxaI;
	dmarc=pass (policy=none) header.from=simonwunderlich.de;
	spf=pass (diktynna.open-mesh.org: domain of sw@simonwunderlich.de designates
 2a01:4f8:c17:e8c0::1 as permitted sender) smtp.mailfrom=sw@simonwunderlich.de
Received: from kero.packetmixer.de
 (p200300C59714c2E05A704819B6Ba2Db4.dip0.t-ipconnect.de
 [IPv6:2003:c5:9714:c2e0:5a70:4819:b6ba:2db4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by mail.simonwunderlich.de (Postfix) with UTF8SMTPSA id 0E2FCFA3E0;
	Mon, 23 Nov 2026 18:18:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1795454319;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tpFYyxptcmh7W4CKUccpXpjcq340ACbxBl95A5gMgvY=;
	b=xyW3KxaISfDZ+2Q44rhdX1nGXKVyFskxGKg+8YuJslVTHI0FgDRn0+rg28MLFbDsR3pQb/
	TGSG9jAJt9m1hE9fSQ4jtD3XZnErmNm6S/cYpjbC2Uk/S6HEBxl7PGAXH7Dzc4f4eq/Nnz
	lqFm8Dk+I2xKhYN13zMEyPzwF0MEXnsaWnIyZMqWXTvZGIxY+9Tza3SqrMwtgKUrtrpFYS
	C+NzIn3zYiKPQfitRyDqzVWI9/gxJX9/OlWQHm56Sjc1MuI/1Kx/rsBnfy+CxBl8ufvWIm
	GUTHow+NlKvaaLyqpo4142gRx0UHS7hFEHeN6EDUL6hLmoZb0sIvQQjdIyccsw==
From: Simon Wunderlich <sw@simonwunderlich.de>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	b.a.t.m.a.n@lists.open-mesh.org,
	Sven Eckelmann <sven@narfation.org>,
	Sashiko <sashiko-bot@kernel.org>,
	Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH net-next 07/15] batman-adv: tt: don't remove unhashed local
 entries
Date: Mon, 23 Nov 2026 18:18:19 +0100
Message-ID: <20261123171827.3294525-8-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261123171827.3294525-1-sw@simonwunderlich.de>
References: <20261123171827.3294525-1-sw@simonwunderlich.de>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: 2XXF4XGHLO6A5PKOMZLDQRHWBNWRDJEU
X-Message-ID-Hash: 2XXF4XGHLO6A5PKOMZLDQRHWBNWRDJEU
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/2XXF4XGHLO6A5PKOMZLDQRHWBNWRDJEU/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_NONE,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Sven Eckelmann <sven@narfation.org>

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

Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://sashiko.dev/#/bug/linux-c3e34735-5286-4ed0-9338-a77e64fef540
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/translation-table.c | 144 +++++++++++++----------------
 1 file changed, 62 insertions(+), 82 deletions(-)

diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index 63eac1e1c65e..7968931d5d3c 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -652,10 +652,14 @@ static u16 batadv_tt_flags_get(struct batadv_tt_common_entry *common)
  *
  * Only a single change per client is queued. It describes the latest state of
  * the client and a new event therefore replaces an already queued one.
+ *
+ * The caller must hold the flags_lock of @common. The events of an entry are
+ * then queued in the same order in which its flags were modified.
  */
 static void __batadv_tt_local_event(struct batadv_priv *bat_priv,
 				    const struct batadv_tt_common_entry *common,
 				    u8 flags)
+	__must_hold(&common->flags_lock)
 {
 	struct batadv_tt_change_node *tt_change_node;
 	struct batadv_tt_change_node *entry;
@@ -663,6 +667,8 @@ static void __batadv_tt_local_event(struct batadv_priv *bat_priv,
 	bool del_op_requested;
 	size_t changes;
 
+	lockdep_assert_held(&common->flags_lock);
+
 	tt_change_node = kmem_cache_alloc(batadv_tt_change_cache, GFP_ATOMIC);
 	if (!tt_change_node)
 		return;
@@ -714,23 +720,6 @@ static void __batadv_tt_local_event(struct batadv_priv *bat_priv,
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
@@ -1614,10 +1603,14 @@ int batadv_tt_local_dump(struct sk_buff *msg, struct netlink_callback *cb)
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
@@ -1643,31 +1636,39 @@ batadv_tt_local_set_pending(struct batadv_priv *bat_priv,
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
 
@@ -1676,6 +1677,12 @@ batadv_tt_local_mark_removed(struct batadv_priv *bat_priv,
 
 	spin_lock_bh(list_lock);
 
+	if (hlist_unhashed(&common->hash_entry)) {
+		*curr_flags = BATADV_NO_FLAGS;
+		spin_unlock_bh(list_lock);
+		return;
+	}
+
 	scoped_guard(spinlock_bh, &common->flags_lock) {
 		*curr_flags = common->flags;
 
@@ -1686,8 +1693,23 @@ batadv_tt_local_mark_removed(struct batadv_priv *bat_priv,
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
@@ -1695,51 +1717,13 @@ batadv_tt_local_mark_removed(struct batadv_priv *bat_priv,
 
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
@@ -1763,12 +1747,8 @@ u16 batadv_tt_local_remove(struct batadv_priv *bat_priv, const u8 *addr,
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

