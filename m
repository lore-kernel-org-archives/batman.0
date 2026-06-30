Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0E1CC43458
	for <batman-adv@archiver.kernel.org>; Tue, 30 Jun 2026 14:09:01 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id A0BA28254E
	for <batman-adv@archiver.kernel.org>; Tue, 30 Jun 2026 16:09:00 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1782828540;
 b=v4RncwEUWiJbuK0zKXORLES5sOAbfZK9xsh4Hcbq6g9XWTZsQ9SmCL6hO/IT9aPQ8BZC7
 23PN5JAX18ha2LKGgxZoFduIzBrt/NMD34BpO70ce/vHX0y4UpfdhW24mSdQU3ZyMqBTLTi
 35f0DvyDYDKbsYvmRF6f58pizN+vpqU=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1782828540; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=RML7WXnJKm0QCAIXXu6o7fujESjNPIoRg8QFFLLlkbU=;
 b=IUigSYywdzzYeABYbt5tpGmKj3mkBpWIBZs7iUUAMVKnEE837YhdTrEwa/wSVccpEmxFN
 8iIDIjICJ4UZMMkohvoKpN2++XVbhFrEYAY4ZTaQd/LdGXunUlNGg0gWvUk3VMKChl8uzB/
 64osEkaCQxMORmpTy5GwgEya4pp2n1c=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass header.from=simonwunderlich.de policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=simonwunderlich.de policy.dmarc=none
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id B6FC0810A3
	for <b.a.t.m.a.n@lists.open-mesh.org>; Tue, 30 Jun 2026 16:06:25 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1782828390;
	b=KV7or4Dnhai3qY1iL7rO3ndbTbyfFCD0Jl+84wXLU9QcENSS0XalK+mV6q9/rKqlpDg99m
	nB+9ShQQwyHc/VO3u0cOvAfy8sRhEzIMT5MtMG0JXcW7Y57hX8rZuaVSJQEJx8qqMVnmBp
	0r9ot7fo6Cx76vl1wACBPjRsboLfFp4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1782828390;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:dkim-signature;
	bh=RML7WXnJKm0QCAIXXu6o7fujESjNPIoRg8QFFLLlkbU=;
	b=F8gIjcsvI8tQGfDYmk9v/Mkb2ARac53Ik0kc+cQ4qHhgbGM5VEsiHtuPirN6HTi/hoDCGK
	g2yXTYJfmWPiBVNeOB9tWTvUBkIRFlWiVr5krmo03gAy6SfOa0wQzwI4dwJUAf3k17t7Mk
	We41WYAjMhLa3yz/OSDKB9PuHol7QsI=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=simonwunderlich.de header.s=09092022 header.b=I9aeYTkz;
	spf=pass (diktynna.open-mesh.org: domain of sw@simonwunderlich.de designates
 23.88.38.48 as permitted sender) smtp.mailfrom=sw@simonwunderlich.de;
	dmarc=pass (policy=none) header.from=simonwunderlich.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1782828384;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=RML7WXnJKm0QCAIXXu6o7fujESjNPIoRg8QFFLLlkbU=;
	b=I9aeYTkzmQugHZyHbSOxmQbBHfhCBE3wpKMbAzOuqMdNFiDQErANeChF3fCNehDgcmB781
	hBAx+RBlYDivhXhRxdiSpaK+aLYbJJOsyVd34S2Mp2sw0vJWC1YVQNjslp3lrR685+psAa
	Es/H1cWpv9vdiq6qZggoZmfao2oXbzbtCIK59lyUrX98L7mzFSCDXdXQc3eSx0o3OZP+UB
	6sAxZetzP7TUKMd8KDU9hndeAq+yVy8tpcPCpwn8PL+Jab+1Em66xAcPVtAKa0epdjPP33
	qSJycq2AuR/8v7eqbJmFJdVapL5T/4vcuFdZPJqsxZWrwCKFUQ2I8gyqbf0V8g==
