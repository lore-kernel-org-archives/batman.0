Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC9CAC0015E
	for <batman-adv@archiver.kernel.org>; Thu, 27 Jul 2023 08:15:08 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 251ED82837
	for <batman-adv@archiver.kernel.org>; Thu, 27 Jul 2023 10:15:07 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1690445707;
 b=UOPPF6y0e8d22pSPR3e1SC2ECgdbCXdvD4YIMRUMaZ5MfCmtJM4M9e4v2Ha5Ru3tPfOSG
 KKjHYide3wTSjqsR7FdJjUfbeXiP9b0BySOD/Sl3tZHRNxby5p/nVtta/q0CaNKB2q9TlSR
 Xan5nsU0YO/zRcwAyqyDdHbM+TDGKn8=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1690445707; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=lgai9498h4WySyCn72bWMdikfIdbrl7UWP7CNrLqSoQ=;
 b=ImSrFYqo5J8Cev8J5/hH1wEplh/trf71U4cQzJO3hSIyUYLijUtYVxoqNP5XMRteAL2K6
 mprcSxIvFBHJ/qDFMqm+4XECFc+CtVhDhUv410EDR4wFIjAPZ0veeEb8V5y2zNy0JZx64Q+
 zGgtLlkAg2xdX0UBHx7zQpfq1DGjtdM=
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
	by diktynna.open-mesh.org (Postfix) with ESMTPS id C01D981924
	for <b.a.t.m.a.n@lists.open-mesh.org>; Thu, 27 Jul 2023 10:14:14 +0200 (CEST)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1690445654;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=lgai9498h4WySyCn72bWMdikfIdbrl7UWP7CNrLqSoQ=;
	b=oIXVozZ36n5ru9OuLlRnG0k58DFLzqgDZ7mgd+xZPQPgEj1Agi3Jsc/PQmY4AE1/PenhSG
	4Lbsdz5njrskHvqtKeeNO7+CMdPgdMQHtsQMYPb3OeOD+4GtMpNOzr7ya2vOIVbkKkP86x
	Fc77RAUolbcD7xtL3m8Q14lPNa7kKl8=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=MKTiMHC2;
	dmarc=pass (policy=none) header.from=narfation.org;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1690445654; a=rsa-sha256;
	cv=none;
	b=JVbI4fkxLxa0SPlti+Sn3bxMWRsihXxbWwWp844mKyRd/9Xifj9plh0jbgdPp1ytdjSgV1
	PJqWPoDbS23wbuSClWGWJMiQx9nWyk/L0o0eMCuUCVeA05pBS/ps1bvfPZApEkGGinSh7m
	c7KCF8B9zLBZwW3d3NOcMuIEQC0MkU8=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1690445654;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lgai9498h4WySyCn72bWMdikfIdbrl7UWP7CNrLqSoQ=;
	b=MKTiMHC2tiLRt9yyJfGXp3LxCxtvTTMjj/eRiLHqCp1OJmOgQiJW/4+NzeqV2SnDRaLzrJ
	Cvg8YBnbQAqFij3YWlKm3x63fDIgOjP6kl1uJsiIgVhgHVa7vRac75f3af6T/lSb1+HLme
	UBaCX+gKEAYfkf4u7WdSOcUpUxX44Fo=
From: Sven Eckelmann <sven@narfation.org>
Date: Thu, 27 Jul 2023 10:13:42 +0200
Subject: [PATCH RFC 1/3] batman-adv: Avoid magic value for minimum MTU
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230727-jumbo-mtu-v1-1-036ce1a6e33c@narfation.org>
References: <20230727-jumbo-mtu-v1-0-036ce1a6e33c@narfation.org>
In-Reply-To: <20230727-jumbo-mtu-v1-0-036ce1a6e33c@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=875; i=sven@narfation.org;
 h=from:subject:message-id; bh=Z4L+JSYnxRehrPI0RFqwwv7dDyMe5bo1qPebP8+uwos=;
 b=owEBbQKS/ZANAwAKAV2HCgfBJntGAcsmYgBkwidHBCJ5/W9i1m3hVhm65GyNhIpFAm7EF5Abx
 LzK/Xmzqs2JAjMEAAEKAB0WIQQXXSuHYSVz3OMy4AJdhwoHwSZ7RgUCZMInRwAKCRBdhwoHwSZ7
 Rnt7EACmBVGtfHmUgdOIuhCvlO5qN30SnSWLzmiuOUnc5M0CXWqUHWdSbTmM2SkMoLa7UxvOa5Y
 J0MasK/HDM0lUqhtqbEukTcyjIxKRk5swUq/EMDzKbF20PdL0Cvn8hZ4vcSt3DA7YVyFJhk2W8W
 nujcvmCe3BqQSzxXj13q5sFXAIY35tyYfnzvpqJP0Jh63/TDgMjgDjm2VYPCul+syRF56hi+e9h
 3RInrl+GUME0sFTbdt5iJ1KQtJ8OtHXopwkoLUsJ+Y7+7pSqQkbvvTKGN94iWTjyiWDw7O8Y+Se
 d4QPuaE//xapgARFj5XHlrcXcdGy/tJijZZEGR/ChqWPOtIkIzb+PRxu/6l5naVKMi5xtMKx6w6
 okOFofTAiA1u3UVqCABHmjhgxnOfVW9Jax/JXk8tz8zGtk7i5VZ+dBj+/GkD9daFTor1BvMYYFT
 B6q2Wi+MUp2eUmXyXI6VRzX2K8I/R8bdwkNKHKswcxJLT/rdBy76inrrpqNb7tyBRrOFhsNeLJS
 P3Pk4Q4dvYSW+WMCI413c4AC3JpoblUilCD4I6MIS0oQgZNSop3wWGH+zHAKk3e2PUqrFv8MIO6
 Ag0/zhPFG/tl4zSQEPXOEvzSrVfI4M7JjgOWlKvSqmfQS7vy25iTMQZe9HB7zfjR9w7vAnjhJgM
 aAmeO6av7z9YQ2w==
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: EJF43MQAY5I7C7RU5PWH7H3GKCVGVECQ
X-Message-ID-Hash: EJF43MQAY5I7C7RU5PWH7H3GKCVGVECQ
X-MailFrom: sven@narfation.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-0;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/EJF43MQAY5I7C7RU5PWH7H3GKCVGVECQ/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

The header linux/if_ether.h already defines a constant for the minimum MTU.
So simply use it instead of having a magic constant in the code.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/soft-interface.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/batman-adv/soft-interface.c b/net/batman-adv/soft-interface.c
index d3fdf822..f7947fad 100644
--- a/net/batman-adv/soft-interface.c
+++ b/net/batman-adv/soft-interface.c
@@ -154,7 +154,7 @@ static int batadv_interface_set_mac_addr(struct net_device *dev, void *p)
 static int batadv_interface_change_mtu(struct net_device *dev, int new_mtu)
 {
 	/* check ranges */
-	if (new_mtu < 68 || new_mtu > batadv_hardif_min_mtu(dev))
+	if (new_mtu < ETH_MIN_MTU || new_mtu > batadv_hardif_min_mtu(dev))
 		return -EINVAL;
 
 	dev->mtu = new_mtu;

-- 
2.39.2

