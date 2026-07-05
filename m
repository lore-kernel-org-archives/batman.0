Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70800C43602
	for <batman-adv@archiver.kernel.org>; Sun,  5 Jul 2026 17:35:03 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 070798427B
	for <batman-adv@archiver.kernel.org>; Sun, 05 Jul 2026 19:35:02 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1783272902;
 b=AJ+MLfWEnB4eOm2Ui2lZdGfRtQnoopk1Ek5/frVuFhKwI7r2WQKs7bH+++fzEX6kCrhTQ
 s2R5/OtCWjhmKhG0GhnrZF7HxDBpAHykBQInzMDmgGCMd+rdjO149EDnE0UrhpL3OxEM6rR
 +DoH8h2u5CItepRwTt+ouwIutSlkh4c=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1783272902; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=uTUiChNl2xN/zmD9kEcL7BMO7kNjuA0MVFImz0GROyI=;
 b=r2uTBe7W8BT8ygbm6UlCdoRAzUhGJclufXLi7RmJA6KwFdePo41cAQTi7oG9mtSiIvt3C
 vfDfM72e/4LC3SYEAxJektJlI0vq64KQZSvZWUYqujRWXEp5nO65THTkwqQ/70hU8oj37aj
 48e2F87otLriaa8MXNbLhOYT2Ma/tB4=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org
 [IPv6:2a00:17d8:100::8b1])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id DDA68823B5
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sun, 05 Jul 2026 19:30:22 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1783272622;
	b=dYBoqxceNrO0px77Oeqh/JrD/3N36+V2IJTiVlq7q/GHtvH4/wJwpjXug0TJDoWJeMeg9V
	DnxqdTfrrHUu71HhEsfV0tyz3GLyvG4aRl2bS2EhIZC+NLnb1mJ2WSD73mbZuh60l454ju
	G1CZgx0iata4DVmRjnJ/8pWvO4CcjcI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1783272622;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=uTUiChNl2xN/zmD9kEcL7BMO7kNjuA0MVFImz0GROyI=;
	b=qMO9Aqq/0mf6YEPh3tvQMfAfXPWAm+Cg1SF2G1VEKZA4gpBbDoBaugU6B3UYEOGtau4r+B
	Hxg6h2qjhQQg6R7Uhoo7wXZ7ramPPpzC79oocFyGjsL3zlBcoLXkmQX3O2d6MfWA0rXWGr
	KDnSvX41XXh0dR9huSxS62Mn4BK+6iM=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=Ue7n+LZe;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id 8C5AF1FEE6;
	Sun, 05 Jul 2026 17:30:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1783272622;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uTUiChNl2xN/zmD9kEcL7BMO7kNjuA0MVFImz0GROyI=;
	b=Ue7n+LZedJdYdM3dhsedFvSK5cpJDepURhFEYUMDx2k6eakRZHSaWx5DUia/EpPeIKjesg
	/YwQbni11dCNOWa33rnJ8wVYAfDJ7z7177ySISNYUdAtQkySduUShR5rGhzqcP76fw3InB
	9ucaaLGLJv3SEaPi+9x6BtlhqSbjQ7M=
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 05 Jul 2026 19:30:09 +0200
Subject: [PATCH 6/9] batctl: tcpdump: skip partial line for oversized
 ICMPv6 errors
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260705-bugfixes-tcpdump-v1-6-c37f6f82eed1@narfation.org>
References: <20260705-bugfixes-tcpdump-v1-0-c37f6f82eed1@narfation.org>
In-Reply-To: <20260705-bugfixes-tcpdump-v1-0-c37f6f82eed1@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1243; i=sven@narfation.org;
 h=from:subject:message-id; bh=xS0Ld8OnA8R5Yo6tUzVP68UUWds93dsaG8qxgVVV0WE=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFleU+bJVpqeqTA4mnZz4vxfjUv0th+TM1oeF7y4TjVS9
 WP0uaxlHaUsDGJcDLJiiix7ruSf38z+Vv7ztI9HYeawMoEMYeDiFICJ+LszMizz5eJzfXdyd/Gy
 TzztrdPy3y7O6jzDsuNLfIDoC3aNgwyMDBNYX94wkKgLjvp+Qf6enMDpB4tvqSfJf7h5+rP4s4x
 AazYA
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: KF3LNVYU7VIU72DHKMUGBS5HKDEVJP5S
X-Message-ID-Hash: KF3LNVYU7VIU72DHKMUGBS5HKDEVJP5S
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/KF3LNVYU7VIU72DHKMUGBS5HKDEVJP5S/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

dump_ipv6() prints the "IP6 <src> > <dst> " line prefix before it checks
whether an ICMPv6 error message exceeds IPV6_MIN_MTU. The length check
might just stop the processing and causes some truncated output on stdout.
Which is then also not terminated by a newline.

Move the size check ahead of the printf to avoid this partial line.

Fixes: 35b37756f4a3 ("add IPv6 support to tcpdump parser")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 tcpdump.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tcpdump.c b/tcpdump.c
index c532ad1..1094069 100644
--- a/tcpdump.c
+++ b/tcpdump.c
@@ -624,7 +624,6 @@ static void dump_ipv6(unsigned char *packet_buff, ssize_t buff_len,
 		icmphdr = (struct icmp6_hdr *)(packet_buff +
 					       sizeof(struct ip6_hdr));
 
-		printf("%s %s > %s ", ip_string, ipsrc, ipdst);
 		if (icmphdr->icmp6_type < ICMP6_INFOMSG_MASK &&
 		    (size_t)(buff_len) > IPV6_MIN_MTU) {
 			fprintf(stderr,
@@ -633,6 +632,7 @@ static void dump_ipv6(unsigned char *packet_buff, ssize_t buff_len,
 			return;
 		}
 
+		printf("%s %s > %s ", ip_string, ipsrc, ipdst);
 		printf("ICMP6");
 		switch (icmphdr->icmp6_type) {
 		case ICMP6_DST_UNREACH:

-- 
2.47.3

