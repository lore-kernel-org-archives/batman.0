Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E609E7718B
	for <batman@archiver.kernel.org>; Fri, 27 Dec 2024 17:59:03 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 6211983FDD
	for <batman@archiver.kernel.org>; Fri, 27 Dec 2024 18:59:01 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1735322341;
 b=F1PCVqoC7LYffI+4RY5prYq7gGdORENgL+01nYOL5z5wVajZoalX2nvPDEnvF3olI40Dw
 8oxCBHZoNmD1QLQG9Xvj4QL0cCrFl6q9aUDbYynfjWFNoWbhTSwrz02GkvxNy0RROS59XlO
 PLazhfiBtmMrJkDDoCirCwgZd27DdDs=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1735322341; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=JkLpNjUhvBznnNF3Su+0Lz+vaaTF+N/ChXXfiM8FcmY=;
 b=xRAWYABMKoDSMBEf2r7m0o3iYPrFX0WPwtsI+AaLfqFaZOoilC56LJ1lCSVbJTx3h1V9w
 98WjdKiFXEAVdtB8nMpRedlPNt1PguQGh0un2dlDN88FmXl8n6RwRknx5pHMRFu1nAIFVuq
 CG7puQWJxl3U57767a866fzyO0t2ud0=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=mailbox.org;
  arc=pass;
  dmarc=pass (Used From Domain Record) header.from=mailbox.org
 policy.dmarc=reject
Authentication-Results: open-mesh.org; dkim=pass header.d=mailbox.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=mailbox.org policy.dmarc=reject
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id B29AC818B2
	for <b.a.t.m.a.n@lists.open-mesh.org>; Fri, 27 Dec 2024 10:31:30 +0100 (CET)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1735291890;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:dkim-signature;
	bh=JkLpNjUhvBznnNF3Su+0Lz+vaaTF+N/ChXXfiM8FcmY=;
	b=O3ABYY5ObSoM9kVA5bGux6Q0s1h85jPHUfA+hm9xKizR+OhlqJ0CDp6TvLkGp8aNes+rV0
	RyWcY2CsvcsUDkQ2RMYAlKoAvsh+mcU/qd2Ke1uRKgpdir4qQa12wtAlGcjeqVH6fP/hWy
	eycbyFBvspnt9Vx/FK6fUC9w1+xdPoI=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=vZ2KKl+S;
	dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=NosNz1Wm;
	dmarc=pass (policy=reject) header.from=mailbox.org;
	spf=pass (diktynna.open-mesh.org: domain of marek.lindner@mailbox.org
 designates 80.241.56.151 as permitted sender)
 smtp.mailfrom=marek.lindner@mailbox.org
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1735291890; a=rsa-sha256;
	cv=none;
	b=fUcmSUbze9ikk3t/yxMfemfE5CyJ3obMstz4gsmveOYVoq0Hf7NdxKzXHfrcWDHeKqAiLf
	IbDRURulubr3R/AMALJ7L7jt1DrjhH9gsbbFbKsgAszfA5eRmSk0zNf7sGC+qRrHhMX9gg
	nbYVjZaYEWyYj1Pqq11MNNLWnDjQRoc=
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4YKKxs63lbz9sTH
	for <b.a.t.m.a.n@lists.open-mesh.org>; Fri, 27 Dec 2024 10:31:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812;
	t=1735291889;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=JkLpNjUhvBznnNF3Su+0Lz+vaaTF+N/ChXXfiM8FcmY=;
	b=vZ2KKl+SaPsjUSf+KIoCKia08nJSGfpFsFApTeJQGfODZhwDWGxRQFWZm61zj6nUeP9lNG
	jEsBDAVnxNWthuhfjmgMZca2fvKkVtz3Aw0idRhTZNKHlY4AdsWdZgiw+J1ydNmX+s3ZNt
	HI9aVCvmTmW+XK7WqE0TXv2mxUX4hp19l4gY6F/UIdTWVkFKiGAYLT3GTrXTvfvkvEe35Y
	WnUkBJAdxtV4bfejwSAcFDEBkLExbQY7uZM5Pwj3cysh0ep86o7exJNhJPZOZJskBZUBJh
	JUt66vQkkFUY+OcH0aWPbdahFUyng/fn8lN3b1gkO9EVJs43hpkYgdz8c+hbZA==
