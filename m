Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CB63C41513
	for <batman-adv@archiver.kernel.org>; Thu, 27 Jul 2023 08:14:29 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 7A1648198D
	for <batman-adv@archiver.kernel.org>; Thu, 27 Jul 2023 10:14:27 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1690445667;
 b=FQtxQbetaO3uKzer4v3mIKtv0NMMgFX1oPaoFoUO+CBsxxxjaVpOtKl0ubXWlNZJqrDLY
 tvwvSzPkK+Mk/zqbqqPYOY1DsHj/nYGnCBvSyBzL/2LuPpys+aNGcbWSy4/MLKlKP1cbkBQ
 InhOJ5F9m0JX/PRowMPFv5xvsN9gDtU=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1690445667; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=KZF4PzwCEwwYcaRBoN0IAh9F1yO0UcrBopOx4zosWIM=;
 b=mLCP0YCrL0ks9U2hXZ9dYUFmHmfo48ilH0BXQTORsn2IBjMv1X0o/Y/OG+XiNBj00/e1W
 y54qNpczcOt7tyYER4kMBFY0YPKuAFFmnC/uCoUOzb0ymgQYgsBvKTbUb0h7QkjHQyidoC0
 hJ1jLVnO3nlBEFmRhyqg+bg0un0QDWg=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
  arc=pass;
  dmarc=pass (Used From Domain Record) header.from=narfation.org
 policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 4DC5B800F3
	for <b.a.t.m.a.n@lists.open-mesh.org>; Thu, 27 Jul 2023 10:14:09 +0200 (CEST)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1690445649;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:dkim-signature;
	bh=KZF4PzwCEwwYcaRBoN0IAh9F1yO0UcrBopOx4zosWIM=;
	b=FTujBhGafH4Az5LKQdxt1WQFvzLn1IKZT+HY7DmvdvxqqQ3ijce3B9eMBmEldEIcxPcGPE
	rVXlRyWq7ekp7aWIKlcalJcAVA3eycbMBY8JdUL7x2gTNbMck+/Q8d3oSkUm0bIofAn48T
	RFR5eQhinfmfbsH1PjYKwVf9iuuMOjQ=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=ZPJOzje3;
	dmarc=pass (policy=none) header.from=narfation.org;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1690445649; a=rsa-sha256;
	cv=none;
	b=cMxoxKvwC3KmUPVC/XsdM7d70ZPxfMlMNk6OgEInVowu5CQPBZegm2egtlMC8a3fWKPLIq
	4aGElJpz5rKspFE+Ft3reHCBvZ7NEAOf0BaVLMYPE/f23Y08OAPH/EPc9AOys6AUH/Y9WX
	PGgridut+XcuLdBf9U/yAx4oE6vHgUQ=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1690445648;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=KZF4PzwCEwwYcaRBoN0IAh9F1yO0UcrBopOx4zosWIM=;
	b=ZPJOzje3mQ9zLjH6aq8w/gtFiqvhDK00YTpOGDYF2dq6u7ux7FNxARSw0X+jMe2j4ELEMC
	KEAJwcwguLGMr1vKMcWOADpM4fe12e7pAxeuFMRuecQNc53BlbhcOHjASL2fiXj4OXxVPk
	zHmA6Ro//NfFm+1azolgeQSH3EJSYvs=
From: Sven Eckelmann <sven@narfation.org>
Subject: [PATCH RFC 0/3] batman-adv: Enable support for jumbo frames
Date: Thu, 27 Jul 2023 10:13:41 +0200
Message-Id: <20230727-jumbo-mtu-v1-0-036ce1a6e33c@narfation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADYnwmQC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI2MDcyNz3azS3KR83dySUl1D4xRzYzMDU8tkCxMloPqCotS0zAqwWdFKQW7
 OSrG1tQC5d+PLYAAAAA==
To: b.a.t.m.a.n@lists.open-mesh.org
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1126; i=sven@narfation.org;
 h=from:subject:message-id; bh=vgQXIjYngWdbFmxWUYBJNc7cdXpNQabIniflKlrDZUo=;
 b=owEBbQKS/ZANAwAKAV2HCgfBJntGAcsmYgBkwidGtCrs6XuViSosNZA+3vHlVbigizFEK/jeC
 Mb3TSAlXmqJAjMEAAEKAB0WIQQXXSuHYSVz3OMy4AJdhwoHwSZ7RgUCZMInRgAKCRBdhwoHwSZ7
 RqzEEACA2AB6wftHtcWJPzBBvBrUr95aQMeL9xG8toSXJwpP33aOt0zW3Uw4zljKFMafL2AfEzu
 mL3Pxyr8M2d+Kkd0X/sKxxVX76LHO6btv8pYD0pqBvLnVWcr/0eIX+JQx3khVcGf10PKSXL4uuy
 fBkdGy4IGNKQRESp2D6ivGdjQod3W3gDUR5N5lsakWMrgtP2vDj21FpXoT1ZFJpf4pk/4Lmp3bK
 ZIMEA+8aphv8ddTTn28wqbSEoF6gBRaasNN9Xu/jTRDJUA6Max5cW+WbZ8J9wcue/WKxKQU36LF
 0HEe0WFGlE94RZ0IeAo1Nlpc2MGVx2cZwdcu4z10c9her+y2Oada3ujblgXQVAFwTCK6qlOk4lc
 YwyZTfpD9SFh73SbMIHBcV3RzRACI/EVTKedUsyZByb0en++3Q4gI5FV0tWmvvzJZL6yVp9iPFp
 b1HiZqzB8uf9PP2PkjU40zt7I1sS9uIfiamsBWt43JigbiZBqSzeBOjaUynEuM+1HcIUIgTmPxn
 2di+oQMjyHIObaAdSmDvHvdgfA1C1ZDU+tMChbK007+hscWvVOfZucXkoQK2JYR7khp6hz18CjI
 8RFYOoekNdLkZdroJ0C9GXpYODph7EuBRZdF6YBO4mAunh+fxaGSawK1xyob63Vgjdg/NNV80Xu
 sGAYzQJFGr+DhVw==
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: KVUH4LT6ATMLUNXR5HQD2EJIYFXKCCFK
X-Message-ID-Hash: KVUH4LT6ATMLUNXR5HQD2EJIYFXKCCFK
X-MailFrom: sven@narfation.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-0;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/KVUH4LT6ATMLUNXR5HQD2EJIYFXKCCFK/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

There are from time to time discussions about supporting jumbo frames
with batman-adv. While the changes were known since a longe time [1], no
actual tests were performed and no actual reviews were gathered.

Maybe some more interest can be stirred up by this RFC and some
Tested-by/Reviewed-by [2] can be collected - or some fixes.

[1] https://www.open-mesh.org/issues/365
[2] https://www.kernel.org/doc/html/v6.4/process/submitting-patches.html#using-reported-by-tested-by-reviewed-by-suggested-by-and-fixes

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
Sven Eckelmann (3):
      batman-adv: Avoid magic value for minimum MTU
      batman-adv: Check hardif MTU against runtime MTU
      batman-adv: Add support for jumbo frames

 net/batman-adv/hard-interface.c | 24 ++++++++++++++----------
 net/batman-adv/main.h           |  2 ++
 net/batman-adv/soft-interface.c |  5 +++--
 3 files changed, 19 insertions(+), 12 deletions(-)
---
base-commit: f779cdaf7782ee765dbddd31f6d9a89abf0c52f9
change-id: 20230727-jumbo-mtu-13d736059c84

Best regards,
-- 
Sven Eckelmann <sven@narfation.org>

