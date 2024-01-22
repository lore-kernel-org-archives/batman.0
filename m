Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D222CC4725D
	for <batman@archiver.kernel.org>; Mon, 22 Jan 2024 13:10:45 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 176A083E15
	for <batman@archiver.kernel.org>; Mon, 22 Jan 2024 14:10:44 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1705929044;
 b=h+5XKx0ZuUxVFeagUTwPc9bgK3plauTE6pOf+ZcmcWkXOr1h7+ek3PfvJUZmBkL0ItWTG
 nD7CMf5LkjeYNdKkt41wwJ2zcjVjCksCs/tQOAmtJGaSmVuddFY75ldmunyq93fPG6DV2W0
 bJVUOVRurOLm5V5pWijw41VWa04Zbxs=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1705929044; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=UhcUFcWpTeVaZY48tS8FVFPGz8SFDD98GZVcolKSSDk=;
 b=o078UPtEsxt1hDekBVZpUvqFtkQRQR+Xqxs9foI4TxAZAULgTnpRSI8unoLgoGlwPtP19
 XyIZOCm9Oz4I9SrT83K7Fz6aWjJgDi1aPKHAAKyvrSgkh0bTuZTS5i7+ugF7UE8stfKjO36
 gy2di8Qn7B0+LIryq1bISwjlaEtVrgU=
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
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 497B28087F
	for <b.a.t.m.a.n@lists.open-mesh.org>; Mon, 22 Jan 2024 14:10:38 +0100 (CET)
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1705929038; a=rsa-sha256;
	cv=none;
	b=p3ryc8wsWfhUkdQ+FXs5B79j2Mtwlb9iWrJ37y1PRZvIdxsOCGRofKKdLwzA3kXoA+GU2Y
	sJUQroZ8Wy3HN9213b/DQWAY5FwTADfMAqlA+l5vCxTfxteY7Iw2xB5jIegBi9KoiLV35F
	D/DZb1mpcb253+qvUw70H/yLxliKhHE=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=0rjLSXiL;
	dmarc=pass (policy=none) header.from=narfation.org;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1705929038;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:dkim-signature;
	bh=UhcUFcWpTeVaZY48tS8FVFPGz8SFDD98GZVcolKSSDk=;
	b=WgAYseGOGSCxSi8zr6C22anh5uT6RtgEcLqcLRyO+C5/1TnccwmPa0M+ddBxiyO9OABRvq
	VBo8hklG0KOJ1hqscSURyiQ92v9XS9JbvHTs6SLB/0uKnTgDKK0kjEBPo7GWqUcz+O6xpq
	tmIy603s+EH/uLiDk7SivmVpEAXJeAw=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1705929037;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=UhcUFcWpTeVaZY48tS8FVFPGz8SFDD98GZVcolKSSDk=;
	b=0rjLSXiLgpJHyH97kEkTjsQsK3Pz5uNyLAmb9PGzftLMRoRGNqcwtdO13ST3nS9TzOP0Ki
	kKFgUJgXf//cnGp5R4zYAF0fQeoUvl5t8Nl0CDCSGkRNfccOIcPizzEdtCH1Dwz3olQki+
	UEmgRLCush8BR5rmZKdyfe4d0iR8PHc=
From: Sven Eckelmann <sven@narfation.org>
Date: Mon, 22 Jan 2024 14:10:22 +0100
Subject: [PATCH] batman-adv: Drop usage of export.h
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240122-no-export-header-v1-1-d96a0a3886c7@narfation.org>
X-B4-Tracking: v=1; b=H4sIAD1prmUC/x3MMQqAMAxG4atIZgNtdNGriIO0v5qllVREEO9uc
 fyG9x4qMEWhsXnIcGnRnCp821DYl7SBNVaTOOmdF+GUGfeR7eQdS4Sxk6ED+hCi91Szw7Dq/S+
 n+X0/bCWFuGIAAAA=
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1002; i=sven@narfation.org;
 h=from:subject:message-id; bh=6Q7AEiTTBsm+O71O3VcZ/h2yC0j36RPD4NlJ4EzlTwM=;
 b=owEBbQKS/ZANAwAKAV2HCgfBJntGAcsmYgBlrmlA2oFOfiyR7LTWWL6b+dFI2A2bm5Z0fvln2
 fjUlSXcLDGJAjMEAAEKAB0WIQQXXSuHYSVz3OMy4AJdhwoHwSZ7RgUCZa5pQAAKCRBdhwoHwSZ7
 RuYEEACC3iUvCHQtt2cNmDfNznGQr8TJXOYCMji64fGHOcdVugwwNNJQ/547/BruQk3iZ+CDibi
 ecYVQlVw5R2zmS9560p+PeIOLniMwa62xuf/gJ0NZFwBlwGPd6ztY+u0szahS1kaH44iD5oqBmA
 9v4Z66zvUbi0go9ytEvEa51fUH4UmGWBeDK9VB1dvu//Lo+Au0ukqDrPG28VbAX9pUptkEBMwW5
 zGHygSyDuiey5bIumG8SWnc+hiMO4zZJoawmTVGDL0ABinfwx7yAFHlj96rCMu07jM/BBQN3rTa
 qSmJSTse7AMOuLRuCV8UzrDFm4L9j1d3CdY1us+DjTU61B0668ZUBeGNq2nfpdNagqkQTtY+hWG
 OE4HqD7kctcIRmF6omIqku9ajxX/Bew4OG+UAhksVpdUITYw8l55ku0PBPEYdU56yrd2Q8c2VSU
 1GZAZNX/yzgi8c0hwuMMj+Bb5WU419i+72AVNWXk3SRx3R1LgH0sr9Hd8lvvHiIFSvh18bbcQz1
 0hoDTe95yVtjDdWwS2tTi60VLDw7TKb3xHvNRfXwJ7CpGVX5KOhGLU6zaxCXSG3yc2XOWpunI+S
 pBwIU2RUZUwPdZ353cuGuFEAE9Yl2lYNBXremLNaGLJ5x981sjafe2wMDKCG4Q+T/ZekFvdSZab
 jPYcB6JroPUzjiA==
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: JDH4VCOSXJXQG7V3IN7H6HCVXDKWH3UF
X-Message-ID-Hash: JDH4VCOSXJXQG7V3IN7H6HCVXDKWH3UF
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/JDH4VCOSXJXQG7V3IN7H6HCVXDKWH3UF/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

The linux/export.h include was introduced in commit f6977d91a992
("batman-adv: Introduce missing headers for genetlink restructure") to have
access to THIS_MODULE. But with commit 5b20755b7780 ("init: move
THIS_MODULE from <linux/export.h> to <linux/init.h>"), it was moved and the
include for export.h is no longer needed.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/netlink.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/net/batman-adv/netlink.c b/net/batman-adv/netlink.c
index cda99753..6aff7cc1 100644
--- a/net/batman-adv/netlink.c
+++ b/net/batman-adv/netlink.c
@@ -15,7 +15,6 @@
 #include <linux/cache.h>
 #include <linux/err.h>
 #include <linux/errno.h>
-#include <linux/export.h>
 #include <linux/genetlink.h>
 #include <linux/gfp.h>
 #include <linux/if_ether.h>

---
base-commit: ecdc425a87d40eba44c9c094293d50d3e9a38b45
change-id: 20240122-no-export-header-0293ee4ccd11

Best regards,
-- 
Sven Eckelmann <sven@narfation.org>

