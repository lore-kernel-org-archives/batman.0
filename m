Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A41AC43458
	for <batman-adv@archiver.kernel.org>; Wed,  8 Jul 2026 09:24:12 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 08BB0852BD
	for <batman-adv@archiver.kernel.org>; Wed, 08 Jul 2026 11:24:11 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1783502651;
 b=w6pC4BvJlg3zhMC88Xk/j7vSPB50shxVjIwFYMSXqE8tpuQVCGwUOWq4oFSUVB8hN2WDj
 aZgdGBHZQpgBMze0kF4aZ5HMayyTvWFqTea1n6k5PSiFIJXvC/CAF1gq9hR/D+sraXMA8f3
 2WkWe2uas/L2WFVzNQ2VfOguh24E/BM=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1783502651; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=5AMdxW44N2haoNqT9owFcCG9SY8E2sZKqXc4kIUckTo=;
 b=Rr36UwGkKnxkX+b0fudvq1KiaibJZS2ARasP/JEEE/r6hbPDlRv98v34zC5xJHu0FUve9
 w7FNDADMLBrFffxiaAqQdh0EVgMisC9P78cuscgFk8/brGHLrYhlz+CWR435xDuJ83l8yWX
 aWJH/X8lDFMWqQhB8CXdBY3ff3agPYQ=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass header.from=simonwunderlich.de policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=simonwunderlich.de policy.dmarc=none
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de
 [IPv6:2a01:4f8:c17:e8c0::1])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id C7659803D9
	for <b.a.t.m.a.n@lists.open-mesh.org>; Wed, 08 Jul 2026 11:18:40 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1783502325;
	b=uiy4VHkSH3VLo0sA4XucHtpq3uI1kx3/WQtLe//BO9GvMLjUgY4GrFekiM14YaUZ2BtZTn
	CuTeGBM2ryRuTiupy2ekKPEStZiDXWfhGs9bpxhO4doKJvahdkYYGeUUQ4JGjBksbe4RiH
	57cqfrQKF7dKy2ySY1xod2AU01YRyNU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1783502325;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=5AMdxW44N2haoNqT9owFcCG9SY8E2sZKqXc4kIUckTo=;
	b=Yrg8RGVt4EU9mrwGx3Qppy5BaQZ06tkIYX9nI50uDkZlL/AZbgTft0TauHhgnmF9fQEfkh
	UfVuutJVE+30U/II8w62T0xz0I8VMqJwjsX9mvoOAoluw45PHiVWsXcI5LGBF6bmsqheig
	0eBcYN3zyjSsD7XDvPbv4FCCbLzkRVU=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=simonwunderlich.de header.s=09092022 header.b=vtg7s09u;
	spf=pass (diktynna.open-mesh.org: domain of sw@simonwunderlich.de designates
 2a01:4f8:c17:e8c0::1 as permitted sender)
 smtp.mailfrom=sw@simonwunderlich.de;
	dmarc=pass (policy=none) header.from=simonwunderlich.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1783502319;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5AMdxW44N2haoNqT9owFcCG9SY8E2sZKqXc4kIUckTo=;
	b=vtg7s09uKKic1UBT1uzejFiC7QPuFsBbHLSeebTB7+kWaNdQkoqkyLoly26gW2WAGPftda
	+Rai9PCNdEylgOR2YYaQ66PGuhpKj4yYyrV2U4jCKoui1TJSF8T9bwfEFpjvDeVB5tkv0h
	YCcrtw5wSu01TGhXeQxjriKm2rNZJ0JmblcLqKV3pEzPzRZD0760wYtmR+mqt+YPcMoz4H
	S9+CMxSzDi7q/nRhhGkCtA5/9QR8o3e7zy7CCqIFEHs8JlIZM2k2561wuFHgPa3GTVMnER
	ZYvvXdVty836cjlWd8o7LspXRqXVhDmMDxWmtPcGqsVijltodXx02QSre/4QoA==
From: Simon Wunderlich <sw@simonwunderlich.de>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	b.a.t.m.a.n@lists.open-mesh.org,
	Sven Eckelmann <sven@narfation.org>,
	stable@vger.kernel.org,
	Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH net 3/9] batman-adv: clean untagged VLAN on netdev
 registration failure
Date: Wed,  8 Jul 2026 11:18:15 +0200
Message-ID: <20260708091821.314516-4-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260708091821.314516-1-sw@simonwunderlich.de>
References: <20260708091821.314516-1-sw@simonwunderlich.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: O7IOEH6O3P63S67BEI7MN6A7DY7HBYPO
X-Message-ID-Hash: O7IOEH6O3P63S67BEI7MN6A7DY7HBYPO
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/O7IOEH6O3P63S67BEI7MN6A7DY7HBYPO/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

From: Sven Eckelmann <sven@narfation.org>

When an mesh interface is registered, it creates an untagged struct
batadv_meshif_vlan on top of it via the NETDEV_REGISTER notifier. But in
this process, another receiver of this notification can veto the
registration. The netdev registration will be aborted because of this veto.

