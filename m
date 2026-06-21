Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFE29CD98F0
	for <batman@archiver.kernel.org>; Sun, 21 Jun 2026 14:32:03 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 748BE84508
	for <batman@archiver.kernel.org>; Sun, 21 Jun 2026 16:32:02 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1782052322;
 b=toDfdyBJBYv2kCuQc+mA0HLaKEwAvo2xfVD79DkuKkpvQyl+e70C68Td0RAiuCciGoEfB
 no7z9Pg4PpDbQlqtarsCnKT+ddJ50+OxyGfGGD6XON/r+aGmT1n26+gGQHe6Q6sf4dQzZ8g
 kUZpmvi5j3s7At53WN690M/HP5g69Rs=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1782052322; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=F5J9ROC3BkkgoTA9CmkYa3oPapnVHalRUn6fCPUtr6E=;
 b=B6mUPbtt3QbaBJdcX9lpWGqVvDVENle7CeSM1yYb7bl2cVdSZGy0TVORqjadVzGdruwcP
 PGiLMhSbuX4azsyIM+nD4cS3tngWLnJ6M1c17K9oRb9cgTOiGTkN6Dpyb49+MVjLBgTx+j2
 kHOELqO+//8N7CXgTLLAuLTdzUx6lF8=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id AFA8C84077
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sun, 21 Jun 2026 16:25:03 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1782051903;
	b=Hg5NMeeHfzU5TdnRrgaePYm9s1XP373zfjr5NLYjWxTU4H7B/Ea/YLj8B9rci0fGPrSUxt
	Z3hMdNecsjN7GMU2x6OQ1GU20x7ll1HjIMrkVa555mtxlqmrKWP0BDf6s0SE80+wcwoIfq
	eNoXhjiAQ45G3dN7iuxE+CiP9i1w1Vw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1782051903;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=F5J9ROC3BkkgoTA9CmkYa3oPapnVHalRUn6fCPUtr6E=;
	b=z3xaIhEE9e1r6qvdk387FyQX9AN/cfEOJn3koAhr32bi5GC5FmW/kXS5sVdnnwiPIlEiAk
	liV52ZO8kgaJN9du1Cw16bz5glOBkfUO87L1IOxZRlwE6GqGIU3OZ3s/L965M8809syJkF
	ccsTTSvYvd3e6tF6rPq+wHNIvR1+Sl0=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=lpkwCFPD;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id 67D4520059;
	Sun, 21 Jun 2026 14:25:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1782051903;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=F5J9ROC3BkkgoTA9CmkYa3oPapnVHalRUn6fCPUtr6E=;
	b=lpkwCFPDgVe6tCaeGbMBRAcorDfuh+ppEtnyJqz0PTuFXKZp1aBUyL3SsXn9tommwvblZT
	ER1vCDEqo8XTjUSiVQycwEz/xInLUu5zdE9y32QMdkGgX1oxDr6Ttm4fLJhcwoYoRYQt0g
	Cd7c3hNEq7ZNEoJonDy/9XsB229L6EI=
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 21 Jun 2026 16:24:00 +0200
Subject: [PATCH 10/28] batctl: tcpdump: fix endianness of fragmentation
 sequence number
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260621-bugfixes-v1-10-b09736288a4a@narfation.org>
References: <20260621-bugfixes-v1-0-b09736288a4a@narfation.org>
In-Reply-To: <20260621-bugfixes-v1-0-b09736288a4a@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1005; i=sven@narfation.org;
 h=from:subject:message-id; bh=GoEfJpsRyr/FI8xNrQHKVgyoAk934eSr+agfsXqCaH4=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFnmX1g5mtbntfqmTf3uKXJ+t4mYXniu9+mZ5cf9T79pW
 af3IPBIRykLgxgXg6yYIsueK/nnN7O/lf887eNRmDmsTCBDGLg4BWAi0s8ZGWae11Pv5be/wdEQ
 0361zOLk3p9F//tL755Ou21dabuvz5SRYf5p/07xpRotVYb3Ljycrxjm/86g1P3+7jZbromzj/h
 bsAMA
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: 6RZHTWELHCGEQ67FNAUR3KKX3V4JDW2H
X-Message-ID-Hash: 6RZHTWELHCGEQ67FNAUR3KKX3V4JDW2H
X-MailFrom: sven@narfation.org
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/6RZHTWELHCGEQ67FNAUR3KKX3V4JDW2H/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

The kernel returns the unicast fragmentation packet in network (big endian)
byte order. But the system might be little endian. In this case, the bytes
must be first reordered before they can be printed.

Fixes: 30f8fe9c105a ("batctl: tcpdump: Add support for unicast fragmentation")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 tcpdump.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tcpdump.c b/tcpdump.c
index aced4d3..ddcee03 100644
--- a/tcpdump.c
+++ b/tcpdump.c
@@ -1050,7 +1050,7 @@ static void dump_batman_ucast_frag(unsigned char *packet_buff, ssize_t buff_len,
 	printf("%s: UCAST FRAG, seqno %d, no %d, ttl %hhu\n",
 	       get_name_by_macaddr((struct ether_addr *)frag_packet->dest,
 				   read_opt),
-	       frag_packet->seqno, frag_packet->no, frag_packet->ttl);
+	       ntohs(frag_packet->seqno), frag_packet->no, frag_packet->ttl);
 }
 
 static void dump_batman_bcast(unsigned char *packet_buff, ssize_t buff_len,

-- 
2.47.3

