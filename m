Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78073606A31C
	for <batman@archiver.kernel.org>; Wed, 18 Nov 2026 11:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.a=rsa-sha256 header.s=20121 header.b=gumjVaNs
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 0514B8215A
	for <batman@archiver.kernel.org>; Wed, 18 Nov 2026 12:48:11 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1795002491;
 b=SE9QA97a4N6LsoE2x3jK753IR49bC6CKGyXqhEtimVMU4pSk+Wo6mTXXj+ndwmiYhnnxS
 bYEJXLAWOya4G2hJ286YQ7WbpBCPCGkipYllBOCuL5noIBFABxv6u3gHIQtd6e2wuneszV7
 0cSx4Y1n6UEWEOPQGtRpsC7lIcW3gK4=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1795002491; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=JSTAVFHa6d/HFRNmAiSk9LLh7jYkXG0C78tygr0DOZM=;
 b=ahrFE0ytJBIPC/aPSmZBMNZnoMcuWsIjPAHGcU1U8GnJoaYaWwJduNjRGwjB+0307E9hF
 6uG+GjNfgVaAh6aulLX1yFho0ifo9XVULMkcsIPPPVhuMb6QBUcCZ43dnXG9eUBoj+AwuM3
 26Vwnl+wq6HmKu9XsPQxqQJbd6HMmTU=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org
 [IPv6:2a00:17d8:100::8b1])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 7A989805A7
	for <b.a.t.m.a.n@lists.open-mesh.org>; Wed, 18 Nov 2026 12:42:23 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1795002143;
	b=JoiO09oZb/+d5LyObdWJF1w/JKdCmHTznwUjb12vRBry8E89MCjA3/y1ubkRg+lGAOldNs
	pXwKPkfd0gBnyTLFKG3xQsFZD2U/Qky+BNT8nWfn7Ff78ERviqFwK5OMQJj6dMd8eNJ4eG
	06dk5j/yN4gurZnZ0iEBuMbueakYNJo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1795002143;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=JSTAVFHa6d/HFRNmAiSk9LLh7jYkXG0C78tygr0DOZM=;
	b=TK8V7S3S0Xqta2fsppdVWvBin+yCpY/oGQNmYQKRjfCgCqYBqcQgUr0dtgzsM2hL4HjNnq
	Lwb8YnOcnbJu0gQf7LD0cwrzLrommFX3Ez2tNFoCfH47MlPIBWpmXLneMFEBCdJLl3UDHh
	ej+wZw8BtNcJ5TGLHnqsUriF/C8o09E=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=gumjVaNs;
	dmarc=pass (policy=none) header.from=narfation.org;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org
Received: by dvalin.narfation.org (Postfix) id CD7241FE9A;
	Wed, 18 Nov 2026 11:42:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1795002142;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JSTAVFHa6d/HFRNmAiSk9LLh7jYkXG0C78tygr0DOZM=;
	b=gumjVaNsF3zFOrxmP5pTZCelwZTl4viofrsAq6Z5uvbGdPDNM2RV97+ZIflccMHkeytakn
	m/HtxPPVqx+V1Kj0EJFKs3lDLQiNIQXV2wpB58zDEGH+GuVIgwomngGBMtRz0RdLOOJQzn
	oFhs0dfi+MyIvKXWkSAsdosP8bLzxRI=
From: Sven Eckelmann <sven@narfation.org>
Date: Wed, 18 Nov 2026 12:42:01 +0100
Subject: [PATCH batadv v5 11/11] batman-adv: tt: drop ADD+DEL events of
 never announced clients
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: 
 <20261118-tt-avoid-unhashed-event-v5-11-bce9ead803e6@narfation.org>
References: <20261118-tt-avoid-unhashed-event-v5-0-bce9ead803e6@narfation.org>
In-Reply-To: 
 <20261118-tt-avoid-unhashed-event-v5-0-bce9ead803e6@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=12846; i=sven@narfation.org;
 h=from:subject:message-id; bh=x623Z2BDD4RxIERpt67dU1yjAaB7YmoQvnTH65qew30=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFl/+1lTNthmcKhktr1UXGo2/Z64TK3go9nfi38X396Tv
 Oz1nx8hHaUsDGJcDLJiiix7ruSf38z+Vv7ztI9HYeawMoEMYeDiFICJzHnFyDDN88S/+25r73zv
 uvq3h+OvzZ3M/ZJLWya9WiD9oi1iNqsZI8OVMj7ZvfMup4Scm/8toWGBLruV1K4ETtb0tpVrb5U
 Ef+YFAA==
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: SOUGSYB4I4N33E4IYQFZEKSKSQJE4KW6
X-Message-ID-Hash: SOUGSYB4I4N33E4IYQFZEKSKSQJE4KW6
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/SOUGSYB4I4N33E4IYQFZEKSKSQJE4KW6/>
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
 net/batman-adv/translation-table.c | 119 +++++++++++++++++++++++++++++--------
 net/batman-adv/types.h             |   7 +++
 2 files changed, 100 insertions(+), 26 deletions(-)

diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index 6102bdf6..e08bf88b 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -704,13 +704,20 @@ static u16 batadv_tt_flags_get(struct batadv_tt_common_entry *common)
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
@@ -722,12 +729,12 @@ static u16 batadv_tt_flags_get(struct batadv_tt_common_entry *common)
  * The caller must hold the flags_lock of @common. The events of an entry are
  * then queued in the same order in which its flags were modified.
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
 	__must_hold(&common->flags_lock)
 {
 	struct batadv_tt_change_node *tt_change_node;
@@ -738,6 +745,9 @@ static bool __batadv_tt_local_event(struct batadv_priv *bat_priv,
 
 	lockdep_assert_held(&common->flags_lock);
 
+	if (cancelled)
+		*cancelled = false;
+
 	tt_change_node = kmem_cache_alloc(batadv_tt_change_cache, GFP_ATOMIC);
 	if (!tt_change_node)
 		return false;
@@ -757,6 +767,7 @@ static bool __batadv_tt_local_event(struct batadv_priv *bat_priv,
 		flags &= ~BATADV_TT_CLIENT_ROAM;
 
 	tt_change_node->change.flags = flags;
+	tt_change_node->initial_add = initial_add && !del_op_requested;
 
 	/* check for ADD+DEL, DEL+ADD, ADD+ADD or DEL+DEL events */
 	spin_lock_bh(&bat_priv->tt.changes_list_lock);
@@ -769,12 +780,31 @@ static bool __batadv_tt_local_event(struct batadv_priv *bat_priv,
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
@@ -1116,6 +1146,10 @@ batadv_tt_local_refresh_needed(struct batadv_tt_local_entry *tt_local,
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
@@ -1136,6 +1170,7 @@ batadv_tt_local_refresh_locked(struct batadv_priv *bat_priv,
 {
 	struct batadv_tt_common_entry *common = &tt_local->common;
 	struct batadv_hashtable *hash = bat_priv->tt.local_hash;
+	bool initial_add = announce;
 	bool readded = false;
 	bool roamed = false;
 	u8 remote_flags;
@@ -1184,7 +1219,8 @@ batadv_tt_local_refresh_locked(struct batadv_priv *bat_priv,
 		 * without a queued change which commits/announces it
 		 */
 		if (announce &&
-		    !__batadv_tt_local_event(bat_priv, common, flags))
+		    !batadv_tt_local_event(bat_priv, common, flags,
+					   initial_add, NULL))
 			return false;
 
 		common->flags = flags;
@@ -1936,6 +1972,11 @@ static void batadv_tt_local_unhash(struct batadv_priv *bat_priv,
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
@@ -1944,8 +1985,11 @@ static void batadv_tt_local_unhash(struct batadv_priv *bat_priv,
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
@@ -1953,6 +1997,7 @@ batadv_tt_local_set_pending(struct batadv_priv *bat_priv,
 {
 	struct batadv_tt_common_entry *common = &tt_local_entry->common;
 	struct batadv_hashtable *hash = bat_priv->tt.local_hash;
+	bool cancelled;
 	bool queued;
 	u32 i;
 
@@ -1960,8 +2005,13 @@ batadv_tt_local_set_pending(struct batadv_priv *bat_priv,
 	lockdep_assert_held(&hash->list_locks[i]);
 	lockdep_assert_held(&common->flags_lock);
 
-	queued = __batadv_tt_local_event(bat_priv, common,
-					 common->flags | flags);
+	queued = batadv_tt_local_event(bat_priv, common, common->flags | flags,
+				       false, &cancelled);
+	if (cancelled) {
+		/* the entry was never announced */
+		batadv_tt_local_unhash(bat_priv, tt_local_entry, message);
+		return true;
+	}
 
 	/* a failed attempt must not hide the still queued DEL of an already
 	 * pending entry
@@ -1977,6 +2027,8 @@ batadv_tt_local_set_pending(struct batadv_priv *bat_priv,
 		   "Local tt entry (%pM, vid: %d) pending to be removed: %s\n",
 		   tt_local_entry->common.key.addr,
 		   batadv_print_vid(tt_local_entry->common.key.vid), message);
+
+	return false;
 }
 
 /**
@@ -1993,6 +2045,9 @@ batadv_tt_local_set_pending(struct batadv_priv *bat_priv,
  * also applies to an entry which still carries BATADV_TT_CLIENT_NEW because its
  * ADD might already have been taken for the next ttvn.
  *
+ * Only an entry whose initial ADD is still queued is removed from the local
+ * table immediately. Nothing was announced about it to the other nodes.
+ *
  * An entry which was already removed from the local table after it was looked
  * up is ignored and BATADV_NO_FLAGS is stored in @curr_flags.
  *
@@ -2009,6 +2064,7 @@ batadv_tt_local_remove_entry(struct batadv_priv *bat_priv,
 	spinlock_t *list_lock; /* protects write access to the hash lists */
 	struct batadv_tt_common_entry *common = &tt_local_entry->common;
 	struct batadv_hashtable *hash = bat_priv->tt.local_hash;
+	bool unhashed = false;
 	u16 flags;
 	u32 i;
 
@@ -2037,11 +2093,15 @@ batadv_tt_local_remove_entry(struct batadv_priv *bat_priv,
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
@@ -2090,6 +2150,8 @@ static void batadv_tt_local_purge_list(struct batadv_priv *bat_priv,
 
 	hlist_for_each_entry_safe(tt_common_entry, node_tmp, head,
 				  hash_entry) {
+		bool unhashed = false;
+
 		tt_local_entry = container_of(tt_common_entry,
 					      struct batadv_tt_local_entry,
 					      common);
@@ -2099,10 +2161,10 @@ static void batadv_tt_local_purge_list(struct batadv_priv *bat_priv,
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
 
@@ -2113,10 +2175,15 @@ static void batadv_tt_local_purge_list(struct batadv_priv *bat_priv,
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

