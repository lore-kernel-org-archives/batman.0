Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7FFE606A31C
	for <batman@archiver.kernel.org>; Wed, 18 Nov 2026 11:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.a=rsa-sha256 header.s=20121 header.b=KBO9i5oK
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 698ED8447F
	for <batman@archiver.kernel.org>; Wed, 18 Nov 2026 12:44:22 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1795002262;
 b=wFYBfw4jl+Dm4ppp4+o4tmfOmqjjr0/zbP8esEKMjXzOLPtkiDOS0bUp37QirEXwfZ6um
 bUyUVdmZNqH2OPf8KI5O/aj7hYcxqY9p2rZBJ4OwA1WWOYHv+0XrWYIFhUX8oMpn4D1FJ8U
 FFrh52LYPj3LLpOShy8zzBYSikyfpvo=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1795002262; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=hADXN8BdSDdbtw9eZsKCkmsomWn8DZhikHNrPycpa0c=;
 b=ceK6LLX7veKh8InBVGUCPvrmqoZ8gXQL1KPDtTC33lU0AL9G3CdkSpDqGF57IKucA0JEl
 5vpIdGPQ6+L89CLC+IAs0rGdYCbjS8k3OqtMyM639+xvDAr7EYZ5XaGiP141bdrseV9CKSy
 BElGBG8M2M072PqJ45BfkiqxHgI5/g8=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org
 [IPv6:2a00:17d8:100::8b1])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id C29928427A
	for <b.a.t.m.a.n@lists.open-mesh.org>; Wed, 18 Nov 2026 12:42:09 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1795002129;
	b=ifsWoHAZ/sUztxAn+v8jdAR9A1Mm9NKM6sk+Lm7Op1OYxifgn70YpAabDltkVORiBMYYT0
	SpeCnIisj35P7JlrkTbSe8sRTJHrc9Q5HlPgrLuor+G8m8gUX3o5J0mLVefjrdtOQPTtpZ
	wIUjnt/PD2brHpF/r6HE7zNcfr2l9BQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1795002129;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=hADXN8BdSDdbtw9eZsKCkmsomWn8DZhikHNrPycpa0c=;
	b=cDzOeams6OB9ppzgJLM/rj7fZkyumOchb/XVpl8xrocFezQeWKCeqxa6/wfMzGaAzLGqiN
	PuhmU6mcX8HVQEThhzMxWIPleu+bHPfZQi2K0C+khWUQ43hADUXMDREHBCtHzQlG5fbSaA
	7Gbn/WTIegySKKG202wk/VuqlpHepWg=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=KBO9i5oK;
	dmarc=pass (policy=none) header.from=narfation.org;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org
Received: by dvalin.narfation.org (Postfix) id 4D29920EAD;
	Wed, 18 Nov 2026 11:42:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1795002129;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hADXN8BdSDdbtw9eZsKCkmsomWn8DZhikHNrPycpa0c=;
	b=KBO9i5oK6e9XALXpYdY4oJx3QlMqzD5RowI4AgP/MmUa7F0cHWS5Q9OoFw0FGoyFpvbGB/
	xqouwweUR4BTP9wfQLX+0i1tT9MvfXI2eL/I0TQ2a0rST41N/QkIQ8qGPdBKzYs3CJcRqP
	nvbUM++4XwrSSH45KhOlDGPYhYJMEfs=
From: Sven Eckelmann <sven@narfation.org>
Date: Wed, 18 Nov 2026 12:41:54 +0100
Subject: [PATCH batadv v5 04/11] batman-adv: tt: don't queue local events
 for unhashed entries
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261118-tt-avoid-unhashed-event-v5-4-bce9ead803e6@narfation.org>
References: <20261118-tt-avoid-unhashed-event-v5-0-bce9ead803e6@narfation.org>
In-Reply-To: 
 <20261118-tt-avoid-unhashed-event-v5-0-bce9ead803e6@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>, Sashiko <sashiko-bot@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=9627; i=sven@narfation.org;
 h=from:subject:message-id; bh=gvtJ+h02MIEvSsz3M6rJnCK66MjowZ1XlqTTPqS4jcU=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFl/+5nXXrL0totyfPlw5e5Ht+0kLS6sKe5gfFkd/dBG8
 UIwwzSpjlIWBjEuBlkxRZY9V/LPb2Z/K/952sejMHNYmUCGMHBxCsBENBkYGXaKp38+qnDy9mWv
 Sbzm53p+bYlIEBdKT9Kd6RTJe6n0UCjDP7P9p/X/OH7tZz0kpCJ1/c2py6/SplQ9MmW9bPVJKi9
 4CjsA
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: HQJI2UVNGELOHHVDOWXU3GLVUCHWOQSW
X-Message-ID-Hash: HQJI2UVNGELOHHVDOWXU3GLVUCHWOQSW
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/HQJI2UVNGELOHHVDOWXU3GLVUCHWOQSW/>
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

