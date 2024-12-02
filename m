Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0E71D4979F
	for <batman@archiver.kernel.org>; Mon,  2 Dec 2024 05:36:29 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 4445383FFA
	for <batman@archiver.kernel.org>; Mon,  2 Dec 2024 06:36:28 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1733117788;
 b=lQLxY1oOSPuD4hRDk9UyYQbontbUfsS+5FeKLRi1k9VdfmCb77puUTUdZaXXQMbMWPfbc
 MAKZcPWfBXvoruTaC6woYoHBd+Pdu9AF/hrZ3eDGX9XVQerJXn8MbR1qreO6QkfvaiNiAlJ
 PDSCGjAKEOukAjDKOl3cmy5s3Ga1YgM=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1733117788; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=Szo7j6ve60HY69L2OFyyh4q05Vilnpi9VoRV2utSXfA=;
 b=ahJp6L7+ysIoX6IxAkAY5M8JzGSX8Y56ZWaBdsUwymoPwX/s4d2QzCP4HWY+kYBqAG3S9
 WuZgulgiktnfPGXm2TvXa2a4jHt0lYVrSBWa3I7kOLEkynKP4U94aDVITtyXvm9bFQDnRDl
 pER5nmMYjOpmn2KtVYK9abftyI1+TwI=
ARC-Authentication-Results: i=2; open-mesh.org; dkim=fail;
  arc=pass;
  dmarc=none
Authentication-Results: open-mesh.org; dkim=fail; arc=pass; dmarc=none
Received: from mail.aperture-lab.de (mail.aperture-lab.de [116.203.183.178])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 6E7C781D4E
	for <b.a.t.m.a.n@lists.open-mesh.org>; Mon,  2 Dec 2024 06:35:22 +0100 (CET)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1733117722;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Szo7j6ve60HY69L2OFyyh4q05Vilnpi9VoRV2utSXfA=;
	b=znnPVCfjsVMDuNS3fd4Lt3d05JBi8YZ4x7ebZub9K5DYvgF0sKI+ne/j5vqgWfCw7eZsia
	vIq8XIZUTDj+TgE/0RLgSIzvyoxr1OPJIlxHXaeLXaBbzmm/muuR4AVHKbVec3qervapFp
	oOBId0ICGaxerQYWa3LOhz5ZQT9nVm4=
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1733117722; a=rsa-sha256;
	cv=none;
	b=C5M3RcqXGpIPdq3mF8y9X0FRbtH91XJp9Lr9UlpMBCeasYm28xU6kYWoPFSVC2gKqdYTLk
	h8DeU1bsCVDCFywXi7EHW0J56I1fyVNN+A9BLNzeH3kGGdshE8ITjotyH/UdWwHcFk8Cv8
	ALLhdoaEoIhXIHOXX7vB1wkHvgy28/I=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=none;
	spf=pass (diktynna.open-mesh.org: domain of linus.luessing@c0d3.blue
 designates 116.203.183.178 as permitted sender)
 smtp.mailfrom=linus.luessing@c0d3.blue;
	dmarc=none
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id CC0E454C76E;
	Mon,  2 Dec 2024 06:35:20 +0100 (CET)
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@c0d3.blue>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@c0d3.blue>
Subject: [PATCH v3 1/3] batman-adv: add dynamic,
 bridged-in TT VID detection support
Date: Mon,  2 Dec 2024 06:05:20 +0100
Message-ID: <20241202053511.326-2-linus.luessing@c0d3.blue>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241202053511.326-1-linus.luessing@c0d3.blue>
References: <20241202053511.326-1-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
Message-ID-Hash: 7Z2ST3BU5PQVPHBCS75Y6DWIN2J7VB6J
X-Message-ID-Hash: 7Z2ST3BU5PQVPHBCS75Y6DWIN2J7VB6J
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/7Z2ST3BU5PQVPHBCS75Y6DWIN2J7VB6J/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

So far, if we wanted to bridge VLAN tagged frames into the mesh one would
need to manually create an according VLAN interface on top of bat0
first, to trigger batman-adv to create the according structures
for a VID.

With this change the VLAN from bridged-in clients is now automatically
detected and added to the translation table on the fly.

