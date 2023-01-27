Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 368C8C38142
	for <batman-adv@archiver.kernel.org>; Fri, 27 Jan 2023 10:22:33 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 7D94084244
	for <batman-adv@archiver.kernel.org>; Fri, 27 Jan 2023 11:22:31 +0100 (CET)
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 883B7805AC
	for <b.a.t.m.a.n@lists.open-mesh.org>; Fri, 27 Jan 2023 11:21:36 +0100 (CET)
ARC-Seal: i=2; s=20121; d=open-mesh.org; t=1674814896; a=rsa-sha256;
	cv=pass;
	b=SeoKcBdEl3tPLZAmA4sg8FUooWlsk3wXinxkDQnVo8lEM3F08BHbEHgeX71Z6GJ7FZm8cX
	4NtIVmwvEyT1BnDkTy5s9gfRaXNBs7xMXD+bvCm83dkQhCq2sZss0/wDLVGckt1m0YgcFP
	NHhPJ2cv6AZUsRLWR5Z8jpd4Cvb38gY=
ARC-Authentication-Results: i=2;
	diktynna.open-mesh.org;
	dkim=pass header.d=simonwunderlich.de header.s=09092022 header.b=KSmKO++k;
	spf=pass (diktynna.open-mesh.org: domain of sw@simonwunderlich.de designates 23.88.38.48 as permitted sender) smtp.mailfrom=sw@simonwunderlich.de;
	arc=pass ("simonwunderlich.de:s=09092022:i=1");
	dmarc=pass (policy=none) header.from=simonwunderlich.de
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1674814896;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=ZvLElpC1+VVIp39vMIrU5LoBRiGr9pejs0Xce5d2JTM=;
	b=N/v6SJC52ohq7z16QcDrJkw8i0p5BDU+Ja1Rdh+Nwbec1TOtbcBPyQVAcOs2QgEgS3VZx4
	ULmdcjtTacf+qo+aYn5gDxTTAJVQnZBbIrgrQrCl9sd6DIXEX4LMOtNbFq64GDg+Q06q7z
	WGoOOKQHgC12/8FG8tXNgph0pzjXGDU=
Received: from kero.packetmixer.de (p200300C5973eAed8832E80845Eb11f67.dip0.t-ipconnect.de [IPv6:2003:c5:973e:aed8:832e:8084:5eb1:1f67])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.simonwunderlich.de (Postfix) with ESMTPSA id 47F4BFAFDB;
	Fri, 27 Jan 2023 11:21:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1674814896; h=from:from:sender:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZvLElpC1+VVIp39vMIrU5LoBRiGr9pejs0Xce5d2JTM=;
	b=KSmKO++kKswmJO78DSO8+r8aVxek2gnRKgl/iR0kjWK5y8um1b5rJhTw1y99rQtE4H0Z5r
	F2k7H+ssOHPXeI7oqiBgq77oibi+Xjrp+oc/CyVN2hiA9wGm13f5V1KZSdEjAOqZ4rMs7/
	rktMHyBstl4gvS5G6sKpVXp6tdmBULea7T6HAD0Jy2DyHvHza0oxIX9l2Naw6dlAsK9d3i
	lYiczDZjdI6JPkV9scRPLMaNudAqYs6s7bxd4GRQb4OUAk5z6iIxweFyOX6Ixw+zsnjG8a
	GR/aMveYWp6cBJzYCOllP+A5o2DdoaEXOPAqSa9bf9MLe5GF4uQz34WHzPFaPg==
From: Simon Wunderlich <sw@simonwunderlich.de>
To: kuba@kernel.org,
	davem@davemloft.net
Subject: [PATCH 1/5] batman-adv: Start new development cycle
Date: Fri, 27 Jan 2023 11:21:29 +0100
Message-Id: <20230127102133.700173-2-sw@simonwunderlich.de>
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
	bh=ZvLElpC1+VVIp39vMIrU5LoBRiGr9pejs0Xce5d2JTM=;
	b=c9Dz2OLpNFukMVRawYs0TLlrEBCYdxuK0xrfkMazVNQFu3Roaplj/QZ6HKuRpGY27C/ZhX
	u3VGJPh2DrJQRegsWai9yIacuauLPj36Wg7p1ClCipasVrDfACKRKgHxfbhrbv93erkEDg
	Yvuotj0AKwPE/+WR/DQVDn/5Crv7CZhxMDTfYXiZkxE+3InWJLk+i2WakKeovFR5jMpMg4
	Cv2onBPUHCOmUZnAjB32T56Zbi0Xe5XlYmolWy0OyvDb4PYiXIaWndShnKjK29RG9MAfDz
	o18LNdlJEdo1Aoh8LCOBimV7zW8F5InmLSqLzmiVOQ0fJL6jIe/eQdpWyHeycg==
ARC-Seal: i=1; s=09092022; d=simonwunderlich.de; t=1674814896; a=rsa-sha256;
	cv=none;
	b=wUr3t+U0wzKru1ENhK+ueeEPwZyPCiAN3lbRHzYx+3Q0bEDoAimUPsInHOjmbXQqT61RNnnfiH1PRlPNxnuEioMGqugCVPfcdVv0qOU9tHxbDF7FomK8Aq8XaTvXy72uNl2MXp4GsECJ4olWKGBgcn/XmPwAbbhpjL8euODpJcYC577TfUrGFeRHw8O1Oy4AlzQ1MSz2gx4cRDw1sqTAps5sbj1fhfxXKvks4Mxhc0brPGF9jiC2NTz0mcpXqScOWtdpoSF2iyHCWXL6zshsDbWYhntqZ2ogo2CzszZFg3tZoEq/yPD0SjYy5Q6RwMxdGpxATccPVmK+/FwF5mmrrw==
ARC-Authentication-Results: i=1;
	mail.simonwunderlich.de;
	auth=pass smtp.auth=sw@simonwunderlich.de smtp.mailfrom=sw@simonwunderlich.de
Content-Transfer-Encoding: quoted-printable
Message-ID-Hash: AK2BBEY544DFREP5P6X54NAH4IB53R7Q
X-Message-ID-Hash: AK2BBEY544DFREP5P6X54NAH4IB53R7Q
X-MailFrom: sw@simonwunderlich.de
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-b.a.t.m.a.n.lists.open-mesh.org-0; header-match-b.a.t.m.a.n.lists.open-mesh.org-1; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org
X-Mailman-Version: 3.2.1
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/AK2BBEY544DFREP5P6X54NAH4IB53R7Q/>
List-Archive: <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

This version will contain all the (major or even only minor) changes for
Linux 6.3.

The version number isn't a semantic version number with major and minor
information. It is just encoding the year of the expected publishing as
Linux -rc1 and the number of published versions this year (starting at 0)=
.

Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/main.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/batman-adv/main.h b/net/batman-adv/main.h
index c48803b32bb0..156ed39eded1 100644
--- a/net/batman-adv/main.h
+++ b/net/batman-adv/main.h
@@ -13,7 +13,7 @@
 #define BATADV_DRIVER_DEVICE "batman-adv"
=20
 #ifndef BATADV_SOURCE_VERSION
-#define BATADV_SOURCE_VERSION "2022.3"
+#define BATADV_SOURCE_VERSION "2023.1"
 #endif
=20
 /* B.A.T.M.A.N. parameters */
--=20
2.30.2
