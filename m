Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCEEFCA600B
	for <batman@archiver.kernel.org>; Thu,  8 Oct 2026 14:34:28 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 36DA181E84
	for <batman@archiver.kernel.org>; Thu, 08 Oct 2026 16:34:27 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1791470067;
 b=S+jxn0FYdfaAMNxEuuD89lyHs6hjf6O1uZws4hKgVqL33+ed2WH5FkjYBw8suL30G67c/
 ykrfDxiCohkWbbmxJXiYTJgQa/zx5rQnhQJbvwML/+2GjZRWF8YxVuvrWcWPoElThaw1bSq
 LIYbzClu/JC0H0EopLadifnSCqdiqLE=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1791470067; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=MjKL2xqmMrtweLvFfDrwTtFL7Ba+ie4yTgpgPLv1b2A=;
 b=FO+RR165hs81wUQSS5Z4HD+2ihAUNhqh9ge4ZMIgdcFmD/j1nopXzudF8wbIg/eGsVpEs
 srOaWXwVRGJEXDmcHiCCzeCT2CkreXNQT3djbSXPjPnzSWmUvnEkbz9YF9Oq92MHEQwC636
 qFtW1Kbb9GgIZZDBt1KEh2F0aioh40o=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id C4AE4842AC
	for <b.a.t.m.a.n@lists.open-mesh.org>; Thu, 08 Oct 2026 16:30:50 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1791469860;
	b=w0BCIQYKuD34I+4gPA95yH3MFQf7LmiMjE9rC7vO4ph4pc+IqHIUplGVjVNnKDRm72fJ7q
	2pmzYL+IgDUuSPOLe5smYnDhEFRtDSUABvLzXoZos46sneLbskRWUFjeylGWRsOp1cmq6T
	DtlfwoZ5/ixe5Am2LyE5IyNEwbrd1NM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1791469860;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=MjKL2xqmMrtweLvFfDrwTtFL7Ba+ie4yTgpgPLv1b2A=;
	b=a9TkqjmMP2ZffXrjQiLIKIMqt7Ao1zeY8phKF4m2Znh3YAvbycwyiQI/JEBbaixPvoEo9E
	z6JZ8j+z4u2BTEoey8ITbWubrFGATBCMJVNF7DEP51uu3t5zMMg1gAw6U9Qh/pw9BLlNcc
	+G8T4lpihwva4nKKBD3SzgpCL4x8mBk=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=iHblqy2C;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id 170411FEA4;
	Thu, 08 Oct 2026 14:30:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1791469850;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MjKL2xqmMrtweLvFfDrwTtFL7Ba+ie4yTgpgPLv1b2A=;
	b=iHblqy2CleDCYr/496fP2K4UFrvsGSDaWAYkWQeZLlNcH4SlU59bg9BOvWskxY6A5q1Fwq
	J4CdZlFjy8VBho6uW6OLz66Ti+h5DnBnAOJc7OMPQFneNVF1sMhSzE5oL0EIb9lUSD3HEv
	fh3vhvjjCz5KO8F9PySccd/beAXmbdg=
From: Sven Eckelmann <sven@narfation.org>
Date: Thu, 08 Oct 2026 16:30:11 +0200
Subject: [PATCH batadv v2 6/8] batman-adv: tt: don't queue local events for
 unhashed entries
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261008-tt-avoid-unhashed-event-v2-6-7c4eed81606d@narfation.org>
References: <20261008-tt-avoid-unhashed-event-v2-0-7c4eed81606d@narfation.org>
In-Reply-To: 
 <20261008-tt-avoid-unhashed-event-v2-0-7c4eed81606d@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>, Sashiko <sashiko-bot@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=14392; i=sven@narfation.org;
 h=from:subject:message-id; bh=cCvmyJKGtLdBSpdPdo/D7E2tRgtg8aIvR+0fGbGfCPs=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFnHV3z4oJDL9t7ptvUFq0De7rzLSzi73rq+efq10k2/0
 +XQn1u7O0pZGMS4GGTFFFn2XMk/v5n9rfznaR+PwsxhZQIZwsDFKQAT+ePLyLC+U6NYykSPo9gy
 Y4dbyo+pe77N+mecPyXyl4/DrnMZ4acZGW4anewRd1DWcRc4vz/NznrZDKctjFu4fsfLBG98dOR
 XDycA
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: RGGEQQXNH47V4ARN6ECRZFPEV43VXOXW
X-Message-ID-Hash: RGGEQQXNH47V4ARN6ECRZFPEV43VXOXW
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/RGGEQQXNH47V4ARN6ECRZFPEV43VXOXW/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

