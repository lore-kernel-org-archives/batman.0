Return-Path: <b.a.t.m.a.n-bounces@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9245BC46467;
	Sat,  7 Jan 2023 14:01:16 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 4492C846F7;
	Sat,  7 Jan 2023 15:01:13 +0100 (CET)
Received: from dvalin.narfation.org (dvalin.narfation.org [IPv6:2a00:17d8:100::8b1])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 2875C80223
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sat,  7 Jan 2023 15:01:09 +0100 (CET)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1673100069;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:dkim-signature;
	bh=Z/5tQ2fRPpGScdOJ0VagmD7VGioDsJqzOHf4VVAV8qo=;
	b=AHI+/YGc236bnncDTHKceKiLdzsqkwIA6yjglFLH3svbszqXMSFDNg6pKjt6eN5T9aQpWB
	sUu5q/VJ4zZppo9GK9+UMlqWoMNMKm4kGpGX1vsxfRD2NH1kaaM9JWxMEQTYSjOgh4o0kn
	6RswKwAuYESDN9KGA3YMEkrYecWYvRE=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=Vlnz8Q8+;
	dmarc=pass (policy=none) header.from=narfation.org;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1673100069; a=rsa-sha256;
	cv=none;
	b=knFfE5anzTgLMbgJpLdMDPSkzz/n9DCqL5AyGUkAr6MwUsXcHuQADvKlQnbdnL/waC/Eyf
	1J4a6/qD8lINxdQTHsglszYCVDbHqpHAtUZ08Qnt5YOjtMUZg6zySUH/RIlUmIohvD1Faf
	ezGOVMwmRr3J0mC2FOMA9s3cuK9VwNU=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1673100068;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Z/5tQ2fRPpGScdOJ0VagmD7VGioDsJqzOHf4VVAV8qo=;
	b=Vlnz8Q8++crjn/dhkPmZHEXsVBMQxmtLp7i9tbM5PTQgHlP879G9zNF9w9/rJ9P7tRyAG2
	G7BAOrP38wHexRAQ2jcY9SJ11PVfsAk/7j5BOqkarhxafbzXHmtd8xpVue4c9Tu6Imcow2
	blb1FmAOzwLhSSHBkPLTG1qBatt/kcA=
From: Sven Eckelmann <sven@narfation.org>
Date: Sat, 07 Jan 2023 15:00:41 +0100
Subject: [PATCH v2] batman-adv: Drop prandom.h includes
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230107-headers-v2-1-012e7ae98a43@narfation.org>
X-B4-Tracking: v=1; b=H4sIAAl7uWMC/y2OwQqDMBBEf0Vy7kqy1sb21P8oPay6mhyMshEpi
 P/etfT4huHN7CazRM7mUexGeIs5zkkBL4XpAqWRIfbKBi1W1lkPgalnyWDr2iN23lfXu9F2S5mh
 FUpdOPsTxXTGi/AQP7+B11t5kHmCNYha/lp0iN42VvVl7W6Ns+Agb5yeiWSgVQ+Vs4zmOL5OThB
 0rQAAAA==
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.11.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3645; i=sven@narfation.org;
 h=from:subject:message-id; bh=DQbbIqIcMgiIRcVHY9wEphidIWumDDRje6L+zBHZjd4=;
 b=owEBbQKS/ZANAwAKAV2HCgfBJntGAcsmYgBjuXsdu+mJPWSzjZD9wYiNgqpLI2o++AyEo2LfOjuP
 Q0SvpZKJAjMEAAEKAB0WIQQXXSuHYSVz3OMy4AJdhwoHwSZ7RgUCY7l7HQAKCRBdhwoHwSZ7RvQOEA
 DKWKkEed+On8/98yzhwe7djBPc3mz7KiZ/DqtfatK+ApG8+5L8WRoENzOhaE+WzZ+A7GJmIbtrdeF8
 XDmzW3puxjIziPcsYCabTUTWrPNdR4lHvQIkHZsZgILY70fYeh/sJtwFO4TrbwydYVqTt5dhknvKxl
 GbY6GlIwviPIjhmVBWKMGYMTN2/e1BgVQsRz3PJNiI9cu5dwOjf97G7ZPJhAylWuBbq1E8c3auiLlz
 isCdJ/VCjMwRlYWD34O+l3iuIneJ6kqDmaUkZaqGZ4ePGMRMyo+8HSeRTygBY7bMh6Q/u4A+3EGTC4
 hA/IOL0D6/quGY1eG0Uh642cQh6zLKGfxaQN9hiCzNFH6KmNcEWGIVmO5JJqlLF0W488zQ5YDaQcng
 QLkKSinMT2LzNCoDWSHDdT6qGWEMiUqk2wBpYe/Jd2k9IPiRWbpoaHo9hdzlDC+AWw32vVo46oUfYY
 6boHH8OJZyJ9j2Oq3pTaxCbX+Trsrwqq87Ctz1Izk33mGCw3H1vRcNdrTARk25p+WY0Zth39AHmTeZ
 QmV74WOL0GLYPmZt8Aw8IunbjLqMElNke+owxhxvqGOrDy/OkywBLTCUl2FeoRvDR9jQFjBHqfjCpt
 +XUcQu1rd5CzMWjOJNxCiUqgnESuFjxxKOYXq8PQ5F8ZSyzFK3OfFy3FPkMw==
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: 5PAIYATJJJ4OVDNWCSX3KNJDG6NCYJ7H
X-Message-ID-Hash: 5PAIYATJJJ4OVDNWCSX3KNJDG6NCYJ7H
X-MailFrom: sven@narfation.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-b.a.t.m.a.n.lists.open-mesh.org-0; header-match-b.a.t.m.a.n.lists.open-mesh.org-1; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
X-Mailman-Version: 3.2.1
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/5PAIYATJJJ4OVDNWCSX3KNJDG6NCYJ7H/>
List-Archive: <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

