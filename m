Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 020AAC282EC
	for <batman-adv@archiver.kernel.org>; Thu, 13 Mar 2025 16:49:30 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 9C2EE8460C
	for <batman-adv@archiver.kernel.org>; Thu, 13 Mar 2025 17:49:29 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1741884569;
 b=wuPyxXcvqztvm+Plrb1tSrPNtVb0VP7pG3aQpDAdi4zHfiOawpWN5QTolb2W7BbRoN581
 VZPmy8heR8sMsTMtMOnIIGxqRuOZR9zdegf9Bkyckf5RLk46ogWwaWpT205YAKGMyu6k4K4
 n+iQ8xhJUSgigwtSOCxQxGAacDebyoc=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1741884569; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=W+guuA26qts4VGEaeqsTiXelDklseMCE5w3Bkd/+XgM=;
 b=iVUYdXZAmQrnqOjrMPDE0Wp71ZjnLSmOShLZQwhytclWcxLsB6XSZO39z2x53ckSVaHPU
 XVGOWpgUdq6D10/muWnI1r9wz7ccc8Bv7NRZa0rJyIJBqtLFqpvttMc5HI4Mz7w5zHkAP+H
 kOJYg3eSgqM1Kdgkhi44KF1A/2ZHPAo=
ARC-Authentication-Results: i=2; open-mesh.org; dkim=fail;
  arc=pass;
  dmarc=fail (Used From Domain Record) header.from=simonwunderlich.de
 policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=fail; arc=pass;
 dmarc=fail (Used From Domain Record) header.from=simonwunderlich.de
 policy.dmarc=none
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de
 [IPv6:2a01:4f8:c17:e8c0::1])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 515148426F
	for <b.a.t.m.a.n@lists.open-mesh.org>; Thu, 13 Mar 2025 17:45:30 +0100 (CET)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1741884330;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=W+guuA26qts4VGEaeqsTiXelDklseMCE5w3Bkd/+XgM=;
	b=ZzutOesPEWVwAT50aJ/ZbkUuRCK9liWHf5WLDkaO3d2tXI3DQhOD9TWpphICd2YwI5YxCW
	nbob2/fL9XuGgPN9FrlgwatGxNdw6g8puu0Wee0zI1mqH79CscdEkmc5PUCxKzToNLrSd/
	6ZIPr2g+AE3bCIQzAtVfuOnTPho7idY=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=none;
	dmarc=pass (policy=none) header.from=simonwunderlich.de;
	spf=pass (diktynna.open-mesh.org: domain of sw@simonwunderlich.de designates
 2a01:4f8:c17:e8c0::1 as permitted sender) smtp.mailfrom=sw@simonwunderlich.de
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1741884330; a=rsa-sha256;
	cv=none;
	b=ttmlllvvmRj5O1OtYkstDckPg9Qe7kEAfJxFWONg7QrHLp2/YJE0sejFCg/czpW52pCTC2
	8hdeij9+Y0jmhy8OeHmpfSKll2J0PLNP/TqiZsI28q9R3wlEUOflPFua+cqlI/bkB4skcQ
	gMbkKbPpTyCym17C8tQPyFxL2fPjafA=
Received: from kero.packetmixer.de
 (p200300fA272413901A38A4BC9c0De305.dip0.t-ipconnect.de
 [IPv6:2003:fa:2724:1390:1a38:a4bc:9c0d:e305])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits)
 server-digest SHA256)
	(No client certificate requested)
	by mail.simonwunderlich.de (Postfix) with ESMTPSA id DCA3BFA44A;
	Thu, 13 Mar 2025 17:45:29 +0100 (CET)
From: Simon Wunderlich <sw@simonwunderlich.de>
To: kuba@kernel.org,
	davem@davemloft.net
Cc: netdev@vger.kernel.org,
	b.a.t.m.a.n@lists.open-mesh.org,
	Sven Eckelmann <sven@narfation.org>,
	Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH 08/10] batman-adv: Use actual packet count for aggregated
 packets
Date: Thu, 13 Mar 2025 17:45:17 +0100
Message-Id: <20250313164519.72808-9-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250313164519.72808-1-sw@simonwunderlich.de>
References: <20250313164519.72808-1-sw@simonwunderlich.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: ZWHXHPEBC6UITDS477QTEXNAXYIXIQMB
X-Message-ID-Hash: ZWHXHPEBC6UITDS477QTEXNAXYIXIQMB
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/ZWHXHPEBC6UITDS477QTEXNAXYIXIQMB/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

From: Sven Eckelmann <sven@narfation.org>

The batadv_forw_packet->num_packets didn't store the number of packets but
the the number of packets - 1. This didn't had any effects on the actual
handling of aggregates but can easily be a source of confusion when reading
the code.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/bat_iv_ogm.c | 5 +++--
 net/batman-adv/send.c       | 2 +-
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/net/batman-adv/bat_iv_ogm.c b/net/batman-adv/bat_iv_ogm.c
index 87c1af540457..a20d7f3004c1 100644
--- a/net/batman-adv/bat_iv_ogm.c
+++ b/net/batman-adv/bat_iv_ogm.c
@@ -446,7 +446,7 @@ batadv_iv_ogm_can_aggregate(const struct batadv_ogm_packet *new_bat_ogm_packet,
 	struct batadv_ogm_packet *batadv_ogm_packet;
 	int aggregated_bytes = forw_packet->packet_len + packet_len;
 	struct batadv_hard_iface *primary_if = NULL;
-	u8 packet_num = forw_packet->num_packets + 1;
+	u8 packet_num = forw_packet->num_packets;
 	bool res = false;
 	unsigned long aggregation_end_time;
 
@@ -600,12 +600,13 @@ static void batadv_iv_ogm_aggregate(struct batadv_forw_packet *forw_packet_aggr,
 {
 	skb_put_data(forw_packet_aggr->skb, packet_buff, packet_len);
 	forw_packet_aggr->packet_len += packet_len;
-	forw_packet_aggr->num_packets++;
 
 	/* save packet direct link flag status */
 	if (direct_link)
 		set_bit(forw_packet_aggr->num_packets,
 			forw_packet_aggr->direct_link_flags);
+
+	forw_packet_aggr->num_packets++;
 }
 
 /**
diff --git a/net/batman-adv/send.c b/net/batman-adv/send.c
index 85478fdc8ce8..735ac8077821 100644
--- a/net/batman-adv/send.c
+++ b/net/batman-adv/send.c
@@ -532,7 +532,7 @@ batadv_forw_packet_alloc(struct batadv_hard_iface *if_incoming,
 	forw_packet->queue_left = queue_left;
 	forw_packet->if_incoming = if_incoming;
 	forw_packet->if_outgoing = if_outgoing;
-	forw_packet->num_packets = 0;
+	forw_packet->num_packets = 1;
 
 	return forw_packet;
 
-- 
2.39.5