Signed-off-by: Linus Lüssing <linus.luessing@c0d3.blue>
---
 net/batman-adv/hard-interface.c    |   2 +-
 net/batman-adv/multicast.c         |   8 +-
 net/batman-adv/soft-interface.c    | 125 ++++++++++++++++-------------
 net/batman-adv/soft-interface.h    |   6 +-
 net/batman-adv/translation-table.c |  19 ++---
 net/batman-adv/translation-table.h |   4 +-
 6 files changed, 91 insertions(+), 73 deletions(-)

diff --git a/net/batman-adv/hard-interface.c b/net/batman-adv/hard-interface.c
index 96a412beab2d..f5826dd8752c 100644
--- a/net/batman-adv/hard-interface.c
+++ b/net/batman-adv/hard-interface.c
@@ -946,7 +946,7 @@ static int batadv_hard_if_event_softif(unsigned long event,
 	switch (event) {
 	case NETDEV_REGISTER:
 		bat_priv = netdev_priv(net_dev);
-		batadv_softif_create_vlan(bat_priv, BATADV_NO_FLAGS);
+		batadv_softif_create_vlan_own(bat_priv, BATADV_NO_FLAGS);
 		break;
 	}
 
diff --git a/net/batman-adv/multicast.c b/net/batman-adv/multicast.c
index 38fab5e46ae2..61e765352e29 100644
--- a/net/batman-adv/multicast.c
+++ b/net/batman-adv/multicast.c
@@ -724,6 +724,7 @@ static void batadv_mcast_mla_tt_add(struct batadv_priv *bat_priv,
 {
 	struct batadv_hw_addr *mcast_entry;
 	struct hlist_node *tmp;
+	int ret;
 
 	if (!mcast_list)
 		return;
@@ -733,9 +734,10 @@ static void batadv_mcast_mla_tt_add(struct batadv_priv *bat_priv,
 						  &bat_priv->mcast.mla_list))
 			continue;
 
-		if (!batadv_tt_local_add(bat_priv->soft_iface,
-					 mcast_entry->addr, BATADV_NO_FLAGS,
-					 BATADV_NULL_IFINDEX, BATADV_NO_MARK))
+		ret = batadv_tt_local_add(bat_priv->soft_iface,
+					  mcast_entry->addr, BATADV_NO_FLAGS,
+					  BATADV_NULL_IFINDEX, BATADV_NO_MARK);
+		if (ret <= 0)
 			continue;
 
 		hlist_del(&mcast_entry->list);
diff --git a/net/batman-adv/soft-interface.c b/net/batman-adv/soft-interface.c
index 610bbaaabf0d..d3a3b735ac32 100644
--- a/net/batman-adv/soft-interface.c
+++ b/net/batman-adv/soft-interface.c
@@ -141,6 +141,10 @@ static int batadv_interface_set_mac_addr(struct net_device *dev, void *p)
 
 	rcu_read_lock();
 	hlist_for_each_entry_rcu(vlan, &bat_priv->softif_vlan_list, list) {
+		/* we don't use this VID ourself, avoid adding us to it */
+		if (!batadv_is_my_client(bat_priv, old_addr, vlan->vid))
+			continue;
+
 		batadv_tt_local_remove(bat_priv, old_addr, vlan->vid,
 				       "mac address changed", false);
 		batadv_tt_local_add(dev, addr->sa_data, vlan->vid,
@@ -549,13 +553,15 @@ struct batadv_softif_vlan *batadv_softif_vlan_get(struct batadv_priv *bat_priv,
 }
 
 /**
- * batadv_softif_create_vlan() - allocate the needed resources for a new vlan
+ * batadv_softif_create_vlan() - create a softif vlan struct
  * @bat_priv: the bat priv with all the soft interface information
  * @vid: the VLAN identifier
  *
- * Return: 0 on success, a negative error otherwise.
+ * Return: a pointer to the newly allocated softif vlan struct on success, NULL
+ * otherwise.
  */
-int batadv_softif_create_vlan(struct batadv_priv *bat_priv, unsigned short vid)
+static struct batadv_softif_vlan *
+batadv_softif_create_vlan(struct batadv_priv *bat_priv, unsigned short vid)
 {
 	struct batadv_softif_vlan *vlan;
 
@@ -563,55 +569,93 @@ int batadv_softif_create_vlan(struct batadv_priv *bat_priv, unsigned short vid)
 
 	vlan = batadv_softif_vlan_get(bat_priv, vid);
 	if (vlan) {
-		batadv_softif_vlan_put(vlan);
 		spin_unlock_bh(&bat_priv->softif_vlan_list_lock);
-		return -EEXIST;
+		return vlan;
 	}
 
 	vlan = kzalloc(sizeof(*vlan), GFP_ATOMIC);
 	if (!vlan) {
 		spin_unlock_bh(&bat_priv->softif_vlan_list_lock);
-		return -ENOMEM;
+		return NULL;
 	}
 
 	vlan->bat_priv = bat_priv;
 	vlan->vid = vid;
+	/* hold only one refcount, caller will store a reference to us in
+	 * tt_local->vlan without releasing any refcount
+	 */
 	kref_init(&vlan->refcount);
 
 	atomic_set(&vlan->ap_isolation, 0);
 
-	kref_get(&vlan->refcount);
 	hlist_add_head_rcu(&vlan->list, &bat_priv->softif_vlan_list);
 	spin_unlock_bh(&bat_priv->softif_vlan_list_lock);
 
+	return vlan;
+}
+
+/**
+ * batadv_softif_vlan_get_or_create() - retrieve or create a softif vlan struct
+ * @bat_priv: the bat priv with all the soft interface information
+ * @vid: the VLAN identifier
+ *
+ * Return: the softif vlan struct if found or created or NULL otherwise.
+ */
+struct batadv_softif_vlan *
+batadv_softif_vlan_get_or_create(struct batadv_priv *bat_priv,
+				 unsigned short vid)
+{
+	struct batadv_softif_vlan *vlan = batadv_softif_vlan_get(bat_priv, vid);
+
+	if (vlan)
+		return vlan;
+
+	return batadv_softif_create_vlan(bat_priv, vid);
+}
+
+/**
+ * batadv_softif_create_vlan_own() - add our own softif to the local TT
+ * @bat_priv: the bat priv with all the soft interface information
+ * @vid: the VLAN identifier
+ *
+ * Adds the MAC address of our own soft interface with the given VLAN ID as
+ * a permanent local TT entry.
+ *
+ * Return: 0 on success, a negative error otherwise.
+ */
+int batadv_softif_create_vlan_own(struct batadv_priv *bat_priv,
+				  unsigned short vid)
+{
+	int ret;
+
 	/* add a new TT local entry. This one will be marked with the NOPURGE
 	 * flag
 	 */
-	batadv_tt_local_add(bat_priv->soft_iface,
-			    bat_priv->soft_iface->dev_addr, vid,
-			    BATADV_NULL_IFINDEX, BATADV_NO_MARK);
-
-	/* don't return reference to new softif_vlan */
-	batadv_softif_vlan_put(vlan);
+	ret = batadv_tt_local_add(bat_priv->soft_iface,
+				  bat_priv->soft_iface->dev_addr, vid,
+				  BATADV_NULL_IFINDEX, BATADV_NO_MARK);
+	if (ret < 0)
+		return ret;
 
 	return 0;
 }
 
 /**
- * batadv_softif_destroy_vlan() - remove and destroy a softif_vlan object
+ * batadv_softif_destroy_vlan_own() - remove our own softif from the local TT
  * @bat_priv: the bat priv with all the soft interface information
- * @vlan: the object to remove
+ * @vid: the VLAN identifier
+ *
+ * Removes the MAC address of our own soft interface with the given VLAN ID from
+ * the local TT.
  */
-static void batadv_softif_destroy_vlan(struct batadv_priv *bat_priv,
-				       struct batadv_softif_vlan *vlan)
+static void batadv_softif_destroy_vlan_own(struct batadv_priv *bat_priv,
+					   unsigned short vid)
 {
 	/* explicitly remove the associated TT local entry because it is marked
 	 * with the NOPURGE flag
 	 */
-	batadv_tt_local_remove(bat_priv, bat_priv->soft_iface->dev_addr,
-			       vlan->vid, "vlan interface destroyed", false);
-
-	batadv_softif_vlan_put(vlan);
+	batadv_tt_local_remove(bat_priv, bat_priv->soft_iface->dev_addr, vid,
+			       "vlan interface destroyed", false);
 }
 
 /**
@@ -629,7 +673,6 @@ static int batadv_interface_add_vid(struct net_device *dev, __be16 proto,
 				    unsigned short vid)
 {
 	struct batadv_priv *bat_priv = netdev_priv(dev);
-	struct batadv_softif_vlan *vlan;
 
 	/* only 802.1Q vlans are supported.
 	 * batman-adv does not know how to handle other types
@@ -639,25 +682,7 @@ static int batadv_interface_add_vid(struct net_device *dev, __be16 proto,
 
 	vid |= BATADV_VLAN_HAS_TAG;
 
-	/* if a new vlan is getting created and it already exists, it means that
-	 * it was not deleted yet. batadv_softif_vlan_get() increases the
-	 * refcount in order to revive the object.
-	 *
-	 * if it does not exist then create it.
-	 */
-	vlan = batadv_softif_vlan_get(bat_priv, vid);
-	if (!vlan)
-		return batadv_softif_create_vlan(bat_priv, vid);
-
-	/* add a new TT local entry. This one will be marked with the NOPURGE
-	 * flag. This must be added again, even if the vlan object already
-	 * exists, because the entry was deleted by kill_vid()
-	 */
-	batadv_tt_local_add(bat_priv->soft_iface,
-			    bat_priv->soft_iface->dev_addr, vid,
-			    BATADV_NULL_IFINDEX, BATADV_NO_MARK);
-
-	return 0;
+	return batadv_softif_create_vlan_own(bat_priv, vid);
 }
 
 /**
@@ -676,7 +701,6 @@ static int batadv_interface_kill_vid(struct net_device *dev, __be16 proto,
 				     unsigned short vid)
 {
 	struct batadv_priv *bat_priv = netdev_priv(dev);
-	struct batadv_softif_vlan *vlan;
 
 	/* only 802.1Q vlans are supported. batman-adv does not know how to
 	 * handle other types
@@ -684,15 +708,7 @@ static int batadv_interface_kill_vid(struct net_device *dev, __be16 proto,
 	if (proto != htons(ETH_P_8021Q))
 		return -EINVAL;
 
-	vlan = batadv_softif_vlan_get(bat_priv, vid | BATADV_VLAN_HAS_TAG);
-	if (!vlan)
-		return -ENOENT;
-
-	batadv_softif_destroy_vlan(bat_priv, vlan);
-
-	/* finally free the vlan object */
-	batadv_softif_vlan_put(vlan);
-
+	batadv_softif_destroy_vlan_own(bat_priv, vid | BATADV_VLAN_HAS_TAG);
 	return 0;
 }
 
@@ -1104,7 +1120,6 @@ static void batadv_softif_destroy_netlink(struct net_device *soft_iface,
 {
 	struct batadv_priv *bat_priv = netdev_priv(soft_iface);
 	struct batadv_hard_iface *hard_iface;
-	struct batadv_softif_vlan *vlan;
 
 	list_for_each_entry(hard_iface, &batadv_hardif_list, list) {
 		if (hard_iface->soft_iface == soft_iface)
@@ -1112,11 +1127,7 @@ static void batadv_softif_destroy_netlink(struct net_device *soft_iface,
 	}
 
 	/* destroy the "untagged" VLAN */
-	vlan = batadv_softif_vlan_get(bat_priv, BATADV_NO_FLAGS);
-	if (vlan) {
-		batadv_softif_destroy_vlan(bat_priv, vlan);
-		batadv_softif_vlan_put(vlan);
-	}
+	batadv_softif_destroy_vlan_own(bat_priv, BATADV_NO_FLAGS);
 
 	unregister_netdevice_queue(soft_iface, head);
 }
diff --git a/net/batman-adv/soft-interface.h b/net/batman-adv/soft-interface.h
index 9f2003f1a497..7050ccd304df 100644
--- a/net/batman-adv/soft-interface.h
+++ b/net/batman-adv/soft-interface.h
@@ -21,10 +21,14 @@ void batadv_interface_rx(struct net_device *soft_iface,
 			 struct batadv_orig_node *orig_node);
 bool batadv_softif_is_valid(const struct net_device *net_dev);
 extern struct rtnl_link_ops batadv_link_ops;
-int batadv_softif_create_vlan(struct batadv_priv *bat_priv, unsigned short vid);
+int batadv_softif_create_vlan_own(struct batadv_priv *bat_priv,
+				  unsigned short vid);
 void batadv_softif_vlan_release(struct kref *ref);
 struct batadv_softif_vlan *batadv_softif_vlan_get(struct batadv_priv *bat_priv,
 						  unsigned short vid);
+struct batadv_softif_vlan *
+batadv_softif_vlan_get_or_create(struct batadv_priv *bat_priv,
+				 unsigned short vid);
 
 /**
  * batadv_softif_vlan_put() - decrease the vlan object refcounter and
diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index bc122c4de73d..7b31ecf7cdf1 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -632,8 +632,8 @@ static void batadv_tt_global_free(struct batadv_priv *bat_priv,
  *
  * Return: true if the client was successfully added, false otherwise.
  */
-bool batadv_tt_local_add(struct net_device *soft_iface, const u8 *addr,
-			 unsigned short vid, int ifindex, u32 mark)
+int batadv_tt_local_add(struct net_device *soft_iface, const u8 *addr,
+			unsigned short vid, int ifindex, u32 mark)
 {
 	struct batadv_priv *bat_priv = netdev_priv(soft_iface);
 	struct batadv_tt_local_entry *tt_local;
@@ -645,10 +645,10 @@ bool batadv_tt_local_add(struct net_device *soft_iface, const u8 *addr,
 	struct hlist_head *head;
 	struct batadv_tt_orig_list_entry *orig_entry;
 	int hash_added, table_size, packet_size_max;
-	bool ret = false;
 	bool roamed_back = false;
 	u8 remote_flags;
 	u32 match_mark;
+	int ret = 0;
 
 	if (ifindex != BATADV_NULL_IFINDEX)
 		in_dev = dev_get_by_index(net, ifindex);
@@ -699,21 +699,22 @@ bool batadv_tt_local_add(struct net_device *soft_iface, const u8 *addr,
 		net_ratelimited_function(batadv_info, soft_iface,
 					 "Local translation table size (%i) exceeds maximum packet size (%i); Ignoring new local tt entry: %pM\n",
 					 table_size, packet_size_max, addr);
+		ret = -E2BIG;
 		goto out;
 	}
 
 	tt_local = kmem_cache_alloc(batadv_tl_cache, GFP_ATOMIC);
-	if (!tt_local)
+	if (!tt_local) {
+		ret = -ENOMEM;
 		goto out;
+	}
 
 	/* increase the refcounter of the related vlan */
-	vlan = batadv_softif_vlan_get(bat_priv, vid);
+	vlan = batadv_softif_vlan_get_or_create(bat_priv, vid);
 	if (!vlan) {
-		net_ratelimited_function(batadv_info, soft_iface,
-					 "adding TT local entry %pM to non-existent VLAN %d\n",
-					 addr, batadv_print_vid(vid));
 		kmem_cache_free(batadv_tl_cache, tt_local);
 		tt_local = NULL;
+		ret = -ENOMEM;
 		goto out;
 	}
 
@@ -810,7 +811,7 @@ bool batadv_tt_local_add(struct net_device *soft_iface, const u8 *addr,
 	if (remote_flags ^ (tt_local->common.flags & BATADV_TT_REMOTE_MASK))
 		batadv_tt_local_event(bat_priv, tt_local, BATADV_NO_FLAGS);
 
-	ret = true;
+	ret = 1;
 out:
 	batadv_hardif_put(in_hardif);
 	dev_put(in_dev);
diff --git a/net/batman-adv/translation-table.h b/net/batman-adv/translation-table.h
index d18740d9a22b..bbdda8488c14 100644
--- a/net/batman-adv/translation-table.h
+++ b/net/batman-adv/translation-table.h
@@ -16,8 +16,8 @@
 #include <linux/types.h>
 
 int batadv_tt_init(struct batadv_priv *bat_priv);
-bool batadv_tt_local_add(struct net_device *soft_iface, const u8 *addr,
-			 unsigned short vid, int ifindex, u32 mark);
+int batadv_tt_local_add(struct net_device *soft_iface, const u8 *addr,
+			unsigned short vid, int ifindex, u32 mark);
 u16 batadv_tt_local_remove(struct batadv_priv *bat_priv,
 			   const u8 *addr, unsigned short vid,
 			   const char *message, bool roaming);
-- 
2.45.2

