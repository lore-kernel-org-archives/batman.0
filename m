Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6999AC369BA
	for <batman@archiver.kernel.org>; Wed, 16 Apr 2025 18:38:40 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id A369C849A6
	for <batman@archiver.kernel.org>; Wed, 16 Apr 2025 20:38:38 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1744828718;
 b=JrQJb8/2mdiI4FGyYTuFRAdwVJf5K4OcQZvFS5uO89II7UrXSO0PrR8vPWxlLzWzYtQFR
 wUWciAf5Y3YmLTf/Ys6iUtWQ0sVs+Htxw3FXAPl90+Y69eTdaqlxwmbh97gn+Pi91aH+cuh
 VpvJKlmyf9JijeAcIjcY+usvD85zfW0=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1744828718; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=XJDMhfldMO0Uz3R/dGP3WNaSTXv6Xbup3WKyLVrNux4=;
 b=BP7Z1kITXxvqiba/ZVE8M6wgkvxtiIgtDsLTQ4A/IC2CNHxyVILt16VpsvWsYOU5UGMd+
 8gu65OPzWbxk8ysO9QB0mnP6tXmtyYJbxjjPNG4HopbhSKifNeK2yeZkSaqpQ73MeqBUiYd
 etu949B6HmX6ulF7SbHiwdchPzpEv/Y=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=universe-factory.net;
  arc=pass;
  dmarc=none
Authentication-Results: open-mesh.org;
 dkim=pass header.d=universe-factory.net; arc=pass; dmarc=none
Received: from mail.universe-factory.net (osgiliath.universe-factory.net
 [141.95.161.142])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 6D22984619
	for <b.a.t.m.a.n@lists.open-mesh.org>; Wed, 16 Apr 2025 20:38:22 +0200 (CEST)
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1744828713; a=rsa-sha256;
	cv=none;
	b=BoaNJU2WmG5zui1VO05C6eraqGuq+KSU5z27YeMtbMGSwhPB5y80P4hos0j73dMAkJo+gP
	bHve5foDpL6eVbQ2vPkQo/Ax4/ZEM6kr9gsnpznkcRJUkKt1aL1EuMyo9ZhlfwWs6Ieh7S
	LC/0PXpecYtjEjp05o9+MFtPorHJaIo=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=universe-factory.net header.s=dkim header.b=ozEUG8Vr;
	spf=pass (diktynna.open-mesh.org: domain of mschiffer@universe-factory.net
 designates 141.95.161.142 as permitted sender)
 smtp.mailfrom=mschiffer@universe-factory.net;
	dmarc=pass (policy=reject) header.from=universe-factory.net
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1744828713;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:dkim-signature;
	bh=XJDMhfldMO0Uz3R/dGP3WNaSTXv6Xbup3WKyLVrNux4=;
	b=nXWN2U3z8iMOZjNYfDTeKKu9N7oYXuL4bfif8QC1Fou4G1L3GUrk6p9iY4deR+o/jNcue3
	K75Gowx1/hpm8ZTYlOkmNN4tz1+zkleGqC8jI2oHhqz5eb5UNIDBpxj7jMXpAJuAHjQVEL
	hLOAjzomHCcIe20kgjWGWnlgyE5dKHU=
From: Matthias Schiffer <mschiffer@universe-factory.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=universe-factory.net;
	s=dkim; t=1744828700;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=XJDMhfldMO0Uz3R/dGP3WNaSTXv6Xbup3WKyLVrNux4=;
	b=ozEUG8Vr2QfwYFS+57Y9O4FqUK/BOGKXxyq/rOt5lZ9faT2TiZ7a2d/6UGtkqXJUmgMaI1
	6eQ2VhSY4KeJ1DW/t3zwmXo2rG9ur51Xff01bYip8xRp4Kwu36BqOxZEO34mMR7L3+qG9D
	G2oNytgQb8LUo83t2NMQ7zxHSV6wyufZ6junDEn377pxXa4WgZddpTVQlD5u3rlDvBiu8i
	4vh+XXMlkeT0djG6Ms3UFFFNdFxD+QfHzT5cgCjtLuV4ka27tJ9QQcAps+Ux4ouuJs4Fz1
	wMSAJ43F+60H1VV2I4icLvMNHVaBcOh6NcUsY5pPcmDs3GdpZ9UBHVLz+GeqEQ==
To: Marek Lindner <marek.lindner@mailbox.org>,
	Simon Wunderlich <sw@simonwunderlich.de>,
	Antonio Quartulli <antonio@mandelbit.com>,
	Sven Eckelmann <sven@narfation.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	b.a.t.m.a.n@lists.open-mesh.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Matthias Schiffer <mschiffer@universe-factory.net>
Subject: [PATCH batadv stable v2] batman-adv: fix duplicate MAC address check
Date: Wed, 16 Apr 2025 20:37:56 +0200
Message-ID: 
 <0a3f663c380e8371932cbf157cde18f8ff93c400.1744449181.git.mschiffer@universe-factory.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: -
Message-ID-Hash: AV5H5JUP277NQZ5JLJGFBPK73GFKR6K4
X-Message-ID-Hash: AV5H5JUP277NQZ5JLJGFBPK73GFKR6K4
X-MailFrom: mschiffer@universe-factory.net
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/AV5H5JUP277NQZ5JLJGFBPK73GFKR6K4/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

