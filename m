Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B18DC282DE
	for <batman-adv@archiver.kernel.org>; Thu, 13 Mar 2025 16:45:32 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 161818425E
	for <batman-adv@archiver.kernel.org>; Thu, 13 Mar 2025 17:45:31 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1741884331;
 b=M/H967qd3w6VAHX9gpwdrrpIQQNhoAwdiOALgS/HbwD6/yGmvYJu5SqgmBaRJrp2S3L7F
 Jy3k9nWJnP1x4gX+TSwY/pwdWkml/CChCiHMeBmPvJRYSYwxuU21u1abG+dLjFbESN/nvuS
 JCrGjdFCXZrfl0NUhf3ZCgbwNmFKb0E=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1741884331; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=08Yx4YLwfTo7KkXRkurHDWnxO1EbAOurNMPK1GFCJTA=;
 b=YiDutQ0ERZUgwynunUnyA4+45zR63NtTl6TZQHVCq7KQGuefxLNS/7RJo7WUJq7L6vPKg
 L8p/Ba/sHLp6j9/JLmNe24ZT4cAWuSPFHEq9xya95WEGBt3jcXarXOE9TqeEwmjObALWvN/
 ur6xpywtr4wez4vDmduErhcyIEwYeBM=
ARC-Authentication-Results: i=2; open-mesh.org; dkim=fail;
  arc=pass;
  dmarc=fail (Used From Domain Record) header.from=simonwunderlich.de
 policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=fail; arc=pass;
 dmarc=fail (Used From Domain Record) header.from=simonwunderlich.de
 policy.dmarc=none
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 3F20A800D6
	for <b.a.t.m.a.n@lists.open-mesh.org>; Thu, 13 Mar 2025 17:45:23 +0100 (CET)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1741884323;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=08Yx4YLwfTo7KkXRkurHDWnxO1EbAOurNMPK1GFCJTA=;
	b=QpTc+2kTzkbq2xAg7O2fa1Qu35cwz3rav9yeHLza3JeljitPsDr3GXr9sWPEtUF0sbhRts
	geScRqGnkc8ciZbVhd86KQ102rEkdEBJjy0tRSMJpkpkAYMkoeZ3827KVhK5mVQ0j6ZKFR
	CvWUaM6JQ5XFpQhi1BvVIMZI/ikoCkY=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=none;
	dmarc=pass (policy=none) header.from=simonwunderlich.de;
	spf=pass (diktynna.open-mesh.org: domain of sw@simonwunderlich.de designates
 23.88.38.48 as permitted sender) smtp.mailfrom=sw@simonwunderlich.de
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1741884323; a=rsa-sha256;
	cv=none;
	b=KIX8CMYmfonNGwvkTEC/muEOosvucU/rtPE8UcOudEpA3FHDpPbjjsUJJ1BNiivIWAYVtS
	LVTq5/h1LqltAW0z4cS5Qe8Hm9hlbAInmw6p9tUrpkFGk9MR5NO/5VoPe8FZbyCEUmogrl
	p9JKO3zs9ZO3mRvbiLmbZz5ul4Nib1A=
Received: from kero.packetmixer.de
 (p200300Fa272413901A38A4BC9c0De305.dip0.t-ipconnect.de
 [IPv6:2003:fa:2724:1390:1a38:a4bc:9c0d:e305])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits)
 server-digest SHA256)
	(No client certificate requested)
	by mail.simonwunderlich.de (Postfix) with ESMTPSA id C6D42FA131;
	Thu, 13 Mar 2025 17:45:22 +0100 (CET)
From: Simon Wunderlich <sw@simonwunderlich.de>
To: kuba@kernel.org,
	davem@davemloft.net
Cc: netdev@vger.kernel.org,
	b.a.t.m.a.n@lists.open-mesh.org,
	Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH 00/10] pull request for net-next: batman-adv 2025-03-13
Date: Thu, 13 Mar 2025 17:45:09 +0100
Message-Id: <20250313164519.72808-1-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: 4LHIAUCPXZHUT6ZNFKFAARGNDJ6QEHNN
X-Message-ID-Hash: 4LHIAUCPXZHUT6ZNFKFAARGNDJ6QEHNN
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/4LHIAUCPXZHUT6ZNFKFAARGNDJ6QEHNN/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

Hi Jakub, hi David,

here is a feature/cleanup pull request of batman-adv to go into net-next.

Please pull or let me know of any problem!

Thank you,
      Simon

