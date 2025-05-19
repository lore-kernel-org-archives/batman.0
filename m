Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBE93C2D0CD
	for <batman-adv@archiver.kernel.org>; Mon, 19 May 2025 20:47:21 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id C526D84506
	for <batman-adv@archiver.kernel.org>; Mon, 19 May 2025 22:47:19 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1747687639;
 b=C7tS6CDqfd/nE5kLLxw9VcaNQzbJ4uzRLpfAXKVMoTc2E8QptIt2jROTtCSLcNeHd0VaZ
 47WRhJL8htKyX+pyUZUYgCCEy0Z10px1gTopmV/1IVbcAi036yieNCKgP4DUEOx64eWT40t
 yTX54/dG9a54Nj2EO2ss83Bl4zhvQws=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1747687639; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=r4tFLqo5k3xKoHIPW5pDy7bw73GjEG7aqdMDGqN1oPs=;
 b=JRIn/IB/cRfLUj+60nDFw3pIAyH7iTglObh66cJNkmhn/WwvFf2HHbOSkRFVPZ5div3N1
 n9ZKzV4q/DjdgaCqrPxaWjnM8zbRq2/OgZnut7xvLx1o0wya7auBWclBzcWIturEB7D/NxZ
 wJM7jaDjegVYg38zLUgfLQPy/NRsOuQ=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=universe-factory.net;
  arc=pass;
  dmarc=none
Authentication-Results: open-mesh.org;
 dkim=pass header.d=universe-factory.net; arc=pass; dmarc=none
Received: from mail.universe-factory.net (osgiliath.universe-factory.net
 [141.95.161.142])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 63B2283EF8
	for <b.a.t.m.a.n@lists.open-mesh.org>; Mon, 19 May 2025 22:47:07 +0200 (CEST)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1747687627;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=r4tFLqo5k3xKoHIPW5pDy7bw73GjEG7aqdMDGqN1oPs=;
	b=v+RVrfM24NoFwM3eFbplydVgeuJYmjtSkUcOJGymYgiMqKJc+bFO3xYOw4KcTOokr2ulOd
	httHTE3FslXoXp2AxzQuzHpH46Xb9jpSJUvBE0ZnD5unOtcexYtP5x2K+gROJRr5Be2GeC
	MOxxzTEAshnEUMBPz9c6VipuR+62nTo=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=universe-factory.net header.s=dkim header.b=Z36oibbO;
	dmarc=pass (policy=reject) header.from=universe-factory.net;
	spf=pass (diktynna.open-mesh.org: domain of mschiffer@universe-factory.net
 designates 141.95.161.142 as permitted sender)
 smtp.mailfrom=mschiffer@universe-factory.net
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1747687627; a=rsa-sha256;
	cv=none;
	b=W6gvtKMrHwEmDtTf8+TmLIA4NI1xtZmIi3Sba+qp1lrgQmNo36Pu6t/cij+UNKEThDEi83
	kUwd5SGULdzfer5jMf/eBdoqARKmqlknpaxe7uWTlBm8JBgny7Uok9ZqtE3aWQ0rX5BjGX
	C3BsMEIyX3WBtLkzTfQk9bW7UeFxfug=
From: Matthias Schiffer <mschiffer@universe-factory.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=universe-factory.net;
	s=dkim; t=1747687626;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=r4tFLqo5k3xKoHIPW5pDy7bw73GjEG7aqdMDGqN1oPs=;
	b=Z36oibbOCISEclanDTqUhUZ8OJNayNS0OT3H8FGMI4K6d3BLP+DWeRHr1T2QFUS9nGXfRx
	58RB3eHl12InmKgD3nwF2OuivDCPtKNeJJgWHQJ1EBs0itwIxnDCE07nDq56ag+0pwZADS
	2f+RZf21onm1QBcomKGxAckds+1AZzGj+5bdFIZufGzqH6sKXDiC2RBBmKyM9KRPKe99zm
	P25UJZPUxRjYbxkuJYJtZRm6vqxoa1ThDUTvYrdCELe6SRtbqgD8CSG5uRd7bVSUGZpHjX
	QmpRHrLnsjOolvhYPm4CFPFNnIuAolcu96U9LtHjU/DeHouFuj7BIb0e+8XgzQ==
To: Marek Lindner <marek.lindner@mailbox.org>,
	Simon Wunderlich <sw@simonwunderlich.de>,
	Antonio Quartulli <antonio@mandelbit.com>,
	Sven Eckelmann <sven@narfation.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	b.a.t.m.a.n@lists.open-mesh.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Matthias Schiffer <mschiffer@universe-factory.net>
Subject: [PATCH batadv 5/5] batman-adv: move hardif generation counter into
 batadv_priv
