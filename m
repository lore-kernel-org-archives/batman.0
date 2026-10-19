Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50B04CCF2DA
	for <batman@archiver.kernel.org>; Mon, 19 Oct 2026 10:02:59 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 3A2558427D
	for <batman@archiver.kernel.org>; Mon, 19 Oct 2026 12:02:57 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1792404177;
 b=sxp11uhCCiU7uwD+bHz9zxJH4vri5CeMshLMWADmIAQ732JS8dFagbn+648re5LmRcox8
 8NR1wJ0XSVVxAy+GEX5vuz4IDKPKIjK9tdcUSSDQWt2z6hmUIANOr6H+csWXQ4oqKfMGTEz
 0Q2DmN6dYpU0wGy/f4Bo6uRjVEKWfrE=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1792404177; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=sOxcoPyhdrk6/1ihZIW6d4BGVVDc/izNv+YDJbLE7CA=;
 b=oVqKRvopzxn8dnliyo762kBEtkXsbEgfSxvYbeJWIYgvf0q5tZ2zzkzdUELN4o7OihPoz
 0cianp1/5JLqIuhWOzKq7dvYyCbBEQmofWv9G/2Dsq7Htl0FuX1i1V8l5sYK7VxFk21iQFh
 tHE7LFtxj0/FjZMEzg0Oujm/V1Celi8=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id DEA4B80E2E
	for <b.a.t.m.a.n@lists.open-mesh.org>; Mon, 19 Oct 2026 12:02:47 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1792404168;
	b=1X+tUVG3ovC3jUZsX4LphVjpnYThVQmsz4czPwRvJedmipjiPg04Hun7SEzqK0W6+g7tJk
	2oI+qK4oRvA84E/j/RBRz2zn0VPOUfhcgGmxQwcAt8z6cY1GaiEzNwkaThYYWAAqy03ceZ
	Nl3AyNqERqtJU8pia63npuNnYdwgDEA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1792404168;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:dkim-signature;
	bh=sOxcoPyhdrk6/1ihZIW6d4BGVVDc/izNv+YDJbLE7CA=;
	b=VxPiMSWCrfXEwDg3YwALe+Djz/x7yHbFekLM8N2bxDfcJT/+ARPavA2g8u3bFExE44CX8i
	5k1r4S9YvzxWyZvB40nZnY+CdBjPTh+aiVarrSMLHYy2YZtyQtjdWz+GUCPiSniqI1clP1
	CA/zdI0OTSpsaxM4+4cSaRKPKEaCyig=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=fiB+z8vc;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id E2C8D20281;
	Mon, 19 Oct 2026 10:02:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1792404167;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=sOxcoPyhdrk6/1ihZIW6d4BGVVDc/izNv+YDJbLE7CA=;
	b=fiB+z8vcSXGE6pun2JrwxSwXKr1NwvwEDBXC80lseCJdOSWDtGMMQzAE5hAmvY16G5HCGG
	Rk0+L/1i6kb54dbXUWpiT2LP7PQE0n9Za6VkQhXPXlDcfw3/LjdVium/5NiZpNUV1JyqhR
	0vRPtt2pKMzPKieqE9osXq/MXegARkM=
From: Sven Eckelmann <sven@narfation.org>
Date: Mon, 19 Oct 2026 12:02:43 +0200
Subject: [PATCH batadv] batman-adv: compat: drop private copy of average.h
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261019-compat-ewma-v1-1-9af0a7dc4065@narfation.org>
X-B4-Tracking: v=1; b=H4sIAMLq1WoC/yWM2wqDMBAFf0XOcwPGS6X9leLDGjd2BS8kqRXEf
 zfq4wzMbPDshD3eyQbHi3iZxgj6kcB8aexYSRsZWZo9dapfykzDTEHxfyBV5EVuq9JYbSvEYnZ
 sZb1uHzQUqF1Q397/mp5NOFfY9wNQYrfidwAAAA==
X-Change-ID: 20261019-compat-ewma-4343f75cf1f7
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3409; i=sven@narfation.org;
 h=from:subject:message-id; bh=THcFULg3GCxxurK0+bRv5kvD+vnnxekZ/gwaVhP3fEQ=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFlXXx3uE1jmwbsn8mNwWyHPrff/4vYu8IqOP3HGeZ/K9
 VmcgeUhHaUsDGJcDLJiiix7ruSf38z+Vv7ztI9HYeawMoEMYeDiFICJ9DsxMjTy1Ybte/3rlF+O
 2YnDG7v7VNksmt24T9QpnpoV9WBvdw0jw4+6w5ZBPyq22TpWctdOSyh4/jjEa6FsV8iuetlHK/s
 vMgMA
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: OB74JEI3FTP6IP4N4TQBVEG7LULECOBL
X-Message-ID-Hash: OB74JEI3FTP6IP4N4TQBVEG7LULECOBL
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/OB74JEI3FTP6IP4N4TQBVEG7LULECOBL/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

