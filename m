Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAE03CD3445
	for <batman-adv@archiver.kernel.org>; Fri,  8 May 2026 15:45:12 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 68D5585B0C
	for <batman-adv@archiver.kernel.org>; Fri, 08 May 2026 17:45:11 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1778255111;
 b=knyMKXrHnF9mwsnV5XHE+zichgyMUOT1k9kbdF4fy/c2ulATX0JLc8QPrZJDxB5Q7c8XM
 Vezl1fXOxzPgKRRCmE8eGMFivuARPIZmdY1yOvi/ZY2BTJJz8jATzM1G/sbX31D/Zw09sm4
 djlwn2iCRjXy0OeFIGouWiroPfdwPrs=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1778255111; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=8zhRPnfLe2NDUY+iSHXVns7vYjJltQ03OVMAkw18IsM=;
 b=12k2RJBdpxti48PQSlQWD5OCTKAPdiaPJywQTqNAv8G9vTt0xtUdse8p6u27Ny5gKb3UX
 tbFWw6mRglWV6z2fWFUrYD95oBSaQaRLY033LbISUKpdMRSOsqb1PZBa9TcYMqe982hbklM
 3/Tumfj15vf24+x1alu+knAW6sZqK/s=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass header.from=simonwunderlich.de policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=simonwunderlich.de policy.dmarc=none
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 4C41B85471
	for <b.a.t.m.a.n@lists.open-mesh.org>; Fri, 08 May 2026 17:43:28 +0200 (CEST)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1778255013;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:dkim-signature;
	bh=8zhRPnfLe2NDUY+iSHXVns7vYjJltQ03OVMAkw18IsM=;
	b=qBmG7QDCgFaeMj5Ug62WVDYuKURZrDTXSk8EAxx5Fd6lL81/JQPhl97EMB7XV5fUtE0dkI
	FMbXSMyxcNSL0ms/KmmHwjRQQ9n05t81+0AGrdyuQbXT+Ja2mQTQMPWMgJ+v+YQVX6MPca
	ML5lsx1KSqYPAHtAvkKNKn780HCDv3E=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=simonwunderlich.de header.s=09092022 header.b=eMQSS70w;
	dmarc=pass (policy=none) header.from=simonwunderlich.de;
	spf=pass (diktynna.open-mesh.org: domain of sw@simonwunderlich.de designates
 23.88.38.48 as permitted sender) smtp.mailfrom=sw@simonwunderlich.de
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1778255013;
	b=eDReLGbyKLVEjeM7gm9GgneX+aZmZRTefrUT2qYoPBh21Uxeiwq/8lMr4D7t8+rUyo9sP0
	XuHOY8zuAdEWem+LnodspkEJfOVwtZRNNx5UyHkX3pEJU97vCZAyyjAtdpGHENdp1uS+Gq
	H6B+SlhiJsWeD5UVDx9T87FOr9tLOY0=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1778255006;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=8zhRPnfLe2NDUY+iSHXVns7vYjJltQ03OVMAkw18IsM=;
	b=eMQSS70w0o8Hxn0SN1KG+7odxp01shVyfDXNODrtYMZWnf2If0W19IfQ9EVzbHACsHuHU9
	DvSM2KX39r5gtgTs4g7zex5T7uGXw48/XScBjk0jv137ceubkYzDqrscSX3SptKyyRlMD6
	Ij1Rer/hNkJsbPusM3sFnj4UYylMqJSWuLorp8tIqaQHu1zxtVlJyEseBTyfqLmECR0jy7
	ozMGnLj3QCU2iY9PZdLsCdt2nZm94YuGixFSzUOqnxeiTrLmbXi4QLhWkw6wDaDrcBlDwM
	f2kTbsr8vLDRhw4u1jXe9qyYaO/9KQIPpXTAW+3T4GW79KOf3Rn2vkP2T2VlJw==
From: Simon Wunderlich <sw@simonwunderlich.de>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	b.a.t.m.a.n@lists.open-mesh.org,
	Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH net 0/8] pull request: batman-adv 2026-05-08
Date: Fri,  8 May 2026 17:43:06 +0200
Message-ID: <20260508154314.12817-1-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: SGV6P54VZXPGFYUN55IX2MX3FDJPTMAX
X-Message-ID-Hash: SGV6P54VZXPGFYUN55IX2MX3FDJPTMAX
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/SGV6P54VZXPGFYUN55IX2MX3FDJPTMAX/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

Dear net maintainers,

here are a couple of bugfixes for batman-adv which we would like to have integrated into net.

Please pull or let me know of any problem!

Thank you,
      Simon

The following changes since commit 1f5ffc672165ff851063a5fd044b727ab2517ae3:

  Fix mismerge of the arm64 / timer-core interrupt handling changes (2026-04-14 23:03:02 -0700)

are available in the Git repository at:

  https://git.open-mesh.org/batadv.git tags/batadv-net-pullrequest-20260508

for you to fetch changes up to ba9d20ee9076dac32c371116bacbe72480eb356c:

  batman-adv: bla: put backbone reference on failed claim hash insert (2026-05-08 14:29:02 +0200)

----------------------------------------------------------------
Here are some batman-adv bugfixes:

- fix integer overflow on buff_pos, by Lyes Bourennani

- fix invalid tp_meter access during teardown, by Jiexun Wang (2 patches)

- stop caching unowned originator pointers in BAT IV, by Jiexun Wang

- tp_meter: fix tp_num leak on kmalloc failure, by Sven Eckelmann

- fix BLA refcounting issues, by Sven Eckelmann (3 patches)

----------------------------------------------------------------
Jiexun Wang (3):
      batman-adv: reject new tp_meter sessions during teardown
      batman-adv: stop tp_meter sessions during mesh teardown
      batman-adv: stop caching unowned originator pointers in BAT IV

Lyes Bourennani (1):
      batman-adv: fix integer overflow on buff_pos

Sven Eckelmann (4):
      batman-adv: tp_meter: fix tp_num leak on kmalloc failure
      batman-adv: bla: prevent use-after-free when deleting claims
      batman-adv: bla: only purge non-released claims
      batman-adv: bla: put backbone reference on failed claim hash insert

 net/batman-adv/bat_iv_ogm.c            |  85 +++++++++++++++++-------
 net/batman-adv/bridge_loop_avoidance.c |  11 +++-
 net/batman-adv/main.c                  |   1 +
 net/batman-adv/tp_meter.c              | 116 +++++++++++++++++++++++++++------
 net/batman-adv/tp_meter.h              |   1 +
 net/batman-adv/types.h                 |   4 ++
 6 files changed, 172 insertions(+), 46 deletions(-)
