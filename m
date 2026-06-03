Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5E00CD6E4A
	for <batman-adv@archiver.kernel.org>; Wed,  3 Jun 2026 07:36:58 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 8172E805A3
	for <batman-adv@archiver.kernel.org>; Wed, 03 Jun 2026 09:36:57 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1780472217;
 b=3uqZst8A/V7rbjxO9HSGH9pv5uTSvL2ilIRmxlSIgc/bvUqwiop4eppj8NcnRRJHBiZaP
 KGeAxh/CAf3ltU8GEr7LqPK/hPuQn9vI++UyapcgScC7R/Hg/HMHJS0w5NW+ijscwDSuUMR
 9rnMSGqg74eMvj6+pa+e8VieJntwT94=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1780472217; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=he0/n/acgmP1vB/t/w0LP0oXotNGkr4FL/Cuc2RofVQ=;
 b=UBB0odrpwF98v3xjs0NDi5uAJ1OmuIzScuTZtnIxmaO+w3pASw2Yvfg6Kjl96hbPabRTF
 2wMz7fIV1c/81WasCFJue6cU5C8Iz+Br+Rcv2LG8ysHqumJWBEEI0AmyNNt/INkUEXi/73r
 ZATfNetDxGu082kAfBd6kerNfSWWnpE=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass header.from=simonwunderlich.de policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=simonwunderlich.de policy.dmarc=none
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de
 [IPv6:2a01:4f8:c17:e8c0::1])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id F1614846C2
	for <b.a.t.m.a.n@lists.open-mesh.org>; Wed, 03 Jun 2026 09:25:39 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1780471540;
	b=IoeeCC3xG7bpO7bLb12IFH0UDgnWk/DnPZnRsZxEff+notzBBsMxJgjbKYFBvaS4iRLO3m
	4Qmm+QdPDV5fD5VtmGx4IhIM0C+0upEtEUaKBJvW5wxguglqVtBoyvp62MuXGt9WqZIb5w
	jUn6rirbjoPIa2tBaxENgIsc+v9z2Hk=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=simonwunderlich.de header.s=09092022 header.b=a9j9pyXT;
	spf=pass (diktynna.open-mesh.org: domain of sw@simonwunderlich.de designates
 2a01:4f8:c17:e8c0::1 as permitted sender)
 smtp.mailfrom=sw@simonwunderlich.de;
	dmarc=pass (policy=none) header.from=simonwunderlich.de
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1780471540;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=he0/n/acgmP1vB/t/w0LP0oXotNGkr4FL/Cuc2RofVQ=;
	b=TBMr1ADzP/c9msxWvmmFXb1ipLMm0anKs8BrwUPcqEwFAR8tbsHLfQ17RBsO/A26OkoP+a
	wS0ZeQSzAQobBNaN5R9ueNv9B6TXvCP81deJiT2sOJL5vPx7wLoFyveMKxdO9khJmEqS2+
	+8+c+BJy+h5d1JYv4b7FnP9YV4qp9BI=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1780471539;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=he0/n/acgmP1vB/t/w0LP0oXotNGkr4FL/Cuc2RofVQ=;
	b=a9j9pyXTUKQkbPU7aduarieiA3jnA9aDiRznBp9lT+pmmLPr5t2jc2FCsJyUIupP4aJUqr
	9kz8k8pPfdKUQCh5hN4AUwTkuDF7ipsk8/P8AajBUgTCsVvERTxKXIsapkcQMm3jYgYUic
	xl2n/LwOo4u3Yd81eU1TgZRW6YtHBWY+fsNg6VpAlTRziDHmqpSGaO/Sfr4E07CMwPBtS9
	R//G1kL69lUArE11LSpK7mLuCTpFAV6r3jDTsque/Yv6+HO4P4GLppsWfyzOBuRFG2Ynep
	HBRApSK7agZK8It4OIGhlP0YTP6r0qtZYd5G73jWTj1el6KBmHj/z/ue/dlIQg==
From: Simon Wunderlich <sw@simonwunderlich.de>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	b.a.t.m.a.n@lists.open-mesh.org,
	Sven Eckelmann <sven@narfation.org>,
	Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH net-next 15/15] batman-adv: tt: directly retrieve wifi flags
 of net_device
Date: Wed,  3 Jun 2026 09:25:26 +0200
Message-ID: <20260603072527.174487-16-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260603072527.174487-1-sw@simonwunderlich.de>
References: <20260603072527.174487-1-sw@simonwunderlich.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: RVQOFLLEOGHS43NXL7PVQUDNLOSKWZJ3
X-Message-ID-Hash: RVQOFLLEOGHS43NXL7PVQUDNLOSKWZJ3
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/RVQOFLLEOGHS43NXL7PVQUDNLOSKWZJ3/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

From: Sven Eckelmann <sven@narfation.org>

batadv_tt_local_add() tries to retrieve the wifi flags of an interface to
mark the TT entry as wifi client for the AP isolation feature. In the past,
it was necessary to look up the batadv_hard_iface because the wifi_flags
were stored inside this struct. But with the batadv_wifi_net_devices
rhashtable, it is preferred to directly retrieve the wifi_flags instead of
the indirect route via batadv_hard_iface - which at the end only provides
the net_device (which we used to find the batadv_hard_iface).

This will also be essential when the global batadv_hardif_list is removed
and each lookup via batadv_hardif_get_by_netdev() will require the RTNL
lock.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/hard-interface.c    | 25 ++++++++++++++++++-------
 net/batman-adv/hard-interface.h    |  1 +
 net/batman-adv/translation-table.c | 14 ++++++++------
 3 files changed, 27 insertions(+), 13 deletions(-)

