Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 920FBCD98E6
	for <batman@archiver.kernel.org>; Fri, 19 Jun 2026 07:04:06 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 4074F80F3E
	for <batman@archiver.kernel.org>; Fri, 19 Jun 2026 09:04:05 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1781852645;
 b=cqfPY6wwSoc455kbETcclFy8Rns880b5eukQr5MkSo9h0V1+VFKyjJ464c125XRyGh+ev
 abROhQ26Wm+DNGwMx/AwRdACV+aJcacXwY/aneSkVJXWwZPwlbfU2Ff0cEUSLQx6Y4//hjo
 BPlDYpRqdgIiD6n2B7s26dQuLAmvLlI=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1781852645; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=i1TkLzyUd1JwPopxOLN6MeiT5+G1+YihcZtxk0na7ro=;
 b=IyDO5ba6F8O6oAW1qwPiRcNxm4DOeJ6nj2RJxBvfNyDA3u27PPwPd82PT3OA/F1CassNI
 LqkQiZaDmXecQg3dJdg7QZBF/oeTXmj6GsxILikCjkKfpsuNJiEUOXs4PENVzdqXA7O898s
 Nk2ssYeDuSqTjUUh0ybo8sl2RVmxhXQ=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass header.from=simonwunderlich.de policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=simonwunderlich.de policy.dmarc=none
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de
 [IPv6:2a01:4f8:c17:e8c0::1])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id E89C48308A
	for <b.a.t.m.a.n@lists.open-mesh.org>; Fri, 19 Jun 2026 09:00:48 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1781852454;
	b=zOkhg7TFS5Y/qUoZN7Vm4XaiUZUjW36YYSjoKobxICjhQ+ZxLZMyECu3g6Jrjhs4HGrZVr
	iXf9nEEZvpzUM3RWYi7r7WGWqEDJnT4/qlUOz0ug+W3gXhOERas1kVq1iShcyingwFXbDT
	2sRn19dtk4iwWFeP6wabEd/iVkkxqLw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1781852454;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:dkim-signature;
	bh=i1TkLzyUd1JwPopxOLN6MeiT5+G1+YihcZtxk0na7ro=;
	b=nxpwc2x7ii9SraA9XK+hnZw3m6tO12ImKhLD1XOfUHBGRzlS3evqPnyTY+Lal8nVlwcYNn
	CZMzvRFwFE1yyAuh7EHD2BZQFxZ+eZlY0gAxFxaVIRAgqy3bvGzxiX8oZWOATJV5+PRup9
	z9mngBu39qMq/OKg3SL3FF20iBKd8ws=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=simonwunderlich.de header.s=09092022 header.b=h6ql4ZWx;
	dmarc=pass (policy=none) header.from=simonwunderlich.de;
	spf=pass (diktynna.open-mesh.org: domain of sw@simonwunderlich.de designates
 2a01:4f8:c17:e8c0::1 as permitted sender) smtp.mailfrom=sw@simonwunderlich.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1781852446;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=i1TkLzyUd1JwPopxOLN6MeiT5+G1+YihcZtxk0na7ro=;
	b=h6ql4ZWxeEWdYnFm1M3mQeM7XLANR3/OrTo0BibVg5XKaA2jrGcDTlCfhrKDHsCGM4eskA
	a9GGheNn3gp+OsmVgfmuiebwqXbiI8kpxye54C3HydJeN4e3InzAHzSY2zT4zJenVSVB4K
	x9oaLAI0T3zQckgdydd6ntHJayiEigiU4X5hbU6ds8yDF/154BdOV0kQiqXJKt1sgupeXi
	Dei5CEQEAgYm93WS0Ix+pOzBLeqSnAXj/Pid0bz1/l/5a/mnKeqIW5agmHxiy/hPlNvYYJ
	dGPfagCKL/JowiAPmRrqqIOXuQXWf1z3Du4PTzav9WqJARxfT/0QBDOO7DPlqw==