From: Marek Lindner <marek.lindner@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812;
	t=1735291888;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=JkLpNjUhvBznnNF3Su+0Lz+vaaTF+N/ChXXfiM8FcmY=;
	b=NosNz1WmHtP/1Sn8wDwAkTwqLHrNo5TC7EX4GCBwGkFiHs7QrT/afvHSmlr71wYqGblgHl
	E78juI/ND0hVeQPoXxGWjhgeqfaimmU/dOds2XCK8YoP1vc/sjnijHECscdvx2PxHjlEV6
	h4MWiUU6+7O726ap6nzdpyp6N0pzJNKP2s7bzQFX+yDikWS5c0YOxNhSqzvW9d6Rc6jpOr
	ereRwSuKBqNDnPf3MyE3BuQSSQTqe7wKNw+Rs6YRuFuwi/RiJiaEoWAN5VgwteFVKnaTtA
	R5TFibAX4EeHM8foq4HAgkdEdqk3pvvuraL55n5eNPVN/6qJfQvHiUBve5/Y8A==
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Marek Lindner <marek.lindner@mailbox.org>
Subject: [PATCH] batctl: update email address of Marek Lindner
Date: Fri, 27 Dec 2024 10:31:17 +0100
Message-ID: <20241227093118.2529742-1-marek.lindner@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: 9pwccqutu433ibc8txtpskgnr9ebqazx
X-MBO-RS-ID: 9c0e67aeeb47133f875
X-MailFrom: marek.lindner@mailbox.org
X-Mailman-Rule-Hits: member-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address
Message-ID-Hash: UPUS56UYMCXCX5QAO2R5K7466QOZVXJ6
X-Message-ID-Hash: UPUS56UYMCXCX5QAO2R5K7466QOZVXJ6
X-Mailman-Approved-At: Fri, 27 Dec 2024 18:58:07 +0100
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/UPUS56UYMCXCX5QAO2R5K7466QOZVXJ6/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

---
 aggregation.c          | 2 +-
 bat-hosts.c            | 2 +-
 bat-hosts.h            | 2 +-
 batadv_packet_compat.h | 2 +-
 bisect_iv.c            | 2 +-
 bisect_iv.h            | 2 +-
 bonding.c              | 2 +-
 dat_cache.c            | 2 +-
 debug.c                | 2 +-
 debug.h                | 2 +-
 elp_interval.c         | 2 +-
 fragmentation.c        | 2 +-
 functions.c            | 2 +-
 functions.h            | 2 +-
 genl.h                 | 2 +-
 gw_mode.c              | 2 +-
 hop_penalty.c          | 2 +-
 icmp_helper.c          | 2 +-
 icmp_helper.h          | 2 +-
 interface.c            | 2 +-
 loglevel.c             | 2 +-
 main.c                 | 2 +-
 main.h                 | 2 +-
 man/batctl.8           | 4 ++--
 mcast_flags.c          | 2 +-
 netlink.c              | 2 +-
 netlink.h              | 2 +-
 orig_interval.c        | 2 +-
 ping.c                 | 2 +-
 routing_algo.c         | 2 +-
 statistics.c           | 2 +-
 sys.c                  | 2 +-
 sys.h                  | 2 +-
 tcpdump.h              | 2 +-
 throughput_override.c  | 2 +-
 traceroute.c           | 2 +-
 translate.c            | 2 +-
 37 files changed, 38 insertions(+), 38 deletions(-)

diff --git a/aggregation.c b/aggregation.c
index 47802ed..245b0d3 100644
--- a/aggregation.c
+++ b/aggregation.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright (C) B.A.T.M.A.N. contributors:
  *
- * Marek Lindner <mareklindner@neomailbox.ch>
+ * Marek Lindner <marek.lindner@mailbox.org>
  *
  * License-Filename: LICENSES/preferred/GPL-2.0
  */
diff --git a/bat-hosts.c b/bat-hosts.c
index 7a3d712..57e7d69 100644
--- a/bat-hosts.c
+++ b/bat-hosts.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright (C) B.A.T.M.A.N. contributors:
  *
