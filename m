Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 272E2C0218F
	for <batman-adv@archiver.kernel.org>; Sun,  2 Feb 2025 16:06:34 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 9ADDB84213
	for <batman-adv@archiver.kernel.org>; Sun,  2 Feb 2025 17:06:32 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1738512392;
 b=hdlyYUagmyKq9pwvxhsCGmUdE123EzbbclqOZGJt/u2rTaU1Zwb25B1GTq8Ww+n7Uj4xB
 8+/j6K5XeW7iTU159nwtx36P5w7wAPforchqmzhXEj1k6MkrgI9sycYghwSThzV+wQ0HD7K
 UcvS5Yxgt+yzz4URu2w3tdx7/SNqe5c=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1738512392; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=Jax4OfMDlLnzxygPQwFf+ztsLYuOEJ7WreN/cjBk/o0=;
 b=YD4PfcPKK/xDwQWtpbbLWe8LIj/Gzbm61j/ZyuqAUHfhyQc08ziL0GpHXv7f+kJ+v9wS4
 EtvsKMY/nt/4KFDhkHG6JGBVzq78rEE5x7MS9EW12QDr2zP+mh+EaFZFm03kTeMAi1PcUpy
 pevITgSNIAG6GV1KQD8oGP7hzE5vuZA=
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
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 38DF283FDB
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sun,  2 Feb 2025 17:04:32 +0100 (CET)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1738512272;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=Jax4OfMDlLnzxygPQwFf+ztsLYuOEJ7WreN/cjBk/o0=;
	b=geygwq7ECSr07jQdSmUNBow0buQ+R0O/U3SCZQYI52VB5snAVTeu4RRCJqRUVkgBM5U4/g
	+srU9vUwTMOcAQEsp/lUUA7mtB1if5N5Nm7T2W0fPictRfsQKNdjrq8I0Dmf2t4I3L6vO5
	ax0wMtZ+2eFKiCVYfGPuFE0Y1M966jo=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=s4UZE90+;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1738512272; a=rsa-sha256;
	cv=none;
	b=mfy/bf6/CzD2AIYyVFlWusNynbsT3upENL+z5PfnXgGS/TayxOVZmmyjIaXA0LBnGYSNw3
	5f2dcF07zIRkfs375va9VWr5NFgRr2hgdYHcA26RcADgtRkx1IeybhL9sHH5pANO47JqeH
	OGhIBS8nj5nFRA+38JiIZle1IDulJNw=
Received: from sven-desktop.home.narfation.org (unknown
 [IPv6:2a00:1ca0:1d86:2efc::ab85])
	by dvalin.narfation.org (Postfix) with UTF8SMTPSA id 702181FFC7;
	Sun,  2 Feb 2025 16:04:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1738512271;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Jax4OfMDlLnzxygPQwFf+ztsLYuOEJ7WreN/cjBk/o0=;
	b=s4UZE90+/uZbetJdHfgvNcfzL3Hnynp/HRAPXdZbL6xlVWOSih53+dFH2fEESVJhMbStyS
	oCHDulpXGjqk300kGp/Aa/IwuAQafZJwEpYmnHHFhad4lI5qoo93V1LhmeN5gMrtXh1x8N
	vabJewalvmbqRm1DyCNpbE1O9dllfRY=
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 02 Feb 2025 17:04:12 +0100
Subject: [PATCH 3/5] batman-adv: Use actual packet count for aggregated
 packets
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250202-bitmap_aggregation-v1-3-6542a10e6fad@narfation.org>
References: <20250202-bitmap_aggregation-v1-0-6542a10e6fad@narfation.org>
In-Reply-To: <20250202-bitmap_aggregation-v1-0-6542a10e6fad@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2083; i=sven@narfation.org;
 h=from:subject:message-id; bh=3sKDOuTUNgY5FrvutHENWknYwEjvMXDevs4VwM5pUxI=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDOnzp9cs6X9pad1WwPVfJSNS65SguEXy0h2zDPwV3m7mz
 5upwi/XUcrCIMbFICumyLLnSv75zexv5T9P+3gUZg4rE8gQBi5OAZgIfzojw29HixXl/5e5Blfk
 cbPqR+Voz+IVmjdnqt1s+Wtz8rj6MxkZWrx/yHdwTBU9fJpterbPG4n5TZpGdYcZd51a/dLMV6S
 NCwA=
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: FYA4XOFMSY5U4472ARRNG7LUNWLJL45N
X-Message-ID-Hash: FYA4XOFMSY5U4472ARRNG7LUNWLJL45N
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/FYA4XOFMSY5U4472ARRNG7LUNWLJL45N/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

The batadv_forw_packet->num_packets didn't store the number of packets but
the the number of packets - 1. This didn't had any effects on the actual
handling of aggregates but can easily be a source of confusion when reading
the code.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/bat_iv_ogm.c | 5 +++--
 net/batman-adv/send.c       | 2 +-
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/net/batman-adv/bat_iv_ogm.c b/net/batman-adv/bat_iv_ogm.c
index 47967a53c416abc6ac37cdd269b5277e8e47f680..a43c268b2a3028c9a36fe8ce060cfb23ac5f9381 100644
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
index 0379b126865d7c07b84c08c93eca38279fe6df9c..39a13664dc4dae46f49851af738bca4c3b8891ef 100644
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
2.47.2

