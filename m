Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58641606A331
	for <batman@archiver.kernel.org>; Sat, 14 Nov 2026 09:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=simonwunderlich.de header.i=@simonwunderlich.de header.a=rsa-sha256 header.s=09092022 header.b=CTMwBu1t
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 4FBCE85573
	for <batman@archiver.kernel.org>; Sat, 14 Nov 2026 10:18:40 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1794647920;
 b=17u3Qdf2OID9aNFQIkADC8MUN0owlyOghUZxvFOVHofAKVLMC54CstYnuftkj8RAB2Kp7
 SgkdcQbE1j27k3b5kFdTtV9J5IbYo1qsmtozf/byYdUTxHIrOkiIj8QdmXWhtNreimG32j8
 vsXJM/BP1LZ68RUorpmWWf7VoxFKA4o=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1794647920; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=v76jbwDZwmkf8IJxkPO8WMVckr4cZKmtfvFMD3V2Opo=;
 b=j8BGfo2vH8B+EZnlQq4cbKI7ZFJ2Z6COhsKMfoXg58BcFdbPpla/ByRVukJAAprJV8Xj2
 104UCkSd/4lS69aZUvSwXJJLmX4YzKJFarK5gFokoWrW9XjcUNiL5mfem6P3Ck5Ei+caS/x
 VwPoBplMJrnW1hzkFmnQ8zAt/FWwDw4=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass header.from=simonwunderlich.de policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=simonwunderlich.de policy.dmarc=none
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de
 [IPv6:2a01:4f8:c17:e8c0::1])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id E4C1B82269
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sat, 14 Nov 2026 10:16:02 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1794647772;
	b=I4osdjjNC73duUsddldXfh6sQl9GepbIZsJ9UoxPkLdgRNNCAORbNsdGxyip3hXmItW3vX
	71d9xt0OV7I+RS+YsWaPPGrQ5iDQnPeEvvBJMB2sXyM8azzZBUKTeHEzq2JGDNat65beHk
	7VerNI91JQ/3GGn5Sgkq3Re7qdtku50=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1794647772;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=v76jbwDZwmkf8IJxkPO8WMVckr4cZKmtfvFMD3V2Opo=;
	b=X0E+2QmrSwUZzOvbGmUMykpfBGRwASsPEywqYLA3+Up9fpliCLSyOqevkIQ11jukY4FTjM
	VhUskcSYhErMMw63s97OIQSWB/LWegOiQMSL1onmFh5T3nceJY0zBJFLD7Ep0UCmhtyIzE
	bJ4MUWSSc03bch6pHr+Ts34EvXxJbSY=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=simonwunderlich.de header.s=09092022 header.b=CTMwBu1t;
	spf=pass (diktynna.open-mesh.org: domain of sw@simonwunderlich.de designates
 2a01:4f8:c17:e8c0::1 as permitted sender)
 smtp.mailfrom=sw@simonwunderlich.de;
	dmarc=pass (policy=none) header.from=simonwunderlich.de