batadv_tt_local_add() looks up the local entry via RCU only.
batadv_tt_local_purge_pending_clients() or batadv_tt_local_remove() can
unhash it before the entry is modified and an event is queued for it:

  CPU0                          CPU1
                                /* DEL#1 queued, PENDING set */
  batadv_tt_local_hash_find()
                                batadv_tt_local_commit_changes()
                                  ..._purge_pending_clients()
                                    hlist_del_rcu(&...->hash_entry);
                                  /* DEL#1 announced */
  batadv_tt_local_refresh()
    flags &= ~..._PENDING;
  /* ADD queued for unhashed entry */

The queued event will then be announced for a client which is not part
anymore of the table (+ its CRC). A full table request in this and similar
scenarios is required to fix the inconsistency.

Only the hash bucket list_lock can ensure that an entry is still part of
the local table. batadv_tt_local_refresh() therefore checks with
hlist_unhashed() under this lock whether the entry is still hashed. An
entry which is no longer hashed is not refreshed and batadv_tt_local_add()
creates a new entry instead. batadv_tt_local_insert() adds this entry to
the hash and queues its initial ADD under the same list_lock. Otherwise
batadv_tt_local_commit_changes() could count the entry in the CRC of a ttvn
before its ADD was queued or batadv_tt_local_remove() could unhash it
before the ADD was queued.

Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260930094558.3723766-2-sw%40simonwunderlich.de?part=7
Closes: https://sashiko.dev/#/bug/linux-557fd001-5041-4b0a-a2ea-cdf22526ee84
Closes: https://sashiko.dev/#/bug/linux-c7f17a4b-620f-4307-a058-be6523cc6fa2
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/translation-table.c | 156 ++++++++++++++++++++++++++++++-------
 1 file changed, 129 insertions(+), 27 deletions(-)

diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index dd277c01..a5b34095 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -1019,7 +1019,7 @@ batadv_tt_local_create(struct net_device *mesh_iface, const u8 *addr,
 }
 
 /**
- * batadv_tt_local_refresh() - refresh a local TT entry of an active client
+ * batadv_tt_local_refresh_locked() - refresh a hashed local TT entry
  * @bat_priv: the bat priv with all the mesh interface information
  * @tt_local: the local TT entry to refresh
  * @iif_is_wifi: whether the client is connected via a wifi interface
@@ -1033,19 +1033,23 @@ batadv_tt_local_create(struct net_device *mesh_iface, const u8 *addr,
  * updated. An ADD event is queued when @announce is set, the pending removal
  * was cancelled or a flag announced to the other nodes was modified.
  *
- * All checks and modifications of the flags and the queueing of the ADD event
- * happen in a single flags_lock section. The announced flags are therefore the
- * ones which were just stored in the entry.
+ * The caller must hold the hash bucket list_lock of the entry and must have
+ * checked that the entry is still part of the local table.
  */
 static void
