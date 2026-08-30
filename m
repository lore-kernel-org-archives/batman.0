Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37373C61DE2
	for <batman-adv@archiver.kernel.org>; Sun, 30 Aug 2026 19:53:32 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 8D874804D3
	for <batman-adv@archiver.kernel.org>; Sun, 30 Aug 2026 21:53:30 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1788119610;
 b=n7cBy1vjBzXZBi8FYklsJhM0vdzriNQz7Fwxji+Jhshbw8hdIEwjZjMmdegNk9AEj9cDz
 OJPa58vVPGXy1N46KyjSAmKoBGaBxbP5GWAmaEjM1KjpgKmzprOSReuLWucr4V2ZTI3rb0d
 wziqCmg7jGycCRC5zLSIUSnvi6QcFzk=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1788119610; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=KtOoj7eNpLYxf3JcPKo0l7pxKh43SHvPcx3hINLERNU=;
 b=CUzfczcGs/IjipK8vSG0ZsQV8pF1FNq6hMOoPh7V1BZ4Idv8iD3yzq7WYCkTB3b23iyca
 uMIjE157pCxBfKcvFZW1AsEF2+sK/h8xmbc+NKLZcxHawQYtM/D0YI5h1dSOIa36Z059P/n
 wOrfPSyjvorMa+l2VGjkNBhvopOhh/4=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org
 [IPv6:2a00:17d8:100::8b1])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 916E180468
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sun, 30 Aug 2026 21:53:11 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1788119602;
	b=ZMmWaChie3IMOyJP3+04PeOarTf9n3yoc33xLS/EKkomUVJTwYmGHR+AcQz9PeetiKdc8T
	LczEHKiJK7xeg4l0hDc1si1EmU6jNX5ufqKQ2BtOjx/AKOHL9unZxjO06xHqA+bTeCw1YW
	kOKkjWrXmgVx+LMBFUz820Ck3UQBCSQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1788119602;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:dkim-signature;
	bh=KtOoj7eNpLYxf3JcPKo0l7pxKh43SHvPcx3hINLERNU=;
	b=Y1Kx/vrzeYptn2d3chMqsgzPliRDZLKDJa1VrIwu97BeRA5P06P7jjbptkdtlLkYZWkTMT
	kqDy5C+9fFl153zknZDBbZqA3m6xxF4DfFAXoUBia50/M8Zhs1bOv/dULU44aFSxnMPpNg
	x2EgucT9svmidFz4POOBF4iTHduQbeg=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b="X/2QlDf9";
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id 1B9FD2083E;
	Sun, 30 Aug 2026 19:53:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1788119586;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=KtOoj7eNpLYxf3JcPKo0l7pxKh43SHvPcx3hINLERNU=;
	b=X/2QlDf9pQn+siTV6imeACVdaGxIYHb5xEIvBz8B4mZr6mCcsFeGaWUPaHrkazABOLkwN7
	P+G9HbvQa+CLXb97aBDF8rSqkL0d/8t8eVZ18eVoWz+BQrStJe3Q78tpdbBNQXBqYE2+k9
	0SOLR1O1iCR8MEwkcfC4z4Wb9uS+zMQ=
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 30 Aug 2026 21:52:47 +0200
Subject: [PATCH] batman-adv: tt: reject VLAN/TT entries before reaching
 size limit
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260830-tt-size-check-v1-1-3753d8adc5f8@narfation.org>
X-B4-Tracking: v=1; b=H4sIAA6KlGoC/yXMQQ5EQBBA0atIrVXSSIS5ilhQXSgSI11NRMfd9
 YzlW/wfQNkJK3ySAI4PUfmuEVmaAE3dOjKKjYbc5KWpCoPeo8rFSBPTgmVfD5mtyHZ1AbHZHA9
 y/n9N+1r3fmbyvwnc9wN+Doz+cQAAAA==
