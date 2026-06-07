Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E573BCD8C8C
	for <batman-adv@archiver.kernel.org>; Sun,  7 Jun 2026 11:57:03 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 80E6B8429F
	for <batman-adv@archiver.kernel.org>; Sun, 07 Jun 2026 13:57:02 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1780833422;
 b=iJSmr7McnPvrISdaA5F7+JOG6DJIt0Di4toKWgEy/7+kZujnzXKspE50kx9enXSCfqjcF
 mRbVm92OT3CBv22niCDoQQaXOYkoaHLi2RZxffrqlpJOeMeItlUW7NcOrxh6G+4lujADHbF
 edizkFhTaBqR6vUJFX4j/Nvdg6xJ82I=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1780833422; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=xOGjvTibAnVGQwp6T+/MJ3z+u2B8QwPkMPmTRbUzW/c=;
 b=JAmQMXAQ3QjPXC6Z/D6PgS64Ys5XGW3sjp4QOvoMoRoG7/lbQeEFiuPA2Ler3wKf7y0/Z
 a/Z8q0ye31KjuwMWGGfDje21dcIkya0pi2XUYWIg72cMl9k4ZAORFwLSdTL6LIYG5rfEVYf
 IXVJapEOqCT95u/5wJv2Co8oF9iR/tM=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org
 [IPv6:2a00:17d8:100::8b1])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 7396384187
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sun, 07 Jun 2026 13:54:36 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1780833281;
	b=Cd9xPwo8a73TLGc0j2tXmWMoTm74Xd/g4wHrVgt+fwwpLF6+53XYd/uxoD3UyxbvPtio61
	HhKLT2skyQihj1kajVysUGsXGDkjT5dn1agjPnXNoAZJbSMlNSjUcVzaSFdmz/o3R/vLE0
	N8yEuCK/XOZamW4LE7zJQkg1s2z4ubo=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=hTnGqiSD;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1780833281;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=xOGjvTibAnVGQwp6T+/MJ3z+u2B8QwPkMPmTRbUzW/c=;
	b=gHPCKmEWbkabDAsIXhMxtUFjUxOUi0/+9h6L4C54PqnKLSGt411VKGiScWqRIMA09uBGw2
	ZDX9/n37yRvzqmZr0TpzZ6s3g2azm8/r9m6QqiBEJBijB/TAZ2CWzz6Fqb8Z97mj7NyXXz
	rVpiylHFX4v0CUMO7hkoUcBVAvPveOQ=
Received: by dvalin.narfation.org (Postfix) id 1E196200D7;
	Sun, 07 Jun 2026 11:54:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1780833276;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xOGjvTibAnVGQwp6T+/MJ3z+u2B8QwPkMPmTRbUzW/c=;
	b=hTnGqiSDPFNvt8Gg8G8ai9tOaBDZBM+meX7m1tPyJBsUvg9YaoACHoZsZPuwU/KCvTKSi5
	VObs/hnvqfnqMboFLCieeQSeCs9sXu0eett3BvC2c6+ZnQ5oTLgTUz4vDX0a38/W0wgPmK
	pDapJsdV/6vFnc1a3gGhddRRq/XPSFk=
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 07 Jun 2026 13:53:56 +0200
Subject: [PATCH RFC batadv v4 2/7] batman-adv: remove global hardif list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260607-drop-hardif-list-v4-2-ade2931db295@narfation.org>
References: <20260607-drop-hardif-list-v4-0-ade2931db295@narfation.org>
In-Reply-To: <20260607-drop-hardif-list-v4-0-ade2931db295@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>,
 Nora Schiffer <neocturne@universe-factory.net>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=7262; i=sven@narfation.org;
 h=from:subject:message-id; bh=6xPMUnVoGcLaAuUJcrEqR1G+0CH/faVov70HVjSiKZQ=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFmq0bfunY1Xnyxmv1G61uOW71nD0vsyl3wTOE6s4ljks
 dZZ31O3o5SFQYyLQVZMkWXPlfzzm9nfyn+e9vEozBxWJpAhDFycAjARNyNGhr1LNWfk9TRGJ/sU
 v28zPCYzyzvxqmXjxL8TnGz2tth99WP4n6K1+LS2eehk0WxuLon3W2Yf+HPC/birXGPihHbbX8I
 tXAA=
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: BNNGGVPB7LBOJTZ7RY5CFJ5V6JIIJ367
X-Message-ID-Hash: BNNGGVPB7LBOJTZ7RY5CFJ5V6JIIJ367
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/BNNGGVPB7LBOJTZ7RY5CFJ5V6JIIJ367/>
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
 net/batman-adv/hard-interface.c | 36 +++++++++++++-----------------------
 net/batman-adv/hard-interface.h |  2 +-
 net/batman-adv/main.c           |  5 -----
 net/batman-adv/main.h           |  1 -
 net/batman-adv/netlink.c        |  2 ++
 net/batman-adv/types.h          |  3 ---
 6 files changed, 16 insertions(+), 33 deletions(-)

