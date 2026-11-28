Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9298E606A31C
	for <batman@archiver.kernel.org>; Sat, 28 Nov 2026 09:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=narfation.org header.i=@narfation.org header.a=rsa-sha256 header.s=20121 header.b=VCSPOC6z
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id DBD9084138
	for <batman@archiver.kernel.org>; Sat, 28 Nov 2026 10:23:35 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1795857815;
 b=dkCSC0zU/koYURcHqg5oc7ZNyK3nq3lp0lrplfMzANaGmk96VyOpvHVTFMT/9j/11XtXD
 dRs3bHjFpWVYXNYILsJ+OQfNmXb/91xd+1FZYSAjZ2aDCXCi89RjHTWp64JF3jteB3cGgY5
 4Ocm6jfhANNsJ7Y5cn325iOuVXKVEyU=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1795857815; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=EMH8rzZsc/Td3uLP579SRjkY5McernkaAmRLvYvhY6Q=;
 b=CO3wkgfT7ycgEdeFTlhHR5TMkVUyr19MGV07b8JOSPiWBBjb0aH0AVtWed07WjSEzn8Sb
 VJThvkXN66ZThgHqSJLw0GaKJREycHvqZEARmJx40uboTzQBL2AYiL7neXLb4/tFLvSCATj
 aDZnubd4cLace3vpaksr0nvFJaLDhKw=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 00BE181079
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sat, 28 Nov 2026 10:23:16 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1795857808;
	b=G3hJFqFAuzoHP+VmC8K+b0WhqfjzAEYntDcVEsJ1xJbXKXRv3oLask5QF/M/cWQ94NLa5D
	4MceBFcSRVgJicJvzY1dwnYM8Zte38SjbzMxwHgSYPCPCMmHlZzv86x12ao1Ci2W0WIhPC
	6gvXXP/PdxofKP0YvzOahQXRzIgqgbk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1795857808;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:dkim-signature;
	bh=EMH8rzZsc/Td3uLP579SRjkY5McernkaAmRLvYvhY6Q=;
	b=QftT5O7g0OXFEzQE2X8pg86bniAZoSjAfTKbIO7PZCdAX8EYtNYteBJ16BwQSEWyFSyd0+
	scRkO0cpsZKPYusHNcyf3hQ7F5IXyzAWKhv+lvxCXXRlki1DCnQQIzdYs3S/b1FboWx6LV
	ie7DfigGIs/pPMuJ0bXWYN3EnT+hHGE=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=VCSPOC6z;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id C8D0020462;
	Sat, 28 Nov 2026 09:23:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1795857795;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=EMH8rzZsc/Td3uLP579SRjkY5McernkaAmRLvYvhY6Q=;
	b=VCSPOC6zxTqLlmQFGQCJjgScK7x4d9iglJPmZPxa0Yse8qypeukBIKqVPWFeV1yNfKiiw7
	p0RuC7AxY2yoBmkHh6MpWs7oqaxYa+WC6cHaxHCTxL4wQ6AJC3MRAfaFxl8zY1yMy0Xd1D
	A9qYf2PQn7OGYUMfiTqEHZCMvKYvfac=
From: Sven Eckelmann <sven@narfation.org>
Date: Sat, 28 Nov 2026 10:23:05 +0100
Subject: [PATCH batadv] Revert "batman-adv: tt: drop ADD+DEL events of
 never announced clients"
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: 
 <20261128-revert-tt-add-del-cancellation-v1-1-e75c1c37a6bd@narfation.org>
X-B4-Tracking: v=1; b=H4sIAHidCmsC/yWNwQrCMBBEf6Xs2YUmliL+injY7G41EqIk2yKU/
 ntTPb5h5s0KVUvUCtduhaJLrPGdG7hTB/yk/FCM0hh870fn/AVbSYuhGZIIiiZkyqwpkbUpDv0
 4nXVgT0GgST5Fp/j9HdwgkJEscP/ndQ4vZTvssG072ow40IoAAAA=
