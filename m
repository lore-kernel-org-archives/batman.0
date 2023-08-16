Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B9EAC001B0
	for <batman-adv@archiver.kernel.org>; Wed, 16 Aug 2023 16:40:37 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id A5153833B0
	for <batman-adv@archiver.kernel.org>; Wed, 16 Aug 2023 18:40:35 +0200 (CEST)
ARC-Seal: i=3; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1692204035;
 b=tBIw01iNNb8/0e7jZrywvirIpMSGFc8vyTM0KKOtKppWHBYzjx7fNkaE//PsnpZYPQlOW
 IJlcFqJHsFlMy6Yv+tR3OgR/6A3+npn1vDQgVCpTkvYs6mr6J0pnauC8uOqE1moBCfwGPmN
 /2jLnsicHyY6tJjqQ8DTkgPlICQQxhw=
ARC-Message-Signature: i=3; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1692204035; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=I+eNQQSjj0fLqG+BSXaidpJmTR8Z/e+0zb1hTzjHxqM=;
 b=bmQ62mM4W8horHAds0bIyye4nOuLdsrqltPbjnW+I0Ez76vqp2yMJbBz+YMvEHETTYRYT
 4JvywRbfH20Leuc2EY1CNkHNf0gWpujTM47hJS27zNs4jPSBLVG78h6Zhkcv1ht+5g1VZ1R
 7wocrl6mR18H9E0uNZRFoIbDzrpGBg8=
ARC-Authentication-Results: i=3; open-mesh.org;
 dkim=pass header.d=simonwunderlich.de;
  arc=pass;
  dmarc=pass (Used From Domain Record) header.from=simonwunderlich.de
 policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=simonwunderlich.de policy.dmarc=none
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de
 [IPv6:2a01:4f8:c17:e8c0::1])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id CD8898011C
	for <b.a.t.m.a.n@lists.open-mesh.org>; Wed, 16 Aug 2023 18:40:01 +0200 (CEST)
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1692204001;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:dkim-signature;
	bh=I+eNQQSjj0fLqG+BSXaidpJmTR8Z/e+0zb1hTzjHxqM=;
	b=ut2pxGpYoz0yQHIJQXjUyMMY2Hbqz/Pv0sRjdCP+LbLIX6KNHNq1RPTIzdcxVt3eB1whXD
	Hg6/Ve5lc0quLtkCngdux8YXa+QZV6PZJ9yGBAWfGDgwoLU4/W4yO+smx7fy/fpV3DSwar
	rU3KtgjPbeZS0eQD4d1Gwe61fM5xiQA=
ARC-Authentication-Results: i=2;
	diktynna.open-mesh.org;
	dkim=pass header.d=simonwunderlich.de header.s=09092022 header.b=Ymb+qXUC;
	spf=pass (diktynna.open-mesh.org: domain of sw@simonwunderlich.de designates
 2a01:4f8:c17:e8c0::1 as permitted sender)
 smtp.mailfrom=sw@simonwunderlich.de;
	dmarc=pass (policy=none) header.from=simonwunderlich.de;
	arc=pass ("simonwunderlich.de:s=09092022:i=1")
ARC-Seal: i=2; s=20121; d=open-mesh.org; t=1692204001; a=rsa-sha256;
	cv=pass;
	b=Iquv7OWPdrMV7d5P4KzKrjzZP0FVyDYEqaT1sGOVyB1qAlfAyE0HLPw5s6gmnBkaev8RmS
	FqZXhHi7wCTxYDCGMcukjyBp+nicfduXbNzeBPBFIRtLqbQQAUNJm1Bxaq+CKHi6n7QR0f
	hamMC3zi4lCKJjLQF+tUUwMBTAXWYJA=
Received: from kero.packetmixer.de
 (p200300fa272a67000Bb2D6Dcaf57D46e.dip0.t-ipconnect.de
 [IPv6:2003:fa:272a:6700:bb2:d6dc:af57:d46e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits)
 server-digest SHA256)
	(No client certificate requested)
	by mail.simonwunderlich.de (Postfix) with ESMTPSA id 81DBFFB5C2;
	Wed, 16 Aug 2023 18:40:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1692204001;
 h=from:from:sender:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:references; bh=I+eNQQSjj0fLqG+BSXaidpJmTR8Z/e+0zb1hTzjHxqM=;
	b=Ymb+qXUCe/EpQCfCzLD60gxk9l9FBltIJdqEG1j0Q7+8r41cyUJPTn3jZJY0PJ5dAVApB3
	bN7++gO+szqeYk4bJdDJosSebRarW4W/pxH4OpoEH4qgv+u7dxfqmSJOuu4CNicI+CkIMQ
	SKiZuMmzTCUjJf6byAAw0iP9DBtoNv5pgH/c9ql2KxOJDqk8MPhftvPjZX+8Lh2zpMmRj7
	wEJpoiVh1mbjaiyeNdOx0+oZOCfmIxtEcGjT0eF7T8jut+soaOu3gmbBPCBvwCeUm2qXzN
	ps2/1l7FhpyKdL1p+vl+BKnu091kyTvoLEXw/Ie7poQ50RbALiOSdCrd3D3GHA==
