Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B41F6C001B0
	for <batman-adv@archiver.kernel.org>; Wed, 16 Aug 2023 16:35:18 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 353FE83C86
	for <batman-adv@archiver.kernel.org>; Wed, 16 Aug 2023 18:35:17 +0200 (CEST)
ARC-Seal: i=3; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1692203717;
 b=DifWt5uiJ34wgiimanhUnPsXCyp9ublulewviI+byGoTKKb5YkzBl83W9j7eWzPkXUkRE
 vb9BPFrNZzVuMqLBQnelV9qxHhzlf3gWI2PvP0BSSDr+vBbgxXSjGgCbIikndBrfdjq0wEr
 VyBLTAA70KsMlxSAmX1KL6vG5oKFMVE=
ARC-Message-Signature: i=3; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1692203717; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=jtU/tgx4L6o0Wop2AU1xgpmhIFIvDcIHteSPIJzJVzQ=;
 b=RY4YNXFkOHGdA6wxd1As6pIZpyA3bVsa7PcLEF59PRG4KPO0GSfzUtfzowTkvbdsDYtmB
 GjdWovTbF/xt5+LUfFpXnISgUuMg4opmVOpQ0RzkjL12LY9m/XY3NKUUGeaeaQs0GgpIAlY
 ZpQgxa8HP/Vhid0Y07MI9rIyI1h+Frw=
ARC-Authentication-Results: i=3; open-mesh.org;
 dkim=pass header.d=simonwunderlich.de;
  arc=pass;
  dmarc=pass (Used From Domain Record) header.from=simonwunderlich.de
 policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=simonwunderlich.de policy.dmarc=none
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de
 [IPv6:2a01:4f8:c17:e8c0::1])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 40FEA8011C
	for <b.a.t.m.a.n@lists.open-mesh.org>; Wed, 16 Aug 2023 18:33:22 +0200 (CEST)
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1692203602;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=jtU/tgx4L6o0Wop2AU1xgpmhIFIvDcIHteSPIJzJVzQ=;
	b=1Sk1IfyIFhtdKteMC3693rLdeyipQy4K2lL9PQPlM6l1gOpLyo3648IfJqgG2GqvoCMfl2
	lSsAIpIeJMiUy2wXeeXyBJgpo6hpuoDU4IZ1cRlEuNrVkLLJsvbbLdyzz27NEac4fn5IDi
	dkZRJoE5l9vra3MCWT4MLI0u2FOj5lU=
ARC-Authentication-Results: i=2;
	diktynna.open-mesh.org;
	dkim=pass header.d=simonwunderlich.de header.s=09092022 header.b=ZAJBcK1m;
	spf=pass (diktynna.open-mesh.org: domain of sw@simonwunderlich.de designates
 2a01:4f8:c17:e8c0::1 as permitted sender)
 smtp.mailfrom=sw@simonwunderlich.de;
	dmarc=pass (policy=none) header.from=simonwunderlich.de;
	arc=pass ("simonwunderlich.de:s=09092022:i=1")
ARC-Seal: i=2; s=20121; d=open-mesh.org; t=1692203602; a=rsa-sha256;
	cv=pass;
	b=I1CXZr3en8LkbgqePCNw1L79hzeVGh7CPC6kmiMfD7SMhZslGz6Ky2wVFdaONqmaTXgsr6
	2D9nsf728Rv6aX9FUl2rgz2euHP9Je25fnefcRr8hZ29m57FG8WUwljBjnfevhQZLYE1Iy
	bQ+uFuZAwDkQdNieyzUyqzS37EHv09I=
Received: from kero.packetmixer.de
 (p200300FA272a67000Bb2D6DcAf57D46E.dip0.t-ipconnect.de
 [IPv6:2003:fa:272a:6700:bb2:d6dc:af57:d46e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits)
 server-digest SHA256)
	(No client certificate requested)
	by mail.simonwunderlich.de (Postfix) with ESMTPSA id 2D8F6FB5B6;
	Wed, 16 Aug 2023 18:33:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1692203602;
 h=from:from:sender:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jtU/tgx4L6o0Wop2AU1xgpmhIFIvDcIHteSPIJzJVzQ=;
	b=ZAJBcK1mkQD/h+RaS+rhNBlMEwe8FNtnH+Ubastim8RuMTx6CaaDXOPHk5NNAchmiruGYc
	DKjIHxgcNXxgpcxr/ebBkwXWxjA+EZHgyz7BOR+KFbKn6jtiPJcIkrqTwFU2dIpbgRqv1G
	UAhMPzStUg42dl9KH7b9gdXGU8x4EbZ1ZVlfW/noNGSn5Ha0FZshGuPYuSbBzw7KUbwAGm
	l//+YvOWQ4K4+WQvoUzzU4ypRApT4WeU4tkhwj4yo6AnGszMTu9W4gG8mogASlKfiPrMcQ
	0CQdrFSbTBuIeWs+ZwyMW8n5+XcwZcgWGspEL9HTE5FoWTd9TtyjcnnHHzD8OQ==
From: Simon Wunderlich <sw@simonwunderlich.de>
To: davem@davemloft.net,
	kuba@kernel.org
