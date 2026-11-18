Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20DF5606A31C
	for <batman@archiver.kernel.org>; Wed, 18 Nov 2026 11:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.a=rsa-sha256 header.s=20121 header.b=TyrYhG0H
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 9DD968088A
	for <batman@archiver.kernel.org>; Wed, 18 Nov 2026 12:47:02 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1795002422;
 b=fbzufbU9eoEs4uLfIe2lz99853RatayiOeak8sfxF6fvtLjS6rOBwMpjIF+VMEIM35Bpd
 fA6boYNpqkvcAXfNVPyEsVJ5rWPwL+XcoWcC/vVot69fW80eH4ILT71AJMyvAJNDYuPfpIv
 TQ6ByZdoLZgrlMS3gOoNkFyfsDw27KI=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1795002422; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=FGWou4wkgxalLJD/kIaKjATgVVVhlZtZbqcVmYeamww=;
 b=Sda9TiV78ZQulSpUPZepjobqaRqpQMmxj2KRi+TWM03CeEMtnUUP/9MCVsLJBT7oFpPQ6
 dAC2YqkFPAzaCQuudm/Ug3CgehCqBv8HfSBO0Wabr1PHFdp6EnHDZhlr3Xeq8Uzb8VFCoG6
 cohcS2dFqoWZqLiDUfQf32Pf7H1TE3Q=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 69CAC8427B
	for <b.a.t.m.a.n@lists.open-mesh.org>; Wed, 18 Nov 2026 12:42:19 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1795002139;
	b=g0dXI/tCJu/w768q5CX4l4nbR+usnWP1qJtTVrZdxw+uleukQtDyc/djcd8T4d9yE9TUbZ
	vmStckRgxiKTIyJ+JNEFllypPcDIDntCY5MtndYfuW4lQYZN//WrL0JQP6DFqxPXpqS7x/
	edKML5TAHlWkKgliHSZ1Aa7upNA9Cn8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1795002139;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=FGWou4wkgxalLJD/kIaKjATgVVVhlZtZbqcVmYeamww=;
	b=h6nhDo3H9pklNGx0VGJx6Gfn20PGLzNtO6SwBs2gylgap7pgEi0G43vS9Eu35tcHcX1g3p
	41+iNx33SAWCd0U5ZTIACviu9KPhWNDrjGn149/j/tKveOd+oiCVTbUdwb99He7qQasZw8
	UCl9xpjZ8keH56fi/pCUbEYAJbtvwpU=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=TyrYhG0H;
	dmarc=pass (policy=none) header.from=narfation.org;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org
Received: by dvalin.narfation.org (Postfix) id 073CF1FE9A;
	Wed, 18 Nov 2026 11:42:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1795002139;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FGWou4wkgxalLJD/kIaKjATgVVVhlZtZbqcVmYeamww=;
	b=TyrYhG0HsUlsd9DHrz9Ilhz7M9VAUnCpdSXCBOi5C8K7Nfo0VYa+pgB/byB5m4KWHPHNtd
	WuaGKhJ7+YjRwLd1Fh1ETYMnKV+UZ+ptAnoWJhQN6/Ml0QrCK0oWrkAIJSSZbmhYCaxZLg
	m6ottKRE91A+YrJEs8iIoEEt78MwgQM=
From: Sven Eckelmann <sven@narfation.org>
Date: Wed, 18 Nov 2026 12:41:59 +0100
Subject: [PATCH batadv v5 09/11] batman-adv: tt: commit only the announced
 local changes
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261118-tt-avoid-unhashed-event-v5-9-bce9ead803e6@narfation.org>
References: <20261118-tt-avoid-unhashed-event-v5-0-bce9ead803e6@narfation.org>
In-Reply-To: 
 <20261118-tt-avoid-unhashed-event-v5-0-bce9ead803e6@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>, Sashiko <sashiko-bot@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=11781; i=sven@narfation.org;
 h=from:subject:message-id; bh=tk+2nd17gtflLp9RqudLCcIRwIq2pNWG8oXIytZjfhM=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFl/+1mmT67Sr2G0vvPG/tJKrrjaqQmp5cWxLZlhKyu//
 zU0drTuKGVhEONikBVTZNlzJf/8Zva38p+nfTwKM4eVCWQIAxenAEzkTDsjw9+6JTq/cpSWBV6w
 P3Tj/Ma/mft1vJ0dVmR+VahddZ5VzYGRoaPndvn6NbPrXrcuKc/ROv31ePgx5/CMFkeO7XEXawI
 a+AA=
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: BHBK3RLHBLC62JETCPO5J37MVXJVHSX6
X-Message-ID-Hash: BHBK3RLHBLC62JETCPO5J37MVXJVHSX6
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/BHBK3RLHBLC62JETCPO5J37MVXJVHSX6/>
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

