Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CBEAC0218F
	for <batman-adv@archiver.kernel.org>; Sun,  2 Feb 2025 16:07:15 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 81A4D842A0
	for <batman-adv@archiver.kernel.org>; Sun,  2 Feb 2025 17:07:13 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1738512433;
 b=3sRMzF2PMXJasoKCDjRJzwQRxmxZglaxg2G/yhEz4aoAraFmNx50VoGra9DzYR72t/ADX
 vYoeBL4nUbUIJ/fj5+K0m97Jol8LnW5apHjApwazwb3jGg/yQIpXgdxBvLuG8H05O1zahQb
 ngvvsp/rIhIN7d4CaTtJcY0T6MWCaAA=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1738512433; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=oGapBlmMw9gEkPQs8Ge7PbYGBZyCEN9nPgYV9QYHe3c=;
 b=dH7ZjqCtamJtKhO4P/Ups5aUTDNXvMigW0XITV29Ga3vLWG4Ny25TOLPMSIdrtSurL8E0
 CSGbiLOx995y7g5c5QpEPrUvbe2BoTCL/TnkVS89LLEj3avtMdjICReUqTUbGSIYsK1m6n2
 J4qaRnix9sCXAswGCfNcMKd2OM/t6C4=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
  arc=pass;
  dmarc=pass (Used From Domain Record) header.from=narfation.org
 policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 4CFEC840AE
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sun,  2 Feb 2025 17:04:36 +0100 (CET)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1738512276;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=oGapBlmMw9gEkPQs8Ge7PbYGBZyCEN9nPgYV9QYHe3c=;
	b=sShYmZLZc/I5lKUuUdp0saEmAYsprRzH0yvfti3zd1ZhHzYLlkO6FafUaUXv/60wtvyuss
	+P+RMqokCtzeEsg97o3fUMrAgI41BtST9xQSAbu4SoyOH4xQftEfxdd46m1mv2V4+fkwTo
	bNMUwJ4muEWLgv5o0zBendL3kV+HYt0=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=hGnD5Ihd;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1738512276; a=rsa-sha256;
	cv=none;
	b=st+CRj74LhEp4/MlJ11k8YgHcDPN38y/IOjKzNYUjZ8ELrQSty8U84taMG9AHfBzDaiF3L
	s29TJVRBmfV7yrHhWZbhhi0S4xI7NSMU2aKl4rHubidGsiIbweOhuXK+ELbQXd41mpQ0D2
	+tAOyhcxMeA5zGqbAszd4FHW+4yadak=
Received: from sven-desktop.home.narfation.org (unknown
 [IPv6:2a00:1ca0:1d86:2efc::ab85])
	by dvalin.narfation.org (Postfix) with UTF8SMTPSA id 04D0A1FFC7;
	Sun,  2 Feb 2025 16:04:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1738512276;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oGapBlmMw9gEkPQs8Ge7PbYGBZyCEN9nPgYV9QYHe3c=;
	b=hGnD5IhdK3OeaMoz4bLGMzD8wmp3qEUg5GoSezxfDNXRBYW0GLxu9oRp2m4/fRqAtMQyC2
	xM4uyWhMm7qZsY31BIewVBAP24VhXQPJD5rbm2iSU1rB20F1qAd6ro74gk3YcZbmf2HbP7
	td3WoDm5T0YFc7cVnj6B6Ny8BcR5gns=
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 02 Feb 2025 17:04:13 +0100
Subject: [PATCH 4/5] batman-adv: Ignore own maximum aggregation size during
 RX
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250202-bitmap_aggregation-v1-4-6542a10e6fad@narfation.org>
References: <20250202-bitmap_aggregation-v1-0-6542a10e6fad@narfation.org>
In-Reply-To: <20250202-bitmap_aggregation-v1-0-6542a10e6fad@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1995; i=sven@narfation.org;
 h=from:subject:message-id; bh=krp5/3huzASscHdXC5MUgCNE3wYmU1VSwpJUmfOImcU=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDOnzp9eUehT1X47vqlNy1V/cGdEo7KRfwzpxavTagCK+V
 QJf2Ys7SlkYxLgYZMUUWfZcyT+/mf2t/OdpH4/CzGFlAhnCwMUpABOJjmRkeJKaa8FZza1bOu3K
 AS3bfjbe9Qnqf6Y5738up6q7/njAd4b/nm36HMkLYx6HfrCZKL3/TOuv512OhtfPhfakqV3I1ln
 EDgA=
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: DHMUUSIHRICQXO72WCTWT4LTG3ZDHOLC
X-Message-ID-Hash: DHMUUSIHRICQXO72WCTWT4LTG3ZDHOLC
X-MailFrom: sven@narfation.org
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/DHMUUSIHRICQXO72WCTWT4LTG3ZDHOLC/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

An OGMv1 and OGMv2 packet receive processing were not only limited by the
number of bytes in the received packet but also by the nodes maximum
aggregation packet size limit. But this limit is relevant for TX and not
for RX. It should thefore not be enforced by batadv_(i)v_ogm_aggr_packet

This has a minor side effect for B.A.T.M.A.N. IV because the
batadv_iv_ogm_aggr_packet is also used for the preprocessing for the TX.
But since the aggregation code itself will not allow more than
BATADV_MAX_AGGREGATION_BYTES bytes, this check was never triggering prior
of removing it.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/bat_iv_ogm.c | 3 +--
 net/batman-adv/bat_v_ogm.c  | 3 +--
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/net/batman-adv/bat_iv_ogm.c b/net/batman-adv/bat_iv_ogm.c
index a43c268b2a3028c9a36fe8ce060cfb23ac5f9381..769d5ff779eb88de8b9d889bb3e4a3304875ea32 100644
--- a/net/batman-adv/bat_iv_ogm.c
+++ b/net/batman-adv/bat_iv_ogm.c
@@ -325,8 +325,7 @@ batadv_iv_ogm_aggr_packet(int buff_pos, int packet_len,
 	/* check if there is enough space for the optional TVLV */
 	next_buff_pos += ntohs(ogm_packet->tvlv_len);
 
-	return (next_buff_pos <= packet_len) &&
-	       (next_buff_pos <= BATADV_MAX_AGGREGATION_BYTES);
+	return next_buff_pos <= packet_len;
 }
 
 /* send a batman ogm to a given interface */
diff --git a/net/batman-adv/bat_v_ogm.c b/net/batman-adv/bat_v_ogm.c
index e503ee0d896bd52bb5827102a7a57fc07279f0bd..8f89ffe6020ced5668dc90ac438ecd6dcd1d74b6 100644
--- a/net/batman-adv/bat_v_ogm.c
+++ b/net/batman-adv/bat_v_ogm.c
@@ -839,8 +839,7 @@ batadv_v_ogm_aggr_packet(int buff_pos, int packet_len,
 	/* check if there is enough space for the optional TVLV */
 	next_buff_pos += ntohs(ogm2_packet->tvlv_len);
 
-	return (next_buff_pos <= packet_len) &&
-	       (next_buff_pos <= BATADV_MAX_AGGREGATION_BYTES);
+	return next_buff_pos <= packet_len;
 }
 
 /**

-- 
2.47.2

