Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9C6DC54F54
	for <batman@archiver.kernel.org>; Fri, 31 Jul 2026 04:50:07 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id A29C4831A2
	for <batman@archiver.kernel.org>; Fri, 31 Jul 2026 06:50:05 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1785473405;
 b=wLipy+lrKjrrQqBOL5sYSQtgfRHvd0kEtpToPtv3hzfUsWI5pnrmwELnxsw1WnLBpkNFD
 9qkeIbIjNY+ffD9RgzzZADD9PMViR9DgPTTDO9YNU4kckMYFqFcgZ0ufTAkGVZeMgZha8mA
 g+wugaxU0PHiC5+e0r/FMLkv9iCSt9U=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1785473405; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=7Gplp1Xrzkfo+AGs7N2kTors4yxX8ZwuhH94jTpTC98=;
 b=vClBWuO1CUn5Tx9xpI67diBKhV9J+8nIRalL5aCQogGg4JrtGbm+a6fkUcESUkh74biTa
 +c6kpQoCe1Jdja/xGTQi/SP4M6AQ6EhUTw/UnYKmBhSFbmVu0Xy9PrGgt8gPw8i5ATYtNd7
 GwmQtEvsfxS5wGx9wALBonzIWp/2zVc=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=fail;
 arc=pass;
 dmarc=none
Authentication-Results: open-mesh.org; dkim=fail; arc=pass; dmarc=none
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id ECD3581452
	for <b.a.t.m.a.n@lists.open-mesh.org>; Fri, 31 Jul 2026 04:33:44 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1785465226;
	b=qqSx6o2PES7om5VIYNGaw131UzrTCzt3ofd+Ocvrik88Al2/Mn8Y+FP8ohXCa7Gv4Hv1fD
	td8TPyujBKgpsv7NOOw7pIY/xrgEBg1m9iQP0F9lAinRIxs8OWfkFbty1CjhwKNh5rwT4+
	fKxz/sC9dxACzpmyp0gGzQiZIogxshY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1785465226;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=7Gplp1Xrzkfo+AGs7N2kTors4yxX8ZwuhH94jTpTC98=;
	b=Jahqgn5RX/9++GbJqWTiIYgudK7KFt8ZAmpmlxaPRuXwjs4MiAZsM+LDwrD9EBF1tWsAcN
	ufsXTTzcnGJze/UoKwe874MbW/9zehhLALk4sQlYvD5DFe3a682lL9FvOebdhvpHzssyEB
	UVbr2DUzm9OCx/FfU7P/5CcM6Wsg3ME=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=none;
	spf=pass (diktynna.open-mesh.org: domain of heminhong@kylinos.cn designates
 124.126.103.232 as permitted sender) smtp.mailfrom=heminhong@kylinos.cn;
	dmarc=none
X-UUID: 3c2be5aa8c8811f1aa26b74ffac11d73-20260731
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:54699a3d-b8b7-4609-aba9-1f6bdfc2354c,IP:0,U
	RL:0,TC:0,Content:-25,EDM:-25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACT
	ION:release,TS:-50
X-CID-META: VersionHash:e7bac3a,CLOUDID:58b3604013722049097fe9e4ff5bc48c,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102|136|850|865|898,TC:nil,Content:0|15|
	50,EDM:2,IP:nil,URL:99|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI
	:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 3c2be5aa8c8811f1aa26b74ffac11d73-20260731
X-User: heminhong@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <heminhong@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1908533521; Fri, 31 Jul 2026 10:33:37 +0800
From: Minhong He <heminhong@kylinos.cn>
To: Marek Lindner <marek.lindner@mailbox.org>,
	Simon Wunderlich <sw@simonwunderlich.de>,
	Antonio Quartulli <antonio@mandelbit.com>,
	Sven Eckelmann <sven@narfation.org>,
	b.a.t.m.a.n@lists.open-mesh.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH batadv v3] batman-adv: handle errors in batadv_init()