X-Change-ID: 20261128-revert-tt-add-del-cancellation-406f3e4c2abd
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sashiko <sashiko-bot@kernel.org>, Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=14091; i=sven@narfation.org;
 h=from:subject:message-id; bh=zghPH56RrRiPGB8r9GjXOIzZxguaMws+o+gsvJ3Ij8o=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDNlcc2v09i2J51qxKObhTU5LGTXW59H3Wya9eiG0VNu14
 q7HhcCujlIWBjEuBlkxRZY9V/LPb2Z/K/952sejMHNYmUCGMHBxCsBELgozMhx+mPjW1j9hmcO6
 8F16taaR7tt4lJfzmqx+JHny1FKtJw6MDDMuSwv3en5Y//tLNsOlmRk/EgM9ZKZqPeX587ByGlt
 MKScA
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: 66FPQKYGBMSC7GHMSJUDD2SBZ4FZ4EAL
X-Message-ID-Hash: 66FPQKYGBMSC7GHMSJUDD2SBZ4FZ4EAL
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/66FPQKYGBMSC7GHMSJUDD2SBZ4FZ4EAL/>
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

This reverts commit abd17f89684301a4b2fdfccb4717c6ee55017dd0.

The reverted commit assumed that the other nodes never heard about a
client whose initial ADD is still queued. This is wrong for a roamed
client. The previous originator already got a ROAMING_ADV when the local
entry was inserted:

 Node A                                 Node C (previous originator)
 batadv_tt_local_add()
 |-queues the initial ADD of X
 \-batadv_tt_local_add_roam()
   \-batadv_send_roam_adv()
                                        global X->A with
                                        BATADV_TT_CLIENT_ROAM
 batadv_tt_local_remove()
 \-batadv_tt_local_remove_entry()
   |-sets BATADV_TT_CLIENT_ROAM
   | (only when roaming)
   \-batadv_tt_local_set_pending()
     Initial ADD is cancelled.
     Entry is unhashed right away.
     No DEL is announced.

Cancelling the ADD has two effects for such a client:

* The BATADV_TT_CLIENT_ROAM mark of the local entry is lost together
  with the entry. batadv_tt_local_client_is_roaming() no longer finds
  it. batadv_check_unicast_ttvn() then delivers unicast packets for the
  client locally instead of rerouting them until the next commit.

* Node C never receives a DEL for X. If X->A on C still carries
  BATADV_TT_CLIENT_ROAM, the stale global entry is only removed after
  BATADV_TT_CLIENT_ROAM_TIMEOUT (600 seconds).

Avoiding this requires a lot more special corner case handling and still
doesn't completely solve the problem. The minimal TVLV TT changelist space
benefits of a cancelled ADD+DEL is by far outweighted by the additional
work required and the potential desync between the nodes.

A DEL should therefore only replace an ADD but not drop the announcements
of both operations.

Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261123171827.3294525-1-sw%40simonwunderlich.de?part=15
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/translation-table.c | 119 ++++++++-----------------------------
 net/batman-adv/types.h             |   7 ---
 2 files changed, 26 insertions(+), 100 deletions(-)

diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index e08bf88b..6102bdf6 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -704,20 +704,13 @@ static u16 batadv_tt_flags_get(struct batadv_tt_common_entry *common)
 }
 
 /**
- * batadv_tt_local_event() - store a local TT event (ADD/DEL) with given flags
+ * __batadv_tt_local_event() - store a local TT event (ADD/DEL) with given flags
  * @bat_priv: the bat priv with all the mesh interface information
  * @common: the TT entry involved in the event
  * @flags: flags of the TT entry combined with the event flags
- * @initial_add: whether the ADD is the first one of a client which was never
- *  announced to the other nodes
- * @cancelled: set to true if a DEL cancelled the initial ADD of the client and
- *  to false otherwise (optional)
  *
  * Only a single change per client is queued. It describes the latest state of
- * the client and a new event therefore replaces an already queued one. The
- * only exception is a DEL for a client whose initial ADD is still queued. The
- * other nodes don't need to know anything about such a client and the ADD is
- * cancelled instead.
+ * the client and a new event therefore replaces an already queued one.
  *
  * The other nodes only learn about the modification of a local entry through
  * the queued change. The caller must therefore not modify the entry in a way
@@ -729,12 +722,12 @@ static u16 batadv_tt_flags_get(struct batadv_tt_common_entry *common)
  * The caller must hold the flags_lock of @common. The events of an entry are
  * then queued in the same order in which its flags were modified.
  *
- * Return: true if the event was stored (or cancelled a queued ADD), false if
- * the memory for it could not be allocated.
+ * Return: true if the event was stored, false if the memory for it could not
+ * be allocated.
  */
