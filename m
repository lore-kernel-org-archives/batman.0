Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DAB8C282DE
	for <batman-adv@archiver.kernel.org>; Thu, 13 Mar 2025 16:47:12 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id A0739844E2
	for <batman-adv@archiver.kernel.org>; Thu, 13 Mar 2025 17:47:10 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1741884430;
 b=YwQd1PmVORIFzFM/F4eAd2KgwXU2yE8eoF7M0ZzJplrjrDkj1HWgQGuSZZkqXj0Ga/+yp
 9HoQ3cc9KybFhivHd/I1JB/vLDa9GxRwRwV+ZdP5naUyK+tZGmuVX3cc83Pjwx7Nl6dVT0O
 M9ZLoCsUfdcc7pxFGbioFNO6fBcpcWc=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1741884430; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=iFA/jPobiVyNHj+XIyZ2cwhH88TrFzHvAIspawbEQ7A=;
 b=XvnxqayX2Tt4oTC9rTwqDBTbctvZRqnIB3t6dtBD0w0wTsVFLHkQFZAVEDc+PcZPOfpCX
 olFeUxPmJqXaehKNKIUZc5OVy00auCxc8FAPCAZZdDrnRxjhRKlG3Eb6YGwVYtSzmdASS6a
 c6bNKP2rCcYhRc6Ne1yuINrPS2xqwCE=
ARC-Authentication-Results: i=2; open-mesh.org; dkim=fail;
  arc=pass;
  dmarc=fail (Used From Domain Record) header.from=simonwunderlich.de
 policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=fail; arc=pass;
 dmarc=fail (Used From Domain Record) header.from=simonwunderlich.de
 policy.dmarc=none
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de
 [IPv6:2a01:4f8:c17:e8c0::1])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id C62AE841C9
	for <b.a.t.m.a.n@lists.open-mesh.org>; Thu, 13 Mar 2025 17:45:25 +0100 (CET)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1741884325;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iFA/jPobiVyNHj+XIyZ2cwhH88TrFzHvAIspawbEQ7A=;
	b=zqg4fVupWqucgHYICW4fLXlVXpyvzhi/lCuJNrfzU3K7l0KEG67sVHWSB9SUs5Xmr6bAPU
	O7eUb+7wv222IIwLOGyoMy4S6/cdk96AX+xPq+YzRPyT4tdlJ3MpmEuNZhR/zrHX60IA7V
	f+SCMIvPniFKfCDNtd7RoovMx3I6bek=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=none;
	dmarc=pass (policy=none) header.from=simonwunderlich.de;
	spf=pass (diktynna.open-mesh.org: domain of sw@simonwunderlich.de designates
 2a01:4f8:c17:e8c0::1 as permitted sender) smtp.mailfrom=sw@simonwunderlich.de
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1741884325; a=rsa-sha256;
	cv=none;
	b=HzAn/G9Q6QrS4aJ/A+QzbKinGubDN8JzSPFNX7Cy1gvTR0k+XJ9kY6w9bU2qodoQcTXm44
	xQ482LtJq0C8xW+D5UNKRHCz9rJDkSDoPjs7h7OmqbqFNQQtFxQgb9x0FYYsRuQzl3YqIK
	LGthGEl+9PvL6WW39B033DX67Q5ZWjU=
Received: from kero.packetmixer.de
 (p200300fA272413901A38A4BC9c0De305.dip0.t-ipconnect.de
 [IPv6:2003:fa:2724:1390:1a38:a4bc:9c0d:e305])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits)
 server-digest SHA256)
	(No client certificate requested)
	by mail.simonwunderlich.de (Postfix) with ESMTPSA id 475B7FA1ED;
	Thu, 13 Mar 2025 17:45:25 +0100 (CET)
From: Simon Wunderlich <sw@simonwunderlich.de>
To: kuba@kernel.org,
	davem@davemloft.net
Cc: netdev@vger.kernel.org,
	b.a.t.m.a.n@lists.open-mesh.org,
	Eric Dumazet <edumazet@google.com>,
	Sven Eckelmann <sven@narfation.org>,
	Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH 03/10] batman-adv: adopt netdev_hold() / netdev_put()
Date: Thu, 13 Mar 2025 17:45:12 +0100
Message-Id: <20250313164519.72808-4-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250313164519.72808-1-sw@simonwunderlich.de>
References: <20250313164519.72808-1-sw@simonwunderlich.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: S4SC667PHIJWDO6EN7BYH5AYIXL533RR
X-Message-ID-Hash: S4SC667PHIJWDO6EN7BYH5AYIXL533RR
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/S4SC667PHIJWDO6EN7BYH5AYIXL533RR/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

From: Eric Dumazet <edumazet@google.com>

