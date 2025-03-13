Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FF74C282DE
	for <batman-adv@archiver.kernel.org>; Thu, 13 Mar 2025 16:47:50 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 28C1F84593
	for <batman-adv@archiver.kernel.org>; Thu, 13 Mar 2025 17:47:49 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1741884469;
 b=nTHPmrs29SS2+omXoZ7AR62ncLZSQppzfR6eDtkIPPKcED1KzayFpWQBVNh/9iwebP19M
 ohOnnWwxZIdnOZyIRv31oiM52f1kkzx95VY443IvE9xBTSMVk8vtGSpTI8hiwW+T3aBaVaw
 sRqaIUO0AxtcyzMt7QCTGPS61qewC7k=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1741884469; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=IgGnZbzKGmqqXYX3lVkJC2Sga6YGY6l+7jSrqeAsIzA=;
 b=dKA0jD1bZnUeQC5YMt3SYeSjOYgzdW0D82OMfFZTZkMyuQzoCYDRzoiNLgtCCFMEXsBeU
 SIO1sS3buQWdrGKrzky6yAPZkD97DSRiTy1cEZamp8gwpDSmafzu+0m/X7KFtvy3AcqRc9A
 1L+enWAVeowNgPup2VC9Tb82a1qIc4w=
ARC-Authentication-Results: i=2; open-mesh.org; dkim=fail;
  arc=pass;
  dmarc=fail (Used From Domain Record) header.from=simonwunderlich.de
 policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=fail; arc=pass;
 dmarc=fail (Used From Domain Record) header.from=simonwunderlich.de
 policy.dmarc=none
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de
 [IPv6:2a01:4f8:c17:e8c0::1])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id B5705821A0
	for <b.a.t.m.a.n@lists.open-mesh.org>; Thu, 13 Mar 2025 17:45:26 +0100 (CET)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1741884326;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IgGnZbzKGmqqXYX3lVkJC2Sga6YGY6l+7jSrqeAsIzA=;
	b=3sKAp1C72JRsVBBLmbRPmj9R9CrmnA5P2yvZjb34uwsF4z88RUtRAkVJMRAVTYA2t//WQn
	M6HzkCA9+6DFdBA1MvS74BNaiezWMB+F/sX4t4iQN+fN/fUdacvjjRti8t/1/eu/72TF/R
	Pumn5MJXp9PTyp7+MMbYnyaB/FjkukI=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=none;
	dmarc=pass (policy=none) header.from=simonwunderlich.de;
	spf=pass (diktynna.open-mesh.org: domain of sw@simonwunderlich.de designates
 2a01:4f8:c17:e8c0::1 as permitted sender) smtp.mailfrom=sw@simonwunderlich.de
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1741884326; a=rsa-sha256;
	cv=none;
	b=2fx5vvhf545McYMI/cBe9oP6aI997XqSFA2c6pHXU5zJPIRfYcRFTxsNqbnYwuroXBILt1
	GizgqiVP0qWLzI5PhPxKjl6pNhob19XoYE4QGtzui2W7VoJ3hjtBOv6J51OhaCnt5nxruf
	T2YyYYA7iZfKE0VtKxMEqkMSvvzNYFY=
Received: from kero.packetmixer.de
 (p200300FA272413901a38a4Bc9C0DE305.dip0.t-ipconnect.de
 [IPv6:2003:fa:2724:1390:1a38:a4bc:9c0d:e305])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits)
 server-digest SHA256)
	(No client certificate requested)
	by mail.simonwunderlich.de (Postfix) with ESMTPSA id 36BD2FA1EE;
	Thu, 13 Mar 2025 17:45:26 +0100 (CET)
From: Simon Wunderlich <sw@simonwunderlich.de>
To: kuba@kernel.org,
	davem@davemloft.net
Cc: netdev@vger.kernel.org,
	b.a.t.m.a.n@lists.open-mesh.org,
	Sven Eckelmann <sven@narfation.org>,
	Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH 04/10] batman-adv: Add support for jumbo frames
Date: Thu, 13 Mar 2025 17:45:13 +0100
Message-Id: <20250313164519.72808-5-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250313164519.72808-1-sw@simonwunderlich.de>
References: <20250313164519.72808-1-sw@simonwunderlich.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: CPILB3HA3EH5ED27474AHPJUPLSJODQG
X-Message-ID-Hash: CPILB3HA3EH5ED27474AHPJUPLSJODQG
X-MailFrom: sw@simonwunderlich.de
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/CPILB3HA3EH5ED27474AHPJUPLSJODQG/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

From: Sven Eckelmann <sven@narfation.org>

Since batman-adv is not actually depending on hardware capabilities, it has
no limit on the MTU. Only the lower hard interfaces can limit it. In case
these have an high enough MTU or fragmentation is enabled, a higher MTU
than 1500 can be enabled.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/hard-interface.c | 4 +---
 net/batman-adv/main.h           | 2 ++
 net/batman-adv/soft-interface.c | 3 ++-
 3 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/net/batman-adv/hard-interface.c b/net/batman-adv/hard-interface.c
index 71b2236c0058..e7e7f14da03c 100644
--- a/net/batman-adv/hard-interface.c
+++ b/net/batman-adv/hard-interface.c
@@ -618,10 +618,8 @@ int batadv_hardif_min_mtu(struct net_device *soft_iface)
 
 	/* the real soft-interface MTU is computed by removing the payload
 	 * overhead from the maximum amount of bytes that was just computed.
-	 *
-	 * However batman-adv does not support MTUs bigger than ETH_DATA_LEN
 	 */
-	return min_t(int, min_mtu - batadv_max_header_len(), ETH_DATA_LEN);
+	return min_t(int, min_mtu - batadv_max_header_len(), BATADV_MAX_MTU);
 }
 
 /**
diff --git a/net/batman-adv/main.h b/net/batman-adv/main.h
index 626618d0c366..4ecc304eaddd 100644
--- a/net/batman-adv/main.h
+++ b/net/batman-adv/main.h
@@ -22,6 +22,8 @@
 #define BATADV_THROUGHPUT_MAX_VALUE 0xFFFFFFFF
 #define BATADV_JITTER 20
 
+#define BATADV_MAX_MTU (ETH_MAX_MTU - batadv_max_header_len())
+
 /* Time To Live of broadcast messages */
 #define BATADV_TTL 50
 
diff --git a/net/batman-adv/soft-interface.c b/net/batman-adv/soft-interface.c
index d893c8013261..b1127e6e8900 100644
--- a/net/batman-adv/soft-interface.c
+++ b/net/batman-adv/soft-interface.c
@@ -790,7 +790,7 @@ static int batadv_softif_init_late(struct net_device *dev)
 	atomic_set(&bat_priv->log_level, 0);
 #endif
 	atomic_set(&bat_priv->fragmentation, 1);
-	atomic_set(&bat_priv->packet_size_max, ETH_DATA_LEN);
+	atomic_set(&bat_priv->packet_size_max, BATADV_MAX_MTU);
 	atomic_set(&bat_priv->bcast_queue_left, BATADV_BCAST_QUEUE_LEN);
 	atomic_set(&bat_priv->batman_queue_left, BATADV_BATMAN_QUEUE_LEN);
 
@@ -1043,6 +1043,7 @@ static void batadv_softif_init_early(struct net_device *dev)
 	 * have not been initialized yet
 	 */
 	dev->mtu = ETH_DATA_LEN;
+	dev->max_mtu = BATADV_MAX_MTU;
 
 	/* generate random address */
 	eth_hw_addr_random(dev);
-- 
2.39.5

