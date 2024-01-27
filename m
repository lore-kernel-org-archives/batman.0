Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AAD2C46CD2
	for <batman@archiver.kernel.org>; Sat, 27 Jan 2024 12:50:26 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id C8DFD83E50
	for <batman@archiver.kernel.org>; Sat, 27 Jan 2024 13:50:24 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1706359824;
 b=DED44VrJH1Hd5yIC44bffA+4mwkIkyVVWicgeJpy+t35JJox/M0Yfed8LC7Cq/2LP2dXo
 H3P81U8xTOJf+VuAtzp6yV8asdYlGF2JLsMqv4sxTeUtCkNc4qIHJOL4gFPElnThHmXVvr0
 dUnr0Hnez/io7yO48r6fXNZ2DAnX6cU=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1706359824; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=wSzVySyj5MVrQa+9NIfLshrjnwM1U+vSVnOLsdIn64k=;
 b=bLL2oqBEhl8bAGOQSjzLHpa2d12wnW2DQ5vtqCKWN0P177JUsxeS0b09KJ5sdIZkchKpH
 oCu+m49zJQaRrHCm+pT375lz0qmBiNkvrwIpf4Hl8CGvNykKL4+N9zoONEViic4s6LbXVi2
 ziHHLsYviA+j/cnbrKezZCcs1eQU0BQ=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
  arc=pass;
  dmarc=pass (Used From Domain Record) header.from=narfation.org
 policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 3135B83E50
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sat, 27 Jan 2024 13:49:40 +0100 (CET)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1706359780;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=wSzVySyj5MVrQa+9NIfLshrjnwM1U+vSVnOLsdIn64k=;
	b=2jeczrjsl+Lqm8aVyvbtOwYEHbpXc7+n7iBlqfkMEFVA4sZjnMci1dHMubRBD5hfQdJilz
	TJ9HXHkHkuABb0Yz5CfRdlDk6/5yqi3lwxblKZEPq6aAxKmcP6YE7EHn3AumGdO+8bwDh0
	dX2R0YStFPzBqgeQ9oZsiIJpE8viyS8=
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1706359780; a=rsa-sha256;
	cv=none;
	b=AHHNHd/h3l6rMYgmqfuVOmyhWCDtowlYa9sQkM1vGn9DuH/sS3/OXy5Tb0VVmAe3+Bv8Rr
	MhLtlCO286pzqKSifK2cMj2Hfan8l6hp8wIJIr4USGwb3ZfMC2hAv81QjnREyycA3d6zQm
	B7ZhS3En7p0MLyaUonZYVQR1iIenzf8=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b="0NfnSFR/";
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1706359779;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wSzVySyj5MVrQa+9NIfLshrjnwM1U+vSVnOLsdIn64k=;
	b=0NfnSFR/X3nVLYIm8F8EDm/0EScvt0mHdYjR30SRtfieSX2grNMe69hAjeAMv+fVTa5NSN
	ja/ScoMR4tvm/n8/qPFsRu7EwzzKZ+DsCqdgZrHCujkrabZ0i+HST2zSOkRzdNm6EbZg/w
	HN3q6vEOopq2rhujQsndHFa45GpEMCE=
From: Sven Eckelmann <sven@narfation.org>
Date: Sat, 27 Jan 2024 13:48:59 +0100
Subject: [PATCH 1/6] batctl: tcpdump: Fix missing sanity check for
 batman-adv header
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240127-tcpdump_fuzzing-v1-1-fbc1e1d3fec1@narfation.org>
References: <20240127-tcpdump_fuzzing-v1-0-fbc1e1d3fec1@narfation.org>
In-Reply-To: <20240127-tcpdump_fuzzing-v1-0-fbc1e1d3fec1@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=1080; i=sven@narfation.org;
 h=from:subject:message-id; bh=tm0dZarkFxcq5htLQkTqldU8iV5feDLHFN35pR4XHYI=;
 b=owEBbQKS/ZANAwAKAV2HCgfBJntGAcsmYgBltPvg0Bx/jGJwk+Ho4iDqJC/7RABs6ZH9em6ce
 eq5OwUkwriJAjMEAAEKAB0WIQQXXSuHYSVz3OMy4AJdhwoHwSZ7RgUCZbT74AAKCRBdhwoHwSZ7
 RtqED/oDhyhBJjOV8536EyCrYQTuhwQ8AQq6ctC0BmcMOehYbF0SDtvX5nHJqTkdPNMghctjcm2
 8N//5jTR0VeX9zXuNYFiBMHcZBNtVnxsBupR9fTzK5xSWYO9BGmcNRpeRPbF6EDQEZKhq7hH1zl
 A77xRs+IfOEMthnFYUIDcSyZcV0RMZ0C0TXyoHWYBTIua4y1hEdCIQACwVyPfGbtztZIbYncKtg
 o/faNKV+aBKNNWQkHqh7rFSMAepGvke7dPR9igvBEq/hG/UvNJnhfc5GDFKrvZgtMs4yXp/wZjv
 U/63o7RbmhiwSBE9hJGD8IFWf431ClUlBaDnTy3lgAMVABoZl6p99Q8x+iZN/Ed52avjVQR2vVF
 mdPqT4hwbnABukkuGEU4eDdMow2/sO4mnPA9FlHJIw//Tk8Em1QTQH1/oftU065Homrgmxv6cK0
 Rchf4AGWOoCzC0apC+X8NLLwfhesUVlOfu0jGoJs03nA7o2YAGIvlP+w/7Z3SJJFHi2BNKyhs1E
 9nzQIOPSglgXsUDeeoX1GR4u5n85Y3QIqpVNK0RRk7cY3BqrMlCpZfAPmv6NSvLJlFRuwlKFYef
 yAQO+md17SVbzSpYegVOGGZIUu2crP8/AYS6CZTYdfsXnIF43udd3PT9oLE4RdelEAnIo2Ki2tO
 GSCmfLPqdKCMq+g==
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: LH7SFYHMKXFO6PM4MMBFL3Z2GVQPGFG6
X-Message-ID-Hash: LH7SFYHMKXFO6PM4MMBFL3Z2GVQPGFG6
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/LH7SFYHMKXFO6PM4MMBFL3Z2GVQPGFG6/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

parse_eth_hdr() is assuming that every ETH_P_BATMAN ethernet packet has a
valid, minimal batman-adv header (packet_type, version, ttl) attached. But
it doesn't actually check if the received buffer has enough bytes to access
the two bytes packet_type + version. So it is possible that it tries to
read outside of the received data.

Fixes: 3bdfc388e74b ("implement simple tcpdump, first only batman packets")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 tcpdump.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tcpdump.c b/tcpdump.c
index d340af9..d15c32e 100644
--- a/tcpdump.c
+++ b/tcpdump.c
@@ -1167,6 +1167,9 @@ static void parse_eth_hdr(unsigned char *packet_buff, ssize_t buff_len, int read
 			dump_vlan(packet_buff, buff_len, read_opt, time_printed);
 		break;
 	case ETH_P_BATMAN:
+		/* check for batman-adv packet_type + version */
+		LEN_CHECK(buff_len, sizeof(*eth_hdr) + 2, "BAT HEADER")
+
 		batman_ogm_packet = (struct batadv_ogm_packet *)(packet_buff + ETH_HLEN);
 
 		if ((read_opt & COMPAT_FILTER) &&

-- 
2.39.2

