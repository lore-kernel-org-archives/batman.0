Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D8D1C0015E
	for <batman-adv@archiver.kernel.org>; Wed, 19 Jul 2023 08:17:04 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 9E9C68267A
	for <batman-adv@archiver.kernel.org>; Wed, 19 Jul 2023 10:17:02 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1689754622;
 b=qmppDg0OQW+yuVfACXYZB8PbqSGnZAQrs0fBcCb80yGUo0//tT678E+jkU7g/+oxKLE+p
 zX4jkQosFJMPYYMPNqbVvMVoComZQWpTJjR0RjkK7tjzJfpFD4hkYb6KuoXz5WQ68Fn+HYz
 tI6dM75K8KNW9QrIcPzDEYusaHBZSUs=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1689754622; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=D4yCP+kPBfAcMFcbUlzk/L1SR8XiLbCQWDuFAAf2P1c=;
 b=XvloqFPjXXA7xB9U9U/AJ08317Fwn5PhYyQDhv6+9IFqaLtwEChdb6w1gMxCjBEwt1Sce
 nSovw0s6q/gPfApKiCOPpGPQWytXXq6b7iz+XRpIWCX9Wvy0w+N6AOHaero78aHX/mHxNLC
 7NVjhAXzkBicXTYwoYYw5jT26TQiFnw=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
  arc=pass;
  dmarc=pass (Used From Domain Record) header.from=narfation.org
 policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org
 [IPv6:2a00:17d8:100::8b1])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 6487A81B76
	for <b.a.t.m.a.n@lists.open-mesh.org>; Wed, 19 Jul 2023 10:15:35 +0200 (CEST)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1689754535;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=D4yCP+kPBfAcMFcbUlzk/L1SR8XiLbCQWDuFAAf2P1c=;
	b=ydoTDvahRUBccOciIZH4wHkrIXVWuqpoVTFGIirGc2XG39SIpJliILe1S03ZNZxATGUFmL
	HcPpqWOGqKK4HnAxRJxzU/UisUpFLJu1zOGprnHmIQuMN5+CNImakIuA5y1mx0PXIf+BwG
	DSgr+06a63snyK4dpOBNpFUENnWXVhc=
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1689754535; a=rsa-sha256;
	cv=none;
	b=er/5+CfABsu9brjldIG70L8hy76zOTjeJmCBgbYuyT+J+Qe8i6xTz2AwAx25oBRnDDAbpK
	2j0e2snU4laTZ1drDDJS1Yj+hPGeckz6e2ONL7dlLLYy6HN8+KD9ebVGE+yOqHdIiqzIGa
	DCu8rIIzOv64e8YGMaxFDjlZbjek6a0=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=PmJ6LGBa;
	dmarc=pass (policy=none) header.from=narfation.org;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1689754534;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=D4yCP+kPBfAcMFcbUlzk/L1SR8XiLbCQWDuFAAf2P1c=;
	b=PmJ6LGBa62bpqxnkddGegtSK8R0xiybTMuFroYcj0MT12pkurLbhPdggkCmJgm/Xli7iHb
	tBFlqjkhbQoH6sUAShJAGyTft7C6g9vN/DChj2ZCHAgwZNLAGwELgvfmzJiSZKN9rf3wKQ
	8Yzwu3ESolgAgHY5CVosk4M3W0LCZmo=
From: Sven Eckelmann <sven@narfation.org>
Date: Wed, 19 Jul 2023 10:15:06 +0200
Subject: [PATCH 2/2] batman-adv: Don't increase MTU when set by user
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230719-mtu-v1-2-48fd024f0f56@narfation.org>
References: <20230719-mtu-v1-0-48fd024f0f56@narfation.org>
In-Reply-To: <20230719-mtu-v1-0-48fd024f0f56@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2731; i=sven@narfation.org;
 h=from:subject:message-id; bh=mnEOlgLRcyvbgwlPBj8TvwY3NzW7oLcU9IpSL/TvYEA=;
 b=owEBbQKS/ZANAwAKAV2HCgfBJntGAcsmYgBkt5ueWpmnLb7qupxcmQFXTJafSO6QoSZKNeTJm
 6mlvEaLJvqJAjMEAAEKAB0WIQQXXSuHYSVz3OMy4AJdhwoHwSZ7RgUCZLebngAKCRBdhwoHwSZ7
 RqTmD/0VfqG8CeFO36jIdnOjHwwoGl+Q/YnwYndtJGqeX/pAwH+/0dBCZOcrBviYIz5MlAbhgGW
 Ke8oRrlXX2X+lFSapy9bpBG1V32lgcwAmwHyG6kN4OogvmaICod39YLZMHUPaLcAAPINTacazKw
 cPZ25CReQTSLhx5qqysKx2LAcO1aHp2DXpIti0x2PenW2yP+WdCD4mdHdUX5jqu4dZ6yErkZdtq
 ZQ3fzGSBcgJd5mZvOrCSH5WB/p054l+DnFgAq42k2+7I87nT0JekrbPd5yUVMGxHU4/dhmwogK/
 AeXpxIr2xuHck66or4KVrVVBzrF3DBEpuVHqLQj5ErVHrjRGCNAmVy2LIU02P4W5vF66n9wlOhc
 FQMByvKQeYtvIA957tYsYqCcNehUV4RfmSn7ylcL8Fe9bF5RrOnHhwaK68I5IFm25Dqylvvcdn5
 56qkQHbC9JrBMLh3ZJ/Qr2GV9j/+euc6lDIPfaKPRbbFXCfzQBC4T/ekx5Ge2+KMXhg91e41FSj
 2wZEqTbHcrURcvfnETiYAGqbFFFb26HU3Zoo/Jz0Uv0NfQFfx69yqxw2oAVBxU8bHs9GOz9VzGR
 ZO+g89+0O2xC4v3+gpnjG3JfRmPoEQSN2FG6Mwlz7BMjYi1HWFZ85uD6PICA0932o+hKWr4QIs1
 bVliTVV44oVxlQw==
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: 55R44KQQVMRXEYYRKAQBUWSQBDXZ2MFG
X-Message-ID-Hash: 55R44KQQVMRXEYYRKAQBUWSQBDXZ2MFG
X-MailFrom: sven@narfation.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-0;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/55R44KQQVMRXEYYRKAQBUWSQBDXZ2MFG/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

If the user set an MTU value, it usually means that there are special
requirements for the MTU. But if an interface gots activated, the MTU was
always recalculated and then the user set value was overwritten.

The only reason why this user set value has to be overwritten, is when the
MTU has to be decreased because batman-adv is not able to transfer packets
with the user specified size.

Fixes: 88861ea9acb7 ("[batman-adv] replacing if up/down timer with kernel notifications")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/hard-interface.c | 14 +++++++++++++-
 net/batman-adv/soft-interface.c |  3 +++
 net/batman-adv/types.h          |  6 ++++++
 3 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/net/batman-adv/hard-interface.c b/net/batman-adv/hard-interface.c
index ae5762af..24c9c0c3 100644
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
index d3fdf822..85d00dc9 100644
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
index ca9449ec..cf1a0eaf 100644
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

