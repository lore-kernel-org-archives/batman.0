Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA328CC6B1A
	for <batman@archiver.kernel.org>; Tue, 13 Oct 2026 18:49:43 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 34952804A7
	for <batman@archiver.kernel.org>; Tue, 13 Oct 2026 20:49:42 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1791917382;
 b=UhmWJaLZb7RT7tTCK3c1JBW3wht51fe8Igjm7l0vbRFI7Uz6chQi84ukK5lNfLi5tTGls
 bC+mdnJ/hN5bY0C12EOZNxJr/7zcinX0uf3TQLhYq7R/WlGyiHJObzctvIDU9OW9j5kfhMt
 LtctatOdMvfc3hzRX/LdlK2Vh3/b0xk=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1791917382; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=l4zq6OjCdgQzh9Z6fhlqQsTBnRRi6RIzpi9Qv6OagMY=;
 b=slP8Q3/vLep1g8Kknttnyu7eL1k4cPlr0hJdXsHTI+laYLPsDdkXtf1VwMJMOEXX9kl2S
 4JcXDIjy1BXKshI8mpvIR7FEoLQLXMuVLfW7Ha9CPCwCbSoaNASIVP32t998ftPhBspZ9Xe
 R1oAnQ72xqHvD0qAputpwtqDg0XuULI=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org
 [IPv6:2a00:17d8:100::8b1])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 1644C81F07
	for <b.a.t.m.a.n@lists.open-mesh.org>; Tue, 13 Oct 2026 20:47:43 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1791917273;
	b=hQcTFC2sFJ+MZfIKyCMQBcgsQ8+iBmT5x0+Zie1cQFtx3LYgIjQB+UJiK49pKbNoUQgGGI
	lXtAAUCzB/PyxPOvt6ZufAtjCCaroPantnHpltP3CO2hJvgm597R1FFibauivs57kAgLVH
	31P+1/OoPYxOZgCDvwnFDgqsC6aVagc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1791917273;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=l4zq6OjCdgQzh9Z6fhlqQsTBnRRi6RIzpi9Qv6OagMY=;
	b=KWTdCTrEyqtmDWd8ERi8MZR7EYwM4IEN6A0Z6uVruiWwv7anNa2JqQE31mMWGcRqecu/m6
	brpOk4iJsRA+mtI9nNU7TSODbWNFZuR51zdOr/CLnaRg/LDR9PIdC6nxlcEJzSVIhjruma
	QtBiIa/BJDLWpzedGJwvF+teut7q3/w=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=kGdL9eGg;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id 7E76C20EF2;
	Tue, 13 Oct 2026 18:47:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1791917262;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=l4zq6OjCdgQzh9Z6fhlqQsTBnRRi6RIzpi9Qv6OagMY=;
	b=kGdL9eGgkfnCj635uyJvZvrODKtrgdu6SKtirZrkxIpnTVxS5eIjiPsKJW7g2RaWZJoJOK
	kGzYMV+UYU0PUj3J56dWT+lZLvb7ZJw754hqaZkLU9A4uh3jmEJGz3Iv9wwENmHefGFelJ
	TJ//UFvsFTk9/oNEHuMhpDob3rSAkMQ=
From: Sven Eckelmann <sven@narfation.org>
Date: Tue, 13 Oct 2026 20:47:31 +0200
Subject: [PATCH batadv 3/6] batman-adv: dat: use dedicated key type for DAT
 hash
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261013-hash-key-v1-3-0370efdd8cd0@narfation.org>
References: <20261013-hash-key-v1-0-0370efdd8cd0@narfation.org>
In-Reply-To: <20261013-hash-key-v1-0-0370efdd8cd0@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=8233; i=sven@narfation.org;
 h=from:subject:message-id; bh=gDbyt4A5WPWZhshORyzCxTDBV8G6IyKtL/qkF2fD3RY=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFnnag5xxhv6dHS/3Zx402NP+umzEhncz9f1xC8rlNvP4
 /7iKPfijlIWBjEuBlkxRZY9V/LPb2Z/K/952sejMHNYmUCGMHBxCsBEEh4x/NM8HSt6tWTq/77C
 pkd5m+csDwh4eFFqqbfT9E2VH/96JYox/K9/53fuluh7r72zPh827Fd/ylLas6Ppj8XDrdtnbQs
 6rccGAA==
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: ZY4QVW2CKNH3MEMCSIFA3355MQZU255S
X-Message-ID-Hash: ZY4QVW2CKNH3MEMCSIFA3355MQZU255S
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/ZY4QVW2CKNH3MEMCSIFA3355MQZU255S/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

The DAT hash and the DHT candidate selection hash a dummy struct
batadv_dat_entry on the stack in which only ip and vid are filled.
batadv_dat_entry_hash_find() then compares ip and vid inline instead of
using batadv_compare_dat(), so the key is spelled out in three places.

Move ip and vid into a new struct batadv_dat_entry_key, embedded as
batadv_dat_entry::key. The helpers are only using this key for
hashing/comparison.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/distributed-arp-table.c | 73 ++++++++++++++++------------------
 net/batman-adv/types.h                 | 19 ++++++---
 2 files changed, 49 insertions(+), 43 deletions(-)

