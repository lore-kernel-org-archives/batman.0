Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E0A8606A32E
	for <batman@archiver.kernel.org>; Wed, 11 Nov 2026 10:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=simonwunderlich.de header.i=@simonwunderlich.de header.a=rsa-sha256 header.s=09092022 header.b=BCqBGyo6
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id D9440802E6
	for <batman@archiver.kernel.org>; Wed, 11 Nov 2026 11:28:08 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1794392888;
 b=JMsK01phzahvkBtJ0tW9auD22xlYvG1LsirDMLNPTYA6ptqpA9CujbYEte7VBgnsJpwJp
 lLuksP8PgqJtciwSE209QfNecTB92Pnffsc3JU9g6nJlDtIpmhJxuMqER1ylvxxODWoLo/a
 BaoIzQPRuP5bc3YG7YC8wFCaA+7dZ+I=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1794392888; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=9zDl0MYB7shvzk9kMl26C8GZ3AJOuHtU2CyfGNendrY=;
 b=bkQeJAmIcFF6oadAOtw7+MiMgeAG1eBdHOMx7ckR4I8uShbT4YCvCdw+3ZKUPzDRLuuao
 RyO5cKyl+/aUPMNRzSBPyIqM1G+MEg3KPHhPNpIinBbno6z489Yyj4omYYraukZXJP9sgPk
 v3rK/e9FpnaGIwBq2jMpfHLV8mSTq7g=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass header.from=simonwunderlich.de policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=simonwunderlich.de policy.dmarc=none
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id C0D6480984
	for <b.a.t.m.a.n@lists.open-mesh.org>; Wed, 11 Nov 2026 11:27:32 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1794392862;
	b=SjNOiWByWxE5pKlOnUTxVMfGjbvkaOU+eBkvc7Don0zsKt2SWkQbF5LHE5gpsdgcKsbEFd
	57LWV4jEk9L3TR+J39g5ISFZYe+uS6YO1XXxKv6ihJrwxtjdrxZkg1IN8BGpfTULOsiccd
	8xipMxKCHc7o2ncKu4qKSZFiM4I57/M=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1794392862;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:dkim-signature;
	bh=9zDl0MYB7shvzk9kMl26C8GZ3AJOuHtU2CyfGNendrY=;
	b=lidKIXD/ZgyVRMZVB9Q9/X5ZvG3mSNlUZctKYe+j8fYWBzsFImb0RXW1YmsffE9giMfzWp
	oIOtt5kNqD9VmyNFzUGhhfN4M0Xvylc5eOpEzho/HW/uEtWm6Jb1Fv+VnAgY8SySwGqFq4
	l8YFNawMV+cV2qqMxilVEpZg8u5FhmM=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=simonwunderlich.de header.s=09092022 header.b=BCqBGyo6;
	spf=pass (diktynna.open-mesh.org: domain of sw@simonwunderlich.de designates
 23.88.38.48 as permitted sender) smtp.mailfrom=sw@simonwunderlich.de;
	dmarc=pass (policy=none) header.from=simonwunderlich.de
