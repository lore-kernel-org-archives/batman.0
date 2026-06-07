Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A979CD8C8C
	for <batman-adv@archiver.kernel.org>; Sun,  7 Jun 2026 11:54:50 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id D56C084360
	for <batman-adv@archiver.kernel.org>; Sun, 07 Jun 2026 13:54:48 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1780833288;
 b=QcOCNAu072IFiPVGUB0py1vDMhx5e5qescc7YAB3voEjzM4M99YuAhbajwTIPY3b8AfPL
 tiCRxZ9V+Z11N+I3hntyWXsgdRs2JILl+Zw6jRwYFglTbxOWabSemjPG4Fb17dGgCcABqd+
 cGV/dqby2Cjzado79ezPIjkF3wssuGI=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1780833288; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=wGK4yAru1zhem7jftIrG+ANHkY9yEJws8jQ244L7GWc=;
 b=yrRrnUhiBu/DOKvwgcM5SmOUafC+A6JYN9i4skKzuK9OaK1JXgo6Jf/hEn7Io9DY5w8m9
 SN/4+3wY607iKhJNSyphEY/DAt7BCvjt8PIIRuK6JEkZvSEQjeZRwMVPfamhvvSHz+s2cky
 zdI+5eQz4H+aaOPqwY0+V1OJGhFMSNM=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 5921884187
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sun, 07 Jun 2026 13:54:34 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1780833279;
	b=mcTLTckv6t4Ni1f+f0lO7BhCur8H6k8hycFH3bgECv7IE2fIIwGacT8V+wQ2RCK4KV19WI
	VO/QYX2KrVAQVUJbe+SEcd9uR7w6l/R/uAYNMYiSciRcvW/xL2gSHB1pTRngjzv6PBelvR
	1GL6bmJvd8wxHWmZPvuh2swfi08Uk3E=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=ZDCaNufb;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1780833279;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=wGK4yAru1zhem7jftIrG+ANHkY9yEJws8jQ244L7GWc=;
	b=BwfwZMn4ryXq5l0plXZKc0UHSVPI6Gkes+8U7xSDXM1Dhsk5s+DUHDwk9A8WvbM2/6Cp8y
	G2mUe/LjhU/fkPeK+ynTGan9mRclawjPaUm6HroXP6Y22PF876Mjzx/d/l0vXK9h8Op4NL
	QNdrjJDcQkSZFNg5sH5mDNfOQbkR4dU=
Received: by dvalin.narfation.org (Postfix) id C8443200D3;
	Sun, 07 Jun 2026 11:54:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1780833273;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wGK4yAru1zhem7jftIrG+ANHkY9yEJws8jQ244L7GWc=;
	b=ZDCaNufb3SdsVVjG1+NYYx73vocVKUqpkelg2vR4tSTjo6Ai81VeoBo3SdwqR5HcyRfjaq
	qSFV1+PHI6f80yHRCbpkN1vwYzvbvNdFHWRVH4bE+9ibWxwSMW+XZ2zfNUYkMhMHw4imXG
	+07Iqsk8HrH35CagDyghv9aZdlVA0Ak=
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 07 Jun 2026 13:53:55 +0200
Subject: [PATCH RFC batadv v4 1/7] batman-adv: only create hardif while a
 netdev is part of a mesh
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260607-drop-hardif-list-v4-1-ade2931db295@narfation.org>
References: <20260607-drop-hardif-list-v4-0-ade2931db295@narfation.org>
In-Reply-To: <20260607-drop-hardif-list-v4-0-ade2931db295@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>,
 Nora Schiffer <neocturne@universe-factory.net>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=9378; i=sven@narfation.org;
 h=from:subject:message-id; bh=OGzQ0Kn4+709GtUsekeQTKWRNLrQsnNgBuQ6lIjNpIQ=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFmq0TdXtPrOuD/tR6mnrbY6Y3pl76p7N6q++Keuzgma4
 5BpdDKuo5SFQYyLQVZMkWXPlfzzm9nfyn+e9vEozBxWJpAhDFycAjAR97MMf0VExdd0CGj0Heg9
 9eVR712LKwlqLqGvnk61vv80T0TcpYGRoUmw8FgM3xeGKRM2aSxfsenEjriXTtYsNslM8buk10z
 s4gYA
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: 4NWZ5LYOHJGI7JW4C7IFXPO6KPC2HQTH
X-Message-ID-Hash: 4NWZ5LYOHJGI7JW4C7IFXPO6KPC2HQTH
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/4NWZ5LYOHJGI7JW4C7IFXPO6KPC2HQTH/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

