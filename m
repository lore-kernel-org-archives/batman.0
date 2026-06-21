Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6BC1CD98F0
	for <batman@archiver.kernel.org>; Sun, 21 Jun 2026 14:34:12 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 4247E8403B
	for <batman@archiver.kernel.org>; Sun, 21 Jun 2026 16:34:11 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1782052451;
 b=DFuWhPVuPCIyfZ+k+eWMgixjvh5Sc0wg+bkpSjEk27C0E4yg7aGIFgPl7cd3uV4iab+Zs
 oyZGaLi91xrFvXezNtY4xYDOKo9vDUXKervzIXGwmnirp/azf63YtigF8MTkYSn8/4PkiL3
 hARXalxPHqAGgX7J2utInmUkpPzvQzc=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1782052451; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=4u7FnX8hNlnnmd5rm103/8F/gjTTKffauHCFBuCKTzs=;
 b=zn6YdQBkAv7viGzyRc5gyYf/RG35AC2YezxJasMOjPV/NdaFgnXAcKRWMATnFI6hgngnz
 VPNpaL3w3iCVQsKR9CoNg/stuZ/qBDQHfwkJNOJVPXYUnCVpT6SjDtqt7ZR7I+LkIvekhWf
 dgqMI+yMRJMKSIG4N9Gn1C2K6ryNR5E=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 710B68084B
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sun, 21 Jun 2026 16:25:10 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1782051910;
	b=oQPSJzTwbqHmFM++1euOfZo9L1gRwD/6YbXargYA0qc/yshccyemZVXl+vuEEIcgrvIYdT
	U4vaw8eeIVuXcGxKZyg5BRA20Qf2k/nOFEapPMgiH3mbfN9lCGH3JwDz6p1hotS18CBEcq
	+90lH4dggPoHWpIZU8yNw30iGCpGSMg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1782051910;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=4u7FnX8hNlnnmd5rm103/8F/gjTTKffauHCFBuCKTzs=;
	b=c3iTxFu+91QftuQTjHjpx0lI1U69pG8kXzotTc5OAESSntxHZtq8RIp5NOx59Yn0eVoAzU
	IJ1xnU8WjNbexAkjCSRxuTwxI2WcPPcGLsxsPdQ6JwWA4jFvIIxxoLONn8pFx8pcK97P9T
	rgi+FKgS69RBRyJ1Mk3KYNoiePIczmA=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=Ay+7tWvs;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id 2DABC20059;
	Sun, 21 Jun 2026 14:25:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1782051910;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4u7FnX8hNlnnmd5rm103/8F/gjTTKffauHCFBuCKTzs=;
	b=Ay+7tWvsOJdsLOjMUtmUyERiat/wI9kS/nKluvFmuEyz8GDQhTYx9a4IbI+Te1LZy03QoV
	noymyQwAP/C88kxbNdvHA6bkdBq5CEkzNuoptTt4BzMCjchzXa6eqMBEEO2VYoHFMpKEIW
	kyVl5+M3eeQb/y4xAzCAcaeLTVreP4M=
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 21 Jun 2026 16:24:03 +0200
Subject: [PATCH 13/28] batctl: tcpdump: fix reported length for
 ICMP6_TIME_EXCEEDED
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260621-bugfixes-v1-13-b09736288a4a@narfation.org>
References: <20260621-bugfixes-v1-0-b09736288a4a@narfation.org>
In-Reply-To: <20260621-bugfixes-v1-0-b09736288a4a@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1094; i=sven@narfation.org;
 h=from:subject:message-id; bh=q3NPUkStlHrTvYlpNFSceZwirANZxzppdiYkSkJZA3w=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFnmX9gkzty4M8vPNSE5vGm+3eljrAuWi7x/8PrCp1lng
 yZ9e//hUUcpC4MYF4OsmCLLniv55zezv5X/PO3jUZg5rEwgQxi4OAVgItc9GP5nLjnsoqnI9WN3
 mvx1n80nXx87GH71RtgR8w8iCqUT3KaGMfxmNZH6dZ63Z8IGnXTBvxusI1qnNovH7c2riLkZyVd
 5o5IPAA==
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: 7PZ2PGEYCKQ2CCYWM2SHTCDADPZJWJLK
X-Message-ID-Hash: 7PZ2PGEYCKQ2CCYWM2SHTCDADPZJWJLK
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/7PZ2PGEYCKQ2CCYWM2SHTCDADPZJWJLK/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

The remaining buffer size for ICMP6_TIME_EXCEEDED is only the buffer length
minus the IPv6 header. It could now be discussed whether the output length
should now be with or without the icmp6_hdr length. The length with
icmp6_hdr was chosen because the code looks like a simple copy and paste
error and ip6_hdr's length was most likely the actual intent for the
calculation.

Fixes: 35b37756f4a3 ("add IPv6 support to tcpdump parser")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 tcpdump.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tcpdump.c b/tcpdump.c
index 0895c61..9c90f36 100644
--- a/tcpdump.c
+++ b/tcpdump.c
@@ -669,7 +669,7 @@ static void dump_ipv6(unsigned char *packet_buff, ssize_t buff_len,
 			break;
 		case ICMP6_TIME_EXCEEDED:
 			printf(" time exceeded in-transit, length %zu\n",
-			       (size_t)buff_len - sizeof(struct icmp6_hdr));
+			       (size_t)buff_len - sizeof(struct ip6_hdr));
 			break;
 		case ND_NEIGHBOR_SOLICIT:
 			LEN_CHECK((size_t)buff_len - (size_t)(sizeof(struct ip6_hdr)),

-- 
2.47.3

