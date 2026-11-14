Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9A1E606A334
	for <batman@archiver.kernel.org>; Sat, 14 Nov 2026 09:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=simonwunderlich.de header.i=@simonwunderlich.de header.a=rsa-sha256 header.s=09092022 header.b=T4go6vgD
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 656D184861
	for <batman@archiver.kernel.org>; Sat, 14 Nov 2026 10:16:35 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1794647795;
 b=f+1uxjW+Vd3iq2lknDtQHXYN/g4LNsOPLjcYcU2HVnODgzvGKx1YzjGv5lz+d0jCbnXAA
 tM3olUHGTbYZo7uBth1qE5+zbDzwdktcFwC2+BFTwHghsnZMPstnIAd/3Y6RkPZPhaPiLq9
 8ZYxVCF8WvuUR3vLDIv5mmLKe+um4n8=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1794647795; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=8rVR2pfADRlgq70ZT1O0ahhdqRFAWPhCLjcwG3mDrpQ=;
 b=jRq8Sv4D/Y0RuTRM6WprrJuWJ9Vx8QrYifZLqaS8ELS9BGmqabw2VmSK80aZgm5/WRS1S
 aqkeWKHckCVXS+4Y28xuigQYR8fx6YT+vCefHw+xF7zuRaDlRjP+PcoK7uGyAWDQyqn/+Vc
 1rN8PkxLOuj0IumNcXs9W6khWrgb2b4=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass header.from=simonwunderlich.de policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=simonwunderlich.de policy.dmarc=none
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id A40A083BE1
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sat, 14 Nov 2026 10:15:59 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1794647770;
	b=xFm9Dyk2tOk7gjqVQavakp3cdwPU3Y/mP31OlnPmx1uHtFp8Im4D4b4Ni4K2e4PsBbmAJw
	imBRMCJxb0nXsUMwa8dRu/sJ/F9D4nMsrIICvrTM8oal97FWVWMexxfOsGUiBnb8kRECor
	qk7iNAzFxhqm1QpJLHHUzWoAd3SWB3w=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1794647770;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:dkim-signature;
	bh=8rVR2pfADRlgq70ZT1O0ahhdqRFAWPhCLjcwG3mDrpQ=;
	b=jS4jJwP7rejra4kmJ5ZcFyYpY8AQLrFUikpTm1XMY1VYIqv97B2qz5dj/Pno+rXSL3NFYw
	Vc/1GrHLuvUgQmhmpfCL8Kl3Kqm9AuBR+4gjR4IW9/Pre9rQIlYc50Br6uAD4Uu0gS/NA9
	S4BB0Q3UCvElNPYz2d9x/LNk4DtcIHU=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=simonwunderlich.de header.s=09092022 header.b=T4go6vgD;
	spf=pass (diktynna.open-mesh.org: domain of sw@simonwunderlich.de designates
 23.88.38.48 as permitted sender) smtp.mailfrom=sw@simonwunderlich.de;
	dmarc=pass (policy=none) header.from=simonwunderlich.de