The DECLARE_EWMA macro didn't change since 9 years (Linux 4.15). It is no
longer needed to ship this macro.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 compat-include/linux/average.h | 76 ------------------------------------------
 1 file changed, 76 deletions(-)

diff --git a/compat-include/linux/average.h b/compat-include/linux/average.h
deleted file mode 100644
index f9afe906..00000000
--- a/compat-include/linux/average.h
+++ /dev/null
@@ -1,76 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-
-#ifndef _NET_BATMAN_ADV_COMPAT_LINUX_AVERAGE_H
-#define _NET_BATMAN_ADV_COMPAT_LINUX_AVERAGE_H
-
-#include_next <linux/average.h>
-
-#include <linux/bug.h>
-#include <linux/compiler.h>
-#include <linux/log2.h>
-
-#undef DECLARE_EWMA
-
-/*
- * Exponentially weighted moving average (EWMA)
- *
- * This implements a fixed-precision EWMA algorithm, with both the
- * precision and fall-off coefficient determined at compile-time
- * and built into the generated helper funtions.
- *
- * The first argument to the macro is the name that will be used
- * for the struct and helper functions.
- *
- * The second argument, the precision, expresses how many bits are
- * used for the fractional part of the fixed-precision values.
- *
- * The third argument, the weight reciprocal, determines how the
- * new values will be weighed vs. the old state, new values will
- * get weight 1/weight_rcp and old values 1-1/weight_rcp. Note
- * that this parameter must be a power of two for efficiency.
- */
-
-#define DECLARE_EWMA(name, _precision, _weight_rcp)			\
-	struct ewma_##name {						\
-		unsigned long internal;					\
-	};								\
-	static inline void ewma_##name##_init(struct ewma_##name *e)	\
-	{								\
-		BUILD_BUG_ON(!__builtin_constant_p(_precision));	\
-		BUILD_BUG_ON(!__builtin_constant_p(_weight_rcp));	\
-		/*							\
-		 * Even if you want to feed it just 0/1 you should have	\
-		 * some bits for the non-fractional part...		\
-		 */							\
-		BUILD_BUG_ON((_precision) > 30);			\
-		BUILD_BUG_ON_NOT_POWER_OF_2(_weight_rcp);		\
-		e->internal = 0;					\
-	}								\
-	static inline unsigned long					\
-	ewma_##name##_read(struct ewma_##name *e)			\
-	{								\
-		BUILD_BUG_ON(!__builtin_constant_p(_precision));	\
-		BUILD_BUG_ON(!__builtin_constant_p(_weight_rcp));	\
-		BUILD_BUG_ON((_precision) > 30);			\
-		BUILD_BUG_ON_NOT_POWER_OF_2(_weight_rcp);		\
-		return e->internal >> (_precision);			\
-	}								\
-	static inline void ewma_##name##_add(struct ewma_##name *e,	\
-					     unsigned long val)		\
-	{								\
-		unsigned long internal = READ_ONCE(e->internal);	\
-		unsigned long weight_rcp = ilog2(_weight_rcp);		\
-		unsigned long precision = _precision;			\
-									\
-		BUILD_BUG_ON(!__builtin_constant_p(_precision));	\
-		BUILD_BUG_ON(!__builtin_constant_p(_weight_rcp));	\
-		BUILD_BUG_ON((_precision) > 30);			\
-		BUILD_BUG_ON_NOT_POWER_OF_2(_weight_rcp);		\
-									\
-		WRITE_ONCE(e->internal, internal ?			\
-			(((internal << weight_rcp) - internal) +	\
-				(val << precision)) >> weight_rcp :	\
-			(val << precision));				\
-	}
-
-#endif /* _NET_BATMAN_ADV_COMPAT_LINUX_AVERAGE_H */

---
base-commit: 4fa5cbac90fa7b8936779b4313debb3d89701c59
change-id: 20261019-compat-ewma-4343f75cf1f7

Best regards,
--  
Sven Eckelmann <sven@narfation.org>

