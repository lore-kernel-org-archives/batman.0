Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE2DEC43458
	for <batman-adv@archiver.kernel.org>; Thu,  2 Jul 2026 09:46:59 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 4703D80FA2
	for <batman-adv@archiver.kernel.org>; Thu, 02 Jul 2026 11:46:58 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1782985618;
 b=e4uqcw7TMMQjfDv1GZBADBpzmYr66zP58gAeFVaPd1rOjHuH9Qv+tvuCEIOv0yIBD5pkL
 +R0ooH/CNwBc9r3jSNK4kVzHu5PEJ1uRnE3BwxCYfzzCri2Mq0dqWo6YOkfp+8czFG1daEE
 kCMF2hhOEXjr7B/hHWPhxpb8F2eQk1E=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1782985618; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=izJuo+msxj1C8WKiv+RCUBtfhucC6iMO9hjfUuqTw5U=;
 b=GkPyyPP5qOlkP3NnsDaA5bCShcQDUFfS4xCexfSFO3JUUdpwABQyUlYDL/1Vv65lVOZ1l
 j/SCmt5k74mNLHC9lSZVvSU1W12uZNv6S2xKm56dQhGrRPsX7kmhpMXLPNpocfLtZ8L/Muy
 T0ZSMMGjVgA/Xia41Crk5diIsEEXcpo=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id B15D380824
	for <b.a.t.m.a.n@lists.open-mesh.org>; Thu, 02 Jul 2026 11:46:26 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1782985596;
	b=N7qBJJ6v2U8/w+xl9SsPKMoaqTxbLR45ccVfhTruJIR/xvAnoHfpUi5GaqZ4laQZIEglsJ
	DXoCRBeWfNd2eHWQa4Zo2f4czPgnjY6Kad9nCW0D0VuJKDYsFMHtmzPj5kzLBGtgaUhiTG
	FEiFCb6H5292LvyXxdOp0XsJYucRJKw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1782985596;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:dkim-signature;
	bh=izJuo+msxj1C8WKiv+RCUBtfhucC6iMO9hjfUuqTw5U=;
	b=hfqMDRWf5I7m5RaIEHiVZqFU26s0Rbf/d878yB0hhDD6JfWloFGPafamJbfE6feEtu4Bth
	MYpbsxaubeVlYWtDh9nCgEnYA064Pu1pdX5ulyjOsYs6fxdntjt/1hjQH/Me24gaiX30Y4
	eqyuYAxqB3F6+EdwOSh2UE9NDKscLcw=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=z6YIPQ3Z;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id A72CF1FE5D;
	Thu, 02 Jul 2026 09:46:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1782985585;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=izJuo+msxj1C8WKiv+RCUBtfhucC6iMO9hjfUuqTw5U=;
	b=z6YIPQ3ZOTPCgRYsVK0LxLYFSa2BlIhErWIZwVn7t6DjiALhRh3j67qCkuy3sENhx2FMH6
	bAkUhtIQz8UN093+3XMlaBre42rAU6CpWWjj69tfFZIQsHfAYLZTnfMGKE6DVVXN0NbwkX
	6Bn/tRgUc4YZ4osB9DDS5/pH0QoURqs=
From: Sven Eckelmann <sven@narfation.org>
Date: Thu, 02 Jul 2026 11:46:21 +0200
Subject: [PATCH batadv] batman-adv: ensure minimal ethernet header on TX
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260702-tx-may-pull-v1-1-f860d3a3cffd@narfation.org>
X-B4-Tracking: v=1; b=H4sIAGwzRmoC/yWMwQ6CMBAFf4W8s5ssNaHGXzEeFtjqGkTSFoIh/
 LtVjzPJzIak0TThXG2Iuliy11igPlTo7jLelKwvDMeuYc+O8kpPedM0DwP50DjhU6j9kVGKKWq
 w9Xe7oJUs/YLr36e5fWiXvyvs+wdcdL7ddwAAAA==
X-Change-ID: 20260702-tx-may-pull-7f62a08f1730
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sashiko <sashiko-bot@kernel.org>, Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1469; i=sven@narfation.org;
 h=from:subject:message-id; bh=4xftEZTl/lgpHPQ8u7YetWq1h2/e6U7jbYY7lorl1Mo=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFluxvm1gZVHGLx6mN5YJDxVEGnbfJxprpb0duFWxS9vw
 2bt9bzTUcrCIMbFICumyLLnSv75zexv5T9P+3gUZg4rE8gQBi5OAbiIAMP/8JWcEybP9NiYdzK7
 93XuZJb1i1mMykRvv1W/JvN9jabvB0aGm3tWhTlYCvpWuvtdZV/86OFPXp7/8ovW6zoUr04Mrvz
 BBQA=
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: THJNCLI57HNJXQ6CKEPCUCREKBLVBQUC
X-Message-ID-Hash: THJNCLI57HNJXQ6CKEPCUCREKBLVBQUC
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/THJNCLI57HNJXQ6CKEPCUCREKBLVBQUC/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

As documented in commit 8bd67ebb50c0 ("net: bridge: xmit: make sure we have
at least eth header len bytes"), it is possible by for a local user with
eBPF TC hook access to attach a tc filter which truncates the packet and
redirects to an batadv interface. But the code assumes that at least
ETH_HLEN bytes are available and thus might read outside of the available
buffer.

The batadv_interface_tx() must therefore always check itself if enough data
is available for the ethernet header and don't rely on min_header_len.

Fixes: 094a751463a9 ("route outgoing traffic")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/mesh-interface.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/batman-adv/mesh-interface.c b/net/batman-adv/mesh-interface.c
index a17514ea..7803c5d3 100644
--- a/net/batman-adv/mesh-interface.c
+++ b/net/batman-adv/mesh-interface.c
@@ -235,6 +235,9 @@ static netdev_tx_t batadv_interface_tx(struct sk_buff *skb,
 	if (READ_ONCE(bat_priv->mesh_state) != BATADV_MESH_ACTIVE)
 		goto dropped;
 
+	if (!pskb_may_pull(skb, ETH_HLEN))
+		goto dropped;
+
 	/* reset control block to avoid left overs from previous users */
 	memset(skb->cb, 0, sizeof(struct batadv_skb_cb));
 

---
base-commit: 9bd026856d0c9680390b1a1a42ae0fd44532c3d4
change-id: 20260702-tx-may-pull-7f62a08f1730

Best regards,
--  
Sven Eckelmann <sven@narfation.org>

