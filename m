Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52030C982D8
	for <batman-adv@archiver.kernel.org>; Fri, 18 Sep 2026 22:56:43 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 78E92843BC
	for <batman-adv@archiver.kernel.org>; Sat, 19 Sep 2026 00:56:41 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1789772201;
 b=eJPZfeQeBlEXNta5LOVI2JUEfLb7V0AAXdNZiQmji+5JAArsgclwqBpql4l81j17/DjO1
 n4eaTTL0Dqvd9wW5WCQ5L6bT+uJj6jmUYltQliRmfB7p4arEGkbVgU4C4jSxLa+SF68N3gR
 DBQd5LDeeIlpoZB5mh7RNvKKVxcj1yg=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1789772201; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=ko5SVObkYstLmFLfeV69A62Eptg/P6ouMp6G3OsS2lk=;
 b=dX9wr6Y4gJzHTcmVV0GBN+sNOLx7Yp87YfYWLQf7HrXsgB8YUrcggGvEPmxa37zhP0kYB
 uZm+MpllFhM6YTh7lQR6sQEmegEu0LW33bOR59RPwCLHwJhxoQ39YVhTNb9k3mWwA9WQJbK
 VXxkGSpraDXNw20ngrUnc1shtmI1kSY=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=fail;
 arc=pass;
 dmarc=none
Authentication-Results: open-mesh.org; dkim=fail; arc=pass; dmarc=none
Received: from mail.aperture-lab.de (mail.aperture-lab.de [116.203.183.178])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id D71EB814FA
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sat, 19 Sep 2026 00:56:00 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1789772161;
	b=0CoEaZz5zqQVt1NDAHzNFnAP5umS/mwzLNEpWYooyCsxN1015/rkXMKKGTKbrgzERj4n4f
	1x3N7c2BWVs9hDtE9lnpE4twktCjO0o5tFSiOSUhuJyz8DsC+n5mfA6Zxd7H2pGRGCiILL
	5Rzs+7FxhSqk5ZAnMZzFnOWyFfW5g+s=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1789772161;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ko5SVObkYstLmFLfeV69A62Eptg/P6ouMp6G3OsS2lk=;
	b=dWMhmRXuHEwvyivdq6QogsuW+b0xO5P1ieTagPUiQCpVgCP2WSUhGdUJxCcRxlF1OEJ/z5
	uAv1QI//Mq+T1P3SNBX9zp7GpHDS1hJDd1p678/y8ck1qAuukd01x2pGESjEQI+Toi4zcr
	1ZwbXbwyxeaGXUAEc9rKi9OXS55qfdo=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=none;
	dmarc=none;
	spf=pass (diktynna.open-mesh.org: domain of linus.luessing@c0d3.blue
 designates 116.203.183.178 as permitted sender)
 smtp.mailfrom=linus.luessing@c0d3.blue
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id E4846289AC;
	Sat, 19 Sep 2026 00:55:59 +0200 (CEST)
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@c0d3.blue>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@c0d3.blue>
Subject: [batadv,v10 1/2] batman-adv: split DAT cache into DAT cache and DAT
 DHT
Date: Sat, 19 Sep 2026 00:55:47 +0200
Message-ID: <20260918225549.31315-2-linus.luessing@c0d3.blue>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260918225549.31315-1-linus.luessing@c0d3.blue>
References: <20260918225549.31315-1-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
Message-ID-Hash: EVBZPYMGTGXUBZWNAQHJ4CQUQ6C255U5
X-Message-ID-Hash: EVBZPYMGTGXUBZWNAQHJ4CQUQ6C255U5
X-MailFrom: linus.luessing@c0d3.blue
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/EVBZPYMGTGXUBZWNAQHJ4CQUQ6C255U5/>
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
 net/batman-adv/distributed-arp-table.c | 319 +++++++++++++++++++------
 net/batman-adv/distributed-arp-table.h |  13 +-
 net/batman-adv/netlink.c               |   5 +
 net/batman-adv/routing.c               |   7 +-
 net/batman-adv/types.h                 |   7 +-
 6 files changed, 271 insertions(+), 85 deletions(-)

