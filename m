Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73822C43458
	for <batman-adv@archiver.kernel.org>; Sun, 28 Jun 2026 15:12:22 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 0C97384291
	for <batman-adv@archiver.kernel.org>; Sun, 28 Jun 2026 17:12:21 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1782659541;
 b=jPM54Z5NU12jCKbgPHIambMS3FUloJiIcO/UZ2esEeBJ1iEGMyDAkexBr1KBDi9qwMYYP
 CSREvQ7/NT4TM6ysJYX8DZfwYNxljYJI3NFWSbaDsBJi1R6kJ7mGPZeuVk8rCJKz/4hW2hf
 EVgNoZNXTBlU/kVGegesAlV5z0hpiaY=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1782659541; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=TMSXGMS9y+3CKFpIZs1i9MAnV3nKai4FhRI5Fm0H9Uk=;
 b=1dGHct3XWCwRqJXbEagFzu2QSRz0bi/wKHl0khOcmUvNnugKN4vLtH5Sf09/yqjWiDqSu
 4CjDZBC6rWRrmvOv44UybdielHPA8zdJ2GBzIDJdfDyksu+nIwE6tDIPenCzROV6eao4DRs
 s90aUa6XM/lzNkZZMaYWR98Ysyr0eRo=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=universe-factory.net;
 arc=pass;
 dmarc=none
Authentication-Results: open-mesh.org;
 dkim=pass header.d=universe-factory.net; arc=pass; dmarc=none
Received: from mail.universe-factory.net (osgiliath.universe-factory.net
 [141.95.161.142])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id C2F8683E6F
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sun, 28 Jun 2026 17:08:07 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1782659287;
	b=uZS7mXJipM1kbt2Q/9F/cLIlf26Z92zskr/1gqZh+HspzUm7Xis59vGxBuG6zwOpfc7nAx
	fLH07p2OTvEMydIFuwhbQl68g/CZqIHOh6ef+eWiuRAs4I9l+dH109Zh9cyyLCVzVd3O4b
	s0vJ2RKbcFpB3gLqaYdZIfDFWkm1Y0s=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1782659287;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=TMSXGMS9y+3CKFpIZs1i9MAnV3nKai4FhRI5Fm0H9Uk=;
	b=Zv0Yf8kwkwxrituSVH3XpEer/CNN2Gdu4nwPRN+R5dx8KfAT4Z96WReUxn80RV2Irvhp0f
	oN2P16SZe8qRwCt0rIEiZc4bNwphLzJJ+pl/4d5vEvPobMSZhQx2VGbkkIdzERKbARhGu+
	62Grw/3hTAo0scxGRWXmLxVRmkfj39I=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=universe-factory.net header.s=dkim header.b=gvfZPpok;
	spf=pass (diktynna.open-mesh.org: domain of neocturne@universe-factory.net
 designates 141.95.161.142 as permitted sender)
 smtp.mailfrom=neocturne@universe-factory.net;
	dmarc=pass (policy=reject) header.from=universe-factory.net
From: Nora Schiffer <neocturne@universe-factory.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=universe-factory.net;
	s=dkim; t=1782659287;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TMSXGMS9y+3CKFpIZs1i9MAnV3nKai4FhRI5Fm0H9Uk=;
	b=gvfZPpok9EOn0Oy0kiYLK8wTse7G2Pg8m50QTu85oGl8JpKE5PegIzxo0l5z1wLBH4Cw1v
	9Yw1fnyXY3uBYm9h1rYDlG5+dtgybZSYgvp8VT2xWqIK8fXLSSjGVd3fSvUABrHn+anab+
	TtE7372JkqYI/E3grna1X3i4ZaSIyy/ynec9eSm5m2ztZ23BiU4zRstO02EJ+79678B/8l
	MpK2kuVczvLyXiuuvjJcaA5HcGOMjQcEmzyRFm2Ut3BoXYlV0ZxmEnxUe2BwQFMETpE7C4
	pPAUPZAawf4EpkfuguMcm/3jpzdR3OANj8v8NjT5mLnnOy2Bo82lCmxLaP9c0g==
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: sven@narfation.org,
	Nora Schiffer <neocturne@universe-factory.net>
Subject: [PATCH batadv v5 5/6] batman-adv: move hardif generation counter into
 batadv_priv
Date: Sun, 28 Jun 2026 17:07:32 +0200
Message-ID: 
 <1be669a23303cb3eb93c4672ffbca8150625914c.1782658366.git.neocturne@universe-factory.net>
In-Reply-To: <cover.1782658366.git.neocturne@universe-factory.net>
References: <cover.1782658366.git.neocturne@universe-factory.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: -----
X-MailFrom: neocturne@universe-factory.net
X-Mailman-Rule-Hits: member-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-b.a.t.m.a.n.lists.open-mesh.org-0;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-1;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-2;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-3; emergency
Message-ID-Hash: Y3Z4PEVCJY4LIGZZPRWB35HHQCXSPPNC
X-Message-ID-Hash: Y3Z4PEVCJY4LIGZZPRWB35HHQCXSPPNC
X-Mailman-Approved-At: Sun, 28 Jun 2026 17:11:17 +0200
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/Y3Z4PEVCJY4LIGZZPRWB35HHQCXSPPNC/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

The counter doesn't need to be global.

Signed-off-by: Nora Schiffer <neocturne@universe-factory.net>
---

v2-v5: no changes


 net/batman-adv/hard-interface.c | 4 ++--
 net/batman-adv/main.c           | 1 -
 net/batman-adv/main.h           | 2 --
 net/batman-adv/netlink.c        | 2 +-
 net/batman-adv/types.h          | 3 +++
 5 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/net/batman-adv/hard-interface.c b/net/batman-adv/hard-interface.c
index 86010bc32818..9b8108d464db 100644
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
@@ -865,7 +865,7 @@ void batadv_hardif_disable_interface(struct batadv_hard_iface *hard_iface)
 	batadv_purge_orig_ref(bat_priv);
 	batadv_purge_outstanding_packets(bat_priv, hard_iface);
 
-	batadv_hardif_generation++;
+	bat_priv->hardif_generation++;
 	netdev_upper_dev_unlink(hard_iface->net_dev, hard_iface->mesh_iface);
 	batadv_hardif_recalc_extra_skbroom(hard_iface->mesh_iface);
 
diff --git a/net/batman-adv/main.c b/net/batman-adv/main.c
index 1d82f3a841a1..badc1df0af1d 100644
--- a/net/batman-adv/main.c
+++ b/net/batman-adv/main.c
@@ -59,7 +59,6 @@
 #include "tp_meter.h"
 #include "translation-table.h"
 
-unsigned int batadv_hardif_generation;
 static int (*batadv_rx_handler[256])(struct sk_buff *skb,
 				     struct batadv_hard_iface *recv_if);
 
diff --git a/net/batman-adv/main.h b/net/batman-adv/main.h
index e34145047a34..e738758ee4a7 100644
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
index c1e8a074fb70..4b43b3fab72c 100644
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
index 1671380b3792..e1463a029e83 100644
--- a/net/batman-adv/types.h
+++ b/net/batman-adv/types.h
@@ -1676,6 +1676,9 @@ struct batadv_priv {
 	/** @tp_num: number of currently active tp sessions */
 	atomic_t tp_num;
 
+	/** @hardif_generation: generation counter added to netlink hardif dumps */
+	unsigned int hardif_generation;
+
 	/** @orig_work: work queue callback item for orig node purging */
 	struct delayed_work orig_work;
 
-- 
2.54.0