Date: Fri, 31 Jul 2026 10:33:33 +0800
Message-Id: <20260731023333.70727-1-heminhong@kylinos.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MailFrom: heminhong@kylinos.cn
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-b.a.t.m.a.n.lists.open-mesh.org-0;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-1;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-2;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-3; emergency; member-moderation
Message-ID-Hash: ZKXBEU74Z5HNLFRTHPMQ2ZKA6Z6NXDYM
X-Message-ID-Hash: ZKXBEU74Z5HNLFRTHPMQ2ZKA6Z6NXDYM
X-Mailman-Approved-At: Fri, 31 Jul 2026 06:49:47 +0200
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/ZKXBEU74Z5HNLFRTHPMQ2ZKA6Z6NXDYM/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

batadv_init() ignores errors from several initialization helpers, so the
module can load without those registrations in place.

Check the fallible init steps and unwind prior initialization in reverse
order of acquisition on failure.

Signed-off-by: Minhong He <heminhong@kylinos.cn>
---
v3:
- Initialize wifi netdevices before the event workqueue so error
  unwinding can share a single rcu_barrier() without an extra goto
v2: https://lore.kernel.org/all/20260729084435.128142-1-heminhong@kylinos.cn/
v1: https://lore.kernel.org/all/20260728031050.76643-1-heminhong@kylinos.cn/

 net/batman-adv/bat_iv_ogm.c |  8 +++++++
 net/batman-adv/bat_iv_ogm.h |  1 +
 net/batman-adv/bat_v.c      |  9 ++++++++
 net/batman-adv/bat_v.h      |  5 +++++
 net/batman-adv/main.c       | 45 ++++++++++++++++++++++++++++---------
 net/batman-adv/netlink.c    |  6 ++++-
 net/batman-adv/netlink.h    |  2 +-
 7 files changed, 63 insertions(+), 13 deletions(-)

diff --git a/net/batman-adv/bat_iv_ogm.c b/net/batman-adv/bat_iv_ogm.c
index 22622283f59b..625d4d2ac262 100644
--- a/net/batman-adv/bat_iv_ogm.c
+++ b/net/batman-adv/bat_iv_ogm.c
@@ -2633,3 +2633,11 @@ int __init batadv_iv_init(void)
 out:
 	return ret;
 }
+
+/**
+ * batadv_iv_deinit() - B.A.T.M.A.N. IV deinitialization function
+ */
+void batadv_iv_deinit(void)
+{
+	batadv_recv_handler_unregister(BATADV_IV_OGM);
+}
diff --git a/net/batman-adv/bat_iv_ogm.h b/net/batman-adv/bat_iv_ogm.h
index 04b01bd684e8..90318801aeaf 100644
--- a/net/batman-adv/bat_iv_ogm.h
+++ b/net/batman-adv/bat_iv_ogm.h
@@ -10,5 +10,6 @@
 #include "main.h"
 
 int batadv_iv_init(void);
+void batadv_iv_deinit(void);
 
 #endif /* _NET_BATMAN_ADV_BAT_IV_OGM_H_ */
diff --git a/net/batman-adv/bat_v.c b/net/batman-adv/bat_v.c
index db6f5bdcaa98..c1f2d37aa724 100644
--- a/net/batman-adv/bat_v.c
+++ b/net/batman-adv/bat_v.c
@@ -888,3 +888,12 @@ int __init batadv_v_init(void)
 
 	return ret;
 }
+
+/**
+ * batadv_v_deinit() - B.A.T.M.A.N. V deinitialization function
+ */
+void batadv_v_deinit(void)
+{
+	batadv_recv_handler_unregister(BATADV_OGM2);
+	batadv_recv_handler_unregister(BATADV_ELP);
+}
diff --git a/net/batman-adv/bat_v.h b/net/batman-adv/bat_v.h
index 964431f4dc8d..76bd969e79a2 100644
--- a/net/batman-adv/bat_v.h
+++ b/net/batman-adv/bat_v.h
@@ -12,6 +12,7 @@
 #ifdef CONFIG_BATMAN_ADV_BATMAN_V
 
 int batadv_v_init(void);
+void batadv_v_deinit(void);
 void batadv_v_hardif_init(struct batadv_hard_iface *hardif);
 int batadv_v_mesh_init(struct batadv_priv *bat_priv);
 void batadv_v_mesh_free(struct batadv_priv *bat_priv);