diff --git a/net/batman-adv/hard-interface.c b/net/batman-adv/hard-interface.c
index b78b3989..0085f29a 100644
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
 
@@ -761,7 +762,6 @@ int batadv_hardif_enable_interface(struct net_device *net_dev,
 
 	hard_iface->if_status = BATADV_IF_INACTIVE;
 
-	INIT_LIST_HEAD(&hard_iface->list);
 	INIT_HLIST_HEAD(&hard_iface->neigh_list);
 
 	mutex_init(&hard_iface->bat_iv.ogm_buff_mutex);
@@ -780,6 +780,7 @@ int batadv_hardif_enable_interface(struct net_device *net_dev,
 	hard_iface->mesh_iface = mesh_iface;
 	bat_priv = netdev_priv(hard_iface->mesh_iface);
 
+	batadv_hardif_generation++;
 	ret = netdev_master_upper_dev_link(hard_iface->net_dev,
 					   mesh_iface, hard_iface, NULL, NULL);
 	if (ret)
@@ -825,17 +826,11 @@ int batadv_hardif_enable_interface(struct net_device *net_dev,
 	if (bat_priv->algo_ops->iface.enabled)
 		bat_priv->algo_ops->iface.enabled(hard_iface);
 
-	kref_get(&hard_iface->refcount);
-	list_add_tail_rcu(&hard_iface->list, &batadv_hardif_list);
-	batadv_hardif_generation++;
-
 	return 0;
 
 err_upper:
 	netdev_upper_dev_unlink(hard_iface->net_dev, mesh_iface);
 err_dev:
-	hard_iface->mesh_iface = NULL;
-	netdev_put(mesh_iface, &hard_iface->meshif_dev_tracker);
 	batadv_hardif_put(hard_iface);
 	return ret;
 }
@@ -880,10 +875,6 @@ void batadv_hardif_disable_interface(struct batadv_hard_iface *hard_iface)
 	if (hard_iface->if_status != BATADV_IF_INACTIVE)
 		goto out;
 
-	list_del_rcu(&hard_iface->list);
-	batadv_hardif_put(hard_iface);
-	batadv_hardif_generation++;
-
 	batadv_info(hard_iface->mesh_iface, "Removing interface: %s\n",
 		    hard_iface->net_dev->name);
 	dev_remove_pack(&hard_iface->batman_adv_ptype);
@@ -905,8 +896,8 @@ void batadv_hardif_disable_interface(struct batadv_hard_iface *hard_iface)
 	/* delete all references to this hard_iface */
 	batadv_purge_orig_ref(bat_priv);
 	batadv_purge_outstanding_packets(bat_priv, hard_iface);
-	netdev_put(hard_iface->mesh_iface, &hard_iface->meshif_dev_tracker);
 
+	batadv_hardif_generation++;
 	netdev_upper_dev_unlink(hard_iface->net_dev, hard_iface->mesh_iface);
 	batadv_hardif_recalc_extra_skbroom(hard_iface->mesh_iface);
 
@@ -914,7 +905,6 @@ void batadv_hardif_disable_interface(struct batadv_hard_iface *hard_iface)
 	if (batadv_hardif_cnt(hard_iface->mesh_iface) <= 1)
 		batadv_gw_check_client_stop(bat_priv);
 
-	hard_iface->mesh_iface = NULL;
 	batadv_hardif_put(hard_iface);
 
 out:
diff --git a/net/batman-adv/hard-interface.h b/net/batman-adv/hard-interface.h
index 6d72dbdd..aa9275de 100644
--- a/net/batman-adv/hard-interface.h
+++ b/net/batman-adv/hard-interface.h
@@ -74,7 +74,7 @@ u32 batadv_netdev_get_wifi_flags(struct net_device *net_dev);
 u32 batadv_hardif_get_wifi_flags(struct batadv_hard_iface *hard_iface);
 bool batadv_is_wifi_hardif(struct batadv_hard_iface *hard_iface);
 struct batadv_hard_iface*
-batadv_hardif_get_by_netdev(const struct net_device *net_dev);
+batadv_hardif_get_by_netdev(struct net_device *net_dev);
 int batadv_hardif_enable_interface(struct net_device *net_dev,
 				   struct net_device *mesh_iface);
 void batadv_hardif_disable_interface(struct batadv_hard_iface *hard_iface);
diff --git a/net/batman-adv/main.c b/net/batman-adv/main.c
index 3c457228..1d82f3a8 100644
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
index e3d47f3e..c1e8a074 100644
--- a/net/batman-adv/netlink.c
+++ b/net/batman-adv/netlink.c
@@ -1211,7 +1211,9 @@ batadv_netlink_get_hardif_from_ifindex(struct batadv_priv *bat_priv,
 	if (!hard_dev)
 		return ERR_PTR(-ENODEV);
 
+	rtnl_lock();
 	hard_iface = batadv_hardif_get_by_netdev(hard_dev);
+	rtnl_unlock();
 	if (!hard_iface)
 		goto err_put_harddev;
 
diff --git a/net/batman-adv/types.h b/net/batman-adv/types.h
index 5fd5bd35..5886b579 100644
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