diff --git a/include/uapi/linux/batman_adv.h b/include/uapi/linux/batman_adv.h
index 936bcac270b5..7379c1509f77 100644
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
index a4be5b2a87d7..d2a599c9651d 100644
--- a/net/batman-adv/distributed-arp-table.c
+++ b/net/batman-adv/distributed-arp-table.c
@@ -211,17 +211,17 @@ static bool batadv_dat_to_purge(struct batadv_dat_entry *dat_entry)
 }
 
 /**
- * __batadv_dat_purge() - delete entries from the DAT local storage
- * @bat_priv: the bat priv with all the mesh interface information
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
@@ -230,12 +230,12 @@ static void __batadv_dat_purge(struct batadv_priv *bat_priv,
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
@@ -268,7 +268,8 @@ static void batadv_dat_purge(struct work_struct *work)
 	priv_dat = container_of(delayed_work, struct batadv_priv_dat, work);
 	bat_priv = container_of(priv_dat, struct batadv_priv, dat);
 
-	__batadv_dat_purge(bat_priv, batadv_dat_to_purge);
+	__batadv_dat_purge(bat_priv->dat.cache_hash, batadv_dat_to_purge);
+	__batadv_dat_purge(bat_priv->dat.dht_hash, batadv_dat_to_purge);
 	batadv_dat_start_timer(bat_priv);
 }
 
@@ -387,19 +388,17 @@ static u32 batadv_hash_dat(const void *data, u32 size)
 }
 
 /**
- * batadv_dat_entry_hash_find() - look for a given dat_entry in the local hash
- * table
- * @bat_priv: the bat priv with all the mesh interface information
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
-	struct batadv_hashtable *hash = bat_priv->dat.hash;
 	struct batadv_dat_entry *dat_entry_tmp = NULL;
 	struct batadv_dat_entry *dat_entry;
 	struct batadv_dat_entry to_find;
@@ -434,29 +433,64 @@ batadv_dat_entry_hash_find(struct batadv_priv *bat_priv, __be32 ip,
 	return dat_entry_tmp;
 }
 
+/**
+ * batadv_dat_cache_entry_find() - look for a given dat_entry in the DAT cache
+ * @bat_priv: the bat priv with all the mesh interface information
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
+ * @bat_priv: the bat priv with all the mesh interface information
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
  * @bat_priv: the bat priv with all the mesh interface information
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
 	u64 u64_mac = ether_addr_to_u64(mac_addr);
 	struct batadv_dat_entry *dat_entry;
 	int hash_added;
 
-	dat_entry = batadv_dat_entry_hash_find(bat_priv, ip, vid);
+	dat_entry = batadv_dat_entry_hash_find(hash, ip, vid);
 	/* if this entry is already known, just update it */
 	if (dat_entry) {
 		atomic64_set(&dat_entry->mac_addr, u64_mac);
 
 		dat_entry->last_update = jiffies;
 		batadv_dbg(BATADV_DBG_DAT, bat_priv,
-			   "Entry updated: %pI4 %pM (vid: %d)\n",
-			   &dat_entry->ip, mac_addr,
+			   "Entry updated in %s: %pI4 %pM (vid: %d)\n",
+			   tablename, &dat_entry->ip, mac_addr,
 			   batadv_print_vid(vid));
 		goto out;
 	}
