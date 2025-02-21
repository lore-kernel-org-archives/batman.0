Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2318DC021B3
	for <batman-adv@archiver.kernel.org>; Fri, 21 Feb 2025 17:30:28 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id A35E884302
	for <batman-adv@archiver.kernel.org>; Fri, 21 Feb 2025 18:30:26 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1740159026;
 b=rl93z28RksMkQ6KVM6ExKNZBVB6vQcu7rl5V4gnxwx2GT6tgTv+Vw+5V2kTRlw1NaqI6d
 byZ61M+hK1eWgVBnPKX4h3jZSpReTh4nJZW+KcxY0qXN7eXgI34YgpN8zBYWd5t2O/1rbau
 m3bdJBBT/sfITg5LYlUxoztVam+MK9Q=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1740159026; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=KA+Go1ZjMHYIwlV6t/ERjD/LkbvnT1RtHrr/I0dqsv8=;
 b=mo0aGz6RaXZNAFV5FXx7/huNAgDq4RFsLaX1pIojk4DqnVVPU7HfUqQTNZ1k1xwrh+9tV
 WyiJIcDdmsB8U3c1H5aVGvDPX/x5ulM64a+0oErfQ81J3ai/ITYfUgB9MraA+wjxHtM4ils
 6hWUcoyuEk45n6e97/wKI81mrY1+GXI=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
  arc=pass;
  dmarc=pass (Used From Domain Record) header.from=narfation.org
 policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 85DB183FA8
	for <b.a.t.m.a.n@lists.open-mesh.org>; Fri, 21 Feb 2025 18:28:41 +0100 (CET)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1740158922;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=KA+Go1ZjMHYIwlV6t/ERjD/LkbvnT1RtHrr/I0dqsv8=;
	b=Vhm7+ruUz2nGVuLiBrWMHpcAGIAENG6jCMhkZsvxcep7br8Q1PQd1DHAa2Vz1owuwzbDfM
	oliWEKYp3KRHqhJGFAM+faxnLqixHCdiczGmIqYQbcSnV21OiJa8PoVyg+DPJsQZFYJJNy
	CPpApXWt0jIOydgFPxvfTEnQLGu5NAg=
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1740158922; a=rsa-sha256;
	cv=none;
	b=LV7bY0oKnQI3QTFhkkb4G9jYk+szambhdqDa2OvV6boOm7Qoq4hLsfYB9B0yKN3+cAfZBC
	3FmR72kIGjD90h8kDwaKup6VaWNJf4H2ynOk51bQ18VmCvzE3q5tp3J3e3WvdBk0pJnNuL
	a0ntZZrF9zGlmEZphY+gCGAUkI10ClA=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=JfXjnloP;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1740158917;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KA+Go1ZjMHYIwlV6t/ERjD/LkbvnT1RtHrr/I0dqsv8=;
	b=JfXjnloP9qKrZ+taajZ/tJ+U+FcyHJTmfECaWZ1RDQp5TaFqB1qMb09AVrvOC3Bq22FCVW
	IkNqA0AQ5DClSpKjTHa+MMJipXyevy2r2OEA06nX4MQdjMbqn65GNgwapdmpaJ6KS5hRxd
	bN3hvFLSjWv5+aIKLPUMAdV4J9zIZUE=
From: Sven Eckelmann <sven@narfation.org>
Date: Fri, 21 Feb 2025 18:27:31 +0100
Subject: [PATCH v6 1/3] batman-adv: add dynamic, bridged-in TT VID
 detection support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250221-dynamic-vlans-v6-1-fd94c9b782a7@narfation.org>
References: <20250221-dynamic-vlans-v6-0-fd94c9b782a7@narfation.org>
In-Reply-To: <20250221-dynamic-vlans-v6-0-fd94c9b782a7@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: =?utf-8?q?Linus_L=C3=BCssing?= <linus.luessing@c0d3.blue>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=14330; i=sven@narfation.org;
 h=from:subject:message-id; bh=ic5FQxtqLP5QB3mvYYSjzCTuJbI+sqTjDmSq8smBeCo=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDOk7tu/a9qRqwe8nO6pzGF+ly29syWRLPWx1+VDatcuN3
 wxZP6326yhlYRDjYpAVU2TZcyX//Gb2t/Kfp308CjOHlQlkCAMXpwBMJO4Ew29Wrl9Tr99TCjMK
 N5ZJZ63UvS94TubSA4lLN73ZJv5hPv+U4X/ymsSpkVJFk//NmuR4pX/l4WUTpv3wf5NxR565yOD
 ej5ssAA==
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: BM6A3KKIFURLWGD4OWZHCDYGOAGCQHX6
X-Message-ID-Hash: BM6A3KKIFURLWGD4OWZHCDYGOAGCQHX6
X-MailFrom: sven@narfation.org
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/BM6A3KKIFURLWGD4OWZHCDYGOAGCQHX6/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

