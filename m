Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 505EAC02183
	for <batman-adv@archiver.kernel.org>; Fri, 17 Jan 2025 12:40:13 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id D1BDF84303
	for <batman-adv@archiver.kernel.org>; Fri, 17 Jan 2025 13:40:11 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1737117611;
 b=wquR1qIRb1/KPSHpXroKa4nv+17Nbvw1wZlp32mRPwr1aOkuKF/33ra6Y/cRPI4MwwmZx
 KnLxb4UtolmFQLIPoNFVaN6eO53wwwJ8iWt82s3fjl46LX9vvqoo3QF7hShG8Qg8/Oa8dNY
 +f3L2aDbQ9Zzs0mmjtOr2RsyWhXhj+0=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1737117611; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=IDnupwa/qvc8cL5xwrE5K8Qed0gBNvkeiq9ywP7j39I=;
 b=KZnfHff+fiKqmaQ/0tHr91dH2EHTKc14ZKi2+GOecJRKEdz03pBwIbRDQ1/y9yzfSyoHQ
 6wPkD8UTqjEkbVqSiB0URyujYoJQwqKKGtZSXGajLn4SOTUpJfQr76Wn4Jvxnq/YYLrNbps
 stSPU4zlKSKLpBFsQMMJ8JQmuHgm9I8=
ARC-Authentication-Results: i=2; open-mesh.org; dkim=fail;
  arc=pass;
  dmarc=fail (Used From Domain Record) header.from=simonwunderlich.de
 policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=fail; arc=pass;
 dmarc=fail (Used From Domain Record) header.from=simonwunderlich.de
 policy.dmarc=none
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de
 [IPv6:2a01:4f8:c17:e8c0::1])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 6C61483F41
	for <b.a.t.m.a.n@lists.open-mesh.org>; Fri, 17 Jan 2025 13:39:30 +0100 (CET)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1737117570;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IDnupwa/qvc8cL5xwrE5K8Qed0gBNvkeiq9ywP7j39I=;
	b=Htm5LaeiXsQN9rKZ2QWxcSebpBpwkCi8XTWXJ/rInualZ1+7vzFA1ikw/TrHFFIsoIhj0u
	nGAbsa+J4gC7vA6nknNMcLb5K5foFgC5VnPGplhFA4y+eWhLaI86mWm/XCW5sfwLI4uCOU
	iDEP5yi7dlCYhQ78jmO79Ddv+DV402g=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=none;
	spf=pass (diktynna.open-mesh.org: domain of sw@simonwunderlich.de designates
 2a01:4f8:c17:e8c0::1 as permitted sender)
 smtp.mailfrom=sw@simonwunderlich.de;
	dmarc=pass (policy=none) header.from=simonwunderlich.de
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1737117570; a=rsa-sha256;
	cv=none;
	b=GUPE/4z/vKbMx/TMOHbpgXI4HTqTyt8Ew4OxtH5+/n387iFgZOg7EhcWgiQj/DfQ4vKeFq
	94WSHBdzVfUKx0S1WIVSmzfCnq+NYqIDHL94airlGWNoV0vcaAEXyQsm/O5z751bF3EesR
	yNKa4JjQorbw878iwImKvoVMRU2soLs=
Received: from kero.packetmixer.de
 (p200300c5973c90d8a96dd71A2e03F697.dip0.t-ipconnect.de
 [IPv6:2003:c5:973c:90d8:a96d:d71a:2e03:f697])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits)
 server-digest SHA256)
	(No client certificate requested)
	by mail.simonwunderlich.de (Postfix) with ESMTPSA id 032ACFA14B;
	Fri, 17 Jan 2025 13:39:29 +0100 (CET)
From: Simon Wunderlich <sw@simonwunderlich.de>
To: kuba@kernel.org,
	davem@davemloft.net
Cc: netdev@vger.kernel.org,
	b.a.t.m.a.n@lists.open-mesh.org,
	Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH 01/10] batman-adv: Start new development cycle
Date: Fri, 17 Jan 2025 13:39:01 +0100
Message-Id: <20250117123910.219278-2-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250117123910.219278-1-sw@simonwunderlich.de>
References: <20250117123910.219278-1-sw@simonwunderlich.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: DGP4IK5JCI2HT3FSF4XCLOAZTSOP645V
X-Message-ID-Hash: DGP4IK5JCI2HT3FSF4XCLOAZTSOP645V
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/DGP4IK5JCI2HT3FSF4XCLOAZTSOP645V/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

This version will contain all the (major or even only minor) changes for
Linux 6.14.

The version number isn't a semantic version number with major and minor
information. It is just encoding the year of the expected publishing as
Linux -rc1 and the number of published versions this year (starting at 0).

Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/main.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/batman-adv/main.h b/net/batman-adv/main.h
index 97ea71a052f8..1fbe3a4dd965 100644
--- a/net/batman-adv/main.h
+++ b/net/batman-adv/main.h
@@ -13,7 +13,7 @@
 #define BATADV_DRIVER_DEVICE "batman-adv"
 
 #ifndef BATADV_SOURCE_VERSION
-#define BATADV_SOURCE_VERSION "2024.3"
+#define BATADV_SOURCE_VERSION "2025.0"
 #endif
 
 /* B.A.T.M.A.N. parameters */
-- 
2.39.5