batadv_tt_local_add() and batadv_tt_local_remove() look up the local entry
via RCU only. batadv_tt_local_purge_pending_clients() or
batadv_tt_local_remove_now() can unhash it before the entry is modified and
an event is queued for it:

  CPU0                          CPU1
                                /* DEL#1 queued, PENDING set */
  batadv_tt_local_hash_find()
                                batadv_tt_local_commit_changes()
                                  ..._purge_pending_clients()
                                    hlist_del_rcu(&...->hash_entry);
                                  /* DEL#1 announced */
  batadv_tt_local_add_existing()
    flags &= ~..._PENDING;
  /* ADD queued for unhashed entry */

The queued event will then be announced for a client which is not part
anymore of the table (+ its CRC). A full table request in this and similar
scenarios is required to fix the inconsistency.

Only the hash bucket list_lock can ensure that an entry is still part of
the local table. Local entries are therefore unhashed with
hlist_del_init_rcu() to make hlist_unhashed() usable under this lock.

batadv_tt_local_add_existing() + batadv_tt_local_add_existing() need to be
merged together to ensure only a single locked region for
batadv_tt_local_add() instead of multiple ones.

Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260930094558.3723766-2-sw%40simonwunderlich.de?part=7
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/translation-table.c | 208 +++++++++++++++++++++----------------
 1 file changed, 117 insertions(+), 91 deletions(-)

diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index c6c4df57..3f1d6bea 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -929,55 +929,6 @@ static bool batadv_tt_iif_is_wifi(struct net *net, int ifindex)
 	return batadv_is_wifi(wifi_flags);
 }
 