Add a device tracker to struct batadv_hard_iface to help
debugging of network device refcount imbalances.

Signed-off-by: Eric Dumazet <edumazet@google.com>
[sven@narfation.org: fix kernel-doc, adopt for softif reference]
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/hard-interface.c | 20 ++++++++------------
 net/batman-adv/types.h          |  6 ++++++
 2 files changed, 14 insertions(+), 12 deletions(-)

diff --git a/net/batman-adv/hard-interface.c b/net/batman-adv/hard-interface.c
index 96a412beab2d..71b2236c0058 100644
--- a/net/batman-adv/hard-interface.c
+++ b/net/batman-adv/hard-interface.c
@@ -51,7 +51,7 @@ void batadv_hardif_release(struct kref *ref)
 	struct batadv_hard_iface *hard_iface;
 
 	hard_iface = container_of(ref, struct batadv_hard_iface, refcount);
-	dev_put(hard_iface->net_dev);
+	netdev_put(hard_iface->net_dev, &hard_iface->dev_tracker);
 
 	kfree_rcu(hard_iface, rcu);
 }
@@ -728,6 +728,7 @@ int batadv_hardif_enable_interface(struct batadv_hard_iface *hard_iface,
 	kref_get(&hard_iface->refcount);
 
 	dev_hold(soft_iface);
+	netdev_hold(soft_iface, &hard_iface->softif_dev_tracker, GFP_ATOMIC);
 	hard_iface->soft_iface = soft_iface;
 	bat_priv = netdev_priv(hard_iface->soft_iface);
 
@@ -784,7 +785,7 @@ int batadv_hardif_enable_interface(struct batadv_hard_iface *hard_iface,
 	netdev_upper_dev_unlink(hard_iface->net_dev, soft_iface);
 err_dev:
 	hard_iface->soft_iface = NULL;
-	dev_put(soft_iface);
+	netdev_put(soft_iface, &hard_iface->softif_dev_tracker);
 	batadv_hardif_put(hard_iface);
 	return ret;
 }
@@ -851,7 +852,7 @@ void batadv_hardif_disable_interface(struct batadv_hard_iface *hard_iface)
 	/* delete all references to this hard_iface */
 	batadv_purge_orig_ref(bat_priv);
 	batadv_purge_outstanding_packets(bat_priv, hard_iface);
-	dev_put(hard_iface->soft_iface);
+	netdev_put(hard_iface->soft_iface, &hard_iface->softif_dev_tracker);
 
 	netdev_upper_dev_unlink(hard_iface->net_dev, hard_iface->soft_iface);
 	batadv_hardif_recalc_extra_skbroom(hard_iface->soft_iface);
@@ -875,15 +876,15 @@ batadv_hardif_add_interface(struct net_device *net_dev)
 	ASSERT_RTNL();
 
 	if (!batadv_is_valid_iface(net_dev))
-		goto out;
-
-	dev_hold(net_dev);
+		return NULL;
 
 	hard_iface = kzalloc(sizeof(*hard_iface), GFP_ATOMIC);
 	if (!hard_iface)
-		goto release_dev;
+		return NULL;
 
+	netdev_hold(net_dev, &hard_iface->dev_tracker, GFP_ATOMIC);
 	hard_iface->net_dev = net_dev;
+
 	hard_iface->soft_iface = NULL;
 	hard_iface->if_status = BATADV_IF_NOT_IN_USE;
 
@@ -909,11 +910,6 @@ batadv_hardif_add_interface(struct net_device *net_dev)
 	batadv_hardif_generation++;
 
 	return hard_iface;
-
-release_dev:
-	dev_put(net_dev);
-out:
-	return NULL;
 }
 
 static void batadv_hardif_remove_interface(struct batadv_hard_iface *hard_iface)
diff --git a/net/batman-adv/types.h b/net/batman-adv/types.h
index 64a0cf4257ed..b3b4f71f6dec 100644
--- a/net/batman-adv/types.h
+++ b/net/batman-adv/types.h
@@ -186,6 +186,9 @@ struct batadv_hard_iface {
 	/** @net_dev: pointer to the net_device */
 	struct net_device *net_dev;
 
+	/** @dev_tracker: device tracker for @net_dev */
+	netdevice_tracker dev_tracker;
+
 	/** @refcount: number of contexts the object is used */
 	struct kref refcount;
 
@@ -201,6 +204,9 @@ struct batadv_hard_iface {
 	 */
 	struct net_device *soft_iface;
 
+	/** @softif_dev_tracker: device tracker for @soft_iface */
+	netdevice_tracker softif_dev_tracker;
+
 	/** @rcu: struct used for freeing in an RCU-safe manner */
 	struct rcu_head rcu;
 
-- 
2.39.5

