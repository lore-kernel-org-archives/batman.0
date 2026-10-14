Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6F24CC6B1A
	for <batman@archiver.kernel.org>; Wed, 14 Oct 2026 07:47:12 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 02EE5845B0
	for <batman@archiver.kernel.org>; Wed, 14 Oct 2026 09:47:11 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1791964031;
 b=Sdw2PTVdmcBOz4pWCiPkPIyEKQJjpsyuBYqs2AO86rWra63r6iGDc082fEpFjGa2pOqpt
 gKJgTpuZem+SiffahDNjLQduRpue6VK4LBFIvFTeb6LfzwMuzNwAQjlBfAkb49TptA4PK7T
 vA3YVqKx4ddsEUvT0lREVzcM8J25VUk=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1791964031; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=fQ7StQH6pyWruQg+FOAHvF1OqzkAnMyFq/WV4/jQGkA=;
 b=jrF0bq4BpMQyuope97cZwLkOVUuVU4LsGeaNrHD5OXySJ6Giubml0MXvQphPiHb+AFbej
 URNPOPgQugANEvt/Duv4a6VMQRiKJlUL8d7bOWgvqx/LaEWb7qaJTaxVhxJrafpnqLh7bKH
 08XxY+/3V/NW4i9O332k43ed8U76YQk=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 0FE2383F7E
	for <b.a.t.m.a.n@lists.open-mesh.org>; Wed, 14 Oct 2026 09:46:32 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1791963992;
	b=nQGS6mld9Ujc9ux3lpTlcPDKoGoZMu05X6cOSxm1sPILBPrkms6O8CNvvN4cRkhXeN1ImC
	2IBmX/Svvy1PCqbNiyejkP0ToU1I22oQmBrWXWRKZoSrUPsB/CmnJ7ijyMgM0zNkQYazip
	+IU4jAhoGXulrQo06H3pmsInuaH7RM0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1791963992;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=fQ7StQH6pyWruQg+FOAHvF1OqzkAnMyFq/WV4/jQGkA=;
	b=pNoKkiYICNVx13rSDVO/3yjzz01epVOQoOGsHYHWXPuQJ0sBNS7/NC1n0Hl8OJqwct9Go3
	uEdkttF8EcM2dqa3G8B2WZzSBsBlSeZKu7UROUTPxQUI6fxQCZCcoDIzeFk1ovbScHVxLS
	xt2ppP8KOrzyUgNhMfp7/1XO4R2A4Bk=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=tSsK09qd;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id 9C7EB20C4F;
	Wed, 14 Oct 2026 07:46:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1791963991;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fQ7StQH6pyWruQg+FOAHvF1OqzkAnMyFq/WV4/jQGkA=;
	b=tSsK09qdeaaUfYQWumYehUwBtt3MKX1o2JIBF++ewORK5NsbchODChw7yGfagCavcEWxNv
	RsMRIVck4C/VBtEhWoEfsfTfHe0lc76dDj4Q/1YMi8l8WaIKNhIQ5gwx/EUQaYUAsPP96W
	aON1RbYjGyQA6YXwymNHZzB1Dv3yzIg=
From: Sven Eckelmann <sven@narfation.org>
Date: Wed, 14 Oct 2026 09:46:02 +0200
Subject: [PATCH batadv v2 3/6] batman-adv: dat: use dedicated key type for
 DAT hash
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261014-hash-key-v2-3-7cb91c7df2cb@narfation.org>
References: <20261014-hash-key-v2-0-7cb91c7df2cb@narfation.org>
In-Reply-To: <20261014-hash-key-v2-0-7cb91c7df2cb@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=8253; i=sven@narfation.org;
 h=from:subject:message-id; bh=hztnS8MWNJ+RrDFKvc9gL+e31lpw/eWkSXPbhVtoQig=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFnnjT1vBIqICR6yd67gX5THXBx6wzG4PrYghlf34LEAA
 YmnSzZ2lLIwiHExyIopsuy5kn9+M/tb+c/TPh6FmcPKBDKEgYtTACZSncjI8EB4ModWyMGjTO0l
 0zbfdbN8/5Pz6QLN3UXLmthmB4XY+TP8My/4H+Fh9pF/QjtTYzvD3unfvK7Gunnc1O59G6WhVOD
 OCQA=
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: DRWKJE33WJXV63R6PQ6SLGLV7ECBVFHM
X-Message-ID-Hash: DRWKJE33WJXV63R6PQ6SLGLV7ECBVFHM
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/DRWKJE33WJXV63R6PQ6SLGLV7ECBVFHM/>
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
index 0260ed7e828b2..d785d6ec563d8 100644
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
@@ -711,8 +707,11 @@ batadv_dat_select_candidates(struct batadv_priv *bat_priv, __be32 ip_dst,
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
 
@@ -723,9 +722,7 @@ batadv_dat_select_candidates(struct batadv_priv *bat_priv, __be32 ip_dst,
 	if (!res)
 		return NULL;
 
-	dat.ip = ip_dst;
-	dat.vid = vid;
-	ip_key = (batadv_dat_addr_t)batadv_hash_dat(&dat,
+	ip_key = (batadv_dat_addr_t)batadv_hash_dat(&key,
 						    BATADV_DAT_ADDR_MAX);
 
 	batadv_dbg(BATADV_DBG_DAT, bat_priv,
@@ -957,9 +954,9 @@ batadv_dat_cache_dump_entry(struct sk_buff *msg, u32 portid,
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
@@ -1518,7 +1515,7 @@ bool batadv_dat_snoop_incoming_arp_reply(struct batadv_priv *bat_priv,
 			batadv_dbg(BATADV_DBG_DAT, bat_priv,
 				   "Doubled ARP reply removed: ARP MSG = [src: %pM-%pI4 dst: %pM-%pI4]; dat_entry: %pM-%pI4\n",
 				   hw_src, &ip_src, hw_dst, &ip_dst,
-				   mac, &dat_entry->ip);
+				   mac, &dat_entry->key.ip);
 			dropped = true;
 		}
 	}
diff --git a/net/batman-adv/types.h b/net/batman-adv/types.h
index 7285fe1bcc759..28dad2f4b88f4 100644
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

