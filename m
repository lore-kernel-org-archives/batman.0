Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBC66CD6E56
	for <batman-adv@archiver.kernel.org>; Mon,  1 Jun 2026 12:41:02 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 95A3680C88
	for <batman-adv@archiver.kernel.org>; Mon, 01 Jun 2026 14:41:01 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1780317661;
 b=UAYc4NGIXBsMPluN9QAiJdRY4mX/Y6mRbSpoDjxpA5EG3u4yR2bFsxA+ieQ0rAMzz00mq
 tyfgZz0dv2XZdbAWd6OwpUiCv5B/WF0IsQUyQ861Wz2CrVHn0ryQNkC2UipLTl4vW89MEEH
 +xudG90X/zv6qITTz1na8SsyhMcu3rw=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1780317661; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=VAwlRpw3cuwp2rmiwA0Nrn27eTvWbfo8mto76+Q0O6U=;
 b=EXCGfO5bp7AFcOyABcvehMh8XPxlJElWI+IZEDL+RCCu1ArAOg4nhvuARn7MCcULmDbMP
 YGMJ4ls7wqKyYhT3xVmhRK49zwhuEQPGbGpVtyHTb728m4af4tGHQYj5KKUwJXTe3QZIcex
 zYeBczHDQknoN1Kxrhe8U3isWJ4VZeA=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass header.from=simonwunderlich.de policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=simonwunderlich.de policy.dmarc=none
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 17A0380529
	for <b.a.t.m.a.n@lists.open-mesh.org>; Mon, 01 Jun 2026 14:36:44 +0200 (CEST)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1780317409;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:dkim-signature;
	bh=VAwlRpw3cuwp2rmiwA0Nrn27eTvWbfo8mto76+Q0O6U=;
	b=Cmo1OLfXqDhstk7XUWsyJEdtPSLqawkmk+rICC5aSEEZe7Zft/1SnfL8eUIqPSz4m2rDxm
	2crLwUFDGrtS801ByM3HZNWfh/UeSDjYiacMHindlm7/1TdWpY1d9Ay62IygEX7VDL1z13
	AvYXFmikwIYwFsK05YO6e9EojJA9Nzc=
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1780317409;
	b=WbvskOD8qXMrTZrvGKsXAS5cULjI6T6iLUpBR9wFiMnF/8v2r4t0Wenilqo0jtrEGwnKpI
	NqeJORhYvVrVdyWhdeM8OZDxd0WNSCtaJNf2kzUTKiNnJdOqal+oYbaSqSwk0WYy9RWqBf
	lqmjvDr9idxiW2WvSaMTfm8zln/7LAY=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=simonwunderlich.de header.s=09092022 header.b=ZK8XN8qJ;
	spf=pass (diktynna.open-mesh.org: domain of sw@simonwunderlich.de designates
 23.88.38.48 as permitted sender) smtp.mailfrom=sw@simonwunderlich.de;
	dmarc=pass (policy=none) header.from=simonwunderlich.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1780317402;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=VAwlRpw3cuwp2rmiwA0Nrn27eTvWbfo8mto76+Q0O6U=;
	b=ZK8XN8qJO8nLAnBSKyr4xjuEVxi8nB1oAqHTzwf0ySKDSF0+/qJVjyIBo9s6JHEwI+2jNt
	ul/RmutxaVsgIhgTaaPAtcw7BA2T/zvTKAa7XuLwAcwDVagVX7X7MdZv5wAW35b9zlf9/1
	/pYZ2zzPvesj5Oc/Ddd+10eJENLI8YOYbPEhjw7xr7UXDwnpanaIhR5BN4oDNY/cqxEWkG
	NpbHGa73JdRRHPw3WAqrXFU2H+3wgd30VA6CMMWrwrY3eEA9XrnQhz49G0AkRtGy9tA2gM
	WS7t6bp2e/0+dZ39TVabuYkwiYfm3P4ZatUGeo5+Q4jhUl3yrOkKqP7iqa0gYQ==
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
 2026-06-01
Date: Mon,  1 Jun 2026 14:36:14 +0200
Message-ID: <20260601123629.707089-1-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: 7A5N2Y557AWLZUQILQMVTM3ZVSZZLE5P
X-Message-ID-Hash: 7A5N2Y557AWLZUQILQMVTM3ZVSZZLE5P
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/7A5N2Y557AWLZUQILQMVTM3ZVSZZLE5P/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

Dear net maintainers,

here is a cleanup pull request of batman-adv to go into net-next. This
pull request supersedes batadv-next-pullrequest-20260528 [1]. The
following minor changes were made (I marked the changed patches with v2):

