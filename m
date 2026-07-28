Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B11D0C54F4C
	for <batman@archiver.kernel.org>; Tue, 28 Jul 2026 13:41:36 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 36CF4847E4
	for <batman@archiver.kernel.org>; Tue, 28 Jul 2026 15:41:35 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1785246095;
 b=jTEEIpnmJ/rzaHOnHqMoM9X9iraLFRs29kNCH+zC38n/a1sSj7WrXnu6EMvR1A6vgsXb/
 e4ho8q8GK0G+Tl1sp88ePyJ65XI3HZCUE5y2i3aeYzleYH/mbTHLiFa1JOkwJsakMr7IebR
 tXJol2uxpfDcEEKXRdT1QOmvUSCst2g=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1785246095; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=TmQ7fQlONHEgVx0Gw+msyhzZDojDssIc4WPgzl5MRv8=;
 b=astQyw62QIldcGvnJE2kdXDYFC8QALDinnLlmcUndGi9boUl3hW2ticix8BoVrBSuESQV
 +Y9jz4mx7KfBj0hixKNm8DEPqKlu+6N9JFoPn5tBrmyFKURu0HNSHjuhKJ0ZcqLKG1l8v5M
 Ege7RY+LRaaqBY2VLiuBzogS/ZNJlZI=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass header.from=simonwunderlich.de policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=simonwunderlich.de policy.dmarc=none
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id E2C14843B2
	for <b.a.t.m.a.n@lists.open-mesh.org>; Tue, 28 Jul 2026 15:39:21 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1785245961;
	b=kSc5AcY4s7sbWW8/neLElVzy5mWYA9jvi5ZEJVDhCxhSTSReJaPoOATYAfMzJrFdiCAmU9
	JKczkofQgjWI3RpCYGa3d1jZeJ36+6+F31lZQ6gjcqvRaBBkFZcoWY8LWwGK9iF9LDnylP
	SYwvgCsBADFwZ0d2NuRtYyg5F/h6r+U=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1785245961;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=TmQ7fQlONHEgVx0Gw+msyhzZDojDssIc4WPgzl5MRv8=;
	b=BlGCN7T+2v7LTEiHTEosgCcl+diqdfAb8yoPW41pTjl0IGrtQo7kUGpKYv9QK62GjvIgMa
	XrfmCdMWgbs/X8xGxtyj8vkeDW5OYhpVut8QG1DjhrUZ4mxBePIQypYfLX8VpBHcqQpryh
	IWJFNKvb8Z9M+Et00UrB13l/LUwt+4I=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=simonwunderlich.de header.s=09092022 header.b="hTv0S/p3";
	spf=pass (diktynna.open-mesh.org: domain of sw@simonwunderlich.de designates
 23.88.38.48 as permitted sender) smtp.mailfrom=sw@simonwunderlich.de;
	dmarc=pass (policy=none) header.from=simonwunderlich.de
Received: from kero.packetmixer.de
 (p200300c59717EaD808F168C97e5563a8.dip0.t-ipconnect.de
 [IPv6:2003:c5:9717:ead8:8f1:68c9:7e55:63a8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by mail.simonwunderlich.de (Postfix) with ESMTPSA id 6A12DFA03D;
	Tue, 28 Jul 2026 15:39:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1785245961;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TmQ7fQlONHEgVx0Gw+msyhzZDojDssIc4WPgzl5MRv8=;
	b=hTv0S/p3Vqp2xmSG1axnWLGhpE/G13DLr+tNGvG33kY4y6X7tyv/xqHWFbr0WsIGpMl8K2
	TAuwTd+lzRkROXgsIyQioQV0SiN2x48b1qxYBR7gQE0ZszB2XV36QcGz9dmEeldu+1mZBg
	ynXftJ/LMjWSdHi3GQz20tNDBn1TE2GAInP6NK2tl6fvnqb9FlWSREleOxEH6V3txY0Dyf
	kMe0syy5GuJC4ER+Byuxack84AgT/9x2UxzYYQsOVEcs832xi7UvmoDdRZd8G+dx1YVXUN
	1dBrIZ7qCgEVx6IX2aLjH/NWA+BVg63U49PeZxaSEZ0OwmzdV5Xa+MF8ppq73Q==
From: Simon Wunderlich <sw@simonwunderlich.de>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	b.a.t.m.a.n@lists.open-mesh.org,
	Sven Eckelmann <sven@narfation.org>,
	stable@vger.kernel.org,
	Sashiko <sashiko-bot@kernel.org>,
	Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH net-next 03/15] batman-adv: dat: avoid unaligned fault in IP
 extraction
Date: Tue, 28 Jul 2026 15:39:06 +0200
Message-ID: <20260728133918.643267-4-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260728133918.643267-1-sw@simonwunderlich.de>
References: <20260728133918.643267-1-sw@simonwunderlich.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: PBVOD3SJQEU5WRNYCMHW2KRZMXCP6AF6
X-Message-ID-Hash: PBVOD3SJQEU5WRNYCMHW2KRZMXCP6AF6
X-MailFrom: sw@simonwunderlich.de
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/PBVOD3SJQEU5WRNYCMHW2KRZMXCP6AF6/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

From: Sven Eckelmann <sven@narfation.org>

Independent of the alignment of the ARP packet in the SKB, either the
batadv_arp_ip_src or the batadv_arp_ip_dst will have an unaligned access
(on HW without native unaligned read support).

Use get_unaligned() to handle this properly on all architectures.

Cc: stable@vger.kernel.org
Reported-by: Sashiko <sashiko-bot@kernel.org>
Fixes: 5c3a0e553593 ("batman-adv: Distributed ARP Table - add ARP parsing functions")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/distributed-arp-table.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/net/batman-adv/distributed-arp-table.c b/net/batman-adv/distributed-arp-table.c
index a6fe4820f65b9..6ca946da92758 100644
--- a/net/batman-adv/distributed-arp-table.c
+++ b/net/batman-adv/distributed-arp-table.c
@@ -250,7 +250,10 @@ static u8 *batadv_arp_hw_src(struct sk_buff *skb, int hdr_size)
  */
 static __be32 batadv_arp_ip_src(struct sk_buff *skb, int hdr_size)
 {
-	return *(__force __be32 *)(batadv_arp_hw_src(skb, hdr_size) + ETH_ALEN);
+	u8 *src = batadv_arp_hw_src(skb, hdr_size) + ETH_ALEN;
+	__be32 *ip = (__force __be32 *)src;
+
+	return get_unaligned(ip);
 }
 
 /**
@@ -275,8 +278,9 @@ static u8 *batadv_arp_hw_dst(struct sk_buff *skb, int hdr_size)
 static __be32 batadv_arp_ip_dst(struct sk_buff *skb, int hdr_size)
 {
 	u8 *dst = batadv_arp_hw_src(skb, hdr_size) + ETH_ALEN * 2 + 4;
+	__be32 *ip = (__force __be32 *)dst;
 
-	return *(__force __be32 *)dst;
+	return get_unaligned(ip);
 }
 
 /**
-- 
2.47.3

