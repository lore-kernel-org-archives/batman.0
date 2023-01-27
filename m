Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10D25C54EAA
	for <batman-adv@archiver.kernel.org>; Fri, 27 Jan 2023 10:22:01 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 12CF284635
	for <batman-adv@archiver.kernel.org>; Fri, 27 Jan 2023 11:22:00 +0100 (CET)
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [IPv6:2a01:4f8:c17:e8c0::1])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 3E1C3805AC
	for <b.a.t.m.a.n@lists.open-mesh.org>; Fri, 27 Jan 2023 11:21:36 +0100 (CET)
ARC-Seal: i=2; s=20121; d=open-mesh.org; t=1674814896; a=rsa-sha256;
	cv=pass;
	b=SM/V3WXhnbR9OjMiNiMMsk3shR0fW/ML6HpkbuJpsa0Gm+tLrabbknERnLLEDJDaigUM5t
	UYwSugirNgzqc+RS3GeAHXFtxqmD+QC/J8A0ubs4YGubk6OCUOBseBuysxicoP5GLe96q3
	CVUQ7aQf+x+93cQx/hf3kRRojhMO4C8=
ARC-Authentication-Results: i=2;
	diktynna.open-mesh.org;
	dkim=pass header.d=simonwunderlich.de header.s=09092022 header.b="IL+rLPj/";
	spf=pass (diktynna.open-mesh.org: domain of sw@simonwunderlich.de designates 2a01:4f8:c17:e8c0::1 as permitted sender) smtp.mailfrom=sw@simonwunderlich.de;
	arc=pass ("simonwunderlich.de:s=09092022:i=1");
	dmarc=pass (policy=none) header.from=simonwunderlich.de
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1674814896;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:dkim-signature;
	bh=aXYLvZBvJAKGvHLP8eGn1rEh52J6aR0JS3CEFSTTukQ=;
	b=luz1X2Cj5SJAbgEpTNrb1vcUpyjUgCbxkhf26j6MPHHPr6j+7q0MuK4H2vUlIQlhQBx875
	SNc4ITwnw+T8PVQmy1q0hleisVp/+ArFr+ER6T9tAIYXCdpx0yMwaiUIHBcqmi8vf0V3kn
	buesf7QXP18yMnZc0Taj5DhT4StJMtg=
Received: from kero.packetmixer.de (p200300c5973Eaed8832e80845EB11f67.dip0.t-ipconnect.de [IPv6:2003:c5:973e:aed8:832e:8084:5eb1:1f67])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.simonwunderlich.de (Postfix) with ESMTPSA id D47B6FAFDA;
	Fri, 27 Jan 2023 11:21:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1674814895; h=from:from:sender:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:in-reply-to:
	 references; bh=aXYLvZBvJAKGvHLP8eGn1rEh52J6aR0JS3CEFSTTukQ=;
	b=IL+rLPj/zMQMXOhbtTUVnpMz8O20Fn3nrNteTS3GMHDNNuZCVyAnZdHUNfva7YmwatjkGk
	OK5P/1Z+5xJKU4hHIbEKwSMEtndjPbyOjAJ59bkiuV+PSfRgFFIl4yTK/jnhHXWy+sDHUg
	qgKLW8ip7P4jZsrk78i51iRUtkwKYGlOWi59tEyznsY4hnKrEGii7IGfC8JCC8Wp25qh3g
	6dMk7y6parl/oKLZhxE2f2wrIma2RvfzsydiMIqNPI1LJJU4s0tQAhwumjgVR8yp0KM8Eq
	QIfIzNOXl9xelZbI2QCvt3QoDZ4/RmRhDmEQZZI6MLkDZQQDPmZCK92BdgDFuw==
From: Simon Wunderlich <sw@simonwunderlich.de>
To: kuba@kernel.org,
	davem@davemloft.net
Subject: [PATCH 0/5] pull request for net-next: batman-adv 2023-01-27
Date: Fri, 27 Jan 2023 11:21:28 +0100
Message-Id: <20230127102133.700173-1-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
	d=simonwunderlich.de; s=09092022; t=1674814895;
	h=from:from:sender:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:in-reply-to:
	 references; bh=aXYLvZBvJAKGvHLP8eGn1rEh52J6aR0JS3CEFSTTukQ=;
	b=z9bLkQt271evq2zSxsEQ+uBz/2V4XxLML2pURM41lG/lAg+kOqgaQv9a7wjztf6Sr4Bhb/
	CDEqGtcTnF1xflpdotCInRkMamxRlXwqXAdm2jzsLOpaWo/LnBUFB18t7Bpn26FDTam0Si
	Q9O+M72w4PtJ2I0n9XTM0FRgS79Aao+bexOPqf1FKw3Cjzu5rADPud33cN3rW5xv27UT4r
	oKiOXBbQw3ndSN0MAmLXFEXvcPpJQjRHlXWtWTxrlyKzcRXECmffVZ4mbXqAn19TPhNMgO
	WPgW6x2x+0H5wPKt/LPjy21noJL7rqrV0DIaA6JNZbtTPc8g/hQ41/gTzK1kEg==
