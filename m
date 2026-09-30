Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D904CA5FB1
	for <batman-adv@archiver.kernel.org>; Wed, 30 Sep 2026 09:47:17 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 50F2A8427C
	for <batman-adv@archiver.kernel.org>; Wed, 30 Sep 2026 11:47:15 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1790761635;
 b=RD63N8NskI1R1qDxB9/PeAiUt8WRjxHSdG/fQl0xYctWUgYhkDvnWEewxV/PeTRcHH/zs
 f/+4QqGVwuNXcWrD5SPO+kGkhMDqxC3elXEM6GoeSnqb89/ZsaDRBU4oTk37mQ5HIKJW6+G
 mpXg+sc7SHpDxdOrJuFvKTObOWE50Kg=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1790761635; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=28i/yfmhWsjrZWGfpgWXRsKrylYWppeaugMbYrlbf98=;
 b=cI8De1P4h2aAhzWzA+XZr4jfHJwVgqNMX5I2r/sHO4BEphQpcN1w+de+hV1MIaGKfIJlz
 +qZlt4E85DowzbvLfGztgmc8cG8JajZuHg3JcTX0Ujs5Lu0h0ioZFPoWE9TgBpQX0/Cf1gp
 d7mWIPAqgO29oO05TbL6a3zywqYKMkk=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass header.from=simonwunderlich.de policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=simonwunderlich.de policy.dmarc=none
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de
 [IPv6:2a01:4f8:c17:e8c0::1])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 129738227C
	for <b.a.t.m.a.n@lists.open-mesh.org>; Wed, 30 Sep 2026 11:46:02 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1790761562;
	b=ue/ME4foOUgGkGSYKAfyk7k4vn62xa5bE2FA5xWuNJotwKufh7PsyEpGbWmHSS1HDb0vLL
	SKgYLLnNaq9hS7ffoBDjrdIIRrri5WvnxACA8SVDwQNd0VYnuJoNww7SBPt9D2qd8xjs9G
	/z9IgMBYad60av1ecPAFt73+Hu2Q+Oc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1790761562;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:dkim-signature;
	bh=28i/yfmhWsjrZWGfpgWXRsKrylYWppeaugMbYrlbf98=;
	b=r9BjFklqS/ygdNKxQPzEyv39H/vgdV/XxeOiKOguuVAY2tbCmiG4SZuV39yLvTLSOWDG9u
	rTTtg91x8ttytC3b2OSfmaF3DTuZK1Jq0hM3/VJ4Ygx+S4DPVeHpX6e9FIkjwoGhhvZN56
	nN9KEqUxlYRot4OG4spVh9jP73Y3SnQ=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=simonwunderlich.de header.s=09092022 header.b=wc8VKd+O;
	dmarc=pass (policy=none) header.from=simonwunderlich.de;
	spf=pass (diktynna.open-mesh.org: domain of sw@simonwunderlich.de designates
 2a01:4f8:c17:e8c0::1 as permitted sender) smtp.mailfrom=sw@simonwunderlich.de
Received: from kero.packetmixer.de
 (p200300C5970E81D8CF20E45a7328D917.dip0.t-ipconnect.de
 [IPv6:2003:c5:970e:81d8:cf20:e45a:7328:d917])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by mail.simonwunderlich.de (Postfix) with UTF8SMTPSA id 00E14FA006;
	Wed, 30 Sep 2026 11:45:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1790761560;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=28i/yfmhWsjrZWGfpgWXRsKrylYWppeaugMbYrlbf98=;
	b=wc8VKd+O7SwI2WaWbd1ezuDl3++HMziO6DuwE2zAVANGyNzadl4+dv7WU4xEPooNmT2o9z
	gGKktFUf+nv6ykoeuyw3Ai5Zuf9kdIxBOdolvBt3va+/0IOd5FUb81kaDYL2kczdpVDmjh
	zc4wH2qRnJdKcB09hwXTEPHCJy6n2+2G4+ktEyla2Kfhcv3kYS/WARrCPhbxFjhpy2MShf
	EO/ZaLWflCqyr6cCa4ZIkyQUkJ6AtLausiis2u4H7tYs17Bper75HDuTJTMygEin+/GFot
	QCCMLJe4Lg+Km+jLee2JxqSe1VM93RPpS/AxDl1MSHKOqt+5AxU+kG0FvXcSHA==
From: Simon Wunderlich <sw@simonwunderlich.de>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	b.a.t.m.a.n@lists.open-mesh.org,
	Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH net-next 0/9] pull request for net-next: batman-adv 2026-09-30
Date: Wed, 30 Sep 2026 11:45:49 +0200
Message-ID: <20260930094558.3723766-1-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: 5YLOQQSJUIMHCR3K3SLAUL77BTMNV373
X-Message-ID-Hash: 5YLOQQSJUIMHCR3K3SLAUL77BTMNV373
X-MailFrom: sw@simonwunderlich.de
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-b.a.t.m.a.n.lists.open-mesh.org-0;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-1;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-2;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-3; emergency; member-moderation;
 nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size;
 news-moderation; no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/5YLOQQSJUIMHCR3K3SLAUL77BTMNV373/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

Dear net maintainers,

here is another feature/cleanup pull request of batman-adv to go into net-next.

Please pull or let me know of any problem!

Thank you,
      Simon

The following changes since commit 6d7f71ae4cdcbb22f541638057299fe26c451e65:

  batman-adv: correct batadv_hash_remove kdoc return type (2026-09-06 20:05:31 +0200)

are available in the Git repository at:

  https://git.open-mesh.org/batadv.git tags/batadv-next-pullrequest-20260930

for you to fetch changes up to d1807b20d548171d40c5d21a7cf22830ea8f348e:

  batman-adv: use assign_bit() where applicable (2026-09-27 19:03:34 +0200)

----------------------------------------------------------------
This feature/cleanup patchset includes the following patches:

 - bla: avoid double free after failed backbone_hash alloc,
   by Sven Eckelmann

 - tt: update kerneldoc, by Sven Eckelmann (3 patches)

 - tt: fix local DEL handling, by Sven Eckelmann (3 patches)

 - tt: reject VLAN/TT entries before reaching size limit,
   by Sven Eckelmann

 - use assign_bit() where applicable, by Peng Fan

----------------------------------------------------------------
Peng Fan (1):
      batman-adv: use assign_bit() where applicable

Sven Eckelmann (8):
      batman-adv: bla: avoid double free after failed backbone_hash alloc
      batman-adv: tt: clarify kernel-doc for batadv_tt_global_purge_local
      batman-adv: tt: clarify responsibility for roam flag during removal
      batman-adv: tt: soften kernel-doc for batadv_tt_local_remove_now()
      batman-adv: tt: only queue local del event after successful unlink
      batman-adv: tt: queue local DEL event under bucket lock
      batman-adv: tt: queue local DEL event before marking entry as pending
      batman-adv: tt: reject VLAN/TT entries before reaching size limit

 net/batman-adv/bridge_loop_avoidance.c |   1 +
 net/batman-adv/distributed-arp-table.c |   6 +-
 net/batman-adv/main.c                  |   1 +
 net/batman-adv/mesh-interface.c        |   8 +
 net/batman-adv/translation-table.c     | 359 ++++++++++++++++++++++++---------
 net/batman-adv/translation-table.h     |   3 +
 net/batman-adv/types.h                 |  19 ++
 7 files changed, 299 insertions(+), 98 deletions(-)
