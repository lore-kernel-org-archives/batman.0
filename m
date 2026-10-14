Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA6ACCC6B29
	for <batman@archiver.kernel.org>; Wed, 14 Oct 2026 07:47:52 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 368F5841D0
	for <batman@archiver.kernel.org>; Wed, 14 Oct 2026 09:47:51 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1791964071;
 b=siG1OBm8aru0VsBgVEUgZ+5C5hyc3kU5E55FZ2C+/BKdo9ZJr1jvlKFpJ/AASpZXimkNv
 ME2hHy9HY26KF3kaY6aQG0CvVJtxsamkOrvqnDiJLLXJhRE1YGL+oKCkUW+BEz45MZDdKS9
 UW8j4Bgbv44yIPwxTwZjpxGCB9RGDuo=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1791964071; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=RqR9nyVvulTyof2TAlt923SFseFpVJMLO1L6aTQRYEI=;
 b=HQMQVRih5QwOiX93a0kj7zOr/GWjptxWC8f/uNxoDjMUomFbT9YdKKPwwMndkEJM6VyZr
 UkfHcucNlTw4hDPaGH+eqxdZsfj0VqxNgZrZniDgkfFUaLBPGBzvTL6Ewwu4tMMtKN7vvsO
 6Pf1/cJ+ExCud2eKikNqmZVHwOip4QY=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id B9BCE8173D
	for <b.a.t.m.a.n@lists.open-mesh.org>; Wed, 14 Oct 2026 09:46:33 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1791963993;
	b=pv7m/5/n/8LuQM7qoaWKpRQUp9N+vKPNdZn3hCwVFHgY1gTsmB7pDI6tUh79XjvMbGUrGl
	JM2NulzlA0y/20sIGF1a1oBCB469Dd8S+KnO5TGyVaCrXGxXvhOImlTSME4MVNocn90hwu
	ODnv8QxU/w1tL8pyFnmT06i2Xglz0sA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1791963993;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=RqR9nyVvulTyof2TAlt923SFseFpVJMLO1L6aTQRYEI=;
	b=oLJ1dt0r/Pef1riqtwpJLiZm7V52JLKpSb7URaaKAxC3M8ic9MM/waSwU8mX6dwiLWI98I
	j7D3eeC2crCZ28+luSK7HdgaOJUJjHWl0SWnZ8XhH0kxaIgEjs98jqtOdauJSnEZhOxATC
	VOGJa23wrGwIOavwNAnXdzXTbhMaArQ=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=2jb+KF23;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id 745051FF7B;
	Wed, 14 Oct 2026 07:46:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1791963993;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RqR9nyVvulTyof2TAlt923SFseFpVJMLO1L6aTQRYEI=;
	b=2jb+KF23LU/Wghk0uPfkshY+xmIuzs6GaRly6NR5frHrPp9IxRpbBvmPF0Sh21Fa1GcMuW
	BWrezKfh2nRBvzDdoIpMt+zF3VogTIahVAdLM9D+1CbFFrqxZWid664ww/IJT6cGIKUGrQ
	JTyVagAi9hhEVjwETPiCT0cPFLUy4Gg=
From: Sven Eckelmann <sven@narfation.org>
Date: Wed, 14 Oct 2026 09:46:03 +0200
Subject: [PATCH batadv v2 4/6] batman-adv: tt: use dedicated key type for
 hashes
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261014-hash-key-v2-4-7cb91c7df2cb@narfation.org>
References: <20261014-hash-key-v2-0-7cb91c7df2cb@narfation.org>
In-Reply-To: <20261014-hash-key-v2-0-7cb91c7df2cb@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=23560; i=sven@narfation.org;
 h=from:subject:message-id; bh=kgxJt3x3G6WsaUzyVwpRB9bpmqLz0E51GZCjCceDKTY=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFnnjT3vT4icffLlhtVHag6c9DjZqabhrcHrv7R3vv1xV
 d5NHFU1HaUsDGJcDLJiiix7ruSf38z+Vv7ztI9HYeawMoEMYeDiFICJcG9jZLhSUs+yl7HKeWFt
 9RT9zrBN77bWyCrIfjjfbzd3TqqK5V9Ght9BjFsV4zm2fso49HjyTB7tE5a5D118MxPl1vi/vGq
 xlxMA
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: MMUWG5HI7LUYBKKC6BXMI6NLATIK3VRN
X-Message-ID-Hash: MMUWG5HI7LUYBKKC6BXMI6NLATIK3VRN
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/MMUWG5HI7LUYBKKC6BXMI6NLATIK3VRN/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