ARC-Seal: i=1; s=09092022; d=simonwunderlich.de; t=1674814895; a=rsa-sha256;
	cv=none;
	b=oZSRCmMkt5Yo911jSPOVWuWLn4OHxLs5Jndz2JbJUZhRayOAYDhtR6lwz2c257QPA/Wp1d0muGL56qYuoyn1prK2y1EM8Zbrp4HuUPXzRe64qt10rvsEmgnyC7i9tjbBwZ5MLspn+hEmKotq2IsvrlKBGtna7SyiSmzrYffEhxrD9mDf7L7UXqthJgJxdFn499AmjfMkqpD0P/nSPef4/eJDdCpL5ZsWd2e853t3Z2auz7epSV0lAjiyE1e/fWuqfr2W8IixfXaNpUyaUGkz+wcbd3RIZF2gfUJuBLSrBPAATXtN0P3Uqk31iWneK2LkS/ilqQQikzqR2NmjIPG+0w==
ARC-Authentication-Results: i=1;
	mail.simonwunderlich.de;
	auth=pass smtp.auth=sw@simonwunderlich.de smtp.mailfrom=sw@simonwunderlich.de
Content-Transfer-Encoding: quoted-printable
Message-ID-Hash: BBYFLZCBGQDTOIW35YXZXYSG754BPCNR
X-Message-ID-Hash: BBYFLZCBGQDTOIW35YXZXYSG754BPCNR
X-MailFrom: sw@simonwunderlich.de
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-b.a.t.m.a.n.lists.open-mesh.org-0; header-match-b.a.t.m.a.n.lists.open-mesh.org-1; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org
X-Mailman-Version: 3.2.1
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/BBYFLZCBGQDTOIW35YXZXYSG754BPCNR/>
List-Archive: <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

Hi Jakub, hi David,

here is a feature/cleanup pull request of batman-adv to go into net-next.

Please pull or let me know of any problem!

Thank you,
      Simon

The following changes since commit 88603b6dc419445847923fcb7fe5080067a30f=
98:

  Linux 6.2-rc2 (2023-01-01 13:53:16 -0800)

are available in the Git repository at:

  git://git.open-mesh.org/linux-merge.git tags/batadv-next-pullrequest-20=
230127

for you to fetch changes up to 0c4061c0d0e2c381ffe4d8b7c62ea69ad8132071:

  batman-adv: tvlv: prepare for tvlv enabled multicast packet type (2023-=
01-21 19:01:59 +0100)

----------------------------------------------------------------
This feature/cleanup patchset includes the following patches:

 - bump version strings, by Simon Wunderlich

 - drop prandom.h includes, by Sven Eckelmann

 - fix mailing list address, by Sven Eckelmann

 - multicast feature preparation, by Linus L=C3=BCssing (2 patches)

----------------------------------------------------------------
Linus L=C3=BCssing (2):
      batman-adv: mcast: remove now redundant single ucast forwarding
      batman-adv: tvlv: prepare for tvlv enabled multicast packet type

Simon Wunderlich (1):
      batman-adv: Start new development cycle

Sven Eckelmann (2):
      batman-adv: Drop prandom.h includes
      batman-adv: Fix mailing list address

 Documentation/networking/batman-adv.rst |   2 +-
 include/uapi/linux/batadv_packet.h      |   2 +
 net/batman-adv/bat_iv_ogm.c             |   1 -
 net/batman-adv/bat_v_elp.c              |   1 -
 net/batman-adv/bat_v_ogm.c              |   5 +-
 net/batman-adv/distributed-arp-table.c  |   2 +-
 net/batman-adv/gateway_common.c         |   2 +-
 net/batman-adv/main.h                   |   2 +-
 net/batman-adv/multicast.c              | 251 ++------------------------=
------
 net/batman-adv/multicast.h              |  38 +----
 net/batman-adv/network-coding.c         |   4 +-
 net/batman-adv/routing.c                |   7 +-
 net/batman-adv/soft-interface.c         |  26 ++--
 net/batman-adv/translation-table.c      |   4 +-
 net/batman-adv/tvlv.c                   |  71 ++++++---
 net/batman-adv/tvlv.h                   |   9 +-
 net/batman-adv/types.h                  |   6 +
 17 files changed, 110 insertions(+), 323 deletions(-)