-static bool batadv_tt_local_event(struct batadv_priv *bat_priv,
-				  const struct batadv_tt_common_entry *common,
-				  u8 flags, bool initial_add, bool *cancelled)
+static bool __batadv_tt_local_event(struct batadv_priv *bat_priv,
+				    const struct batadv_tt_common_entry *common,
+				    u8 flags)
 	__must_hold(&common->flags_lock)
 {
 	struct batadv_tt_change_node *tt_change_node;
@@ -745,9 +738,6 @@ static bool batadv_tt_local_event(struct batadv_priv *bat_priv,
 
 	lockdep_assert_held(&common->flags_lock);
 
-	if (cancelled)
-		*cancelled = false;
-
 	tt_change_node = kmem_cache_alloc(batadv_tt_change_cache, GFP_ATOMIC);
 	if (!tt_change_node)
 		return false;
@@ -767,7 +757,6 @@ static bool batadv_tt_local_event(struct batadv_priv *bat_priv,
 		flags &= ~BATADV_TT_CLIENT_ROAM;
 
 	tt_change_node->change.flags = flags;
-	tt_change_node->initial_add = initial_add && !del_op_requested;
 
 	/* check for ADD+DEL, DEL+ADD, ADD+ADD or DEL+DEL events */
 	spin_lock_bh(&bat_priv->tt.changes_list_lock);
@@ -780,31 +769,12 @@ static bool batadv_tt_local_event(struct batadv_priv *bat_priv,
 		if (entry->change.vid != tt_change_node->change.vid)
 			continue;
 
-		if (del_op_requested && entry->initial_add) {
-			/* ADD+DEL of a client which was never announced (e.g.
-			 * roaming of a client still in the NEW state) have no
-			 * effect and can be removed.
-			 */
-			list_del(&entry->list);
-			kmem_cache_free(batadv_tt_change_cache, entry);
-			changes--;
-			if (cancelled)
-				*cancelled = true;
-		} else {
-			/* the other nodes may know the client with different
-			 * flags. A DEL+ADD must therefore still announce the
-			 * current flags and an ADD+DEL must still remove the
-			 * client. ADD+ADD and DEL+DEL only update the flags.
-			 *
-			 * The queued change keeps its initial_add state. An
-			 * ADD which only updates the flags of a still queued
-			 * initial ADD stays cancellable. But an ADD queued
-			 * after the initial ADD was committed (and before the
-			 * entry left the NEW state) must not become
-			 * cancellable.
-			 */
-			entry->change.flags = flags;
-		}
+		/* the other nodes may know the client with different
+		 * flags. A DEL+ADD must therefore still announce the
+		 * current flags and an ADD+DEL must still remove the
+		 * client. ADD+ADD and DEL+DEL only update the flags
+		 */
+		entry->change.flags = flags;
 
 		kmem_cache_free(batadv_tt_change_cache, tt_change_node);
 		goto update_changes;
@@ -1146,10 +1116,6 @@ batadv_tt_local_refresh_needed(struct batadv_tt_local_entry *tt_local,
  * updated. An ADD event is queued when @announce is set, the pending removal
  * was cancelled or a flag announced to the other nodes was modified.
  *
- * @announce is only set for an entry which is just being inserted. Its ADD is
- * therefore the initial ADD of a client which was never announced to the other
- * nodes.
- *
  * The entry is left untouched when the ADD event could not be queued. The
  * other nodes would otherwise never be informed about the new state. An already
  * hashed entry is simply refreshed again when the next packet of the client is
@@ -1170,7 +1136,6 @@ batadv_tt_local_refresh_locked(struct batadv_priv *bat_priv,
 {
 	struct batadv_tt_common_entry *common = &tt_local->common;
 	struct batadv_hashtable *hash = bat_priv->tt.local_hash;
-	bool initial_add = announce;
 	bool readded = false;
 	bool roamed = false;
 	u8 remote_flags;
@@ -1219,8 +1184,7 @@ batadv_tt_local_refresh_locked(struct batadv_priv *bat_priv,
 		 * without a queued change which commits/announces it
 		 */
 		if (announce &&
-		    !batadv_tt_local_event(bat_priv, common, flags,
-					   initial_add, NULL))
+		    !__batadv_tt_local_event(bat_priv, common, flags))
 			return false;
 
 		common->flags = flags;
@@ -1972,11 +1936,6 @@ static void batadv_tt_local_unhash(struct batadv_priv *bat_priv,
  * retry it. Such an entry is marked as del_unqueued instead. It stays in the
  * local table until batadv_tt_local_purge_list() was able to queue its DEL.
  *
- * A client whose initial ADD is still queued was never announced to the other
- * nodes. Its DEL cancels the ADD and the entry is removed from the local table
- * right away. The caller has to drop the hash reference of the entry after it
- * released the flags_lock.
- *
  * The caller must hold the flags_lock of @tt_local_entry and must not have
  * released it since it checked that the entry has to be removed. Both the
  * queue-then-mark order and this single flags_lock section are required.
@@ -1985,11 +1944,8 @@ static void batadv_tt_local_unhash(struct batadv_priv *bat_priv,
  * must have ensured that the entry is still part of the local table. A DEL for
  * an entry which was already purged could otherwise cancel the ADD of a new
  * entry for the same client.
- *
- * Return: true if the entry was removed from the local table instead of being
- * marked as pending, false otherwise.
  */
-static bool
+static void
 batadv_tt_local_set_pending(struct batadv_priv *bat_priv,
 			    struct batadv_tt_local_entry *tt_local_entry,
 			    u16 flags, const char *message)
@@ -1997,7 +1953,6 @@ batadv_tt_local_set_pending(struct batadv_priv *bat_priv,
 {
 	struct batadv_tt_common_entry *common = &tt_local_entry->common;
 	struct batadv_hashtable *hash = bat_priv->tt.local_hash;
-	bool cancelled;
 	bool queued;
 	u32 i;
 
@@ -2005,13 +1960,8 @@ batadv_tt_local_set_pending(struct batadv_priv *bat_priv,
 	lockdep_assert_held(&hash->list_locks[i]);
 	lockdep_assert_held(&common->flags_lock);
 
-	queued = batadv_tt_local_event(bat_priv, common, common->flags | flags,
-				       false, &cancelled);
-	if (cancelled) {
-		/* the entry was never announced */
-		batadv_tt_local_unhash(bat_priv, tt_local_entry, message);
-		return true;
-	}
+	queued = __batadv_tt_local_event(bat_priv, common,
+					 common->flags | flags);
 
 	/* a failed attempt must not hide the still queued DEL of an already
 	 * pending entry
@@ -2027,8 +1977,6 @@ batadv_tt_local_set_pending(struct batadv_priv *bat_priv,
 		   "Local tt entry (%pM, vid: %d) pending to be removed: %s\n",
 		   tt_local_entry->common.key.addr,
 		   batadv_print_vid(tt_local_entry->common.key.vid), message);
-
-	return false;
 }
 
 /**
@@ -2045,9 +1993,6 @@ batadv_tt_local_set_pending(struct batadv_priv *bat_priv,
  * also applies to an entry which still carries BATADV_TT_CLIENT_NEW because its
  * ADD might already have been taken for the next ttvn.
  *
- * Only an entry whose initial ADD is still queued is removed from the local
- * table immediately. Nothing was announced about it to the other nodes.
- *
  * An entry which was already removed from the local table after it was looked
  * up is ignored and BATADV_NO_FLAGS is stored in @curr_flags.
  *
@@ -2064,7 +2009,6 @@ batadv_tt_local_remove_entry(struct batadv_priv *bat_priv,
 	spinlock_t *list_lock; /* protects write access to the hash lists */
 	struct batadv_tt_common_entry *common = &tt_local_entry->common;
 	struct batadv_hashtable *hash = bat_priv->tt.local_hash;
-	bool unhashed = false;
 	u16 flags;
 	u32 i;
 
@@ -2093,15 +2037,11 @@ batadv_tt_local_remove_entry(struct batadv_priv *bat_priv,
 		if (roaming)
 			flags |= BATADV_TT_CLIENT_ROAM;
 
-		unhashed = batadv_tt_local_set_pending(bat_priv, tt_local_entry,
-						       flags, message);
+		batadv_tt_local_set_pending(bat_priv, tt_local_entry, flags,
+					    message);
 	}
 
 	spin_unlock_bh(list_lock);
-
-	/* drop reference of removed hash entry */
-	if (unhashed)
-		batadv_tt_local_entry_put(tt_local_entry);
 }
 
 /**
@@ -2150,8 +2090,6 @@ static void batadv_tt_local_purge_list(struct batadv_priv *bat_priv,
 
 	hlist_for_each_entry_safe(tt_common_entry, node_tmp, head,
 				  hash_entry) {
-		bool unhashed = false;
-
 		tt_local_entry = container_of(tt_common_entry,
 					      struct batadv_tt_local_entry,
 					      common);
@@ -2161,10 +2099,10 @@ static void batadv_tt_local_purge_list(struct batadv_priv *bat_priv,
 			if (tt_local_entry->common.flags & BATADV_TT_CLIENT_PENDING) {
 				/* but its removal must still be announced */
 				if (tt_local_entry->del_unqueued)
-					unhashed = batadv_tt_local_set_pending(bat_priv,
-									       tt_local_entry,
-									       BATADV_TT_CLIENT_DEL,
-									       "requeued");
+					batadv_tt_local_set_pending(bat_priv,
+								    tt_local_entry,
+								    BATADV_TT_CLIENT_DEL,
+								    "requeued");
 				break;
 			}
 
@@ -2175,15 +2113,10 @@ static void batadv_tt_local_purge_list(struct batadv_priv *bat_priv,
 						  timeout))
 				break;
 
-			unhashed = batadv_tt_local_set_pending(bat_priv,
-							       tt_local_entry,
-							       BATADV_TT_CLIENT_DEL,
-							       "timed out");
+			batadv_tt_local_set_pending(bat_priv, tt_local_entry,
+						    BATADV_TT_CLIENT_DEL,
+						    "timed out");
 		}
-
-		/* drop reference of removed hash entry */
-		if (unhashed)
-			batadv_tt_local_entry_put(tt_local_entry);
 	}
 }
 
diff --git a/net/batman-adv/types.h b/net/batman-adv/types.h
index 0a2db658..d443143f 100644
--- a/net/batman-adv/types.h
+++ b/net/batman-adv/types.h
@@ -2005,13 +2005,6 @@ struct batadv_tt_change_node {
 
 	/** @change: holds the actual translation table diff data */
 	struct batadv_tvlv_tt_change change;
-
-	/**
-	 * @initial_add: the change is the initial ADD of a client which was
-	 *  never announced to the other nodes. A DEL of this client cancels
-	 *  the change instead of being queued
-	 */
-	bool initial_add:1;
 };
 
 /**

---
base-commit: 11431b38d0cd787a2e988416e7086dc1cf225055
change-id: 20261128-revert-tt-add-del-cancellation-406f3e4c2abd

Best regards,
--  
Sven Eckelmann <sven@narfation.org>