From: Simon Wunderlich <sw@simonwunderlich.de>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	b.a.t.m.a.n@lists.open-mesh.org,
	Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH net 00/15] pull request: batman-adv 2026-06-19
Date: Fri, 19 Jun 2026 09:00:30 +0200
Message-ID: <20260619070045.438101-1-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: 7MVIMRBGAFQ5SASZ5UUV7YTOWL3BBMN4
X-Message-ID-Hash: 7MVIMRBGAFQ5SASZ5UUV7YTOWL3BBMN4
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/7MVIMRBGAFQ5SASZ5UUV7YTOWL3BBMN4/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

Dear net maintainers,

here are some bugfixes for batman-adv which we would like to have integrated into net.

Please pull or let me know of any problem!

Thank you,
      Simon

The following changes since commit dad4d4b92a9b9f0edb8c66deda049da1b62f6089:

  Merge git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net (2026-06-11 14:33:35 -0700)

are available in the Git repository at:

  https://git.open-mesh.org/batadv.git tags/batadv-net-pullrequest-20260619

for you to fetch changes up to edb557b2ba38fea2c5eb710cf366c797e187218c:

  batman-adv: tvlv: avoid race of cifsnotfound handler state (2026-06-14 12:33:18 +0200)

----------------------------------------------------------------
Here are some batman-adv bugfixes, all by Sven Eckelmann:

- gw: don't deselect gateway with active hardif

- TTL fixes in bcast/mcast and fragmentation handling (4 patches)

- BATMAN V: prevent OGM aggregation on disabled hardif

- tp_meter: concurrency and range fixes, add cap to unacked list
  (4 patches)

- tt: fix unchecked VLAN ID in tt for local add and roam (2 patches)

- dat: check VLAN ID in the hash

- tvlv: enforce 2-byte alignment

- tvlv: avoid race of cifsnotfound handler state

----------------------------------------------------------------
Sven Eckelmann (15):
      batman-adv: gw: don't deselect gateway with active hardif
      batman-adv: ensure bcast is writable before modifying TTL
      batman-adv: fix (m|b)cast csum after decrementing TTL
      batman-adv: frag: ensure fragment is writable before modifying TTL
      batman-adv: frag: avoid underflow of TTL
      batman-adv: v: prevent OGM aggregation on disabled hardif
      batman-adv: tp_meter: restrict number of unacked list entries
      batman-adv: tp_meter: annotate last_recv_time access with READ/WRITE_ONCE
      batman-adv: tp_meter: prevent parallel modifications of last_recv
      batman-adv: tp_meter: handle overlapping packets
      batman-adv: tt: don't merge change entries with different VIDs
      batman-adv: tt: track roam count per VID
      batman-adv: dat: prevent false sharing between VLANs
      batman-adv: tvlv: enforce 2-byte alignment
      batman-adv: tvlv: avoid race of cifsnotfound handler state

 net/batman-adv/bat_iv_ogm.c            | 11 ++++-
 net/batman-adv/bat_v.c                 |  1 +
 net/batman-adv/bat_v_ogm.c             | 23 ++++++++++-
 net/batman-adv/distributed-arp-table.c | 12 ++++--
 net/batman-adv/fragmentation.c         | 22 +++++++++-
 net/batman-adv/fragmentation.h         |  3 +-
 net/batman-adv/hard-interface.c        | 28 +------------
 net/batman-adv/routing.c               | 73 +++++++++++++++++++++++++++++++--
 net/batman-adv/tp_meter.c              | 74 ++++++++++++++++++++++------------
 net/batman-adv/translation-table.c     | 12 +++++-
 net/batman-adv/tvlv.c                  | 69 ++++++++++++++++++++++++++++---
 net/batman-adv/types.h                 | 21 ++++++----
 12 files changed, 270 insertions(+), 79 deletions(-)