-/**
- * batadv_tt_local_add_existing() - refresh an already known local TT entry
- * @bat_priv: the bat priv with all the mesh interface information
- * @tt_local: the local TT entry which was found in the local table
- * @roamed_back: set to true when the client returned to its original location
- *
- * Return: true when the client has to be announced to the mesh again, false
- * otherwise.
- */
-static bool batadv_tt_local_add_existing(struct batadv_priv *bat_priv,
-					 struct batadv_tt_local_entry *tt_local,
-					 bool *roamed_back)
-{
-	struct batadv_tt_common_entry *common = &tt_local->common;
-	bool readded = false;
-
-	tt_local->last_seen = jiffies;
-
-	scoped_guard(spinlock_bh, &common->flags_lock) {
-		if (common->flags & BATADV_TT_CLIENT_PENDING) {
-			batadv_dbg(BATADV_DBG_TT, bat_priv,
-				   "Re-adding pending client %pM (vid: %d)\n",
-				   common->addr, batadv_print_vid(common->vid));
-			/* whatever the reason why the PENDING flag was set,
-			 * this is a client which was enqueued to be removed in
-			 * this orig_interval. Since it popped up again, the
-			 * flag can be reset like it was never enqueued
-			 */
-			common->flags &= ~BATADV_TT_CLIENT_PENDING;
-			readded = true;
-		}
-
-		if (common->flags & BATADV_TT_CLIENT_ROAM) {
-			batadv_dbg(BATADV_DBG_TT, bat_priv,
-				   "Roaming client %pM (vid: %d) came back to its original location\n",
-				   common->addr, batadv_print_vid(common->vid));
-			/* the ROAM flag is set because this client roamed away
-			 * and the node got a roaming_advertisement message. Now
-			 * that the client popped up again at its original
-			 * location such flag can be unset
-			 */
-			common->flags &= ~BATADV_TT_CLIENT_ROAM;
-			*roamed_back = true;
-		}
-	}
-
-	return readded;
-}
-
 /**
  * batadv_tt_local_create() - allocate and initialize a local TT entry
  * @mesh_iface: netdev struct of the mesh interface
@@ -1050,27 +1001,76 @@ batadv_tt_local_create(struct net_device *mesh_iface, const u8 *addr,
 }
 
 /**
- * batadv_tt_local_update_flags() - update the dynamic flags of a local entry
+ * batadv_tt_local_refresh() - refresh a local TT entry of an active client
  * @bat_priv: the bat priv with all the mesh interface information
- * @tt_local: the local TT entry to update
+ * @tt_local: the local TT entry to refresh
  * @iif_is_wifi: whether the client is connected via a wifi interface
  * @mark: the value contained in the skb->mark field of the received packet (if
  *  any)
+ * @announce: whether an ADD event has to be queued even when no announced
+ *  flag was modified
+ * @roamed_back: set to true when the client returned to its original location
  *
- * Return: true if a flag announced to the other nodes was modified, false
- * otherwise.
+ * A pending removal of the entry is cancelled and its dynamic flags are
+ * updated. An ADD event is queued when @announce is set, the pending removal
+ * was cancelled or a flag announced to the other nodes was modified.
+ *
+ * Return: true if the entry was refreshed, false if it is no longer part of
+ * the local table.
  */
 static bool
