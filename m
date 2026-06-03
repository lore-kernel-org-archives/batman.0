Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 814E9CD6E55
	for <batman-adv@archiver.kernel.org>; Wed,  3 Jun 2026 04:31:28 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 1F248847E5
	for <batman-adv@archiver.kernel.org>; Wed, 03 Jun 2026 06:31:27 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1780461087;
 b=EsZtVWOwHGDReyrhwMFUqEblHkJxv69Gb39gFQfR9CjRge+tMU1O7RDEwvFH60wLMpkJV
 i8J/aYG8S4PDPRVOedP1KtiYZ/lui7v3pNUim4LczsJYlOwFzsVHee41xNeRyW2aWpZo2ca
 Z9Zas2EIbfMVUzWqvddL+1o84D2x/qI=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1780461087; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=nn6HCm+YCyiQ5wwCF2uOPCGFHostG0rwd8bZAScBIfI=;
 b=YEczti2jgSYPomKMxY5xTkAGVDvUDJClZjsVDXQn6QsWBYm3IgTSM3rV7sMn3P7wqWcwx
 UpS8YXok5vwBKWiNWQnWJFWqOti88bBOYJ7Rcas6VL484idFnqqdM41arZHC4rqq02rH8/C
 voHk6esHoPJtnuDJlKN6WnaL+IiBVsE=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org
 [IPv6:2a00:17d8:100::8b1])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 7673684A68
	for <b.a.t.m.a.n@lists.open-mesh.org>; Wed, 03 Jun 2026 06:29:13 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1780460953;
	b=EqcNImqtXw5brv6YGX0w1qX+0ldkZCMgR/jjL915RJk98xjT53ljPh1WJSZ8XrmuRnBWLf
	4A+O0E54P8OtDrqyzYV2jNeux1K7gH80cP49aZ5KV4kv+w102o4lEX6t7DJ7VbNDH47X0n
	43kGphuiYpPAxvlYbNZSJC1dXf4ckiM=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=TytzyS1L;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1780460953;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=nn6HCm+YCyiQ5wwCF2uOPCGFHostG0rwd8bZAScBIfI=;
	b=XRqVpLSfQjpglPxvErU7eYfF9wLmoELHVN0+nbNgArMVXAK/WbsC4NlxWu5XH7Mgct9yy+
	JSI4M8ai5I8j+m+2IYl7mWbSZvHSGThNAIkQHeY7UhufcGIWinu5PUFItIakuNOFF+4eWa
	Ra+qIkXmcgr5ieqwo28GyZbRYyrHN4g=
Received: by dvalin.narfation.org (Postfix) id 32857201A1;
	Wed, 03 Jun 2026 04:29:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1780460953;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nn6HCm+YCyiQ5wwCF2uOPCGFHostG0rwd8bZAScBIfI=;
	b=TytzyS1LBeRknEguXLV0eaq3Gur5ElCxTQIqw2fLhz+pHHRfBBOtmJgfsswqT9d78Vs60u
	+xXNi7JnkK7yGCpnZGwt2lj6iDBVScxrmSVmaqMqBQn6SmNYtXRFApctUbLcpkcWnW22JR
	0Av+Rc3/NnqV6053PunnIMpBPaAYv8g=
From: Sven Eckelmann <sven@narfation.org>
Date: Wed, 03 Jun 2026 06:29:00 +0200
Subject: [PATCH batadv v2 1/5] batman-adv: tt: directly retrieve wifi flags
 of net_device
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260603-drop-hardif-list-v2-1-5f79821ca333@narfation.org>
References: <20260603-drop-hardif-list-v2-0-5f79821ca333@narfation.org>
In-Reply-To: <20260603-drop-hardif-list-v2-0-5f79821ca333@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5357; i=sven@narfation.org;
 h=from:subject:message-id; bh=G0KTDTFY8WrkfqdS+onHujAH57emobQHWOH4LjNexGU=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFnya6fwvrpwsTd3rt1/sY99DFLSv8PPO228dP7Vpk+9M
 yL476nP7ihlYRDjYpAVU2TZcyX//Gb2t/Kfp308CjOHlQlkCAMXpwBMZBoPw/9wB/6JJ1g83947
 nx3w/t1haV2bVX8XHZ6XufW0ZObiV1ebGRk6K/9+apnYzN/5dDfTwoinh1/KXRc7l6/FsPTNojo
 FxmoWAA==
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: DMI4ZLWSVOB6YQ42WQECNGI4FAAT4BQZ
X-Message-ID-Hash: DMI4ZLWSVOB6YQ42WQECNGI4FAAT4BQZ
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/DMI4ZLWSVOB6YQ42WQECNGI4FAAT4BQZ/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

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
---
 net/batman-adv/hard-interface.c    | 35 +++++++++++++++++++++++------------
 net/batman-adv/hard-interface.h    |  1 +
 net/batman-adv/translation-table.c | 14 ++++++++------
 3 files changed, 32 insertions(+), 18 deletions(-)