- * Andreas Langer <an.langer@gmx.de>, Marek Lindner <mareklindner@neomailbox.ch>
+ * Andreas Langer <an.langer@gmx.de>, Marek Lindner <marek.lindner@mailbox.org>
  *
  * License-Filename: LICENSES/preferred/GPL-2.0
  */
diff --git a/bat-hosts.h b/bat-hosts.h
index 3cfec66..660b184 100644
--- a/bat-hosts.h
+++ b/bat-hosts.h
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 /* Copyright (C) B.A.T.M.A.N. contributors:
  *
- * Marek Lindner <mareklindner@neomailbox.ch>
+ * Marek Lindner <marek.lindner@mailbox.org>
  *
  * License-Filename: LICENSES/preferred/GPL-2.0
  */
diff --git a/batadv_packet_compat.h b/batadv_packet_compat.h
index ee99fb0..58b9c01 100644
--- a/batadv_packet_compat.h
+++ b/batadv_packet_compat.h
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 /* Copyright (C) B.A.T.M.A.N. contributors:
  *
- * Andreas Langer <an.langer@gmx.de>, Marek Lindner <mareklindner@neomailbox.ch>
+ * Andreas Langer <an.langer@gmx.de>, Marek Lindner <marek.lindner@mailbox.org>
  *
  * License-Filename: LICENSES/preferred/GPL-2.0
  */
diff --git a/bisect_iv.c b/bisect_iv.c
index d2dd8cf..1cb11b8 100644
--- a/bisect_iv.c
+++ b/bisect_iv.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright (C) B.A.T.M.A.N. contributors:
  *
- * Marek Lindner <mareklindner@neomailbox.ch>
+ * Marek Lindner <marek.lindner@mailbox.org>
  *
  * License-Filename: LICENSES/preferred/GPL-2.0
  */
diff --git a/bisect_iv.h b/bisect_iv.h
index 40424ea..ea39177 100644
--- a/bisect_iv.h
+++ b/bisect_iv.h
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 /* Copyright (C) B.A.T.M.A.N. contributors:
  *
- * Marek Lindner <mareklindner@neomailbox.ch>
+ * Marek Lindner <marek.lindner@mailbox.org>
  *
  * License-Filename: LICENSES/preferred/GPL-2.0
  */
diff --git a/bonding.c b/bonding.c
index 5407d28..947f22b 100644
--- a/bonding.c
+++ b/bonding.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright (C) B.A.T.M.A.N. contributors:
  *
- * Marek Lindner <mareklindner@neomailbox.ch>
+ * Marek Lindner <marek.lindner@mailbox.org>
  *
  * License-Filename: LICENSES/preferred/GPL-2.0
  */
diff --git a/dat_cache.c b/dat_cache.c
index b666a43..4c72360 100644
--- a/dat_cache.c
+++ b/dat_cache.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright (C) B.A.T.M.A.N. contributors:
  *
- * Marek Lindner <mareklindner@neomailbox.ch>
+ * Marek Lindner <marek.lindner@mailbox.org>
  *
  * License-Filename: LICENSES/preferred/GPL-2.0
  */
diff --git a/debug.c b/debug.c
index 5629e1f..b715885 100644
--- a/debug.c
+++ b/debug.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright (C) B.A.T.M.A.N. contributors:
  *
- * Marek Lindner <mareklindner@neomailbox.ch>
+ * Marek Lindner <marek.lindner@mailbox.org>
  *
  * License-Filename: LICENSES/preferred/GPL-2.0
  */
diff --git a/debug.h b/debug.h
index ac208fe..1e97a5a 100644
--- a/debug.h
+++ b/debug.h
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 /* Copyright (C) B.A.T.M.A.N. contributors:
  *
- * Marek Lindner <mareklindner@neomailbox.ch>
+ * Marek Lindner <marek.lindner@mailbox.org>
  *
  * License-Filename: LICENSES/preferred/GPL-2.0
  */
diff --git a/elp_interval.c b/elp_interval.c
index a951528..b294eaf 100644
--- a/elp_interval.c
+++ b/elp_interval.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright (C) B.A.T.M.A.N. contributors:
  *
- * Marek Lindner <mareklindner@neomailbox.ch>
+ * Marek Lindner <marek.lindner@mailbox.org>
  *
  * License-Filename: LICENSES/preferred/GPL-2.0
  */
