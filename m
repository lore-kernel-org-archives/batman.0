Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15490C0218F
	for <batman-adv@archiver.kernel.org>; Sun,  2 Feb 2025 16:05:51 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 93E2D84299
	for <batman-adv@archiver.kernel.org>; Sun,  2 Feb 2025 17:05:49 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1738512349;
 b=PoBojxLy0BCf5n7pIHP9lXpvNcgkO+bDLOf2p1w54KekeqW1/nYBQYrvyash8o+UVq9XQ
 zvm4QZCcFUMa7Vs48gJOqpJimFGi+/zTDVTE0rVP91YQNB/pKldtkkMLAicY54W76/DHO3a
 yN8cL2bDAmgUipeXuq4svU1E7k0AU3Y=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1738512349; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=9DO0OS0iP//y8NaZaBcboW8/w6LphWSlaUrv8aEFX8Y=;
 b=TZBGy+EAUyQjuNHxNcaMlrHWpDgA17j/Wdp3E9Hbm+vZkKobjyrwBLB7zKRuSLLs2cp9+
 D5hfTWRVYfnQ/MhkvxAFzFt4AzubXWyEBraCb1RMFk8UGSLnrbpV93IEhWdYuSVOurMDqd7
 ty/PscHELviuoW+gbPzLnzSPdmrcMYE=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
  arc=pass;
  dmarc=pass (Used From Domain Record) header.from=narfation.org
 policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 765AB83E48
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sun,  2 Feb 2025 17:04:27 +0100 (CET)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1738512267;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=9DO0OS0iP//y8NaZaBcboW8/w6LphWSlaUrv8aEFX8Y=;
	b=TQqpcLcUl/RcVvniTlF1B+SG+EdA7YHiGw/2ojHHGRTGfBDMuUU5ay/KA7ykpadvfKxLVa
	l5F08FnF3FgsHVs5sROJgeCvPJVP0jXpxHHP6u4panMwuFVzC3HhpTc2cF+GlIuS3jQQV6
	lpOEJbAfb6Q6RVEcTJTmUbajSpJbaoc=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b="u1/lTDEd";
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1738512267; a=rsa-sha256;
	cv=none;
	b=teW0GiwGRORWdiv9pdCjuaCxNdGzKsc7x7MKH3FYn2Emu9L+O262RbYC8ZgfSdFKDcCCU/
	Ip2APtWI9gbuH/7skZz/SbpZXB1haKhHQH/85WoMSDwHRS9gxZI2CstCba0vPPPLLU+R02
	975yb28asb+dRO+xZoeFL/U5MPCptfM=
Received: from sven-desktop.home.narfation.org (unknown
 [IPv6:2a00:1ca0:1d86:2efc::ab85])
	by dvalin.narfation.org (Postfix) with UTF8SMTPSA id E57481FFC7;
	Sun,  2 Feb 2025 16:04:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1738512267;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9DO0OS0iP//y8NaZaBcboW8/w6LphWSlaUrv8aEFX8Y=;
	b=u1/lTDEdaAka9N5vRizEaGnyr0cFcXJJdkFUP5bRvdmVrUpMnrTm3sG3Ntdcng5ZjNDnfy
	/25P2Fm3ETQujytrl6/A5YmUfDKkVO1JxwUHCt78E7AehVixvAcnGObHhmSmK+8bif9YjY
	PnipRBQ/ujdq5cmFJJIVlwXZ2qiLmOM=
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 02 Feb 2025 17:04:11 +0100
Subject: [PATCH 2/5] batman-adv: Switch to bitmap helper for aggregation
 handling
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250202-bitmap_aggregation-v1-2-6542a10e6fad@narfation.org>
References: <20250202-bitmap_aggregation-v1-0-6542a10e6fad@narfation.org>
In-Reply-To: <20250202-bitmap_aggregation-v1-0-6542a10e6fad@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4319; i=sven@narfation.org;
 h=from:subject:message-id; bh=jdAh5ulqweFErBLdOWqijj2GZpNNAaL6QFv6stn041c=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDOnzp1fv6T0bUhwVM3uXx/wN5ZkT4y5KVAVUTHBrPG+hK
 3Qj9sj2jlIWBjEuBlkxRZY9V/LPb2Z/K/952sejMHNYmUCGMHBxCsBEHggy/BV59WyjRZ2Q7rzP
 G5p1WVtOsj6QzD6YO3nBbOVr7AfcHyowMjS+c3jtoma5T8GGf+KySinrKebB+pceL5V81Vc1UWT
 HFHYA
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: 5OQANCUT6IJJDI7FB6LWYCXKLUZMCLWE
X-Message-ID-Hash: 5OQANCUT6IJJDI7FB6LWYCXKLUZMCLWE
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/5OQANCUT6IJJDI7FB6LWYCXKLUZMCLWE/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

The aggregation code duplicates code which already exists in the the bitops
and bitmap helper. By switching to the bitmap helpers, operating on larger
aggregations becomes possible without touching the different portions of
the code which read/modify direct_link_flags.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/bat_iv_ogm.c | 19 +++++++++----------
 net/batman-adv/main.h       |  1 +
 net/batman-adv/types.h      |  2 +-
 3 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/net/batman-adv/bat_iv_ogm.c b/net/batman-adv/bat_iv_ogm.c
index b316cfc5b8769928a77ac936e5935ae780d5ad68..47967a53c416abc6ac37cdd269b5277e8e47f680 100644
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
index 485e68a06835b48923278da7b9aa79db6968945f..541fce90ec4188c993e5df16da5b61f493b5a5e0 100644
--- a/net/batman-adv/main.h
+++ b/net/batman-adv/main.h
@@ -102,6 +102,7 @@
  */
 #define BATADV_TQ_SIMILARITY_THRESHOLD 50
 
+#define BATADV_MAX_AGGREGATION_PACKETS 32
 #define BATADV_MAX_AGGREGATION_BYTES 512
 #define BATADV_MAX_AGGREGATION_MS 100
 
diff --git a/net/batman-adv/types.h b/net/batman-adv/types.h
index fe89f08533fe694e137bf31594c60915d4783c7a..4216d01aac803339528943762b55076b5387df4a 100644
--- a/net/batman-adv/types.h
+++ b/net/batman-adv/types.h
@@ -2161,7 +2161,7 @@ struct batadv_forw_packet {
 	u16 packet_len;
 
 	/** @direct_link_flags: direct link flags for aggregated OGM packets */
-	u32 direct_link_flags;
+	DECLARE_BITMAP(direct_link_flags, BATADV_MAX_AGGREGATION_PACKETS);
 
 	/** @num_packets: counter for aggregated OGMv1 packets */
 	u8 num_packets;

-- 
2.47.2