diff --git a/net/batman-adv/hard-interface.c b/net/batman-adv/hard-interface.c
index bb3c31b5..c592ff58 100644
--- a/net/batman-adv/hard-interface.c
+++ b/net/batman-adv/hard-interface.c
@@ -365,6 +365,28 @@ static u32 batadv_wifi_flags_evaluate(struct net_device *net_device)
 	return wifi_flags;
 }
 
+/**
+ * batadv_netdev_get_wifi_flags() - retrieve wifi flags for net_device
+ * @net_dev: the device to check
+ *
+ * Return: batadv_hard_iface_wifi_flags flags of the device
+ */
+u32 batadv_netdev_get_wifi_flags(struct net_device *net_dev)
+{
+	struct batadv_wifi_net_device_state *device_state;
+	u32 wifi_flags;
+
+	rcu_read_lock();
+	device_state = rhashtable_lookup_fast(&batadv_wifi_net_devices,
+					      &net_dev,
+					      batadv_wifi_net_devices_params);
+	if (device_state)
+		wifi_flags = READ_ONCE(device_state->wifi_flags);
+	rcu_read_unlock();
+
+	return wifi_flags;
+}
+
 /**
  * batadv_hardif_get_wifi_flags() - retrieve wifi flags for hard_iface
  * @hard_iface: the device to check
@@ -373,21 +395,10 @@ static u32 batadv_wifi_flags_evaluate(struct net_device *net_device)
  */
 u32 batadv_hardif_get_wifi_flags(struct batadv_hard_iface *hard_iface)
 {
-	struct batadv_wifi_net_device_state *device_state;
-	u32 wifi_flags = 0;
-
 	if (!hard_iface)
 		return 0;
 
-	rcu_read_lock();
-	device_state = rhashtable_lookup_fast(&batadv_wifi_net_devices,
-					      &hard_iface->net_dev,
-					      batadv_wifi_net_devices_params);
-	if (device_state)
-		wifi_flags = READ_ONCE(device_state->wifi_flags);
-	rcu_read_unlock();
-
-	return wifi_flags;
+	return batadv_netdev_get_wifi_flags(hard_iface->net_dev);
 }
 
 /**
diff --git a/net/batman-adv/hard-interface.h b/net/batman-adv/hard-interface.h
index 089e65c8..822e7e37 100644
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
index 25acbb34..5e2893f4 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -636,20 +636,23 @@ bool batadv_tt_local_add(struct net_device *mesh_iface, const u8 *addr,
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
 
@@ -724,7 +727,7 @@ bool batadv_tt_local_add(struct net_device *mesh_iface, const u8 *addr,
 	 */
 	tt_local->common.flags = BATADV_TT_CLIENT_NEW;
 	tt_local->common.vid = vid;
-	if (batadv_is_wifi_hardif(in_hardif))
+	if (iif_is_wifi)
 		tt_local->common.flags |= BATADV_TT_CLIENT_WIFI;
 	kref_init(&tt_local->common.refcount);
 	tt_local->last_seen = jiffies;
@@ -783,7 +786,7 @@ bool batadv_tt_local_add(struct net_device *mesh_iface, const u8 *addr,
 	 */
 	remote_flags = tt_local->common.flags & BATADV_TT_REMOTE_MASK;
 
-	if (batadv_is_wifi_hardif(in_hardif))
+	if (iif_is_wifi)
 		tt_local->common.flags |= BATADV_TT_CLIENT_WIFI;
 	else
 		tt_local->common.flags &= ~BATADV_TT_CLIENT_WIFI;
@@ -807,7 +810,6 @@ bool batadv_tt_local_add(struct net_device *mesh_iface, const u8 *addr,
 
 	ret = true;
 out:
-	batadv_hardif_put(in_hardif);
 	dev_put(in_dev);
 	batadv_tt_local_entry_put(tt_local);
 	batadv_tt_global_entry_put(tt_global);

-- 
2.47.3

