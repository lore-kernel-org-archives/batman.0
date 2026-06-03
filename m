Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8181ACD6E4A
	for <batman-adv@archiver.kernel.org>; Wed,  3 Jun 2026 04:33:49 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 17CE784C82
	for <batman-adv@archiver.kernel.org>; Wed, 03 Jun 2026 06:33:48 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1780461228;
 b=Atl4IuraiRFhLEkPRiorn9P+zr1sV6YKJbF6IbudXk/7OTUdVi8tjUuef5kqC0FzHOneF
 MRoXWxVajfgFobZ5QT3C4wCO89/k2n0b6fo3nFI2eWzM7p53m20fELWzUgOS+WNoe2kKHma
 NX/RJSWobjau8KF3o5jyr7KQzYkHIFQ=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1780461228; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=Xvt6+d1ekCnmL91wrIAcaV7Df9i620dlAb1UbQ/Qvcg=;
 b=Wd08dW9BrPVo9hZd/0zLFQ+rCIcDkXYOJfRE4xiLh1sX7e1eQR8B+IhYS4QAYtXFYoLWY
 hWxxKRjrMpffkOD2HpmjGkYimrtdYpqUS0oxIK9icMvqi0eQtiK9n9txUjkEWqN7Bo+JjK4
 eyRj6nZ/oOeAlbw8DfpN8MgOro26huQ=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org
 [IPv6:2a00:17d8:100::8b1])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 63DC185082
	for <b.a.t.m.a.n@lists.open-mesh.org>; Wed, 03 Jun 2026 06:29:46 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1780460986;
	b=Q3DTnuar8kiZmJ3lWC67+f45OVZSwU3T+VVcNrYq8cvAMqUP0C4+AHjW80ewBfXcAEYjoY
	eMTW1hujlaNLnYiFDSrYvXhwJoUMaLe3+zxEoDRloBNvq0gN08DOgqNzkCoo5LZpNtbH2y
	MrnrcUYLjpQr1UKj+Ix1Gw9BGzIOW/o=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=1DgTPnIu;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1780460986;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=Xvt6+d1ekCnmL91wrIAcaV7Df9i620dlAb1UbQ/Qvcg=;
	b=o580fY1UKCBTS4X5wXAu2bTQgQeTEyAMGLSbNOwUPKryCK2l0zWOEtJW7PGaGCPTGkqYnZ
	bfH3i+GJyrowG/5ZUX0an4WbZcq1tx0RHptT+38Ie26lvQnsKu4AIW+KjJvH+jexOM7VvN
	7o9JaLHQ02uiE7WAspTXneY5aelqbSQ=
Received: by dvalin.narfation.org (Postfix) id 1F9BC1FD9C;
	Wed, 03 Jun 2026 04:29:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1780460986;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Xvt6+d1ekCnmL91wrIAcaV7Df9i620dlAb1UbQ/Qvcg=;
	b=1DgTPnIuKB7Hd+7pQjO6MtnPU6n467Gn3bjZDskBViAOf598rNtH0rZ+JxkggjpnjaUoSv
	mVu0tf5ku0cvPLTlUIzFckrq6TSqtSCLYFQK+NxSGaHCG7Kc54HF1es9lymrZDm5VDAPLc
	5j1azgT5NlzINDyrfLnvDnsuYX5Qfds=
From: Sven Eckelmann <sven@narfation.org>
Date: Wed, 03 Jun 2026 06:29:03 +0200
Subject: [PATCH batadv v2 4/5] batman-adv: remove global hardif list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260603-drop-hardif-list-v2-4-5f79821ca333@narfation.org>
References: <20260603-drop-hardif-list-v2-0-5f79821ca333@narfation.org>
In-Reply-To: <20260603-drop-hardif-list-v2-0-5f79821ca333@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>,
 Nora Schiffer <neocturne@universe-factory.net>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=7081; i=sven@narfation.org;
 h=from:subject:message-id; bh=uIWeumZrtJMPh+f1JiJs3p/GrShq+PUwHfnQAabFE7E=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFnya6dsu28QGD1dWId3vp7QG4His+wrdsxe9rdRXuPt3
 WVSkq3zOkpZGMS4GGTFFFn2XMk/v5n9rfznaR+PwsxhZQIZwsDFKQAT8XRg+CvwRHMv8/Wec/bL
 0usCtv0I0TpmFMrvvr1ct2qv+U3bUH1GhtefJ0ed63umfK1tutbW5sqoKK0Y7p5Fl8Lndqs9ytN
 PZAYA
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: VRPKBXSIZIR7WGRGIWN2CKSDHGXT4F6S
X-Message-ID-Hash: VRPKBXSIZIR7WGRGIWN2CKSDHGXT4F6S
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/VRPKBXSIZIR7WGRGIWN2CKSDHGXT4F6S/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

