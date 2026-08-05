Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDA3BC55174
	for <batman-adv@archiver.kernel.org>; Wed,  5 Aug 2026 14:35:13 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id EF99F8413A
	for <batman-adv@archiver.kernel.org>; Wed, 05 Aug 2026 16:35:11 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1785940511;
 b=AllWUKeOZMc2kWVtAjPd9M7XDH7oiXNGxBcXDY5payWgabsIpAFGeOyPWT/z71g3t8ymm
 +IBrP18QBLY015ACIVUvOrycYo9q/34fn82cAxZ7Uw8ye8LaCK+kYSXX91zDLVRAHl3HlzD
 dl6UNFBaZbxKxXtQ/Nj+bteENIQbYQc=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1785940511; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=9uzEweOhEpBINPGk4fnNm5R3TblxhZJTHxrpnEQqsi4=;
 b=Yxl05XUqwuofFFj1L/iRVVcYMgX/VNwF9mnGJPB63KyqGjmgjPLR981elwCmumwIGdV05
 DGcpmCLXR0a4anMxKr6tT0/mZb8sUvM9EtPeFy/SKdwu/YcwG26Qkgu4KCYjjnP7nBnmm/U
 91dXmutST3syrbg6wCLbMJxoBnbx+fY=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass header.from=simonwunderlich.de policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=simonwunderlich.de policy.dmarc=none
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de
 [IPv6:2a01:4f8:c17:e8c0::1])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id B2EB9841D5
	for <b.a.t.m.a.n@lists.open-mesh.org>; Wed, 05 Aug 2026 16:32:10 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1785940330;
	b=AvIehJ6kxqosJuPr51SUZSFW5MmeTDou7nJIn3HenzIzoT8Lngl9JPsoHBYmfhRWeGgV1H
	IOrLGYplmeDVdLn4sfCs5B7t85lC0EZN7ty/ihjgiU4LMBDYNbHx0V0nfGFGJo1cXl+u4A
	w+nLV99EnGBmKn8VdgkVKSQizAtsIKM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1785940330;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:dkim-signature;
	bh=9uzEweOhEpBINPGk4fnNm5R3TblxhZJTHxrpnEQqsi4=;
	b=exVysTTDd8ml4zqlct1/bTgAEdJhiblMv29fmaDDz8nlNixuSiISX1qgoJY4gePmK7259B
	/3kuiWbUKeo0d1OduEe9ssY3Ruil03KMWvnpSIPRqUZ+HkFVsWwG0rTjzqV117ACNz/nem
	/hfPo+WmlInBPm7eatNH03S9wf11Fnc=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=simonwunderlich.de header.s=09092022 header.b=wQYuQwJy;
	spf=pass (diktynna.open-mesh.org: domain of sw@simonwunderlich.de designates
 2a01:4f8:c17:e8c0::1 as permitted sender)
 smtp.mailfrom=sw@simonwunderlich.de;
	dmarc=pass (policy=none) header.from=simonwunderlich.de
Received: from kero.packetmixer.de
 (p200300C5970B56D88eEBAC4310D100aa.dip0.t-ipconnect.de
 [IPv6:2003:c5:970b:56d8:8eeb:ac43:10d1:aa])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by mail.simonwunderlich.de (Postfix) with ESMTPSA id 10559FA1BF;
	Wed, 05 Aug 2026 16:32:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1785940325;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=9uzEweOhEpBINPGk4fnNm5R3TblxhZJTHxrpnEQqsi4=;
	b=wQYuQwJyCrMKxv6tibmy/71pITO7sBIwwd48/cL+kpQjVDZMamHBHA4gYvdD+m4Ei0iG0a
	/a7mWcqgtLN0lJYWDNfp+cyBJ1pmgCI4onAEDkrFB+QFUJIDW3v/E4+ntEggmJHBQ6jyqU
	Q8KZxfPg+0BX7CNWLoe4twZQqFkGZzjJkdGS+Q7UuleLlRKq3REviBqPGe7cvGKEKhdhAA
	fJk+Vas3B0S+SGV9ahe17dit+wR4TJ1n3OZ9av/mGlSKzP+rdi/2efQx9WU8UERJ7mNe7A
	b2B/a1iH1b+/Ms2LkbhsrzoeYAvnImaCnkwMviC1YYTXYXaCP88K/lV767Cg5g==
From: Simon Wunderlich <sw@simonwunderlich.de>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	b.a.t.m.a.n@lists.open-mesh.org,
	Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH net-next 00/10] pull request for net-next: batman-adv
 2026-08-05