@@ -23,6 +24,10 @@ static inline int batadv_v_init(void)
 	return 0;
 }
 
+static inline void batadv_v_deinit(void)
+{
+}
+
 static inline void batadv_v_hardif_init(struct batadv_hard_iface *hardif)
 {
 }
diff --git a/net/batman-adv/main.c b/net/batman-adv/main.c
index 73becb054948..c1044287e2ca 100644
--- a/net/batman-adv/main.c
+++ b/net/batman-adv/main.c
@@ -94,35 +94,58 @@ static int __init batadv_init(void)
 
 	batadv_recv_handler_init();
 
-	batadv_v_init();
-	batadv_iv_init();
+	ret = batadv_v_init();
+	if (ret < 0)
+		goto err_tt;
+
+	ret = batadv_iv_init();
+	if (ret < 0)
+		goto err_v;
+
 	batadv_tp_meter_init();
 
+	ret = batadv_wifi_net_devices_init();
+	if (ret < 0)
+		goto err_iv;
+
 	batadv_event_workqueue = create_singlethread_workqueue("bat_events");
 	if (!batadv_event_workqueue) {
 		ret = -ENOMEM;
-		goto err_create_wq;
+		goto err_wifi;
 	}
 
-	ret = batadv_wifi_net_devices_init();
+	ret = register_netdevice_notifier(&batadv_hard_if_notifier);
 	if (ret < 0)
-		goto err_init_wifi;
+		goto err_wq;
 
-	register_netdevice_notifier(&batadv_hard_if_notifier);
-	rtnl_link_register(&batadv_link_ops);
-	batadv_netlink_register();
+	ret = rtnl_link_register(&batadv_link_ops);
+	if (ret < 0)
+		goto err_notifier;
+
+	ret = batadv_netlink_register();
+	if (ret < 0)
+		goto err_rtnl;
 
 	pr_info("B.A.T.M.A.N. advanced %s (compatibility version %i) loaded\n",
 		init_utsname()->release, BATADV_COMPAT_VERSION);
 
 	return 0;
 
-err_init_wifi:
+err_rtnl:
+	rtnl_link_unregister(&batadv_link_ops);
+err_notifier:
+	unregister_netdevice_notifier(&batadv_hard_if_notifier);
+err_wq:
 	destroy_workqueue(batadv_event_workqueue);
 	batadv_event_workqueue = NULL;
 	rcu_barrier();
-
-err_create_wq:
+err_wifi:
+	batadv_wifi_net_devices_deinit();
+err_iv:
+	batadv_iv_deinit();
+err_v:
+	batadv_v_deinit();
+err_tt:
 	batadv_tt_cache_destroy();
 
 	return ret;
diff --git a/net/batman-adv/netlink.c b/net/batman-adv/netlink.c
index d2bc48c70714..99341f39df2a 100644
--- a/net/batman-adv/netlink.c
+++ b/net/batman-adv/netlink.c
@@ -1550,14 +1550,18 @@ struct genl_family batadv_netlink_family __ro_after_init = {
 
 /**
  * batadv_netlink_register() - register batadv genl netlink family
+ *
+ * Return: 0 on success or negative error number in case of failure
  */
-void __init batadv_netlink_register(void)
+int __init batadv_netlink_register(void)
 {
 	int ret;
 
 	ret = genl_register_family(&batadv_netlink_family);
 	if (ret)
 		pr_warn("unable to register netlink family\n");
+
+	return ret;
 }
 
 /**
diff --git a/net/batman-adv/netlink.h b/net/batman-adv/netlink.h
index 4eae9e5ff135..f92d3ea7d06c 100644
--- a/net/batman-adv/netlink.h
+++ b/net/batman-adv/netlink.h
@@ -12,7 +12,7 @@
 #include <linux/netlink.h>
 #include <linux/types.h>
 
-void batadv_netlink_register(void);
+int batadv_netlink_register(void);
 void batadv_netlink_unregister(void);
 struct net_device *batadv_netlink_get_meshif(struct netlink_callback *cb);
 struct batadv_hard_iface *
-- 
2.25.1

