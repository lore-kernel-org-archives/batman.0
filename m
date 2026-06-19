Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCF23CD98E6
	for <batman@archiver.kernel.org>; Fri, 19 Jun 2026 07:02:40 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 49D7C80C1F
	for <batman@archiver.kernel.org>; Fri, 19 Jun 2026 09:02:39 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1781852559;
 b=aMBiET2nu4e6HrVPJP301S0R9mjcZwHcC4gQ4Y/iPfAJ1hRvaKLjfecMDNuHu/CMoIq7Q
 0S5/HRsm1mDItT3M7l5RrTn8n0FKq4ZzPcHCs5WcNwQCKL4R6EfwluuPqWPYk6HnhySnpln
 FubN4h4vvnMz8UJSKChjbWAdD/D/GdE=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1781852559; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=6e8joL+dyxKxUQbyUNURUpKgR0UCuyNlXRp5Lgytw+I=;
 b=eXAMouVxoQVEx+EPxmsjxqQwd3h6mFVcwkCdt0xbdEwgYTRJjQVLe3SPA4r2LLveSpE1H
 Ush2gkiYzM5N8H9R1HNC6S77ryH7e73fyt31o68qPqwAbfS3GZC/Pc5wkEUK4zRSz1B5IsB
 QL4gsqbQ9hOYXolLe2d+1FsBa4IKQ9c=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass header.from=simonwunderlich.de policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=simonwunderlich.de policy.dmarc=none
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de
 [IPv6:2a01:4f8:c17:e8c0::1])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 35EC98081E
	for <b.a.t.m.a.n@lists.open-mesh.org>; Fri, 19 Jun 2026 09:00:54 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1781852454;
	b=lwaspQglAURDp4ufZt5vlIGOQeloB2fldm/Q3ge1dXVO2YC04wika+pYq5oCwebUHYj7F4
	qEabSZOczKsDW+gOyJqQOpJXhn1lhWF77n8Oj2V23KtVdJSkBXbb/jaCRfOsaJ4jcS7REI
	zD+I21+f+SQZSIIx1sCVZMOXdBIwlbA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1781852454;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=6e8joL+dyxKxUQbyUNURUpKgR0UCuyNlXRp5Lgytw+I=;
	b=Rk3pe1kSTj9RPHA0db6sPZGjrjFT/pJqNqMvWM0m739d2gkryQTTuULhg14M15WmwrfX98
	gQIy3lFJZbYgeXNnNi/kItxUA54k0jXNIZYr3lBc0JhQs2UKL6/dck6fhmv50ANgUlYkkP
	qAhLoqt8yqYN9fq8RVIa4fGf3svG6Rw=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=simonwunderlich.de header.s=09092022 header.b=UvUZRmtv;
	dmarc=pass (policy=none) header.from=simonwunderlich.de;
	spf=pass (diktynna.open-mesh.org: domain of sw@simonwunderlich.de designates
 2a01:4f8:c17:e8c0::1 as permitted sender) smtp.mailfrom=sw@simonwunderlich.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1781852450;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6e8joL+dyxKxUQbyUNURUpKgR0UCuyNlXRp5Lgytw+I=;
	b=UvUZRmtvX36M0a/pCOfje421DFjf89Qe+/29VPXjgBufuG01zBA2yUqJDYhCfnu+GWxwbb
	qw0MWYhE7sgAr/0JuQbGSwTjPRGDsdLu/R6DZ/OSs1hbWXlYzzXNCbudM/cCuDkHDVW8kS
	3YHPJBG+lFLjiaPVNe3XEst9dbF0Up5k9/2cmORcxW+QoSlsCuCyVy+o1nd8i9xkT0oE1T
	gfR0Ip1UOBSOz/M6n0q5os027q3Ff7dFulTtZhPYhQm0rKuOLCD0TBhJAxfAN8xiEas+va
	+Lauwy5MgwkVEUcPok2fELI759sTE0H8gZnekEsHpbyXXqAFbfUHWrKUV4Ts9A==
From: Simon Wunderlich <sw@simonwunderlich.de>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	b.a.t.m.a.n@lists.open-mesh.org,
	Sven Eckelmann <sven@narfation.org>,
	stable@kernel.org,
	Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH net 05/15] batman-adv: frag: avoid underflow of TTL
Date: Fri, 19 Jun 2026 09:00:35 +0200
Message-ID: <20260619070045.438101-6-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260619070045.438101-1-sw@simonwunderlich.de>
References: <20260619070045.438101-1-sw@simonwunderlich.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: 7XZUM7MKVQOWSUH334OMTONABREF7XDK
X-Message-ID-Hash: 7XZUM7MKVQOWSUH334OMTONABREF7XDK
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/7XZUM7MKVQOWSUH334OMTONABREF7XDK/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

From: Sven Eckelmann <sven@narfation.org>

Packets with a TTL are using it to limit the amount of time this packet can
be forwarded. But for batadv_frag_packet, the TTL was always only reduced
but it was never evaluated. It could even underflow without any effect.

Check the TTL in batadv_frag_skb_fwd() before attempting to prepare it for
forwarding. This keeps it in sync with the not fragmented unicast packet.

Cc: stable@kernel.org
Fixes: 610bfc6bc99b ("batman-adv: Receive fragmented packets and merge")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/fragmentation.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/net/batman-adv/fragmentation.c b/net/batman-adv/fragmentation.c
index f311a42203d2e..8a006a0473a87 100644
--- a/net/batman-adv/fragmentation.c
+++ b/net/batman-adv/fragmentation.c
@@ -417,6 +417,13 @@ bool batadv_frag_skb_fwd(struct sk_buff *skb,
 	 */
 	total_size = ntohs(packet->total_size);
 	if (total_size > neigh_node->if_incoming->net_dev->mtu) {
+		if (packet->ttl < 2) {
+			kfree_skb(skb);
+			*rx_result = NET_RX_DROP;
+			ret = true;
+			goto out;
+		}
+
 		if (skb_cow(skb, ETH_HLEN) < 0) {
 			kfree_skb(skb);
 			*rx_result = NET_RX_DROP;
-- 
2.47.3