Received: from kero.packetmixer.de (unknown
 [IPv6:2a02:3037:6ed:dd6c:838:344b:3152:2d5e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by mail.simonwunderlich.de (Postfix) with UTF8SMTPSA id 1962AFA039;
	Sat, 14 Nov 2026 10:15:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1794647758;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=8rVR2pfADRlgq70ZT1O0ahhdqRFAWPhCLjcwG3mDrpQ=;
	b=T4go6vgDBFWAAJ3xBilyOc3Cwt+O0E0Xtnv/5WnmDZecU/oSLwVpIIhpwtkHKVQxvLvwpx
	dH4ofneexeDeiqz9ZO4ySpQlwzZWxcdMRt7pJTvyC8fjjMnJFiUmsW6K8kfXF4sTawoygj
	7woPEmOJlpcEA+7Z4A3LGwt0Pd5ghPTVmU+8OOOOGoU4ly7Dx1uN5Th6tPBzIcLbLPToXQ
	OHzl/dT7gM+lbEjQ2G2boXqdUEikb6At2kfTahisrEVynlZczh9yLvCfw+h+wiSXKO8we1
	uXnYDVXwzSfi1P5gsAuqOXq6gQB9414OFwnOSPvp+SaCTkSNZ1yIH/6czNsMlw==
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
 2026-11-14
Date: Sat, 14 Nov 2026 10:15:41 +0100
Message-ID: <20261114091556.3336038-1-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.47.3
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: FOPXYDTMF2LS5J4E4LJRSVVQKXGYG6B4
X-Message-ID-Hash: FOPXYDTMF2LS5J4E4LJRSVVQKXGYG6B4
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/FOPXYDTMF2LS5J4E4LJRSVVQKXGYG6B4/>
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

here is another cleanup pull request of batman-adv to go into net-next.

Please pull or let me know of any problem!

Thank you,
      Simon

The following changes since commit d5c0415dfb58b646696292a7af3d084200933f84:

  batman-adv: mcast: document the value stored in is_routable (2026-10-31 23:04:11 +0100)

are available in the Git repository at:

  https://git.open-mesh.org/batadv.git tags/batadv-next-pullrequest-20261114

for you to fetch changes up to e2c4b4b08e96e8ada2674ce26ff9e4abc33897bb:

  batman-adv: annotate functions returning objects with __must_check (2026-11-01 18:13:10 +0100)

----------------------------------------------------------------
This cleanup patchset includes the following patches, all by
Sven Eckelmann:

- use dedicated key types for various hashes (4 patches)

- pass explicit key and update documentation (2 patches)

- consolidate skb consumption (4 patches)

- increase hash generation when purging entries (4 patches)

- annotate functions returning objects with __must_check

----------------------------------------------------------------
Sven Eckelmann (15):
      batman-adv: bla: use dedicated key type for claim hash
      batman-adv: bla: use dedicated key type for backbone gateway hash
      batman-adv: dat: use dedicated key type for DAT hash
      batman-adv: tt: use dedicated key type for hashes
      batman-adv: originator: pass explicit key to orig_hash
      batman-adv: hash: document key argument of hash operations
      batman-adv: never consume skb in BLA rx and DAT incoming snooping
      batman-adv: always consume skb in batadv_forw_packet_alloc()
      batman-adv: split fragment forwarding into lookup and forward
      batman-adv: document skb ownership of always-consuming functions
      batman-adv: tt: increase hash generation when purging clients
      batman-adv: dat: increase hash generation when purging entries
      batman-adv: bla: increase hash generation when purging entries
      batman-adv: increase orig hash generation when purging originators
      batman-adv: annotate functions returning objects with __must_check

 net/batman-adv/bat_iv_ogm.c            |  14 +--
 net/batman-adv/bat_v.c                 |   2 +-
 net/batman-adv/bat_v_elp.c             |   6 +-
 net/batman-adv/bat_v_ogm.c             |   2 +-
 net/batman-adv/bat_v_ogm.h             |   4 +-
 net/batman-adv/bridge_loop_avoidance.c | 224 +++++++++++++++++----------------
 net/batman-adv/distributed-arp-table.c |  90 +++++++------
 net/batman-adv/fragmentation.c         | 111 ++++++++--------
 net/batman-adv/fragmentation.h         |   9 +-
 net/batman-adv/gateway_client.h        |   9 +-
 net/batman-adv/hard-interface.c        |   2 +-
 net/batman-adv/hard-interface.h        |  10 +-
 net/batman-adv/hash.h                  |  15 ++-
 net/batman-adv/mesh-interface.c        |   6 +-
 net/batman-adv/mesh-interface.h        |   4 +-
 net/batman-adv/multicast.c             |   3 +-
 net/batman-adv/netlink.c               |  10 +-
 net/batman-adv/netlink.h               |   5 +-
 net/batman-adv/originator.c            |  31 ++---
 net/batman-adv/originator.h            |  28 ++---
 net/batman-adv/routing.c               |  33 +++--
 net/batman-adv/routing.h               |   2 +-
 net/batman-adv/send.c                  |  31 +++--
 net/batman-adv/send.h                  |   2 +-
 net/batman-adv/tp_meter.c              |   8 +-
 net/batman-adv/translation-table.c     | 190 ++++++++++++++--------------
 net/batman-adv/translation-table.h     |   9 +-
 net/batman-adv/tvlv.c                  |   4 +-
 net/batman-adv/types.h                 |  57 +++++++--
 29 files changed, 498 insertions(+), 423 deletions(-)
