Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA37DC54EAA
	for <batman-adv@archiver.kernel.org>; Fri, 27 Jan 2023 10:23:05 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 4B6DE8234B
	for <batman-adv@archiver.kernel.org>; Fri, 27 Jan 2023 11:23:04 +0100 (CET)
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 1BD56805AC
	for <b.a.t.m.a.n@lists.open-mesh.org>; Fri, 27 Jan 2023 11:21:37 +0100 (CET)
ARC-Seal: i=2; s=20121; d=open-mesh.org; t=1674814897; a=rsa-sha256;
	cv=pass;
	b=niN4lDFJEW/420GfsKFvFStthYKUgQMsWqYRu+ECd5nAFZGMzL8jUBgz0dLIu8ndq99nzk
	VxWiX1putlSC+HJjibFrEnXrDmi6gdTPe10EptHFLazJSf9oy+0Ja1sC0o2SqO7KQKqBTO
	GBnbSRIBdPa65gR+FpLnnaODiIEwmls=
ARC-Authentication-Results: i=2;
	diktynna.open-mesh.org;
	dkim=pass header.d=simonwunderlich.de header.s=09092022 header.b=d7l9CdOm;
	spf=pass (diktynna.open-mesh.org: domain of sw@simonwunderlich.de designates 23.88.38.48 as permitted sender) smtp.mailfrom=sw@simonwunderlich.de;
	arc=pass ("simonwunderlich.de:s=09092022:i=1");
	dmarc=pass (policy=none) header.from=simonwunderlich.de
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1674814897;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=FX+vfV96bXVuybOGcedVod4Mm8JbtdN6dmvlO3snp1g=;
	b=RC965VmXpd43ycZyTWE6atdO4OyGTaShBsgTzZ9knTZ52gVseq7kn6HpOXL0Tb2MfNM1BR
	sCKRSBZOw9s/0XY128DLmvV03GRtvq5P80zmerJKLpk6FA6YnliN0/SsK0CoP50KfIJZ0R
	WBFZirVDUavhupnA2knkZcNhEdeNBQw=
Received: from kero.packetmixer.de (p200300C5973eaED8832e80845eB11F67.dip0.t-ipconnect.de [IPv6:2003:c5:973e:aed8:832e:8084:5eb1:1f67])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.simonwunderlich.de (Postfix) with ESMTPSA id ABDB1FAFDC;
	Fri, 27 Jan 2023 11:21:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1674814896; h=from:from:sender:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FX+vfV96bXVuybOGcedVod4Mm8JbtdN6dmvlO3snp1g=;
	b=d7l9CdOmuD+BsVHk+VCmiOOzD/ANfilIjOWKY+qJXAf+kb0wP8ZVcrtGvOVbTP80Tc+3f6
	Vegk9v/ohsWvEa2Ig7X7mhBMHmfzme7u9GY5+cqxI75y98Qk5RqSD+L4j1Ol0kp+6rXnzl
	Vcny8kJLFy7kOFMQFOrZdv03PpL+S8x9LvNddKDAHaM/GRfJMAHm3WfemrlbqHCVKrP4ZY
	cZ5GMpgoI/ILt2DIdqF2deFnt2fdmfUhoX3q0vPsNqwg9Qu6adWZEFziqCzEdGvQbVNM7w
	0brm5vAtkUH/LhVrAJKV6Fa8jh/l7EvbIsn5UsugODW5LR2/zrGzHgnwdDDrJA==
From: Simon Wunderlich <sw@simonwunderlich.de>
To: kuba@kernel.org,
	davem@davemloft.net