diff --git a/net/batman-adv/distributed-arp-table.c b/net/batman-adv/distributed-arp-table.c
index 74050bff..5e6f825e 100644
--- a/net/batman-adv/distributed-arp-table.c
+++ b/net/batman-adv/distributed-arp-table.c
@@ -275,19 +275,18 @@ static void batadv_dat_purge(struct work_struct *work)
 /**
  * batadv_compare_dat() - comparing function used in the local DAT hash table
  * @node: node in the local table
- * @data2: second object to compare the node to
+ * @data2: &struct batadv_dat_entry_key to compare the node to
  *
- * Return: true if the two entries are the same, false otherwise.
+ * Return: true if the entry has the given key, false otherwise.
  */
 static bool batadv_compare_dat(const struct hlist_node *node, const void *data2)
 {
-	const struct batadv_dat_entry *entry1;
-	const struct batadv_dat_entry *entry2;
+	const struct batadv_dat_entry_key *key = data2;
+	const struct batadv_dat_entry *entry;
 
-	entry1 = container_of(node, struct batadv_dat_entry, hash_entry);
-	entry2 = data2;
+	entry = container_of(node, struct batadv_dat_entry, hash_entry);
 
-	return entry1->ip == entry2->ip && entry1->vid == entry2->vid;
+	return entry->key.ip == key->ip && entry->key.vid == key->vid;
 }
 
 /**
@@ -351,30 +350,30 @@ static __be32 batadv_arp_ip_dst(struct sk_buff *skb, int hdr_size)
 
 /**
  * batadv_hash_dat() - compute the hash value for an IP address
- * @data: data to hash
+ * @data: &struct batadv_dat_entry_key to hash
  * @size: size of the hash table
  *
  * Return: the selected index in the hash table for the given data.
  */
 static u32 batadv_hash_dat(const void *data, u32 size)
 {
-	const struct batadv_dat_entry *dat = data;
-	const unsigned char *key;
+	const struct batadv_dat_entry_key *key = data;
+	const unsigned char *buf;
 	u32 hash = 0;
 	__be16 vid;
 	u32 i;
 
-	key = (__force const unsigned char *)&dat->ip;
-	for (i = 0; i < sizeof(dat->ip); i++) {
-		hash += key[i];
+	buf = (__force const unsigned char *)&key->ip;
+	for (i = 0; i < sizeof(key->ip); i++) {
+		hash += buf[i];
 		hash += (hash << 10);
 		hash ^= (hash >> 6);
 	}
 
-	vid = htons(dat->vid);
-	key = (__force const unsigned char *)&vid;
-	for (i = 0; i < sizeof(dat->vid); i++) {
-		hash += key[i];
+	vid = htons(key->vid);
+	buf = (__force const unsigned char *)&vid;
+	for (i = 0; i < sizeof(key->vid); i++) {
+		hash += buf[i];
 		hash += (hash << 10);
 		hash ^= (hash >> 6);
 	}
@@ -401,26 +400,23 @@ batadv_dat_entry_hash_find(struct batadv_priv *bat_priv, __be32 ip,
 {
 	struct batadv_hashtable *hash = bat_priv->dat.hash;
 	struct batadv_dat_entry *dat_entry_tmp = NULL;
+	struct batadv_dat_entry_key key = {
+		.ip = ip,
+		.vid = vid,
+	};
 	struct batadv_dat_entry *dat_entry;
-	struct batadv_dat_entry to_find;
 	struct hlist_head *head;
 	u32 index;
 
 	if (!hash)
 		return NULL;
 
-	to_find.ip = ip;
-	to_find.vid = vid;
-
-	index = batadv_hash_dat(&to_find, hash->size);
+	index = batadv_hash_dat(&key, hash->size);
 	head = &hash->table[index];
 
 	rcu_read_lock();
 	hlist_for_each_entry_rcu(dat_entry, head, hash_entry) {
-		if (dat_entry->ip != ip)
-			continue;
-
-		if (dat_entry->vid != vid)
+		if (!batadv_compare_dat(&dat_entry->hash_entry, &key))
 			continue;
 
 		if (!kref_get_unless_zero(&dat_entry->refcount))
@@ -456,7 +452,7 @@ static void batadv_dat_entry_add(struct batadv_priv *bat_priv, __be32 ip,
 		dat_entry->last_update = jiffies;
 		batadv_dbg(BATADV_DBG_DAT, bat_priv,
 			   "Entry updated: %pI4 %pM (vid: %d)\n",
-			   &dat_entry->ip, mac_addr,
+			   &dat_entry->key.ip, mac_addr,
 			   batadv_print_vid(vid));
 		goto out;
 	}
@@ -465,15 +461,15 @@ static void batadv_dat_entry_add(struct batadv_priv *bat_priv, __be32 ip,
 	if (!dat_entry)
 		goto out;
 
-	dat_entry->ip = ip;
-	dat_entry->vid = vid;
+	dat_entry->key.ip = ip;
+	dat_entry->key.vid = vid;
 	atomic64_set(&dat_entry->mac_addr, u64_mac);
 	dat_entry->last_update = jiffies;
 	kref_init(&dat_entry->refcount);
 
 	kref_get(&dat_entry->refcount);
 	hash_added = batadv_hash_add(bat_priv->dat.hash, batadv_compare_dat,
-				     batadv_hash_dat, dat_entry,
+				     batadv_hash_dat, &dat_entry->key,
 				     &dat_entry->hash_entry);
 
 	if (unlikely(hash_added != 0)) {
@@ -483,7 +479,7 @@ static void batadv_dat_entry_add(struct batadv_priv *bat_priv, __be32 ip,
 	}
 
 	batadv_dbg(BATADV_DBG_DAT, bat_priv, "New entry added: %pI4 %pM (vid: %d)\n",
-		   &dat_entry->ip, mac_addr, batadv_print_vid(vid));
+		   &dat_entry->key.ip, mac_addr, batadv_print_vid(vid));
 
 out:
 	batadv_dat_entry_put(dat_entry);
@@ -710,8 +706,11 @@ batadv_dat_select_candidates(struct batadv_priv *bat_priv, __be32 ip_dst,
 			     unsigned short vid)
 {
 	batadv_dat_addr_t last_max = BATADV_DAT_ADDR_MAX;
+	struct batadv_dat_entry_key key = {
+		.ip = ip_dst,
+		.vid = vid,
+	};
 	struct batadv_dat_candidate *res;
-	struct batadv_dat_entry dat;
 	batadv_dat_addr_t ip_key;
 	int select;
 
@@ -722,9 +721,7 @@ batadv_dat_select_candidates(struct batadv_priv *bat_priv, __be32 ip_dst,
 	if (!res)
 		return NULL;
 
-	dat.ip = ip_dst;
-	dat.vid = vid;
-	ip_key = (batadv_dat_addr_t)batadv_hash_dat(&dat,
+	ip_key = (batadv_dat_addr_t)batadv_hash_dat(&key,
 						    BATADV_DAT_ADDR_MAX);
 
 	batadv_dbg(BATADV_DBG_DAT, bat_priv,
@@ -956,9 +953,9 @@ batadv_dat_cache_dump_entry(struct sk_buff *msg, u32 portid,
 	u64_to_ether_addr(u64_mac, mac);
 
 	if (nla_put_in_addr(msg, BATADV_ATTR_DAT_CACHE_IP4ADDRESS,
-			    dat_entry->ip) ||
+			    dat_entry->key.ip) ||
 	    nla_put(msg, BATADV_ATTR_DAT_CACHE_HWADDRESS, ETH_ALEN, mac) ||
-	    nla_put_u16(msg, BATADV_ATTR_DAT_CACHE_VID, dat_entry->vid) ||
+	    nla_put_u16(msg, BATADV_ATTR_DAT_CACHE_VID, dat_entry->key.vid) ||
 	    nla_put_u32(msg, BATADV_ATTR_LAST_SEEN_MSECS, msecs)) {
 		genlmsg_cancel(msg, hdr);
 		return -EMSGSIZE;
@@ -1517,7 +1514,7 @@ bool batadv_dat_snoop_incoming_arp_reply(struct batadv_priv *bat_priv,
 			batadv_dbg(BATADV_DBG_DAT, bat_priv,
 				   "Doubled ARP reply removed: ARP MSG = [src: %pM-%pI4 dst: %pM-%pI4]; dat_entry: %pM-%pI4\n",
 				   hw_src, &ip_src, hw_dst, &ip_dst,
-				   mac, &dat_entry->ip);
+				   mac, &dat_entry->key.ip);
 			dropped = true;
 		}
 	}
diff --git a/net/batman-adv/types.h b/net/batman-adv/types.h
index 7285fe1b..28dad2f4 100644
--- a/net/batman-adv/types.h
+++ b/net/batman-adv/types.h
@@ -2212,20 +2212,29 @@ struct batadv_algo_ops {
 	struct batadv_algo_gw_ops gw;
 };
 
+/**
+ * struct batadv_dat_entry_key - key of a DAT entry in &batadv_priv_dat.hash
+ *  and in the DHT
+ */
+struct batadv_dat_entry_key {
+	/** @ip: the IPv4 corresponding to this DAT/ARP entry */
+	__be32 ip;
+
+	/** @vid: the vlan ID associated to this entry */
+	unsigned short vid;
+};
+
 /**
  * struct batadv_dat_entry - it is a single entry of batman-adv ARP backend. It
  * is used to stored ARP entries needed for the global DAT cache
  */
 struct batadv_dat_entry {
-	/** @ip: the IPv4 corresponding to this DAT/ARP entry */
-	__be32 ip;
+	/** @key: hash key identifying the DAT entry */
+	struct batadv_dat_entry_key key;
 
 	/** @mac_addr: the MAC address associated to the stored IPv4 */
 	atomic64_t mac_addr;
 
-	/** @vid: the vlan ID associated to this entry */
-	unsigned short vid;
-
 	/**
 	 * @last_update: time in jiffies when this entry was refreshed last time
 	 */

-- 
2.47.3

