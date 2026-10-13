Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5ACB7CC6B1A
	for <batman@archiver.kernel.org>; Tue, 13 Oct 2026 18:48:31 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id A2917843FA
	for <batman@archiver.kernel.org>; Tue, 13 Oct 2026 20:48:29 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1791917309;
 b=ab9x5NuuHGTMkraQOnDj0icsFuTjg+qXUjbXP9sHdX0uF0qZgwINxGNaHS6ft0EnS0Bh8
 LAhXx7OonxdKXtBqHg6Tod9A+OonxKMI4HYtsSSiHxqsSn/63vyreUsfJoTjtvfnzpjATx2
 RFB5MQpg4vK+1UzyNPFNIG5aGkN/z2g=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1791917309; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=Lkr9K6Z/NopfSKsNmDgEuhr8JWEIKrqn9q3qVI0s/l4=;
 b=Rq+mRamBJsVzF7f/sq+KdQe41W7d3TkM2bvXwSkbmTrJsCYCh+4dFmPcGLrZTaz4Nq2iB
 kGrKxh92LxMQImEeLDoHExzL5t3C7v0DvMkEeT+JrrcyqtemEG4/OO044NR3EcfW5Wc225E
 0DIn8J/+3E3Y/mXdG49K/inWd0zG5kc=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 3C48981F07
	for <b.a.t.m.a.n@lists.open-mesh.org>; Tue, 13 Oct 2026 20:47:39 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1791917269;
	b=Cuk8APA0LpQ97tvjcsy0swc0RR/kMIKo6s8Di7hqeEEHFY0r0i6/Wo5ivaRAAP7MDPWqUN
	xJ0Q+gyom0Dq8nl+6nH8gFLH/iIQl+812EsrFKHmp0Jgt/yeaRb9qVSZ+RBpv2dXApLhBx
	hV+a3D1F7cueEx8asxDMnaT7guc4sOA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1791917269;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=Lkr9K6Z/NopfSKsNmDgEuhr8JWEIKrqn9q3qVI0s/l4=;
	b=yQFRfPSzvh9UZG0P3QNw0l3D7P7S3zxHNd20U1Xqgsng3+H7Nv1MS+ZbUQjpyInRbhLKKz
	Y5p8K68FEQOQS+kDRVEo3mxHsdW/3DNcZnMP3H7QL5M2hJU1PSTtJu+u4p7H5AUZVnGddo
	kslxDPCvdmK78oz67AEswmKHzJH5Jvw=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=fjc9CnVd;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id D9700202F3;
	Tue, 13 Oct 2026 18:47:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1791917258;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Lkr9K6Z/NopfSKsNmDgEuhr8JWEIKrqn9q3qVI0s/l4=;
	b=fjc9CnVdjRVOtGY5VFJ1zZdUUvWh3KlzMapzFPNVWKi7hxI06h5sS82cM0D81tEpIAKctK
	kaK5WxDjHtpOqwHhvEyxsQ7XJOPqJucF5dGgfvAqssmjMftqmaLqLAALmKNI3ec7suIxgX
	uyElhbxBjTxgdAFXVZ8Jr6BMCCLinaU=
From: Sven Eckelmann <sven@narfation.org>
Date: Tue, 13 Oct 2026 20:47:29 +0200
Subject: [PATCH batadv 1/6] batman-adv: bla: use dedicated key type for
 claim hash
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261013-hash-key-v1-1-0370efdd8cd0@narfation.org>
References: <20261013-hash-key-v1-0-0370efdd8cd0@narfation.org>
In-Reply-To: <20261013-hash-key-v1-0-0370efdd8cd0@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=11932; i=sven@narfation.org;
 h=from:subject:message-id; bh=PL2Xj9luYMNIPibztidP4d7DI+MAE1SFEDEJDlmvx44=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFnnag49MD00MX3mYtY/AhL/jqXeNntoe99sSdvdw3yi6
 VLZHpf3d5SyMIhxMciKKbLsuZJ/fjP7W/nP0z4ehZnDygQyhIGLUwAm8jud4X/l1ne6ix53hWpr
 OJSYlz9Z+aJZbEPKhHfOtsUzdy37b2HNyLCwkulAodNKB235NX1tJ9f/cV7y/U+628Xg/x6MC7g
 ir/IAAA==
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: 4WUY3MRRNMFQPCYMNBTFGU2IIYGBRV2V
X-Message-ID-Hash: 4WUY3MRRNMFQPCYMNBTFGU2IIYGBRV2V
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/4WUY3MRRNMFQPCYMNBTFGU2IIYGBRV2V/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