batadv_tt_local_commit_changes_nolock() takes the queued changes for the
new TTVN and then scans the complete local table: every
BATADV_TT_CLIENT_NEW entry is committed and every BATADV_TT_CLIENT_PENDING
entry is removed. But the local table is modified in parallel by
batadv_tt_local_add() and batadv_tt_local_remove(). An entry which was
added or marked for removal after the changes were taken is then already
part of the CRC (or already missing from it) of the new TTVN although its
ADD/DEL is only announced with the next one. The other nodes detect the CRC
mismatch and have to request the full table.

But there is already the list of batadv_tvlv_tt_change which belong to the
TTVN which is currently committed. Since its state it atomically extracted
by batadv_tt_local_commit_changes_nolock(), it can be used as stable source
for the operations which need to be applied on the local TT. The changes
are applied similar to the patching done for the global TT table after
receiving a TTVN changeset - but with the local TT specific flags state in
mind:

The ADD of an entry finishes its NEW state and the DEL of an entry removes
it from the local table.

An entry which was marked for removal after the changes were taken stays in
the table until its DEL is committed. This also applies to entries which
still carry BATADV_TT_CLIENT_NEW. But batadv_tt_local_resize_to_mtu() still
drops the pending entries directly. It holds the commit_lock and commits
the queued changes right away. The DEL of each dropped entry is therefore
announced with this commit.

The scan of the complete table also finished the entries whose ADD or DEL
was never queued because the allocation of the change failed. This is no
longer needed: an entry is not brought into the BATADV_TT_CLIENT_NEW state
without a queued ADD anymore and the DEL of a BATADV_TT_CLIENT_PENDING
entry is requeued by the purge until it was stored.

The client of a committed DEL might have been detected again after the
changes were taken. Its entry is then no longer pending or it was marked
for removal again but the new DEL could not be queued. Such an entry is not
removed because its ADD is queued for the next TTVN. But the other nodes
remove the client with the DEL of the current TTVN. The entry is therefore
brought back into the BATADV_TT_CLIENT_NEW state. It is then not part of
the CRC and of the full table responses until its ADD is committed.

Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://sashiko.dev/#/bug/linux-0de54f93-3f78-4500-b5ea-3c6973e51bf3
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/translation-table.c | 176 +++++++++++++++++++++++++++----------
 1 file changed, 128 insertions(+), 48 deletions(-)

diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index 89fed26b..c2f5b8a5 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -588,6 +588,12 @@ static void batadv_tt_local_size_inc(struct batadv_priv *bat_priv,
  * was removed from bat_priv->tt.local_hash (under the specific
  * list_locks[i]) or when it is ensured that it is not accessible
  * in this list.
+ *
+ * The only exception is an entry which stays in bat_priv->tt.local_hash but is
+ * brought back into the NEW state by batadv_tt_local_commit_change(). The NEW
+ * flag must then be set under the same list_locks[i] and the flags_lock of the
+ * entry. batadv_tt_local_size_inc() counts the entry again when its NEW flag
+ * is removed.
  */
 static void batadv_tt_local_size_dec(struct batadv_priv *bat_priv,
 				     unsigned short vid)
@@ -1929,9 +1935,8 @@ batadv_tt_local_set_pending(struct batadv_priv *bat_priv,
  *
  * All checks and modifications happen under the hash bucket list_lock and the
  * flags_lock of the entry. This prevents a concurrent
- * batadv_tt_local_purge_pending_clients() from removing the entry,
- * batadv_tt_local_transition_new() from clearing BATADV_TT_CLIENT_NEW and
- * batadv_tt_local_refresh() from modifying the entry after it was checked.
+ * batadv_tt_local_commit_change() from removing the entry and
+ * batadv_tt_local_refresh() from modifying it after it was checked.
  */
 static void
 batadv_tt_local_remove_entry(struct batadv_priv *bat_priv,
@@ -4598,49 +4603,6 @@ void batadv_tt_free(struct batadv_priv *bat_priv)
 	kfree(bat_priv->tt.last_changeset);
 }
 
-/**
- * batadv_tt_local_transition_new() - unset the NEW flag on the local
- *  table and count them in the TT size
- * @bat_priv: the bat priv with all the mesh interface information
- */
-static void batadv_tt_local_transition_new(struct batadv_priv *bat_priv)
-{
-	spinlock_t *list_lock; /* protects write access to the hash lists */
-	struct batadv_hashtable *hash = bat_priv->tt.local_hash;
-	struct batadv_tt_common_entry *tt_common_entry;
-	struct hlist_head *head;
-	u32 i;
-
-	if (!hash)
-		return;
-
-	for (i = 0; i < hash->size; i++) {
-		head = &hash->table[i];
-		list_lock = &hash->list_locks[i];
-
-		spin_lock_bh(list_lock);
-		hlist_for_each_entry(tt_common_entry, head, hash_entry) {
-			bool cont = false;
-
-			scoped_guard(spinlock_bh, &tt_common_entry->flags_lock) {
-				if (!(tt_common_entry->flags & BATADV_TT_CLIENT_NEW)) {
-					cont = true;
-					break;
-				}
-
-				tt_common_entry->flags &= ~BATADV_TT_CLIENT_NEW;
-			}
-
-			if (cont)
-				continue;
-
-			batadv_tt_local_size_inc(bat_priv,
-						 tt_common_entry->key.vid);
-		}
-		spin_unlock_bh(list_lock);
-	}
-}
-
 /**
  * batadv_tt_local_unhash_pending() - remove a pending entry from the local table
  * @bat_priv: the bat priv with all the mesh interface information
@@ -4678,6 +4640,112 @@ batadv_tt_local_unhash_pending(struct batadv_priv *bat_priv,
 	return true;
 }
 
+/**
+ * batadv_tt_local_commit_change() - apply a committed change to the local table
+ * @bat_priv: the bat priv with all the mesh interface information
+ * @change: the change which is announced with the new ttvn
+ *
+ * The CRC and the full table responses of a ttvn must reflect exactly the
+ * changes announced with it. Only the entry affected by a committed change is
+ * therefore modified. An entry which was added or marked for removal after the
+ * change set was taken stays in its current state until its own change is
+ * committed with a later ttvn.
+ *
+ * An ADD finishes the BATADV_TT_CLIENT_NEW state of the entry and it is counted
+ * as part of the local table from now on. A DEL removes the entry which is
+ * marked as BATADV_TT_CLIENT_PENDING from the local table.
+ *
+ * The entry is not protected by bat_priv->tt.commit_lock against a concurrent
+ * refresh and removal. The client of a committed DEL can therefore be detected
+ * again after the change set was taken. Its entry is then no longer
+ * BATADV_TT_CLIENT_PENDING or it was marked for removal again without a queued
+ * DEL (del_unqueued). Such an entry must stay hashed because its ADD is queued
+ * for a later ttvn. But the other nodes remove the client with the new ttvn.
+ * The entry is therefore brought back into the BATADV_TT_CLIENT_NEW state and
+ * is not counted as part of the local table until its ADD is committed.
+ *
+ * The caller must hold tt->commit_lock. It is the one which took @change from
+ * the queued changes of the new ttvn.
+ */
+static void
+batadv_tt_local_commit_change(struct batadv_priv *bat_priv,
+			      const struct batadv_tvlv_tt_change *change)
+	__must_hold(&bat_priv->tt.commit_lock)
+{
+	spinlock_t *list_lock; /* protects write access to the hash lists */
+	struct batadv_hashtable *hash = bat_priv->tt.local_hash;
+	struct batadv_tt_local_entry *tt_local = NULL;
+	struct batadv_tt_common_entry *tt_common;
+	struct batadv_tt_common_entry_key key;
+	struct hlist_head *head;
+	bool committed = false;
+	bool del_op;
+	u32 i;
+
+	lockdep_assert_held(&bat_priv->tt.commit_lock);
+
+	if (!hash)
+		return;
+
+	ether_addr_copy(key.addr, change->addr);
+	key.vid = ntohs(change->vid);
+	del_op = change->flags & BATADV_TT_CLIENT_DEL;
+
+	i = batadv_choose_tt(&key, hash->size);
+	head = &hash->table[i];
+	list_lock = &hash->list_locks[i];
+
+	spin_lock_bh(list_lock);
+
+	hlist_for_each_entry(tt_common, head, hash_entry) {
+		if (!batadv_compare_tt(&tt_common->hash_entry, &key))
+			continue;
+
+		scoped_guard(spinlock_bh, &tt_common->flags_lock) {
+			if (!del_op) {
+				/* an ADD of an already committed entry only
+				 * announces new flags or cancels its removal
+				 */
+				if (!(tt_common->flags & BATADV_TT_CLIENT_NEW))
+					break;
+
+				tt_common->flags &= ~BATADV_TT_CLIENT_NEW;
+				committed = true;
+				break;
+			}
+
+			tt_local = container_of(tt_common,
+						struct batadv_tt_local_entry,
+						common);
+			if (batadv_tt_local_unhash_pending(bat_priv, tt_local))
+				break;
+
+			tt_local = NULL;
+
+			/* The client was detected again after its DEL was
+			 * taken. The other nodes remove it with this ttvn and
+			 * only add it again with the still queued ADD. The
+			 * entry must be hidden from the CRC and the full table
+			 * responses until this ADD is committed.
+			 */
+			if (!(tt_common->flags & BATADV_TT_CLIENT_NEW)) {
+				tt_common->flags |= BATADV_TT_CLIENT_NEW;
+				batadv_tt_local_size_dec(bat_priv, key.vid);
+			}
+		}
+
+		if (committed)
+			batadv_tt_local_size_inc(bat_priv, key.vid);
+
+		break;
+	}
+
+	spin_unlock_bh(list_lock);
+
+	/* drop reference of removed hash entry */
+	batadv_tt_local_entry_put(tt_local);
+}
+
 /**
  * batadv_tt_local_purge_pending_clients() - finalise removal of pending local
  *  clients
@@ -4686,8 +4754,14 @@ batadv_tt_local_unhash_pending(struct batadv_priv *bat_priv,
  * Iterate over the local TT and physically remove every entry that has been
  * marked as BATADV_TT_CLIENT_PENDING and whose DEL was queued. An entry which
  * still waits for its DEL (del_unqueued) stays in the local table.
+ *
+ * The caller must hold tt->commit_lock and has to commit the queued changes
+ * right away. The DEL of each removed entry is still queued because no commit
+ * could have taken it since the entry was marked. All removals are therefore
+ * announced with the next ttvn.
  */
 static void batadv_tt_local_purge_pending_clients(struct batadv_priv *bat_priv)
+	__must_hold(&bat_priv->tt.commit_lock)
 {
 	spinlock_t *list_lock; /* protects write access to the hash lists */
 	struct batadv_hashtable *hash = bat_priv->tt.local_hash;
@@ -4697,6 +4771,8 @@ static void batadv_tt_local_purge_pending_clients(struct batadv_priv *bat_priv)
 	struct hlist_head *head;
 	u32 i;
 
+	lockdep_assert_held(&bat_priv->tt.commit_lock);
+
 	if (!hash)
 		return;
 
@@ -4736,6 +4812,7 @@ static void batadv_tt_local_purge_pending_clients(struct batadv_priv *bat_priv)
 static void batadv_tt_local_commit_changes_nolock(struct batadv_priv *bat_priv)
 	__must_hold(&bat_priv->tt.commit_lock)
 {
+	struct batadv_tt_change_node *tt_change_node;
 	LIST_HEAD(changes_list);
 	int changes_num;
 
@@ -4758,9 +4835,12 @@ static void batadv_tt_local_commit_changes_nolock(struct batadv_priv *bat_priv)
 		return;
 	}
 
-	batadv_tt_local_transition_new(bat_priv);
+	/* bring the affected local entries into the state announced with the
+	 * new ttvn
+	 */
+	list_for_each_entry(tt_change_node, &changes_list, list)
+		batadv_tt_local_commit_change(bat_priv, &tt_change_node->change);
 
-	batadv_tt_local_purge_pending_clients(bat_priv);
 	batadv_tt_local_update_crc(bat_priv);
 
 	/* Increment the TTVN only once per OGM interval */

-- 
2.47.3