diff --git a/fragmentation.c b/fragmentation.c
index 974345a..2f3d3b9 100644
--- a/fragmentation.c
+++ b/fragmentation.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright (C) B.A.T.M.A.N. contributors:
  *
- * Marek Lindner <mareklindner@neomailbox.ch>
+ * Marek Lindner <marek.lindner@mailbox.org>
  *
  * License-Filename: LICENSES/preferred/GPL-2.0
  */
diff --git a/functions.c b/functions.c
index bf6057c..f7a3080 100644
--- a/functions.c
+++ b/functions.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright (C) B.A.T.M.A.N. contributors:
  *
- * Andreas Langer <an.langer@gmx.de>, Marek Lindner <mareklindner@neomailbox.ch>
+ * Andreas Langer <an.langer@gmx.de>, Marek Lindner <marek.lindner@mailbox.org>
  *
  * License-Filename: LICENSES/preferred/GPL-2.0
  */
diff --git a/functions.h b/functions.h
index b85bbf1..33b57da 100644
--- a/functions.h
+++ b/functions.h
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 /* Copyright (C) B.A.T.M.A.N. contributors:
  *
- * Andreas Langer <an.langer@gmx.de>, Marek Lindner <mareklindner@neomailbox.ch>
+ * Andreas Langer <an.langer@gmx.de>, Marek Lindner <marek.lindner@mailbox.org>
  *
  * License-Filename: LICENSES/preferred/GPL-2.0
  */
diff --git a/genl.h b/genl.h
index cab6ad3..7177ce9 100644
--- a/genl.h
+++ b/genl.h
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 /* Copyright (C) B.A.T.M.A.N. contributors:
  *
- * Marek Lindner <mareklindner@neomailbox.ch>
+ * Marek Lindner <marek.lindner@mailbox.org>
  *
  * License-Filename: LICENSES/preferred/GPL-2.0
  */
diff --git a/gw_mode.c b/gw_mode.c
index 1b102a3..996ca08 100644
--- a/gw_mode.c
+++ b/gw_mode.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright (C) B.A.T.M.A.N. contributors:
  *
- * Marek Lindner <mareklindner@neomailbox.ch>
+ * Marek Lindner <marek.lindner@mailbox.org>
  *
  * License-Filename: LICENSES/preferred/GPL-2.0
  */
diff --git a/hop_penalty.c b/hop_penalty.c
index e43595b..11f30ae 100644
--- a/hop_penalty.c
+++ b/hop_penalty.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright (C) B.A.T.M.A.N. contributors:
  *
- * Marek Lindner <mareklindner@neomailbox.ch>
+ * Marek Lindner <marek.lindner@mailbox.org>
  *
  * License-Filename: LICENSES/preferred/GPL-2.0
  */
diff --git a/icmp_helper.c b/icmp_helper.c
index a523f23..459ea63 100644
--- a/icmp_helper.c
+++ b/icmp_helper.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright (C) B.A.T.M.A.N. contributors:
  *
- * Marek Lindner <mareklindner@neomailbox.ch>, Simon Wunderlich
+ * Marek Lindner <marek.lindner@mailbox.org>, Simon Wunderlich
  *
  * License-Filename: LICENSES/preferred/GPL-2.0
  */
diff --git a/icmp_helper.h b/icmp_helper.h
index d117993..f8dbaa9 100644
--- a/icmp_helper.h
+++ b/icmp_helper.h
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 /* Copyright (C) B.A.T.M.A.N. contributors:
  *
- * Andreas Langer <an.langer@gmx.de>, Marek Lindner <mareklindner@neomailbox.ch>
+ * Andreas Langer <an.langer@gmx.de>, Marek Lindner <marek.lindner@mailbox.org>
  *
  * License-Filename: LICENSES/preferred/GPL-2.0
  */
diff --git a/interface.c b/interface.c
index 6f70468..dfe5ad4 100644
--- a/interface.c
+++ b/interface.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright (C) B.A.T.M.A.N. contributors:
  *
- * Marek Lindner <mareklindner@neomailbox.ch>
+ * Marek Lindner <marek.lindner@mailbox.org>
  *
  * License-Filename: LICENSES/preferred/GPL-2.0
  */