Subject: [PATCH 2/5] batman-adv: Don't increase MTU when set by user
Date: Wed, 16 Aug 2023 18:33:15 +0200
Message-Id: <20230816163318.189996-3-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230816163318.189996-1-sw@simonwunderlich.de>
References: <20230816163318.189996-1-sw@simonwunderlich.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
	d=simonwunderlich.de; s=09092022; t=1692203602;
	h=from:from:sender:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jtU/tgx4L6o0Wop2AU1xgpmhIFIvDcIHteSPIJzJVzQ=;
	b=uvCyrT5yxTVLpvUL9j/Kbx1/jk6u2SafmN8gKg64X2WS8LKZe9IHDBRBi8q57WWWVuqmL2
	URpZJNg6tl/PpY32yK4EbhOw2bxXvZIoHiB+g33a6RGGGeO6b8RX7jPGW1n0EseCrS2x6P
	yRtN4t0OwxfbpADgqjFDd56aJy4T3aneT8rg1iFoHFMRVM4oscpMq9AZ5VkqAEd0CJPUiI
	UvRZyhChd41LsMU1Hvq09mWrtd1DlvF583mDjxznCCFaG46OFGZLq2eQ3tdy9jMy/rrd7W
	S53mE4KBxm1Ap6tvAL40bcYNG4De7Xq6u84Z+AGt8md4C7KAokdHEVIA74+icQ==
ARC-Seal: i=1; s=09092022; d=simonwunderlich.de; t=1692203602; a=rsa-sha256;
	cv=none;
	b=Kn4nsiW5NXDiE0JOpoekwcbtDknkwfoJ/zAw/H9KB2cBra8ZNhiCasi/5Rr/LxyLxe2AiJY4kfGfkyRrpOnlqMi39sc5dIoEHLGmw+Ds2jXbQwrvgvhh1le25hbsjXKwBuhh4B9YYk9BCILBRBqyqN33EiirjE6PQSFATq6ZnaSW4s9fwioBGU0KGq/jjJwwT/NTtU8I554TqYv+eCwhNZac71kLB/rfyWMCESrpqP4RhuButAHGdajAI+TXZ30q1ZszTR2RWhrJZILmK1YRG6lxtFtUuaStf7oSaMDRvPVzijY02TxvIVGpf5CpKj92Uds7Q4K3m6ATsBkDKOhTEA==
ARC-Authentication-Results: i=1;
	mail.simonwunderlich.de;
	auth=pass smtp.auth=sw@simonwunderlich.de smtp.mailfrom=sw@simonwunderlich.de
Message-ID-Hash: CHKD3XZHSVDGSZWDD34U76E5ORK3SHD5
X-Message-ID-Hash: CHKD3XZHSVDGSZWDD34U76E5ORK3SHD5
X-MailFrom: sw@simonwunderlich.de
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-0;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
CC: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org,
 stable@vger.kernel.org
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/CHKD3XZHSVDGSZWDD34U76E5ORK3SHD5/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

From: Sven Eckelmann <sven@narfation.org>

If the user set an MTU value, it usually means that there are special
requirements for the MTU. But if an interface gots activated, the MTU was
always recalculated and then the user set value was overwritten.

The only reason why this user set value has to be overwritten, is when the
MTU has to be decreased because batman-adv is not able to transfer packets
with the user specified size.

Fixes: c6c8fea29769 ("net: Add batman-adv meshing protocol")
Cc: stable@vger.kernel.org
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/hard-interface.c | 14 +++++++++++++-
 net/batman-adv/soft-interface.c |  3 +++
 net/batman-adv/types.h          |  6 ++++++
 3 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/net/batman-adv/hard-interface.c b/net/batman-adv/hard-interface.c
index ae5762af0146..24c9c0c3f316 100644
--- a/net/batman-adv/hard-interface.c
+++ b/net/batman-adv/hard-interface.c
@@ -630,7 +630,19 @@ int batadv_hardif_min_mtu(struct net_device *soft_iface)
  */
 void batadv_update_min_mtu(struct net_device *soft_iface)
 {
-	dev_set_mtu(soft_iface, batadv_hardif_min_mtu(soft_iface));
+	struct batadv_priv *bat_priv = netdev_priv(soft_iface);
+	int limit_mtu;
+	int mtu;
+
+	mtu = batadv_hardif_min_mtu(soft_iface);
+
+	if (bat_priv->mtu_set_by_user)
+		limit_mtu = bat_priv->mtu_set_by_user;
+	else
+		limit_mtu = ETH_DATA_LEN;
+
+	mtu = min(mtu, limit_mtu);
+	dev_set_mtu(soft_iface, mtu);
 
 	/* Check if the local translate table should be cleaned up to match a
 	 * new (and smaller) MTU.
diff --git a/net/batman-adv/soft-interface.c b/net/batman-adv/soft-interface.c
index d3fdf82282af..85d00dc9ce32 100644
--- a/net/batman-adv/soft-interface.c
+++ b/net/batman-adv/soft-interface.c
@@ -153,11 +153,14 @@ static int batadv_interface_set_mac_addr(struct net_device *dev, void *p)
 
 static int batadv_interface_change_mtu(struct net_device *dev, int new_mtu)
 {
+	struct batadv_priv *bat_priv = netdev_priv(dev);
+
 	/* check ranges */
 	if (new_mtu < 68 || new_mtu > batadv_hardif_min_mtu(dev))
 		return -EINVAL;
 
 	dev->mtu = new_mtu;
+	bat_priv->mtu_set_by_user = new_mtu;
 
 	return 0;
 }
diff --git a/net/batman-adv/types.h b/net/batman-adv/types.h
index ca9449ec9836..cf1a0eafe3ab 100644
--- a/net/batman-adv/types.h
+++ b/net/batman-adv/types.h
@@ -1546,6 +1546,12 @@ struct batadv_priv {
 	/** @soft_iface: net device which holds this struct as private data */
 	struct net_device *soft_iface;
 
+	/**
+	 * @mtu_set_by_user: MTU was set once by user
+	 * protected by rtnl_lock
+	 */
+	int mtu_set_by_user;
+
 	/**
 	 * @bat_counters: mesh internal traffic statistic counters (see
 	 *  batadv_counters)
-- 
2.39.2