From: Nora Schiffer <neocturne@universe-factory.net>

batman-adv has used netdevice notifiers to create a hardif struct for
every Ethernet-like netdev in the system, instead of just for netdevs
that are actually used for meshing.

This is inefficient in many ways: It requires maintaining a global list
of hardifs (as there is no other place to store the hardif associated
with a netdev), lookups in this list are O(n) in the total number of
interfaces, and the maintenance of this list results in just loading the
batman-adv module to cause a slowdown of certain netdev operations (for
example, deleting n Ethernet netdevs may take O(n^2) because for each
removal, the corresponding hardif needs to be looked up in the global
list).

As the next step towards removing the global list, only create a hardif
struct when an interface is added to a mesh, and destroy it on removal.
Parts of batadv_hardif_add_interface() are merged into
batadv_hardif_enable_interface(), and batadv_hardif_remove_interface()
can be dropped altogether.
---
 net/batman-adv/hard-interface.c | 120 +++++++++++++++-------------------------
 net/batman-adv/hard-interface.h |   2 +-
 net/batman-adv/mesh-interface.c |  13 +----
 3 files changed, 46 insertions(+), 89 deletions(-)

diff --git a/net/batman-adv/hard-interface.c b/net/batman-adv/hard-interface.c
index 60cee2c2..b78b3989 100644
--- a/net/batman-adv/hard-interface.c
+++ b/net/batman-adv/hard-interface.c
@@ -723,33 +723,58 @@ batadv_hardif_deactivate_interface(struct batadv_hard_iface *hard_iface)
 }
 
 /**
- * batadv_hardif_enable_interface() - Enslave hard interface to mesh interface
- * @hard_iface: hard interface to add to mesh interface
+ * batadv_hardif_enable_interface() - Enslave interface to mesh interface
+ * @net_dev: netdev struct of the interface to add to mesh interface
  * @mesh_iface: netdev struct of the mesh interface
  *
  * Return: 0 on success or negative error number in case of failure
  */
