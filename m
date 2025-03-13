Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79A70C282DE
	for <batman-adv@archiver.kernel.org>; Thu, 13 Mar 2025 16:20:41 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 219BD84467
	for <batman-adv@archiver.kernel.org>; Thu, 13 Mar 2025 17:20:40 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1741882840;
 b=gM6bcX0S2dJi+wr9daBa8lqnUriW+OAhkzbpSEHH0ReFwLiHPPTVdoQAwNd+HHZQlvipE
 4HuAy569hFqvCiELgdRNRSEZDxGkKx4TqUD2whNwVafU/AyIX4sQy3e3+wo7mNi9CYnGr7z
 EbGms2Bk70UEMAYknWXvf0Z898ib+n4=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1741882840; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=WKgqnU0Pmo+qx3MMfqOi7/R+7o8P9CvLJ/4hD3JLtq4=;
 b=iusRgHGShBLP9G8jv/jyEA67F82tReZYFTHzXY0MaDwVOWnP6U8bAzaZX3MQfTkpvfFen
 39RctsnFdh8JOxi4ZtjQ45wy1BJYHf+CQ64xFl8Ofj/UY3K2c773uAQrkOIlk18UWRZz/aY
 PfrHd7wXqcN7BmbhWx2v22kpbQ9vbV4=
ARC-Authentication-Results: i=2; open-mesh.org; dkim=fail;
  arc=pass;
  dmarc=fail (Used From Domain Record) header.from=simonwunderlich.de
 policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=fail; arc=pass;
 dmarc=fail (Used From Domain Record) header.from=simonwunderlich.de
 policy.dmarc=none
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de
 [IPv6:2a01:4f8:c17:e8c0::1])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id C36368424B
	for <b.a.t.m.a.n@lists.open-mesh.org>; Thu, 13 Mar 2025 17:17:46 +0100 (CET)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1741882666;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WKgqnU0Pmo+qx3MMfqOi7/R+7o8P9CvLJ/4hD3JLtq4=;
	b=3DhQYq2i0dcBADF1AqLMV5810QnZxqvGkOWOUfw775YpS7HEV6yIXSyztMJ1VCbmJ+5KF8
	NdZ2CwK1gqpg328XoNSfdzO7MC/n3N+BRX9gXXkKtWZdsDXRkzwQ+JZna7Uo6vPb4spd0E
	3S81baX+tvgTq1nvHwTFTFTwXIYCmUo=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=none;
	dmarc=pass (policy=none) header.from=simonwunderlich.de;
	spf=pass (diktynna.open-mesh.org: domain of sw@simonwunderlich.de designates
 2a01:4f8:c17:e8c0::1 as permitted sender) smtp.mailfrom=sw@simonwunderlich.de
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1741882666; a=rsa-sha256;
	cv=none;
	b=HUlMM7A4JpsfTSQaPURTbfwt9sN0Crzkja9KkZmbnBHrD1xnpEslm3K9VLdsc/a7WlEJzI
	BVdizmDjkCvzUVfHWBPhegzj4J8W2bV5dqXpwSBrvtrEZumyhcMKEnq3NDMdXQZoK+uWmM
	giDdxOmsiTxosIaHhTNOxWQ3ONHrKtc=
Received: from kero.packetmixer.de
 (p200300fA272413901A38A4bc9c0De305.dip0.t-ipconnect.de
 [IPv6:2003:fa:2724:1390:1a38:a4bc:9c0d:e305])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits)
 server-digest SHA256)
	(No client certificate requested)
	by mail.simonwunderlich.de (Postfix) with ESMTPSA id 6DB72FA449;
	Thu, 13 Mar 2025 17:17:46 +0100 (CET)
From: Simon Wunderlich <sw@simonwunderlich.de>
To: davem@davemloft.net,
	kuba@kernel.org
Cc: netdev@vger.kernel.org,
	b.a.t.m.a.n@lists.open-mesh.org,
	Sven Eckelmann <sven@narfation.org>,
	stable@vger.kernel.org,
	Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH 5/5] batman-adv: Ignore own maximum aggregation size during RX
Date: Thu, 13 Mar 2025 17:17:38 +0100
Message-Id: <20250313161738.71299-6-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250313161738.71299-1-sw@simonwunderlich.de>
References: <20250313161738.71299-1-sw@simonwunderlich.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: OLXSLSZINIEYNO4W4LLUEHORKMR3SBHS
X-Message-ID-Hash: OLXSLSZINIEYNO4W4LLUEHORKMR3SBHS
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/OLXSLSZINIEYNO4W4LLUEHORKMR3SBHS/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

From: Sven Eckelmann <sven@narfation.org>

An OGMv1 and OGMv2 packet receive processing were not only limited by the
number of bytes in the received packet but also by the nodes maximum
aggregation packet size limit. But this limit is relevant for TX and not
for RX. It must not be enforced by batadv_(i)v_ogm_aggr_packet to avoid
loss of information in case of a different limit for sender and receiver.

This has a minor side effect for B.A.T.M.A.N. IV because the
batadv_iv_ogm_aggr_packet is also used for the preprocessing for the TX.
But since the aggregation code itself will not allow more than
BATADV_MAX_AGGREGATION_BYTES bytes, this check was never triggering (in
this context) prior of removing it.

Cc: stable@vger.kernel.org
Fixes: c6c8fea29769 ("net: Add batman-adv meshing protocol")
Fixes: 9323158ef9f4 ("batman-adv: OGMv2 - implement originators logic")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/bat_iv_ogm.c | 3 +--
 net/batman-adv/bat_v_ogm.c  | 3 +--
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/net/batman-adv/bat_iv_ogm.c b/net/batman-adv/bat_iv_ogm.c
index 07ae5dd1f150..b12645949ae5 100644
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
index e503ee0d896b..8f89ffe6020c 100644
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
2.39.5

