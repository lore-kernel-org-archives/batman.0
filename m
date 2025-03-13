Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65BD1C282DE
	for <batman-adv@archiver.kernel.org>; Thu, 13 Mar 2025 16:48:56 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 017538453B
	for <batman-adv@archiver.kernel.org>; Thu, 13 Mar 2025 17:48:55 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1741884535;
 b=nHgtbBP2D+8xw0u/WuFQLowyFrsg8r6qgVFwvyQWY5+cNxSFCuzohaEVpHkYtHUR0BluW
 pptB7QvYWBjl5g4lpGsDHYtwf+PTY0avP65Ovbi6TwJdLXQclkuXcCTYbJYofXqL0lmyjO5
 O8cD1iyrkHbyGh3X6wSfUvszpJgIHH0=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1741884535; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=2SoFylawpBpRut47RFIutcPzS9eK9hFpyjHbKIck1cU=;
 b=aiP2UQ2Uxamp9VdzCQ77+ZBx+3cbEjaz4BGB00dSRjnfAWmo3szQMMGGhKFZjl7rbu4dc
 cEnnKaaDQokT4JMhhny3QR67/sk6zhRdNysTmmpdueySZ7N4SFAPn6kcoqd3+cEiz7R9gv6
 trm2jjv7YeNiwuSgP54Ap0uYx18I1N8=
ARC-Authentication-Results: i=2; open-mesh.org; dkim=fail;
  arc=pass;
  dmarc=fail (Used From Domain Record) header.from=simonwunderlich.de
 policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=fail; arc=pass;
 dmarc=fail (Used From Domain Record) header.from=simonwunderlich.de
 policy.dmarc=none
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de
 [IPv6:2a01:4f8:c17:e8c0::1])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 6EC1F84282
	for <b.a.t.m.a.n@lists.open-mesh.org>; Thu, 13 Mar 2025 17:45:29 +0100 (CET)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1741884329;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2SoFylawpBpRut47RFIutcPzS9eK9hFpyjHbKIck1cU=;
	b=bzgSX4yshDOfbuay23jm2jlPVlMZf/S0E1GKMXvlVLiA64DbvAWGSdiSKIosya07Cqkg7I
	jCJEd4YCIg/8fAMQ7potKMDAiYbEdBQhIikq7vtfl9HuaxTMyV5JppSeh9PKPw58TZCvet
	Lo3GA28yzU2G/UquDY5Dutkf8S83T0g=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=none;
	dmarc=pass (policy=none) header.from=simonwunderlich.de;
	spf=pass (diktynna.open-mesh.org: domain of sw@simonwunderlich.de designates
 2a01:4f8:c17:e8c0::1 as permitted sender) smtp.mailfrom=sw@simonwunderlich.de
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1741884329; a=rsa-sha256;
	cv=none;
	b=dmJvPzMvpyWPS+B8Z5Gms9FmgZYhq8RX9jdz5uCCnINnob/gh7dIro6v3fP3uynGV3j+Zv
	gKbHUkdIQ57Uq2XFrZWdKzYZUxbYnLILLVzk++etJ6Yz6f8lbfS6XqlhDeOeAsOb+lNATI
	5AziXDQnIuMECzRdrrF0cbQO/a2XT/U=
Received: from kero.packetmixer.de
 (p200300fa272413901a38a4bC9c0De305.dip0.t-ipconnect.de
 [IPv6:2003:fa:2724:1390:1a38:a4bc:9c0d:e305])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits)
 server-digest SHA256)
	(No client certificate requested)
	by mail.simonwunderlich.de (Postfix) with ESMTPSA id 06C94FA14B;
	Thu, 13 Mar 2025 17:45:29 +0100 (CET)
From: Simon Wunderlich <sw@simonwunderlich.de>
To: kuba@kernel.org,
	davem@davemloft.net
Cc: netdev@vger.kernel.org,
	b.a.t.m.a.n@lists.open-mesh.org,
	Sven Eckelmann <sven@narfation.org>,
	Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH 07/10] batman-adv: Switch to bitmap helper for aggregation
 handling
Date: Thu, 13 Mar 2025 17:45:16 +0100
Message-Id: <20250313164519.72808-8-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250313164519.72808-1-sw@simonwunderlich.de>
References: <20250313164519.72808-1-sw@simonwunderlich.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: KZONR3J7QPB4FH7GODXXCW2P6SKSMIU7
X-Message-ID-Hash: KZONR3J7QPB4FH7GODXXCW2P6SKSMIU7
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/KZONR3J7QPB4FH7GODXXCW2P6SKSMIU7/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

From: Sven Eckelmann <sven@narfation.org>

The aggregation code duplicates code which already exists in the the bitops
and bitmap helper. By switching to the bitmap helpers, operating on larger
aggregations becomes possible without touching the different portions of
the code which read/modify direct_link_flags.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/bat_iv_ogm.c | 19 +++++++++----------
 net/batman-adv/main.h       |  1 +
 net/batman-adv/types.h      |  2 +-
 3 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/net/batman-adv/bat_iv_ogm.c b/net/batman-adv/bat_iv_ogm.c