The claim hash lookup functions are given a struct batadv_bla_claim.
For a lookup, a dummy claim is created on the stack and only its addr
and vid members are filled. All other members stay uninitialized, and
only by reading the hash and compare callbacks can one tell which
members form the key.

Move addr and vid into a new struct batadv_bla_claim_key, embedded as
batadv_bla_claim::key. The helpers are only using this key for
hashing/comparison.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/bridge_loop_avoidance.c | 98 +++++++++++++++++-----------------
 net/batman-adv/types.h                 | 12 ++++-
 2 files changed, 60 insertions(+), 50 deletions(-)

diff --git a/net/batman-adv/bridge_loop_avoidance.c b/net/batman-adv/bridge_loop_avoidance.c
index a96f269d..f9dd1688 100644
--- a/net/batman-adv/bridge_loop_avoidance.c
+++ b/net/batman-adv/bridge_loop_avoidance.c
@@ -59,18 +59,18 @@ batadv_bla_send_announce(struct batadv_priv *bat_priv,
 
 /**
  * batadv_choose_claim() - choose the right bucket for a claim.
- * @data: data to hash
+ * @data: &struct batadv_bla_claim_key to hash
  * @size: size of the hash table
  *
  * Return: the hash index of the claim
  */
 static inline u32 batadv_choose_claim(const void *data, u32 size)
 {
-	const struct batadv_bla_claim *claim = data;
+	const struct batadv_bla_claim_key *key = data;
 	u32 hash = 0;
 
-	hash = jhash(&claim->addr, sizeof(claim->addr), hash);
-	hash = jhash(&claim->vid, sizeof(claim->vid), hash);
+	hash = jhash(&key->addr, sizeof(key->addr), hash);
+	hash = jhash(&key->vid, sizeof(key->vid), hash);
 
 	return hash % size;
 }
@@ -119,24 +119,24 @@ static bool batadv_compare_backbone_gw(const struct hlist_node *node,
 }
 
 /**
- * batadv_compare_claim() - compare address and vid of two claims
- * @node: list node of the first entry to compare
- * @data2: pointer to the second claims
+ * batadv_compare_claim() - compare key of a claim with a search key
+ * @node: list node of the claim to compare
+ * @data2: &struct batadv_bla_claim_key to compare with
  *
- * Return: true if the claims have the same data, false otherwise
+ * Return: true if the claim has the given key, false otherwise
  */
 static bool batadv_compare_claim(const struct hlist_node *node,
 				 const void *data2)
 {
-	const void *data1 = container_of(node, struct batadv_bla_claim,
-					 hash_entry);
-	const struct batadv_bla_claim *cl1 = data1;
-	const struct batadv_bla_claim *cl2 = data2;
+	const struct batadv_bla_claim_key *key = data2;
+	const struct batadv_bla_claim *claim;
 
-	if (!batadv_compare_eth(cl1->addr, cl2->addr))
+	claim = container_of(node, struct batadv_bla_claim, hash_entry);
+
+	if (!batadv_compare_eth(claim->key.addr, key->addr))
 		return false;
 
-	if (cl1->vid != cl2->vid)
+	if (claim->key.vid != key->vid)
 		return false;
 
 	return true;
@@ -188,7 +188,7 @@ static void batadv_claim_release(struct kref *ref)
 	spin_unlock_bh(&claim->backbone_lock);
 
 	spin_lock_bh(&old_backbone_gw->crc_lock);
-	old_backbone_gw->crc ^= crc16(0, claim->addr, ETH_ALEN);
+	old_backbone_gw->crc ^= crc16(0, claim->key.addr, ETH_ALEN);
 	spin_unlock_bh(&old_backbone_gw->crc_lock);
 
 	batadv_backbone_gw_put(old_backbone_gw);
@@ -211,13 +211,13 @@ static void batadv_claim_put(struct batadv_bla_claim *claim)
 /**
  * batadv_claim_hash_find() - looks for a claim in the claim hash
  * @bat_priv: the bat priv with all the mesh interface information
- * @data: search data (may be local/static data)
+ * @key: key of the searched claim
  *
  * Return: claim if found or NULL otherwise.
  */
 static struct batadv_bla_claim *
 batadv_claim_hash_find(struct batadv_priv *bat_priv,
-		       struct batadv_bla_claim *data)
+		       const struct batadv_bla_claim_key *key)
 {
 	struct batadv_hashtable *hash = bat_priv->bla.claim_hash;
 	struct batadv_bla_claim *claim_tmp = NULL;
@@ -228,12 +228,12 @@ batadv_claim_hash_find(struct batadv_priv *bat_priv,
 	if (!hash)
 		return NULL;
 
-	index = batadv_choose_claim(data, hash->size);
+	index = batadv_choose_claim(key, hash->size);
 	head = &hash->table[index];
 
 	rcu_read_lock();
 	hlist_for_each_entry_rcu(claim, head, hash_entry) {
-		if (!batadv_compare_claim(&claim->hash_entry, data))
+		if (!batadv_compare_claim(&claim->hash_entry, key))
 			continue;
 
 		if (!kref_get_unless_zero(&claim->refcount))
@@ -615,7 +615,8 @@ static void batadv_bla_answer_request(struct batadv_priv *bat_priv,
 			if (claim->backbone_gw != backbone_gw)
 				continue;
 
-			batadv_bla_send_claim(bat_priv, claim->addr, claim->vid,
+			batadv_bla_send_claim(bat_priv, claim->key.addr,
+					      claim->key.vid,
 					      BATADV_CLAIM_TYPE_CLAIM);
 		}
 		rcu_read_unlock();
@@ -688,15 +689,15 @@ static void batadv_bla_add_claim(struct batadv_priv *bat_priv,
 				 struct batadv_bla_backbone_gw *backbone_gw)
 {
 	struct batadv_bla_backbone_gw *old_backbone_gw;
-	struct batadv_bla_claim search_claim;
+	struct batadv_bla_claim_key claim_key;
 	struct batadv_bla_claim *claim;
 	int hash_added;
 	u16 claim_crc;
 	bool changed;
 
-	ether_addr_copy(search_claim.addr, mac);
-	search_claim.vid = vid;
-	claim = batadv_claim_hash_find(bat_priv, &search_claim);
+	ether_addr_copy(claim_key.addr, mac);
+	claim_key.vid = vid;
+	claim = batadv_claim_hash_find(bat_priv, &claim_key);
 	claim_crc = crc16(0, mac, ETH_ALEN);
 
 	/* create a new claim entry if it does not exist yet. */
@@ -705,9 +706,9 @@ static void batadv_bla_add_claim(struct batadv_priv *bat_priv,
 		if (!claim)
 			return;
 
-		ether_addr_copy(claim->addr, mac);
+		ether_addr_copy(claim->key.addr, mac);
+		claim->key.vid = vid;
 		spin_lock_init(&claim->backbone_lock);
-		claim->vid = vid;
 		WRITE_ONCE(claim->lasttime, jiffies);
 		kref_get(&backbone_gw->refcount);
 		claim->backbone_gw = backbone_gw;
@@ -720,7 +721,7 @@ static void batadv_bla_add_claim(struct batadv_priv *bat_priv,
 		kref_get(&claim->refcount);
 		hash_added = batadv_hash_add(bat_priv->bla.claim_hash,
 					     batadv_compare_claim,
-					     batadv_choose_claim, claim,
+					     batadv_choose_claim, &claim->key,
 					     &claim->hash_entry);
 
 		if (unlikely(hash_added != 0)) {
@@ -813,12 +814,12 @@ static void batadv_bla_del_claim(struct batadv_priv *bat_priv,
 {
 	struct batadv_bla_claim *claim_removed_entry;
 	struct hlist_node *claim_removed_node;
-	struct batadv_bla_claim search_claim;
+	struct batadv_bla_claim_key claim_key;
 	struct batadv_bla_claim *claim;
 
-	ether_addr_copy(search_claim.addr, mac);
-	search_claim.vid = vid;
-	claim = batadv_claim_hash_find(bat_priv, &search_claim);
+	ether_addr_copy(claim_key.addr, mac);
+	claim_key.vid = vid;
+	claim = batadv_claim_hash_find(bat_priv, &claim_key);
 	if (!claim)
 		return;
 
@@ -827,7 +828,8 @@ static void batadv_bla_del_claim(struct batadv_priv *bat_priv,
 
 	claim_removed_node = batadv_hash_remove(bat_priv->bla.claim_hash,
 						batadv_compare_claim,
-						batadv_choose_claim, claim);
+						batadv_choose_claim,
+						&claim->key);
 	if (!claim_removed_node)
 		goto free_claim;
 
@@ -1354,11 +1356,11 @@ static void batadv_bla_purge_claims(struct batadv_priv *bat_priv,
 purge_now:
 			batadv_dbg(BATADV_DBG_BLA, bat_priv,
 				   "%s(): %pM, vid %d\n", __func__,
-				   claim->addr, claim->vid);
+				   claim->key.addr, claim->key.vid);
 
 			batadv_handle_unclaim(bat_priv, primary_if,
 					      backbone_gw->orig,
-					      claim->addr, claim->vid);
+					      claim->key.addr, claim->key.vid);
 skip:
 			batadv_backbone_gw_put(backbone_gw);
 			batadv_claim_put(claim);
@@ -1959,8 +1961,8 @@ bool batadv_bla_rx(struct batadv_priv *bat_priv, struct sk_buff *skb,
 		   unsigned short vid, int packet_type)
 {
 	struct batadv_bla_backbone_gw *backbone_gw;
+	struct batadv_bla_claim_key claim_key;
 	struct batadv_bla_claim *claim = NULL;
-	struct batadv_bla_claim search_claim;
 	struct batadv_hard_iface *primary_if;
 	struct ethhdr *ethhdr;
 	bool own_claim;
@@ -2006,9 +2008,9 @@ bool batadv_bla_rx(struct batadv_priv *bat_priv, struct sk_buff *skb,
 	    batadv_bla_check_ucast_duplist(bat_priv, skb))
 		goto handled;
 
-	ether_addr_copy(search_claim.addr, ethhdr->h_source);
-	search_claim.vid = vid;
-	claim = batadv_claim_hash_find(bat_priv, &search_claim);
+	ether_addr_copy(claim_key.addr, ethhdr->h_source);
+	claim_key.vid = vid;
+	claim = batadv_claim_hash_find(bat_priv, &claim_key);
 
 	if (!claim) {
 		bool local = batadv_is_my_client(bat_priv, ethhdr->h_source, vid);
@@ -2097,8 +2099,8 @@ bool batadv_bla_tx(struct batadv_priv *bat_priv, struct sk_buff *skb,
 		   unsigned short vid)
 {
 	struct batadv_bla_backbone_gw *backbone_gw;
+	struct batadv_bla_claim_key claim_key;
 	struct batadv_bla_claim *claim = NULL;
-	struct batadv_bla_claim search_claim;
 	struct batadv_hard_iface *primary_if;
 	struct ethhdr *ethhdr;
 	bool client_roamed;
@@ -2121,10 +2123,10 @@ bool batadv_bla_tx(struct batadv_priv *bat_priv, struct sk_buff *skb,
 		if (is_multicast_ether_addr(ethhdr->h_dest))
 			goto handled;
 
-	ether_addr_copy(search_claim.addr, ethhdr->h_source);
-	search_claim.vid = vid;
+	ether_addr_copy(claim_key.addr, ethhdr->h_source);
+	claim_key.vid = vid;
 
-	claim = batadv_claim_hash_find(bat_priv, &search_claim);
+	claim = batadv_claim_hash_find(bat_priv, &claim_key);
 
 	/* if no claim exists, allow it. */
 	if (!claim)
@@ -2230,8 +2232,8 @@ batadv_bla_claim_dump_entry(struct sk_buff *msg, u32 portid,
 			goto put_backbone_gw;
 		}
 
-	if (nla_put(msg, BATADV_ATTR_BLA_ADDRESS, ETH_ALEN, claim->addr) ||
-	    nla_put_u16(msg, BATADV_ATTR_BLA_VID, claim->vid) ||
+	if (nla_put(msg, BATADV_ATTR_BLA_ADDRESS, ETH_ALEN, claim->key.addr) ||
+	    nla_put_u16(msg, BATADV_ATTR_BLA_VID, claim->key.vid) ||
 	    nla_put(msg, BATADV_ATTR_BLA_BACKBONE, ETH_ALEN,
 		    backbone_gw->orig) ||
 	    nla_put_u16(msg, BATADV_ATTR_BLA_CRC,
@@ -2524,8 +2526,8 @@ bool batadv_bla_check_claim(struct batadv_priv *bat_priv,
 {
 	struct batadv_hard_iface *primary_if = NULL;
 	struct batadv_bla_backbone_gw *backbone_gw;
+	struct batadv_bla_claim_key claim_key;
 	struct batadv_bla_claim *claim = NULL;
-	struct batadv_bla_claim search_claim;
 	bool ret = true;
 
 	if (!READ_ONCE(bat_priv->bridge_loop_avoidance))
@@ -2536,10 +2538,10 @@ bool batadv_bla_check_claim(struct batadv_priv *bat_priv,
 		return ret;
 
 	/* First look if the mac address is claimed */
-	ether_addr_copy(search_claim.addr, addr);
-	search_claim.vid = vid;
+	ether_addr_copy(claim_key.addr, addr);
+	claim_key.vid = vid;
 
-	claim = batadv_claim_hash_find(bat_priv, &search_claim);
+	claim = batadv_claim_hash_find(bat_priv, &claim_key);
 
 	/* If there is a claim and we are not owner of the claim,
 	 * return false.
diff --git a/net/batman-adv/types.h b/net/batman-adv/types.h
index c19caa84..bfcbcf8c 100644
--- a/net/batman-adv/types.h
+++ b/net/batman-adv/types.h
@@ -1825,14 +1825,22 @@ struct batadv_bla_backbone_gw {
 };
 
 /**
- * struct batadv_bla_claim - claimed non-mesh client structure
+ * struct batadv_bla_claim_key - key of a claim in &batadv_priv_bla.claim_hash
  */
-struct batadv_bla_claim {
+struct batadv_bla_claim_key {
 	/** @addr: mac address of claimed non-mesh client */
 	u8 addr[ETH_ALEN] __aligned(2);
 
 	/** @vid: vlan id this client was detected on */
 	unsigned short vid;
+};
+
+/**
+ * struct batadv_bla_claim - claimed non-mesh client structure
+ */
+struct batadv_bla_claim {
+	/** @key: hash key identifying the claim */
+	struct batadv_bla_claim_key key;
 
 	/** @backbone_gw: pointer to backbone gw claiming this client */
 	struct batadv_bla_backbone_gw *backbone_gw;

-- 
2.47.3

