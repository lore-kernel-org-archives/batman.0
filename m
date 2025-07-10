Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 815B0C83F17
	for <batman@archiver.kernel.org>; Thu, 10 Jul 2025 16:47:15 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 0357784C27
	for <batman@archiver.kernel.org>; Thu, 10 Jul 2025 18:47:12 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1752166032;
 b=zC3k6m/bUwS3fqKSmkFepXO5dM7L9w77WgaWYqee2I1T2LLAbAS6EzpqTt/DQPGI/ExT4
 tHMHN9kyvi+nj7drEZ5pPoVj08gN5er/LzDFwCQ2bVA0En2XMHIKZAFdD+sFzoMObrSUZLf
 N0AdtYJTcMgk5qt7L/h1QfnCC/zATyg=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1752166032; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=93Z+eyp8o7aEHzkK2H0eIU41kCx8f7IpToYhNP9++Gs=;
 b=bbwBA46O3sOgoP7OoijdVwsRECC+KkEljeigDB33f75NE1yZ8Pn6yQSuKZKsvnnWC2/nq
 ZVJGsD1BdkAWA38FYa4Axwx3PvQJ/CU3rdA98pxQH1gy+oRGymYHmRjvsfwjWBEZQKjtEmt
 f3AHeA0jGIvUCv8yI0bbJH+UByNR024=
ARC-Authentication-Results: i=2; open-mesh.org; dkim=fail;
  arc=pass;
  dmarc=fail (Used From Domain Record) header.from=simonwunderlich.de
 policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=fail; arc=pass;
 dmarc=fail (Used From Domain Record) header.from=simonwunderlich.de
 policy.dmarc=none
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id A94F98461F
	for <b.a.t.m.a.n@lists.open-mesh.org>; Thu, 10 Jul 2025 18:45:10 +0200 (CEST)
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1752165920; a=rsa-sha256;
	cv=none;
	b=PkYuDzRgcZ7QB5yq+0TD5F+35QKXI33nhGmwz9rHXwmSYFyDScWnrfgFXTJCRxrXP0MuR0
	HQWiUMioXpfGAr+Y3Ow/Uof50CXe9Ce47PBL325O4FatIcotJ3SsS51frMibkxT2Q/pJ27
	M7EUhjgqTrJeFIzKSllprjNC0pkE8ss=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=none;
	spf=pass (diktynna.open-mesh.org: domain of sw@simonwunderlich.de designates
 23.88.38.48 as permitted sender) smtp.mailfrom=sw@simonwunderlich.de;
	dmarc=pass (policy=none) header.from=simonwunderlich.de
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1752165920;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=93Z+eyp8o7aEHzkK2H0eIU41kCx8f7IpToYhNP9++Gs=;
	b=RvAj8JwkLYZbrX7e43nfuRdmd5j3J8v+2izOtjTsh/uAHP5qe05B2rZyVtrUFJqknmRFCD
	ckYDP93PBpRQBnCfNVxKGCrlghrmwcE17zdO2PcyVyccgHcUWQR+P8QeIzGvSwUudRZEot
	Crzbn//xTYvImc1RJtlp3ulwMBWmUCM=
Received: from kero.packetmixer.de
 (p200300fA271bac80353e86DE392BA4aF.dip0.t-ipconnect.de
 [IPv6:2003:fa:271b:ac80:353e:86de:392b:a4af])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits)
 server-digest SHA256)
	(No client certificate requested)
	by mail.simonwunderlich.de (Postfix) with ESMTPSA id 7A690FA023;
	Thu, 10 Jul 2025 18:45:10 +0200 (CEST)
From: Simon Wunderlich <sw@simonwunderlich.de>
To: kuba@kernel.org,
	davem@davemloft.net
Cc: netdev@vger.kernel.org,
	b.a.t.m.a.n@lists.open-mesh.org,
	Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH net-next 1/2] batman-adv: Start new development cycle
Date: Thu, 10 Jul 2025 18:45:00 +0200
Message-Id: <20250710164501.153872-2-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250710164501.153872-1-sw@simonwunderlich.de>
References: <20250710164501.153872-1-sw@simonwunderlich.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: JBJLFYGI4UKSLTF2RELWOPNX27ODT3DE
X-Message-ID-Hash: JBJLFYGI4UKSLTF2RELWOPNX27ODT3DE
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/JBJLFYGI4UKSLTF2RELWOPNX27ODT3DE/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

This version will contain all the (major or even only minor) changes for
Linux 6.17.

The version number isn't a semantic version number with major and minor
information. It is just encoding the year of the expected publishing as
Linux -rc1 and the number of published versions this year (starting at 0).

Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/main.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/batman-adv/main.h b/net/batman-adv/main.h
index 692109be2210..1481eb2bacee 100644
--- a/net/batman-adv/main.h
+++ b/net/batman-adv/main.h
@@ -13,7 +13,7 @@
 #define BATADV_DRIVER_DEVICE "batman-adv"
 
 #ifndef BATADV_SOURCE_VERSION
-#define BATADV_SOURCE_VERSION "2025.2"
+#define BATADV_SOURCE_VERSION "2025.3"
 #endif
 
 /* B.A.T.M.A.N. parameters */
-- 
2.39.5

