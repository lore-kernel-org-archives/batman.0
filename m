Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7094EC3ABBC
	for <batman-adv@archiver.kernel.org>; Fri,  9 May 2025 09:13:59 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 0246284C2A
	for <batman-adv@archiver.kernel.org>; Fri,  9 May 2025 11:13:58 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1746782038;
 b=YZGYMFBcfiGDUBU7KACy+C6x1KcCl8jiqBqHf9YmFAGDnpr3NRtrviUGcJxPROfDq/paq
 XGvPKVGpGSiclOjfMO72YT2pHnsIjUTL5BS90yTYnrCiANxP57kZ65i1mQ5HtXyfJ6KzbYC
 uZ5Cobyfv2acPv6Q0MMuW3ziGQNmh0A=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1746782038; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=6vDGb2ZX0fNqPSfWM94SrkPfP5oo1uPe0gNGJQbGjuI=;
 b=I240QgSOPCF+8KW9vD85/lPxelX9/iVT277jOiWJyI6oj4XmbUBImFP99iYgH2T4hUGjl
 pGl5afsb+lbEe157km8YmGSeMxIVOqbmxGqHqTjtrzlzim2XLJkgJYW+DeyYboOuqLRBMsh
 YD1uXGG6K/O455wdl7nHXxc7UXGgfUg=
ARC-Authentication-Results: i=2; open-mesh.org; dkim=fail;
  arc=pass;
  dmarc=fail (Used From Domain Record) header.from=simonwunderlich.de
 policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=fail; arc=pass;
 dmarc=fail (Used From Domain Record) header.from=simonwunderlich.de
 policy.dmarc=none
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de
 [IPv6:2a01:4f8:c17:e8c0::1])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 12ABB84750
	for <b.a.t.m.a.n@lists.open-mesh.org>; Fri,  9 May 2025 11:10:46 +0200 (CEST)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1746781846;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6vDGb2ZX0fNqPSfWM94SrkPfP5oo1uPe0gNGJQbGjuI=;
	b=sQ5MtjpQRS++R4thSwX0Nye6YdwgMo3hKRMvPUQ/wZR2xhDfNvzFlwO4oXNoSHHfOR/N8N
	PgEmhFaeaGJU5pDfeEhfNaM48rreMxU/mPEomcs4peeAKpYMvML8hRdSIidZ33wk29oAX6
	D/InI4CWXtIXVOkAKJrJl5Ws6rx51Ho=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=none;
	spf=pass (diktynna.open-mesh.org: domain of sw@simonwunderlich.de designates
 2a01:4f8:c17:e8c0::1 as permitted sender)
 smtp.mailfrom=sw@simonwunderlich.de;
	dmarc=pass (policy=none) header.from=simonwunderlich.de
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1746781846; a=rsa-sha256;
	cv=none;
	b=rUB/2xkGBv83CnJa7y0GOrO0VFEPvfdiU/ID400g4Dzw7kb7cKrK1Bm49L1EJcfEz9XOyx
	oD3Vxth8BwNPwDBwNBBO4OQkbzu/Rp9f5YjJPNFbvIcYcM/P/f0uLSlfMgptVNAblq4PTv
	VLt8GnYAfvQ3uxuCjT7H8LK+Jgqve7Y=
Received: from kero.packetmixer.de
 (p200300c59736c7D829705d90AB67A755.dip0.t-ipconnect.de
 [IPv6:2003:c5:9736:c7d8:2970:5d90:ab67:a755])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits)
 server-digest SHA256)
	(No client certificate requested)
	by mail.simonwunderlich.de (Postfix) with ESMTPSA id A4846FA373;
	Fri,  9 May 2025 11:10:45 +0200 (CEST)
From: Simon Wunderlich <sw@simonwunderlich.de>
To: kuba@kernel.org,
	davem@davemloft.net
Cc: netdev@vger.kernel.org,
	b.a.t.m.a.n@lists.open-mesh.org,
	Sven Eckelmann <sven@narfation.org>,
	Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH net-next 4/5] batman-adv: Switch to crc32 header for crc32c
Date: Fri,  9 May 2025 11:10:40 +0200
Message-Id: <20250509091041.108416-5-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250509091041.108416-1-sw@simonwunderlich.de>
References: <20250509091041.108416-1-sw@simonwunderlich.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: 4Z3BTSPSGSGFEM6CR337Y3RUEPYYDC35
X-Message-ID-Hash: 4Z3BTSPSGSGFEM6CR337Y3RUEPYYDC35
X-MailFrom: sw@simonwunderlich.de
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/4Z3BTSPSGSGFEM6CR337Y3RUEPYYDC35/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

From: Sven Eckelmann <sven@narfation.org>

The crc32c() function was moved in commit 8df36829045a ("lib/crc32:
standardize on crc32c() name for Castagnoli CRC32") from linux/crc32c.h to
linux/crc32.h. The former is just an include file which redirects to the
latter.

Avoid the indirection by directly including the correct header file.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/main.c              | 2 +-
 net/batman-adv/translation-table.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/batman-adv/main.c b/net/batman-adv/main.c
index e41f816f0887..c0bc75513355 100644
--- a/net/batman-adv/main.c
+++ b/net/batman-adv/main.c
@@ -11,7 +11,7 @@
 #include <linux/build_bug.h>
 #include <linux/byteorder/generic.h>
 #include <linux/container_of.h>
-#include <linux/crc32c.h>
+#include <linux/crc32.h>
 #include <linux/device.h>
 #include <linux/errno.h>
 #include <linux/gfp.h>
diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index 4a3165920de1..8d0e04e770cb 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -14,7 +14,7 @@
 #include <linux/cache.h>
 #include <linux/compiler.h>
 #include <linux/container_of.h>
-#include <linux/crc32c.h>
+#include <linux/crc32.h>
 #include <linux/err.h>
 #include <linux/errno.h>
 #include <linux/etherdevice.h>
-- 
2.39.5

