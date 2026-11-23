Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F0D3606A31A
	for <batman@archiver.kernel.org>; Mon, 23 Nov 2026 17:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=simonwunderlich.de header.i=@simonwunderlich.de header.a=rsa-sha256 header.s=09092022 header.b=PjPs9Fhl
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 8C9DB8465F
	for <batman@archiver.kernel.org>; Mon, 23 Nov 2026 18:19:54 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1795454394;
 b=TI8tPu5f7wqNgEvkSCPhXS9y401y5ndfMVCfAsV+cCrtD6PlkrbJDWWo/CCiMaqjCPuyD
 eUPEWKkBwuTmOJU4mWPs58+fNjVfA6ul+SWV7uOwekZRe9kD0JTgn1EHj/zkHMbmVB76AHo
 tZRhU/F65ww6AjBv0f4clCU3inS8bSc=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1795454394; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=HTSxq5AdXzXnAkXTGC23vo77Fv+9+l048NGGD4ATRx0=;
 b=YkQhlNYI6nJGX3LOvAMpE96GgT1PRkPWL4iaKu0bPJSfARDWbSGLLY6lamPYx0XMswJV4
 PsztIGCPtPKDzqmVHGwqTcjYPai0D09xwga0dWmZg3S/lyKctcUiCxjInIyTF4+Y7EzqdNx
 CtN7cuxPGNvAj3S1g4gE6WXe9Hq/VcA=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass header.from=simonwunderlich.de policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=simonwunderlich.de policy.dmarc=none
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de
 [IPv6:2a01:4f8:c17:e8c0::1])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id CF128830EF
	for <b.a.t.m.a.n@lists.open-mesh.org>; Mon, 23 Nov 2026 18:18:42 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1795454322;
	b=MVmpQ7I6x7f0uftSBvM7MZu/xlIyDsew8WZTKk8drn9PiD5hiC1Wsvo9pHFVZOpCt43CtH
	MeMz5atnZnm/CblFKcBIPRifJsLhg9z0ULOcDpzoI8eZxL9vwlxolj0M2aGPQ/VPtpLf5k
	Dw/iAwxXw7X7bgxWPC2ygayZYIDIWQg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1795454322;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=HTSxq5AdXzXnAkXTGC23vo77Fv+9+l048NGGD4ATRx0=;
	b=awq0xXVRRI7tPIezPE0FdPmdCTEIDgkCnHSAedlpOVkjKdgAmMbtbB1/5JduMvjQYoUYG+
	TTCgmvgVHqjwNBMpw3hihK42+utB94Z7o4TR4gA6IV1YFhjHeSFgD4J6F03G05zYCOdTpA
	mteIdNQXYq6sjecsOypbuw4fbI/Dsog=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=simonwunderlich.de header.s=09092022 header.b=PjPs9Fhl;
	dmarc=pass (policy=none) header.from=simonwunderlich.de;
	spf=pass (diktynna.open-mesh.org: domain of sw@simonwunderlich.de designates
 2a01:4f8:c17:e8c0::1 as permitted sender) smtp.mailfrom=sw@simonwunderlich.de
Received: from kero.packetmixer.de
 (p200300C59714c2E05a704819b6BA2db4.dip0.t-ipconnect.de
 [IPv6:2003:c5:9714:c2e0:5a70:4819:b6ba:2db4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by mail.simonwunderlich.de (Postfix) with UTF8SMTPSA id A0E14FA3E1;
	Mon, 23 Nov 2026 18:18:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1795454319;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HTSxq5AdXzXnAkXTGC23vo77Fv+9+l048NGGD4ATRx0=;
	b=PjPs9FhlDvXPCiBzJ7gaAKLYxthPHgTeEg+8SL7fKk624ew3+ukufVL6YHj3UtjYvgMguv
	e1fdaK5nyosLEcPspAwzuvPuJSFHZQupkvYDDrUhgJTYoG3lna/7jGTCxoNSgf4EPOEVLT
	ZNt6NeZv0OvK5Tl9NaLbWaGb0aTnHT7tusec3K45MX29vL+QYDOL5gLUl31dPU/B4Zh0s0
	1AZXSF0sZ6pBEb/4jPfZp5SL8Ld3RUV77Wcvl1AJHo1u+TaxjtU9wEuTFhoqvPgT6iURD5
	8RaG2AnuKHV9pevoM2lHOwSgGAe7HakgGrRsBb/LMRUkFOzlfEtpoGFANecLIg==
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
Subject: [PATCH net-next 08/15] batman-adv: tt: don't queue local events for
 unhashed entries
Date: Mon, 23 Nov 2026 18:18:20 +0100
Message-ID: <20261123171827.3294525-9-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261123171827.3294525-1-sw@simonwunderlich.de>
References: <20261123171827.3294525-1-sw@simonwunderlich.de>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: Y47RTPWXLDAAE2OB2QSBUXNYQR6W27EX
X-Message-ID-Hash: Y47RTPWXLDAAE2OB2QSBUXNYQR6W27EX
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/Y47RTPWXLDAAE2OB2QSBUXNYQR6W27EX/>
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
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/translation-table.c | 156 ++++++++++++++++++++++++-----
 1 file changed, 129 insertions(+), 27 deletions(-)

diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index 7968931d5d3c..2828e362640a 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -966,7 +966,7 @@ batadv_tt_local_create(struct net_device *mesh_iface, const u8 *addr,
 }
 
 /**
- * batadv_tt_local_refresh() - refresh a local TT entry of an active client
+ * batadv_tt_local_refresh_locked() - refresh a hashed local TT entry
  * @bat_priv: the bat priv with all the mesh interface information
  * @tt_local: the local TT entry to refresh
  * @iif_is_wifi: whether the client is connected via a wifi interface
@@ -980,19 +980,23 @@ batadv_tt_local_create(struct net_device *mesh_iface, const u8 *addr,
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
@@ -1053,6 +1057,109 @@ batadv_tt_local_refresh(struct batadv_priv *bat_priv,
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
@@ -1073,10 +1180,9 @@ bool batadv_tt_local_add(struct net_device *mesh_iface, const u8 *addr,
 	struct batadv_tt_global_entry *tt_global = NULL;
 	struct batadv_tt_local_entry *tt_local;
 	bool roamed_back = false;
-	bool added = false;
 	bool iif_is_wifi;
 	bool ret = false;
-	int hash_added;
+	int err;
 
 	iif_is_wifi = batadv_tt_iif_is_wifi(dev_net(mesh_iface), ifindex);
 
@@ -1086,30 +1192,26 @@ bool batadv_tt_local_add(struct net_device *mesh_iface, const u8 *addr,
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