Received: from kero.packetmixer.de (unknown
 [IPv6:2a02:3037:6ed:dd6c:838:344b:3152:2d5e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by mail.simonwunderlich.de (Postfix) with UTF8SMTPSA id 1D052FA1B1;
	Sat, 14 Nov 2026 10:16:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1794647762;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=v76jbwDZwmkf8IJxkPO8WMVckr4cZKmtfvFMD3V2Opo=;
	b=CTMwBu1tgDBxviMkoWs2Humr35UmBnJCSfopC3PavhuxPb1GGfhldMy4EwTjs1iCk95tmo
	HkYhyIA6TYX27NOaAos5eDu8R7L5A9inorzFRrY8nmQaOawQAFSfgqHJ5PtyQHjkC5JWHf
	st15wIlvzP2XeSE0DJy8ZFkbC+9jp6LEpAQ2dLvi2vfLr99cl7hjoePZQpXABNdeZccVp9
	/Dzv3TQQ+qUnF8KjX40gvJWPeIc9rbi3wX4ig7mFendU7wSLFvSmwr+pEdHLiHkBGfbN5k
	GQQZ3s/ckm/fVUom2vD69edMQlInZFjDjkWtEoA5lnvZHEOvBvJIAnXhHyVUsg==
From: Simon Wunderlich <sw@simonwunderlich.de>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	b.a.t.m.a.n@lists.open-mesh.org,
	Sven Eckelmann <sven@narfation.org>,
	Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH net-next 04/15] batman-adv: tt: use dedicated key type for
 hashes
Date: Sat, 14 Nov 2026 10:15:45 +0100
Message-ID: <20261114091556.3336038-5-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261114091556.3336038-1-sw@simonwunderlich.de>
References: <20261114091556.3336038-1-sw@simonwunderlich.de>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: 726MN5ATU7IOU7EDY3KZFUF37OAZEHOZ
X-Message-ID-Hash: 726MN5ATU7IOU7EDY3KZFUF37OAZEHOZ
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/726MN5ATU7IOU7EDY3KZFUF37OAZEHOZ/>
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

The TT hash lookup functions are given a struct batadv_tt_common_entry.
For a lookup, a dummy TT entry is created on the stack and only its addr
and vid members are filled. All other members stay uninitialized, and
only by reading the hash and compare callbacks can one tell which
members form the key.

Move addr and vid into a new struct batadv_tt_common_entry_key, embedded as
batadv_tt_common_entry::key. The helpers are only using this key for
hashing/comparison.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/translation-table.c | 177 +++++++++++++++--------------
 net/batman-adv/types.h             |  13 ++-
 2 files changed, 101 insertions(+), 89 deletions(-)

diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index 50f24a3ad0ea0..926b4a3214196 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -81,60 +81,62 @@ static void batadv_tt_global_del(struct batadv_priv *bat_priv,
 				 bool roaming);
 
 /**
- * batadv_compare_tt() - check if two TT entries are the same
- * @node: the list element pointer of the first TT entry
- * @data2: pointer to the tt_common_entry of the second TT entry
+ * batadv_compare_tt() - check if a TT entry has the given key
+ * @node: the list element pointer of the TT entry
+ * @data2: &struct batadv_tt_common_entry_key to compare with
  *
- * Compare the MAC address and the VLAN ID of the two TT entries and check if
- * they are the same TT client.
- * Return: true if the two TT clients are the same, false otherwise
+ * Compare the MAC address and the VLAN ID of the TT entry with the key and
+ * check if they are the same TT client.
+ * Return: true if the TT entry has the given key, false otherwise
  */
 static bool batadv_compare_tt(const struct hlist_node *node, const void *data2)
 {
-	const void *data1 = container_of(node, struct batadv_tt_common_entry,
-					 hash_entry);
-	const struct batadv_tt_common_entry *tt1 = data1;
-	const struct batadv_tt_common_entry *tt2 = data2;
+	const struct batadv_tt_common_entry_key *key = data2;
+	const struct batadv_tt_common_entry *tt;
+
+	tt = container_of(node, struct batadv_tt_common_entry, hash_entry);
 
-	return (tt1->vid == tt2->vid) && batadv_compare_eth(data1, data2);
+	return tt->key.vid == key->vid &&
+	       batadv_compare_eth(tt->key.addr, key->addr);
 }
 
 /**
  * batadv_compare_tt_entry() - check if a hash node is a specific TT entry
  * @node: the list element pointer of the TT entry stored in the bucket
- * @data2: pointer to the tt_common_entry which is looked for
+ * @data2: &batadv_tt_common_entry.key of the TT entry which is looked for
  *
- * Unlike batadv_compare_tt(), this only matches the very object which is
- * passed as @data2 and not just any entry for the same TT client. It is meant
- * for batadv_hash_remove() callers which must not unlink an entry they did not
- * look up themselves.
+ * Unlike batadv_compare_tt(), this only matches the very object which embeds
+ * the key passed as @data2 and not just any entry for the same TT client. It is
+ * meant for batadv_hash_remove() callers which must not unlink an entry they
+ * did not look up themselves.
  *
- * Return: true if @node belongs to @data2, false otherwise
+ * Return: true if @node belongs to the entry of @data2, false otherwise
  */
 static bool batadv_compare_tt_entry(const struct hlist_node *node,
 				    const void *data2)
 {
-	const struct batadv_tt_common_entry *tt = data2;
+	const struct batadv_tt_common_entry *tt;
+
+	tt = container_of(data2, struct batadv_tt_common_entry, key);
 
 	return node == &tt->hash_entry;
 }
 
 /**
  * batadv_choose_tt() - return the index of the tt entry in the hash table
- * @data: pointer to the tt_common_entry object to map
+ * @data: &struct batadv_tt_common_entry_key to map
  * @size: the size of the hash table
  *
- * Return: the hash index where the object represented by 'data' should be
+ * Return: the hash index where the object with the key 'data' should be
  * stored at.
  */
 static inline u32 batadv_choose_tt(const void *data, u32 size)
 {
-	const struct batadv_tt_common_entry *tt;
+	const struct batadv_tt_common_entry_key *key = data;
 	u32 hash = 0;
 
-	tt = data;
-	hash = jhash(&tt->addr, ETH_ALEN, hash);
-	hash = jhash(&tt->vid, sizeof(tt->vid), hash);
+	hash = jhash(&key->addr, ETH_ALEN, hash);
+	hash = jhash(&key->vid, sizeof(key->vid), hash);
 
 	return hash % size;
 }
@@ -153,7 +155,7 @@ batadv_tt_hash_find(struct batadv_hashtable *hash, const u8 *addr,
 		    unsigned short vid)
 {
 	struct batadv_tt_common_entry *tt_tmp = NULL;
-	struct batadv_tt_common_entry to_search;
+	struct batadv_tt_common_entry_key key;
 	struct batadv_tt_common_entry *tt;
 	struct hlist_head *head;
 	u32 index;
@@ -161,18 +163,15 @@ batadv_tt_hash_find(struct batadv_hashtable *hash, const u8 *addr,
 	if (!hash)
 		return NULL;
 
-	ether_addr_copy(to_search.addr, addr);
-	to_search.vid = vid;
+	ether_addr_copy(key.addr, addr);
+	key.vid = vid;
 
-	index = batadv_choose_tt(&to_search, hash->size);
+	index = batadv_choose_tt(&key, hash->size);
 	head = &hash->table[index];
 
 	rcu_read_lock();
 	hlist_for_each_entry_rcu(tt, head, hash_entry) {
-		if (!batadv_compare_eth(tt, addr))
-			continue;
-
-		if (tt->vid != vid)
+		if (!batadv_compare_tt(&tt->hash_entry, &key))
 			continue;
 
 		if (!kref_get_unless_zero(&tt->refcount))
@@ -667,8 +666,8 @@ static void __batadv_tt_local_event(struct batadv_priv *bat_priv,
 
 	memset(tt_change_node->change.reserved, 0,
 	       sizeof(tt_change_node->change.reserved));
-	ether_addr_copy(tt_change_node->change.addr, common->addr);
-	tt_change_node->change.vid = htons(common->vid);
+	ether_addr_copy(tt_change_node->change.addr, common->key.addr);
+	tt_change_node->change.vid = htons(common->key.vid);
 
 	del_op_requested = flags & BATADV_TT_CLIENT_DEL;
 
@@ -686,7 +685,7 @@ static void __batadv_tt_local_event(struct batadv_priv *bat_priv,
 	changes = READ_ONCE(bat_priv->tt.local_changes);
 	list_for_each_entry_safe(entry, safe, &bat_priv->tt.changes_list,
 				 list) {
-		if (!batadv_compare_eth(entry->change.addr, common->addr))
+		if (!batadv_compare_eth(entry->change.addr, common->key.addr))
 			continue;
 
 		if (entry->change.vid != tt_change_node->change.vid)
@@ -802,14 +801,14 @@ static void batadv_tt_global_free(struct batadv_priv *bat_priv,
 
 	batadv_dbg(BATADV_DBG_TT, bat_priv,
 		   "Deleting global tt entry %pM (vid: %d): %s\n",
-		   tt_global->common.addr,
-		   batadv_print_vid(tt_global->common.vid), message);
+		   tt_global->common.key.addr,
+		   batadv_print_vid(tt_global->common.key.vid), message);
 
 	/* remove exactly this object when still present in hash */
 	tt_removed_node = batadv_hash_remove(bat_priv->tt.global_hash,
 					     batadv_compare_tt_entry,
 					     batadv_choose_tt,
-					     &tt_global->common);
+					     &tt_global->common.key);
 	if (!tt_removed_node)
 		return;
 
@@ -865,8 +864,8 @@ static void batadv_tt_local_add_roam(struct batadv_priv *bat_priv,
 	head = &tt_global->orig_list;
 	rcu_read_lock();
 	hlist_for_each_entry_rcu(orig_entry, head, list) {
-		batadv_send_roam_adv(bat_priv, tt_global->common.addr,
-				     tt_global->common.vid,
+		batadv_send_roam_adv(bat_priv, tt_global->common.key.addr,
+				     tt_global->common.key.vid,
 				     orig_entry->orig_node);
 	}
 	rcu_read_unlock();
@@ -923,7 +922,8 @@ static bool batadv_tt_local_add_existing(struct batadv_priv *bat_priv,
 		if (common->flags & BATADV_TT_CLIENT_PENDING) {
 			batadv_dbg(BATADV_DBG_TT, bat_priv,
 				   "Re-adding pending client %pM (vid: %d)\n",
-				   common->addr, batadv_print_vid(common->vid));
+				   common->key.addr,
+				   batadv_print_vid(common->key.vid));
 			/* whatever the reason why the PENDING flag was set,
 			 * this is a client which was enqueued to be removed in
 			 * this orig_interval. Since it popped up again, the
@@ -936,7 +936,8 @@ static bool batadv_tt_local_add_existing(struct batadv_priv *bat_priv,
 		if (common->flags & BATADV_TT_CLIENT_ROAM) {
 			batadv_dbg(BATADV_DBG_TT, bat_priv,
 				   "Roaming client %pM (vid: %d) came back to its original location\n",
-				   common->addr, batadv_print_vid(common->vid));
+				   common->key.addr,
+				   batadv_print_vid(common->key.vid));
 			/* the ROAM flag is set because this client roamed away
 			 * and the node got a roaming_advertisement message. Now
 			 * that the client popped up again at its original
@@ -998,8 +999,8 @@ batadv_tt_local_create(struct net_device *mesh_iface, const u8 *addr,
 		   addr, batadv_print_vid(vid),
 		   (u8)atomic_read(&bat_priv->tt.vn));
 
-	ether_addr_copy(tt_local->common.addr, addr);
-	tt_local->common.vid = vid;
+	ether_addr_copy(tt_local->common.key.addr, addr);
+	tt_local->common.key.vid = vid;
 	kref_init(&tt_local->common.refcount);
 	last_seen = jiffies;
 	WRITE_ONCE(tt_local->last_seen, last_seen);
@@ -1114,7 +1115,7 @@ bool batadv_tt_local_add(struct net_device *mesh_iface, const u8 *addr,
 
 		kref_get(&tt_local->common.refcount);
 		hash_added = batadv_hash_add(bat_priv->tt.local_hash, batadv_compare_tt,
-					     batadv_choose_tt, &tt_local->common,
+					     batadv_choose_tt, &tt_local->common.key,
 					     &tt_local->common.hash_entry);
 
 		if (unlikely(hash_added != 0)) {
@@ -1488,7 +1489,7 @@ batadv_tt_local_dump_entry(struct sk_buff *msg, u32 portid,
 	last_seen = READ_ONCE(local->last_seen);
 	last_seen_msecs = jiffies_delta_to_msecs(jiffies - last_seen);
 
-	vlan = batadv_meshif_vlan_get(bat_priv, common->vid);
+	vlan = batadv_meshif_vlan_get(bat_priv, common->key.vid);
 	if (!vlan)
 		return 0;
 
@@ -1506,9 +1507,9 @@ batadv_tt_local_dump_entry(struct sk_buff *msg, u32 portid,
 
 	flags = batadv_tt_flags_get(common);
 
-	if (nla_put(msg, BATADV_ATTR_TT_ADDRESS, ETH_ALEN, common->addr) ||
+	if (nla_put(msg, BATADV_ATTR_TT_ADDRESS, ETH_ALEN, common->key.addr) ||
 	    nla_put_u32(msg, BATADV_ATTR_TT_CRC32, crc) ||
-	    nla_put_u16(msg, BATADV_ATTR_TT_VID, common->vid) ||
+	    nla_put_u16(msg, BATADV_ATTR_TT_VID, common->key.vid) ||
 	    nla_put_u32(msg, BATADV_ATTR_TT_FLAGS, flags))
 		goto nla_put_failure;
 
@@ -1644,7 +1645,7 @@ batadv_tt_local_set_pending(struct batadv_priv *bat_priv,
 	struct batadv_hashtable *hash = bat_priv->tt.local_hash;
 	u32 i;
 
-	i = batadv_choose_tt(common, hash->size);
+	i = batadv_choose_tt(&common->key, hash->size);
 	lockdep_assert_held(&hash->list_locks[i]);
 	lockdep_assert_held(&common->flags_lock);
 
@@ -1653,8 +1654,8 @@ batadv_tt_local_set_pending(struct batadv_priv *bat_priv,
 
 	batadv_dbg(BATADV_DBG_TT, bat_priv,
 		   "Local tt entry (%pM, vid: %d) pending to be removed: %s\n",
-		   tt_local_entry->common.addr,
-		   batadv_print_vid(tt_local_entry->common.vid), message);
+		   tt_local_entry->common.key.addr,
+		   batadv_print_vid(tt_local_entry->common.key.vid), message);
 }
 
 /**
@@ -1686,7 +1687,7 @@ batadv_tt_local_mark_removed(struct batadv_priv *bat_priv,
 	u16 flags;
 	u32 i;
 
-	i = batadv_choose_tt(common, hash->size);
+	i = batadv_choose_tt(&common->key, hash->size);
 	list_lock = &hash->list_locks[i];
 
 	spin_lock_bh(list_lock);
@@ -1740,7 +1741,7 @@ batadv_tt_local_remove_now(struct batadv_priv *bat_priv,
 	/* remove exactly this object when still present in hash */
 	tt_removed_node = batadv_hash_remove(bat_priv->tt.local_hash,
 					     batadv_compare_tt_entry,
-					     batadv_choose_tt, common);
+					     batadv_choose_tt, &common->key);
 	if (!tt_removed_node)
 		return;
 
@@ -1751,7 +1752,7 @@ batadv_tt_local_remove_now(struct batadv_priv *bat_priv,
 	 * BATADV_TT_CLIENT_NEW check in batadv_tt_local_mark_removed().
 	 */
 	if (!(batadv_tt_flags_get(common) & BATADV_TT_CLIENT_NEW))
-		batadv_tt_local_size_dec(bat_priv, common->vid);
+		batadv_tt_local_size_dec(bat_priv, common->key.vid);
 
 	/* drop reference of remove hash entry */
 	batadv_tt_local_entry_put(tt_local_entry);
@@ -2070,7 +2071,7 @@ batadv_tt_global_orig_entry_add(struct batadv_tt_global_entry *tt_global,
 
 	INIT_HLIST_NODE(&orig_entry->list);
 	kref_get(&orig_node->refcount);
-	batadv_tt_global_size_inc(orig_node, tt_global->common.vid);
+	batadv_tt_global_size_inc(orig_node, tt_global->common.key.vid);
 	orig_entry->orig_node = orig_node;
 	orig_entry->ttvn = ttvn;
 	orig_entry->flags = flags;
@@ -2111,11 +2112,11 @@ batadv_tt_global_purge_local(struct batadv_priv *bat_priv,
 	/* Do not remove multicast addresses from the local hash on
 	 * global additions
 	 */
-	if (is_multicast_ether_addr(common->addr))
+	if (is_multicast_ether_addr(common->key.addr))
 		return;
 
 	/* remove address from local hash if present */
-	local_flags = batadv_tt_local_remove(bat_priv, common->addr, common->vid,
+	local_flags = batadv_tt_local_remove(bat_priv, common->key.addr, common->key.vid,
 					     "global tt received",
 					     flags & BATADV_TT_CLIENT_ROAM);
 
@@ -2161,7 +2162,7 @@ batadv_tt_global_merge_flags(struct batadv_tt_global_entry *tt_global_entry,
 		 * TT_CLIENT_TEMP, therefore they have to be copied in the
 		 * client entry
 		 */
-		if (!is_multicast_ether_addr(common->addr))
+		if (!is_multicast_ether_addr(common->key.addr))
 			common->flags |= flags & (~BATADV_TT_SYNC_MASK);
 
 		/* If there is the BATADV_TT_CLIENT_ROAM flag set, there is only
@@ -2205,11 +2206,11 @@ batadv_tt_global_create(const unsigned char *tt_addr, unsigned short vid,
 		return NULL;
 
 	common = &tt_global_entry->common;
-	ether_addr_copy(common->addr, tt_addr);
-	common->vid = vid;
+	ether_addr_copy(common->key.addr, tt_addr);
+	common->key.vid = vid;
 	spin_lock_init(&common->flags_lock);
 
-	if (!is_multicast_ether_addr(common->addr)) {
+	if (!is_multicast_ether_addr(common->key.addr)) {
 		scoped_guard(spinlock_bh, &common->flags_lock)
 			common->flags = flags & (~BATADV_TT_SYNC_MASK);
 	}
@@ -2291,7 +2292,7 @@ static bool batadv_tt_global_add(struct batadv_priv *bat_priv,
 		kref_get(&common->refcount);
 		hash_added = batadv_hash_add(bat_priv->tt.global_hash,
 					     batadv_compare_tt,
-					     batadv_choose_tt, common,
+					     batadv_choose_tt, &common->key,
 					     &common->hash_entry);
 
 		if (unlikely(hash_added != 0)) {
@@ -2335,7 +2336,7 @@ static bool batadv_tt_global_add(struct batadv_priv *bat_priv,
 
 	batadv_dbg(BATADV_DBG_TT, bat_priv,
 		   "Creating new global tt entry: %pM (vid: %d, via %pM)\n",
-		   common->addr, batadv_print_vid(common->vid),
+		   common->key.addr, batadv_print_vid(common->key.vid),
 		   orig_node->orig);
 	ret = true;
 
@@ -2417,7 +2418,7 @@ batadv_tt_global_dump_subentry(struct sk_buff *msg, u32 portid, u32 seq,
 	u32 crc;
 
 	vlan = batadv_orig_node_vlan_get(orig->orig_node,
-					 common->vid);
+					 common->key.vid);
 	if (!vlan)
 		return 0;
 
@@ -2434,13 +2435,13 @@ batadv_tt_global_dump_subentry(struct sk_buff *msg, u32 portid, u32 seq,
 	flags = (batadv_tt_flags_get(common) & (~BATADV_TT_SYNC_MASK)) | orig->flags;
 	last_ttvn = READ_ONCE(orig->orig_node->last_ttvn);
 
-	if (nla_put(msg, BATADV_ATTR_TT_ADDRESS, ETH_ALEN, common->addr) ||
+	if (nla_put(msg, BATADV_ATTR_TT_ADDRESS, ETH_ALEN, common->key.addr) ||
 	    nla_put(msg, BATADV_ATTR_ORIG_ADDRESS, ETH_ALEN,
 		    orig->orig_node->orig) ||
 	    nla_put_u8(msg, BATADV_ATTR_TT_TTVN, orig->ttvn) ||
 	    nla_put_u8(msg, BATADV_ATTR_TT_LAST_TTVN, last_ttvn) ||
 	    nla_put_u32(msg, BATADV_ATTR_TT_CRC32, crc) ||
-	    nla_put_u16(msg, BATADV_ATTR_TT_VID, common->vid) ||
+	    nla_put_u16(msg, BATADV_ATTR_TT_VID, common->key.vid) ||
 	    nla_put_u32(msg, BATADV_ATTR_TT_FLAGS, flags))
 		goto nla_put_failure;
 
@@ -2616,7 +2617,7 @@ _batadv_tt_global_del_orig_entry(struct batadv_tt_global_entry *tt_global_entry,
 	lockdep_assert_held(&tt_global_entry->list_lock);
 
 	batadv_tt_global_size_dec(orig_entry->orig_node,
-				  tt_global_entry->common.vid);
+				  tt_global_entry->common.key.vid);
 	atomic_dec(&tt_global_entry->orig_list_count);
 	/* requires holding tt_global_entry->list_lock and orig_entry->list
 	 * being part of a list
@@ -2669,11 +2670,11 @@ batadv_tt_global_del_orig_node(struct batadv_priv *bat_priv,
 	head = &tt_global_entry->orig_list;
 	hlist_for_each_entry_safe(orig_entry, safe, head, list) {
 		if (orig_entry->orig_node == orig_node) {
-			vid = tt_global_entry->common.vid;
+			vid = tt_global_entry->common.key.vid;
 			batadv_dbg(BATADV_DBG_TT, bat_priv,
 				   "Deleting %pM from global tt entry %pM (vid: %d): %s\n",
 				   orig_node->orig,
-				   tt_global_entry->common.addr,
+				   tt_global_entry->common.key.addr,
 				   batadv_print_vid(vid), message);
 			_batadv_tt_global_del_orig_entry(tt_global_entry,
 							 orig_entry);
@@ -2781,7 +2782,7 @@ static void batadv_tt_global_del(struct batadv_priv *bat_priv,
 	 *    the global entry, since it is useless now.
 	 */
 	local_entry = batadv_tt_local_hash_find(bat_priv,
-						tt_global_entry->common.addr,
+						tt_global_entry->common.key.addr,
 						vid);
 	if (local_entry) {
 		/* local entry exists, case 2: client roamed to us. */
@@ -2832,7 +2833,8 @@ void batadv_tt_global_del_orig(struct batadv_priv *bat_priv,
 		hlist_for_each_entry_safe(tt_common_entry, safe,
 					  head, hash_entry) {
 			/* remove only matching entries */
-			if (match_vid >= 0 && tt_common_entry->vid != match_vid)
+			if (match_vid >= 0 &&
+			    tt_common_entry->key.vid != match_vid)
 				continue;
 
 			tt_global = container_of(tt_common_entry,
@@ -2843,10 +2845,10 @@ void batadv_tt_global_del_orig(struct batadv_priv *bat_priv,
 						       orig_node, message);
 
 			if (hlist_empty(&tt_global->orig_list)) {
-				vid = tt_global->common.vid;
+				vid = tt_global->common.key.vid;
 				batadv_dbg(BATADV_DBG_TT, bat_priv,
 					   "Deleting global tt entry %pM (vid: %d): %s\n",
-					   tt_global->common.addr,
+					   tt_global->common.key.addr,
 					   batadv_print_vid(vid), message);
 				hlist_del_rcu(&tt_common_entry->hash_entry);
 				batadv_tt_global_entry_put(tt_global);
@@ -2924,8 +2926,8 @@ static void batadv_tt_global_purge(struct batadv_priv *bat_priv)
 
 			batadv_dbg(BATADV_DBG_TT, bat_priv,
 				   "Deleting global tt entry %pM (vid: %d): %s\n",
-				   tt_global->common.addr,
-				   batadv_print_vid(tt_global->common.vid),
+				   tt_global->common.key.addr,
+				   batadv_print_vid(tt_global->common.key.vid),
 				   msg);
 
 			hlist_del_rcu(&tt_common->hash_entry);
@@ -3125,7 +3127,7 @@ static u32 batadv_tt_global_crc(struct batadv_priv *bat_priv,
 			/* compute the CRC only for entries belonging to the
 			 * VLAN identified by the vid passed as parameter
 			 */
-			if (tt_common->vid != vid)
+			if (tt_common->key.vid != vid)
 				continue;
 
 			tt_flags = batadv_tt_flags_get(tt_common);
@@ -3156,7 +3158,7 @@ static u32 batadv_tt_global_crc(struct batadv_priv *bat_priv,
 			/* use network order to read the VID: this ensures that
 			 * every node reads the bytes in the same order.
 			 */
-			tmp_vid = htons(tt_common->vid);
+			tmp_vid = htons(tt_common->key.vid);
 			crc_tmp = crc32c(0, &tmp_vid, sizeof(tmp_vid));
 
 			/* compute the CRC on flags that have to be kept in sync
@@ -3165,7 +3167,7 @@ static u32 batadv_tt_global_crc(struct batadv_priv *bat_priv,
 			flags = tt_orig->flags;
 			crc_tmp = crc32c(crc_tmp, &flags, sizeof(flags));
 
-			crc ^= crc32c(crc_tmp, tt_common->addr, ETH_ALEN);
+			crc ^= crc32c(crc_tmp, tt_common->key.addr, ETH_ALEN);
 
 			batadv_tt_orig_list_entry_put(tt_orig);
 		}
@@ -3207,7 +3209,7 @@ static u32 batadv_tt_local_crc(struct batadv_priv *bat_priv,
 			/* compute the CRC only for entries belonging to the
 			 * VLAN identified by vid
 			 */
-			if (tt_common->vid != vid)
+			if (tt_common->key.vid != vid)
 				continue;
 
 			tt_flags = batadv_tt_flags_get(tt_common);
@@ -3223,7 +3225,7 @@ static u32 batadv_tt_local_crc(struct batadv_priv *bat_priv,
 			/* use network order to read the VID: this ensures that
 			 * every node reads the bytes in the same order.
 			 */
-			tmp_vid = htons(tt_common->vid);
+			tmp_vid = htons(tt_common->key.vid);
 			crc_tmp = crc32c(0, &tmp_vid, sizeof(tmp_vid));
 
 			/* compute the CRC on flags that have to be kept in sync
@@ -3231,7 +3233,7 @@ static u32 batadv_tt_local_crc(struct batadv_priv *bat_priv,
 			 */
 			crc_tmp = crc32c(crc_tmp, &flags, sizeof(flags));
 
-			crc ^= crc32c(crc_tmp, tt_common->addr, ETH_ALEN);
+			crc ^= crc32c(crc_tmp, tt_common->key.addr, ETH_ALEN);
 		}
 		rcu_read_unlock();
 	}
@@ -3492,9 +3494,10 @@ static u16 batadv_tt_tvlv_generate(struct batadv_priv *bat_priv,
 			if (!ret)
 				continue;
 
-			ether_addr_copy(tt_change->addr, tt_common_entry->addr);
+			ether_addr_copy(tt_change->addr,
+					tt_common_entry->key.addr);
 			tt_change->flags = flags;
-			tt_change->vid = htons(tt_common_entry->vid);
+			tt_change->vid = htons(tt_common_entry->key.vid);
 			memset(tt_change->reserved, 0,
 			       sizeof(tt_change->reserved));
 
@@ -4403,7 +4406,7 @@ static void batadv_tt_local_transition_new(struct batadv_priv *bat_priv)
 				continue;
 
 			batadv_tt_local_size_inc(bat_priv,
-						 tt_common_entry->vid);
+						 tt_common_entry->key.vid);
 		}
 		spin_unlock_bh(list_lock);
 	}
@@ -4447,8 +4450,8 @@ static void batadv_tt_local_purge_pending_clients(struct batadv_priv *bat_priv)
 
 				batadv_dbg(BATADV_DBG_TT, bat_priv,
 					   "Deleting local tt entry (%pM, vid: %d): pending\n",
-					   tt_common->addr,
-					   batadv_print_vid(tt_common->vid));
+					   tt_common->key.addr,
+					   batadv_print_vid(tt_common->key.vid));
 
 				hlist_del_rcu(&tt_common->hash_entry);
 
@@ -4456,7 +4459,7 @@ static void batadv_tt_local_purge_pending_clients(struct batadv_priv *bat_priv)
 				 * never counted and must not be uncounted here.
 				 */
 				if (!(tt_common->flags & BATADV_TT_CLIENT_NEW))
-					batadv_tt_local_size_dec(bat_priv, tt_common->vid);
+					batadv_tt_local_size_dec(bat_priv, tt_common->key.vid);
 			}
 
 			if (cont)
diff --git a/net/batman-adv/types.h b/net/batman-adv/types.h
index 3a340ce9660d9..8e590f19d2362 100644
--- a/net/batman-adv/types.h
+++ b/net/batman-adv/types.h
@@ -1883,14 +1883,23 @@ struct batadv_bla_claim {
 #endif
 
 /**
- * struct batadv_tt_common_entry - tt local & tt global common data
+ * struct batadv_tt_common_entry_key - key of a TT entry in
+ *  &batadv_priv_tt.local_hash or &batadv_priv_tt.global_hash
  */
-struct batadv_tt_common_entry {
+struct batadv_tt_common_entry_key {
 	/** @addr: mac address of non-mesh client */
 	u8 addr[ETH_ALEN] __aligned(2);
 
 	/** @vid: VLAN identifier */
 	unsigned short vid;
+};
+
+/**
+ * struct batadv_tt_common_entry - tt local & tt global common data
+ */
+struct batadv_tt_common_entry {
+	/** @key: hash key identifying the TT client */
+	struct batadv_tt_common_entry_key key;
 
 	/**
 	 * @hash_entry: hlist node for &batadv_priv_tt.local_hash or for
-- 
2.47.3

