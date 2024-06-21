Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1517C2BA1A
	for <batman-adv@archiver.kernel.org>; Fri, 21 Jun 2024 14:39:56 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 132DA83175
	for <batman-adv@archiver.kernel.org>; Fri, 21 Jun 2024 16:39:55 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1718980795;
 b=xXrf7tAbZEqGCfnu+3axBVE5Pwg+jdZ8bFgdGe4tGmxcN0kFPCXgqPKl4XZZ/yWy8GYUJ
 19zFJHxtYLzIf56IKigPA8xEhUfoei6N8C6XLYWcqbtLRrD4Agqxo2e9/bE2TaGIMMJj1/+
 kpZl0XL4rhzsFnh2w8ncXksKndSqIvU=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1718980795; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=xuYQdyYszVNYy/xDjlC3wSa7Oq5R1svy18097dBlbDM=;
 b=u/QQegDcaw55+7USZPWgjA/Hlcjs93k4tk6T76BMPlBnpMerv/VLA8x466CRD0nR1QSAp
 YD238eYF6CSK68hQkim5N4ZPUA+aXkC4VtPHicV886TJGQK+k5K739C7Mj4f89IyZ8RezfA
 pAa9OCjqDp7wPVMG23mPVrXAxjVUBSQ=
ARC-Authentication-Results: i=2; open-mesh.org; dkim=fail;
  arc=pass;
  dmarc=fail (Used From Domain Record) header.from=simonwunderlich.de
 policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=fail; arc=pass;
 dmarc=fail (Used From Domain Record) header.from=simonwunderlich.de
 policy.dmarc=none
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de
 [IPv6:2a01:4f8:c17:e8c0::1])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id B4A5B825B1
	for <b.a.t.m.a.n@lists.open-mesh.org>; Fri, 21 Jun 2024 16:39:23 +0200 (CEST)
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1718980764; a=rsa-sha256;
	cv=none;
	b=eHiNF2UawYUsCejwkrE77V5FjRGfpGC+GE0J+k3cdQZ84U7jm91FtaVK96AMu7C/N8TZ6j
	GOZfdszV8kFip29uVYzJpJ4oyzCLUOomGX3BWVC+nLXVo0xsqbj00ddvM21mj1mjcHbz3k
	NWtmtaS7wNB5sqLtloOTuYPIQOJ6Lb8=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=none;
	dmarc=pass (policy=none) header.from=simonwunderlich.de;
	spf=pass (diktynna.open-mesh.org: domain of sw@simonwunderlich.de designates
 2a01:4f8:c17:e8c0::1 as permitted sender) smtp.mailfrom=sw@simonwunderlich.de
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1718980764;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=xuYQdyYszVNYy/xDjlC3wSa7Oq5R1svy18097dBlbDM=;
	b=WFl+YKvx7b/+4t6D3cPOVYXvflDPvxd75G5+vWADDT0vO6tVvGh3/utqibTrEKqGlzAnXh
	A7d0PWs80YOgPa1fbnaM8rvkqd6PAbto1uhURrTKcTIunMNepbNzarlu/kGsOmzspwpUPa
	jrpDGWgDmv0PFnfT+qD/Jn2B9nsnVTs=
Received: from kero.packetmixer.de
 (p200300C5970FcFD871714591023Aa0Cd.dip0.t-ipconnect.de
 [IPv6:2003:c5:970f:cfd8:7171:4591:23a:a0cd])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits)
 server-digest SHA256)
	(No client certificate requested)
	by mail.simonwunderlich.de (Postfix) with ESMTPSA id 3D1A8FA131;
	Fri, 21 Jun 2024 16:39:22 +0200 (CEST)
From: Simon Wunderlich <sw@simonwunderlich.de>
To: davem@davemloft.net,
	kuba@kernel.org
Cc: netdev@vger.kernel.org,
	b.a.t.m.a.n@lists.open-mesh.org,
	Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH 0/2] pull request for net: batman-adv 2024-06-21
Date: Fri, 21 Jun 2024 16:39:13 +0200
Message-Id: <20240621143915.49137-1-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Message-ID-Hash: QDSXCRHQEVUDBA7H2XYT4KHWK7UUJYSA
X-Message-ID-Hash: QDSXCRHQEVUDBA7H2XYT4KHWK7UUJYSA
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/QDSXCRHQEVUDBA7H2XYT4KHWK7UUJYSA/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

Hi David, hi Jakub,

here are two bugfixes for batman-adv which we would like to have integrated into net.

Please pull or let me know of any problem!

Thank you,
      Simon

The following changes since commit 1613e604df0cd359cf2a7fbd9be7a0bcfacfabd0:

  Linux 6.10-rc1 (2024-05-26 15:20:12 -0700)

are available in the Git repository at:

  git://git.open-mesh.org/linux-merge.git tags/batadv-net-pullrequest-20240621

for you to fetch changes up to 6bfff3582416b2f809e6b08c6e9d57b18086bdbd:

  Revert "batman-adv: prefer kfree_rcu() over call_rcu() with free-only callbacks" (2024-06-12 20:18:00 +0200)

----------------------------------------------------------------
Here are some batman-adv bugfixes:

- Don't accept TT entries for out-of-spec VIDs, by Sven Eckelmann

- Revert "batman-adv: prefer kfree_rcu() over call_rcu() with free-only
  callbacks", by Linus Lüssing

----------------------------------------------------------------
Linus Lüssing (1):
      Revert "batman-adv: prefer kfree_rcu() over call_rcu() with free-only callbacks"

Sven Eckelmann (1):
      batman-adv: Don't accept TT entries for out-of-spec VIDs

 net/batman-adv/originator.c        | 27 ++++++++++++++++++++++
 net/batman-adv/translation-table.c | 47 +++++++++++++++++++++++++++++++++++---
 2 files changed, 71 insertions(+), 3 deletions(-)