The commit a15d3f3c1c2a ("batman-adv: use get_random_u32_below() instead of
deprecated function") replaced the prandom.h function prandom_u32_max with
the random.h function get_random_u32_below. There is no need to still
include prandom.h.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
v2:
- Fix conflicts with the Linux < 4.14 compat code removal
- directly integrate "batman-adv: Include random.h for get_random_u32_below"
  into the first patch
---
 compat-include/linux/prandom.h  | 24 ------------------------
 net/batman-adv/bat_iv_ogm.c     |  1 -
 net/batman-adv/bat_v_elp.c      |  1 -
 net/batman-adv/bat_v_ogm.c      |  1 -
 net/batman-adv/network-coding.c |  2 +-
 5 files changed, 1 insertion(+), 28 deletions(-)

diff --git a/compat-include/linux/prandom.h b/compat-include/linux/prandom.h
deleted file mode 100644
index ec2f5244..00000000
--- a/compat-include/linux/prandom.h
+++ /dev/null
@@ -1,24 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/* Copyright (C) B.A.T.M.A.N. contributors:
- *
- * Marek Lindner, Simon Wunderlich
- *
- * This file contains macros for maintaining compatibility with older versions
- * of the Linux kernel.
- */
-
-#ifndef _NET_BATMAN_ADV_COMPAT_LINUX_PRANDOM_H_
-#define _NET_BATMAN_ADV_COMPAT_LINUX_PRANDOM_H_
-
-#include <linux/version.h>
-#if LINUX_VERSION_IS_GEQ(5, 8, 1) || \
-    (LINUX_VERSION_IS_GEQ(4, 14, 193) && LINUX_VERSION_IS_LESS(4, 15, 0)) || \
-    (LINUX_VERSION_IS_GEQ(4, 19, 138) && LINUX_VERSION_IS_LESS(4, 20, 0)) || \
-    (LINUX_VERSION_IS_GEQ(5, 4, 57) && LINUX_VERSION_IS_LESS(5, 5, 0)) || \
-    (LINUX_VERSION_IS_GEQ(5, 7, 14) && LINUX_VERSION_IS_LESS(5, 8, 0))
-#include_next <linux/prandom.h>
-#else
-#include <linux/random.h>
-#endif
-
-#endif /* _NET_BATMAN_ADV_COMPAT_LINUX_PRANDOM_H_ */
diff --git a/net/batman-adv/bat_iv_ogm.c b/net/batman-adv/bat_iv_ogm.c
index 114ee5da..828fb393 100644
--- a/net/batman-adv/bat_iv_ogm.c
+++ b/net/batman-adv/bat_iv_ogm.c
@@ -27,7 +27,6 @@
 #include <linux/netdevice.h>
 #include <linux/netlink.h>
 #include <linux/pkt_sched.h>
-#include <linux/prandom.h>
 #include <linux/printk.h>
 #include <linux/random.h>
 #include <linux/rculist.h>
diff --git a/net/batman-adv/bat_v_elp.c b/net/batman-adv/bat_v_elp.c
index f9a58fb5..acff5658 100644
--- a/net/batman-adv/bat_v_elp.c
+++ b/net/batman-adv/bat_v_elp.c
@@ -21,7 +21,6 @@
 #include <linux/minmax.h>
 #include <linux/netdevice.h>
 #include <linux/nl80211.h>
-#include <linux/prandom.h>
 #include <linux/random.h>
 #include <linux/rculist.h>
 #include <linux/rcupdate.h>
diff --git a/net/batman-adv/bat_v_ogm.c b/net/batman-adv/bat_v_ogm.c
index addfd8c4..96e02736 100644
--- a/net/batman-adv/bat_v_ogm.c
+++ b/net/batman-adv/bat_v_ogm.c
@@ -21,7 +21,6 @@
 #include <linux/minmax.h>
 #include <linux/mutex.h>
 #include <linux/netdevice.h>
-#include <linux/prandom.h>
 #include <linux/random.h>
 #include <linux/rculist.h>
 #include <linux/rcupdate.h>
diff --git a/net/batman-adv/network-coding.c b/net/batman-adv/network-coding.c
index bf29fba4..ecd871ab 100644
--- a/net/batman-adv/network-coding.c
+++ b/net/batman-adv/network-coding.c
@@ -25,8 +25,8 @@
 #include <linux/lockdep.h>
 #include <linux/net.h>
 #include <linux/netdevice.h>
-#include <linux/prandom.h>
 #include <linux/printk.h>
+#include <linux/random.h>
 #include <linux/rculist.h>
 #include <linux/rcupdate.h>
 #include <linux/skbuff.h>

---
base-commit: d364e8168b28b345f39c3f77526a2d71a28c282e
change-id: 20230107-headers-055722c77349

Best regards,
-- 
Sven Eckelmann <sven@narfation.org>