The TT hash lookup functions are given a struct batadv_tt_common_entry.
For a lookup, a dummy TT entry is created on the stack and only its addr
and vid members are filled. All other members stay uninitialized, and
only by reading the hash and compare callbacks can one tell which
members form the key.

Move addr and vid into a new struct batadv_tt_common_entry_key, embedded as
batadv_tt_common_entry::key. The helpers are only using this key for
hashing/comparison.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/translation-table.c | 177 +++++++++++++++++++------------------
 net/batman-adv/types.h             |  13 ++-
 2 files changed, 101 insertions(+), 89 deletions(-)

diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index 3349376a9087d..c6c2ad0bb7d99 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -79,60 +79,62 @@ static void batadv_tt_global_del(struct batadv_priv *bat_priv,
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
 
-	return (tt1->vid == tt2->vid) && batadv_compare_eth(data1, data2);
+	tt = container_of(node, struct batadv_tt_common_entry, hash_entry);
+
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
@@ -151,7 +153,7 @@ batadv_tt_hash_find(struct batadv_hashtable *hash, const u8 *addr,
 		    unsigned short vid)
 {
 	struct batadv_tt_common_entry *tt_tmp = NULL;
-	struct batadv_tt_common_entry to_search;
+	struct batadv_tt_common_entry_key key;
 	struct batadv_tt_common_entry *tt;
 	struct hlist_head *head;
 	u32 index;
@@ -159,18 +161,15 @@ batadv_tt_hash_find(struct batadv_hashtable *hash, const u8 *addr,
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
@@ -640,8 +639,8 @@ static void __batadv_tt_local_event(struct batadv_priv *bat_priv,
 
 	memset(tt_change_node->change.reserved, 0,
 	       sizeof(tt_change_node->change.reserved));
-	ether_addr_copy(tt_change_node->change.addr, common->addr);
-	tt_change_node->change.vid = htons(common->vid);
+	ether_addr_copy(tt_change_node->change.addr, common->key.addr);
+	tt_change_node->change.vid = htons(common->key.vid);
 
 	tt_change_node->change.flags = flags;
 	del_op_requested = flags & BATADV_TT_CLIENT_DEL;
@@ -651,7 +650,7 @@ static void __batadv_tt_local_event(struct batadv_priv *bat_priv,
 	changes = READ_ONCE(bat_priv->tt.local_changes);
 	list_for_each_entry_safe(entry, safe, &bat_priv->tt.changes_list,
 				 list) {
-		if (!batadv_compare_eth(entry->change.addr, common->addr))
+		if (!batadv_compare_eth(entry->change.addr, common->key.addr))
 			continue;
 
 		if (entry->change.vid != tt_change_node->change.vid)
@@ -780,14 +779,14 @@ static void batadv_tt_global_free(struct batadv_priv *bat_priv,
 
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
 
@@ -836,8 +835,8 @@ static void batadv_tt_local_add_roam(struct batadv_priv *bat_priv,
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
@@ -893,7 +892,8 @@ static bool batadv_tt_local_add_existing(struct batadv_priv *bat_priv,
 		if (common->flags & BATADV_TT_CLIENT_PENDING) {
 			batadv_dbg(BATADV_DBG_TT, bat_priv,
 				   "Re-adding pending client %pM (vid: %d)\n",
-				   common->addr, batadv_print_vid(common->vid));
+				   common->key.addr,
+				   batadv_print_vid(common->key.vid));
 			/* whatever the reason why the PENDING flag was set,
 			 * this is a client which was enqueued to be removed in
 			 * this orig_interval. Since it popped up again, the
@@ -907,7 +907,8 @@ static bool batadv_tt_local_add_existing(struct batadv_priv *bat_priv,
 		if (common->flags & BATADV_TT_CLIENT_ROAM) {
 			batadv_dbg(BATADV_DBG_TT, bat_priv,
 				   "Roaming client %pM (vid: %d) came back to its original location\n",
-				   common->addr, batadv_print_vid(common->vid));
+				   common->key.addr,
+				   batadv_print_vid(common->key.vid));
 			/* the ROAM flag is set because this client roamed away
 			 * and the node got a roaming_advertisement message. Now
 			 * that the client popped up again at its original
@@ -968,8 +969,8 @@ batadv_tt_local_create(struct net_device *mesh_iface, const u8 *addr,
 		   addr, batadv_print_vid(vid),
 		   (u8)atomic_read(&bat_priv->tt.vn));
 
-	ether_addr_copy(tt_local->common.addr, addr);
-	tt_local->common.vid = vid;
+	ether_addr_copy(tt_local->common.key.addr, addr);
+	tt_local->common.key.vid = vid;
 	kref_init(&tt_local->common.refcount);
 	tt_local->last_seen = jiffies;
 	tt_local->common.added_at = tt_local->last_seen;
@@ -1083,7 +1084,7 @@ bool batadv_tt_local_add(struct net_device *mesh_iface, const u8 *addr,
 
 		kref_get(&tt_local->common.refcount);
 		hash_added = batadv_hash_add(bat_priv->tt.local_hash, batadv_compare_tt,
-					     batadv_choose_tt, &tt_local->common,
+					     batadv_choose_tt, &tt_local->common.key,
 					     &tt_local->common.hash_entry);
 
 		if (unlikely(hash_added != 0)) {
@@ -1434,7 +1435,7 @@ batadv_tt_local_dump_entry(struct sk_buff *msg, u32 portid,
 	local = container_of(common, struct batadv_tt_local_entry, common);
 	last_seen_msecs = jiffies_to_msecs(jiffies - local->last_seen);
 
-	vlan = batadv_meshif_vlan_get(bat_priv, common->vid);
+	vlan = batadv_meshif_vlan_get(bat_priv, common->key.vid);
 	if (!vlan)
 		return 0;
 
@@ -1452,9 +1453,9 @@ batadv_tt_local_dump_entry(struct sk_buff *msg, u32 portid,
 
 	flags = batadv_tt_flags_get(common);
 
-	if (nla_put(msg, BATADV_ATTR_TT_ADDRESS, ETH_ALEN, common->addr) ||
+	if (nla_put(msg, BATADV_ATTR_TT_ADDRESS, ETH_ALEN, common->key.addr) ||
 	    nla_put_u32(msg, BATADV_ATTR_TT_CRC32, crc) ||
-	    nla_put_u16(msg, BATADV_ATTR_TT_VID, common->vid) ||
+	    nla_put_u16(msg, BATADV_ATTR_TT_VID, common->key.vid) ||
 	    nla_put_u32(msg, BATADV_ATTR_TT_FLAGS, flags))
 		goto nla_put_failure;
 
@@ -1590,7 +1591,7 @@ batadv_tt_local_set_pending(struct batadv_priv *bat_priv,
 	struct batadv_hashtable *hash = bat_priv->tt.local_hash;
 	u32 i;
 
-	i = batadv_choose_tt(common, hash->size);
+	i = batadv_choose_tt(&common->key, hash->size);
 	lockdep_assert_held(&hash->list_locks[i]);
 	lockdep_assert_held(&common->flags_lock);
 
@@ -1599,8 +1600,8 @@ batadv_tt_local_set_pending(struct batadv_priv *bat_priv,
 
 	batadv_dbg(BATADV_DBG_TT, bat_priv,
 		   "Local tt entry (%pM, vid: %d) pending to be removed: %s\n",
-		   tt_local_entry->common.addr,
-		   batadv_print_vid(tt_local_entry->common.vid), message);
+		   tt_local_entry->common.key.addr,
+		   batadv_print_vid(tt_local_entry->common.key.vid), message);
 }
 
 /**
@@ -1632,7 +1633,7 @@ batadv_tt_local_mark_removed(struct batadv_priv *bat_priv,
 	u16 flags;
 	u32 i;
 
-	i = batadv_choose_tt(common, hash->size);
+	i = batadv_choose_tt(&common->key, hash->size);
 	list_lock = &hash->list_locks[i];
 
 	spin_lock_bh(list_lock);
@@ -1686,7 +1687,7 @@ batadv_tt_local_remove_now(struct batadv_priv *bat_priv,
 	/* remove exactly this object when still present in hash */
 	tt_removed_node = batadv_hash_remove(bat_priv->tt.local_hash,
 					     batadv_compare_tt_entry,
-					     batadv_choose_tt, common);
+					     batadv_choose_tt, &common->key);
 	if (!tt_removed_node)
 		return;
 
@@ -1697,7 +1698,7 @@ batadv_tt_local_remove_now(struct batadv_priv *bat_priv,
 	 * BATADV_TT_CLIENT_NEW check in batadv_tt_local_mark_removed().
 	 */
 	if (!(batadv_tt_flags_get(common) & BATADV_TT_CLIENT_NEW))
-		batadv_tt_local_size_dec(bat_priv, common->vid);
+		batadv_tt_local_size_dec(bat_priv, common->key.vid);
 
 	/* drop reference of remove hash entry */
 	batadv_tt_local_entry_put(tt_local_entry);
@@ -2015,7 +2016,7 @@ batadv_tt_global_orig_entry_add(struct batadv_tt_global_entry *tt_global,
 
 	INIT_HLIST_NODE(&orig_entry->list);
 	kref_get(&orig_node->refcount);
-	batadv_tt_global_size_inc(orig_node, tt_global->common.vid);
+	batadv_tt_global_size_inc(orig_node, tt_global->common.key.vid);
 	orig_entry->orig_node = orig_node;
 	orig_entry->ttvn = ttvn;
 	orig_entry->flags = flags;
@@ -2056,11 +2057,11 @@ batadv_tt_global_purge_local(struct batadv_priv *bat_priv,
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
 
@@ -2106,7 +2107,7 @@ batadv_tt_global_merge_flags(struct batadv_tt_global_entry *tt_global_entry,
 		 * TT_CLIENT_TEMP, therefore they have to be copied in the
 		 * client entry
 		 */
-		if (!is_multicast_ether_addr(common->addr))
+		if (!is_multicast_ether_addr(common->key.addr))
 			common->flags |= flags & (~BATADV_TT_SYNC_MASK);
 
 		/* If there is the BATADV_TT_CLIENT_ROAM flag set, there is only
@@ -2150,11 +2151,11 @@ batadv_tt_global_create(const unsigned char *tt_addr, unsigned short vid,
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
@@ -2236,7 +2237,7 @@ static bool batadv_tt_global_add(struct batadv_priv *bat_priv,
 		kref_get(&common->refcount);
 		hash_added = batadv_hash_add(bat_priv->tt.global_hash,
 					     batadv_compare_tt,
-					     batadv_choose_tt, common,
+					     batadv_choose_tt, &common->key,
 					     &common->hash_entry);
 
 		if (unlikely(hash_added != 0)) {
@@ -2280,7 +2281,7 @@ static bool batadv_tt_global_add(struct batadv_priv *bat_priv,
 
 	batadv_dbg(BATADV_DBG_TT, bat_priv,
 		   "Creating new global tt entry: %pM (vid: %d, via %pM)\n",
-		   common->addr, batadv_print_vid(common->vid),
+		   common->key.addr, batadv_print_vid(common->key.vid),
 		   orig_node->orig);
 	ret = true;
 
@@ -2362,7 +2363,7 @@ batadv_tt_global_dump_subentry(struct sk_buff *msg, u32 portid, u32 seq,
 	u32 crc;
 
 	vlan = batadv_orig_node_vlan_get(orig->orig_node,
-					 common->vid);
+					 common->key.vid);
 	if (!vlan)
 		return 0;
 
@@ -2379,13 +2380,13 @@ batadv_tt_global_dump_subentry(struct sk_buff *msg, u32 portid, u32 seq,
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
 
@@ -2561,7 +2562,7 @@ _batadv_tt_global_del_orig_entry(struct batadv_tt_global_entry *tt_global_entry,
 	lockdep_assert_held(&tt_global_entry->list_lock);
 
 	batadv_tt_global_size_dec(orig_entry->orig_node,
-				  tt_global_entry->common.vid);
+				  tt_global_entry->common.key.vid);
 	atomic_dec(&tt_global_entry->orig_list_count);
 	/* requires holding tt_global_entry->list_lock and orig_entry->list
 	 * being part of a list
@@ -2614,11 +2615,11 @@ batadv_tt_global_del_orig_node(struct batadv_priv *bat_priv,
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
@@ -2726,7 +2727,7 @@ static void batadv_tt_global_del(struct batadv_priv *bat_priv,
 	 *    the global entry, since it is useless now.
 	 */
 	local_entry = batadv_tt_local_hash_find(bat_priv,
-						tt_global_entry->common.addr,
+						tt_global_entry->common.key.addr,
 						vid);
 	if (local_entry) {
 		/* local entry exists, case 2: client roamed to us. */
@@ -2777,7 +2778,8 @@ void batadv_tt_global_del_orig(struct batadv_priv *bat_priv,
 		hlist_for_each_entry_safe(tt_common_entry, safe,
 					  head, hash_entry) {
 			/* remove only matching entries */
-			if (match_vid >= 0 && tt_common_entry->vid != match_vid)
+			if (match_vid >= 0 &&
+			    tt_common_entry->key.vid != match_vid)
 				continue;
 
 			tt_global = container_of(tt_common_entry,
@@ -2788,10 +2790,10 @@ void batadv_tt_global_del_orig(struct batadv_priv *bat_priv,
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
@@ -2869,8 +2871,8 @@ static void batadv_tt_global_purge(struct batadv_priv *bat_priv)
 
 			batadv_dbg(BATADV_DBG_TT, bat_priv,
 				   "Deleting global tt entry %pM (vid: %d): %s\n",
-				   tt_global->common.addr,
-				   batadv_print_vid(tt_global->common.vid),
+				   tt_global->common.key.addr,
+				   batadv_print_vid(tt_global->common.key.vid),
 				   msg);
 
 			hlist_del_rcu(&tt_common->hash_entry);
@@ -3070,7 +3072,7 @@ static u32 batadv_tt_global_crc(struct batadv_priv *bat_priv,
 			/* compute the CRC only for entries belonging to the
 			 * VLAN identified by the vid passed as parameter
 			 */
-			if (tt_common->vid != vid)
+			if (tt_common->key.vid != vid)
 				continue;
 
 			tt_flags = batadv_tt_flags_get(tt_common);
@@ -3101,7 +3103,7 @@ static u32 batadv_tt_global_crc(struct batadv_priv *bat_priv,
 			/* use network order to read the VID: this ensures that
 			 * every node reads the bytes in the same order.
 			 */
-			tmp_vid = htons(tt_common->vid);
+			tmp_vid = htons(tt_common->key.vid);
 			crc_tmp = crc32c(0, &tmp_vid, sizeof(tmp_vid));
 
 			/* compute the CRC on flags that have to be kept in sync
@@ -3110,7 +3112,7 @@ static u32 batadv_tt_global_crc(struct batadv_priv *bat_priv,
 			flags = tt_orig->flags;
 			crc_tmp = crc32c(crc_tmp, &flags, sizeof(flags));
 
-			crc ^= crc32c(crc_tmp, tt_common->addr, ETH_ALEN);
+			crc ^= crc32c(crc_tmp, tt_common->key.addr, ETH_ALEN);
 
 			batadv_tt_orig_list_entry_put(tt_orig);
 		}
@@ -3152,7 +3154,7 @@ static u32 batadv_tt_local_crc(struct batadv_priv *bat_priv,
 			/* compute the CRC only for entries belonging to the
 			 * VLAN identified by vid
 			 */
-			if (tt_common->vid != vid)
+			if (tt_common->key.vid != vid)
 				continue;
 
 			tt_flags = batadv_tt_flags_get(tt_common);
@@ -3168,7 +3170,7 @@ static u32 batadv_tt_local_crc(struct batadv_priv *bat_priv,
 			/* use network order to read the VID: this ensures that
 			 * every node reads the bytes in the same order.
 			 */
-			tmp_vid = htons(tt_common->vid);
+			tmp_vid = htons(tt_common->key.vid);
 			crc_tmp = crc32c(0, &tmp_vid, sizeof(tmp_vid));
 
 			/* compute the CRC on flags that have to be kept in sync
@@ -3176,7 +3178,7 @@ static u32 batadv_tt_local_crc(struct batadv_priv *bat_priv,
 			 */
 			crc_tmp = crc32c(crc_tmp, &flags, sizeof(flags));
 
-			crc ^= crc32c(crc_tmp, tt_common->addr, ETH_ALEN);
+			crc ^= crc32c(crc_tmp, tt_common->key.addr, ETH_ALEN);
 		}
 		rcu_read_unlock();
 	}
@@ -3433,9 +3435,10 @@ static u16 batadv_tt_tvlv_generate(struct batadv_priv *bat_priv,
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
 
@@ -4334,7 +4337,7 @@ static void batadv_tt_local_transition_new(struct batadv_priv *bat_priv)
 				continue;
 
 			batadv_tt_local_size_inc(bat_priv,
-						 tt_common_entry->vid);
+						 tt_common_entry->key.vid);
 		}
 		spin_unlock_bh(list_lock);
 	}
@@ -4378,8 +4381,8 @@ static void batadv_tt_local_purge_pending_clients(struct batadv_priv *bat_priv)
 
 				batadv_dbg(BATADV_DBG_TT, bat_priv,
 					   "Deleting local tt entry (%pM, vid: %d): pending\n",
-					   tt_common->addr,
-					   batadv_print_vid(tt_common->vid));
+					   tt_common->key.addr,
+					   batadv_print_vid(tt_common->key.vid));
 
 				hlist_del_rcu(&tt_common->hash_entry);
 
@@ -4387,7 +4390,7 @@ static void batadv_tt_local_purge_pending_clients(struct batadv_priv *bat_priv)
 				 * never counted and must not be uncounted here.
 				 */
 				if (!(tt_common->flags & BATADV_TT_CLIENT_NEW))
-					batadv_tt_local_size_dec(bat_priv, tt_common->vid);
+					batadv_tt_local_size_dec(bat_priv, tt_common->key.vid);
 			}
 
 			if (cont)
diff --git a/net/batman-adv/types.h b/net/batman-adv/types.h
index 28dad2f4b88f4..e92f59b62d89e 100644
--- a/net/batman-adv/types.h
+++ b/net/batman-adv/types.h
@@ -1872,14 +1872,23 @@ struct batadv_bla_claim {
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

