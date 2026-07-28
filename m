Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62BDDC54F4C
	for <batman@archiver.kernel.org>; Tue, 28 Jul 2026 13:39:25 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id C836084656
	for <batman@archiver.kernel.org>; Tue, 28 Jul 2026 15:39:23 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1785245963;
 b=FQO0osGa/WrZHd0IsEdTmiu92Sglm7QJos/sW4j1OFe1zcfV2ptc1Z0RPwSM2odB6zp0a
 h2VlNsUQqULDd9ZFICTaEl0SUGtsGjYGYdHUZULGtRHaT+OgKmtbhy4gA4F7CdhuiArW0rx
 5mNhMEiBd34QxmUlGDRrxL8JwF19MI4=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1785245963; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=qqEllnaONuEr6tIT/DHGIGAHgfo9X/1/a0Y4WPVoQWw=;
 b=sB86fqgAW9Gr8VjYlMLZjKoFk0kjeAWqM71KX/pPCNa8SMrXhgdd4W8SDYxXojehrTxyA
 aR728KHLILZYl6VIQvf+1cm1/yVlweHNE0yJ6hLmNFDLnadstbDwoXc4oQX3zxqS2BtSlZk
 Lur0KOAp2SQWHsQ7ASAhZPvYAkH+HSk=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass header.from=simonwunderlich.de policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=simonwunderlich.de policy.dmarc=none
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id EEDBC8460D
	for <b.a.t.m.a.n@lists.open-mesh.org>; Tue, 28 Jul 2026 15:39:19 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1785245960;
	b=kDgnxkWx8yh4JgmcWBggHNEXGGuPNUBs/uKlqB8VmJSi6/XpOprjwZ0CsKY7O+7yIE6tg9
	cCH7dJr3splvJVZCCAIbNSH1amHcYV1bZN7CZX0XYMd82KqVwbfxP/oIzFioYfjCAMFCwp
	BHQWOanQJDbbrBumJ/HuQA3Y+4detNE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1785245960;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:dkim-signature;
	bh=qqEllnaONuEr6tIT/DHGIGAHgfo9X/1/a0Y4WPVoQWw=;
	b=rrMamdWAtKpU/SSnZBJ9yX2GXVW9LbC1oSMKEN3xNtAUNlg0QKFukdUoh/yPy0XWROK9a5
	1j3g8IsRsC+Dsv636rTYAUXoq39A4SnrnfByP+54h0G2UJODTtLk3mZ0brFVfRYmElw+2n
	7BSiNqYuOCKrUQ85sc/TIo1H9RFYF/Y=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=simonwunderlich.de header.s=09092022 header.b=nj5ChFge;
	spf=pass (diktynna.open-mesh.org: domain of sw@simonwunderlich.de designates
 23.88.38.48 as permitted sender) smtp.mailfrom=sw@simonwunderlich.de;
	dmarc=pass (policy=none) header.from=simonwunderlich.de