X-Change-ID: 20260830-tt-size-check-6b9f1d8cda93
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=14039; i=sven@narfation.org;
 h=from:subject:message-id; bh=30uMCdAHzaB+SD3fTTBvKS1zcPPGx+9A+kST03828lw=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFlTuuQFzi1rm3X93+XmfW/cdnkXP50d0n8ur/7TzmjV0
 7fOLfB26ShlYRDjYpAVU2TZcyX//Gb2t/Kfp308CjOHlQlkCAMXpwBMREiQ4X/itGvNN3QZBOa+
 Dnp0zOtBcGato50qe1VtuH98ouvGd8IMfzhrLSVPGemFpZz7avzar9RqMgu/3jxfMyGxzVrdohK
 P+AA=
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: FFOI5J3TQKSKR2WA7E74F7MD3QQMEASS
X-Message-ID-Hash: FFOI5J3TQKSKR2WA7E74F7MD3QQMEASS
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/FFOI5J3TQKSKR2WA7E74F7MD3QQMEASS/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

The translation table is announcing its current state via the TT TVLV in
each OGM(2). If another originator detects a desync with its own copy of
this state information, it will request a full table sync. Each originator
must therefore be able to send a reply with its full table without hitting
the size limit of this response.

The translation table code already tries to limit the amount of local TT
entries. But the code itself fails to achieve this task because:

* the size check uses shared, unlocked information
* the size check isn't done for VLANs

When enough VLANs + TT entries are created in parallel, then the TT will
need more room then allowed for a full translation table reply. Other
originators will then send regularly requests for a table sync but never
get a reply.

To avoid this problem for new VLAN and local TT entries, each new entry
must reserve "room" before it is actually allocated. Only when enough
"room" is available, this reservation is granted. This makes it possible to
keep the reservation handling locked and therefore safe for multiple
parallel contexts.

For now, over-reservation caused by a reduction of the MTU is not taken
into account.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
https://www.open-mesh.org/issues/252
---
 net/batman-adv/main.c              |   1 +
 net/batman-adv/mesh-interface.c    |   8 ++
 net/batman-adv/translation-table.c | 194 +++++++++++++++++++++++++++++++------
 net/batman-adv/translation-table.h |   3 +
 net/batman-adv/types.h             |  19 ++++
 5 files changed, 194 insertions(+), 31 deletions(-)

diff --git a/net/batman-adv/main.c b/net/batman-adv/main.c
index d89d44706269b..6c54a8d4be3ec 100644
--- a/net/batman-adv/main.c
+++ b/net/batman-adv/main.c
@@ -198,6 +198,7 @@ int batadv_mesh_init(struct net_device *mesh_iface)
 	spin_lock_init(&bat_priv->tt.roam_list_lock);
 	spin_lock_init(&bat_priv->tt.last_changeset_lock);
 	spin_lock_init(&bat_priv->tt.commit_lock);
+	spin_lock_init(&bat_priv->tt.reserve_lock);
 	spin_lock_init(&bat_priv->gw.list_lock);
 #ifdef CONFIG_BATMAN_ADV_MCAST
 	spin_lock_init(&bat_priv->mcast.mla_lock);
diff --git a/net/batman-adv/mesh-interface.c b/net/batman-adv/mesh-interface.c
index 63af21954cf90..1ce707aaf48a0 100644
--- a/net/batman-adv/mesh-interface.c
+++ b/net/batman-adv/mesh-interface.c
@@ -561,6 +561,8 @@ void batadv_meshif_vlan_release(struct kref *ref)
 	hlist_del_rcu(&vlan->list);
 	spin_unlock_bh(&vlan->bat_priv->meshif_vlan_list_lock);
 
+	batadv_tt_local_unreserve_vlan(vlan->bat_priv);
+
 	kfree_rcu(vlan, rcu);
 }
 
@@ -614,9 +616,15 @@ int batadv_meshif_create_vlan(struct batadv_priv *bat_priv, unsigned short vid)
 		return -EEXIST;
 	}
 
+	if (!batadv_tt_local_reserve_vlan(bat_priv, vid)) {
+		spin_unlock_bh(&bat_priv->meshif_vlan_list_lock);
+		return -EMSGSIZE;
+	}
+
 	vlan = kzalloc_obj(*vlan, GFP_ATOMIC);
 	if (!vlan) {
 		spin_unlock_bh(&bat_priv->meshif_vlan_list_lock);
+		batadv_tt_local_unreserve_vlan(bat_priv);
 		return -ENOMEM;
 	}
 
diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index 6c65d195f3756..00ce5f83e50b3 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -234,6 +234,162 @@ batadv_tt_global_hash_find(struct batadv_priv *bat_priv, const u8 *addr,
 	return tt_global_entry;
 }
 
+/**
+ * batadv_tt_len() - compute length in bytes of given number of tt changes
+ * @changes_num: number of tt changes
+ *
+ * Return: computed length in bytes.
+ */
+static int batadv_tt_len(int changes_num)
+{
+	return changes_num * sizeof(struct batadv_tvlv_tt_change);
+}
+
+/**
+ * batadv_tt_local_transmit_size() - calculate the size of a full table response
+ *  for a given number of VLANs and local TT entries
+ * @num_vlan: number of announced VLANs
+ * @num_entries: number of announced local TT entries
+ *
+ * Return: local translation table size in bytes.
+ */
+static int batadv_tt_local_transmit_size(u16 num_vlan, u16 num_entries)
+{
+	int hdr_size;
+
+	/* header size of tvlv encapsulated tt response payload */
+	hdr_size = sizeof(struct batadv_unicast_tvlv_packet);
+	hdr_size += sizeof(struct batadv_tvlv_hdr);
+	hdr_size += sizeof(struct batadv_tvlv_tt_data);
+	hdr_size += num_vlan * sizeof(struct batadv_tvlv_tt_vlan_data);
+
+	return hdr_size + batadv_tt_len(num_entries);
+}
+
+/**
+ * batadv_tt_local_reserve() - reserve room in the transmittable local table
+ * @bat_priv: the bat priv with all the mesh interface information
+ * @num_vlan: number of VLANs to reserve
+ * @num_entries: number of local TT entries to reserve
+ * @table_size: stores the resulting worst case table size in bytes
+ *
+ * Add the requested number of VLANs and local TT entries to the reservation
+ * counters and check whether the local translation table would then still fit
+ * in a single full table response. The reservation is dropped again when it
+ * would not.
+ *
+ * The reservation has to happen before the related object is allocated. This
+ * way two parallel allocations cannot both observe enough room for themselves
+ * and end up with a local table which can no longer be transmitted.
+ *
+ * A granted reservation must be returned via batadv_tt_local_unreserve() when
+ * the related object is released or was never created.
+ *
+ * Return: true when the reservation was granted, false otherwise.
+ */
+static bool batadv_tt_local_reserve(struct batadv_priv *bat_priv, u16 num_vlan,
+				    u16 num_entries, int *table_size)
+{
+	int packet_size_max = READ_ONCE(bat_priv->packet_size_max);
+
+	scoped_guard(spinlock_bh, &bat_priv->tt.reserve_lock) {
+		bat_priv->tt.reserved_vlans += num_vlan;
+		bat_priv->tt.reserved_entries += num_entries;
+
+		*table_size = batadv_tt_local_transmit_size(bat_priv->tt.reserved_vlans,
+							    bat_priv->tt.reserved_entries);
+		if (*table_size <= packet_size_max)
+			return true;
+
+		bat_priv->tt.reserved_vlans -= num_vlan;
+		bat_priv->tt.reserved_entries -= num_entries;
+	}
+
+	return false;
+}
+
+/**
+ * batadv_tt_local_unreserve() - return room in the transmittable local table
+ * @bat_priv: the bat priv with all the mesh interface information
+ * @num_vlan: number of VLANs to return
+ * @num_entries: number of local TT entries to return
+ */
+static void batadv_tt_local_unreserve(struct batadv_priv *bat_priv,
+				      u16 num_vlan, u16 num_entries)
+{
+	scoped_guard(spinlock_bh, &bat_priv->tt.reserve_lock) {
+		bat_priv->tt.reserved_vlans -= num_vlan;
+		bat_priv->tt.reserved_entries -= num_entries;
+	}
+}
+
+/**
+ * batadv_tt_local_reserve_entry() - reserve room for a new local TT entry
+ * @bat_priv: the bat priv with all the mesh interface information
+ * @addr: the mac address of the client to add
+ *
+ * Return: true when the reservation was granted, false otherwise.
+ */
+static bool batadv_tt_local_reserve_entry(struct batadv_priv *bat_priv,
+					  const u8 *addr)
+{
+	int table_size;
+
+	if (batadv_tt_local_reserve(bat_priv, 0, 1, &table_size))
+		return true;
+
+	net_ratelimited_function(batadv_info, bat_priv->mesh_iface,
+				 "Local translation table size (%i) exceeds maximum packet size (%i); Ignoring new local tt entry: %pM\n",
+				 table_size,
+				 READ_ONCE(bat_priv->packet_size_max), addr);
+
+	return false;
+}
+
+/**
+ * batadv_tt_local_unreserve_entry() - return the room of a local TT entry
+ * @bat_priv: the bat priv with all the mesh interface information
+ */
+static void batadv_tt_local_unreserve_entry(struct batadv_priv *bat_priv)
+{
+	batadv_tt_local_unreserve(bat_priv, 0, 1);
+}
+
+/**
+ * batadv_tt_local_reserve_vlan() - reserve room for a new VLAN
+ * @bat_priv: the bat priv with all the mesh interface information
+ * @vid: the VLAN identifier
+ *
+ * Each VLAN adds a per VLAN header to the full table response and therefore
+ * has to be reserved before batadv_meshif_create_vlan() allocates it.
+ *
+ * Return: true when the reservation was granted, false otherwise.
+ */
+bool batadv_tt_local_reserve_vlan(struct batadv_priv *bat_priv,
+				  unsigned short vid)
+{
+	int table_size;
+
+	if (batadv_tt_local_reserve(bat_priv, 1, 0, &table_size))
+		return true;
+
+	net_ratelimited_function(batadv_info, bat_priv->mesh_iface,
+				 "Local translation table size (%i) exceeds maximum packet size (%i); Ignoring new VLAN: %d\n",
+				 table_size, READ_ONCE(bat_priv->packet_size_max),
+				 batadv_print_vid(vid));
+
+	return false;
+}
+
+/**
+ * batadv_tt_local_unreserve_vlan() - return the room of a VLAN
+ * @bat_priv: the bat priv with all the mesh interface information
+ */
+void batadv_tt_local_unreserve_vlan(struct batadv_priv *bat_priv)
+{
+	batadv_tt_local_unreserve(bat_priv, 1, 0);
+}
+
 /**
  * batadv_tt_local_entry_release() - release tt_local_entry from lists and queue
  *  for free after rcu grace period
@@ -246,6 +402,7 @@ static void batadv_tt_local_entry_release(struct kref *ref)
 	tt_local_entry = container_of(ref, struct batadv_tt_local_entry,
 				      common.refcount);
 
+	batadv_tt_local_unreserve_entry(tt_local_entry->vlan->bat_priv);
 	batadv_meshif_vlan_put(tt_local_entry->vlan);
 
 	kfree_rcu(tt_local_entry, common.rcu);
@@ -537,17 +694,6 @@ static void batadv_tt_local_event(struct batadv_priv *bat_priv,
 	spin_unlock_bh(&bat_priv->tt.changes_list_lock);
 }
 
-/**
- * batadv_tt_len() - compute length in bytes of given number of tt changes
- * @changes_num: number of tt changes
- *
- * Return: computed length in bytes.
- */
-static int batadv_tt_len(int changes_num)
-{
-	return changes_num * sizeof(struct batadv_tvlv_tt_change);
-}
-
 /**
  * batadv_tt_entries() - compute the number of entries fitting in tt_len bytes
  * @tt_len: available space
@@ -571,7 +717,6 @@ static int batadv_tt_local_table_transmit_size(struct batadv_priv *bat_priv)
 	struct batadv_meshif_vlan *vlan;
 	u16 tt_local_entries = 0;
 	u16 num_vlan = 0;
-	int hdr_size;
 
 	rcu_read_lock();
 	hlist_for_each_entry_rcu(vlan, &bat_priv->meshif_vlan_list, list) {
@@ -580,13 +725,7 @@ static int batadv_tt_local_table_transmit_size(struct batadv_priv *bat_priv)
 	}
 	rcu_read_unlock();
 
-	/* header size of tvlv encapsulated tt response payload */
-	hdr_size = sizeof(struct batadv_unicast_tvlv_packet);
-	hdr_size += sizeof(struct batadv_tvlv_hdr);
-	hdr_size += sizeof(struct batadv_tvlv_tt_data);
-	hdr_size += num_vlan * sizeof(struct batadv_tvlv_tt_vlan_data);
-
-	return hdr_size + batadv_tt_len(tt_local_entries);
+	return batadv_tt_local_transmit_size(num_vlan, tt_local_entries);
 }
 
 /**
@@ -790,23 +929,15 @@ batadv_tt_local_create(struct net_device *mesh_iface, const u8 *addr,
 	struct batadv_priv *bat_priv = netdev_priv(mesh_iface);
 	struct batadv_tt_local_entry *tt_local;
 	struct batadv_meshif_vlan *vlan;
-	int packet_size_max;
-	int table_size;
 
-	/* Ignore the client if we cannot send it in a full table response. */
-	table_size = batadv_tt_local_table_transmit_size(bat_priv);
-	table_size += batadv_tt_len(1);
-	packet_size_max = READ_ONCE(bat_priv->packet_size_max);
-	if (table_size > packet_size_max) {
-		net_ratelimited_function(batadv_info, mesh_iface,
-					 "Local translation table size (%i) exceeds maximum packet size (%i); Ignoring new local tt entry: %pM\n",
-					 table_size, packet_size_max, addr);
+	if (!batadv_tt_local_reserve_entry(bat_priv, addr))
 		return NULL;
-	}
 
 	tt_local = kmem_cache_alloc(batadv_tl_cache, GFP_ATOMIC);
