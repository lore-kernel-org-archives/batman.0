Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6030FC46CD2
	for <batman@archiver.kernel.org>; Sat, 27 Jan 2024 12:51:45 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id A9F7283F84
	for <batman@archiver.kernel.org>; Sat, 27 Jan 2024 13:51:43 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1706359903;
 b=b3DIQVoVtF+a7qcoqgTuknWvz2doXbv3M0gKfhqteWGg591azkR50aID0EVqh5FC3v467
 wAnb7S0ubosIV253VfGl7ht7bkruxTkt4S8W7msNG18/m5cmMXRjKxNQ8upUW53lm9EpvgE
 XsS8mOPC719dvkF48ToGD8VJbOEtnRY=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1706359903; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=lKbzh0HYhx673USzsx2jXNg08b/xV+LZN0cXoP4TYhU=;
 b=lrg6cfy7TfFRWeDRfp3wU4dgUIw47tP9uEBuS9kA8XczTyH5+l5nF7B0lehgvkwbEULgM
 KujOsgVEeaXO5CcZRSJBhhPqebJsYOUbgT4424ZEpqKvfjAR+HQwcbLuVCZnoDoEbUvaPPd
 vC5EMw3pTMvzu9QuAfHuywYbwnPHgAE=
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
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 04E4583E50
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sat, 27 Jan 2024 13:49:40 +0100 (CET)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1706359781;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=lKbzh0HYhx673USzsx2jXNg08b/xV+LZN0cXoP4TYhU=;
	b=Q3yG7mI/zcDxaNDPEG7RPnfF3S9d9zQerFJPwks9udxHj8EgUfc4VMWBLx18yUesOOxWC3
	VkGzLcYR4gcDQ7HczlPjfpOErHiZFylljGY3dD9YnPR5tYhj17cOWIbVyIUbsiiI+4o4l/
	b23WIkyDs9yTmqkMMoTKxsCOVRQMhCQ=
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1706359781; a=rsa-sha256;
	cv=none;
	b=W8QzE6atGcdxzmD1nLUdgksmtE3+o5YxxYLAQ/oFZNhuKJXtpAKreJwLH5UoICG7VTjZS3
	RAo5CjOm+zdccTRgLVPvEBl08UC/LI86pcJiEok1OnR8ycWA4+QBmBo3kWbMVUVx8Y/llu
	ltSDVo2wiT5k1AoQm3SV2jCJ/aiUwkk=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b="cf/yYAyn";
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1706359780;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lKbzh0HYhx673USzsx2jXNg08b/xV+LZN0cXoP4TYhU=;
	b=cf/yYAyndzX6B/zAGFG00Od/mR/oPCsXb7D9UzZQt3ZqyDv01zrskmOGskLyNrvLxcJMX5
	hixJnjRLhhb2pzxAZehGa8NQYObG7xeYL+crK8OBMhnqRkAeJziz/bomVVeOzDc3TzItmF
	yfUWZ07Vg1d1m2fwnEd5IcJ6WEcAX6M=
From: Sven Eckelmann <sven@narfation.org>
Date: Sat, 27 Jan 2024 13:49:01 +0100
Subject: [PATCH 3/6] batctl: tcpdump: Fix IPv4 header length check
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240127-tcpdump_fuzzing-v1-3-fbc1e1d3fec1@narfation.org>
References: <20240127-tcpdump_fuzzing-v1-0-fbc1e1d3fec1@narfation.org>
In-Reply-To: <20240127-tcpdump_fuzzing-v1-0-fbc1e1d3fec1@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=1140; i=sven@narfation.org;
 h=from:subject:message-id; bh=B98DKAqnawGRxlS+ETWC9dWxg0rcjAfykx17Tn9ZJn4=;
 b=owEBbQKS/ZANAwAKAV2HCgfBJntGAcsmYgBltPvh/mqx+FT8svm2arQpsYw2UlLf+fZX6VL/J
 50ht/W3ze6JAjMEAAEKAB0WIQQXXSuHYSVz3OMy4AJdhwoHwSZ7RgUCZbT74QAKCRBdhwoHwSZ7
 RrroD/93bmkWz3BUWHoxgPY6r0nDK2ld20OsSyJne7tqSwJU5yzhx2gh+QRzDfFy4Wmlxf/j9kT
 8aTzKjupYn9e1mDrI90TeEiaj1Y77e5iH/vmhBjF2LlQkHWvLU2gGCk2PfAMA0mgxi5VCmA/5aE
 ghqhG0taHZA01Evtmy50uYei/UGF+vt8UG28PAXgb0w+TkH1xrmiiAVsIquF+yNzeJZt7dUceO3
 0kUHT0sELGfz0MK3fKmnN73kci/opxTL+747IxKyUP4+Rn4sm00WS7yPj+j5ap62cf6J0B2miRO
 PgB4ZhPRjYYNwehcnuR3QX9UhHmxev4VS9q2+y0/csjcZ43RjtFTagLq3wTaEnY1nmF0dlnTe4f
 NGrcUirIhMA4YEeyMcIeew1YiOqueVZUX78i60QYiqaydA8ZqkuhX8L2SykpeHs+8uwd7WggnLF
 9gxgSumIVEHYG+ha8cRyZL+lmFd1VPlAUMtFfpx7vB0fSJpMrWg9Q6nmV+nyGII8AGAAgO1hT5z
 Ml77/f+xnCWC55/o/WT0+30ED4PpuAF0nCqEbUlCRxbzBqflrmkTwLIdPgwUkd9EMyWH0R2Ci51
 D5zkG6rs+hUHyF7HliDTd5xjOQVHPoasI1OTbs4vc9nK/SDTyTRDili2M0I+t1rl5CarnfLONoO
 bE9GX/zQE2TsyNw==
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: HRSOXCCT7SUNRFYGQQ32DGM3TDBVRORM
X-Message-ID-Hash: HRSOXCCT7SUNRFYGQQ32DGM3TDBVRORM
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/HRSOXCCT7SUNRFYGQQ32DGM3TDBVRORM/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

dump_ip() is directly accessing the header in the header length check and
assumes that ihl can be trusted. But when when ihl is set to something less
than 5 then it would not even be possible to store the basic IPv4 header in
it. But dump_ip would have still accepted it because it didn't check if
there are at least enough bytes available to read the basic IPv4 header. So
it is possible that it tries to read outside of the received data.

Fixes: 75d68356f3fa ("[batctl] tcpdump - add basic IPv4 support")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 tcpdump.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tcpdump.c b/tcpdump.c
index 9bb4b9e..3fdd7c3 100644
--- a/tcpdump.c
+++ b/tcpdump.c
@@ -694,7 +694,9 @@ static void dump_ip(unsigned char *packet_buff, ssize_t buff_len,
 	struct icmphdr *icmphdr;
 
 	iphdr = (struct iphdr *)packet_buff;
+	LEN_CHECK((size_t)buff_len, sizeof(*iphdr), ip_string);
 	LEN_CHECK((size_t)buff_len, (size_t)(iphdr->ihl * 4), ip_string);
+	LEN_CHECK((size_t)(iphdr->ihl * 4), sizeof(*iphdr), ip_string);
 
 	if (!time_printed)
 		print_time();

-- 
2.39.2

