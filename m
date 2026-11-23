Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D2D9606A31A
	for <batman@archiver.kernel.org>; Mon, 23 Nov 2026 17:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=simonwunderlich.de header.i=@simonwunderlich.de header.a=rsa-sha256 header.s=09092022 header.b=bk8I2dFe
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id E154885ACD
	for <batman@archiver.kernel.org>; Mon, 23 Nov 2026 18:25:59 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1795454759;
 b=314qoLG0fzNBcobNhui71rClP8E2oSdUGDhi+12ViYsyC3HbX+duFsuFqKOlsYBFEuUkK
 JE2zvQPOeGjD5vidcJkZQn39DeetffpgIjFCOh4ePMIrPI41mmeI35O3rAZUCBWTy280OZ9
 4MaQ/73aJ3Xo+tG2D/owWrtYCF7y25w=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1795454759; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=lY4IWR5RE8JRCHshy73LQhprhIq63vBxF10mAmpq+G0=;
 b=VjE1tH72VEs5ekSRhLJDiJ8Bo/EYWFaz002J7xF9tJN0Jeu9m5VDgrCwdAqc0Ivelpppa
 OG1c07GHW9JOJJBsrT9BQZW5nzEdfZsjEoID5xqMi4FdNb3cN978h02F4CfUbhAEUtdnc7Z
 I7hSmNstArj0nMVtrwwbnH8ioFlRcf0=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass header.from=simonwunderlich.de policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=simonwunderlich.de policy.dmarc=none
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de
 [IPv6:2a01:4f8:c17:e8c0::1])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id CB7B38465E
	for <b.a.t.m.a.n@lists.open-mesh.org>; Mon, 23 Nov 2026 18:18:46 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1795454336;
	b=Vjfmu3y+EclGJRwdtI+FhMoaTGck0v52C9KArlrzIIUBd5jT64vAmQLH3GKsEQBKjdiWvr
	jurUBi/ozNxvNp/UhKBQBDajt3Qp17RJ+aLG08/+WsNKk1csDw2L5BEIP5SJTMGYLxcQCM
	7+jpumlGHm1Ih7jOJXl/qvjcTMZOVcA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1795454336;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=lY4IWR5RE8JRCHshy73LQhprhIq63vBxF10mAmpq+G0=;
	b=hDcy2Vt+/3aJ8dq47Z4IFxNOKfFtNSpCl/g1CX9pE2vb8Z50S04k6lSendr+Sw6QaBFsxI
	3TvlWzDQQ3PIkMzXk1a72HXGcU/J+v+frlNX9LjS5kd4m8sUkrsPFb+Ta5hIJrFdht0Kh0
	fKigK2sSuV3Ye+RLtz+JIr81Dpc4uUY=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=simonwunderlich.de header.s=09092022 header.b=bk8I2dFe;
	dmarc=pass (policy=none) header.from=simonwunderlich.de;
	spf=pass (diktynna.open-mesh.org: domain of sw@simonwunderlich.de designates
 2a01:4f8:c17:e8c0::1 as permitted sender) smtp.mailfrom=sw@simonwunderlich.de
Received: from kero.packetmixer.de
 (p200300C59714C2E05A704819B6BA2DB4.dip0.t-ipconnect.de
 [IPv6:2003:c5:9714:c2e0:5a70:4819:b6ba:2db4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by mail.simonwunderlich.de (Postfix) with UTF8SMTPSA id 331BEFA039;
	Mon, 23 Nov 2026 18:18:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1795454326;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lY4IWR5RE8JRCHshy73LQhprhIq63vBxF10mAmpq+G0=;
	b=bk8I2dFeg2fKzKr4mEfeV3d6bx/gVMgwmhyyAAKbyUFd+MZf6DY9aC88xU04Ul+QvpkOx8
	gjj6nnZJtm6+XivTmBkQiXalC8XOygYeizPhyxdSYj8yJsDMzYQFBHDGFdAdaj0Ya9YKJB
	hgfx9kroo9C3nDiTbfeKAviQzDqCFw6zDV/LnAl2mB5qep7g7YO41uz6wmQmzKMsqf6RSu
	nf+T5NNXmdR0lwc4Q2iwSolOYDZHxR713M+dDnldGUfxTlVY9jVCslX8Pdk+uo0fdNJLe5
	bMGKh3GmVL9IWSv4RRpfxwFc/A+rsoDxFp+QjTG/aBJUqx2roeBGlGnXIhxFRw==
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
Subject: [PATCH net-next 13/15] batman-adv: tt: commit only the announced
 local changes
Date: Mon, 23 Nov 2026 18:18:25 +0100
Message-ID: <20261123171827.3294525-14-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261123171827.3294525-1-sw@simonwunderlich.de>
References: <20261123171827.3294525-1-sw@simonwunderlich.de>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: CXJO7ZTSFK5A3N7VD4X4XTUGLWAJ5UJA
X-Message-ID-Hash: CXJO7ZTSFK5A3N7VD4X4XTUGLWAJ5UJA
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/CXJO7ZTSFK5A3N7VD4X4XTUGLWAJ5UJA/>
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
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/translation-table.c | 176 +++++++++++++++++++++--------
 1 file changed, 128 insertions(+), 48 deletions(-)

diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index 2a7f50de70fc..b03d6c74732f 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -539,6 +539,12 @@ static void batadv_tt_local_size_inc(struct batadv_priv *bat_priv,
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
@@ -1876,9 +1882,8 @@ batadv_tt_local_set_pending(struct batadv_priv *bat_priv,
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
@@ -4545,49 +4550,6 @@ void batadv_tt_free(struct batadv_priv *bat_priv)
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
@@ -4625,6 +4587,112 @@ batadv_tt_local_unhash_pending(struct batadv_priv *bat_priv,
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
@@ -4633,8 +4701,14 @@ batadv_tt_local_unhash_pending(struct batadv_priv *bat_priv,
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
@@ -4644,6 +4718,8 @@ static void batadv_tt_local_purge_pending_clients(struct batadv_priv *bat_priv)
 	struct hlist_head *head;
 	u32 i;
 
+	lockdep_assert_held(&bat_priv->tt.commit_lock);
+
 	if (!hash)
 		return;
 
@@ -4683,6 +4759,7 @@ static void batadv_tt_local_purge_pending_clients(struct batadv_priv *bat_priv)
 static void batadv_tt_local_commit_changes_nolock(struct batadv_priv *bat_priv)
 	__must_hold(&bat_priv->tt.commit_lock)
 {
+	struct batadv_tt_change_node *tt_change_node;
 	LIST_HEAD(changes_list);
 	int changes_num;
 
@@ -4705,9 +4782,12 @@ static void batadv_tt_local_commit_changes_nolock(struct batadv_priv *bat_priv)
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

