Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D915E606A324
	for <batman@archiver.kernel.org>; Mon,  2 Nov 2026 21:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=narfation.org header.i=@narfation.org header.a=rsa-sha256 header.s=20121 header.b=Pk622bN3
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 7EDDB8467B
	for <batman@archiver.kernel.org>; Mon, 02 Nov 2026 22:17:32 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1793654252;
 b=psK3Tkfj1vKeh4EKbc65qtZTFn8TDU7gZ1BC1LXpZqSeApZiCUueKIuOTgTOSlmmgLgzK
 ya43qbxjRO3Wsdo9r3LzBfnN+Ab3Kml9h2lhIKUK8KrV9F7d8K9H7iMJw2KL92zGmBjhAnv
 9DYI9Sot+zQdEAkFrjkgVMqYoQ0tSIo=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1793654252; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=MhDlPeeBlDwvyE7yB3n+ZEU6uxx57HIXTaLTaGoScpI=;
 b=OG1bunj/xkHoDuGznm9aWV8Ysk6I9HTeb85IHA5Q5P24SqdEacay6sRHDSknO16jdGawF
 W3H2KT814IOAJ5ZGz3iWR/AHzw0+H23TyCb3LlER7Ft+mpMlQgHdBhnkobn4zfwdI3pc5oH
 pLZmyRDsXV29jOxDiGQmZoxdPMxjw+Q=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org
 [IPv6:2a00:17d8:100::8b1])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 79E79844B2
	for <b.a.t.m.a.n@lists.open-mesh.org>; Mon, 02 Nov 2026 22:15:30 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1793654140;
	b=LjMgvSmMY+W4j+5J28tMBdFp9rLxV0EooJU1QkbTGP4ASrNCZXYcinFdexSLp//N8SVVFG
	2xw43zPGfODsmVA551uEOyVmZ7U/hWEwy2neojWPWfLarVTIjuNB4XyoCvmu6h/x5GU6VU
	7+YmV4NQem+B80SkUULKmsZt/yjcW+k=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1793654140;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=MhDlPeeBlDwvyE7yB3n+ZEU6uxx57HIXTaLTaGoScpI=;
	b=Ai7CUHdxy7f2ab3e9lpzyA0yGJPir/4SI/tNuejqzzmhifKL+s8Chmze24Yw4/AE6RXYaA
	QCUY3Ueko/KP+ZKzTzGZG2UzF//aJCmDAEFhemHIyPF2ALJghwZ9qD+LEvHkuIpbuejJ/j
	PIyx4SP++nxtvPqNpbmGGjmSyQt80WE=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=Pk622bN3;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id DB5BF2202F;
	Mon, 02 Nov 2026 21:15:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1793654130;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MhDlPeeBlDwvyE7yB3n+ZEU6uxx57HIXTaLTaGoScpI=;
	b=Pk622bN33SsOIDLCDMS/85xC8juXGHKGST2Wm437nqzqUXWI+PN/MZyxhiDdch+FJcTprD
	MW4JfA7OTVJzr8/3Vnrb3CoSI4DZYVzU2ye0qTEYLzRMm2ABnQVEyv9/VM2uiyYTp16Ppm
	SCi1LdVau2f+njsf9Je7LAwwQ/zqD4s=
From: Sven Eckelmann <sven@narfation.org>
Date: Mon, 02 Nov 2026 22:15:18 +0100
Subject: [PATCH batadv v3 3/3] batman-adv: tt: drop ADD+DEL events of never
 announced clients
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261102-tt-avoid-unhashed-event-v3-3-f37f59c80b0d@narfation.org>
References: <20261102-tt-avoid-unhashed-event-v3-0-f37f59c80b0d@narfation.org>
In-Reply-To: 
 <20261102-tt-avoid-unhashed-event-v3-0-f37f59c80b0d@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=8214; i=sven@narfation.org;
 h=from:subject:message-id; bh=/PpWUBGbNdyWAxtqvV3ASlfugRx+ZVX6jhE1MbbZYlo=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFkv/masuN3hHSHAkLZ30b4pazV1XG9EtTv0KbTM3G7cK
 BCqfcWjo5SFQYyLQVZMkWXPlfzzm9nfyn+e9vEozBxWJpAhDFycAjCRGfUM/x0mV1Rsu16iMP9a
 x8Qlv/z8I3+2zKg+nLTUxDLp4KbFi1sZ/gf2GO9P01E//G7OwtWzQvc+XL1xToZE1B7jw2n/lmu
 qmrICAA==
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: H7UG7IWOABJMGVSRJIYVZCFYNWWH4YBQ
X-Message-ID-Hash: H7UG7IWOABJMGVSRJIYVZCFYNWWH4YBQ
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/H7UG7IWOABJMGVSRJIYVZCFYNWWH4YBQ/>
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
the ADD event. The BATADV_TT_CLIENT_NEW flag must be checked to identify
clients which were or were not yet announced.

