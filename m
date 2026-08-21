Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74F10C5DF7D
	for <batman-adv@archiver.kernel.org>; Fri, 21 Aug 2026 09:48:29 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 9FAFF8125E
	for <batman-adv@archiver.kernel.org>; Fri, 21 Aug 2026 11:48:27 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1787305707;
 b=oYOeIPw+V3hX7Ju7Txa3BUAJI1gsbeA4ihK4RGQEeUoII0HhmnSEo3Sz+7rNflD/cLa1B
 6hYWl8PcdHCxnKFo5PkrKm15nC7XpzmWFTjlGV6syhmXI1h974RXc8GzX0q1IAmsq5b8JCa
 8xl+Wqpe24XW4d7bjk1kCdQq9Z1jGV0=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1787305707; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=qFhQ49oqhHKVO9Sa5p8UdYVng+tO6C+zzN+tt3FPwQA=;
 b=Wqj31cMKbvldrRGWyEdQ7lUPa9eLr7rOux1us36+693871QyWyO3IHqfvekUwqWhCUpZq
 MwZsZBGdabzPuk8WZ9cP4rIF5/9TQoILF7tyluDN7zW+GkdpM1OZB3sy99AeMFhP6WYKYTX
 DBMyRmWgt8Ss2As7Kz2ufzasFlGDwEc=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass header.from=simonwunderlich.de policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=simonwunderlich.de policy.dmarc=none
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id AFD988125E
	for <b.a.t.m.a.n@lists.open-mesh.org>; Fri, 21 Aug 2026 11:48:18 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1787305699;
	b=1MvmFqZSHMA891j3v9YrsTDx9havun7Fk2bJffH9np0Fqax4lsz3CHRhHZ6opqK4G9zheU
	l9+Ct0bWKoEQ0QPp27ZL7OMJGjrFvvil1/b6SyNwHY/iiBKBcU4qFPBPt0hBf9zzYoJe28
	myyD4WiYrR1dZ4Y52MHEpW9QZgx0gw4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1787305699;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:dkim-signature;
	bh=qFhQ49oqhHKVO9Sa5p8UdYVng+tO6C+zzN+tt3FPwQA=;
	b=TQC49UXPMTRLsacOsb6rf53ddoDdF5Torrjz4z2lqBKZryg8wul/mFIXkiWrbYKJ2KoA/G
	n4fiJ5ifPdDquV7j8D3XYQbmrIbb++nBA0aVxFyvGlzsHvTH+iGHHp1EIq0iPr3CFdha1Z
	W5pnUbhGCFcrnWP8yfZd8f6L/A0fwCQ=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=simonwunderlich.de header.s=09092022 header.b="o/3GB6rh";
	spf=pass (diktynna.open-mesh.org: domain of sw@simonwunderlich.de designates
 23.88.38.48 as permitted sender) smtp.mailfrom=sw@simonwunderlich.de;
	dmarc=pass (policy=none) header.from=simonwunderlich.de
Received: from kero.packetmixer.de
 (p200300c59714fCD8ec8C87C354003FEd.dip0.t-ipconnect.de
 [IPv6:2003:c5:9714:fcd8:ec8c:87c3:5400:3fed])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by mail.simonwunderlich.de (Postfix) with UTF8SMTPSA id ACA8EFA006;
	Fri, 21 Aug 2026 11:48:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1787305697;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=qFhQ49oqhHKVO9Sa5p8UdYVng+tO6C+zzN+tt3FPwQA=;
	b=o/3GB6rhFAJhCHw/3Hn+Bv7vV9jHgy2IztXBWrmcOgCPkjMFB/O4GLuDh9XkcD8ctF5uHo
	Ko4Xvw67GCzHPktF407dLNVASo+uxP5HyFftIlJ9pzebyRSP26dXghFTR0kK9eJlbEJNCM
	7EeprSMnU9Cj17F6OiQuCqWwt7S44l+uV1OrW8yPsy4XDNTJ4UKC6jXR/K0gsIOQh/frYd
	xfK2p0C4Tqq8q/0eGUeCxLb3bayWp48N1q1eO3asRmRzDI7rQ08rrypUHDYQJ3Wc2Lx37C
	rYcKgbPd/RGhbHdU57t7r71wL/HNMRxenV+gUjMG1ZjbDuOEFgQOVxo8GU2Vng==
From: Simon Wunderlich <sw@simonwunderlich.de>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	b.a.t.m.a.n@lists.open-mesh.org,
	Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH net 0/9] pull request: batman-adv 2026-08-21
Date: Fri, 21 Aug 2026 11:48:04 +0200
Message-ID: <20260821094813.201800-1-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: RYTPM2NENSYVH67DKRUEZOH2XVNVGEZY
X-Message-ID-Hash: RYTPM2NENSYVH67DKRUEZOH2XVNVGEZY
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/RYTPM2NENSYVH67DKRUEZOH2XVNVGEZY/>
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

The following changes since commit 02aee8ebea3a714d92b27da9a9d8791d8c8c9a4f:

  batman-adv: remove negative returns for batadv_send_skb_unicast (2026-08-05 10:00:16 +0200)

are available in the Git repository at:

  https://git.open-mesh.org/batadv.git tags/batadv-net-pullrequest-20260821

for you to fetch changes up to 8d128c932bced74e3b1625ba3d7c78ef122a88a7:

  batman-adv: bla: fix freeing of claims on meshif deletion (2026-08-05 10:23:09 +0200)

----------------------------------------------------------------
Here are a few batman-adv bugfixes:

 - fix stale receive device on merged fragments, by Zhiling Zou

the others are written by Sven Eckelmann:

 - bla: fix potential CRC corruption issues (2 patches)

 - dat: avoid unaligned fault in IP extraction

 - dat: atomically update mac addresses

 - mcast: fix TX priority extraction for BATADV_FORW_MCAST

 - mcast: fix skb sharing and linearization (2 patches)

 - bla: fix freeing of claims on meshif deletion

----------------------------------------------------------------
Sven Eckelmann (8):
      batman-adv: bla: avoid CRC corruption due to parallel claim add
      batman-adv: bla: prevent CRC corruptions after claim flush
      batman-adv: dat: avoid unaligned fault in IP extraction
      batman-adv: dat: atomically update mac addresses
      batman-adv: fix TX priority extraction for BATADV_FORW_MCAST
      batman-adv: mcast: ensure unshared skb for multicast packets
      batman-adv: mcast: linearize skbuff for packet generation
      batman-adv: bla: fix freeing of claims on meshif deletion

Zhiling Zou (1):
      batman-adv: fix stale receive device on merged fragments

 net/batman-adv/bridge_loop_avoidance.c | 78 +++++++++++++++++-----------------
 net/batman-adv/distributed-arp-table.c | 66 +++++++++++++++++++---------
 net/batman-adv/main.c                  |  4 ++
 net/batman-adv/mesh-interface.c        |  7 ++-
 net/batman-adv/multicast_forw.c        |  7 ++-
 net/batman-adv/types.h                 |  2 +-
 6 files changed, 100 insertions(+), 64 deletions(-)
