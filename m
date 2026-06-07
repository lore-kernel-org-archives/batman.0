Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9801CD8C88
	for <batman-adv@archiver.kernel.org>; Sun,  7 Jun 2026 11:56:19 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 574B784832
	for <batman-adv@archiver.kernel.org>; Sun, 07 Jun 2026 13:56:18 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1780833378;
 b=ZrUlGXXoff8SVjv+ZUEmaK9rvVHWVOQ7gcbKecHA3YsOkLGNVydApXjE3hjS4k0NEDxVZ
 qgMMrTFNajU80qsYaCSurFtFe54w0ZJwVQVIWVn/HxS+ADLUEq6VNzEZbGKl9UP5rV/u71Q
 b4kPupjFt1JMbErJ7Y59UmOtkb5KBpc=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1780833378; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=hGwrTfiCVwrx10gG5WYGCqaKedq+Ub9Aofo51HpF5a4=;
 b=sCP5jggYldv/nDLmDrAsPJFqBPojJyy6PfxXqXdtbVIuEwmExOUWd0d6NrBdhDp0uLX2s
 phKu5qDiNulIqNgyedfcPP4gr8yyB9yeS71PPf0VLqkPfWWM0hjB7EHJV7OHwA4M9RjPYSI
 pg3wudMUD4UcwUYAcOYFWCBslIhWVxo=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 0FBAA84191
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sun, 07 Jun 2026 13:54:41 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1780833281;
	b=ArjNK1qur8A1HBNzyR37KJ+NPYvA8lvRCEJFHZk8jprMp7nOVxUZuqJxXFJndbF7/dYYDz
	3166uGrMZUNkCiXaO2+VQOFv+qLJeoEI1e4vZ54vnVKTDKAZLAz3po/d2u8lXvchkddJv/
	UnGy3f2PSNeAY+1umKJDFzY7/3qs9hw=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=eM2ozz8U;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1780833281;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=hGwrTfiCVwrx10gG5WYGCqaKedq+Ub9Aofo51HpF5a4=;
	b=CqLOc9FM0NI2h7ohByH8uUspQzWcVk3fzaHTWICOG2TlscRfqcmMpBgCo/WPp6qZ4055kS
	D0H2pxLoyyjkIf00Bfx0sjcw0LyjkbBGiG48APWQ08Qb0uw8GArKitYH/XhlNb6UC5JV6c
	1pB3H8bF9V1Lx1ZvD2e4cm+FH96Jy30=
Received: by dvalin.narfation.org (Postfix) id C3D6C200D3;
	Sun, 07 Jun 2026 11:54:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1780833280;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hGwrTfiCVwrx10gG5WYGCqaKedq+Ub9Aofo51HpF5a4=;
	b=eM2ozz8U/dXULASJR7KpPSWQeWGdjb7RrkZAE0g+akeI8Zt+zQBVR4XbE4XSEe30/H/pbC
	xdPhh/+Ci7tZ8UUrWvVPl4+VcoiRSYgVRzn9ba4BASYuV/4Sv3jcuAks7+lNiyve8Xz0pZ
	Y4UtyVUHZzZXvJp1UX/x0jJRikTQRHQ=
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 07 Jun 2026 13:53:58 +0200
Subject: [PATCH RFC batadv v4 4/7] batman-adv: move hardif generation
 counter into batadv_priv
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260607-drop-hardif-list-v4-4-ade2931db295@narfation.org>
References: <20260607-drop-hardif-list-v4-0-ade2931db295@narfation.org>
In-Reply-To: <20260607-drop-hardif-list-v4-0-ade2931db295@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>,
 Nora Schiffer <neocturne@universe-factory.net>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3076; i=sven@narfation.org;
 h=from:subject:message-id; bh=AJtQMdhj5UJoUN7grlY1t9izWEAKXVUQEZwlp9bF1dY=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFmq0bduZP/qb04wLn7Llhzz1+LXhPlZPndeXTOpzS59J
 +kYEWvRUcrCIMbFICumyLLnSv75zexv5T9P+3gUZg4rE8gQBi5OAZhI2xGGfwaXHW+nPJVRtvm9
 9af3xz/ud36Ild7/sfDFF+7gpbeu6Woz/C9RFH2wOUJUPyqwQV2EzTMsT0nRXLhhb/Ubw95Jx51
 a+AE=
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: XCGSQKSIEMXSZ4QXWSYR5FPRGACK3U3Y
X-Message-ID-Hash: XCGSQKSIEMXSZ4QXWSYR5FPRGACK3U3Y
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/XCGSQKSIEMXSZ4QXWSYR5FPRGACK3U3Y/>
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
index ce62b842..92ae497e 100644
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
@@ -891,7 +891,7 @@ void batadv_hardif_disable_interface(struct batadv_hard_iface *hard_iface)
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
index c1e8a074..4b43b3fa 100644
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
index 5886b579..2134c877 100644
--- a/net/batman-adv/types.h
+++ b/net/batman-adv/types.h
@@ -1667,6 +1667,9 @@ struct batadv_priv {
 	/** @tp_num: number of currently active tp sessions */
 	atomic_t tp_num;
 
+	/** @hardif_generation: generation counter added to netlink hardif dumps */
+	unsigned int hardif_generation;
+
 	/** @orig_work: work queue callback item for orig node purging */
 	struct delayed_work orig_work;
 

-- 
2.47.3