-batadv_tt_local_update_flags(struct batadv_priv *bat_priv,
-			     struct batadv_tt_local_entry *tt_local,
-			     bool iif_is_wifi, u32 mark)
+batadv_tt_local_refresh(struct batadv_priv *bat_priv,
+			struct batadv_tt_local_entry *tt_local,
+			bool iif_is_wifi, u32 mark, bool announce,
+			bool *roamed_back)
 {
+	spinlock_t *list_lock; /* protects write access to the hash lists */
 	struct batadv_tt_common_entry *common = &tt_local->common;
+	struct batadv_hashtable *hash = bat_priv->tt.local_hash;
 	u8 remote_flags;
 	u32 match_mark;
-	bool modified;
+	u32 i;
+
+	i = batadv_choose_tt(common, hash->size);
+	list_lock = &hash->list_locks[i];
+
+	tt_local->last_seen = jiffies;
+
+	spin_lock_bh(list_lock);
+
+	/* the entry was removed from the local table after it was looked up */
+	if (hlist_unhashed(&common->hash_entry)) {
+		spin_unlock_bh(list_lock);
+		return false;
+	}
 
 	scoped_guard(spinlock_bh, &common->flags_lock) {
+		if (common->flags & BATADV_TT_CLIENT_PENDING) {
+			batadv_dbg(BATADV_DBG_TT, bat_priv,
+				   "Re-adding pending client %pM (vid: %d)\n",
+				   common->addr, batadv_print_vid(common->vid));
+			/* whatever the reason why the PENDING flag was set,
+			 * this is a client which was enqueued to be removed in
+			 * this orig_interval. Since it popped up again, the
+			 * flag can be reset like it was never enqueued
+			 */
+			common->flags &= ~BATADV_TT_CLIENT_PENDING;
+			announce = true;
+		}
+
+		if (common->flags & BATADV_TT_CLIENT_ROAM) {
+			batadv_dbg(BATADV_DBG_TT, bat_priv,
+				   "Roaming client %pM (vid: %d) came back to its original location\n",
+				   common->addr, batadv_print_vid(common->vid));
+			/* the ROAM flag is set because this client roamed away
+			 * and the node got a roaming_advertisement message. Now
+			 * that the client popped up again at its original
+			 * location such flag can be unset
+			 */
+			common->flags &= ~BATADV_TT_CLIENT_ROAM;
+			*roamed_back = true;
+		}
+
 		/* store the current remote flags before altering them. This
 		 * helps understanding is flags are changing or not
 		 */
@@ -1092,10 +1092,17 @@ batadv_tt_local_update_flags(struct batadv_priv *bat_priv,
 		else
 			common->flags &= ~BATADV_TT_CLIENT_ISOLA;
 
-		modified = remote_flags ^ (common->flags & BATADV_TT_REMOTE_MASK);
+		if (remote_flags ^ (common->flags & BATADV_TT_REMOTE_MASK))
+			announce = true;
+
+		if (announce)
+			__batadv_tt_local_event(bat_priv, common,
+						common->flags);
 	}
 
-	return modified;
+	spin_unlock_bh(list_lock);
+
+	return true;
 }
 
 /**
@@ -1118,7 +1125,6 @@ bool batadv_tt_local_add(struct net_device *mesh_iface, const u8 *addr,
 	struct batadv_tt_global_entry *tt_global = NULL;
 	struct batadv_tt_local_entry *tt_local;
 	bool roamed_back = false;
-	bool added = false;
 	bool iif_is_wifi;
 	bool ret = false;
 	int hash_added;
@@ -1130,10 +1136,15 @@ bool batadv_tt_local_add(struct net_device *mesh_iface, const u8 *addr,
 	if (!is_multicast_ether_addr(addr))
 		tt_global = batadv_tt_global_hash_find(bat_priv, addr, vid);
 
-	if (tt_local) {
-		added = batadv_tt_local_add_existing(bat_priv, tt_local,
-						     &roamed_back);
-	} else {
+	if (tt_local &&
+	    !batadv_tt_local_refresh(bat_priv, tt_local, iif_is_wifi, mark,
+				     false, &roamed_back)) {
+		/* stale entry which has to be replaced by a new one */
+		batadv_tt_local_entry_put(tt_local);
+		tt_local = NULL;
+	}
+
+	if (!tt_local) {
 		tt_local = batadv_tt_local_create(mesh_iface, addr, vid, iif_is_wifi);
 		if (!tt_local)
 			goto out;
@@ -1149,21 +1160,12 @@ bool batadv_tt_local_add(struct net_device *mesh_iface, const u8 *addr,
 			goto out;
 		}
 
-		added = true;
+		batadv_tt_local_refresh(bat_priv, tt_local, iif_is_wifi, mark,
+					true, &roamed_back);
 	}
 
-	/* announce the (re-)added client to the mesh */
-	if (added)
-		batadv_tt_local_event(bat_priv, tt_local, BATADV_NO_FLAGS);
-
 	batadv_tt_local_add_roam(bat_priv, tt_global, roamed_back);
 
-	/* if any "dynamic" flag has been modified, resend an ADD event for this
-	 * entry so that all the nodes can get the new flags
-	 */
-	if (batadv_tt_local_update_flags(bat_priv, tt_local, iif_is_wifi, mark))
-		batadv_tt_local_event(bat_priv, tt_local, BATADV_NO_FLAGS);
-
 	ret = true;
 out:
 	batadv_tt_local_entry_put(tt_local);
