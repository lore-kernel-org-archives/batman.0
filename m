Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 293E3C02180
	for <batman-adv@archiver.kernel.org>; Mon, 13 Jan 2025 20:07:01 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id A347284316
	for <batman-adv@archiver.kernel.org>; Mon, 13 Jan 2025 21:06:59 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1736798819;
 b=oVSOVVgs9a6IsEJG9DxhKLzYkmh3UZW6YSxQ10kOt0K4mKX1JYmUg4BQJrubqsByG6jqf
 of/dwoN4GsyxNx2dd04p7w1MdQVUpUKiVLM/ldM6GTDD02/3bE1iVB8SZeOImkrE1dIUT8j
 oo+kNn8gVhHRjy++DjiQiPO7hqOrSMc=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1736798819; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=RuOSI14L6/evNXEQQwZFhw1abbSEgbYJjvZOkO1SbU0=;
 b=Al4+dkB6Z1dGIb0qm42+Y4OMVdm6J2aSmeL282zIjv6CNG2v2CUWMjHGA5eIq5Vs91on9
 QUvf/Q/+GDcicEvd/ogUDgJb7gJPsU/EKRnIbhdIXfPHtxS+sE89Dm+XHuhKI945aNiJQst
 y0Iq0iUfbbfVeaiwpZ12tKzOSl4DmCE=
ARC-Authentication-Results: i=2; open-mesh.org; dkim=fail;
  arc=pass;
  dmarc=none
Authentication-Results: open-mesh.org; dkim=fail; arc=pass; dmarc=none
Received: from mail.aperture-lab.de (mail.aperture-lab.de [116.203.183.178])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 1DEDC81A5F
	for <b.a.t.m.a.n@lists.open-mesh.org>; Mon, 13 Jan 2025 21:05:17 +0100 (CET)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1736798717;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RuOSI14L6/evNXEQQwZFhw1abbSEgbYJjvZOkO1SbU0=;
	b=bT1UUjjSKvOyqMMHHO8NgoOq5QelvgXyJJYpIvSNlCBc437L/qUIVMZnSHTfrfgM2C8HdF
	7z6cDb310pKFqwyxc4McaYWPkImnzGFSrCZrRij8tsxf9UP5g/tLTt+hpDxpAPsLjQDZSI
	alTfCFFs6uBUMmTxamlG3zRhIinvq1k=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=none;
	spf=pass (diktynna.open-mesh.org: domain of linus.luessing@c0d3.blue
 designates 116.203.183.178 as permitted sender)
 smtp.mailfrom=linus.luessing@c0d3.blue;
	dmarc=none
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1736798717; a=rsa-sha256;
	cv=none;
	b=Bsu4rMJ3Gg+rg3lVbqpf43Se8ngQoON/daZTrApGVbjlVPGNtpDlU98MTV+iofuDba8Hay
	mqb6BUFN9SXfylMKcRUIo56DAt5P+cFXg4ye0MNeJiJqMFKsO06s+mbgFzJ+H+kU1qWlu3
	p34FzVCkll+IlTt3btckKl+VoGzqPlQ=
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 8D49C540FD3;
	Mon, 13 Jan 2025 21:05:16 +0100 (CET)
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@c0d3.blue>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@c0d3.blue>
Subject: [PATCH v8 2/3] batman-adv: split DAT cache into DAT cache and DAT DHT
Date: Mon, 13 Jan 2025 20:31:40 +0100
Message-ID: <20250113200510.18681-3-linus.luessing@c0d3.blue>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250113200510.18681-1-linus.luessing@c0d3.blue>
References: <20250113200510.18681-1-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
Message-ID-Hash: 7ZCJHFMDGKY5SMIO52ZIVJENQC5L4P3N
X-Message-ID-Hash: 7ZCJHFMDGKY5SMIO52ZIVJENQC5L4P3N
X-MailFrom: linus.luessing@c0d3.blue
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-0;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-1;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-2; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/7ZCJHFMDGKY5SMIO52ZIVJENQC5L4P3N/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

Similar to the translation table split the (mostly) locally maintained
DAT cache and the DAT DHT concepts into two separate tables.

This eases the monitoring and debugging regarding the origin of DAT
entries. And allows to apply differing properties to entries in the DAT
cache and DAT DHT in the future, like distinct timeouts.

Signed-off-by: Linus Lüssing <linus.luessing@c0d3.blue>
---
 include/uapi/linux/batman_adv.h        |   5 +
 net/batman-adv/distributed-arp-table.c | 316 +++++++++++++++++++------
 net/batman-adv/distributed-arp-table.h |  13 +-
 net/batman-adv/netlink.c               |   5 +
 net/batman-adv/routing.c               |   8 +-
 net/batman-adv/types.h                 |   7 +-
 6 files changed, 269 insertions(+), 85 deletions(-)