The register_netdevice() call will try to clean up the net_device using
unregister_netdevice_queue() - which only uses the .priv_destructor to
free private resources. In this situation, .dellink will not be called.

The cleanup of the untagged batadv_meshif_vlan must thefore be done in the
destructor to avoid a leak of this object.

Cc: stable@vger.kernel.org
Fixes: 5d2c05b21337 ("batman-adv: add per VLAN interface attribute framework")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/main.c           |  8 ++++++++
 net/batman-adv/mesh-interface.c | 13 ++-----------
 net/batman-adv/mesh-interface.h |  2 ++
 3 files changed, 12 insertions(+), 11 deletions(-)

diff --git a/net/batman-adv/main.c b/net/batman-adv/main.c
index 8844e40e6a803..67bed3ee77e7e 100644
--- a/net/batman-adv/main.c
+++ b/net/batman-adv/main.c
@@ -259,6 +259,7 @@ int batadv_mesh_init(struct net_device *mesh_iface)
 void batadv_mesh_free(struct net_device *mesh_iface)
 {
 	struct batadv_priv *bat_priv = netdev_priv(mesh_iface);
+	struct batadv_meshif_vlan *vlan;
 
 	WRITE_ONCE(bat_priv->mesh_state, BATADV_MESH_DEACTIVATING);
 
@@ -273,6 +274,13 @@ void batadv_mesh_free(struct net_device *mesh_iface)
 
 	batadv_mcast_free(bat_priv);
 
+	/* destroy the "untagged" VLAN */
+	vlan = batadv_meshif_vlan_get(bat_priv, BATADV_NO_FLAGS);
+	if (vlan) {
+		batadv_meshif_destroy_vlan(bat_priv, vlan);
+		batadv_meshif_vlan_put(vlan);
+	}
+
 	/* Free the TT and the originator tables only after having terminated
 	 * all the other depending components which may use these structures for
 	 * their purposes.
diff --git a/net/batman-adv/mesh-interface.c b/net/batman-adv/mesh-interface.c
index 0b75234521b63..fbfd99268de47 100644
--- a/net/batman-adv/mesh-interface.c
+++ b/net/batman-adv/mesh-interface.c
@@ -595,8 +595,8 @@ int batadv_meshif_create_vlan(struct batadv_priv *bat_priv, unsigned short vid)
  * @bat_priv: the bat priv with all the mesh interface information
  * @vlan: the object to remove
  */
-static void batadv_meshif_destroy_vlan(struct batadv_priv *bat_priv,
-				       struct batadv_meshif_vlan *vlan)
+void batadv_meshif_destroy_vlan(struct batadv_priv *bat_priv,
+				struct batadv_meshif_vlan *vlan)
 {
 	/* explicitly remove the associated TT local entry because it is marked
 	 * with the NOPURGE flag
@@ -1091,22 +1091,13 @@ static int batadv_meshif_newlink(struct net_device *dev,
 static void batadv_meshif_destroy_netlink(struct net_device *mesh_iface,
 					  struct list_head *head)
 {
-	struct batadv_priv *bat_priv = netdev_priv(mesh_iface);
 	struct batadv_hard_iface *hard_iface;
-	struct batadv_meshif_vlan *vlan;
 
 	while (!list_empty(&mesh_iface->adj_list.lower)) {
 		hard_iface = netdev_adjacent_get_private(mesh_iface->adj_list.lower.next);
 		batadv_hardif_disable_interface(hard_iface);
 	}
 
-	/* destroy the "untagged" VLAN */
-	vlan = batadv_meshif_vlan_get(bat_priv, BATADV_NO_FLAGS);
-	if (vlan) {
-		batadv_meshif_destroy_vlan(bat_priv, vlan);
-		batadv_meshif_vlan_put(vlan);
-	}
-
 	unregister_netdevice_queue(mesh_iface, head);
 }
 
diff --git a/net/batman-adv/mesh-interface.h b/net/batman-adv/mesh-interface.h
index 53756c5a45e04..5e1e83e04ffbc 100644
--- a/net/batman-adv/mesh-interface.h
+++ b/net/batman-adv/mesh-interface.h
@@ -21,6 +21,8 @@ void batadv_interface_rx(struct net_device *mesh_iface,
 bool batadv_meshif_is_valid(const struct net_device *net_dev);
 extern struct rtnl_link_ops batadv_link_ops;
 int batadv_meshif_create_vlan(struct batadv_priv *bat_priv, unsigned short vid);
+void batadv_meshif_destroy_vlan(struct batadv_priv *bat_priv,
+				struct batadv_meshif_vlan *vlan);
 void batadv_meshif_vlan_release(struct kref *ref);
 struct batadv_meshif_vlan *batadv_meshif_vlan_get(struct batadv_priv *bat_priv,
 						  unsigned short vid);
-- 
2.47.3