-	if (!tt_local)
+	if (!tt_local) {
+		batadv_tt_local_unreserve_entry(bat_priv);
 		return NULL;
+	}
 
 	/* increase the refcounter of the related vlan */
 	vlan = batadv_meshif_vlan_get(bat_priv, vid);
@@ -815,6 +946,7 @@ batadv_tt_local_create(struct net_device *mesh_iface, const u8 *addr,
 					 "adding TT local entry %pM to non-existent VLAN %d\n",
 					 addr, batadv_print_vid(vid));
 		kmem_cache_free(batadv_tl_cache, tt_local);
+		batadv_tt_local_unreserve_entry(bat_priv);
 		return NULL;
 	}
 
diff --git a/net/batman-adv/translation-table.h b/net/batman-adv/translation-table.h
index 618d9dbca5eac..ca01d20ee2d7f 100644
--- a/net/batman-adv/translation-table.h
+++ b/net/batman-adv/translation-table.h
@@ -16,6 +16,9 @@
 #include <linux/types.h>
 
 int batadv_tt_init(struct batadv_priv *bat_priv);
+bool batadv_tt_local_reserve_vlan(struct batadv_priv *bat_priv,
+				  unsigned short vid);
+void batadv_tt_local_unreserve_vlan(struct batadv_priv *bat_priv);
 bool batadv_tt_local_add(struct net_device *mesh_iface, const u8 *addr,
 			 unsigned short vid, int ifindex, u32 mark);
 u16 batadv_tt_local_remove(struct batadv_priv *bat_priv,
diff --git a/net/batman-adv/types.h b/net/batman-adv/types.h
index 67872927cfb50..c19caa84e6920 100644
--- a/net/batman-adv/types.h
+++ b/net/batman-adv/types.h
@@ -1055,6 +1055,25 @@ struct batadv_priv_tt {
 	 */
 	spinlock_t commit_lock;
 
+	/**
+	 * @reserved_entries: number of local TT entries which are currently
+	 *  allocated or about to be allocated. Together with @reserved_vlans it
+	 *  describes the worst case size of a full table response.
+	 */
+	u16 reserved_entries;
+
+	/**
+	 * @reserved_vlans: number of mesh interface VLANs which are currently
+	 *  allocated or about to be allocated. Together with @reserved_entries
+	 *  it describes the worst case size of a full table response.
+	 */
+	u16 reserved_vlans;
+
+	/**
+	 * @reserve_lock: lock protecting @reserved_entries & @reserved_vlans
+	 */
+	spinlock_t reserve_lock;
+
 	/** @work: work queue callback item for translation table purging */
 	struct delayed_work work;
 };

---
base-commit: 926013fd40f6822ada063df8f82025d3a4a47e5a
change-id: 20260830-tt-size-check-6b9f1d8cda93

Best regards,
--  
Sven Eckelmann <sven@narfation.org>