diff --git a/include/uapi/linux/batman_adv.h b/include/uapi/linux/batman_adv.h
index 35dc016c9bb4..9498ccb09d67 100644
--- a/include/uapi/linux/batman_adv.h
+++ b/include/uapi/linux/batman_adv.h
@@ -613,6 +613,11 @@ enum batadv_nl_commands {
 	 */
 	BATADV_CMD_SET_VLAN,
 
+	/**
+	 * @BATADV_CMD_GET_DAT_DHT: Query list of DAT DHT entries
+	 */
+	BATADV_CMD_GET_DAT_DHT,
+
 	/* add new commands above here */
 
 	/**
diff --git a/net/batman-adv/distributed-arp-table.c b/net/batman-adv/distributed-arp-table.c
index e5a07152d4ec..8d6d5e338130 100644
--- a/net/batman-adv/distributed-arp-table.c
+++ b/net/batman-adv/distributed-arp-table.c
@@ -144,17 +144,17 @@ static bool batadv_dat_to_purge(struct batadv_dat_entry *dat_entry)
 }
 
 /**
- * __batadv_dat_purge() - delete entries from the DAT local storage
- * @bat_priv: the bat priv with all the soft interface information
+ * __batadv_dat_purge() - delete entries from a DAT hash table
+ * @hash: the hash table to delete from
  * @to_purge: function in charge to decide whether an entry has to be purged or
  *	      not. This function takes the dat_entry as argument and has to
  *	      returns a boolean value: true is the entry has to be deleted,
  *	      false otherwise
  *
- * Loops over each entry in the DAT local storage and deletes it if and only if
+ * Loops over each entry in a DAT hash table and deletes it if and only if
  * the to_purge function passed as argument returns true.
  */
-static void __batadv_dat_purge(struct batadv_priv *bat_priv,
+static void __batadv_dat_purge(struct batadv_hashtable *hash,
 			       bool (*to_purge)(struct batadv_dat_entry *))
 {
 	spinlock_t *list_lock; /* protects write access to the hash lists */
@@ -163,12 +163,12 @@ static void __batadv_dat_purge(struct batadv_priv *bat_priv,
 	struct hlist_head *head;
 	u32 i;
 
-	if (!bat_priv->dat.hash)
+	if (!hash)
 		return;
 
-	for (i = 0; i < bat_priv->dat.hash->size; i++) {
-		head = &bat_priv->dat.hash->table[i];
-		list_lock = &bat_priv->dat.hash->list_locks[i];
+	for (i = 0; i < hash->size; i++) {
+		head = &hash->table[i];
+		list_lock = &hash->list_locks[i];
 
 		spin_lock_bh(list_lock);
 		hlist_for_each_entry_safe(dat_entry, node_tmp, head,
@@ -201,7 +201,8 @@ static void batadv_dat_purge(struct work_struct *work)
 	priv_dat = container_of(delayed_work, struct batadv_priv_dat, work);
 	bat_priv = container_of(priv_dat, struct batadv_priv, dat);
 
-	__batadv_dat_purge(bat_priv, batadv_dat_to_purge);
+	__batadv_dat_purge(bat_priv->dat.cache_hash, batadv_dat_to_purge);
+	__batadv_dat_purge(bat_priv->dat.dht_hash, batadv_dat_to_purge);
 	batadv_dat_start_timer(bat_priv);
 }
 
@@ -313,21 +314,19 @@ static u32 batadv_hash_dat(const void *data, u32 size)
 }
 
 /**
- * batadv_dat_entry_hash_find() - look for a given dat_entry in the local hash
- * table
- * @bat_priv: the bat priv with all the soft interface information
+ * batadv_dat_entry_hash_find() - look for a given dat_entry in a hash table
+ * @hash: the hash table to search in
  * @ip: search key
  * @vid: VLAN identifier
  *
  * Return: the dat_entry if found, NULL otherwise.
  */
 static struct batadv_dat_entry *
-batadv_dat_entry_hash_find(struct batadv_priv *bat_priv, __be32 ip,
+batadv_dat_entry_hash_find(struct batadv_hashtable *hash, __be32 ip,
 			   unsigned short vid)
 {
 	struct hlist_head *head;
 	struct batadv_dat_entry to_find, *dat_entry, *dat_entry_tmp = NULL;
-	struct batadv_hashtable *hash = bat_priv->dat.hash;
 	u32 index;
 
 	if (!hash)
@@ -355,28 +354,63 @@ batadv_dat_entry_hash_find(struct batadv_priv *bat_priv, __be32 ip,
 	return dat_entry_tmp;
 }
 
+/**
+ * batadv_dat_cache_entry_find() - look for a given dat_entry in the DAT cache
+ * @bat_priv: the bat priv with all the soft interface information
+ * @ip: search key
+ * @vid: VLAN identifier
+ *
+ * Return: the dat_entry if found, NULL otherwise.
+ */
+static inline struct batadv_dat_entry *
+batadv_dat_cache_entry_find(struct batadv_priv *bat_priv, __be32 ip,
+			    unsigned short vid)
+{
+	return batadv_dat_entry_hash_find(bat_priv->dat.cache_hash, ip, vid);
+}
+
+/**
+ * batadv_dat_dht_entry_find() - look for a given dat_entry in the DAT DHT
+ * @bat_priv: the bat priv with all the soft interface information
+ * @ip: search key
+ * @vid: VLAN identifier
+ *
+ * Return: the dat_entry if found, NULL otherwise.
+ */
+static inline struct batadv_dat_entry *
+batadv_dat_dht_entry_find(struct batadv_priv *bat_priv, __be32 ip,
+			  unsigned short vid)
+{
+	return batadv_dat_entry_hash_find(bat_priv->dat.dht_hash, ip, vid);
+}
+
 /**
  * batadv_dat_entry_add() - add a new dat entry or update it if already exists
  * @bat_priv: the bat priv with all the soft interface information
+ * @hash: the hash table to add to
  * @ip: ipv4 to add/edit
  * @mac_addr: mac address to assign to the given ipv4
  * @vid: VLAN identifier
+ * @tablename: the name of the hash table to add to
  */
-static void batadv_dat_entry_add(struct batadv_priv *bat_priv, __be32 ip,
-				 u8 *mac_addr, unsigned short vid)
+static void
+batadv_dat_entry_add(struct batadv_priv *bat_priv,
+		     struct batadv_hashtable *hash, __be32 ip,
+		     u8 *mac_addr, unsigned short vid,
+		     const char *tablename)
 {
 	struct batadv_dat_entry *dat_entry;
 	int hash_added;
 
-	dat_entry = batadv_dat_entry_hash_find(bat_priv, ip, vid);
+	dat_entry = batadv_dat_entry_hash_find(hash, ip, vid);
 	/* if this entry is already known, just update it */
 	if (dat_entry) {
 		if (!batadv_compare_eth(dat_entry->mac_addr, mac_addr))
 			ether_addr_copy(dat_entry->mac_addr, mac_addr);
 		dat_entry->last_update = jiffies;
 		batadv_dbg(BATADV_DBG_DAT, bat_priv,
-			   "Entry updated: %pI4 %pM (vid: %d)\n",
-			   &dat_entry->ip, dat_entry->mac_addr,
+			   "Entry updated in %s: %pI4 %pM (vid: %d)\n",
+			   tablename, &dat_entry->ip, dat_entry->mac_addr,
 			   batadv_print_vid(vid));
 		goto out;
 	}
@@ -392,7 +426,7 @@ static void batadv_dat_entry_add(struct batadv_priv *bat_priv, __be32 ip,
 	kref_init(&dat_entry->refcount);
 
 	kref_get(&dat_entry->refcount);
-	hash_added = batadv_hash_add(bat_priv->dat.hash, batadv_compare_dat,
+	hash_added = batadv_hash_add(hash, batadv_compare_dat,
 				     batadv_hash_dat, dat_entry,
 				     &dat_entry->hash_entry);
 
@@ -402,13 +436,45 @@ static void batadv_dat_entry_add(struct batadv_priv *bat_priv, __be32 ip,
 		goto out;
 	}
 
-	batadv_dbg(BATADV_DBG_DAT, bat_priv, "New entry added: %pI4 %pM (vid: %d)\n",
-		   &dat_entry->ip, dat_entry->mac_addr, batadv_print_vid(vid));
+	batadv_dbg(BATADV_DBG_DAT, bat_priv,
+		   "New entry added in %s: %pI4 %pM (vid: %d)\n",
+		   tablename, &dat_entry->ip, dat_entry->mac_addr,
+		   batadv_print_vid(vid));
 
 out:
 	batadv_dat_entry_put(dat_entry);
 }
 
+/**
+ * batadv_dat_cache_entry_add() - add or update dat_entry in the DAT cache
+ * @bat_priv: the bat priv with all the soft interface information
+ * @ip: ipv4 to add/edit
+ * @mac_addr: mac address to assign to the given ipv4
+ * @vid: VLAN identifier
+ */
+static inline void
+batadv_dat_cache_entry_add(struct batadv_priv *bat_priv, __be32 ip,
+			   u8 *mac_addr, unsigned short vid)
+{
+	batadv_dat_entry_add(bat_priv, bat_priv->dat.cache_hash, ip, mac_addr,
+			     vid, "cache");
+}
+
+/**
+ * batadv_dat_dht_entry_add() - add or update dat_entry in the DAT DHT
+ * @bat_priv: the bat priv with all the soft interface information
+ * @ip: ipv4 to add/edit
+ * @mac_addr: mac address to assign to the given ipv4
+ * @vid: VLAN identifier
+ */
+static inline void
+batadv_dat_dht_entry_add(struct batadv_priv *bat_priv, __be32 ip,
+			 u8 *mac_addr, unsigned short vid)
+{
+	batadv_dat_entry_add(bat_priv, bat_priv->dat.dht_hash, ip, mac_addr,
+			     vid, "dht");
+}
+
 #ifdef CONFIG_BATMAN_ADV_DEBUG
 
 /**
@@ -785,19 +851,57 @@ static void batadv_dat_tvlv_ogm_handler_v1(struct batadv_priv *bat_priv,
 }
 
 /**
- * batadv_dat_hash_free() - free the local DAT hash table
+ * batadv_dat_hash_free() - free a DAT hash table
  * @bat_priv: the bat priv with all the soft interface information
  */
-static void batadv_dat_hash_free(struct batadv_priv *bat_priv)
+static void batadv_dat_hash_free(struct batadv_hashtable **hash)
 {
-	if (!bat_priv->dat.hash)
+	if (!(*hash))
 		return;
 
-	__batadv_dat_purge(bat_priv, NULL);
+	__batadv_dat_purge(*hash, NULL);
 
-	batadv_hash_destroy(bat_priv->dat.hash);
+	batadv_hash_destroy(*hash);
 
-	bat_priv->dat.hash = NULL;
+	*hash = NULL;
+}
+
+/**
+ * batadv_dat_cache_hash_init() - initialise the DAT cache hash table
+ * @bat_priv: the bat priv with all the soft interface information
+ *
+ * Return: 0 in case of success, a negative error code otherwise
+ */
+static int batadv_dat_cache_hash_init(struct batadv_priv *bat_priv)
+{
+	if (bat_priv->dat.cache_hash)
+		return 0;
+
+	bat_priv->dat.cache_hash = batadv_hash_new(1024);
+
+	if (!bat_priv->dat.cache_hash)
+		return -ENOMEM;
+
+	return 0;
+}
+
+/**
+ * batadv_dat_dht_hash_init() - initialise the DAT DHT hash table
+ * @bat_priv: the bat priv with all the soft interface information
+ *
+ * Return: 0 in case of success, a negative error code otherwise
+ */
+static int batadv_dat_dht_hash_init(struct batadv_priv *bat_priv)
+{
+	if (bat_priv->dat.dht_hash)
+		return 0;
+
+	bat_priv->dat.dht_hash = batadv_hash_new(1024);
+
+	if (!bat_priv->dat.dht_hash)
+		return -ENOMEM;
+
+	return 0;
 }
 
 /**
@@ -808,13 +912,15 @@ static void batadv_dat_hash_free(struct batadv_priv *bat_priv)
  */
 int batadv_dat_init(struct batadv_priv *bat_priv)
 {
-	if (bat_priv->dat.hash)
-		return 0;
+	int ret;
 
-	bat_priv->dat.hash = batadv_hash_new(1024);
+	ret = batadv_dat_cache_hash_init(bat_priv);
+	if (ret < 0)
+		return ret;
 
-	if (!bat_priv->dat.hash)
-		return -ENOMEM;
+	ret = batadv_dat_dht_hash_init(bat_priv);
+	if (ret < 0)
+		return ret;
 
 	INIT_DELAYED_WORK(&bat_priv->dat.work, batadv_dat_purge);
 	batadv_dat_start_timer(bat_priv);
@@ -837,30 +943,31 @@ void batadv_dat_free(struct batadv_priv *bat_priv)
 
 	cancel_delayed_work_sync(&bat_priv->dat.work);
 
-	batadv_dat_hash_free(bat_priv);
+	batadv_dat_hash_free(&bat_priv->dat.cache_hash);
+	batadv_dat_hash_free(&bat_priv->dat.dht_hash);
 }
 
 /**
- * batadv_dat_cache_dump_entry() - dump one entry of the DAT cache table to a
- *  netlink socket
+ * batadv_dat_dump_entry() - dump one entry of a DAT hash table to a netlink
+ *  socket
  * @msg: buffer for the message
  * @portid: netlink port
  * @cb: Control block containing additional options
  * @dat_entry: entry to dump
+ * @cmd: generic netlink command
  *
  * Return: 0 or error code.
  */
 static int
-batadv_dat_cache_dump_entry(struct sk_buff *msg, u32 portid,
-			    struct netlink_callback *cb,
-			    struct batadv_dat_entry *dat_entry)
+batadv_dat_dump_entry(struct sk_buff *msg, u32 portid,
+		      struct netlink_callback *cb,
+		      struct batadv_dat_entry *dat_entry, u8 cmd)
 {
 	int msecs;
 	void *hdr;
 
 	hdr = genlmsg_put(msg, portid, cb->nlh->nlmsg_seq,
-			  &batadv_netlink_family, NLM_F_MULTI,
-			  BATADV_CMD_GET_DAT_CACHE);
+			  &batadv_netlink_family, NLM_F_MULTI, cmd);
 	if (!hdr)
 		return -ENOBUFS;
 
@@ -883,22 +990,23 @@ batadv_dat_cache_dump_entry(struct sk_buff *msg, u32 portid,
 }
 
 /**
- * batadv_dat_cache_dump_bucket() - dump one bucket of the DAT cache table to
- *  a netlink socket
+ * batadv_dat_dump_bucket() - dump one bucket of a DAT hash table to a netlink
+ *  socket
  * @msg: buffer for the message
  * @portid: netlink port
  * @cb: Control block containing additional options
  * @hash: hash to dump
  * @bucket: bucket index to dump
  * @idx_skip: How many entries to skip
+ * @cmd: generic netlink command
  *
  * Return: 0 or error code.
  */
 static int
-batadv_dat_cache_dump_bucket(struct sk_buff *msg, u32 portid,
-			     struct netlink_callback *cb,
-			     struct batadv_hashtable *hash, unsigned int bucket,
-			     int *idx_skip)
+batadv_dat_dump_bucket(struct sk_buff *msg, u32 portid,
+		       struct netlink_callback *cb,
+		       struct batadv_hashtable *hash, unsigned int bucket,
+		       int *idx_skip, u8 cmd)
 {
 	struct batadv_dat_entry *dat_entry;
 	int idx = 0;
@@ -910,7 +1018,7 @@ batadv_dat_cache_dump_bucket(struct sk_buff *msg, u32 portid,
 		if (idx < *idx_skip)
 			goto skip;
 
-		if (batadv_dat_cache_dump_entry(msg, portid, cb, dat_entry)) {
+		if (batadv_dat_dump_entry(msg, portid, cb, dat_entry, cmd)) {
 			spin_unlock_bh(&hash->list_locks[bucket]);
 			*idx_skip = idx;
 
@@ -926,30 +1034,26 @@ batadv_dat_cache_dump_bucket(struct sk_buff *msg, u32 portid,
 }
 
 /**
- * batadv_dat_cache_dump() - dump DAT cache table to a netlink socket
+ * batadv_dat_dump() - dump a DAT hash table to a netlink socket
+ * @bat_priv: the bat priv with all the soft interface information
  * @msg: buffer for the message
  * @cb: callback structure containing arguments
+ * @hash: the hash table to dump from
+ * @cmd: generic netlink command
  *
  * Return: message length.
  */
-int batadv_dat_cache_dump(struct sk_buff *msg, struct netlink_callback *cb)
+static int
+batadv_dat_dump(struct batadv_priv *bat_priv, struct sk_buff *msg,
+		struct netlink_callback *cb, struct batadv_hashtable *hash,
+		u8 cmd)
 {
-	struct batadv_hard_iface *primary_if = NULL;
 	int portid = NETLINK_CB(cb->skb).portid;
-	struct net_device *soft_iface;
-	struct batadv_hashtable *hash;
-	struct batadv_priv *bat_priv;
+	struct batadv_hard_iface *primary_if;
 	int bucket = cb->args[0];
 	int idx = cb->args[1];
 	int ret = 0;
 
-	soft_iface = batadv_netlink_get_softif(cb);
-	if (IS_ERR(soft_iface))
-		return PTR_ERR(soft_iface);
-
-	bat_priv = netdev_priv(soft_iface);
-	hash = bat_priv->dat.hash;
-
 	primary_if = batadv_primary_if_get_selected(bat_priv);
 	if (!primary_if || primary_if->if_status != BATADV_IF_ACTIVE) {
 		ret = -ENOENT;
@@ -957,8 +1061,8 @@ int batadv_dat_cache_dump(struct sk_buff *msg, struct netlink_callback *cb)
 	}
 
 	while (bucket < hash->size) {
-		if (batadv_dat_cache_dump_bucket(msg, portid, cb, hash, bucket,
-						 &idx))
+		if (batadv_dat_dump_bucket(msg, portid, cb, hash, bucket, &idx,
+					   cmd))
 			break;
 
 		bucket++;
@@ -973,8 +1077,58 @@ int batadv_dat_cache_dump(struct sk_buff *msg, struct netlink_callback *cb)
 out:
 	batadv_hardif_put(primary_if);
 
+	return ret;
+}
+
+/**
+ * batadv_dat_cache_dump() - dump the DAT cache table to a netlink socket
+ * @msg: buffer for the message
+ * @cb: callback structure containing arguments
+ *
+ * Return: Message length on success or a negative error number otherwise.
+ */
+int batadv_dat_cache_dump(struct sk_buff *msg, struct netlink_callback *cb)
+{
+	struct net_device *soft_iface;
+	struct batadv_priv *bat_priv;
+	int ret;
+
+	soft_iface = batadv_netlink_get_softif(cb);
+	if (IS_ERR(soft_iface))
+		return PTR_ERR(soft_iface);
+
+	bat_priv = netdev_priv(soft_iface);
+
+	ret = batadv_dat_dump(bat_priv, msg, cb, bat_priv->dat.cache_hash,
+			      BATADV_CMD_GET_DAT_CACHE);
+
 	dev_put(soft_iface);
+	return ret;
+}
 
+/**
+ * batadv_dat_dht_dump() - dump the DAT DHT table to a netlink socket
+ * @msg: buffer for the message
+ * @cb: callback structure containing arguments
+ *
+ * Return: Message length on success or a negative error number otherwise.
+ */
+int batadv_dat_dht_dump(struct sk_buff *msg, struct netlink_callback *cb)
+{
+	struct net_device *soft_iface;
+	struct batadv_priv *bat_priv;
+	int ret;
+
+	soft_iface = batadv_netlink_get_softif(cb);
+	if (IS_ERR(soft_iface))
+		return PTR_ERR(soft_iface);
+
+	bat_priv = netdev_priv(soft_iface);
+
+	ret = batadv_dat_dump(bat_priv, msg, cb, bat_priv->dat.dht_hash,
+			      BATADV_CMD_GET_DAT_DHT);
+
+	dev_put(soft_iface);
 	return ret;
 }
 
@@ -1154,9 +1308,9 @@ bool batadv_dat_snoop_outgoing_arp_request(struct batadv_priv *bat_priv,
 	hw_src = batadv_arp_hw_src(skb, hdr_size);
 	ip_dst = batadv_arp_ip_dst(skb, hdr_size);
 
-	batadv_dat_entry_add(bat_priv, ip_src, hw_src, vid);
+	batadv_dat_cache_entry_add(bat_priv, ip_src, hw_src, vid);
 
-	dat_entry = batadv_dat_entry_hash_find(bat_priv, ip_dst, vid);
+	dat_entry = batadv_dat_cache_entry_find(bat_priv, ip_dst, vid);
 	if (dat_entry) {
 		/* If the ARP request is destined for a local client the local
 		 * client will answer itself. DAT would only generate a
@@ -1246,9 +1400,9 @@ bool batadv_dat_snoop_incoming_arp_request(struct batadv_priv *bat_priv,
 
 	batadv_dbg_arp(bat_priv, skb, hdr_size, "Parsing incoming ARP REQUEST");
 
-	batadv_dat_entry_add(bat_priv, ip_src, hw_src, vid);
+	batadv_dat_cache_entry_add(bat_priv, ip_src, hw_src, vid);
 
-	dat_entry = batadv_dat_entry_hash_find(bat_priv, ip_dst, vid);
+	dat_entry = batadv_dat_dht_entry_find(bat_priv, ip_dst, vid);
 	if (!dat_entry)
 		goto out;
 
@@ -1309,8 +1463,8 @@ void batadv_dat_snoop_outgoing_arp_reply(struct batadv_priv *bat_priv,
 	hw_dst = batadv_arp_hw_dst(skb, hdr_size);
 	ip_dst = batadv_arp_ip_dst(skb, hdr_size);
 
-	batadv_dat_entry_add(bat_priv, ip_src, hw_src, vid);
-	batadv_dat_entry_add(bat_priv, ip_dst, hw_dst, vid);
+	batadv_dat_cache_entry_add(bat_priv, ip_src, hw_src, vid);
+	batadv_dat_cache_entry_add(bat_priv, ip_dst, hw_dst, vid);
 
 	/* Send the ARP reply to the candidates for both the IP addresses that
 	 * the node obtained from the ARP reply
@@ -1332,7 +1486,8 @@ void batadv_dat_snoop_outgoing_arp_reply(struct batadv_priv *bat_priv,
  * packet has to be delivered to the interface
  */
 bool batadv_dat_snoop_incoming_arp_reply(struct batadv_priv *bat_priv,
-					 struct sk_buff *skb, int hdr_size)
+					 struct sk_buff *skb, int hdr_size,
+					 bool is_dht_put)
 {
 	struct batadv_dat_entry *dat_entry = NULL;
 	u16 type;
@@ -1357,13 +1512,18 @@ bool batadv_dat_snoop_incoming_arp_reply(struct batadv_priv *bat_priv,
 	hw_dst = batadv_arp_hw_dst(skb, hdr_size);
 	ip_dst = batadv_arp_ip_dst(skb, hdr_size);
 
+	if (is_dht_put) {
+		batadv_dat_dht_entry_add(bat_priv, ip_src, hw_src, vid);
+		batadv_dat_dht_entry_add(bat_priv, ip_dst, hw_dst, vid);
+	}
+
 	/* If ip_dst is already in cache and has the right mac address,
 	 * drop this frame if this ARP reply is destined for us because it's
 	 * most probably an ARP reply generated by another node of the DHT.
 	 * We have most probably received already a reply earlier. Delivering
 	 * this frame would lead to doubled receive of an ARP reply.
 	 */
-	dat_entry = batadv_dat_entry_hash_find(bat_priv, ip_src, vid);
+	dat_entry = batadv_dat_cache_entry_find(bat_priv, ip_src, vid);
 	if (dat_entry && batadv_compare_eth(hw_src, dat_entry->mac_addr)) {
 		batadv_dbg(BATADV_DBG_DAT, bat_priv, "Doubled ARP reply removed: ARP MSG = [src: %pM-%pI4 dst: %pM-%pI4]; dat_entry: %pM-%pI4\n",
 			   hw_src, &ip_src, hw_dst, &ip_dst,
@@ -1374,8 +1534,8 @@ bool batadv_dat_snoop_incoming_arp_reply(struct batadv_priv *bat_priv,
 	/* Update our internal cache with both the IP addresses the node got
 	 * within the ARP reply
 	 */
-	batadv_dat_entry_add(bat_priv, ip_src, hw_src, vid);
-	batadv_dat_entry_add(bat_priv, ip_dst, hw_dst, vid);
+	batadv_dat_cache_entry_add(bat_priv, ip_src, hw_src, vid);
+	batadv_dat_cache_entry_add(bat_priv, ip_dst, hw_dst, vid);
 
 	if (dropped)
 		goto out;
@@ -1631,8 +1791,8 @@ static void batadv_dat_put_dhcp(struct batadv_priv *bat_priv, u8 *chaddr,
 
 	skb_set_network_header(skb, ETH_HLEN);
 
-	batadv_dat_entry_add(bat_priv, yiaddr, chaddr, vid);
-	batadv_dat_entry_add(bat_priv, ip_dst, hw_dst, vid);
+	batadv_dat_cache_entry_add(bat_priv, yiaddr, chaddr, vid);
+	batadv_dat_cache_entry_add(bat_priv, ip_dst, hw_dst, vid);
 
 	batadv_dat_forward_data(bat_priv, skb, yiaddr, vid,
 				BATADV_P_DAT_DHT_PUT);
@@ -1757,8 +1917,8 @@ void batadv_dat_snoop_incoming_dhcp_ack(struct batadv_priv *bat_priv,
 	hw_src = ethhdr->h_source;
 	vid = batadv_dat_get_vid(skb, &hdr_size);
 
-	batadv_dat_entry_add(bat_priv, yiaddr, chaddr, vid);
-	batadv_dat_entry_add(bat_priv, ip_src, hw_src, vid);
+	batadv_dat_cache_entry_add(bat_priv, yiaddr, chaddr, vid);
+	batadv_dat_cache_entry_add(bat_priv, ip_src, hw_src, vid);
 
 	batadv_dbg(BATADV_DBG_DAT, bat_priv,
 		   "Snooped from incoming DHCPACK (server address): %pI4, %pM (vid: %i)\n",
@@ -1802,7 +1962,7 @@ bool batadv_dat_drop_broadcast_packet(struct batadv_priv *bat_priv,
 		goto out;
 
 	ip_dst = batadv_arp_ip_dst(forw_packet->skb, hdr_size);
-	dat_entry = batadv_dat_entry_hash_find(bat_priv, ip_dst, vid);
+	dat_entry = batadv_dat_cache_entry_find(bat_priv, ip_dst, vid);
 	/* check if the node already got this entry */
 	if (!dat_entry) {
 		batadv_dbg(BATADV_DBG_DAT, bat_priv,
diff --git a/net/batman-adv/distributed-arp-table.h b/net/batman-adv/distributed-arp-table.h
index bed7f3d20844..28ac93b0113d 100644
--- a/net/batman-adv/distributed-arp-table.h
+++ b/net/batman-adv/distributed-arp-table.h
@@ -31,7 +31,8 @@ bool batadv_dat_snoop_incoming_arp_request(struct batadv_priv *bat_priv,
 void batadv_dat_snoop_outgoing_arp_reply(struct batadv_priv *bat_priv,
 					 struct sk_buff *skb);
 bool batadv_dat_snoop_incoming_arp_reply(struct batadv_priv *bat_priv,
-					 struct sk_buff *skb, int hdr_size);
+					 struct sk_buff *skb, int hdr_size,
+					 bool is_dht_put);
 void batadv_dat_snoop_outgoing_dhcp_ack(struct batadv_priv *bat_priv,
 					struct sk_buff *skb,
 					__be16 proto,
@@ -74,6 +75,7 @@ batadv_dat_init_own_addr(struct batadv_priv *bat_priv,
 int batadv_dat_init(struct batadv_priv *bat_priv);
 void batadv_dat_free(struct batadv_priv *bat_priv);
 int batadv_dat_cache_dump(struct sk_buff *msg, struct netlink_callback *cb);
+int batadv_dat_dht_dump(struct sk_buff *msg, struct netlink_callback *cb);
 
 /**
  * batadv_dat_inc_counter() - increment the correct DAT packet counter
@@ -126,7 +128,8 @@ batadv_dat_snoop_outgoing_arp_reply(struct batadv_priv *bat_priv,
 
 static inline bool
 batadv_dat_snoop_incoming_arp_reply(struct batadv_priv *bat_priv,
-				    struct sk_buff *skb, int hdr_size)
+				    struct sk_buff *skb, int hdr_size,
+				    bool is_dht_put)
 {
 	return false;
 }
@@ -176,6 +179,12 @@ batadv_dat_cache_dump(struct sk_buff *msg, struct netlink_callback *cb)
 	return -EOPNOTSUPP;
 }
 
+static inline int
+batadv_dat_dht_dump(struct sk_buff *msg, struct netlink_callback *cb)
+{
+	return -EOPNOTSUPP;
+}
+
 static inline void batadv_dat_inc_counter(struct batadv_priv *bat_priv,
 					  u8 subtype)
 {
diff --git a/net/batman-adv/netlink.c b/net/batman-adv/netlink.c
index c37e0995f67e..6197b5840469 100644
--- a/net/batman-adv/netlink.c
+++ b/net/batman-adv/netlink.c
@@ -1502,6 +1502,11 @@ static const struct genl_small_ops batadv_netlink_ops[] = {
 		.flags = GENL_UNS_ADMIN_PERM,
 		.dumpit = batadv_dat_cache_dump,
 	},
+	{
+		.cmd = BATADV_CMD_GET_DAT_DHT,
+		.flags = GENL_ADMIN_PERM,
+		.dumpit = batadv_dat_dht_dump,
+	},
 	{
 		.cmd = BATADV_CMD_GET_MCAST_FLAGS,
 		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
diff --git a/net/batman-adv/routing.c b/net/batman-adv/routing.c
index f1061985149f..b3195a225ccc 100644
--- a/net/batman-adv/routing.c
+++ b/net/batman-adv/routing.c
@@ -943,10 +943,10 @@ int batadv_recv_unicast_packet(struct sk_buff *skb,
 	struct batadv_unicast_4addr_packet *unicast_4addr_packet;
 	u8 *orig_addr, *orig_addr_gw;
 	struct batadv_orig_node *orig_node = NULL, *orig_node_gw = NULL;
+	bool is4addr, is_gw, is_dht_put = false;
 	int check, hdr_size = sizeof(*unicast_packet);
 	enum batadv_subtype subtype;
 	int ret = NET_RX_DROP;
-	bool is4addr, is_gw;
 
 	unicast_packet = (struct batadv_unicast_packet *)skb->data;
 	is4addr = unicast_packet->packet_type == BATADV_UNICAST_4ADDR;
@@ -1005,6 +1005,8 @@ int batadv_recv_unicast_packet(struct sk_buff *skb,
 				orig_addr = unicast_4addr_packet->src;
 				orig_node = batadv_orig_hash_find(bat_priv,
 								  orig_addr);
+			} else if (subtype == BATADV_P_DAT_DHT_PUT) {
+				is_dht_put = true;
 			}
 		}
 
@@ -1012,7 +1014,7 @@ int batadv_recv_unicast_packet(struct sk_buff *skb,
 							  hdr_size))
 			goto rx_success;
 		if (batadv_dat_snoop_incoming_arp_reply(bat_priv, skb,
-							hdr_size))
+							hdr_size, is_dht_put))
 			goto rx_success;
 
 		batadv_dat_snoop_incoming_dhcp_ack(bat_priv, skb, hdr_size);
@@ -1249,7 +1251,7 @@ int batadv_recv_bcast_packet(struct sk_buff *skb,
 
 	if (batadv_dat_snoop_incoming_arp_request(bat_priv, skb, hdr_size))
 		goto rx_success;
-	if (batadv_dat_snoop_incoming_arp_reply(bat_priv, skb, hdr_size))
+	if (batadv_dat_snoop_incoming_arp_reply(bat_priv, skb, hdr_size, false))
 		goto rx_success;
 
 	batadv_dat_snoop_incoming_dhcp_ack(bat_priv, skb, hdr_size);
diff --git a/net/batman-adv/types.h b/net/batman-adv/types.h
index f491bff8c51b..294302832ec7 100644
--- a/net/batman-adv/types.h
+++ b/net/batman-adv/types.h
@@ -1231,8 +1231,11 @@ struct batadv_priv_dat {
 	/** @addr: node DAT address */
 	batadv_dat_addr_t addr;
 
-	/** @hash: hashtable representing the local ARP cache */
-	struct batadv_hashtable *hash;
+	/** @cache_hash: hashtable representing the local ARP cache */
+	struct batadv_hashtable *cache_hash;
+
+	/** @dht_hash: hashtable representing the local DAT DHT */
+	struct batadv_hashtable *dht_hash;
 
 	/** @work: work queue callback item for cache purging */
 	struct delayed_work work;
-- 
2.45.2

