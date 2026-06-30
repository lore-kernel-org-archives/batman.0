Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C43B5C43458
	for <batman-adv@archiver.kernel.org>; Tue, 30 Jun 2026 14:10:36 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 65AC382726
	for <batman-adv@archiver.kernel.org>; Tue, 30 Jun 2026 16:10:35 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1782828635;
 b=Hst5w9BcGXL4p6M/pCgLIjdhd3W94H8qZq3Az39AnIdrw9l7a8UY3K90197PR3nWC2esU
 lPKRQ5Gp9FiPpxWdipTcHGw14SSMT+VsCbkxIqUAAz/xbWqy623o8bzK8hXBkGWrwyvF6Lt
 s5ArrLb+KUeJzwY8WWV8L7Wuu7UlHIM=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1782828635; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=EctJOCeEEu+Op8mhIe8WysG352nf2zpZL4mApbut/rs=;
 b=LO7QvyI3ytzzTBuDlqEyk7J6t3oJesECnzAVmZUlb1Gil5minIpafxgdj+6AUU4HiU++B
 YFW6EpAkpSRNC9MmBzudd+0uqm7Q0sYBa+6gzyG/gd5h6T/YK8jmnsKmFKp0xFL6uUvlZOI
 x4/s5ogN0sxRoXCW+FtCeyNJl0EvJDw=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass header.from=simonwunderlich.de policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=simonwunderlich.de policy.dmarc=none
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 86A18810DB
	for <b.a.t.m.a.n@lists.open-mesh.org>; Tue, 30 Jun 2026 16:06:26 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1782828391;
	b=3IG6h45OzpieAkbhIZb45QdCZkJCixTuNdS3ngdg79I0W9mWNfwIZ7L3jA7ZW4LtnFu45C
	dx83HZgRYQulL5We25eTC9a9w62yWAr3iCmh9W4dqZu6Qdn7Ao6S5kC1ySvesA8gxY63hc
	VRiLBTPqacwZE4jIsuG5QPvcHauDAn8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1782828391;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=EctJOCeEEu+Op8mhIe8WysG352nf2zpZL4mApbut/rs=;
	b=e4953HTa8pBV2IxM1MgTGS5cKzBcQtGfv9pXDchJMQHYpidCo+dBpY6rMMeV9cM7PfLsh+
	Slv38UpcnlnPDOU1dlg8AZ4Xnl/MhrLsbHUFW1i9rlyvLoAd689mnqI9yHJXS36pV/eeXL
	91fVO5mQ+BVHKIH9DbJ4/my+vDwe+Q8=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=simonwunderlich.de header.s=09092022 header.b=PRNFO9LU;
	spf=pass (diktynna.open-mesh.org: domain of sw@simonwunderlich.de designates
 23.88.38.48 as permitted sender) smtp.mailfrom=sw@simonwunderlich.de;
	dmarc=pass (policy=none) header.from=simonwunderlich.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1782828385;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EctJOCeEEu+Op8mhIe8WysG352nf2zpZL4mApbut/rs=;
	b=PRNFO9LUuX26RcEZOiQpY9gBSvO71xsFhUXwNXkWLkqDtUxISJRfqI0u5jbqLeOU07sBJo
	oUqcQNcy58AbTuaCGfrEo/crl6EmJLoyMG37xXRwXjBEYUMVUqDNTAdQ0+hRogkZszzeMM
	aobzCHltqqkFPAaWan/VmRyfiJL8Ocvdsy60R3XsRGUuPxfw2T/rn4iR2GBKHPujb/hj3I
	MWnzKp5MsQHi9C2VDDGNEeNPtoB707OWlwe+iuz3qeGNRmBE8k2v6ISTTNEDRU4En7G3QS
	q6BbhAUs6LT3w1dlTMwCBHGlegUbh5HluvRQayCp/PcLYu+yNA3n+CW0v4fV4g==
From: Simon Wunderlich <sw@simonwunderlich.de>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	b.a.t.m.a.n@lists.open-mesh.org,
	Nora Schiffer <neocturne@universe-factory.net>,
	Sven Eckelmann <sven@narfation.org>,
	Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH net-next 01/15] batman-adv: create hardif only for netdevs
 that are part of a mesh
Date: Tue, 30 Jun 2026 16:06:09 +0200
Message-ID: <20260630140623.88431-2-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260630140623.88431-1-sw@simonwunderlich.de>
References: <20260630140623.88431-1-sw@simonwunderlich.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: DXOKJMGSEIAGZWR6OPX5YL6SHVKAX42D
X-Message-ID-Hash: DXOKJMGSEIAGZWR6OPX5YL6SHVKAX42D
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/DXOKJMGSEIAGZWR6OPX5YL6SHVKAX42D/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

From: Nora Schiffer <neocturne@universe-factory.net>

batman-adv is using netdev notifiers to create a hard_iface struct for
every Ethernet-like netdev in the system. These hardifs are tracked in a
global linked list, which results in a few performance issues:

Lookups in this list are O(n) in the total number of netdevs. As a
hardif is looked up when a netdev is removed, this also takes O(n) in
the number of netdevs, and removing n netdevs may take O(n^2). This
slowdown will always happen when the batman-adv module is loaded, no
mesh needs to be active.

With the hardif being referenced as iflink private data, the global list
is only needed for hardifs that are *not* part of a mesh (that is, the
hardif is unused). To prepare for removing the global list, only create
a hardif struct when an interface is added to a mesh and destroy it on
removal.

As adding/removing and enabling/disabling a hardif become one and the
same, batadv_hardif_add_interface() is merged into
batadv_hardif_enable_interface(), and batadv_hardif_remove_interface()
can be dropped altogether.

Signed-off-by: Nora Schiffer <neocturne@universe-factory.net>
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/hard-interface.c | 120 +++++++++++---------------------
 net/batman-adv/hard-interface.h |   2 +-
 net/batman-adv/mesh-interface.c |  13 +---
 3 files changed, 44 insertions(+), 91 deletions(-)

diff --git a/net/batman-adv/hard-interface.c b/net/batman-adv/hard-interface.c
index 03d01c20a9548..9c9a892d22c6b 100644
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
+
+	netdev_hold(net_dev, &hard_iface->dev_tracker, GFP_ATOMIC);
+	hard_iface->net_dev = net_dev;
+
+	hard_iface->if_status = BATADV_IF_INACTIVE;
+
+	INIT_LIST_HEAD(&hard_iface->list);
+	INIT_HLIST_HEAD(&hard_iface->neigh_list);
 
-	kref_get(&hard_iface->refcount);
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
@@ -764,9 +789,6 @@ int batadv_hardif_enable_interface(struct batadv_hard_iface *hard_iface,
 	if (ret < 0)
 		goto err_upper;
 
-	hard_iface->if_status = BATADV_IF_INACTIVE;
-
-	kref_get(&hard_iface->refcount);
 	hard_iface->batman_adv_ptype.type = ethertype;
 	hard_iface->batman_adv_ptype.func = batadv_batman_skb_recv;
 	hard_iface->batman_adv_ptype.dev = hard_iface->net_dev;
@@ -802,7 +824,9 @@ int batadv_hardif_enable_interface(struct batadv_hard_iface *hard_iface,
 	if (bat_priv->algo_ops->iface.enabled)
 		bat_priv->algo_ops->iface.enabled(hard_iface);
 
-out:
+	list_add_tail_rcu(&hard_iface->list, &batadv_hardif_list);
+	batadv_hardif_generation++;
+
 	return 0;
 
 err_upper:
@@ -823,15 +847,19 @@ void batadv_hardif_disable_interface(struct batadv_hard_iface *hard_iface)
 	struct batadv_priv *bat_priv = netdev_priv(hard_iface->mesh_iface);
 	struct batadv_hard_iface *primary_if = NULL;
 
+	ASSERT_RTNL();
+
 	batadv_hardif_deactivate_interface(hard_iface);
 
 	if (hard_iface->if_status != BATADV_IF_INACTIVE)
 		goto out;
 
+	list_del_rcu(&hard_iface->list);
+	batadv_hardif_generation++;
+
 	batadv_info(hard_iface->mesh_iface, "Removing interface: %s\n",
 		    hard_iface->net_dev->name);
 	dev_remove_pack(&hard_iface->batman_adv_ptype);
-	batadv_hardif_put(hard_iface);
 
 	primary_if = batadv_primary_if_get_selected(bat_priv);
 	if (hard_iface == primary_if) {
@@ -844,7 +872,7 @@ void batadv_hardif_disable_interface(struct batadv_hard_iface *hard_iface)
 	}
 
 	bat_priv->algo_ops->iface.disable(hard_iface);
-	hard_iface->if_status = BATADV_IF_NOT_IN_USE;
+	hard_iface->if_status = BATADV_IF_TO_BE_REMOVED;
 
 	/* delete all references to this hard_iface */
 	batadv_purge_orig_ref(bat_priv);
@@ -865,63 +893,6 @@ void batadv_hardif_disable_interface(struct batadv_hard_iface *hard_iface)
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
@@ -1082,10 +1053,6 @@ static int batadv_hard_if_event(struct notifier_block *this,
 	batadv_wifi_net_device_event(event, net_dev);
 
 	hard_iface = batadv_hardif_get_by_netdev(net_dev);
-	if (!hard_iface && (event == NETDEV_REGISTER ||
-			    event == NETDEV_POST_TYPE_CHANGE))
-		hard_iface = batadv_hardif_add_interface(net_dev);
-
 	if (!hard_iface)
 		goto out;
 
@@ -1099,10 +1066,7 @@ static int batadv_hard_if_event(struct notifier_block *this,
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
index af31696c39780..6d72dbdd5c203 100644
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
index 44026810b99ce..a37368c1f5b55 100644
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