From: Simon Wunderlich <sw@simonwunderlich.de>
To: kuba@kernel.org,
	davem@davemloft.net
Subject: [PATCH 0/7] pull request for net-next: batman-adv 2023-08-16
Date: Wed, 16 Aug 2023 18:39:53 +0200
Message-Id: <20230816164000.190884-1-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
	d=simonwunderlich.de; s=09092022; t=1692204001;
	h=from:from:sender:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:references; bh=I+eNQQSjj0fLqG+BSXaidpJmTR8Z/e+0zb1hTzjHxqM=;
	b=ps4xuiNxZY+wGGy9p0uQd6t0RuOKMyhua+3vMXc4VzB86bpFX5TUENVufo7xXNirc1L78E
	119FDLiEBG/bWOaoBZ4RF2PkNMatZMuZayOuNlr2yEyxMwZTQi9YRgu+tFX8HQXRBn6BW0
	29yMN+kY91PPg3ID2YLx+1bNd8n2e7rTgxT4fo7rxkJT7GqCRq/UV8SWbWkDAFnuU0elYQ
	T8VcLRfDRQGlyHPBh1+fww9Goo4dJYL22K0pOaYFu0gm8fIzoZOLsM9biohLtHn/S3Ig4F
	7xEDF5nMkWxIrP8RLFwd/dSNYbWoGUGPPy419cLNfyWMPBRIeiW0Jz0buzLmrA==
ARC-Seal: i=1; s=09092022; d=simonwunderlich.de; t=1692204001; a=rsa-sha256;
	cv=none;
	b=P+7j+XEL5cTgQM5CkLn64UVNnipyBjxTxAaZMIZ38zsY32s9vxmXonkM9sleXcYdVDRWxBJN3y8TfH9wCgkwdG2vvIHqLvhZHCYNeMwfElc4auPh8wLXYnE987dGLsMpSC+jMAMxRp9PvZ9KAA4pw2B2vyX3r7GeeoBvMZWVHwWLXnybVB6l5CZlYo1HLya33/37DnQ/fRxsuy5mexsZyUvTbvTE9JUzlS1v0nRpLECAQeniu2ARo5yyRqrj10rXkIjXSow/IjhT8+jkSU48qQB1LDfcekojUxgavxblLVqaaaWPS8phd/71tQChJYxT3tlEAFn+q+gLBlu7M2X10A==
ARC-Authentication-Results: i=1;
	mail.simonwunderlich.de;
	auth=pass smtp.auth=sw@simonwunderlich.de smtp.mailfrom=sw@simonwunderlich.de
Message-ID-Hash: 53RFEPXD6J2BQEW5JXEXPOQAMELVAWJN
X-Message-ID-Hash: 53RFEPXD6J2BQEW5JXEXPOQAMELVAWJN
X-MailFrom: sw@simonwunderlich.de
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-0;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
CC: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/53RFEPXD6J2BQEW5JXEXPOQAMELVAWJN/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

Hi Jakub, hi David,

here is a cleanup pull request of batman-adv to go into net-next.

Please pull or let me know of any problem!

Thank you,
      Simon

The following changes since commit 06c2afb862f9da8dc5efa4b6076a0e48c3fbaaa5:

  Linux 6.5-rc1 (2023-07-09 13:53:13 -0700)

are available in the Git repository at:

  git://git.open-mesh.org/linux-merge.git tags/batadv-next-pullrequest-20230816

for you to fetch changes up to 6f96d46f9a1ad1c02589b598c56ea881094129d8:

  batman-adv: Drop per algo GW section class code (2023-08-14 18:01:21 +0200)

----------------------------------------------------------------
This cleanup patchset includes the following patches:

 - bump version strings, by Simon Wunderlich

 - Remove unused declarations, by Yue Haibing

 - Clean up MTU handling, by Sven Eckelmann (2 patches)

 - Clean up/remove (obsolete) functions, by Sven Eckelmann (3 patches)

----------------------------------------------------------------
Simon Wunderlich (1):
      batman-adv: Start new development cycle

Sven Eckelmann (5):
      batman-adv: Avoid magic value for minimum MTU
      batman-adv: Check hardif MTU against runtime MTU
      batman-adv: Drop unused function batadv_gw_bandwidth_set
      batman-adv: Keep batadv_netlink_notify_* static
      batman-adv: Drop per algo GW section class code

YueHaibing (1):
      batman-adv: Remove unused declarations

 net/batman-adv/bat_iv_ogm.c     |   1 +
 net/batman-adv/bat_v.c          |  23 +-----
 net/batman-adv/gateway_common.c | 162 +---------------------------------------
 net/batman-adv/gateway_common.h |   7 --
 net/batman-adv/hard-interface.c |  20 +++--
 net/batman-adv/main.h           |   2 +-
 net/batman-adv/netlink.c        |  15 ++--
 net/batman-adv/netlink.h        |   6 --
 net/batman-adv/routing.h        |   4 -
 net/batman-adv/soft-interface.c |   2 +-
 net/batman-adv/types.h          |   7 +-
 11 files changed, 28 insertions(+), 221 deletions(-)