From: Nora Schiffer <neocturne@universe-factory.net>

With interfaces being kept track of as iflink private data, there is no
need for the global list anymore. batadv_hardif_get_by_netdev() can now
use netdev_master_upper_dev_get()+netdev_lower_dev_get_private() to find
the hardif corresponding to a netdev.
---
 net/batman-adv/hard-interface.c | 35 +++++++++++++----------------------
 net/batman-adv/hard-interface.h |  2 +-
 net/batman-adv/main.c           |  5 -----
 net/batman-adv/main.h           |  1 -
 net/batman-adv/netlink.c        |  2 ++
 net/batman-adv/types.h          |  3 ---
 6 files changed, 16 insertions(+), 32 deletions(-)

diff --git a/net/batman-adv/hard-interface.c b/net/batman-adv/hard-interface.c
index 909e9b01..3990d826 100644
--- a/net/batman-adv/hard-interface.c
+++ b/net/batman-adv/hard-interface.c
@@ -63,6 +63,7 @@ void batadv_hardif_release(struct kref *ref)
 	struct batadv_hard_iface *hard_iface;
 
 	hard_iface = container_of(ref, struct batadv_hard_iface, refcount);
+	netdev_put(hard_iface->mesh_iface, &hard_iface->meshif_dev_tracker);
 	netdev_put(hard_iface->net_dev, &hard_iface->dev_tracker);
 
 	kfree_rcu(hard_iface, rcu);
@@ -75,21 +76,21 @@ void batadv_hardif_release(struct kref *ref)
  * Return: batadv_hard_iface of net_dev (with increased refcnt), NULL on errors
  */
 struct batadv_hard_iface *
-batadv_hardif_get_by_netdev(const struct net_device *net_dev)
+batadv_hardif_get_by_netdev(struct net_device *net_dev)
 {
 	struct batadv_hard_iface *hard_iface;
+	struct net_device *mesh_iface;
 
-	rcu_read_lock();
-	list_for_each_entry_rcu(hard_iface, &batadv_hardif_list, list) {
-		if (hard_iface->net_dev == net_dev &&
-		    kref_get_unless_zero(&hard_iface->refcount))
-			goto out;
-	}
+	ASSERT_RTNL();
 
-	hard_iface = NULL;
+	mesh_iface = netdev_master_upper_dev_get(net_dev);
+	if (!mesh_iface || !batadv_meshif_is_valid(mesh_iface))
+		return NULL;
+
+	hard_iface = netdev_lower_dev_get_private(mesh_iface, net_dev);
+	if (!kref_get_unless_zero(&hard_iface->refcount))
+		return NULL;
 
-out:
-	rcu_read_unlock();
 	return hard_iface;
 }
 
