Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D83F7C54F4C
	for <batman@archiver.kernel.org>; Tue, 28 Jul 2026 06:28:39 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id D0F06840BB
	for <batman@archiver.kernel.org>; Tue, 28 Jul 2026 08:28:37 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1785220117;
 b=3+pNsXmNQO4kP3dnmNu3BoWDP6JVbrWzH0SEfH8daOBqRkwkmGMy71eMyvKdaBCx9k5lM
 JtRHucjIt9vcLx89Qa+akcBfen3mvXOI0Y0OmBiQvWJua00dTw5su+8D1SuKVRA7FG8VXel
 yDnELjx9XlX2sO66i2/4jmQnBg1jFuo=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1785220117; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=ndTxUd9WDmjDGoYTUW1PYj8vG7xFsLVJwoDolfNpavg=;
 b=vDEQho1Cp22YV+/zAcvycUeoy3fShCYULC273wld/840wSMMJoUICjzB3CU/bnuaMZiJR
 E61tlMBuiqR9fI0ZLxrBGpqlCpTJf+eKx/Til06ZCrPbVZKRBqLXsirgkkGtcQbqiVd9sen
 nEf5ItwD2MQyKXOk6ydB9ZKurM+AAUA=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=fail;
 arc=pass;
 dmarc=none
Authentication-Results: open-mesh.org; dkim=fail; arc=pass; dmarc=none
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id A6E8780A12
	for <b.a.t.m.a.n@lists.open-mesh.org>; Tue, 28 Jul 2026 05:11:04 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1785208276;
	b=BgPOVJ+0MGaI6f8g9LOUU1HsG9OLPNOpbLjzDoUMNsR0tcSSlL8Mu9GslLyCPQiVGXuSgI
	VwWgFIYvXLZLqTt8KApZrhckH/b1dBsvyIwJuBPU1bucC732VZ0n+Dr0/Css4hUImk/hGa
	+f2gmnx47scvCCk9B1iO48FsLIwonmU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1785208276;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ndTxUd9WDmjDGoYTUW1PYj8vG7xFsLVJwoDolfNpavg=;
	b=2Xp3+v9FGPYgZNNDt1Z30h9YQbrefEnEsCAvdhIecFjF2DkSoWu3G/DCGsI48W6HcCAXNp
	KPEIALxetm9y7JOgxw2Rfvk1L8idko3Pl7eO1t61fBQFerOyq2jBvBOQZ4O24nT+CGA9D8
	9iGHk7Z9O+t5V99p8rsdS+aS5cetFDs=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=none;
	spf=pass (diktynna.open-mesh.org: domain of heminhong@kylinos.cn designates
 124.126.103.232 as permitted sender) smtp.mailfrom=heminhong@kylinos.cn;
	dmarc=none
X-UUID: f29cc8628a3111f1aa26b74ffac11d73-20260728
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:c1c3f42d-d709-457b-a9ae-cf9fe1a2c0d0,IP:0,U
	RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:e7bac3a,CLOUDID:8cd09a781ef505a8ab7cb90d70c7b954,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102|136|850|865|898,TC:nil,Content:0|15|
	50,EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0
	,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: f29cc8628a3111f1aa26b74ffac11d73-20260728
X-User: heminhong@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <heminhong@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 393920790; Tue, 28 Jul 2026 11:10:55 +0800
From: Minhong He <heminhong@kylinos.cn>
To: Marek Lindner <marek.lindner@mailbox.org>,
	Simon Wunderlich <sw@simonwunderlich.de>,
	Antonio Quartulli <antonio@mandelbit.com>,
	Sven Eckelmann <sven@narfation.org>,
	b.a.t.m.a.n@lists.open-mesh.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH net] batman-adv: check register_netdevice_notifier() and
 rtnl_link_register() errors
Date: Tue, 28 Jul 2026 11:10:50 +0800
Message-Id: <20260728031050.76643-1-heminhong@kylinos.cn>
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
Message-ID-Hash: P7E7J4AX5DENZ3BMHA5Z76YDK2SMIAMY
X-Message-ID-Hash: P7E7J4AX5DENZ3BMHA5Z76YDK2SMIAMY
X-Mailman-Approved-At: Tue, 28 Jul 2026 08:28:34 +0200
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/P7E7J4AX5DENZ3BMHA5Z76YDK2SMIAMY/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

batadv_init() ignores errors from register_netdevice_notifier() and
rtnl_link_register(), so the module can load without those registrations
in place.

Check both return values and unwind prior initialization in reverse order
of acquisition on failure.

Signed-off-by: Minhong He <heminhong@kylinos.cn>
---
 net/batman-adv/main.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/net/batman-adv/main.c b/net/batman-adv/main.c
index 73becb054948..e6bcaf2d14ed 100644
--- a/net/batman-adv/main.c
+++ b/net/batman-adv/main.c
@@ -108,8 +108,14 @@ static int __init batadv_init(void)
 	if (ret < 0)
 		goto err_init_wifi;
 
-	register_netdevice_notifier(&batadv_hard_if_notifier);
-	rtnl_link_register(&batadv_link_ops);
+	ret = register_netdevice_notifier(&batadv_hard_if_notifier);
+	if (ret < 0)
+		goto err_reg_notifier;
+
+	ret = rtnl_link_register(&batadv_link_ops);
+	if (ret < 0)
+		goto err_rtnl_link;
+
 	batadv_netlink_register();
 
 	pr_info("B.A.T.M.A.N. advanced %s (compatibility version %i) loaded\n",
@@ -117,6 +123,10 @@ static int __init batadv_init(void)
 
 	return 0;
 
+err_rtnl_link:
+	unregister_netdevice_notifier(&batadv_hard_if_notifier);
+err_reg_notifier:
+	batadv_wifi_net_devices_deinit();
 err_init_wifi:
 	destroy_workqueue(batadv_event_workqueue);
 	batadv_event_workqueue = NULL;
-- 
2.25.1