index b715f7343ffd..87c1af540457 100644
--- a/net/batman-adv/bat_iv_ogm.c
+++ b/net/batman-adv/bat_iv_ogm.c
@@ -355,7 +355,7 @@ static void batadv_iv_ogm_send_to_if(struct batadv_forw_packet *forw_packet,
 		/* we might have aggregated direct link packets with an
 		 * ordinary base packet
 		 */
-		if (forw_packet->direct_link_flags & BIT(packet_num) &&
+		if (test_bit(packet_num, forw_packet->direct_link_flags) &&
 		    forw_packet->if_incoming == hard_iface)
 			batadv_ogm_packet->flags |= BATADV_DIRECTLINK;
 		else
@@ -460,6 +460,7 @@ batadv_iv_ogm_can_aggregate(const struct batadv_ogm_packet *new_bat_ogm_packet,
 	 * - the send time is within our MAX_AGGREGATION_MS time
 	 * - the resulting packet won't be bigger than
 	 *   MAX_AGGREGATION_BYTES
+	 * - the number of packets is lower than MAX_AGGREGATION_PACKETS
 	 * otherwise aggregation is not possible
 	 */
 	if (!time_before(send_time, forw_packet->send_time) ||
@@ -469,7 +470,7 @@ batadv_iv_ogm_can_aggregate(const struct batadv_ogm_packet *new_bat_ogm_packet,
 	if (aggregated_bytes > BATADV_MAX_AGGREGATION_BYTES)
 		return false;
 
-	if (packet_num >= BITS_PER_TYPE(forw_packet->direct_link_flags))
+	if (packet_num >= BATADV_MAX_AGGREGATION_PACKETS)
 		return false;
 
 	/* packet is not leaving on the same interface. */
@@ -578,12 +579,13 @@ static void batadv_iv_ogm_aggregate_new(const unsigned char *packet_buff,
 	memcpy(skb_buff, packet_buff, packet_len);
 
 	forw_packet_aggr->own = own_packet;
-	forw_packet_aggr->direct_link_flags = BATADV_NO_FLAGS;
+	bitmap_zero(forw_packet_aggr->direct_link_flags,
+		    BATADV_MAX_AGGREGATION_PACKETS);
 	forw_packet_aggr->send_time = send_time;
 
 	/* save packet direct link flag status */
 	if (direct_link)
-		forw_packet_aggr->direct_link_flags |= 1;
+		set_bit(0, forw_packet_aggr->direct_link_flags);
 
 	INIT_DELAYED_WORK(&forw_packet_aggr->delayed_work,
 			  batadv_iv_send_outstanding_bat_ogm_packet);
@@ -596,17 +598,14 @@ static void batadv_iv_ogm_aggregate(struct batadv_forw_packet *forw_packet_aggr,
 				    const unsigned char *packet_buff,
 				    int packet_len, bool direct_link)
 {
-	unsigned long new_direct_link_flag;
-
 	skb_put_data(forw_packet_aggr->skb, packet_buff, packet_len);
 	forw_packet_aggr->packet_len += packet_len;
 	forw_packet_aggr->num_packets++;
 
 	/* save packet direct link flag status */
-	if (direct_link) {
-		new_direct_link_flag = BIT(forw_packet_aggr->num_packets);
-		forw_packet_aggr->direct_link_flags |= new_direct_link_flag;
-	}
+	if (direct_link)
+		set_bit(forw_packet_aggr->num_packets,
+			forw_packet_aggr->direct_link_flags);
 }
 
 /**
diff --git a/net/batman-adv/main.h b/net/batman-adv/main.h
index c08c96b5b8b1..67af435ee04e 100644
--- a/net/batman-adv/main.h
+++ b/net/batman-adv/main.h
@@ -104,6 +104,7 @@
  */
 #define BATADV_TQ_SIMILARITY_THRESHOLD 50
 
+#define BATADV_MAX_AGGREGATION_PACKETS 32
 #define BATADV_MAX_AGGREGATION_BYTES 512
 #define BATADV_MAX_AGGREGATION_MS 100
 
diff --git a/net/batman-adv/types.h b/net/batman-adv/types.h
index b222f8a80ed9..0ca0fc072fc9 100644
--- a/net/batman-adv/types.h
+++ b/net/batman-adv/types.h
@@ -2139,7 +2139,7 @@ struct batadv_forw_packet {
 	u16 packet_len;
 
 	/** @direct_link_flags: direct link flags for aggregated OGM packets */
-	u32 direct_link_flags;
+	DECLARE_BITMAP(direct_link_flags, BATADV_MAX_AGGREGATION_PACKETS);
 
 	/** @num_packets: counter for aggregated OGMv1 packets */
 	u8 num_packets;
-- 
2.39.5

