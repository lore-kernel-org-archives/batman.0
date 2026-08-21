Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E43D1C5DF94
	for <batman-adv@archiver.kernel.org>; Fri, 21 Aug 2026 09:50:31 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 4A20180CC7
	for <batman-adv@archiver.kernel.org>; Fri, 21 Aug 2026 11:50:30 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1787305830;
 b=pPdLzh9R+DR9N+x1K9t1GjpgpZAEkkQWftezdQWBGdK5wEDkbmbo852TWez4ZeJWFf2WR
 gRcMYFuzBre6t8pyqtF4+bXV7i/4WCEA6ZFJFEWm59SAaDJecXligdmeEJSOCsDJW6y/hB/
 uETw4lSVllPjuYvFzmKEokRvA0/7Sd4=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1787305830; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=CdutJj0NeCuOQVhmoP4O60XEo/9t+zQrQe/6al6JIHw=;
 b=38KTPdM7ZhGUQIs1TkQgLo7RVu7l7bDs4upJLarrugudx2ZYsSOeFyCpb4qFBZZBij1x8
 e1RhFvJwPxPBrCNU2nEExnaiAiPziWZ2LUrxSRQt9Z85tWKjt+ALUMS57GNtvXqimgpGcxB
 nTWc9dRM5SVzf0HbZi9CnspWhHkK1dY=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass header.from=simonwunderlich.de policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=simonwunderlich.de policy.dmarc=none
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de
 [IPv6:2a01:4f8:c17:e8c0::1])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id F31858125E
	for <b.a.t.m.a.n@lists.open-mesh.org>; Fri, 21 Aug 2026 11:48:20 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1787305701;
	b=uZcbAFBk0+q/Il3KB2LQrIqjRdyG4zJH/ik0xs+v71rWAY1Yy/x2Bu3yPoFccZFY7Ixnoz
	mnQdkZy9PIt9fV0FtNVk0/tGicCBM6dPXoS42J95KxP99piQXjJd+YsMG/z41fU2dN9z7l
	kVl3BhvQ6REggJiyYL+mJTEOwbi24h8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1787305701;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=CdutJj0NeCuOQVhmoP4O60XEo/9t+zQrQe/6al6JIHw=;
	b=KLDZYwIwWsJDbZbk/vwWVRi9teU3jwupfhEgvtpXEBnocxjOZ3N9Hace2+Jag5C9f+zeiK
	dEy+2Sfihl/WxqK5uQU9OtpBPt6idmNSGC0eMLuluggpLmJHsESUVjvy0QnQmrqdwqutb8
	BHwcubZeU4svgQpXmEpAvNF8PVrxZFU=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=simonwunderlich.de header.s=09092022 header.b=RP1zouhO;
	spf=pass (diktynna.open-mesh.org: domain of sw@simonwunderlich.de designates
 2a01:4f8:c17:e8c0::1 as permitted sender)
 smtp.mailfrom=sw@simonwunderlich.de;
	dmarc=pass (policy=none) header.from=simonwunderlich.de
Received: from kero.packetmixer.de
 (p200300C59714FCd8eC8c87C354003feD.dip0.t-ipconnect.de
 [IPv6:2003:c5:9714:fcd8:ec8c:87c3:5400:3fed])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by mail.simonwunderlich.de (Postfix) with UTF8SMTPSA id 6355DFA116;
	Fri, 21 Aug 2026 11:48:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1787305700;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CdutJj0NeCuOQVhmoP4O60XEo/9t+zQrQe/6al6JIHw=;
	b=RP1zouhO4/HDyEzyjo7l0TSLrfTujCuL1i+GZjLh5IlShbRU7xbcwacnOQMKbvkXZks1Kg
	nd+R2a20sh91UmkWQG6eMLLzPP7U27dydiOSarzvZHosLBN4lQRLccHK/6Hbejfcdxl1BW
	jXy+0ldA2y+Vn8hUDI8j4JfqNNfqLRa2x1RWt0DrNMmHNgPS+0m9Cc2Pf46t4zHDiUeDMD
	dn7ZHUzL0q1qBdAE8f6aTChiXp7Thio9xfdMB7XyZU02oizMyMdWNEVlZVmIw07svpaPpu
	PJMeJJDIXqB3ScAH+jrZdTkbh3uvDqcMoN7/mN7F+P7yJphw1Ms/WmlIgBUMyg==
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
Subject: [PATCH net 4/9] batman-adv: dat: avoid unaligned fault in IP
 extraction
Date: Fri, 21 Aug 2026 11:48:08 +0200
Message-ID: <20260821094813.201800-5-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260821094813.201800-1-sw@simonwunderlich.de>
References: <20260821094813.201800-1-sw@simonwunderlich.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: 52VHITT3AIG7MBHWYLHDUIHRCZ3AV2HU
X-Message-ID-Hash: 52VHITT3AIG7MBHWYLHDUIHRCZ3AV2HU
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/52VHITT3AIG7MBHWYLHDUIHRCZ3AV2HU/>
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
index 0d5a9cb0affeb..76fd23db926c7 100644
--- a/net/batman-adv/distributed-arp-table.c
+++ b/net/batman-adv/distributed-arp-table.c
@@ -316,7 +316,10 @@ static u8 *batadv_arp_hw_src(struct sk_buff *skb, int hdr_size)
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
@@ -341,8 +344,9 @@ static u8 *batadv_arp_hw_dst(struct sk_buff *skb, int hdr_size)
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

