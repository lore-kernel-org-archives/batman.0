Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 540DDCD6E68
	for <batman-adv@archiver.kernel.org>; Thu,  4 Jun 2026 04:43:02 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id F351F84566
	for <batman-adv@archiver.kernel.org>; Thu, 04 Jun 2026 06:43:00 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1780548180;
 b=LkKnqDuPeHuHvHeAWelV7QjTg19+w1pWh7122BwL3R6b+U/OemJsmNJJ+Wi+93lfano8w
 lbeH2MyNpxUUTM3ca4kbrI5YGetQOLPiWa0+x1pqXLyqgGXnp3UzNexC33L+0knLmUYPAH3
 XRnwLs1JOOH7OBfOKUwDSHm1A26EDoU=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1780548180; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=I1HBOodQ0pIGsfhrddWk9H9pd/T8ZBiqMXV0+8AmEtM=;
 b=ovXFjUDVorzsIPXjUw/WtwBgUAK2c1bjL1IEnOMkN5Xj6oHHouZQZMG0zRq+ZHE7MCE5r
 zdofEUPh0ByMmipmHzFdaeXzpYbMKF7fS2EZnm8OVLBxrMTJQoDy4/WGt2nNVH3VzOXlc/i
 r52f5OHG13Ae2x9ckrOSAW04f9gBMZg=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id CCB6B8452A
	for <b.a.t.m.a.n@lists.open-mesh.org>; Thu, 04 Jun 2026 06:40:02 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1780548002;
	b=GmJ0ZDiMiCjVeLftJthwxuKrSUgKFZVsfdHoP01qwsRzXd9moNg2zvBDlPS5W40edaSdKJ
	gZzYYkalHtnrnqgDNKbi0JPViZ4T4yXsqv49/emXvGccCbBGYzCuJ7A58Vqq3QiO6cBkdm
	smJZn0u76k6qtVJ64OVVd3r9rTcQTWM=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b="WCr/gPpX";
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1780548002;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=I1HBOodQ0pIGsfhrddWk9H9pd/T8ZBiqMXV0+8AmEtM=;
	b=fYYLPcCE2Td0wPYenQgbV/OyqTQtiIuqJfupPldHZ9Dz0Mhw2PerGGvuRaadoaVrHMT4Xy
	dYfSVtHhrpe7Tta/dDhKiLS336nNtqBjHgxPkJhi89pm3/Kb0xdAWLy6YMnJ5RGd9kdg0O
	m0WACxNRA3IEZN1WGWGOjhTFmhEwjpA=
Received: by dvalin.narfation.org (Postfix) id 4C9221FF78;
	Thu, 04 Jun 2026 04:40:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1780548002;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=I1HBOodQ0pIGsfhrddWk9H9pd/T8ZBiqMXV0+8AmEtM=;
	b=WCr/gPpXLhZYPZk5WV3axtgbEAr+rd9C3riTI4l/l2OObCDkGI2jcJ/x9PMGwhbY5Y+Cc8
	O+OviITnHn2/WkEdj2iE+XAixUQYCQPT7f745OZSoh3H/OnUxlJeTFpZDfKAlUGg9B1obc
	HT3dBb3eKAIu0yk1+yokMaE3uOmdNXI=
From: Sven Eckelmann <sven@narfation.org>
Date: Thu, 04 Jun 2026 06:39:32 +0200
Subject: [PATCH RFC batadv v3 4/4] batman-adv: move hardif generation
 counter into batadv_priv
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260604-drop-hardif-list-v3-4-e0dfa8c7d602@narfation.org>
References: <20260604-drop-hardif-list-v3-0-e0dfa8c7d602@narfation.org>
In-Reply-To: <20260604-drop-hardif-list-v3-0-e0dfa8c7d602@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>,
 Nora Schiffer <neocturne@universe-factory.net>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3076; i=sven@narfation.org;
 h=from:subject:message-id; bh=HSRrHoQoSxN9dIjHW6kNLoyPln7JVe7q//Q5CIV4m4U=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFmKjE2V9umRp8s/Cxy8a7Ggr9nw9tM972TYUzJL7buZf
 0/ftEO1o5SFQYyLQVZMkWXPlfzzm9nfyn+e9vEozBxWJpAhDFycAjCRw8sY/ulOtJ6/3K3A5oXc
 DuGV7TzXl5a/WWcuGxlQqKNtK+xoaczI8DD+satX7YYjt6efc7jt2ZDaJPdtnmjSktS5X1YHPzw
 vxgIA
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: RXIYAV5W53ELCDTPR5SLBYI3OKBK42VT
X-Message-ID-Hash: RXIYAV5W53ELCDTPR5SLBYI3OKBK42VT
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/RXIYAV5W53ELCDTPR5SLBYI3OKBK42VT/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