@@ -1632,10 +1634,14 @@ int batadv_tt_local_dump(struct sk_buff *msg, struct netlink_callback *cb)
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
@@ -1668,11 +1674,14 @@ batadv_tt_local_set_pending(struct batadv_priv *bat_priv,
  * @roaming: true if the deletion is due to a roaming event
  * @curr_flags: pointer to store the flags of the entry before it was marked
  *
- * An already announced entry is marked as BATADV_TT_CLIENT_PENDING and the
- * (roamed) DEL change is queued. Both happen under the hash bucket list_lock
- * of the entry to prevent concurrent batadv_tt_local_purge_pending_clients()
- * from removing the entry and batadv_tt_local_transition_new() from clearing
- * BATADV_TT_CLIENT_NEW after it was checked.
++ * For an already announced entry, the (roamed) DEL change is queued and the
++ * entry is marked as BATADV_TT_CLIENT_PENDING by batadv_tt_local_set_pending().
+  *
++ * An entry which still carries BATADV_TT_CLIENT_NEW is not marked. The caller
++ * has to purge it via batadv_tt_local_remove_now().
++ *
++ * An entry which was already removed from the local table after it was looked
++ * up is ignored and BATADV_NO_FLAGS is stored in @curr_flags.
  *
  * Return: true if the entry has to be kept in the local table until the next
  * ttvn increment, false if it can be purged immediately.
@@ -1694,6 +1703,12 @@ batadv_tt_local_mark_removed(struct batadv_priv *bat_priv,
 
 	spin_lock_bh(list_lock);
 
+	if (hlist_unhashed(&common->hash_entry)) {
+		*curr_flags = BATADV_NO_FLAGS;
+		spin_unlock_bh(list_lock);
+		return true;
+	}
+
 	scoped_guard(spinlock_bh, &common->flags_lock) {
 		*curr_flags = common->flags;
 
@@ -1737,15 +1752,24 @@ static void
 batadv_tt_local_remove_now(struct batadv_priv *bat_priv,
 			   struct batadv_tt_local_entry *tt_local_entry)
 {
+	spinlock_t *list_lock; /* protects write access to the hash lists */
 	struct batadv_tt_common_entry *common = &tt_local_entry->common;
-	struct hlist_node *tt_removed_node;
+	struct batadv_hashtable *hash = bat_priv->tt.local_hash;
+	u32 i;
+
+	i = batadv_choose_tt(common, hash->size);
+	list_lock = &hash->list_locks[i];
+
+	spin_lock_bh(list_lock);
 
 	/* remove exactly this object when still present in hash */
-	tt_removed_node = batadv_hash_remove(bat_priv->tt.local_hash,
-					     batadv_compare_tt_entry,
-					     batadv_choose_tt, common);
-	if (!tt_removed_node)
+	if (hlist_unhashed(&common->hash_entry)) {
+		spin_unlock_bh(list_lock);
 		return;
+	}
+
+	hlist_del_init_rcu(&common->hash_entry);
+	atomic_inc(&hash->generation);
 
 	batadv_tt_local_event(bat_priv, tt_local_entry, BATADV_TT_CLIENT_DEL);
 
@@ -1756,6 +1780,8 @@ batadv_tt_local_remove_now(struct batadv_priv *bat_priv,
 	if (!(batadv_tt_flags_get(common) & BATADV_TT_CLIENT_NEW))
 		batadv_tt_local_size_dec(bat_priv, common->vid);
 
+	spin_unlock_bh(list_lock);
+
 	/* drop reference of remove hash entry */
 	batadv_tt_local_entry_put(tt_local_entry);
 }
@@ -1885,7 +1911,7 @@ static void batadv_tt_local_table_free(struct batadv_priv *bat_priv)
 		spin_lock_bh(list_lock);
 		hlist_for_each_entry_safe(tt_common_entry, node_tmp,
 					  head, hash_entry) {
-			hlist_del_rcu(&tt_common_entry->hash_entry);
+			hlist_del_init_rcu(&tt_common_entry->hash_entry);
 			tt_local = container_of(tt_common_entry,
 						struct batadv_tt_local_entry,
 						common);
@@ -4451,7 +4477,7 @@ static void batadv_tt_local_purge_pending_clients(struct batadv_priv *bat_priv)
 					   tt_common->addr,
 					   batadv_print_vid(tt_common->vid));
 
-				hlist_del_rcu(&tt_common->hash_entry);
+				hlist_del_init_rcu(&tt_common->hash_entry);
 
 				/* An entry which still carries BATADV_TT_CLIENT_NEW was
 				 * never counted and must not be uncounted here.

-- 
2.47.3

