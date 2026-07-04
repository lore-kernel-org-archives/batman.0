Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86791C43458
	for <batman-adv@archiver.kernel.org>; Sat,  4 Jul 2026 19:39:34 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 0D14184639
	for <batman-adv@archiver.kernel.org>; Sat, 04 Jul 2026 21:39:33 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1783193973;
 b=VnsBv3Eg4MMsLodxyorH3m93NvksYgOLCJMp39mEAJ4Q7gK2YDP9Wy1LmLVbhDrE9XCfJ
 RxceedZQjR0h1loUK1B+jb25XzKuHOkodXyZ2wEB3nBMiI/ytR9UIZN2i+DGTmDJXwZI34C
 hEa2zvYr0LtlQ1VBo211y46xJBhVAC4=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1783193973; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=1XuvbiL9QiAb7aEBqTTwi9SI5GZmcBxgTMHT3vdHQVQ=;
 b=dPqgCebCz26AnG98/R6tR4eZWC5+BDUWLSUoLrWZM04zocPC3uQ2GZgXxouNvJ9CAFQwG
 S+Zdim3n/1KDDP7eovwZCTAVFIuG7Ghi/DtU1WxsdVMEqZKMr3bTSpHBBOGwnoBGuXFr83H
 hmynnyQAfDufTE3FKtWybmCFArbLkSE=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 3FC2B84204
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sat, 04 Jul 2026 21:36:36 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1783193796;
	b=iOY4C/hoYziTRLDP4bZ3ixoLvb2nYJysQLJHp6RpDff+qieLlvyxjY3S8YoXqabZTKeVAi
	r+82QGxLiWY7PLVWUH+jjufQksan04MDG8qfLCEgEG73kek4IKOUhiVLeCQGibKtpw/6Fm
	AewfUVGMr9MsbrH0RGNAIWzEXNueL7c=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1783193796;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=1XuvbiL9QiAb7aEBqTTwi9SI5GZmcBxgTMHT3vdHQVQ=;
	b=RWbx4WF3Vitic2H1yUafbHZlYsJgCmNE/nuSwC0mYE8LHg6m6waY278/MRauOH8IfAzBZf
	SJJkM8KZo04XXZu6wdjAk/oKI/nSoh7+5oMOpzpjRXtc9q6bt2r7dsQ5HsZ252BCFZL7Xb
	77ke1WnFYTYPVe3jAmrAVKWKDzOfAG0=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=ETRYytP5;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id B615F20685;
	Sat, 04 Jul 2026 19:36:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1783193795;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1XuvbiL9QiAb7aEBqTTwi9SI5GZmcBxgTMHT3vdHQVQ=;
	b=ETRYytP57EBTseyiLVTdRSE3kj1IpSbqWnOAxMk9+DCXt0VkpxCqXDJH3GiPQgrjK03zgg
	Hfyvgc24UHvYfb082DVHUsuLf1fGV/pIiQwyocQzoh0YjHtHhA99gQYekRM669VAKZilhR
	Zcsog+HcjVES+c8+FpfAoKchtj/D1os=
From: Sven Eckelmann <sven@narfation.org>
Date: Sat, 04 Jul 2026 21:36:02 +0200
Subject: [PATCH 4/5] batctl: debug: reject non-finite/negative
 interval/timeout values
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260704-bugfixes-debug-v1-4-888ddc878206@narfation.org>
References: <20260704-bugfixes-debug-v1-0-888ddc878206@narfation.org>
In-Reply-To: <20260704-bugfixes-debug-v1-0-888ddc878206@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1889; i=sven@narfation.org;
 h=from:subject:message-id; bh=Khn4IpybZ+DKt6zMFE79r9y356qWwX866Xxs6Gs8Uzc=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFmeCcsDc3/bKWf8a8rvZ3b/ZuSf0tws8CKncMLJrKWnL
 7PzWHd1lLIwiHExyIopsuy5kn9+M/tb+c/TPh6FmcPKBDKEgYtTACay7A7D/8LrmlIFDkXuh4oK
 hLLdJka8Nt/k1pl/JOW6Ttky24UFVxkZZqv5LPnDF9p/oNd0u4p4lpev+Ar9gDTvjrW276LWvnz
 KCwA=
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: TIYPRPU5IAAZBSHIPD75BFKDFFKKOA3D
X-Message-ID-Hash: TIYPRPU5IAAZBSHIPD75BFKDFFKKOA3D
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/TIYPRPU5IAAZBSHIPD75BFKDFFKKOA3D/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

A "%f" sscanf conversion accepts the textual floating point literals "nan",
"inf" and "infinity", and an out-of-range magnitude such as "1e9999" is
converted to infinity. There are calculations and comparisons performed
with the values. They must therefore be well defined non-negative and
finite numbers.

Fixes: 302a41a73915 ("batctl: Add timeout filtering option for originators")
Fixes: e4a7b7733faf ("batctl: Add an optional interval for watch-mode")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 debug.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/debug.c b/debug.c
index 1cceea6..22cbcb8 100644
--- a/debug.c
+++ b/debug.c
@@ -10,6 +10,7 @@
 #include <stdio.h>
 #include <stdlib.h>
 #include <errno.h>
+#include <math.h>
 
 #include "debug.h"
 #include "functions.h"
@@ -68,9 +69,10 @@ int handle_debug_table(struct state *state, int argc, char **argv)
 			if (!optarg)
 				break;
 
-			if (sscanf(optarg, "%f%c", &watch_interval, &tmp) != 1) {
+			if (sscanf(optarg, "%f%c", &watch_interval, &tmp) != 1 ||
+			    !isfinite(watch_interval) || watch_interval < 0) {
 				fprintf(stderr,
-					"Error - provided argument of '-%c' is not a number\n",
+					"Error - provided argument of '-%c' is not a positive number\n",
 					optchar);
 				return EXIT_FAILURE;
 			}
@@ -83,9 +85,10 @@ int handle_debug_table(struct state *state, int argc, char **argv)
 			}
 
 			read_opt |= NO_OLD_ORIGS;
-			if (sscanf(optarg, "%f%c", &orig_timeout, &tmp) != 1) {
+			if (sscanf(optarg, "%f%c", &orig_timeout, &tmp) != 1 ||
+			    !isfinite(orig_timeout) || orig_timeout < 0) {
 				fprintf(stderr,
-					"Error - provided argument of '-%c' is not a number\n",
+					"Error - provided argument of '-%c' is not a positive number\n",
 					optchar);
 				return EXIT_FAILURE;
 			}

-- 
2.47.3