* removal of version.h and switch to `init_utsname()->release` to dynamically retrieve linux version
* switch back packet_size_max to signed integer datatype to match consumers
* add missing kerneldoc for batadv_wifi_net_devices_init

Please pull or let me know of any problem!

Thank you,
      Simon

[1] e-mail subject was: [PATCH net-next 00/15] pull request for net-next: batman-adv 2026-05-28
reference: https://lore.kernel.org/all/20260528142924.329658-1-sw@simonwunderlich.de/

The following changes since commit 68993ced0f618e36cf33388f1e50223e5e6e78cc:

  Merge tag 'net-7.1-rc5' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net (2026-05-21 14:39:12 -0700)

are available in the Git repository at:

  https://git.open-mesh.org/batadv.git tags/batadv-next-pullrequest-20260601

for you to fetch changes up to 3bd64ca11d9a1672d67d3130a7264c2cf7f93cdf:

  batman-adv: use neigh_node's orig_node only as id (2026-06-01 14:22:03 +0200)

----------------------------------------------------------------
This batman-adv cleanup patchset includes the following patches, all by
Sven Eckelmann:

 - drop batman-adv specific version

 - MAINTAINERS housekeeping for batman-adv (two patches)

 - add missing includes

 - use atomic_xchg() for gw.reselect check

 - extract netdev wifi detection information object

 - replace inappropriate atomic access with (READ|WRITE)_ONCE
   (six patches)

 - tt: replace open-coded overflow check with helper

 - tvlv: avoid unnecessary OGM buffer reallocations

 - use neigh_node's orig_node only as id

----------------------------------------------------------------
Sven Eckelmann (15):
      batman-adv: drop batman-adv specific version
      MAINTAINERS: Rename batman-adv T(ree)
      MAINTAINERS: Don't send batman-adv patches to netdev
      batman-adv: add missing includes
      batman-adv: use atomic_xchg() for gw.reselect check
      batman-adv: extract netdev wifi detection information object
      batman-adv: replace non-atomic meshif config fields with (READ|WRITE)_ONCE
      batman-adv: replace non-atomic hardif config fields with (READ|WRITE)_ONCE
      batman-adv: replace non-atomic vlan config fields with (READ|WRITE)_ONCE
      batman-adv: replace non-atomic mesh state with (READ|WRITE)_ONCE
      batman-adv: replace non-atomic packet_size_max with (READ|WRITE)_ONCE
      batman-adv: replace non-atomic last_ttvn with (READ|WRITE)_ONCE
      batman-adv: tt: replace open-coded overflow check with helper
      batman-adv: tvlv: avoid unnecessary OGM buffer reallocations
      batman-adv: use neigh_node's orig_node only as id

 MAINTAINERS                            |   4 +-
 net/batman-adv/Makefile                |   1 +
 net/batman-adv/bat_iv_ogm.c            |  65 ++++++-----
 net/batman-adv/bat_v.c                 |  10 +-
 net/batman-adv/bat_v_elp.c             |  15 ++-
 net/batman-adv/bat_v_ogm.c             |  46 ++++----
 net/batman-adv/bridge_loop_avoidance.c |  15 +--
 net/batman-adv/distributed-arp-table.c |  17 +--
 net/batman-adv/fragmentation.c         |   1 +
 net/batman-adv/gateway_client.c        |   9 +-
 net/batman-adv/gateway_common.c        |  14 +--
 net/batman-adv/hard-interface.c        | 207 +++++++++++++++++++++++++++++----
 net/batman-adv/hard-interface.h        |  34 +++++-
 net/batman-adv/log.h                   |   2 +-
 net/batman-adv/main.c                  |  42 ++++---
 net/batman-adv/main.h                  |   4 -
 net/batman-adv/mesh-interface.c        |  42 +++----
 net/batman-adv/multicast.c             |   4 +-
 net/batman-adv/netlink.c               |  80 ++++++-------
 net/batman-adv/originator.c            |   8 +-
 net/batman-adv/routing.c               |   6 +-
 net/batman-adv/send.c                  |   6 +-
 net/batman-adv/tp_meter.c              |   6 +-
 net/batman-adv/translation-table.c     |  32 +++--
 net/batman-adv/tvlv.c                  |  57 +++++----
 net/batman-adv/tvlv.h                  |   3 +-
 net/batman-adv/types.h                 | 138 ++++++++++++++--------
 net/batman-adv/version.c               |  12 ++
 28 files changed, 581 insertions(+), 299 deletions(-)
 create mode 100644 net/batman-adv/version.c