Received: from kero.packetmixer.de
 (p200300C59740ded843Be7e4a980e9C65.dip0.t-ipconnect.de
 [IPv6:2003:c5:9740:ded8:43be:7e4a:980e:9c65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by mail.simonwunderlich.de (Postfix) with UTF8SMTPSA id 0D5CAFA0B2;
	Wed, 11 Nov 2026 11:27:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1794392851;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=9zDl0MYB7shvzk9kMl26C8GZ3AJOuHtU2CyfGNendrY=;
	b=BCqBGyo69nMId0eBy5Bw+r4uziUIL5lbxHM8MBaJGIxAw4NglIPDOvTb4DuOg21dO7NigJ
	RkYGx8R5wWpqlrBx2YTyUEf04eYBXz9lvOjn4BEeesZo9PraxG2OWTYo3IesEAiVHuFv+w
	HHulqKhdSejJWnonZ14MDeeOqU6tu3oWBsKgKEkUbnw9B3EfLVhR1SuJNg0/tVwMu4sfQ6
	5AWn3PFazdlf0N+bEk922T8IFY+QxguY54gKQ30EXSqfEgEVfTnl/7qCkCfjd2pOH/0qtO
	Qwd/WjK+wU1aLIGaTscgsnbAQjGFwDR3GEcMsNNJy58iu0pwujnrznbiCnA+yQ==
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
 2026-11-11
Date: Wed, 11 Nov 2026 11:27:14 +0100
Message-ID: <20261111102729.2096241-1-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.47.3
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Message-ID-Hash: VADIGXVZRKUMGQ5RBKT3E32CBI4SQBFQ
X-Message-ID-Hash: VADIGXVZRKUMGQ5RBKT3E32CBI4SQBFQ
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/VADIGXVZRKUMGQ5RBKT3E32CBI4SQBFQ/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
X-Spam-Status: No, score=-23.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_NONE,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Dear net maintainers,

here is a cleanup pull request of batman-adv to go into net-next.

Please pull or let me know of any problem!

Thank you,
      Simon

The following changes since commit a137095419b4be0b204a11af4f1cea872ea262e9:

  batman-adv: tt: limit local table to single TVLV response size (2026-10-30 10:11:27 +0100)

are available in the Git repository at:

  https://git.open-mesh.org/batadv.git tags/batadv-next-pullrequest-20261111

for you to fetch changes up to d5c0415dfb58b646696292a7af3d084200933f84:

  batman-adv: mcast: document the value stored in is_routable (2026-10-31 23:04:11 +0100)

----------------------------------------------------------------
This cleanup patchset includes the following patches:

- mcast: explicitly initialize mcast.*_want_all_rtr{4,6),
  by Sven Eckelmann (2 patches)

- uapi: add note/clarification on access of reserved bytes/bits,
  by Linus Lüssing

The remaining patches are authored by Sven Eckelmann:

- avoid torn u64 counter reads on 32-bit systems

- bat_v: initialize last_unicast_tx on neighbor creation

- anotate various timestamps with READ/WRITE_ONCE (6 patches)

- use matching return types for bool and void functions

- mark read-only MAC address parameters as const

- use bool for boolean flags

- mcast: document the value stored in is_routable

----------------------------------------------------------------
Linus Lüssing (1):
      batman-adv: uapi: add note/clarification on access of reserved bytes/bits

Sven Eckelmann (14):
      batman-adv: mcast: explicitly initialize mcast.num_want_all_rtr{4,6)
      batman-adv: mcast: explicitly initialize mcast.want_all_rtr{4,6}_list
      batman-adv: avoid torn u64 counter reads on 32-bit systems
      batman-adv: bat_v: initialize last_unicast_tx on neighbor creation
      batman-adv: dat: annotate last_update with READ/WRITE_ONCE
      batman-adv: bla: avoid negative reported BATADV_ATTR_LAST_SEEN_MSECS
      batman-adv: tt: annotate last_seen with READ/WRITE_ONCE
      batman-adv: annotate originator last_seen with READ/WRITE_ONCE
      batman-adv: annotate neigh_node last_seen with READ/WRITE_ONCE
      batman-adv: annotate hardif_neigh_node last_seen with READ/WRITE_ONCE
      batman-adv: use matching return types for bool and void functions
      batman-adv: mark read-only MAC address parameters as const
      batman-adv: use bool for boolean flags
      batman-adv: mcast: document the value stored in is_routable

 include/uapi/linux/batadv_packet.h     | 28 +++++++++++++++---------
 net/batman-adv/bat_iv_ogm.c            | 34 ++++++++++++++++-------------
 net/batman-adv/bat_v.c                 |  9 ++++++--
 net/batman-adv/bat_v_elp.c             |  8 ++++---
 net/batman-adv/bat_v_ogm.c             |  7 +++---
 net/batman-adv/bridge_loop_avoidance.c | 21 ++++++++++--------
 net/batman-adv/bridge_loop_avoidance.h | 11 +++++-----
 net/batman-adv/distributed-arp-table.c | 19 +++++++++-------
 net/batman-adv/distributed-arp-table.h |  3 +--
 net/batman-adv/hard-interface.c        |  2 +-
 net/batman-adv/hard-interface.h        |  2 +-
 net/batman-adv/main.c                  |  2 ++
 net/batman-adv/main.h                  | 15 +++++++++++--
 net/batman-adv/mesh-interface.c        | 25 +++++++++++++++++----
 net/batman-adv/multicast.c             | 18 +++++++++------
 net/batman-adv/multicast.h             |  3 +--
 net/batman-adv/multicast_forw.c        | 27 +++++++++++++----------
 net/batman-adv/originator.c            | 16 ++++++++------
 net/batman-adv/originator.h            |  2 +-
 net/batman-adv/routing.c               |  4 ++--
 net/batman-adv/translation-table.c     | 40 +++++++++++++++++++---------------
 net/batman-adv/translation-table.h     |  8 +++----
 net/batman-adv/types.h                 | 23 ++++++++++++++-----
 23 files changed, 204 insertions(+), 123 deletions(-)
