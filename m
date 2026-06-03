Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A872CD6E4A
	for <batman-adv@archiver.kernel.org>; Wed,  3 Jun 2026 04:34:33 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 2A89F82727
	for <batman-adv@archiver.kernel.org>; Wed, 03 Jun 2026 06:34:32 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1780461272;
 b=3h43n5aTWJsP5Yf8PQABXMNaATxklxP8QsCuTLik79X16rvGQiVTqism02V0IXUitYoVN
 +F/yoWBPFwEjR8UK4L2yUfhgxHXjPevstm52BbkagFC0UgY8/oIGDhUS9FHL3IFbM/WJ9am
 EwAxUDzo/db8IyaA5JapI9w5MrvF2SI=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1780461272; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=w+ztb/9yt28Q6DzGZgQpcGc5ZB8Tdf30Bw0jE0wJzaU=;
 b=FfeYijvtlTSm5Gv3nrWy8VvgISUeV6PeqfDEDNNr7tGJSe4jpsVUxFstM8mVUEiBfsPeS
 AwDEgiWeeJgPMnOu5emzWyOaGqRpAYnnPPHQ/dvTA0bYqo5fyUi/zVzEf417to+kxjXtXAa
 RVEKVmLtUORbZYL+xHTfpT2ijJj6NqI=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 0122B84A91
	for <b.a.t.m.a.n@lists.open-mesh.org>; Wed, 03 Jun 2026 06:29:49 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1780460989;
	b=0PBnDzf/wHlLjgUuE+Axagp+xvaZKxBvAjoSN69MmWlTlhoc+nsS0iRmcDYEg0cTXXun26
	7By3Qw9QELfORpP6yUcf9ZED+rmWd1s+dhyUlKAIR6unNhLqMkmm26rsT+CX/PTw6j49vy
	BQYg8mc9UfsgJ6CvP+j337Aqgm7bkf4=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=Kf6mpFH0;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1780460989;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=w+ztb/9yt28Q6DzGZgQpcGc5ZB8Tdf30Bw0jE0wJzaU=;
	b=rlKH+xv1L2CvVcrXTZneG9PlzfkobKaq222pswZTmmcAYxc0zO4MMDd9h+0BgZy53Oy8WB
	F7eJDqRLNSgy0v4T8aN5cYbKVXQHOKUTAuxJhtgVq3Ez4pG3U5LbT9S6mZ/+3w0j44HK4h
	BccSCciH1XE4+jbKknrjRJeUFp8PfpU=
Received: by dvalin.narfation.org (Postfix) id B3D211FD9C;
	Wed, 03 Jun 2026 04:29:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1780460988;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=w+ztb/9yt28Q6DzGZgQpcGc5ZB8Tdf30Bw0jE0wJzaU=;
	b=Kf6mpFH0UO9LKfohNDnbquCYTvCdK84y+SWQiiRAUHvVGGK84U3F7FD5FoEABI0pimpDvE
	/2mJk4Ku9ouzc7+mm9Ru2WuerVQhMNN5d0oJFemG2Aeybq955zb9BPelT0WUB9EnbdDQiH
	nckt+eCBCpKN0zCaPzGV7YfcOapv2Jg=
From: Sven Eckelmann <sven@narfation.org>
Date: Wed, 03 Jun 2026 06:29:04 +0200
Subject: [PATCH batadv v2 5/5] batman-adv: move hardif generation counter
 into batadv_priv
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260603-drop-hardif-list-v2-5-5f79821ca333@narfation.org>
References: <20260603-drop-hardif-list-v2-0-5f79821ca333@narfation.org>
In-Reply-To: <20260603-drop-hardif-list-v2-0-5f79821ca333@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>,
 Nora Schiffer <neocturne@universe-factory.net>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3076; i=sven@narfation.org;
 h=from:subject:message-id; bh=r1MuJ1dZHXLKmOofoP5TWLJboP5MrqMJk4FsAdvgWl4=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFnya6e89LwWWhkcYC8UuZK3KKTi/iPn8ql317be+HmYX
 22Dpt+0jlIWBjEuBlkxRZY9V/LPb2Z/K/952sejMHNYmUCGMHBxCsBE7r9iZGiMPZzlECig6XRu
 R679u0/tUnektT7pz3Q4e/TJxJIN/2sZGZbaa6bqv1RZW1Ly0fbk1ZSQkhqb2XlHImrWpl1u3Zf
 dww8A
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: EUWOESWPDGWYDYJ6G3RI3AGZPJZNTGDI
X-Message-ID-Hash: EUWOESWPDGWYDYJ6G3RI3AGZPJZNTGDI
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/EUWOESWPDGWYDYJ6G3RI3AGZPJZNTGDI/>
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
index 3990d826..8e16b20a 100644
--- a/net/batman-adv/hard-interface.c
+++ b/net/batman-adv/hard-interface.c
@@ -775,7 +775,7 @@ int batadv_hardif_enable_interface(struct net_device *net_dev,
 	hard_iface->mesh_iface = mesh_iface;
 	bat_priv = netdev_priv(hard_iface->mesh_iface);
 
-	batadv_hardif_generation++;
+	bat_priv->hardif_generation++;
 	ret = netdev_master_upper_dev_link(hard_iface->net_dev,
 					   mesh_iface, hard_iface, NULL, NULL);
 	if (ret)
@@ -894,7 +894,7 @@ void batadv_hardif_disable_interface(struct batadv_hard_iface *hard_iface)
 	batadv_purge_orig_ref(bat_priv);
 	batadv_purge_outstanding_packets(bat_priv, hard_iface);
 
-	batadv_hardif_generation++;
+	bat_priv->hardif_generation++;
 	netdev_upper_dev_unlink(hard_iface->net_dev, hard_iface->mesh_iface);
 	batadv_hardif_recalc_extra_skbroom(hard_iface->mesh_iface);
 
diff --git a/net/batman-adv/main.c b/net/batman-adv/main.c
index ad26b6ce..f3c2e42c 100644
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
index 1449f364..557a5539 100644
--- a/net/batman-adv/netlink.c
+++ b/net/batman-adv/netlink.c
@@ -962,7 +962,7 @@ batadv_netlink_dump_hardif(struct sk_buff *msg, struct netlink_callback *cb)
 	bat_priv = netdev_priv(mesh_iface);
 
 	rtnl_lock();
-	cb->seq = batadv_hardif_generation << 1 | 1;
+	cb->seq = bat_priv->hardif_generation << 1 | 1;
 
 	netdev_for_each_lower_private(mesh_iface, hard_iface, iter) {
 		if (i++ < skip)
diff --git a/net/batman-adv/types.h b/net/batman-adv/types.h
index deb0b738..5ea04c32 100644
--- a/net/batman-adv/types.h
+++ b/net/batman-adv/types.h
@@ -1658,6 +1658,9 @@ struct batadv_priv {
 	/** @tp_num: number of currently active tp sessions */
 	atomic_t tp_num;
 
+	/** @hardif_generation: generation counter added to netlink hardif dumps */
+	unsigned int hardif_generation;
+
 	/** @orig_work: work queue callback item for orig node purging */
 	struct delayed_work orig_work;
 

-- 
2.47.3

