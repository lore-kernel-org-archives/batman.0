Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E78C5D4979F
	for <batman-adv@archiver.kernel.org>; Mon,  2 Dec 2024 05:35:48 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 0DABE83F4A
	for <batman-adv@archiver.kernel.org>; Mon,  2 Dec 2024 06:35:47 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1733117747;
 b=OVasTdYgsdpQ97mf0fe574uFlcrKai9HaQd8cXJEBovf8RFfhFTf1+POPKsrU5Ub7KCvd
 q1DN/Jtu3xCK70LLSq/NXSgVYb1XMTBXGAfvSfmh/UcdBQYsoJF17r+M6QNqdAb1hYi73Dl
 pbAiwEyI8DbZAgbn345WRqIuYxK2xDA=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1733117747; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=XwL1pSGM62PjHCSuko99NLsiBUmZtSw2AbNJlwrlimo=;
 b=MxfRKPMeqq84/9wCXL13acwQ887FiprVs7+plhaVTOiKKFfGwNnBuY2U1YRb+Qga0DJkK
 GsFVbVYf7noCIfaMtR5mNFqoqama6R7T6+inqqh3OmV9uVXUVGEYIt9DCtikQ4LGfHsGXwN
 dgtJjMud+ZZ85x/YUcCsoqt9mghtH8s=
ARC-Authentication-Results: i=2; open-mesh.org; dkim=fail;
  arc=pass;
  dmarc=none
Authentication-Results: open-mesh.org; dkim=fail; arc=pass; dmarc=none
Received: from mail.aperture-lab.de (mail.aperture-lab.de [116.203.183.178])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 746CF81CDD
	for <b.a.t.m.a.n@lists.open-mesh.org>; Mon,  2 Dec 2024 06:35:20 +0100 (CET)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1733117720;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=XwL1pSGM62PjHCSuko99NLsiBUmZtSw2AbNJlwrlimo=;
	b=2rxpEeiDM9bUHsKOFmsgitkcqlCBHpq4IgTmGSuB69zLM80O25Cl6LH7Zg8EjdsMhfS4Fj
	hmB7yus7fpPGu/xorx5i1JQlkzZ5DsucrRIV6H9OsYqRfuSN/EuS69JNrrZzZYdLUj1cM6
	Hsa1H1FEBtcfoG3CuVpFaIaa01DOsjY=
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1733117720; a=rsa-sha256;
	cv=none;
	b=F0mj4bwNUtBZSzON/HaGiSfd0NirDrN7RvJ/ColIaqHnDlv71xoeNgEaZbEYF/5eCmAQJ3
	3VKesH+hEXruOCxIq3XIdYkvS7fNhCarUYBAdbjr8BjhKgNwJSvGMBfFWTVa+Gu77vvTv0
	07tY4QTcmT8ov6dHEG5ynHh6h2lleo4=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=none;
	spf=pass (diktynna.open-mesh.org: domain of linus.luessing@c0d3.blue
 designates 116.203.183.178 as permitted sender)
 smtp.mailfrom=linus.luessing@c0d3.blue;
	dmarc=none
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 6DDD4541073
	for <b.a.t.m.a.n@lists.open-mesh.org>; Mon,  2 Dec 2024 06:35:19 +0100 (CET)
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@c0d3.blue>
To: b.a.t.m.a.n@lists.open-mesh.org
Subject: [PATCH v3 0/3] add dynamic, bridged-in TT VID detection support
Date: Mon,  2 Dec 2024 06:05:19 +0100
Message-ID: <20241202053511.326-1-linus.luessing@c0d3.blue>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
Message-ID-Hash: T6J7CYQXRJMX2RYANC7LKHHV6KHL5NI2
X-Message-ID-Hash: T6J7CYQXRJMX2RYANC7LKHHV6KHL5NI2
X-MailFrom: linus.luessing@c0d3.blue
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/T6J7CYQXRJMX2RYANC7LKHHV6KHL5NI2/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

For one thing the following patchest is supposed to mitigate the
regression of extra OGM overhead that we accidentally introduced with
the introduction of the compatibility version 15, the TVLV support it
provided, together with TT VLAN support. The addition of these TVLVs
roughly doubled the OGM overhead back then, also/mainly because the 8021q
and Linux bridge modules would add TT VLAN IDs 0 and 1, even if no one is
actually using them. PATCH 3/3 tries to avoid this and will only add
these two VLAN IDs if they were detected on actual traffic.

In preparation of this the internal VLAN creation was overhauled in
PATCH 1/3. This also in theory allows detecting new VLAN IDs dynamically
from traffic from bridged-in traffic. So far, VLAN IDs could only be
used which were anticipated and configured on top of bat0 by the
administrator.

However the detection of VLANs from bridged-in clients is by default
disabled for now through PATCH 2/3. This patch adds a configurable limit
for such snooped VLAN IDs, defaulting to zero for now. The issue is that
each added VLAN still increases the OGM size considerably in the current
protocol, so it is not advised to add many VLANs at the moment, without a
bigger upgrade of the protocol. Also there is still an outstanding issue
with temporarily broken broadcast traffic upon adding a new VLAN if BLA
is enabled at the same time. Therefore defaulting to zero snooped VLANs
from bridged-in clients for now.

Regards, Linus

---

v3:
* fixing refcounting, removing an unnecessary kref_get() in PATCH 1/3
* adding PATCH 2/3 + PATCH 3/3
* resubmitting without the RFC tag

v2: fix a typo, a missing "to" in the commit message