Since this would be only the case for clients which appeared and directly
disappeared, this behavior must only be triggered by
batadv_tt_local_remove_now(). And valid change entries are only the ones
which were never a DEL announcements. Otherwise the receiver will not know
to remove a global TT entry after the (disappeared) DEL+ADD+DEL change
sequence.

This initial DEL in a DEL+ADD+DEL change sequence can be queued by
batadv_tt_local_mark_removed() after
batadv_tt_local_commit_changes_nolock() took the changes_list but before
batadv_tt_local_purge_pending_clients() removed the entry. A new instance
of the client then reuses this queued change for its ADD. Each change entry
must therefore store if it was ever a DEL.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/translation-table.c | 84 +++++++++++++++++++++-----------------
 net/batman-adv/types.h             |  8 ++++
 2 files changed, 55 insertions(+), 37 deletions(-)

diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index ecbf50ea..0afdd8fa 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -698,17 +698,22 @@ static u16 batadv_tt_flags_get(struct batadv_tt_common_entry *common)
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
@@ -735,6 +740,7 @@ static void __batadv_tt_local_event(struct batadv_priv *bat_priv,
 		flags &= ~BATADV_TT_CLIENT_ROAM;
 
 	tt_change_node->change.flags = flags;
+	tt_change_node->del_queued = del_op_requested;
 
 	/* check for ADD+DEL, DEL+ADD, ADD+ADD or DEL+DEL events */
 	spin_lock_bh(&bat_priv->tt.changes_list_lock);
@@ -747,12 +753,27 @@ static void __batadv_tt_local_event(struct batadv_priv *bat_priv,
 		if (entry->change.vid != tt_change_node->change.vid)
 			continue;
 
-		/* the other nodes may know the client with different
-		 * flags. A DEL+ADD must therefore still announce the
-		 * current flags and an ADD+DEL must still remove the
-		 * client. ADD+ADD and DEL+DEL only update the flags
-		 */
-		entry->change.flags = flags;
+		if (cancel_add && del_op_requested && !entry->del_queued) {
+			/* ADD+DEL of a client which was never announced (e.g.
+			 * roaming of a client still in the NEW state) have no
+			 * effect and can be removed.
+			 *
+			 * This is not allowed when the ADD replaced a DEL of a
+			 * previous (announced) instance of the client
+			 * (DEL-ADD-DEL sequence).
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
+			entry->del_queued |= del_op_requested;
+		}
 
 		kmem_cache_free(batadv_tt_change_cache, tt_change_node);
 		goto update_changes;
@@ -767,23 +788,6 @@ static void __batadv_tt_local_event(struct batadv_priv *bat_priv,
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
@@ -1188,8 +1192,8 @@ batadv_tt_local_refresh(struct batadv_priv *bat_priv,
 			announce = true;
 
 		if (announce)
-			__batadv_tt_local_event(bat_priv, common,
-						common->flags);
+			batadv_tt_local_event(bat_priv, common,
+					      common->flags, false);
 	}
 
 	spin_unlock_bh(list_lock);
@@ -1772,7 +1776,7 @@ batadv_tt_local_set_pending(struct batadv_priv *bat_priv,
 	lockdep_assert_held(&hash->list_locks[i]);
 	lockdep_assert_held(&common->flags_lock);
 
-	__batadv_tt_local_event(bat_priv, common, common->flags | flags);
+	batadv_tt_local_event(bat_priv, common, common->flags | flags, false);
 	common->flags |= BATADV_TT_CLIENT_PENDING;
 
 	batadv_dbg(BATADV_DBG_TT, bat_priv,
@@ -1876,6 +1880,7 @@ batadv_tt_local_remove_now(struct batadv_priv *bat_priv,
 	spinlock_t *list_lock; /* protects write access to the hash lists */
 	struct batadv_tt_common_entry *common = &tt_local_entry->common;
 	struct batadv_hashtable *hash = bat_priv->tt.local_hash;
+	u16 flags;
 	u32 i;
 
 	i = batadv_choose_tt(&common->key, hash->size);
@@ -1892,13 +1897,18 @@ batadv_tt_local_remove_now(struct batadv_priv *bat_priv,
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
 		batadv_tt_local_size_dec(bat_priv, common->key.vid);
 
 	spin_unlock_bh(list_lock);
diff --git a/net/batman-adv/types.h b/net/batman-adv/types.h
index 8e590f19..16ecbc45 100644
--- a/net/batman-adv/types.h
+++ b/net/batman-adv/types.h
@@ -1998,6 +1998,14 @@ struct batadv_tt_change_node {
 
 	/** @change: holds the actual translation table diff data */
 	struct batadv_tvlv_tt_change change;
+
+	/**
+	 * @del_queued: a DEL was queued for the client since the last commit.
+	 *  The change can then no longer be dropped because it might have to
+	 *  remove a previous instance of the client which was announced to
+	 *  the other nodes
+	 */
+	bool del_queued:1;
 };
 
 /**

-- 
2.47.3