From: Nora Schiffer <neocturne@universe-factory.net>

The counter doesn't need to be global.
---
 net/batman-adv/hard-interface.c | 4 ++--
 net/batman-adv/main.c           | 1 -
 net/batman-adv/main.h           | 2 --
 net/batman-adv/netlink.c        | 2 +-
 net/batman-adv/types.h          | 3 +++
 5 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/net/batman-adv/hard-interface.c b/net/batman-adv/hard-interface.c
index 77a2240a..a340476f 100644
--- a/net/batman-adv/hard-interface.c
+++ b/net/batman-adv/hard-interface.c
@@ -774,7 +774,7 @@ int batadv_hardif_enable_interface(struct net_device *net_dev,
 	hard_iface->mesh_iface = mesh_iface;
 	bat_priv = netdev_priv(hard_iface->mesh_iface);
 
-	batadv_hardif_generation++;
+	bat_priv->hardif_generation++;
 	ret = netdev_master_upper_dev_link(hard_iface->net_dev,
 					   mesh_iface, hard_iface, NULL, NULL);
 	if (ret)
@@ -892,7 +892,7 @@ void batadv_hardif_disable_interface(struct batadv_hard_iface *hard_iface)
 	batadv_purge_orig_ref(bat_priv);
 	batadv_purge_outstanding_packets(bat_priv, hard_iface);
 
-	batadv_hardif_generation++;
+	bat_priv->hardif_generation++;
 	netdev_upper_dev_unlink(hard_iface->net_dev, hard_iface->mesh_iface);
 	batadv_hardif_recalc_extra_skbroom(hard_iface->mesh_iface);
 
diff --git a/net/batman-adv/main.c b/net/batman-adv/main.c
index 1d82f3a8..badc1df0 100644
--- a/net/batman-adv/main.c
+++ b/net/batman-adv/main.c
@@ -59,7 +59,6 @@
 #include "tp_meter.h"
 #include "translation-table.h"
 
-unsigned int batadv_hardif_generation;
 static int (*batadv_rx_handler[256])(struct sk_buff *skb,
 				     struct batadv_hard_iface *recv_if);
 
diff --git a/net/batman-adv/main.h b/net/batman-adv/main.h
index e3414504..e738758e 100644
--- a/net/batman-adv/main.h
+++ b/net/batman-adv/main.h
@@ -226,8 +226,6 @@ static inline int batadv_print_vid(unsigned short vid)
 		return -1;
 }
 
-extern unsigned int batadv_hardif_generation;
-
 extern struct workqueue_struct *batadv_event_workqueue;
 
 int batadv_mesh_init(struct net_device *mesh_iface);
diff --git a/net/batman-adv/netlink.c b/net/batman-adv/netlink.c
index 6fb0bebc..7f08db9c 100644
--- a/net/batman-adv/netlink.c
+++ b/net/batman-adv/netlink.c
@@ -968,7 +968,7 @@ batadv_netlink_dump_hardif(struct sk_buff *msg, struct netlink_callback *cb)
 	bat_priv = netdev_priv(mesh_iface);
 
 	rtnl_lock();
-	cb->seq = batadv_hardif_generation << 1 | 1;
+	cb->seq = bat_priv->hardif_generation << 1 | 1;
 
 	netdev_for_each_lower_private(mesh_iface, hard_iface, iter) {
 		if (i++ < skip)
diff --git a/net/batman-adv/types.h b/net/batman-adv/types.h
index 1ee663c3..22cd53dd 100644
--- a/net/batman-adv/types.h
+++ b/net/batman-adv/types.h
@@ -1665,6 +1665,9 @@ struct batadv_priv {
 	/** @tp_num: number of currently active tp sessions */
 	atomic_t tp_num;
 
+	/** @hardif_generation: generation counter added to netlink hardif dumps */
+	unsigned int hardif_generation;
+
 	/** @orig_work: work queue callback item for orig node purging */
 	struct delayed_work orig_work;
 

-- 
2.47.3