Date: Wed,  5 Aug 2026 16:27:14 +0200
Message-ID: <20260805143200.722098-1-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: EEMRGLDYFKCA3IBY7NZ5FVKTJVDMA5NR
X-Message-ID-Hash: EEMRGLDYFKCA3IBY7NZ5FVKTJVDMA5NR
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/EEMRGLDYFKCA3IBY7NZ5FVKTJVDMA5NR/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

Dear net maintainers,

here is a cleanup pull request of batman-adv to go into net-next. It
replaces my previous pull request as of 2026-07-28 [1]. We're including
only cleanups patches of the previous pull request - some of them revised
- plus some new cleanup patches. We've dropped the fix patches from the
previous pull request and will submit those separately, later.

Please pull or let me know of any problem!

Thank you,
      Simon

[1] https://lore.kernel.org/netdev/20260728133918.643267-1-sw@simonwunderlich.de/

The following changes since commit b470fde8f77b56ff273c5527484b99499b894e16:

  Merge git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net (2026-07-10 10:20:05 +0200)

are available in the Git repository at:

  https://git.open-mesh.org/batadv.git tags/batadv-next-pullrequest-20260805

for you to fetch changes up to 02aee8ebea3a714d92b27da9a9d8791d8c8c9a4f:

  batman-adv: remove negative returns for batadv_send_skb_unicast (2026-08-05 10:00:16 +0200)

----------------------------------------------------------------
This cleanup patchset includes the following patches:

 - dat: drop non-4addr backwards compatibility, by Sven Eckelmann

 - tvlv: handle negative tvlv processing return codes,
   by Sven Eckelmann

 - improve kernel-doc, add comments and warnings,
   by Sven Eckelmann (3 patches)

 - coding style: split declarations, reverse x-mas tree,
   by Sven Eckelmann (2 patches)

 - handle errors in batadv_init(), by Minhong He

 - correct NET_RX_* NET_XMIT_* confusion, by Sven Eckelmann

 - remove negative returns for batadv_send_skb_unicast,
   by Sven Eckelmann

----------------------------------------------------------------
Minhong He (1):
      batman-adv: handle errors in batadv_init()

Sven Eckelmann (9):
      batman-adv: dat: drop non-4addr backwards compatibility
      batman-adv: tvlv: handle negative tvlv processing return codes
      batman-adv: add missing kernel-doc comments
      batman-adv: fix kernel-doc for functions holding skb ownership
      batman-adv: annotate functions which may reallocate the skbuff
      batman-adv: split multiple declarations per line
      batman-adv: switch var declarations to reverse x-mas tree order
      batman-adv: correct NET_RX_* NET_XMIT_* confusion
      batman-adv: remove negative returns for batadv_send_skb_unicast

 include/uapi/linux/batadv_packet.h     |  16 +-
 net/batman-adv/bat_algo.c              |  16 +-
 net/batman-adv/bat_iv_ogm.c            | 311 ++++++++++++++++++++------
 net/batman-adv/bat_iv_ogm.h            |   1 +
 net/batman-adv/bat_v.c                 |  96 +++++++--
 net/batman-adv/bat_v.h                 |   5 +
 net/batman-adv/bat_v_elp.c             |  19 +-
 net/batman-adv/bat_v_ogm.c             |  34 +--
 net/batman-adv/bitarray.c              |   9 +-
 net/batman-adv/bridge_loop_avoidance.c | 109 ++++++----
 net/batman-adv/distributed-arp-table.c | 239 ++++++++++++++------
 net/batman-adv/fragmentation.c         |  35 +--
 net/batman-adv/gateway_client.c        |  46 ++--
 net/batman-adv/gateway_common.c        |   6 +-
 net/batman-adv/hard-interface.c        |  94 +++++++-
 net/batman-adv/hash.c                  |   5 +-
 net/batman-adv/hash.h                  |  42 ++--
 net/batman-adv/log.h                   |  16 +-
 net/batman-adv/main.c                  | 104 +++++++--
 net/batman-adv/mesh-interface.c        | 109 ++++++++--
 net/batman-adv/multicast.c             |  43 ++--
 net/batman-adv/multicast_forw.c        |  26 ++-
 net/batman-adv/netlink.c               |  20 +-
 net/batman-adv/netlink.h               |   2 +-
 net/batman-adv/originator.c            |  64 +++---
 net/batman-adv/routing.c               | 121 ++++++++---
 net/batman-adv/send.c                  |  13 +-
 net/batman-adv/tp_meter.c              |  41 ++--
 net/batman-adv/translation-table.c     | 383 +++++++++++++++++++++++++--------
 net/batman-adv/tvlv.c                  |  46 ++--
 net/batman-adv/types.h                 |   4 +-
 31 files changed, 1541 insertions(+), 534 deletions(-)