Date: Mon, 19 May 2025 22:46:32 +0200
Message-ID: 
 <fd475dcf9ceaa7d14e4f0b4dca668f93e704f370.1747687504.git.mschiffer@universe-factory.net>
In-Reply-To: 
 <0b26554afea5203820faef1dfb498af7533a9b5d.1747687504.git.mschiffer@universe-factory.net>
References: 
 <0b26554afea5203820faef1dfb498af7533a9b5d.1747687504.git.mschiffer@universe-factory.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: -----
Message-ID-Hash: YWVY44WURG352LT5JII4I65WLYYPNUB2
X-Message-ID-Hash: YWVY44WURG352LT5JII4I65WLYYPNUB2
X-MailFrom: mschiffer@universe-factory.net
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/YWVY44WURG352LT5JII4I65WLYYPNUB2/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

The counter doesn't need to be global.

Signed-off-by: Matthias Schiffer <mschiffer@universe-factory.net>
---
 net/batman-adv/hard-interface.c | 4 ++--
 net/batman-adv/main.c           | 1 -
 net/batman-adv/main.h           | 2 --
 net/batman-adv/netlink.c        | 2 +-
 net/batman-adv/types.h          | 3 +++
 5 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/net/batman-adv/hard-interface.c b/net/batman-adv/hard-interface.c
index 5b46104dcf61..90968abefba0 100644
--- a/net/batman-adv/hard-interface.c
+++ b/net/batman-adv/hard-interface.c
@@ -748,7 +748,7 @@ int batadv_hardif_enable_interface(struct net_device *net_dev,
 	hard_iface->mesh_iface = mesh_iface;
 	bat_priv = netdev_priv(hard_iface->mesh_iface);
 
-	batadv_hardif_generation++;
+	bat_priv->hardif_generation++;
 	ret = netdev_master_upper_dev_link(hard_iface->net_dev,
 					   mesh_iface, hard_iface, NULL, NULL);
 	if (ret)
@@ -869,7 +869,7 @@ void batadv_hardif_disable_interface(struct batadv_hard_iface *hard_iface)
 	batadv_purge_outstanding_packets(bat_priv, hard_iface);
 	netdev_put(hard_iface->mesh_iface, &hard_iface->meshif_dev_tracker);
 
-	batadv_hardif_generation++;
+	bat_priv->hardif_generation++;
 	netdev_upper_dev_unlink(hard_iface->net_dev, hard_iface->mesh_iface);
 	batadv_hardif_recalc_extra_skbroom(hard_iface->mesh_iface);
 
diff --git a/net/batman-adv/main.c b/net/batman-adv/main.c
index 8e8ea93cf61d..f3d82d567968 100644
--- a/net/batman-adv/main.c
+++ b/net/batman-adv/main.c
@@ -61,7 +61,6 @@
 #include "tp_meter.h"
 #include "translation-table.h"
 
-unsigned int batadv_hardif_generation;
 static int (*batadv_rx_handler[256])(struct sk_buff *skb,
 				     struct batadv_hard_iface *recv_if);
 
diff --git a/net/batman-adv/main.h b/net/batman-adv/main.h
index debc55922fe1..365d92d04c85 100644
--- a/net/batman-adv/main.h
+++ b/net/batman-adv/main.h
@@ -232,8 +232,6 @@ static inline int batadv_print_vid(unsigned short vid)
 		return -1;
 }
 
-extern unsigned int batadv_hardif_generation;
-
 extern struct workqueue_struct *batadv_event_workqueue;
 
 int batadv_mesh_init(struct net_device *mesh_iface);
diff --git a/net/batman-adv/netlink.c b/net/batman-adv/netlink.c
index 41c1e7e0cf0d..23a626c63d40 100644
--- a/net/batman-adv/netlink.c
+++ b/net/batman-adv/netlink.c
@@ -978,7 +978,7 @@ batadv_netlink_dump_hardif(struct sk_buff *msg, struct netlink_callback *cb)
 	bat_priv = netdev_priv(mesh_iface);
 
 	rtnl_lock();
-	cb->seq = batadv_hardif_generation << 1 | 1;
+	cb->seq = bat_priv->hardif_generation << 1 | 1;
 
 	netdev_for_each_lower_private(mesh_iface, hard_iface, iter) {
 		if (i++ < skip)
diff --git a/net/batman-adv/types.h b/net/batman-adv/types.h
index fc84c2a80020..f490fe436458 100644
--- a/net/batman-adv/types.h
+++ b/net/batman-adv/types.h
@@ -1727,6 +1727,9 @@ struct batadv_priv {
 	/** @tp_num: number of currently active tp sessions */
 	atomic_t tp_num;
 
+	/** @hardif_generation: generation counter added to netlink hardif dumps */
+	unsigned int hardif_generation;
+
 	/** @orig_work: work queue callback item for orig node purging */
 	struct delayed_work orig_work;
 
-- 
2.49.0