From: Linus Lüssing <linus.luessing@c0d3.blue>

So far, if we wanted to bridge VLAN tagged frames into the mesh one would
need to manually create an according VLAN interface on top of bat0
first, to trigger batman-adv to create the according structures
for a VID.

With this change the VLAN from bridged-in clients is now automatically
detected and added to the translation table on the fly.

Signed-off-by: Linus Lüssing <linus.luessing@c0d3.blue>
---
 net/batman-adv/hard-interface.c    |   2 +-
 net/batman-adv/mesh-interface.c    | 125 ++++++++++++++++++++-----------------
 net/batman-adv/mesh-interface.h    |   6 +-
 net/batman-adv/multicast.c         |   8 ++-
 net/batman-adv/translation-table.c |  19 +++---
 net/batman-adv/translation-table.h |   4 +-
 6 files changed, 91 insertions(+), 73 deletions(-)

diff --git a/net/batman-adv/hard-interface.c b/net/batman-adv/hard-interface.c
index f145f96626531053bbf8f58a31f28f625a9d80f9..e69091498f3f903b48c4ecdae040d714e29ef931 100644
--- a/net/batman-adv/hard-interface.c
+++ b/net/batman-adv/hard-interface.c
@@ -940,7 +940,7 @@ static int batadv_hard_if_event_meshif(unsigned long event,
 	switch (event) {
 	case NETDEV_REGISTER:
 		bat_priv = netdev_priv(net_dev);
-		batadv_meshif_create_vlan(bat_priv, BATADV_NO_FLAGS);
+		batadv_meshif_create_vlan_own(bat_priv, BATADV_NO_FLAGS);
 		break;
 	}
 
diff --git a/net/batman-adv/mesh-interface.c b/net/batman-adv/mesh-interface.c
index 6d3dc650a93f96aa5e2abd3b30a69e47a47607b0..1e3ffca3fcf03236fb2403d7c6696b6135fc72fc 100644
--- a/net/batman-adv/mesh-interface.c
+++ b/net/batman-adv/mesh-interface.c
@@ -141,6 +141,10 @@ static int batadv_interface_set_mac_addr(struct net_device *dev, void *p)
 
 	rcu_read_lock();
 	hlist_for_each_entry_rcu(vlan, &bat_priv->meshif_vlan_list, list) {
+		/* we don't use this VID ourself, avoid adding us to it */
+		if (!batadv_is_my_client(bat_priv, old_addr, vlan->vid))
+			continue;
+
 		batadv_tt_local_remove(bat_priv, old_addr, vlan->vid,
 				       "mac address changed", false);
 		batadv_tt_local_add(dev, addr->sa_data, vlan->vid,
@@ -549,13 +553,15 @@ struct batadv_meshif_vlan *batadv_meshif_vlan_get(struct batadv_priv *bat_priv,
 }
 
 /**
- * batadv_meshif_create_vlan() - allocate the needed resources for a new vlan
+ * batadv_meshif_create_vlan() - create a meshif vlan struct
  * @bat_priv: the bat priv with all the mesh interface information
  * @vid: the VLAN identifier
  *
- * Return: 0 on success, a negative error otherwise.
+ * Return: a pointer to the newly allocated meshif vlan struct on success, NULL
+ * otherwise.
  */
-int batadv_meshif_create_vlan(struct batadv_priv *bat_priv, unsigned short vid)
+static struct batadv_meshif_vlan *
+batadv_meshif_create_vlan(struct batadv_priv *bat_priv, unsigned short vid)
 {
 	struct batadv_meshif_vlan *vlan;
 
@@ -563,55 +569,93 @@ int batadv_meshif_create_vlan(struct batadv_priv *bat_priv, unsigned short vid)
 
 	vlan = batadv_meshif_vlan_get(bat_priv, vid);
 	if (vlan) {
-		batadv_meshif_vlan_put(vlan);
 		spin_unlock_bh(&bat_priv->meshif_vlan_list_lock);
-		return -EEXIST;
+		return vlan;
 	}
 
 	vlan = kzalloc(sizeof(*vlan), GFP_ATOMIC);
 	if (!vlan) {
 		spin_unlock_bh(&bat_priv->meshif_vlan_list_lock);
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
 	hlist_add_head_rcu(&vlan->list, &bat_priv->meshif_vlan_list);
 	spin_unlock_bh(&bat_priv->meshif_vlan_list_lock);
 
+	return vlan;
+}
+
+/**
+ * batadv_meshif_vlan_get_or_create() - retrieve or create a meshif vlan struct
+ * @bat_priv: the bat priv with all the mesh interface information
+ * @vid: the VLAN identifier
+ *
+ * Return: the meshif vlan struct if found or created or NULL otherwise.
+ */
+struct batadv_meshif_vlan *
+batadv_meshif_vlan_get_or_create(struct batadv_priv *bat_priv,
+				 unsigned short vid)
+{
+	struct batadv_meshif_vlan *vlan = batadv_meshif_vlan_get(bat_priv, vid);
+
+	if (vlan)
+		return vlan;
+
+	return batadv_meshif_create_vlan(bat_priv, vid);
+}
+
+/**
+ * batadv_meshif_create_vlan_own() - add our own meshif to the local TT
+ * @bat_priv: the bat priv with all the mesh interface information
+ * @vid: the VLAN identifier
+ *
+ * Adds the MAC address of our own mesh interface with the given VLAN ID as
+ * a permanent local TT entry.
+ *
+ * Return: 0 on success, a negative error otherwise.
+ */
+int batadv_meshif_create_vlan_own(struct batadv_priv *bat_priv,
+				  unsigned short vid)
+{
+	int ret;
+
 	/* add a new TT local entry. This one will be marked with the NOPURGE
 	 * flag
 	 */
-	batadv_tt_local_add(bat_priv->mesh_iface,
-			    bat_priv->mesh_iface->dev_addr, vid,
-			    BATADV_NULL_IFINDEX, BATADV_NO_MARK);
-
-	/* don't return reference to new meshif_vlan */
-	batadv_meshif_vlan_put(vlan);
+	ret = batadv_tt_local_add(bat_priv->mesh_iface,
+				  bat_priv->mesh_iface->dev_addr, vid,
+				  BATADV_NULL_IFINDEX, BATADV_NO_MARK);
+	if (ret < 0)
+		return ret;
 
 	return 0;
 }
 
 /**
- * batadv_meshif_destroy_vlan() - remove and destroy a meshif_vlan object
+ * batadv_meshif_destroy_vlan_own() - remove our own meshif from the local TT
  * @bat_priv: the bat priv with all the mesh interface information
- * @vlan: the object to remove
+ * @vid: the VLAN identifier
+ *
+ * Removes the MAC address of our own mesh interface with the given VLAN ID from
+ * the local TT.
  */
-static void batadv_meshif_destroy_vlan(struct batadv_priv *bat_priv,
-				       struct batadv_meshif_vlan *vlan)
+static void batadv_meshif_destroy_vlan_own(struct batadv_priv *bat_priv,
+					   unsigned short vid)
 {
 	/* explicitly remove the associated TT local entry because it is marked
 	 * with the NOPURGE flag
 	 */
-	batadv_tt_local_remove(bat_priv, bat_priv->mesh_iface->dev_addr,
-			       vlan->vid, "vlan interface destroyed", false);
-
-	batadv_meshif_vlan_put(vlan);
+	batadv_tt_local_remove(bat_priv, bat_priv->mesh_iface->dev_addr, vid,
+			       "vlan interface destroyed", false);
 }
 
 /**
@@ -629,7 +673,6 @@ static int batadv_interface_add_vid(struct net_device *dev, __be16 proto,
 				    unsigned short vid)
 {
 	struct batadv_priv *bat_priv = netdev_priv(dev);
-	struct batadv_meshif_vlan *vlan;
 
 	/* only 802.1Q vlans are supported.
 	 * batman-adv does not know how to handle other types
@@ -647,25 +690,7 @@ static int batadv_interface_add_vid(struct net_device *dev, __be16 proto,
 
 	vid |= BATADV_VLAN_HAS_TAG;
 
-	/* if a new vlan is getting created and it already exists, it means that
-	 * it was not deleted yet. batadv_meshif_vlan_get() increases the
-	 * refcount in order to revive the object.
-	 *
-	 * if it does not exist then create it.
-	 */
-	vlan = batadv_meshif_vlan_get(bat_priv, vid);
-	if (!vlan)
-		return batadv_meshif_create_vlan(bat_priv, vid);
-
-	/* add a new TT local entry. This one will be marked with the NOPURGE
-	 * flag. This must be added again, even if the vlan object already
-	 * exists, because the entry was deleted by kill_vid()
-	 */
-	batadv_tt_local_add(bat_priv->mesh_iface,
-			    bat_priv->mesh_iface->dev_addr, vid,
-			    BATADV_NULL_IFINDEX, BATADV_NO_MARK);
-
-	return 0;
+	return batadv_meshif_create_vlan_own(bat_priv, vid);
 }
 
 /**
@@ -684,7 +709,6 @@ static int batadv_interface_kill_vid(struct net_device *dev, __be16 proto,
 				     unsigned short vid)
 {
 	struct batadv_priv *bat_priv = netdev_priv(dev);
-	struct batadv_meshif_vlan *vlan;
 
 	/* only 802.1Q vlans are supported. batman-adv does not know how to
 	 * handle other types
@@ -698,15 +722,7 @@ static int batadv_interface_kill_vid(struct net_device *dev, __be16 proto,
 	if (vid == 0)
 		return 0;
 
-	vlan = batadv_meshif_vlan_get(bat_priv, vid | BATADV_VLAN_HAS_TAG);
-	if (!vlan)
-		return -ENOENT;
-
-	batadv_meshif_destroy_vlan(bat_priv, vlan);
-
-	/* finally free the vlan object */
-	batadv_meshif_vlan_put(vlan);
-
+	batadv_meshif_destroy_vlan_own(bat_priv, vid | BATADV_VLAN_HAS_TAG);
 	return 0;
 }
 
@@ -1119,7 +1135,6 @@ static void batadv_meshif_destroy_netlink(struct net_device *mesh_iface,
 {
 	struct batadv_priv *bat_priv = netdev_priv(mesh_iface);
 	struct batadv_hard_iface *hard_iface;
-	struct batadv_meshif_vlan *vlan;
 
 	list_for_each_entry(hard_iface, &batadv_hardif_list, list) {
 		if (hard_iface->mesh_iface == mesh_iface)
@@ -1127,11 +1142,7 @@ static void batadv_meshif_destroy_netlink(struct net_device *mesh_iface,
 	}
 
 	/* destroy the "untagged" VLAN */
-	vlan = batadv_meshif_vlan_get(bat_priv, BATADV_NO_FLAGS);
-	if (vlan) {
-		batadv_meshif_destroy_vlan(bat_priv, vlan);
-		batadv_meshif_vlan_put(vlan);
-	}
+	batadv_meshif_destroy_vlan_own(bat_priv, BATADV_NO_FLAGS);
 
 	unregister_netdevice_queue(mesh_iface, head);
 }
diff --git a/net/batman-adv/mesh-interface.h b/net/batman-adv/mesh-interface.h
index 7ba055b2bc269d57719fa5cdd50888155cbd3d44..afa29e99df85f7fc60bdf2754f32febabaddb9b2 100644
--- a/net/batman-adv/mesh-interface.h
+++ b/net/batman-adv/mesh-interface.h
@@ -21,10 +21,14 @@ void batadv_interface_rx(struct net_device *mesh_iface,
 			 struct batadv_orig_node *orig_node);
 bool batadv_meshif_is_valid(const struct net_device *net_dev);
 extern struct rtnl_link_ops batadv_link_ops;
-int batadv_meshif_create_vlan(struct batadv_priv *bat_priv, unsigned short vid);
+int batadv_meshif_create_vlan_own(struct batadv_priv *bat_priv,
+				  unsigned short vid);
 void batadv_meshif_vlan_release(struct kref *ref);
 struct batadv_meshif_vlan *batadv_meshif_vlan_get(struct batadv_priv *bat_priv,
 						  unsigned short vid);
+struct batadv_meshif_vlan *
+batadv_meshif_vlan_get_or_create(struct batadv_priv *bat_priv,
+				 unsigned short vid);
 
 /**
  * batadv_meshif_vlan_put() - decrease the vlan object refcounter and
diff --git a/net/batman-adv/multicast.c b/net/batman-adv/multicast.c
index f26892b362e299c7d13a784a845b781958de98c0..97665c3005c54591b205d0f429c98ce056260335 100644
--- a/net/batman-adv/multicast.c
+++ b/net/batman-adv/multicast.c
@@ -723,6 +723,7 @@ static void batadv_mcast_mla_tt_add(struct batadv_priv *bat_priv,
 {
 	struct batadv_hw_addr *mcast_entry;
 	struct hlist_node *tmp;
+	int ret;
 
 	if (!mcast_list)
 		return;
@@ -732,9 +733,10 @@ static void batadv_mcast_mla_tt_add(struct batadv_priv *bat_priv,
 						  &bat_priv->mcast.mla_list))
 			continue;
 
-		if (!batadv_tt_local_add(bat_priv->mesh_iface,
-					 mcast_entry->addr, BATADV_NO_FLAGS,
-					 BATADV_NULL_IFINDEX, BATADV_NO_MARK))
+		ret = batadv_tt_local_add(bat_priv->mesh_iface,
+					  mcast_entry->addr, BATADV_NO_FLAGS,
+					  BATADV_NULL_IFINDEX, BATADV_NO_MARK);
+		if (ret <= 0)
 			continue;
 
 		hlist_del(&mcast_entry->list);
diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index 23cb44185a5ceb2ad836ffa1e8446e8c3a41d02e..efbe7addc121a777393f71d3b07f152d5b039113 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -626,8 +626,8 @@ static void batadv_tt_global_free(struct batadv_priv *bat_priv,
  *
  * Return: true if the client was successfully added, false otherwise.
  */
-bool batadv_tt_local_add(struct net_device *mesh_iface, const u8 *addr,
-			 unsigned short vid, int ifindex, u32 mark)
+int batadv_tt_local_add(struct net_device *mesh_iface, const u8 *addr,
+			unsigned short vid, int ifindex, u32 mark)
 {
 	struct batadv_priv *bat_priv = netdev_priv(mesh_iface);
 	struct batadv_tt_local_entry *tt_local;
@@ -639,10 +639,10 @@ bool batadv_tt_local_add(struct net_device *mesh_iface, const u8 *addr,
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
@@ -693,21 +693,22 @@ bool batadv_tt_local_add(struct net_device *mesh_iface, const u8 *addr,
 		net_ratelimited_function(batadv_info, mesh_iface,
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
-	vlan = batadv_meshif_vlan_get(bat_priv, vid);
+	vlan = batadv_meshif_vlan_get_or_create(bat_priv, vid);
 	if (!vlan) {
-		net_ratelimited_function(batadv_info, mesh_iface,
-					 "adding TT local entry %pM to non-existent VLAN %d\n",
-					 addr, batadv_print_vid(vid));
 		kmem_cache_free(batadv_tl_cache, tt_local);
 		tt_local = NULL;
+		ret = -ENOMEM;
 		goto out;
 	}
 
@@ -804,7 +805,7 @@ bool batadv_tt_local_add(struct net_device *mesh_iface, const u8 *addr,
 	if (remote_flags ^ (tt_local->common.flags & BATADV_TT_REMOTE_MASK))
 		batadv_tt_local_event(bat_priv, tt_local, BATADV_NO_FLAGS);
 
-	ret = true;
+	ret = 1;
 out:
 	batadv_hardif_put(in_hardif);
 	dev_put(in_dev);
diff --git a/net/batman-adv/translation-table.h b/net/batman-adv/translation-table.h
index 618d9dbca5eac48c06f99922ce5902ecce500821..9a972c5a7a7559e8c4a89aac63cf7e24585c63b6 100644
--- a/net/batman-adv/translation-table.h
+++ b/net/batman-adv/translation-table.h
@@ -16,8 +16,8 @@
 #include <linux/types.h>
 
 int batadv_tt_init(struct batadv_priv *bat_priv);
-bool batadv_tt_local_add(struct net_device *mesh_iface, const u8 *addr,
-			 unsigned short vid, int ifindex, u32 mark);
+int batadv_tt_local_add(struct net_device *mesh_iface, const u8 *addr,
+			unsigned short vid, int ifindex, u32 mark);
 u16 batadv_tt_local_remove(struct batadv_priv *bat_priv,
 			   const u8 *addr, unsigned short vid,
 			   const char *message, bool roaming);

-- 
2.39.5