-int batadv_hardif_enable_interface(struct batadv_hard_iface *hard_iface,
+int batadv_hardif_enable_interface(struct net_device *net_dev,
 				   struct net_device *mesh_iface)
 {
 	struct batadv_priv *bat_priv;
 	__be16 ethertype = htons(ETH_P_BATMAN);
 	int max_header_len = batadv_max_header_len();
+	struct batadv_hard_iface *hard_iface;
 	unsigned int required_mtu;
 	unsigned int hardif_mtu;
 	bool fragmentation;
 	int ret;
 
-	hardif_mtu = READ_ONCE(hard_iface->net_dev->mtu);
+	ASSERT_RTNL();
+
+	if (!batadv_is_valid_iface(net_dev))
+		return -EINVAL;
+
+	hardif_mtu = READ_ONCE(net_dev->mtu);
 	required_mtu = READ_ONCE(mesh_iface->mtu) + max_header_len;
 
 	if (hardif_mtu < ETH_MIN_MTU + max_header_len)
 		return -EINVAL;
 
-	if (hard_iface->if_status != BATADV_IF_NOT_IN_USE)
-		goto out;
+	hard_iface = kzalloc_obj(*hard_iface, GFP_ATOMIC);
+	if (!hard_iface)
+		return -ENOMEM;
 
-	kref_get(&hard_iface->refcount);
+	netdev_hold(net_dev, &hard_iface->dev_tracker, GFP_ATOMIC);
+	hard_iface->net_dev = net_dev;
+
+	hard_iface->if_status = BATADV_IF_INACTIVE;
+
+	INIT_LIST_HEAD(&hard_iface->list);
+	INIT_HLIST_HEAD(&hard_iface->neigh_list);
+
+	mutex_init(&hard_iface->bat_iv.ogm_buff_mutex);
+	spin_lock_init(&hard_iface->neigh_list_lock);
+	kref_init(&hard_iface->refcount);
+
+	hard_iface->num_bcasts = BATADV_NUM_BCASTS_DEFAULT;
+	if (batadv_is_wifi_hardif(hard_iface))
+		hard_iface->num_bcasts = BATADV_NUM_BCASTS_WIRELESS;
+
+	WRITE_ONCE(hard_iface->hop_penalty, 0);
+
+	batadv_v_hardif_init(hard_iface);
 
 	netdev_hold(mesh_iface, &hard_iface->meshif_dev_tracker, GFP_ATOMIC);
 	hard_iface->mesh_iface = mesh_iface;
@@ -764,8 +789,6 @@ int batadv_hardif_enable_interface(struct batadv_hard_iface *hard_iface,
 	if (ret < 0)
 		goto err_upper;
 
-	hard_iface->if_status = BATADV_IF_INACTIVE;
-
 	kref_get(&hard_iface->refcount);
 	hard_iface->batman_adv_ptype.type = ethertype;
 	hard_iface->batman_adv_ptype.func = batadv_batman_skb_recv;
@@ -802,7 +825,10 @@ int batadv_hardif_enable_interface(struct batadv_hard_iface *hard_iface,
 	if (bat_priv->algo_ops->iface.enabled)
 		bat_priv->algo_ops->iface.enabled(hard_iface);
 
-out:
+	kref_get(&hard_iface->refcount);
+	list_add_tail_rcu(&hard_iface->list, &batadv_hardif_list);
+	batadv_hardif_generation++;
+
 	return 0;
 
 err_upper:
@@ -847,11 +873,17 @@ void batadv_hardif_disable_interface(struct batadv_hard_iface *hard_iface)
 	struct batadv_priv *bat_priv = netdev_priv(hard_iface->mesh_iface);
 	struct batadv_hard_iface *primary_if = NULL;
 
+	ASSERT_RTNL();
+
 	batadv_hardif_deactivate_interface(hard_iface);
 
 	if (hard_iface->if_status != BATADV_IF_INACTIVE)
 		goto out;
 
+	list_del_rcu(&hard_iface->list);
+	batadv_hardif_put(hard_iface);
+	batadv_hardif_generation++;
+
 	batadv_info(hard_iface->mesh_iface, "Removing interface: %s\n",
 		    hard_iface->net_dev->name);
 	dev_remove_pack(&hard_iface->batman_adv_ptype);
@@ -868,7 +900,7 @@ void batadv_hardif_disable_interface(struct batadv_hard_iface *hard_iface)
 	}
 
 	bat_priv->algo_ops->iface.disable(hard_iface);
-	hard_iface->if_status = BATADV_IF_NOT_IN_USE;
+	hard_iface->if_status = BATADV_IF_TO_BE_REMOVED;
 
 	/* delete all references to this hard_iface */
 	batadv_purge_orig_ref(bat_priv);
@@ -889,63 +921,6 @@ void batadv_hardif_disable_interface(struct batadv_hard_iface *hard_iface)
 	batadv_hardif_put(primary_if);
 }
 
-static struct batadv_hard_iface *
-batadv_hardif_add_interface(struct net_device *net_dev)
-{
-	struct batadv_hard_iface *hard_iface;
-
-	ASSERT_RTNL();
-
-	if (!batadv_is_valid_iface(net_dev))
-		return NULL;
-
-	hard_iface = kzalloc_obj(*hard_iface, GFP_ATOMIC);
-	if (!hard_iface)
-		return NULL;
-
-	netdev_hold(net_dev, &hard_iface->dev_tracker, GFP_ATOMIC);
-	hard_iface->net_dev = net_dev;
-
-	hard_iface->mesh_iface = NULL;
-	hard_iface->if_status = BATADV_IF_NOT_IN_USE;
-
-	INIT_LIST_HEAD(&hard_iface->list);
-	INIT_HLIST_HEAD(&hard_iface->neigh_list);
-
-	mutex_init(&hard_iface->bat_iv.ogm_buff_mutex);
-	spin_lock_init(&hard_iface->neigh_list_lock);
-	kref_init(&hard_iface->refcount);
-
-	hard_iface->num_bcasts = BATADV_NUM_BCASTS_DEFAULT;
-	if (batadv_is_wifi_hardif(hard_iface))
-		hard_iface->num_bcasts = BATADV_NUM_BCASTS_WIRELESS;
-
-	WRITE_ONCE(hard_iface->hop_penalty, 0);
-
-	batadv_v_hardif_init(hard_iface);
-
-	kref_get(&hard_iface->refcount);
-	list_add_tail_rcu(&hard_iface->list, &batadv_hardif_list);
-	batadv_hardif_generation++;
-
-	return hard_iface;
-}
-
-static void batadv_hardif_remove_interface(struct batadv_hard_iface *hard_iface)
-{
-	ASSERT_RTNL();
-
-	/* first deactivate interface */
-	if (hard_iface->if_status != BATADV_IF_NOT_IN_USE)
-		batadv_hardif_disable_interface(hard_iface);
-
-	if (hard_iface->if_status != BATADV_IF_NOT_IN_USE)
-		return;
-
-	hard_iface->if_status = BATADV_IF_TO_BE_REMOVED;
-	batadv_hardif_put(hard_iface);
-}
-
 /**
  * batadv_hard_if_event_meshif() - Handle events for mesh interfaces
  * @event: NETDEV_* event to handle
@@ -1106,10 +1081,6 @@ static int batadv_hard_if_event(struct notifier_block *this,
 	batadv_wifi_net_device_event(event, net_dev);
 
 	hard_iface = batadv_hardif_get_by_netdev(net_dev);
-	if (!hard_iface && (event == NETDEV_REGISTER ||
-			    event == NETDEV_POST_TYPE_CHANGE))
-		hard_iface = batadv_hardif_add_interface(net_dev);
-
 	if (!hard_iface)
 		goto out;
 
@@ -1123,10 +1094,7 @@ static int batadv_hard_if_event(struct notifier_block *this,
 		break;
 	case NETDEV_UNREGISTER:
 	case NETDEV_PRE_TYPE_CHANGE:
-		list_del_rcu(&hard_iface->list);
-		batadv_hardif_generation++;
-
-		batadv_hardif_remove_interface(hard_iface);
+		batadv_hardif_disable_interface(hard_iface);
 		break;
 	case NETDEV_CHANGEMTU:
 		if (hard_iface->mesh_iface)
diff --git a/net/batman-adv/hard-interface.h b/net/batman-adv/hard-interface.h
index af31696c..6d72dbdd 100644
--- a/net/batman-adv/hard-interface.h
+++ b/net/batman-adv/hard-interface.h
@@ -75,7 +75,7 @@ u32 batadv_hardif_get_wifi_flags(struct batadv_hard_iface *hard_iface);
 bool batadv_is_wifi_hardif(struct batadv_hard_iface *hard_iface);
 struct batadv_hard_iface*
 batadv_hardif_get_by_netdev(const struct net_device *net_dev);
-int batadv_hardif_enable_interface(struct batadv_hard_iface *hard_iface,
+int batadv_hardif_enable_interface(struct net_device *net_dev,
 				   struct net_device *mesh_iface);
 void batadv_hardif_disable_interface(struct batadv_hard_iface *hard_iface);
 int batadv_hardif_min_mtu(struct net_device *mesh_iface);
diff --git a/net/batman-adv/mesh-interface.c b/net/batman-adv/mesh-interface.c
index e5a55d24..0411a0ba 100644
--- a/net/batman-adv/mesh-interface.c
+++ b/net/batman-adv/mesh-interface.c
@@ -836,18 +836,7 @@ static int batadv_meshif_slave_add(struct net_device *dev,
 				   struct net_device *slave_dev,
 				   struct netlink_ext_ack *extack)
 {
-	struct batadv_hard_iface *hard_iface;
-	int ret = -EINVAL;
-
-	hard_iface = batadv_hardif_get_by_netdev(slave_dev);
-	if (!hard_iface || hard_iface->mesh_iface)
-		goto out;
-
-	ret = batadv_hardif_enable_interface(hard_iface, dev);
-
-out:
-	batadv_hardif_put(hard_iface);
-	return ret;
+	return batadv_hardif_enable_interface(slave_dev, dev);
 }
 
 /**

-- 
2.47.3

