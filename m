Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0210C3ABC3
	for <batman-adv@archiver.kernel.org>; Fri,  9 May 2025 09:04:09 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 4192684B24
	for <batman-adv@archiver.kernel.org>; Fri,  9 May 2025 11:04:08 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1746781448;
 b=rBdOmOrz26bBtwZKJg2SVLsCZzT61ibsYv2joV0OLMFpgS/yVOw/oXTLCYCk+2UalPdHr
 7iC+U8XgJoV+XtfFmAp4lf/1cnFr3dS/xkl0ZBsVDavqFt9xKTxJfszJwIj+vv/kghtQrGW
 77lo8LgcZ6g+pwjQ1Q5XWfnVyD89gAQ=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1746781448; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=DKrW0PehhvkuO4I9VLjYXKtzT1HM2FynPiZPTJN8kUQ=;
 b=fYlu4YIa059qa/PCIvNH16fhD66qR1YLyzN+ahBmNFgrz9Y1Tv4/9Q7qFwQkkttnsR69c
 xbHz2vkJwfSDWg3xLJcnjVrU3rAem2xrBlkmLPTXkXobvegYa30zC1m9owoC65FfkkQH+zf
 MpYpadf4hzMQ0h2X+/dZmLR/kQIXS9o=
ARC-Authentication-Results: i=2; open-mesh.org; dkim=fail;
  arc=pass;
  dmarc=fail (Used From Domain Record) header.from=simonwunderlich.de
 policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=fail; arc=pass;
 dmarc=fail (Used From Domain Record) header.from=simonwunderlich.de
 policy.dmarc=none
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de
 [IPv6:2a01:4f8:c17:e8c0::1])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 077D6844FF
	for <b.a.t.m.a.n@lists.open-mesh.org>; Fri,  9 May 2025 11:02:51 +0200 (CEST)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1746781382;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DKrW0PehhvkuO4I9VLjYXKtzT1HM2FynPiZPTJN8kUQ=;
	b=Nm06twqjV6TO3dOzOvzOGxTuMRs6oFQ0EU5ytuk/T+W70xZH5A0i5xvzQkKePcbIGT0SNh
	X4ZJwOTOrghGKxoas3avU2VYI01FWiga+zw3IBBuHzmtl0oePz76quIIqZYsnLBcss1iKG
	m/DXGL0vxIRnN0+MhZ501CTVlWHA2Fw=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=none;
	spf=pass (diktynna.open-mesh.org: domain of sw@simonwunderlich.de designates
 2a01:4f8:c17:e8c0::1 as permitted sender)
 smtp.mailfrom=sw@simonwunderlich.de;
	dmarc=pass (policy=none) header.from=simonwunderlich.de
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1746781382; a=rsa-sha256;
	cv=none;
	b=fTMetukWFzLVqiaOhGgl1XeuHdjiTW1Ho1fQHYpCxzhmj0GCIVppEjGjJxDp2ZrRwjXGcu
	EiOWVrhX+Dwu+YMNvKb3Vth84LNQxxs+WqOK75WOsb4Ygf7ps2cIAO7Au+5j4J2wfnB7C+
	tB0opk/52PJWoSiXjaU1psm0IdJQ00k=
Received: from kero.packetmixer.de
 (p200300C59736C7d829705D90aB67a755.dip0.t-ipconnect.de
 [IPv6:2003:c5:9736:c7d8:2970:5d90:ab67:a755])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits)
 server-digest SHA256)
	(No client certificate requested)
	by mail.simonwunderlich.de (Postfix) with ESMTPSA id 5A8AAFA132;
	Fri,  9 May 2025 11:02:49 +0200 (CEST)
From: Simon Wunderlich <sw@simonwunderlich.de>
To: davem@davemloft.net,
	kuba@kernel.org
Cc: netdev@vger.kernel.org,
	b.a.t.m.a.n@lists.open-mesh.org,
	Matthias Schiffer <mschiffer@universe-factory.net>,
	Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH net 1/1] batman-adv: fix duplicate MAC address check
Date: Fri,  9 May 2025 11:02:40 +0200
Message-Id: <20250509090240.107796-2-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250509090240.107796-1-sw@simonwunderlich.de>
References: <20250509090240.107796-1-sw@simonwunderlich.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: FMF5G22QZVY3GBRFKLURUXYTJND5EVGG
X-Message-ID-Hash: FMF5G22QZVY3GBRFKLURUXYTJND5EVGG
X-MailFrom: sw@simonwunderlich.de
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/FMF5G22QZVY3GBRFKLURUXYTJND5EVGG/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

From: Matthias Schiffer <mschiffer@universe-factory.net>

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
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
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
2.39.5

