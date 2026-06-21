Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3CB4CD98F2
	for <batman@archiver.kernel.org>; Sun, 21 Jun 2026 14:33:29 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 96B2984383
	for <batman@archiver.kernel.org>; Sun, 21 Jun 2026 16:33:28 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1782052408;
 b=uYHT0J7YuLnvR4P5nQF1vX6I1diRishxXsyjgIYFGZV1AQMNPU7VBGFITr63XHOHurR4v
 MLzbC5YeoZDRVjn7hCmunIL7j4TFip+z2ULTOARWpEn1oz00kIRCN/drL4j15h3/hhN7Khd
 wLujYU8bq2m/UMll9FYTvm+Hg1/sZ7Y=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1782052408; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=Mp9FjWpJygiqBkMyCIsIfz68kRfqHSyi88DTf9/lNhk=;
 b=QiYNW/3U0cEX/HDndLa59VxSr6fS0sgfSDJKrtKfmFsdyD9mgBO30Y92sbWVg2zbW2BlD
 qHgi8+zxysm25sffbhhyOsVs1Gk1HlVQ+jIBgcN1zYGxTsXxuSA1q/F5L3tcduPJgjbqoyS
 KVStTqHraeshRlWbWqwNQYycR+dcgL8=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 464C683CE2
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sun, 21 Jun 2026 16:25:08 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1782051908;
	b=07OfnvOsFzZs59eOfKTTenZZx1sUSATusDQsQYLsCYUr2QneTrgQBTPVcOWQHGl7QOmATv
	DBQZ9XRVBYHh617rTSZ8U2fZn63IHwSmqE8KbH2JBo4pfdV5ShTPYsy85EmBh+soXI0exW
	VWlApkSJH4354fnF3pCb5pKKalxtzBs=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1782051908;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=Mp9FjWpJygiqBkMyCIsIfz68kRfqHSyi88DTf9/lNhk=;
	b=ssUXfXrPv6AvEl6L2U9w2SnAr8v4zI/goPs3+snpCYErzhQ1GS2ADYtLUy931TC8PEzvmz
	HO9Ub2KFS5KLfLqNkmaMetpu3/ukCg679vicFZKwt3cSTHqZe/L2uLv826dGMo9I3OUSzr
	6fKs8A+d5GJ3e39zrpN96u6hEvOAamg=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=XBoZ1qgC;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id 0441120059;
	Sun, 21 Jun 2026 14:25:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1782051908;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Mp9FjWpJygiqBkMyCIsIfz68kRfqHSyi88DTf9/lNhk=;
	b=XBoZ1qgCIEPsd9dhnvSN3lwMOsBqFQkWAG68oqrD+N3wzyxOCrlbhtFqXZ3/xOT0hG6u4Q
	x0GMa5s/IuwP8OHfw8ggI2fvzpMfgTkyL8UyFmPzgNJpN0wBMFhVVmXQ8bKhixdqv2hg8f
	NrsfKn/f9n8VopI3DLKc57fMsa3RyHE=
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 21 Jun 2026 16:24:02 +0200
Subject: [PATCH 12/28] batctl: tcpdump: drop hardcoded IPv6 buffer sizes
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260621-bugfixes-v1-12-b09736288a4a@narfation.org>
References: <20260621-bugfixes-v1-0-b09736288a4a@narfation.org>
In-Reply-To: <20260621-bugfixes-v1-0-b09736288a4a@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1513; i=sven@narfation.org;
 h=from:subject:message-id; bh=4HIoXmlx1Fhs0wr+KtsuaQzx6mhZLDgzTFDUbPZJX0Q=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFnmX9gavWd+PMXu0Xl1wQzPS6XSmQLtPA3cobEPu/Q2+
 N4Ss7bqKGVhEONikBVTZNlzJf/8Zva38p+nfTwKM4eVCWQIAxenAEwk5zHDP+NsD4Hr82S+l6Z9
 KQ88z5X6PPeE7NbUWPm5/0W1TsYtmc7wv1h2xalNL9Zq3NL4op27qI6dMcvgemVMWb7Y/Rpdg58
 n+QA=
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: WNBZRJAPKYUFNESLGNK5PLE2NQ6CGYFD
X-Message-ID-Hash: WNBZRJAPKYUFNESLGNK5PLE2NQ6CGYFD
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/WNBZRJAPKYUFNESLGNK5PLE2NQ6CGYFD/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

The inet_ntop expects to know the dst size buffer. But instead of
specifying how to calculate the size of this buffer, just a value was
hardcoded - which might not fulfill the "INET6_ADDRSTRLEN" size
requirements.

Evaluate the size of the buffer at compile time to avoid potential
discrepancies.

Fixes: 35b37756f4a3 ("add IPv6 support to tcpdump parser")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 tcpdump.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tcpdump.c b/tcpdump.c
index e417cd1..0895c61 100644
--- a/tcpdump.c
+++ b/tcpdump.c
@@ -676,7 +676,7 @@ static void dump_ipv6(unsigned char *packet_buff, ssize_t buff_len,
 				  sizeof(*nd_neigh_sol), "ICMPv6 Neighbor Solicitation");
 			nd_neigh_sol = (struct nd_neighbor_solicit *)icmphdr;
 			inet_ntop(AF_INET6, &nd_neigh_sol->nd_ns_target,
-				  nd_nas_target, 40);
+				  nd_nas_target, sizeof(nd_nas_target));
 			printf(" neighbor solicitation, who has %s, length %zd\n",
 			       nd_nas_target, buff_len);
 			break;
@@ -685,7 +685,7 @@ static void dump_ipv6(unsigned char *packet_buff, ssize_t buff_len,
 				  sizeof(*nd_advert), "ICMPv6 Neighbor Advertisement");
 			nd_advert = (struct nd_neighbor_advert *)icmphdr;
 			inet_ntop(AF_INET6, &nd_advert->nd_na_target,
-				  nd_nas_target, 40);
+				  nd_nas_target, sizeof(nd_nas_target));
 			printf(" neighbor advertisement, tgt is %s, length %zd\n",
 			       nd_nas_target, buff_len);
 			break;

-- 
2.47.3