@@ -754,10 +755,8 @@ int batadv_hardif_enable_interface(struct net_device *net_dev,
 	netdev_hold(net_dev, &hard_iface->dev_tracker, GFP_ATOMIC);
 	hard_iface->net_dev = net_dev;
 
-	hard_iface->mesh_iface = NULL;
 	hard_iface->if_status = BATADV_IF_INACTIVE;
 
-	INIT_LIST_HEAD(&hard_iface->list);
 	INIT_HLIST_HEAD(&hard_iface->neigh_list);
 
 	mutex_init(&hard_iface->bat_iv.ogm_buff_mutex);
@@ -772,14 +771,11 @@ int batadv_hardif_enable_interface(struct net_device *net_dev,
 
 	batadv_v_hardif_init(hard_iface);
 
-	kref_get(&hard_iface->refcount);
-	list_add_tail_rcu(&hard_iface->list, &batadv_hardif_list);
-	batadv_hardif_generation++;
-
 	netdev_hold(mesh_iface, &hard_iface->meshif_dev_tracker, GFP_ATOMIC);
 	hard_iface->mesh_iface = mesh_iface;
 	bat_priv = netdev_priv(hard_iface->mesh_iface);
 
+	batadv_hardif_generation++;
 	ret = netdev_master_upper_dev_link(hard_iface->net_dev,
 					   mesh_iface, hard_iface, NULL, NULL);
 	if (ret)
@@ -876,10 +872,6 @@ void batadv_hardif_disable_interface(struct batadv_hard_iface *hard_iface)
 	if (hard_iface->if_status != BATADV_IF_INACTIVE)
 		goto out;
 
-	list_del_rcu(&hard_iface->list);
-	batadv_hardif_put(hard_iface);
-	batadv_hardif_generation++;
-
 	batadv_info(hard_iface->mesh_iface, "Removing interface: %s\n",
 		    hard_iface->net_dev->name);
 	dev_remove_pack(&hard_iface->batman_adv_ptype);
@@ -901,8 +893,8 @@ void batadv_hardif_disable_interface(struct batadv_hard_iface *hard_iface)
 	/* delete all references to this hard_iface */
 	batadv_purge_orig_ref(bat_priv);
 	batadv_purge_outstanding_packets(bat_priv, hard_iface);
-	netdev_put(hard_iface->mesh_iface, &hard_iface->meshif_dev_tracker);
 
+	batadv_hardif_generation++;
 	netdev_upper_dev_unlink(hard_iface->net_dev, hard_iface->mesh_iface);
 	batadv_hardif_recalc_extra_skbroom(hard_iface->mesh_iface);
 
@@ -910,7 +902,6 @@ void batadv_hardif_disable_interface(struct batadv_hard_iface *hard_iface)
 	if (batadv_hardif_cnt(hard_iface->mesh_iface) <= 1)
 		batadv_gw_check_client_stop(bat_priv);
 
-	hard_iface->mesh_iface = NULL;
 	batadv_hardif_put(hard_iface);
 
 out:
diff --git a/net/batman-adv/hard-interface.h b/net/batman-adv/hard-interface.h
index 1194f24f..a5fd8c52 100644
--- a/net/batman-adv/hard-interface.h
+++ b/net/batman-adv/hard-interface.h
@@ -68,7 +68,7 @@ u32 batadv_netdev_get_wifi_flags(struct net_device *net_dev);
 u32 batadv_hardif_get_wifi_flags(struct batadv_hard_iface *hard_iface);
 bool batadv_is_wifi_hardif(struct batadv_hard_iface *hard_iface);
 struct batadv_hard_iface*
-batadv_hardif_get_by_netdev(const struct net_device *net_dev);
+batadv_hardif_get_by_netdev(struct net_device *net_dev);
 int batadv_hardif_enable_interface(struct net_device *net_dev,
 				   struct net_device *mesh_iface);
 void batadv_hardif_disable_interface(struct batadv_hard_iface *hard_iface);
diff --git a/net/batman-adv/main.c b/net/batman-adv/main.c
index 60d4f600..ad26b6ce 100644
--- a/net/batman-adv/main.c
+++ b/net/batman-adv/main.c
@@ -59,10 +59,6 @@
 #include "tp_meter.h"
 #include "translation-table.h"
 
-/* List manipulations on hardif_list have to be rtnl_lock()'ed,
- * list traversals just rcu-locked
- */
-struct list_head batadv_hardif_list;
 unsigned int batadv_hardif_generation;
 static int (*batadv_rx_handler[256])(struct sk_buff *skb,
 				     struct batadv_hard_iface *recv_if);
@@ -95,7 +91,6 @@ static int __init batadv_init(void)
 	if (ret < 0)
 		return ret;
 
-	INIT_LIST_HEAD(&batadv_hardif_list);
 	batadv_algo_init();
 
 	batadv_recv_handler_init();
diff --git a/net/batman-adv/main.h b/net/batman-adv/main.h
index f68fc8b7..e3414504 100644
--- a/net/batman-adv/main.h
+++ b/net/batman-adv/main.h
@@ -226,7 +226,6 @@ static inline int batadv_print_vid(unsigned short vid)
 		return -1;
 }
 
-extern struct list_head batadv_hardif_list;
 extern unsigned int batadv_hardif_generation;
 
 extern struct workqueue_struct *batadv_event_workqueue;
diff --git a/net/batman-adv/netlink.c b/net/batman-adv/netlink.c
index 4a0fe9ec..1449f364 100644
--- a/net/batman-adv/netlink.c
+++ b/net/batman-adv/netlink.c
@@ -1205,7 +1205,9 @@ batadv_netlink_get_hardif_from_ifindex(struct batadv_priv *bat_priv,
 	if (!hard_dev)
 		return ERR_PTR(-ENODEV);
 
+	rtnl_lock();
 	hard_iface = batadv_hardif_get_by_netdev(hard_dev);
+	rtnl_unlock();
 	if (!hard_iface)
 		goto err_put_harddev;
 
diff --git a/net/batman-adv/types.h b/net/batman-adv/types.h
index 19c73168..deb0b738 100644
--- a/net/batman-adv/types.h
+++ b/net/batman-adv/types.h
@@ -208,9 +208,6 @@ struct batadv_wifi_net_device_state {
  * struct batadv_hard_iface - network device known to batman-adv
  */
 struct batadv_hard_iface {
-	/** @list: list node for batadv_hardif_list */
-	struct list_head list;
-
 	/** @if_status: status of the interface for batman-adv */
 	char if_status;
 

-- 
2.47.3