diff --git a/loglevel.c b/loglevel.c
index ab6f033..a26559a 100644
--- a/loglevel.c
+++ b/loglevel.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright (C) B.A.T.M.A.N. contributors:
  *
- * Marek Lindner <mareklindner@neomailbox.ch>
+ * Marek Lindner <marek.lindner@mailbox.org>
  *
  * License-Filename: LICENSES/preferred/GPL-2.0
  */
diff --git a/main.c b/main.c
index 45038d3..9516dee 100644
--- a/main.c
+++ b/main.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright (C) B.A.T.M.A.N. contributors:
  *
- * Andreas Langer <an.langer@gmx.de>, Marek Lindner <mareklindner@neomailbox.ch>
+ * Andreas Langer <an.langer@gmx.de>, Marek Lindner <marek.lindner@mailbox.org>
  *
  * License-Filename: LICENSES/preferred/GPL-2.0
  */
diff --git a/main.h b/main.h
index 555af07..646ef5d 100644
--- a/main.h
+++ b/main.h
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 /* Copyright (C) B.A.T.M.A.N. contributors:
  *
- * Andreas Langer <an.langer@gmx.de>, Marek Lindner <mareklindner@neomailbox.ch>
+ * Andreas Langer <an.langer@gmx.de>, Marek Lindner <marek.lindner@mailbox.org>
  *
  * License-Filename: LICENSES/preferred/GPL-2.0
  */
diff --git a/man/batctl.8 b/man/batctl.8
index b5be0b8..f7522b4 100644
--- a/man/batctl.8
+++ b/man/batctl.8
@@ -515,7 +515,7 @@ addresses.
 .BR traceroute (1),
 .BR trace-cmd (1)
 .SH AUTHOR
-batctl was written by Andreas Langer <an.langer@gmx.de> and Marek Lindner <mareklindner@neomailbox.ch>.
+batctl was written by Andreas Langer <an.langer@gmx.de> and Marek Lindner <marek.lindner@mailbox.org>.
 .PP
-This manual page was written by Simon Wunderlich <sw@simonwunderlich.de>, Marek Lindner <mareklindner@neomailbox.ch> and
+This manual page was written by Simon Wunderlich <sw@simonwunderlich.de>, Marek Lindner <marek.lindner@mailbox.org> and
 Andrew Lunn <andrew@lunn.ch>
diff --git a/mcast_flags.c b/mcast_flags.c
index 9535981..9dcb90c 100644
--- a/mcast_flags.c
+++ b/mcast_flags.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright (C) B.A.T.M.A.N. contributors:
  *
- * Marek Lindner <mareklindner@neomailbox.ch>
+ * Marek Lindner <marek.lindner@mailbox.org>
  *
  * License-Filename: LICENSES/preferred/GPL-2.0
  */
diff --git a/netlink.c b/netlink.c
index a41548d..31aec5e 100644
--- a/netlink.c
+++ b/netlink.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright (C) B.A.T.M.A.N. contributors:
  *
- * Marek Lindner <mareklindner@neomailbox.ch>, Andrew Lunn <andrew@lunn.ch>
+ * Marek Lindner <marek.lindner@mailbox.org>, Andrew Lunn <andrew@lunn.ch>
  *
  * License-Filename: LICENSES/preferred/GPL-2.0
  */
diff --git a/netlink.h b/netlink.h
index 237f760..03da947 100644
--- a/netlink.h
+++ b/netlink.h
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 /* Copyright (C) B.A.T.M.A.N. contributors:
  *
- * Marek Lindner <mareklindner@neomailbox.ch>, Andrew Lunn <andrew@lunn.ch>
+ * Marek Lindner <marek.lindner@mailbox.org>, Andrew Lunn <andrew@lunn.ch>
  *
  * License-Filename: LICENSES/preferred/GPL-2.0
  */
diff --git a/orig_interval.c b/orig_interval.c
index 0201b15..4e13016 100644
--- a/orig_interval.c
+++ b/orig_interval.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright (C) B.A.T.M.A.N. contributors:
  *
- * Marek Lindner <mareklindner@neomailbox.ch>
+ * Marek Lindner <marek.lindner@mailbox.org>
  *
  * License-Filename: LICENSES/preferred/GPL-2.0
  */