The following changes since commit b66e19dcf684b21b6d3a1844807bd1df97ad197a:

  Merge branch 'mctp-add-mctp-over-usb-hardware-transport-binding' (2025-02-21 16:45:26 -0800)

are available in the Git repository at:

  git://git.open-mesh.org/linux-merge.git tags/batadv-next-pullrequest-20250313

for you to fetch changes up to 7cfb32456ed82cd548114234ec275d57d4f7554e:

  batman-adv: add missing newlines for log macros (2025-02-23 11:18:36 +0100)

----------------------------------------------------------------
This feature/cleanup patchset includes the following patches:

 - bump version strings, by Simon Wunderlich

 - drop batadv_priv_debug_log struct, by Sven Eckelmann

 - adopt netdev_hold() / netdev_put(), by Eric Dumazet

 - add support for jumbo frames, by Sven Eckelmann

 - use consistent name for mesh interface, by Sven Eckelmann

 - cleanup B.A.T.M.A.N. IV OGM aggregation handling,
   by Sven Eckelmann (4 patches)

 - add missing newlines for log macros, by Sven Eckelmann

----------------------------------------------------------------
Eric Dumazet (1):
      batman-adv: adopt netdev_hold() / netdev_put()

Simon Wunderlich (1):
      batman-adv: Start new development cycle

Sven Eckelmann (8):
      batman-adv: Drop batadv_priv_debug_log struct
      batman-adv: Add support for jumbo frames
      batman-adv: Use consistent name for mesh interface
      batman-adv: Limit number of aggregated packets directly
      batman-adv: Switch to bitmap helper for aggregation handling
      batman-adv: Use actual packet count for aggregated packets
      batman-adv: Limit aggregation size to outgoing MTU
      batman-adv: add missing newlines for log macros

 Documentation/networking/batman-adv.rst            |   2 +-
 include/uapi/linux/batman_adv.h                    |  18 +-
 net/batman-adv/Makefile                            |   2 +-
 net/batman-adv/bat_algo.c                          |   8 +-
 net/batman-adv/bat_iv_ogm.c                        | 105 ++++++-----
 net/batman-adv/bat_v.c                             |  28 +--
 net/batman-adv/bat_v_elp.c                         |  16 +-
 net/batman-adv/bat_v_ogm.c                         |  42 ++---
 net/batman-adv/bitarray.c                          |   2 +-
 net/batman-adv/bridge_loop_avoidance.c             | 106 +++++------
 net/batman-adv/distributed-arp-table.c             |  68 +++----
 net/batman-adv/distributed-arp-table.h             |   4 +-
 net/batman-adv/fragmentation.c                     |   2 +-
 net/batman-adv/gateway_client.c                    |  38 ++--
 net/batman-adv/gateway_common.c                    |   8 +-
 net/batman-adv/hard-interface.c                    | 158 ++++++++--------
 net/batman-adv/hard-interface.h                    |  12 +-
 net/batman-adv/log.c                               |   2 +-
 net/batman-adv/log.h                               |  10 +-
 net/batman-adv/main.c                              |  42 ++---
 net/batman-adv/main.h                              |  24 +--
 .../{soft-interface.c => mesh-interface.c}         | 197 ++++++++++----------
 .../{soft-interface.h => mesh-interface.h}         |  22 +--
 net/batman-adv/multicast.c                         | 182 +++++++++----------
 net/batman-adv/multicast_forw.c                    |  30 ++--
 net/batman-adv/netlink.c                           | 180 +++++++++----------
 net/batman-adv/netlink.h                           |   2 +-
 net/batman-adv/network-coding.c                    |  64 +++----
 net/batman-adv/originator.c                        |  58 +++---
 net/batman-adv/routing.c                           |  42 ++---
 net/batman-adv/send.c                              |  36 ++--
 net/batman-adv/send.h                              |   4 +-
 net/batman-adv/tp_meter.c                          |  30 ++--
 net/batman-adv/trace.h                             |   2 +-
 net/batman-adv/translation-table.c                 | 198 ++++++++++-----------
 net/batman-adv/translation-table.h                 |   4 +-
 net/batman-adv/tvlv.c                              |  26 +--
 net/batman-adv/types.h                             |  78 +++-----
 38 files changed, 917 insertions(+), 935 deletions(-)
 rename net/batman-adv/{soft-interface.c => mesh-interface.c} (84%)
 rename net/batman-adv/{soft-interface.h => mesh-interface.h} (50%)
