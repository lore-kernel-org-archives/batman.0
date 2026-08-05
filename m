Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86715C55ABA
	for <batman-adv@archiver.kernel.org>; Wed,  5 Aug 2026 14:35:47 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 05F4384278
	for <batman-adv@archiver.kernel.org>; Wed, 05 Aug 2026 16:35:46 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1785940546;
 b=k3M3YMNTVjjPzPsKuQCUSKz5UKi1vI6CxTpvdtY0Y1dgc/t0w5QNxSl989XhCzj0CZJ4f
 +RTshcQydT9pjKBsarxaMqn0SFGL3QDWUKo8hddxwM+qgtNkHzA0EYkeOaxdREAO/dg/iwb
 jAPArgC3dXmNnDxfxmCmXcJTLcwi6pw=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1785940546; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=fEO3/kLmL6SmU2jKGwS0RERQbRf/VGCpfalTmiKvqFQ=;
 b=GIIU5CpiWIzL3z3rM9UYRGPp6YZ/Y/7OcMJcZ2uuk3BQZVt0wfHxFw9D/9U7EcOcLq89O
 jEx1tpzn9nCDtl3kNmgkm2ifvxLYr4IEQp2hNT4EyMUdOFNY2VgfllqGR3GwARvtjrwqM6R
 vDPI5n6ez2TbBxqjxxrhJty4mw3cdNQ=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass header.from=simonwunderlich.de policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=simonwunderlich.de policy.dmarc=none
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de
 [IPv6:2a01:4f8:c17:e8c0::1])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 0950684192
	for <b.a.t.m.a.n@lists.open-mesh.org>; Wed, 05 Aug 2026 16:32:11 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1785940331;
	b=xvFxk8RPKlcKmruBCoGi5GFCNcjHifst2VLGGLtnup6DNZZYppEJ5DYMBwjuemVJ2NBkua
	fWHRtjv/yRSy+l8v6BfFYNXtSI+m8hS3tXEdoWuukdshOh0yoQzuCJerEcP+tmNsCvE7i/
	weyW1kE5ckqZkWnRPFyz88KHDU98RJ8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1785940331;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=fEO3/kLmL6SmU2jKGwS0RERQbRf/VGCpfalTmiKvqFQ=;
	b=Gn7iK2jvMj3YPt7R48xYaDpFywkR014oGaWzBqWHRBUZYDWFY9SAseRwPr+UJWyRhhGrzJ
	anPSWj/E3ZDuM0IUBZ6pipzrD+buj9BorbeMkWRfUydP/xqG7REgE97rNjzDmqV1XQHkyZ
	cHyWz1l/R3fCg6q/5IDoC5WWHhNqpGs=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=simonwunderlich.de header.s=09092022 header.b=uEBHodpN;
	spf=pass (diktynna.open-mesh.org: domain of sw@simonwunderlich.de designates
 2a01:4f8:c17:e8c0::1 as permitted sender)
 smtp.mailfrom=sw@simonwunderlich.de;
	dmarc=pass (policy=none) header.from=simonwunderlich.de
Received: from kero.packetmixer.de
 (p200300c5970b56d88Eebac4310d100Aa.dip0.t-ipconnect.de
 [IPv6:2003:c5:970b:56d8:8eeb:ac43:10d1:aa])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by mail.simonwunderlich.de (Postfix) with ESMTPSA id 98046FA1DF;
	Wed, 05 Aug 2026 16:32:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1785940330;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fEO3/kLmL6SmU2jKGwS0RERQbRf/VGCpfalTmiKvqFQ=;
	b=uEBHodpN6od0b8IqamW7zwKjeL1kIk0tynwpZjIZtXk8TI1pHWru6WgQU0PMKLz63xecVE
	0o60Bwe8TQNahWikFNII/UQ2O7+5rCkod7tS1GxYajIjF4GA6ExLycNzYE1cUWlFg00Xw1
	mDexgIJne3my67eps6ieyVdfhKFP6wLeLSUb+3cpAnIwoGdx04ChOoKtlxyRJBWEXYRlzS
	QaMQm2NtQXdXW1CZrdvrwWRMWV/zfWVcUqpGFOZb57G+HptCBecAcVHVFcLkKPMpdOY90w
	Hr7C2xiGWvJJEP3CesCCZsW3cu7eTQwlinxRpKtPFlwbWGBBrAvMGDeSbJNhIw==