From: Simon Wunderlich <sw@simonwunderlich.de>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	b.a.t.m.a.n@lists.open-mesh.org,
	Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH net-next 00/15] pull request for net-next: batman-adv
 2026-06-30
Date: Tue, 30 Jun 2026 16:06:08 +0200
Message-ID: <20260630140623.88431-1-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: 2EMHA2KJB7QHPUAQURSS4ZOEB44XZIK3
X-Message-ID-Hash: 2EMHA2KJB7QHPUAQURSS4ZOEB44XZIK3
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/2EMHA2KJB7QHPUAQURSS4ZOEB44XZIK3/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

Dear net maintainers,

here is cleanup pull request of batman-adv to go into net-next.

Please pull or let me know of any problem!

Thank you,
      Simon

The following changes since commit 805185b7c7a1069e407b6f7b3bc98e44d415f484:

  Merge tag 'net-7.2-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net (2026-06-25 12:25:36 -0700)

are available in the Git repository at:

  https://git.open-mesh.org/batadv.git tags/batadv-next-pullrequest-20260630

for you to fetch changes up to 247691642fd4de7a029de253e47dba936542ce9f:

  batman-adv: tp_meter: delay allocation of unacked entry (2026-06-28 22:09:04 +0200)

----------------------------------------------------------------
This cleanup patchset includes the following patches:

 - drop hardif global list, by Nora Schiffer (2 patches)

 - make hard_iface->mesh_iface immutable, by Sven Eckelmann

 - further post-hardif global list cleanups,
   by Nora Schiffer (3 patches)

 - cleanups and simplifications depending on the hardif->mesh_iface
   immutability guarantee, by Sven Eckelmann (3 patches)

 - tvlv: extract tvlv header iterator, by Sven Eckelmann

 - tp_meter: improve unacked list handling,
   by Sven Eckelmann (5 patches)

----------------------------------------------------------------
Nora Schiffer (5):
      batman-adv: create hardif only for netdevs that are part of a mesh
      batman-adv: remove global hardif list
      batman-adv: remove BATADV_IF_NOT_IN_USE hardif state
      batman-adv: move hardif generation counter into batadv_priv
      batman-adv: drop unneeded goto and initialization from batadv_hardif_disable_interface()

Sven Eckelmann (10):
      batman-adv: make hard_iface->mesh_iface immutable
      batman-adv: drop NULL check for immutable hardif->mesh_iface
      Revert "batman-adv: v: stop OGMv2 on disabled interface"
      batman-adv: iv: drop migration check for batadv_hard_iface
      batman-adv: tvlv: extract tvlv header iterator
      batman-adv: tp_meter: simplify unordered ack calculation
      batman-adv: tp_meter: combine adjacent/overlapping unacked entries
      batman-adv: tp_meter: keep unacked list for receivers
      batman-adv: tp_meter: adjust name of receiver lock
      batman-adv: tp_meter: delay allocation of unacked entry

 net/batman-adv/bat_iv_ogm.c            |  12 +-
 net/batman-adv/bat_v_elp.c             |   9 +-
 net/batman-adv/bat_v_ogm.c             |  33 ++---
 net/batman-adv/bridge_loop_avoidance.c |   9 +-
 net/batman-adv/hard-interface.c        | 165 ++++++++-----------------
 net/batman-adv/hard-interface.h        |  10 +-
 net/batman-adv/main.c                  |   9 --
 net/batman-adv/main.h                  |   3 -
 net/batman-adv/mesh-interface.c        |  13 +-
 net/batman-adv/netlink.c               |   4 +-
 net/batman-adv/originator.c            |   4 -
 net/batman-adv/tp_meter.c              | 217 ++++++++++++++++++++-------------
 net/batman-adv/tvlv.c                  |  86 +++++++------
 net/batman-adv/types.h                 |  28 ++---
 14 files changed, 273 insertions(+), 329 deletions(-)
