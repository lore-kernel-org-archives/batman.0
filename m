Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8C4D606A332
	for <batman@archiver.kernel.org>; Sat, 14 Nov 2026 09:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=simonwunderlich.de header.i=@simonwunderlich.de header.a=rsa-sha256 header.s=09092022 header.b=J+/8JL5c
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 5CC4784941
	for <batman@archiver.kernel.org>; Sat, 14 Nov 2026 10:17:37 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1794647857;
 b=tiRdIipUPSgAH65chXQQ6piRiMdt1KXUTd4bPig3wMuMWFWVyUId0kNnn8E5TzOdQKeh4
 NsDsFhozzmyTsI6stCL2IdSn8ZA1iJ0lF3FmEzNt2hfmY1acELHZYBtQrMG25glxzA+usMe
 gdKUsKBTz4HF8c5wkaxAuAndGZ7PAMI=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1794647857; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=8MXoR4PCQOMlyDOZu5v7kSxWqHfTqxmfQJ3n61B78xA=;
 b=eb9yhq70nZVupBVyxbQmg1BujH0uJ4jR9jxLqy5cX5GJEIXcZyVM7jzzq2Y8i2316hfGr
 sMWx3NVrz5qGca2+9iOLb0dojFvVVrUYX13xeRfw8V6969mHaI05kfxq0RocRj8PHKgTHL8
 J6ffCxavlpOw2Th0hXKEVDUJ0IcJ7Ps=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass header.from=simonwunderlich.de policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=simonwunderlich.de policy.dmarc=none
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id BEE4E82269
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sat, 14 Nov 2026 10:16:01 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1794647771;
	b=1zR/uPdC4wuasbsFSjfc6hDB7FQULlBiSli94e7bjkLaNrKH34tH8Bq5gF17cLzap3hMv7
	uvWMtTV5PUGz9/c780G+XJChx3Lq1QGO8F4gbMn3ReM/oqJfC+5l/zRM/YtthOvOacvD1i
	+pl71bX1QAQ0jr+P7Yr61AFPvh8oafY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1794647771;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=8MXoR4PCQOMlyDOZu5v7kSxWqHfTqxmfQJ3n61B78xA=;
	b=xwfpuo7AFpIE+iOQ73AHxXcFR+Gx/TBOvpuCIcc1dGIvLjQqiu6UGMoW4FyuJv6bJhjEg3
	lVD+EwFE1GToN203koWCgcWs5lNuEQhTfj48uhpoqxzxGM3bO9138NT8jTkqcToN+0faX2
	CiDN98YZdRM7njxytzcU0rRnh39T7cM=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=simonwunderlich.de header.s=09092022 header.b="J+/8JL5c";
	spf=pass (diktynna.open-mesh.org: domain of sw@simonwunderlich.de designates
 23.88.38.48 as permitted sender) smtp.mailfrom=sw@simonwunderlich.de;
	dmarc=pass (policy=none) header.from=simonwunderlich.de