From: Simon Wunderlich <sw@simonwunderlich.de>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	b.a.t.m.a.n@lists.open-mesh.org,
	Minhong He <heminhong@kylinos.cn>,
	Sven Eckelmann <sven@narfation.org>,
	Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH net-next 08/10] batman-adv: handle errors in batadv_init()
Date: Wed,  5 Aug 2026 16:27:22 +0200
Message-ID: <20260805143200.722098-9-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260805143200.722098-1-sw@simonwunderlich.de>
References: <20260805143200.722098-1-sw@simonwunderlich.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: RXHSKZZTXANQ6M2NKNE3CVVFYQ6J6CNE
X-Message-ID-Hash: RXHSKZZTXANQ6M2NKNE3CVVFYQ6J6CNE
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/RXHSKZZTXANQ6M2NKNE3CVVFYQ6J6CNE/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

From: Minhong He <heminhong@kylinos.cn>

batadv_init() ignores errors from several initialization helpers, so the
module can load without those registrations in place.

Check the fallible init steps and unwind prior initialization in reverse
order of acquisition on failure.

Signed-off-by: Minhong He <heminhong@kylinos.cn>
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/bat_iv_ogm.c |  8 +++++++
 net/batman-adv/bat_iv_ogm.h |  1 +
 net/batman-adv/bat_v.c      |  9 ++++++++
 net/batman-adv/bat_v.h      |  5 +++++
 net/batman-adv/main.c       | 45 ++++++++++++++++++++++++++++---------
 net/batman-adv/netlink.c    |  6 ++++-
 net/batman-adv/netlink.h    |  2 +-
 7 files changed, 63 insertions(+), 13 deletions(-)

diff --git a/net/batman-adv/bat_iv_ogm.c b/net/batman-adv/bat_iv_ogm.c
index aff279b83da49..53fbdbbe8f4f7 100644
--- a/net/batman-adv/bat_iv_ogm.c
+++ b/net/batman-adv/bat_iv_ogm.c
@@ -2802,3 +2802,11 @@ int __init batadv_iv_init(void)
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
index 04b01bd684e80..90318801aeaff 100644
--- a/net/batman-adv/bat_iv_ogm.h
+++ b/net/batman-adv/bat_iv_ogm.h
@@ -10,5 +10,6 @@
 #include "main.h"
 
 int batadv_iv_init(void);
+void batadv_iv_deinit(void);
 
 #endif /* _NET_BATMAN_ADV_BAT_IV_OGM_H_ */
diff --git a/net/batman-adv/bat_v.c b/net/batman-adv/bat_v.c
index ee372fc9d44e9..0c27447cf6889 100644
--- a/net/batman-adv/bat_v.c
+++ b/net/batman-adv/bat_v.c
@@ -947,3 +947,12 @@ int __init batadv_v_init(void)
 
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
index 964431f4dc8de..76bd969e79a26 100644
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
index c2d5b39b02f47..77597171d6376 100644
--- a/net/batman-adv/main.c
+++ b/net/batman-adv/main.c
@@ -102,35 +102,58 @@ static int __init batadv_init(void)
 
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
index 926210a67d640..107647c9badad 100644
--- a/net/batman-adv/netlink.c
+++ b/net/batman-adv/netlink.c
@@ -1556,14 +1556,18 @@ struct genl_family batadv_netlink_family __ro_after_init = {
 
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
index 4eae9e5ff1354..f92d3ea7d06cb 100644
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
2.47.3