batadv_check_known_mac_addr() is both too lenient and too strict:

- It is called from batadv_hardif_add_interface(), which means that it
  checked interfaces that are not used for batman-adv at all. Move it
  to batadv_hardif_enable_interface(). Also, restrict it to hardifs of
  the same mesh interface; different mesh interfaces should not interact
  at all. The batadv_check_known_mac_addr() argument is changed from
  `struct net_device` to `struct batadv_hard_iface` to achieve this.
- The check only cares about hardifs in BATADV_IF_ACTIVE and
  BATADV_IF_TO_BE_ACTIVATED states, but interfaces in BATADV_IF_INACTIVE
  state should be checked as well, or the following steps will not
  result in a warning then they should:

  - Add two interfaces in down state with different MAC addresses to
    a mesh as hardifs
  - Change the MAC addresses so they conflict
  - Set interfaces to up state

  Now there will be two active hardifs with the same MAC address, but no
  warning. Fix by only ignoring hardifs in BATADV_IF_NOT_IN_USE state.

The RCU lock can be dropped, as we're holding RTNL anyways when the
function is called.

Fixes: c6c8fea29769 ("net: Add batman-adv meshing protocol")
Signed-off-by: Matthias Schiffer <mschiffer@universe-factory.net>
---
v2: do not change pr_warn to netdev_warn in the patch for stable

 net/batman-adv/hard-interface.c | 31 ++++++++++++++++++-------------
 1 file changed, 18 insertions(+), 13 deletions(-)

diff --git a/net/batman-adv/hard-interface.c b/net/batman-adv/hard-interface.c
index f145f9662653..d099434d3dfa 100644
--- a/net/batman-adv/hard-interface.c
+++ b/net/batman-adv/hard-interface.c
@@ -506,28 +506,32 @@ batadv_hardif_is_iface_up(const struct batadv_hard_iface *hard_iface)
 	return false;
 }
 
-static void batadv_check_known_mac_addr(const struct net_device *net_dev)
+static void batadv_check_known_mac_addr(const struct batadv_hard_iface *hard_iface)
 {
-	const struct batadv_hard_iface *hard_iface;
+	const struct net_device *mesh_iface = hard_iface->mesh_iface;
+	const struct batadv_hard_iface *tmp_hard_iface;
 
-	rcu_read_lock();
-	list_for_each_entry_rcu(hard_iface, &batadv_hardif_list, list) {
-		if (hard_iface->if_status != BATADV_IF_ACTIVE &&
-		    hard_iface->if_status != BATADV_IF_TO_BE_ACTIVATED)
+	if (!mesh_iface)
+		return;
+
+	list_for_each_entry(tmp_hard_iface, &batadv_hardif_list, list) {
+		if (tmp_hard_iface == hard_iface)
+			continue;
+
+		if (tmp_hard_iface->mesh_iface != mesh_iface)
 			continue;
 
-		if (hard_iface->net_dev == net_dev)
+		if (tmp_hard_iface->if_status == BATADV_IF_NOT_IN_USE)
 			continue;
 
-		if (!batadv_compare_eth(hard_iface->net_dev->dev_addr,
-					net_dev->dev_addr))
+		if (!batadv_compare_eth(tmp_hard_iface->net_dev->dev_addr,
+					hard_iface->net_dev->dev_addr))
 			continue;
 
 		pr_warn("The newly added mac address (%pM) already exists on: %s\n",
-			net_dev->dev_addr, hard_iface->net_dev->name);
+			hard_iface->net_dev->dev_addr, tmp_hard_iface->net_dev->name);
 		pr_warn("It is strongly recommended to keep mac addresses unique to avoid problems!\n");
 	}
-	rcu_read_unlock();
 }
 
 /**
@@ -764,6 +768,8 @@ int batadv_hardif_enable_interface(struct batadv_hard_iface *hard_iface,
 			    hard_iface->net_dev->name, hardif_mtu,
 			    required_mtu);
 
+	batadv_check_known_mac_addr(hard_iface);
+
 	if (batadv_hardif_is_iface_up(hard_iface))
 		batadv_hardif_activate_interface(hard_iface);
 	else
@@ -902,7 +908,6 @@ batadv_hardif_add_interface(struct net_device *net_dev)
 
 	batadv_v_hardif_init(hard_iface);
 
-	batadv_check_known_mac_addr(hard_iface->net_dev);
 	kref_get(&hard_iface->refcount);
 	list_add_tail_rcu(&hard_iface->list, &batadv_hardif_list);
 	batadv_hardif_generation++;
@@ -989,7 +994,7 @@ static int batadv_hard_if_event(struct notifier_block *this,
 		if (hard_iface->if_status == BATADV_IF_NOT_IN_USE)
 			goto hardif_put;
 
-		batadv_check_known_mac_addr(hard_iface->net_dev);
+		batadv_check_known_mac_addr(hard_iface);
 
 		bat_priv = netdev_priv(hard_iface->mesh_iface);
 		bat_priv->algo_ops->iface.update_mac(hard_iface);
-- 
2.49.0