Subject: [PATCH 2/5] batman-adv: Drop prandom.h includes
Date: Fri, 27 Jan 2023 11:21:30 +0100
Message-Id: <20230127102133.700173-3-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230127102133.700173-1-sw@simonwunderlich.de>
References: <20230127102133.700173-1-sw@simonwunderlich.de>
MIME-Version: 1.0
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
	d=simonwunderlich.de; s=09092022; t=1674814896;
	h=from:from:sender:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FX+vfV96bXVuybOGcedVod4Mm8JbtdN6dmvlO3snp1g=;
	b=gpov7GB8prCZz1Q88YwdD1poXemsEF7sMBV1lIVlscFUB+K2AAQMwwKNgwJ5XfWE6onus2
	m7OJ25ePwJwHFz6yFReul7FdmsDg5Rh+bu9h79WlHg0TC+z1BNVuOpgleH1Hh3GibaFfBZ
	DLEj8n7Ms30Kw/qJQhZDeVYqSGJw0fQ+RgbGnNz6/h+0htvJNY+4cRKcEx5+0pMgiq0jB3
	LubnS4P+N3iH3MkRLPOH9GC6Dg6EBnKqIwK6f9uqVjMEuZeJGYHHDA2IVAhvMbUfNKDh3+
	2KGdSlGsj69C751kSOrVVRPPwkiAa1t2xEv2KIQE4mSBOVIHptTagLEMzjSFhg==
ARC-Seal: i=1; s=09092022; d=simonwunderlich.de; t=1674814896; a=rsa-sha256;
	cv=none;
	b=DZ1ybybrAil1GO3mEX4X3gj/DrjqAnz93zxZUBKsdvoO0UOIM53vSk5ks9w8kgmgNevw55H/oq2ILTSXIstGlvbr5p9Mm0+EaRPiNTV3EZnKZgStZtM2uVlF2aI6f2cwQ6t5G3zfVUF2zQrYnsAmxFvxIjRSTgIJTeLLB4YnSZjtmu2jgY5pU/eXfc2+GdU1qmPlBBKBPvgNeVDKWUUqyxUaeIXhjcCqDac7OswgQI5fhYvQRdNgLo900TlI4tF95T5Fx5nOmas9PQBR8LHPQM8XS0/NDHQsDECy7QGB+oHnLHBsGEL6FzMpd466JPu/HBOnsakz/TbU19qQMBzghg==
ARC-Authentication-Results: i=1;
	mail.simonwunderlich.de;
	auth=pass smtp.auth=sw@simonwunderlich.de smtp.mailfrom=sw@simonwunderlich.de
Content-Transfer-Encoding: quoted-printable
Message-ID-Hash: SU32BI5IFFBL7EXF3YONYX3HRYPQSPS6
X-Message-ID-Hash: SU32BI5IFFBL7EXF3YONYX3HRYPQSPS6
X-MailFrom: sw@simonwunderlich.de
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-b.a.t.m.a.n.lists.open-mesh.org-0; header-match-b.a.t.m.a.n.lists.open-mesh.org-1; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org
X-Mailman-Version: 3.2.1
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/SU32BI5IFFBL7EXF3YONYX3HRYPQSPS6/>
List-Archive: <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

From: Sven Eckelmann <sven@narfation.org>

The commit 8032bf1233a7 ("treewide: use get_random_u32_below() instead of
deprecated function") replaced the prandom.h function prandom_u32_max wit=
h
the random.h function get_random_u32_below. There is no need to still
include prandom.h.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/bat_iv_ogm.c     | 1 -
 net/batman-adv/bat_v_elp.c      | 1 -
 net/batman-adv/bat_v_ogm.c      | 1 -
 net/batman-adv/network-coding.c | 2 +-
 4 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/net/batman-adv/bat_iv_ogm.c b/net/batman-adv/bat_iv_ogm.c
index 114ee5da261f..828fb393ee94 100644
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
index f9a58fb5442e..acff565849ae 100644
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
index addfd8c4fe95..96e027364ddd 100644
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
diff --git a/net/batman-adv/network-coding.c b/net/batman-adv/network-cod=
ing.c
index bf29fba4dde5..ecd871abda34 100644
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
--=20
2.30.2