Received: from kero.packetmixer.de
 (p200300c59717ead808f168C97E5563A8.dip0.t-ipconnect.de
 [IPv6:2003:c5:9717:ead8:8f1:68c9:7e55:63a8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by mail.simonwunderlich.de (Postfix) with ESMTPSA id 2E678FA006;
	Tue, 28 Jul 2026 15:39:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1785245959;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=qqEllnaONuEr6tIT/DHGIGAHgfo9X/1/a0Y4WPVoQWw=;
	b=nj5ChFgeo3TeTrBlDF04WUCh3MTpeneBBtLsb14gpsUSabPToEvjLUTkPoLAGaxcLtyEGk
	y1Kw1kJGiM/8PlVuqjy8HIKvvPtgqhKfap0CMsqxRIeoUmjoN76KcW7YwL6it8QUPq5Umd
	/vt5uiuCZaWDs/c5uo7t/OSn6oVNsk0h7vlNDbq5xgNKBtQHYWut4TdELNcU+2iZyMaeZ1
	6RwJumtv2KDTFSZD/hrhh1MyTYvKC2UHQK1xeMwYvh6xcBKUZOUbw45lEVeS4fQxqL+ZQF
	Y9bVCSsN4fVTQG4JWGM03GsfWCA/ns2T8xSIj75+PMzR1UkG+s93sByk84cHvg==
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
 2026-07-28
Date: Tue, 28 Jul 2026 15:39:03 +0200
Message-ID: <20260728133918.643267-1-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: D33JAFYZ63VFPKYOPQPND4DYA2G2IFGI
X-Message-ID-Hash: D33JAFYZ63VFPKYOPQPND4DYA2G2IFGI
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/D33JAFYZ63VFPKYOPQPND4DYA2G2IFGI/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

Dear net maintainers,

here is a minor bugfix/cleanup pull request of batman-adv to go into net-next.

Please pull or let me know of any problem!

Thank you,
      Simon

The following changes since commit b470fde8f77b56ff273c5527484b99499b894e16:

  Merge git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net (2026-07-10 10:20:05 +0200)

are available in the Git repository at:

  https://git.open-mesh.org/batadv.git tags/batadv-next-pullrequest-20260728

for you to fetch changes up to 6af11807a9e1e9117bfe4865cc9b30935c339cf2:

  batman-adv: tt: simplify NEW flag transition code (2026-07-10 22:35:45 +0200)

----------------------------------------------------------------
This minor bugfix/cleanup patchset includes the following patches (all by Sven Eckelmann):

7 minor bugfix patches:

 - bla: fix potential CRC corruptions (2 patches)

 - dat: avoid unaligned fault in IP extraction

 - dat: atomically update mac addresses

 - mcast: ensure linearization, TX prio extraction and unshared skbs
   (3 patches)

8 cleanup patches:

 - dat: drop non-4addr backwards compatibility

 - improve kernel-doc, add comments and warnings (3 patches)

 - coding style: split declarations, reverse x-mas tree (2 patches)

 - tt: atomic flag modifications, simplify NEW flag transition (2 patches)

----------------------------------------------------------------
Sven Eckelmann (15):
      batman-adv: bla: avoid CRC corruption due to parallel claim add
      batman-adv: bla: prevent CRC corruptions after claim flush
      batman-adv: dat: avoid unaligned fault in IP extraction
      batman-adv: dat: atomically update mac addresses
      batman-adv: fix TX priority extraction for BATADV_FORW_MCAST
      batman-adv: mcast: ensure unshared skb for multicast packets
      batman-adv: mcast: linearize skbuff for packet generation
      batman-adv: dat: drop non-4addr backwards compatibility
      batman-adv: add missing kernel-doc comments
      batman-adv: fix kernel-doc for functions holding skb ownership
      batman-adv: annotate functions which may reallocate the skbuff
      batman-adv: split multiple declarations per line
      batman-adv: switch var declarations to reverse x-mas tree order
      batman-adv: tt: use atomic flag modifications
      batman-adv: tt: simplify NEW flag transition code

 include/uapi/linux/batadv_packet.h     |  16 +-
 net/batman-adv/bat_algo.c              |  16 +-
 net/batman-adv/bat_iv_ogm.c            | 303 ++++++++++++----
 net/batman-adv/bat_v.c                 |  87 ++++-
 net/batman-adv/bat_v_elp.c             |  19 +-
 net/batman-adv/bat_v_ogm.c             |  34 +-
 net/batman-adv/bitarray.c              |   9 +-
 net/batman-adv/bridge_loop_avoidance.c | 169 +++++----
 net/batman-adv/distributed-arp-table.c | 305 +++++++++++-----
 net/batman-adv/fragmentation.c         |  34 +-
 net/batman-adv/gateway_client.c        |  41 ++-
 net/batman-adv/gateway_common.c        |   6 +-
 net/batman-adv/hard-interface.c        |  94 ++++-
 net/batman-adv/hash.c                  |   5 +-
 net/batman-adv/hash.h                  |  42 ++-
 net/batman-adv/log.h                   |  16 +-
 net/batman-adv/main.c                  |  59 ++-
 net/batman-adv/mesh-interface.c        | 116 ++++--
 net/batman-adv/multicast.c             |  33 +-
 net/batman-adv/multicast_forw.c        |  33 +-
 net/batman-adv/netlink.c               |  14 +-
 net/batman-adv/originator.c            |  64 ++--
 net/batman-adv/routing.c               | 115 ++++--
 net/batman-adv/send.c                  |   7 +-
 net/batman-adv/tp_meter.c              |  41 ++-
 net/batman-adv/translation-table.c     | 637 +++++++++++++++++++++++----------
 net/batman-adv/tvlv.c                  |  24 +-
 net/batman-adv/types.h                 |   8 +-
 28 files changed, 1692 insertions(+), 655 deletions(-)