Received: from kero.packetmixer.de (unknown
 [IPv6:2a02:3037:6ed:dd6c:838:344b:3152:2d5e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by mail.simonwunderlich.de (Postfix) with UTF8SMTPSA id 03A9AFA1B0;
	Sat, 14 Nov 2026 10:16:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1794647761;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8MXoR4PCQOMlyDOZu5v7kSxWqHfTqxmfQJ3n61B78xA=;
	b=J+/8JL5cvaP3sKZulXFWDruQjStLoq+ZMTzWJx4tWlwm33/fFSt/3wDWzZwE16R+MHxGuH
	4zf04Btwtu3UklejPCTMSis/Lx6GV920V7TRPrguMTm/dqkogoLRcpfogH6j5WMV4R76hP
	UXWbjF7fUx9wsYisatOARmsF2FQPFxallmHlWO/r78tpxVCC7V8u3d4LR0yrttdM9CTps4
	ThenKvuP5oDiEDnpnaXWwB+E0moxxDaegEkIugBvBrVa3UzL0GRQVs7dnDOuGHOxxBBjQi
	8xuqd+3//AQG/o3B9daYiBjoSsnKaEMnYDIq8M263De9Lw6Rhr01zKEowiJIdw==
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
Subject: [PATCH net-next 03/15] batman-adv: dat: use dedicated key type for
 DAT hash
Date: Sat, 14 Nov 2026 10:15:44 +0100
Message-ID: <20261114091556.3336038-4-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261114091556.3336038-1-sw@simonwunderlich.de>
References: <20261114091556.3336038-1-sw@simonwunderlich.de>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: X67B7ODNSMI3H3CXLP65AYZMGZGOXEUT
X-Message-ID-Hash: X67B7ODNSMI3H3CXLP65AYZMGZGOXEUT
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/X67B7ODNSMI3H3CXLP65AYZMGZGOXEUT/>
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

The DAT hash and the DHT candidate selection hash a dummy struct
batadv_dat_entry on the stack in which only ip and vid are filled.
batadv_dat_entry_hash_find() then compares ip and vid inline instead of
using batadv_compare_dat(), so the key is spelled out in three places.

Move ip and vid into a new struct batadv_dat_entry_key, embedded as
batadv_dat_entry::key. The helpers are only using this key for
hashing/comparison.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/distributed-arp-table.c | 73 ++++++++++++--------------
 net/batman-adv/types.h                 | 19 +++++--
 2 files changed, 49 insertions(+), 43 deletions(-)

diff --git a/net/batman-adv/distributed-arp-table.c b/net/batman-adv/distributed-arp-table.c
index 862a3a5eab566..204d48a8257ae 100644
--- a/net/batman-adv/distributed-arp-table.c
+++ b/net/batman-adv/distributed-arp-table.c
@@ -276,19 +276,18 @@ static void batadv_dat_purge(struct work_struct *work)
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
@@ -352,30 +351,30 @@ static __be32 batadv_arp_ip_dst(struct sk_buff *skb, int hdr_size)
 
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
@@ -402,26 +401,23 @@ batadv_dat_entry_hash_find(struct batadv_priv *bat_priv, __be32 ip,
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
@@ -457,7 +453,7 @@ static void batadv_dat_entry_add(struct batadv_priv *bat_priv, __be32 ip,
 		WRITE_ONCE(dat_entry->last_update, jiffies);
 		batadv_dbg(BATADV_DBG_DAT, bat_priv,
 			   "Entry updated: %pI4 %pM (vid: %d)\n",
-			   &dat_entry->ip, mac_addr,
+			   &dat_entry->key.ip, mac_addr,
 			   batadv_print_vid(vid));
 		goto out;
 	}
@@ -466,15 +462,15 @@ static void batadv_dat_entry_add(struct batadv_priv *bat_priv, __be32 ip,
 	if (!dat_entry)
 		goto out;
 
-	dat_entry->ip = ip;
-	dat_entry->vid = vid;
+	dat_entry->key.ip = ip;
+	dat_entry->key.vid = vid;
 	atomic64_set(&dat_entry->mac_addr, u64_mac);
 	WRITE_ONCE(dat_entry->last_update, jiffies);
 	kref_init(&dat_entry->refcount);
 
 	kref_get(&dat_entry->refcount);
 	hash_added = batadv_hash_add(bat_priv->dat.hash, batadv_compare_dat,
-				     batadv_hash_dat, dat_entry,
+				     batadv_hash_dat, &dat_entry->key,
 				     &dat_entry->hash_entry);
 
 	if (unlikely(hash_added != 0)) {
@@ -484,7 +480,7 @@ static void batadv_dat_entry_add(struct batadv_priv *bat_priv, __be32 ip,
 	}
 
 	batadv_dbg(BATADV_DBG_DAT, bat_priv, "New entry added: %pI4 %pM (vid: %d)\n",
-		   &dat_entry->ip, mac_addr, batadv_print_vid(vid));
+		   &dat_entry->key.ip, mac_addr, batadv_print_vid(vid));
 
 out:
 	batadv_dat_entry_put(dat_entry);
@@ -712,8 +708,11 @@ batadv_dat_select_candidates(struct batadv_priv *bat_priv, __be32 ip_dst,
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
 
@@ -724,9 +723,7 @@ batadv_dat_select_candidates(struct batadv_priv *bat_priv, __be32 ip_dst,
 	if (!res)
 		return NULL;
 
-	dat.ip = ip_dst;
-	dat.vid = vid;
-	ip_key = (batadv_dat_addr_t)batadv_hash_dat(&dat,
+	ip_key = (batadv_dat_addr_t)batadv_hash_dat(&key,
 						    BATADV_DAT_ADDR_MAX);
 
 	batadv_dbg(BATADV_DBG_DAT, bat_priv,
@@ -960,9 +957,9 @@ batadv_dat_cache_dump_entry(struct sk_buff *msg, u32 portid,
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
@@ -1521,7 +1518,7 @@ bool batadv_dat_snoop_incoming_arp_reply(struct batadv_priv *bat_priv,
 			batadv_dbg(BATADV_DBG_DAT, bat_priv,
 				   "Doubled ARP reply removed: ARP MSG = [src: %pM-%pI4 dst: %pM-%pI4]; dat_entry: %pM-%pI4\n",
 				   hw_src, &ip_src, hw_dst, &ip_dst,
-				   mac, &dat_entry->ip);
+				   mac, &dat_entry->key.ip);
 			dropped = true;
 		}
 	}
diff --git a/net/batman-adv/types.h b/net/batman-adv/types.h
index aae9c38a96b48..3a340ce9660d9 100644
--- a/net/batman-adv/types.h
+++ b/net/batman-adv/types.h
@@ -2229,20 +2229,29 @@ struct batadv_algo_ops {
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