-batadv_tt_local_refresh(struct batadv_priv *bat_priv,
-			struct batadv_tt_local_entry *tt_local,
-			bool iif_is_wifi, u32 mark, bool announce,
-			bool *roamed_back)
+batadv_tt_local_refresh_locked(struct batadv_priv *bat_priv,
+			       struct batadv_tt_local_entry *tt_local,
+			       bool iif_is_wifi, u32 mark, bool announce,
+			       bool *roamed_back)
 {
 	struct batadv_tt_common_entry *common = &tt_local->common;
+	struct batadv_hashtable *hash = bat_priv->tt.local_hash;
 	u8 remote_flags;
 	u32 match_mark;
+	u32 i;
+
+	i = batadv_choose_tt(&common->key, hash->size);
+	lockdep_assert_held(&hash->list_locks[i]);
 
 	scoped_guard(spinlock_bh, &common->flags_lock) {
 		if (common->flags & BATADV_TT_CLIENT_PENDING) {
@@ -1106,6 +1110,109 @@ batadv_tt_local_refresh(struct batadv_priv *bat_priv,
 	}
 }
 
+/**
+ * batadv_tt_local_refresh() - refresh a local TT entry of an active client
+ * @bat_priv: the bat priv with all the mesh interface information
+ * @tt_local: the local TT entry to refresh
+ * @iif_is_wifi: whether the client is connected via a wifi interface
+ * @mark: the value contained in the skb->mark field of the received packet (if
+ *  any)
+ * @roamed_back: set to true when the client returned to its original location
+ *
+ * See batadv_tt_local_refresh_locked() for the actual refresh.
+ *
+ * Return: 0 if the entry was refreshed, -ENOENT if the entry is no longer part
+ * of the local table.
+ */
+static int
+batadv_tt_local_refresh(struct batadv_priv *bat_priv,
+			struct batadv_tt_local_entry *tt_local,
+			bool iif_is_wifi, u32 mark, bool *roamed_back)
+{
+	spinlock_t *list_lock; /* protects write access to the hash lists */
+	struct batadv_tt_common_entry *common = &tt_local->common;
+	struct batadv_hashtable *hash = bat_priv->tt.local_hash;
+	u32 i;
+
+	i = batadv_choose_tt(&common->key, hash->size);
+	list_lock = &hash->list_locks[i];
+
+	WRITE_ONCE(tt_local->last_seen, jiffies);
+
+	spin_lock_bh(list_lock);
+
+	/* the entry was removed from the local table after it was looked up */
+	if (hlist_unhashed(&common->hash_entry)) {
+		spin_unlock_bh(list_lock);
+		return -ENOENT;
+	}
+
+	batadv_tt_local_refresh_locked(bat_priv, tt_local, iif_is_wifi, mark,
+				       false, roamed_back);
+
+	spin_unlock_bh(list_lock);
+
+	return 0;
+}
+
+/**
+ * batadv_tt_local_insert() - add a new local TT entry to the local table
+ * @bat_priv: the bat priv with all the mesh interface information
+ * @tt_local: the new local TT entry (not yet hashed)
+ * @iif_is_wifi: whether the client is connected via a wifi interface
+ * @mark: the value contained in the skb->mark field of the received packet (if
+ *  any)
+ * @roamed_back: set to true when the client returned to its original location
+ *
+ * The entry is inserted into the local hash and its initial ADD event is
+ * queued under the same hash bucket list_lock. A concurrent
+ * batadv_tt_local_commit_changes() can therefore not count the entry in the
+ * CRC of a ttvn before its ADD was queued and a concurrent
+ * batadv_tt_local_remove() can not unhash it before the ADD was queued.
+ *
+ * Return: true if the entry was added, false if the client already has an
+ * entry in the local table.
+ */
+static bool batadv_tt_local_insert(struct batadv_priv *bat_priv,
+				   struct batadv_tt_local_entry *tt_local,
+				   bool iif_is_wifi, u32 mark,
+				   bool *roamed_back)
+{
+	spinlock_t *list_lock; /* protects write access to the hash lists */
+	struct batadv_tt_common_entry *common = &tt_local->common;
+	struct batadv_hashtable *hash = bat_priv->tt.local_hash;
+	struct hlist_head *head;
+	struct hlist_node *node;
+	u32 i;
+
+	i = batadv_choose_tt(&common->key, hash->size);
+	head = &hash->table[i];
+	list_lock = &hash->list_locks[i];
+
+	spin_lock_bh(list_lock);
+
+	hlist_for_each(node, head) {
+		if (!batadv_compare_tt(node, &common->key))
+			continue;
+
+		spin_unlock_bh(list_lock);
+		return false;
+	}
+
+	/* reference for the hash */
+	kref_get(&common->refcount);
+	hlist_add_head_rcu(&common->hash_entry, head);
+	atomic_inc(&hash->generation);
+
+	/* announce the added client to the mesh */
+	batadv_tt_local_refresh_locked(bat_priv, tt_local, iif_is_wifi, mark,
+				       true, roamed_back);
+
+	spin_unlock_bh(list_lock);
+
+	return true;
+}
+
 /**
  * batadv_tt_local_add() - add a new client to the local table or update an
  *  existing client
@@ -1126,10 +1233,9 @@ bool batadv_tt_local_add(struct net_device *mesh_iface, const u8 *addr,
 	struct batadv_tt_global_entry *tt_global = NULL;
 	struct batadv_tt_local_entry *tt_local;
 	bool roamed_back = false;
-	bool added = false;
 	bool iif_is_wifi;
 	bool ret = false;
-	int hash_added;
+	int err;
 
 	iif_is_wifi = batadv_tt_iif_is_wifi(dev_net(mesh_iface), ifindex);
 
@@ -1139,30 +1245,26 @@ bool batadv_tt_local_add(struct net_device *mesh_iface, const u8 *addr,
 		tt_global = batadv_tt_global_hash_find(bat_priv, addr, vid);
 
 	if (tt_local) {
-		WRITE_ONCE(tt_local->last_seen, jiffies);
-	} else {
+		err = batadv_tt_local_refresh(bat_priv, tt_local, iif_is_wifi,
+					      mark, &roamed_back);
+		if (err == -ENOENT) {
+			/* stale entry which has to be replaced by a new one */
+			batadv_tt_local_entry_put(tt_local);
+			tt_local = NULL;
+		}
+	}
+
+	if (!tt_local) {
 		tt_local = batadv_tt_local_create(mesh_iface, addr, vid, iif_is_wifi);
 		if (!tt_local)
 			goto out;
 
-		kref_get(&tt_local->common.refcount);
-		hash_added = batadv_hash_add(bat_priv->tt.local_hash, batadv_compare_tt,
-					     batadv_choose_tt, &tt_local->common.key,
-					     &tt_local->common.hash_entry);
-
-		if (unlikely(hash_added != 0)) {
-			/* remove the reference for the hash */
-			batadv_tt_local_entry_put(tt_local);
+		if (unlikely(!batadv_tt_local_insert(bat_priv, tt_local,
+						     iif_is_wifi, mark,
+						     &roamed_back)))
 			goto out;
-		}
-
-		added = true;
 	}
 
-	/* announce the (re-)added client or its modified flags to the mesh */
-	batadv_tt_local_refresh(bat_priv, tt_local, iif_is_wifi, mark, added,
-				&roamed_back);
-
 	batadv_tt_local_add_roam(bat_priv, tt_global, roamed_back);
 
 	ret = true;

-- 
2.47.3

