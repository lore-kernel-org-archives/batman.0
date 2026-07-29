Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7B44C53219
	for <batman@archiver.kernel.org>; Wed, 29 Jul 2026 14:57:36 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id B30B582E69
	for <batman@archiver.kernel.org>; Wed, 29 Jul 2026 16:57:34 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1785337054;
 b=06A3YUe+HO1aPAy0N0f5vlYSDSqJrYGhl0IZRNlI66T845x7bdUJAEKTpSLFt1AexRT+W
 fAkGh/7zzzGSIyx2krWepHtPRVyujULMQ1U9GK+OwpqywE9NIKpawj1ewgmrFVLZ7sY/Gux
 AnCIkbmo1/hScVALUid514fq9rCvwo8=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1785337054; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=3X/iw4B2Z6ja8b8Z3teiU0tOGgycJKv06rIbBuG4190=;
 b=o+9Vv2OM6usDVgFSq1snb1vvXmX8UuaKBpgD1wHZVYA8/NVhZwmHEJvwC1J1addPokNrB
 NwU8x/SPV+RSirk3qb/GLKjrlNpRgpWp4K9dpWA/1vMAGHXRUzarSBq+jmsQssopzF1FLoR
 DgfsmK46Ge7C3m4e9Y+r7Q8KpXd6wro=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=fail;
 arc=pass;
 dmarc=none
Authentication-Results: open-mesh.org; dkim=fail; arc=pass; dmarc=none
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 3834781678
	for <b.a.t.m.a.n@lists.open-mesh.org>; Wed, 29 Jul 2026 10:44:51 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1785314693;
	b=wLUp19cDvqXQMnp5/sfROcGBteOgeAMlwyt344jfzbScDZz/9q6vh9PK073Y8bCy0mNBRB
	u4aKEBnVs3u2jPBurh9SLe+0HkrfhfVIDQxu0ek5/O8t73woW469hVrIQKGz8h82T7fBPn
	048IR8FLU3z2RUcTAOPWC0AvQUNGMRQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1785314693;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3X/iw4B2Z6ja8b8Z3teiU0tOGgycJKv06rIbBuG4190=;
	b=wfBMEoP1TGidOZ4WlOOd2Zr/k3fvkucDVd2pPd4JypMuufFIn2HztW2hQhdoy2FGE1g0Ny
	3K/w8W7yJihJsKNS7azXsVRFcH1GsyWMS/W8vE09bKXBc9HgN4gh8zybFbPfOHBQm8VPRF
	7q0AKjFesaDA3FK9Rqfcn8Aw+Mg7Yrk=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=none;
	spf=pass (diktynna.open-mesh.org: domain of heminhong@kylinos.cn designates
 124.126.103.232 as permitted sender) smtp.mailfrom=heminhong@kylinos.cn;
	dmarc=none
X-UUID: bdd5a2228b2911f1aa26b74ffac11d73-20260729
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:b5b7d861-212f-4c24-a3e3-4ff0b9a03b1d,IP:0,U
	RL:0,TC:0,Content:-25,EDM:-25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACT
	ION:release,TS:-50
X-CID-META: VersionHash:e7bac3a,CLOUDID:927de268c0980353e61c091e5cde7aad,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:81|82|102|136|850|865|898,TC:nil,Content
	:0|15|50,EDM:2,IP:nil,URL:99|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL
	:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: bdd5a2228b2911f1aa26b74ffac11d73-20260729
X-User: heminhong@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <heminhong@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 183331719; Wed, 29 Jul 2026 16:44:42 +0800
From: Minhong He <heminhong@kylinos.cn>
To: Marek Lindner <marek.lindner@mailbox.org>,
	Simon Wunderlich <sw@simonwunderlich.de>,
	Antonio Quartulli <antonio@mandelbit.com>,
	Sven Eckelmann <sven@narfation.org>,
	b.a.t.m.a.n@lists.open-mesh.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH v2] batman-adv: handle errors in batadv_init()
Date: Wed, 29 Jul 2026 16:44:35 +0800
Message-Id: <20260729084435.128142-1-heminhong@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260728031050.76643-1-heminhong@kylinos.cn>
References: <20260728031050.76643-1-heminhong@kylinos.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MailFrom: heminhong@kylinos.cn
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-b.a.t.m.a.n.lists.open-mesh.org-0;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-1;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-2;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-3; emergency; member-moderation
Message-ID-Hash: MBSGJNF4QZI7AUUEKSLHWQKX7HG36VPO
X-Message-ID-Hash: MBSGJNF4QZI7AUUEKSLHWQKX7HG36VPO
X-Mailman-Approved-At: Wed, 29 Jul 2026 16:57:14 +0200
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/MBSGJNF4QZI7AUUEKSLHWQKX7HG36VPO/>
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
v2:
- Drop the "net" subject prefix; this targets the batman-adv tree
- Also check batadv_v_init()/batadv_iv_init()/batadv_netlink_register()
- Add batadv_v_deinit()/batadv_iv_deinit() helpers for unwind
- Call rcu_barrier() before batadv_wifi_net_devices_deinit()
- Shorten the subject
v1: https://lore.kernel.org/all/20260728031050.76643-1-heminhong@kylinos.cn/

 net/batman-adv/bat_iv_ogm.c |  8 +++++++
 net/batman-adv/bat_iv_ogm.h |  1 +
 net/batman-adv/bat_v.c      |  9 ++++++++
 net/batman-adv/bat_v.h      |  5 ++++
 net/batman-adv/main.c       | 46 +++++++++++++++++++++++++++++--------
 net/batman-adv/netlink.c    |  6 ++++-
 net/batman-adv/netlink.h    |  2 +-
 7 files changed, 66 insertions(+), 11 deletions(-)

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
index 73becb054948..8fe8a2b27a74 100644
--- a/net/batman-adv/main.c
+++ b/net/batman-adv/main.c
@@ -94,35 +94,63 @@ static int __init batadv_init(void)
 
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
 
 	batadv_event_workqueue = create_singlethread_workqueue("bat_events");
 	if (!batadv_event_workqueue) {
 		ret = -ENOMEM;
-		goto err_create_wq;
+		goto err_iv;
 	}
 
 	ret = batadv_wifi_net_devices_init();
 	if (ret < 0)
-		goto err_init_wifi;
+		goto err_wq;
 
-	register_netdevice_notifier(&batadv_hard_if_notifier);
-	rtnl_link_register(&batadv_link_ops);
-	batadv_netlink_register();
+	ret = register_netdevice_notifier(&batadv_hard_if_notifier);
+	if (ret < 0)
+		goto err_wifi;
+
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
+err_wifi:
 	destroy_workqueue(batadv_event_workqueue);
 	batadv_event_workqueue = NULL;
 	rcu_barrier();
+	batadv_wifi_net_devices_deinit();
+	goto err_iv;
 
-err_create_wq:
+err_wq:
+	destroy_workqueue(batadv_event_workqueue);
+	batadv_event_workqueue = NULL;
+	rcu_barrier();
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