diff --git a/net/batman-adv/hard-interface.c b/net/batman-adv/hard-interface.c
index bb3c31b5f259d..43ebf86e7b368 100644
--- a/net/batman-adv/hard-interface.c
+++ b/net/batman-adv/hard-interface.c
@@ -366,22 +366,19 @@ static u32 batadv_wifi_flags_evaluate(struct net_device *net_device)
 }
 
 /**
- * batadv_hardif_get_wifi_flags() - retrieve wifi flags for hard_iface
- * @hard_iface: the device to check
+ * batadv_netdev_get_wifi_flags() - retrieve wifi flags for net_device
+ * @net_dev: the device to check
  *
  * Return: batadv_hard_iface_wifi_flags flags of the device
  */
-u32 batadv_hardif_get_wifi_flags(struct batadv_hard_iface *hard_iface)
+u32 batadv_netdev_get_wifi_flags(struct net_device *net_dev)
 {
 	struct batadv_wifi_net_device_state *device_state;
 	u32 wifi_flags = 0;
 
-	if (!hard_iface)
-		return 0;
-
 	rcu_read_lock();
 	device_state = rhashtable_lookup_fast(&batadv_wifi_net_devices,
-					      &hard_iface->net_dev,
+					      &net_dev,
 					      batadv_wifi_net_devices_params);
 	if (device_state)
 		wifi_flags = READ_ONCE(device_state->wifi_flags);
@@ -390,6 +387,20 @@ u32 batadv_hardif_get_wifi_flags(struct batadv_hard_iface *hard_iface)
 	return wifi_flags;
 }
 
+/**
+ * batadv_hardif_get_wifi_flags() - retrieve wifi flags for hard_iface
+ * @hard_iface: the device to check
+ *
+ * Return: batadv_hard_iface_wifi_flags flags of the device
+ */
+u32 batadv_hardif_get_wifi_flags(struct batadv_hard_iface *hard_iface)
+{
+	if (!hard_iface)
+		return 0;
+
+	return batadv_netdev_get_wifi_flags(hard_iface->net_dev);
+}
+
 /**
  * batadv_is_wifi_hardif() - check if the given hardif is a wifi interface
  * @hard_iface: the device to check
diff --git a/net/batman-adv/hard-interface.h b/net/batman-adv/hard-interface.h
index 089e65c8a4817..822e7e378c4d1 100644
--- a/net/batman-adv/hard-interface.h
+++ b/net/batman-adv/hard-interface.h
@@ -70,6 +70,7 @@ extern struct notifier_block batadv_hard_if_notifier;
 
 struct net_device *__batadv_get_real_netdev(struct net_device *net_device);
 struct net_device *batadv_get_real_netdev(struct net_device *net_device);
+u32 batadv_netdev_get_wifi_flags(struct net_device *net_dev);
 u32 batadv_hardif_get_wifi_flags(struct batadv_hard_iface *hard_iface);
 bool batadv_is_wifi_hardif(struct batadv_hard_iface *hard_iface);
 struct batadv_hard_iface*
diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index 44bbaa3bb37d1..c346e43d47b9b 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -596,20 +596,23 @@ bool batadv_tt_local_add(struct net_device *mesh_iface, const u8 *addr,
 	struct net *net = dev_net(mesh_iface);
 	struct batadv_meshif_vlan *vlan;
 	struct net_device *in_dev = NULL;
-	struct batadv_hard_iface *in_hardif = NULL;
 	struct hlist_head *head;
 	struct batadv_tt_orig_list_entry *orig_entry;
 	int hash_added, table_size, packet_size_max;
 	bool ret = false;
 	bool roamed_back = false;
+	bool iif_is_wifi = false;
 	u8 remote_flags;
 	u32 match_mark;
 
 	if (ifindex != BATADV_NULL_IFINDEX)
 		in_dev = dev_get_by_index(net, ifindex);
 
-	if (in_dev)
-		in_hardif = batadv_hardif_get_by_netdev(in_dev);
+	if (in_dev) {
+		u32 wifi_flags = batadv_netdev_get_wifi_flags(in_dev);
+
+		iif_is_wifi = batadv_is_wifi(wifi_flags);
+	}
 
 	tt_local = batadv_tt_local_hash_find(bat_priv, addr, vid);
 
@@ -684,7 +687,7 @@ bool batadv_tt_local_add(struct net_device *mesh_iface, const u8 *addr,
 	 */
 	tt_local->common.flags = BATADV_TT_CLIENT_NEW;
 	tt_local->common.vid = vid;
-	if (batadv_is_wifi_hardif(in_hardif))
+	if (iif_is_wifi)
 		tt_local->common.flags |= BATADV_TT_CLIENT_WIFI;
 	kref_init(&tt_local->common.refcount);
 	tt_local->last_seen = jiffies;
@@ -743,7 +746,7 @@ bool batadv_tt_local_add(struct net_device *mesh_iface, const u8 *addr,
 	 */
 	remote_flags = tt_local->common.flags & BATADV_TT_REMOTE_MASK;
 
-	if (batadv_is_wifi_hardif(in_hardif))
+	if (iif_is_wifi)
 		tt_local->common.flags |= BATADV_TT_CLIENT_WIFI;
 	else
 		tt_local->common.flags &= ~BATADV_TT_CLIENT_WIFI;
@@ -767,7 +770,6 @@ bool batadv_tt_local_add(struct net_device *mesh_iface, const u8 *addr,
 
 	ret = true;
 out:
-	batadv_hardif_put(in_hardif);
 	dev_put(in_dev);
 	batadv_tt_local_entry_put(tt_local);
 	batadv_tt_global_entry_put(tt_global);
-- 
2.47.3