@@ -472,7 +506,7 @@ static void batadv_dat_entry_add(struct batadv_priv *bat_priv, __be32 ip,
 	kref_init(&dat_entry->refcount);
 
 	kref_get(&dat_entry->refcount);
-	hash_added = batadv_hash_add(bat_priv->dat.hash, batadv_compare_dat,
+	hash_added = batadv_hash_add(hash, batadv_compare_dat,
 				     batadv_hash_dat, dat_entry,
 				     &dat_entry->hash_entry);
 
@@ -482,13 +516,44 @@ static void batadv_dat_entry_add(struct batadv_priv *bat_priv, __be32 ip,
 		goto out;
 	}
 
-	batadv_dbg(BATADV_DBG_DAT, bat_priv, "New entry added: %pI4 %pM (vid: %d)\n",
-		   &dat_entry->ip, mac_addr, batadv_print_vid(vid));
+	batadv_dbg(BATADV_DBG_DAT, bat_priv,
+		   "New entry added in %s: %pI4 %pM (vid: %d)\n",
+		   tablename, &dat_entry->ip, mac_addr, batadv_print_vid(vid));
 
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
+ * @bat_priv: the bat priv with all the mesh interface information
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
@@ -870,19 +935,57 @@ static void batadv_dat_tvlv_ogm_handler_v1(struct batadv_priv *bat_priv,
 }
 
 /**
- * batadv_dat_hash_free() - free the local DAT hash table
- * @bat_priv: the bat priv with all the mesh interface information
+ * batadv_dat_hash_free() - free a DAT hash table
+ * @hash: the hash table to free
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
+ * @bat_priv: the bat priv with all the mesh interface information
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
+ * @bat_priv: the bat priv with all the mesh interface information
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
@@ -893,13 +996,15 @@ static void batadv_dat_hash_free(struct batadv_priv *bat_priv)
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
@@ -922,23 +1027,25 @@ void batadv_dat_free(struct batadv_priv *bat_priv)
 
 	disable_delayed_work_sync(&bat_priv->dat.work);
 
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
 	u8 mac[ETH_ALEN] __aligned(2);
 	u64 u64_mac;
@@ -946,8 +1053,7 @@ batadv_dat_cache_dump_entry(struct sk_buff *msg, u32 portid,
 	void *hdr;
 
 	hdr = genlmsg_put(msg, portid, cb->nlh->nlmsg_seq,
-			  &batadv_netlink_family, NLM_F_MULTI,
-			  BATADV_CMD_GET_DAT_CACHE);
+			  &batadv_netlink_family, NLM_F_MULTI, cmd);
 	if (!hdr)
 		return -ENOBUFS;
 
@@ -971,22 +1077,23 @@ batadv_dat_cache_dump_entry(struct sk_buff *msg, u32 portid,
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
@@ -998,7 +1105,7 @@ batadv_dat_cache_dump_bucket(struct sk_buff *msg, u32 portid,
 		if (idx < *idx_skip)
 			goto skip;
 
-		if (batadv_dat_cache_dump_entry(msg, portid, cb, dat_entry)) {
+		if (batadv_dat_dump_entry(msg, portid, cb, dat_entry, cmd)) {
 			spin_unlock_bh(&hash->list_locks[bucket]);
 			*idx_skip = idx;
 
@@ -1014,30 +1121,26 @@ batadv_dat_cache_dump_bucket(struct sk_buff *msg, u32 portid,
 }
 
 /**
- * batadv_dat_cache_dump() - dump DAT cache table to a netlink socket
+ * batadv_dat_dump() - dump a DAT hash table to a netlink socket
+ * @bat_priv: the bat priv with all the mesh interface information
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
-	struct net_device *mesh_iface;
-	struct batadv_hashtable *hash;
-	struct batadv_priv *bat_priv;
+	struct batadv_hard_iface *primary_if;
 	int bucket = cb->args[0];
 	int idx = cb->args[1];
 	int ret = 0;
 
-	mesh_iface = batadv_netlink_get_meshif(cb);
-	if (IS_ERR(mesh_iface))
-		return PTR_ERR(mesh_iface);
-
-	bat_priv = netdev_priv(mesh_iface);
-	hash = bat_priv->dat.hash;
-
 	primary_if = batadv_primary_if_get_selected(bat_priv);
 	if (!primary_if || primary_if->if_status != BATADV_IF_ACTIVE) {
 		ret = -ENOENT;
@@ -1045,8 +1148,8 @@ int batadv_dat_cache_dump(struct sk_buff *msg, struct netlink_callback *cb)
 	}
 
 	while (bucket < hash->size) {
-		if (batadv_dat_cache_dump_bucket(msg, portid, cb, hash, bucket,
-						 &idx))
+		if (batadv_dat_dump_bucket(msg, portid, cb, hash, bucket, &idx,
+					   cmd))
 			break;
 
 		bucket++;
@@ -1061,8 +1164,58 @@ int batadv_dat_cache_dump(struct sk_buff *msg, struct netlink_callback *cb)
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
+	struct net_device *mesh_iface;
+	struct batadv_priv *bat_priv;
+	int ret;
+
+	mesh_iface = batadv_netlink_get_meshif(cb);
+	if (IS_ERR(mesh_iface))
+		return PTR_ERR(mesh_iface);
+
+	bat_priv = netdev_priv(mesh_iface);
+
+	ret = batadv_dat_dump(bat_priv, msg, cb, bat_priv->dat.cache_hash,
+			      BATADV_CMD_GET_DAT_CACHE);
+
 	dev_put(mesh_iface);
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
+	struct net_device *mesh_iface;
+	struct batadv_priv *bat_priv;
+	int ret;
+
+	mesh_iface = batadv_netlink_get_meshif(cb);
+	if (IS_ERR(mesh_iface))
+		return PTR_ERR(mesh_iface);
+
+	bat_priv = netdev_priv(mesh_iface);
+
+	ret = batadv_dat_dump(bat_priv, msg, cb, bat_priv->dat.dht_hash,
+			      BATADV_CMD_GET_DAT_DHT);
+
+	dev_put(mesh_iface);
 	return ret;
 }
 
@@ -1269,9 +1422,9 @@ bool batadv_dat_snoop_outgoing_arp_request(struct batadv_priv *bat_priv,
 	hw_src = batadv_arp_hw_src(skb, hdr_size);
 	ip_dst = batadv_arp_ip_dst(skb, hdr_size);
 
-	batadv_dat_entry_add(bat_priv, ip_src, hw_src, vid);
+	batadv_dat_cache_entry_add(bat_priv, ip_src, hw_src, vid);
 
-	dat_entry = batadv_dat_entry_hash_find(bat_priv, ip_dst, vid);
+	dat_entry = batadv_dat_cache_entry_find(bat_priv, ip_dst, vid);
 	if (dat_entry) {
 		u64_mac = atomic64_read(&dat_entry->mac_addr);
 		u64_to_ether_addr(u64_mac, mac);
@@ -1374,9 +1527,9 @@ bool batadv_dat_snoop_incoming_arp_request(struct batadv_priv *bat_priv,
 
 	batadv_dbg_arp(bat_priv, skb, hdr_size, "Parsing incoming ARP REQUEST");
 
-	batadv_dat_entry_add(bat_priv, ip_src, hw_src, vid);
+	batadv_dat_cache_entry_add(bat_priv, ip_src, hw_src, vid);
 
-	dat_entry = batadv_dat_entry_hash_find(bat_priv, ip_dst, vid);
+	dat_entry = batadv_dat_dht_entry_find(bat_priv, ip_dst, vid);
 	if (!dat_entry)
 		goto out;
 
@@ -1443,8 +1596,8 @@ void batadv_dat_snoop_outgoing_arp_reply(struct batadv_priv *bat_priv,
 	hw_dst = batadv_arp_hw_dst(skb, hdr_size);
 	ip_dst = batadv_arp_ip_dst(skb, hdr_size);
 
-	batadv_dat_entry_add(bat_priv, ip_src, hw_src, vid);
-	batadv_dat_entry_add(bat_priv, ip_dst, hw_dst, vid);
+	batadv_dat_cache_entry_add(bat_priv, ip_src, hw_src, vid);
+	batadv_dat_cache_entry_add(bat_priv, ip_dst, hw_dst, vid);
 
 	/* Send the ARP reply to the candidates for both the IP addresses that
 	 * the node obtained from the ARP reply
@@ -1461,6 +1614,8 @@ void batadv_dat_snoop_outgoing_arp_reply(struct batadv_priv *bat_priv,
  * @bat_priv: the bat priv with all the mesh interface information
  * @skb: packet to check
  * @hdr_size: size of the encapsulation header
+ * @is_dht_put: ARP reply is part of a unicast 4addr DHT PUT packet and should
+ *  not only update our local DAT cache but also our local DAT DHT
  *
  * Warning: This function may reallocate the skb data buffer via
  * batadv_dat_get_vid()/... Any pointer into the skb data (e.g. obtained
@@ -1471,7 +1626,8 @@ void batadv_dat_snoop_outgoing_arp_reply(struct batadv_priv *bat_priv,
  * packet has to be delivered to the interface
  */
 bool batadv_dat_snoop_incoming_arp_reply(struct batadv_priv *bat_priv,
-					 struct sk_buff *skb, int hdr_size)
+					 struct sk_buff *skb, int hdr_size,
+					 bool is_dht_put)
 {
 	struct batadv_dat_entry *dat_entry = NULL;
 	u8 mac[ETH_ALEN] __aligned(2);
@@ -1504,13 +1660,18 @@ bool batadv_dat_snoop_incoming_arp_reply(struct batadv_priv *bat_priv,
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
 	if (dat_entry) {
 		u64_mac = atomic64_read(&dat_entry->mac_addr);
 		u64_to_ether_addr(u64_mac, mac);
@@ -1527,8 +1688,8 @@ bool batadv_dat_snoop_incoming_arp_reply(struct batadv_priv *bat_priv,
 	/* Update our internal cache with both the IP addresses the node got
 	 * within the ARP reply
 	 */
-	batadv_dat_entry_add(bat_priv, ip_src, hw_src, vid);
-	batadv_dat_entry_add(bat_priv, ip_dst, hw_dst, vid);
+	batadv_dat_cache_entry_add(bat_priv, ip_src, hw_src, vid);
+	batadv_dat_cache_entry_add(bat_priv, ip_dst, hw_dst, vid);
 
 	if (dropped)
 		goto out;
@@ -1782,8 +1943,8 @@ static void batadv_dat_put_dhcp(struct batadv_priv *bat_priv, u8 *chaddr,
 
 	skb_set_network_header(skb, ETH_HLEN);
 
-	batadv_dat_entry_add(bat_priv, yiaddr, chaddr, vid);
-	batadv_dat_entry_add(bat_priv, ip_dst, hw_dst, vid);
+	batadv_dat_cache_entry_add(bat_priv, yiaddr, chaddr, vid);
+	batadv_dat_cache_entry_add(bat_priv, ip_dst, hw_dst, vid);
 
 	batadv_dat_forward_data(bat_priv, skb, yiaddr, vid,
 				BATADV_P_DAT_DHT_PUT);
@@ -1918,8 +2079,8 @@ void batadv_dat_snoop_incoming_dhcp_ack(struct batadv_priv *bat_priv,
 	ethhdr = (struct ethhdr *)(skb->data + hdr_size);
 	hw_src = ethhdr->h_source;
 
-	batadv_dat_entry_add(bat_priv, yiaddr, chaddr, vid);
-	batadv_dat_entry_add(bat_priv, ip_src, hw_src, vid);
+	batadv_dat_cache_entry_add(bat_priv, yiaddr, chaddr, vid);
+	batadv_dat_cache_entry_add(bat_priv, ip_src, hw_src, vid);
 
 	batadv_dbg(BATADV_DBG_DAT, bat_priv,
 		   "Snooped from incoming DHCPACK (server address): %pI4, %pM (vid: %i)\n",
@@ -1972,7 +2133,7 @@ bool batadv_dat_drop_broadcast_packet(struct batadv_priv *bat_priv,
 		goto out;
 
 	ip_dst = batadv_arp_ip_dst(forw_packet->skb, hdr_size);
-	dat_entry = batadv_dat_entry_hash_find(bat_priv, ip_dst, vid);
+	dat_entry = batadv_dat_cache_entry_find(bat_priv, ip_dst, vid);
 	/* check if the node already got this entry */
 	if (!dat_entry) {
 		batadv_dbg(BATADV_DBG_DAT, bat_priv,
diff --git a/net/batman-adv/distributed-arp-table.h b/net/batman-adv/distributed-arp-table.h
index e7b75e82eb1d..ad81b7db921e 100644
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
index 1177b3ceaf03..26584e0a2cc8 100644
--- a/net/batman-adv/netlink.c
+++ b/net/batman-adv/netlink.c
@@ -1498,6 +1498,11 @@ static const struct genl_small_ops batadv_netlink_ops[] = {
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
index 6442f5d0cc93..5cf26e8b3257 100644
--- a/net/batman-adv/routing.c
+++ b/net/batman-adv/routing.c
@@ -1046,6 +1046,7 @@ int batadv_recv_unicast_packet(struct sk_buff *skb,
 	struct batadv_orig_node *orig_node = NULL;
 	int hdr_size = sizeof(*unicast_packet);
 	enum batadv_subtype subtype;
+	bool is_dht_put = false;
 	int ret = NET_RX_DROP;
 	u8 *orig_addr_gw;
 	u8 *orig_addr;
@@ -1105,6 +1106,8 @@ int batadv_recv_unicast_packet(struct sk_buff *skb,
 				orig_addr = unicast_4addr_packet->src;
 				orig_node = batadv_orig_hash_find(bat_priv,
 								  orig_addr);
+			} else if (subtype == BATADV_P_DAT_DHT_PUT) {
+				is_dht_put = true;
 			}
 		}
 
@@ -1112,7 +1115,7 @@ int batadv_recv_unicast_packet(struct sk_buff *skb,
 							  hdr_size))
 			goto rx_success;
 		if (batadv_dat_snoop_incoming_arp_reply(bat_priv, skb,
-							hdr_size))
+							hdr_size, is_dht_put))
 			goto rx_success;
 
 		batadv_dat_snoop_incoming_dhcp_ack(bat_priv, skb, hdr_size);
@@ -1353,7 +1356,7 @@ int batadv_recv_bcast_packet(struct sk_buff *skb,
 
 	if (batadv_dat_snoop_incoming_arp_request(bat_priv, skb, hdr_size))
 		goto rx_success;
-	if (batadv_dat_snoop_incoming_arp_reply(bat_priv, skb, hdr_size))
+	if (batadv_dat_snoop_incoming_arp_reply(bat_priv, skb, hdr_size, false))
 		goto rx_success;
 
 	batadv_dat_snoop_incoming_dhcp_ack(bat_priv, skb, hdr_size);
diff --git a/net/batman-adv/types.h b/net/batman-adv/types.h
index c19caa84e692..045727c3adc0 100644
--- a/net/batman-adv/types.h
+++ b/net/batman-adv/types.h
@@ -1211,8 +1211,11 @@ struct batadv_priv_dat {
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
2.55.0