diff --git a/ping.c b/ping.c
index f2f6c41..14d9c21 100644
--- a/ping.c
+++ b/ping.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright (C) B.A.T.M.A.N. contributors:
  *
- * Andreas Langer <an.langer@gmx.de>, Marek Lindner <mareklindner@neomailbox.ch>
+ * Andreas Langer <an.langer@gmx.de>, Marek Lindner <marek.lindner@mailbox.org>
  *
  * License-Filename: LICENSES/preferred/GPL-2.0
  */
diff --git a/routing_algo.c b/routing_algo.c
index 8d1b63e..5aa4597 100644
--- a/routing_algo.c
+++ b/routing_algo.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright (C) B.A.T.M.A.N. contributors:
  *
- * Marek Lindner <mareklindner@neomailbox.ch>
+ * Marek Lindner <marek.lindner@mailbox.org>
  *
  * License-Filename: LICENSES/preferred/GPL-2.0
  */
diff --git a/statistics.c b/statistics.c
index 134a8cd..9506308 100644
--- a/statistics.c
+++ b/statistics.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright (C) B.A.T.M.A.N. contributors:
  *
- * Marek Lindner <mareklindner@neomailbox.ch>
+ * Marek Lindner <marek.lindner@mailbox.org>
  *
  * License-Filename: LICENSES/preferred/GPL-2.0
  */
diff --git a/sys.c b/sys.c
index dcef51f..0b38677 100644
--- a/sys.c
+++ b/sys.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright (C) B.A.T.M.A.N. contributors:
  *
- * Marek Lindner <mareklindner@neomailbox.ch>
+ * Marek Lindner <marek.lindner@mailbox.org>
  *
  * License-Filename: LICENSES/preferred/GPL-2.0
  */
diff --git a/sys.h b/sys.h
index 1f27347..493f41f 100644
--- a/sys.h
+++ b/sys.h
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 /* Copyright (C) B.A.T.M.A.N. contributors:
  *
- * Marek Lindner <mareklindner@neomailbox.ch>
+ * Marek Lindner <marek.lindner@mailbox.org>
  *
  * License-Filename: LICENSES/preferred/GPL-2.0
  */
diff --git a/tcpdump.h b/tcpdump.h
index be64aeb..91f9242 100644
--- a/tcpdump.h
+++ b/tcpdump.h
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 /* Copyright (C) B.A.T.M.A.N. contributors:
  *
- * Andreas Langer <an.langer@gmx.de>, Marek Lindner <mareklindner@neomailbox.ch>
+ * Andreas Langer <an.langer@gmx.de>, Marek Lindner <marek.lindner@mailbox.org>
  *
  * License-Filename: LICENSES/preferred/GPL-2.0
  */
diff --git a/throughput_override.c b/throughput_override.c
index 9767d9e..6c316ff 100644
--- a/throughput_override.c
+++ b/throughput_override.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright (C) B.A.T.M.A.N. contributors:
  *
- * Marek Lindner <mareklindner@neomailbox.ch>
+ * Marek Lindner <marek.lindner@mailbox.org>
  *
  * License-Filename: LICENSES/preferred/GPL-2.0
  */
diff --git a/traceroute.c b/traceroute.c
index 2409c30..a0fb925 100644
--- a/traceroute.c
+++ b/traceroute.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright (C) B.A.T.M.A.N. contributors:
  *
- * Andreas Langer <an.langer@gmx.de>, Marek Lindner <mareklindner@neomailbox.ch>
+ * Andreas Langer <an.langer@gmx.de>, Marek Lindner <marek.lindner@mailbox.org>
  *
  * License-Filename: LICENSES/preferred/GPL-2.0
  */
diff --git a/translate.c b/translate.c
index 0101724..73510ea 100644
--- a/translate.c
+++ b/translate.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright (C) B.A.T.M.A.N. contributors:
  *
- * Andreas Langer <an.langer@gmx.de>, Marek Lindner <mareklindner@neomailbox.ch>
+ * Andreas Langer <an.langer@gmx.de>, Marek Lindner <marek.lindner@mailbox.org>
  *
  * License-Filename: LICENSES/preferred/GPL-2.0
  */
-- 
2.45.2

