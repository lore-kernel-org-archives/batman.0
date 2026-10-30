Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1628B60A260A
	for <batman@archiver.kernel.org>; Fri, 30 Oct 2026 13:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=simonwunderlich.de header.i=@simonwunderlich.de header.a=rsa-sha256 header.s=09092022 header.b=pZrA1Btw
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id A976C83C4D
	for <batman@archiver.kernel.org>; Fri, 30 Oct 2026 14:51:35 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1793368295;
 b=a5jorOp8h6vgSweLfsOlUvA6P2zQLhNqcnzYR6ETz0hx/sazq/yZmvG4wL36SxsYevD6m
 gPO1r+TTqjfsiLUPHtma36KzPtDwDsa4GVBRnUlZu/F17LrpYddH5IM8Z9Xub/bVJ5a6t1h
 YwijQpJCqcEoHw/6ZJuZpBwV9SxuYIc=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1793368295; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=ugFQ0SBkJarxj9YkqGiF/LsnDDkv17Ud8Nwf4UW/tek=;
 b=COVLNOV/slb2ybKD+hc4Sg6vLUPI2z+KT6h3eXRW9Dy2acmH5b9XyID/tomJ2u1PQdpEI
 DlqEpXOzBz0GjKzZ2s2jgmqgKxDvjXceVNKgbNVAOBwwGeWsafrbBwZ29xKsdQtpBr1DhtM
 ugKOA9Lv2J9DL2+R79OrpQl5NsvmeH4=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass header.from=simonwunderlich.de policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=simonwunderlich.de policy.dmarc=none
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 6CF3D80B7F
	for <b.a.t.m.a.n@lists.open-mesh.org>; Fri, 30 Oct 2026 14:51:09 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1793368279;
	b=hsUg3M8Dbo+kOxkP8qDTflf/BIwiUxnyr04MLczs44HBuea0eeWeYF5kAJT9NL/cC2RlED
	jKBUhoTnExV63I4jYSa6U7MAABc4ruYE3RAT2xcwKvWy5cuUJd/zzRO1EdsDQxnnkBTA6r
	+zTpC0oeJvrVUvd1wPzleIzp9hgjG9M=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1793368279;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:dkim-signature;
	bh=ugFQ0SBkJarxj9YkqGiF/LsnDDkv17Ud8Nwf4UW/tek=;
	b=VAqmJ8Thtucu6IDSe4YVroyH4rNXYAFw7AT/gI/XZkN7JZvVi91dDyMpVaxczgQI2uFBka
	qGSvVhUTxRk6GGj1IS1HEGi96zemA3hg3PeME7pLULdsUzOTL8Uz+v5Jz0QRlGbVHyjw9L
	bNNnpzep1ufNmINciYZLg3lbrO44FpI=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=simonwunderlich.de header.s=09092022 header.b=pZrA1Btw;
	spf=pass (diktynna.open-mesh.org: domain of sw@simonwunderlich.de designates
 23.88.38.48 as permitted sender) smtp.mailfrom=sw@simonwunderlich.de;
	dmarc=pass (policy=none) header.from=simonwunderlich.de
Received: from kero.packetmixer.de
 (p200300C597124Fd839580C360D3eD6F6.dip0.t-ipconnect.de
 [IPv6:2003:c5:9712:4fd8:3958:c36:d3e:d6f6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by mail.simonwunderlich.de (Postfix) with UTF8SMTPSA id D45C8FA006;
	Fri, 30 Oct 2026 14:51:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1793368267;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ugFQ0SBkJarxj9YkqGiF/LsnDDkv17Ud8Nwf4UW/tek=;
	b=pZrA1BtwQBygFStLVzQ0U+dZ3T8j/LjmwLvJD9uEGUY16JdAWlwbs5C4YrpibX1xUxYph8
	myJQu4dNprM6Ivc+XmNztE+DgKclcb+gr5Ol6kA9BEpfbdnVlPtU7zIHjgqOMl4MvybvTX
	7TK6tgnPrszlnZ9qZZYDZEJmpDODZX1l8IV4gaGcn+I08sdkpTdH8rtdo6M2qTkHttjDN8
	znUK5iLy+djDoRqHFa1rIx3dUsnrFSYkAVUCh+iYy16jcF6vDXyJV7dBqjpHFQSmGvuGRE
	mqTIkq8+OGjd/zKG7cbvIpgcy+idVMrKoR3ijPPeZnuCPVfbX5VZkiNjYbg8TQ==
From: Simon Wunderlich <sw@simonwunderlich.de>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	b.a.t.m.a.n@lists.open-mesh.org,
	Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH net 00/14] pull request: batman-adv 2026-10-30
Date: Fri, 30 Oct 2026 14:50:51 +0100
Message-ID: <20261030135105.2555887-1-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.47.3
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Message-ID-Hash: IQTGVM4AK4YSJL746FMBUAOBWSCMLFU2
X-Message-ID-Hash: IQTGVM4AK4YSJL746FMBUAOBWSCMLFU2
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/IQTGVM4AK4YSJL746FMBUAOBWSCMLFU2/>
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

here is a bugfix pull request of batman-adv to go into net. This
pull request supersedes batadv-net-pullrequest-20261026 [1]. The
following changes were made (I marked the changed patches with v2):

* "Close OGM aggregation": dropped the Assisted-by tag and documented
  the new meaning of num_packets

* "tt: only transmit local ROAM flag together with DEL": clarified the
  commit message and noted that batadv_tt_global_purge_local() is not
  addressed

* "tt: only update flags for TT events": corrected the Fixes tag

* "tt: don't drop local events queued during TVLV update": moved the
  atomic snapshot of the changes into
  batadv_tt_local_commit_changes_nolock() so the TTVN decision covers
  the same events. If the TVLV allocation fails, the last changeset is
  now dropped only when the TTVN was incremented

* "tt: limit local table to single TVLV response size": Fixes now
  points to the original commit, and the patch is marked
  stable+noautosel because it is relevant mostly for the over-allocation
  fix 85fb027f611b

* new (patches were queued for later but Sashiko complained about
  problems which would be solved by them)

  - "tt: clear ROAM flag when re-adding a pending local client"
  - "tt: send ROAM_ADV on each roamed back client"
  - "tt: ignore ROAM flag of received ADD changes"

* new: "mcast: validate tracker padding before forwarding"

Please pull or let me know of any problem!

Thank you,
      Simon

[1] e-mail subject was: [PATCH net 00/10] pull request: batman-adv 2026-10-26
    reference: https://lore.kernel.org/r/20261026085309.1074911-1-sw@simonwunderlich.de

The following changes since commit d1807b20d548171d40c5d21a7cf22830ea8f348e:

  batman-adv: use assign_bit() where applicable (2026-09-27 19:03:34 +0200)

are available in the Git repository at:

  https://git.open-mesh.org/batadv.git tags/batadv-net-pullrequest-20261030

for you to fetch changes up to a137095419b4be0b204a11af4f1cea872ea262e9:

  batman-adv: tt: limit local table to single TVLV response size (2026-10-30 10:11:27 +0100)

----------------------------------------------------------------
Here are a few batman-adv bugfixes:

- avoid WARN_ON for orig_ifinfo allocation failure, by Deepanshu Kartikey

- close OGM aggregation before transmission, by Chengfeng Ye

- mcast: validate tracker padding before forwarding, by Kyle Zeng

The remaining bugfixes are authored by Sven Eckelmann:

- tpmeter: fix u32 truncation of reported bytes

- dat: initialize orig_node of unfilled candidate slots

- fix skb leak when hard_iface is being released

- stop originator purge worker before freeing tt

- tt: fix flag and event handling (6 patches)

- tt: limit local table to single TVLV response size

----------------------------------------------------------------
Chengfeng Ye (1):
      batman-adv: Close OGM aggregation before transmission

Deepanshu Kartikey (1):
      batman-adv: avoid WARN_ON for orig_ifinfo allocation failure

Kyle Zeng (1):
      batman-adv: mcast: validate tracker padding before forwarding

Sven Eckelmann (11):
      batman-adv: tpmeter: fix u32 truncation of reported bytes
      batman-adv: dat: initialize orig_node of unfilled candidate slots
      batman-adv: fix skb leak when hard_iface is being released
      batman-adv: stop originator purge worker before freeing TT
      batman-adv: tt: only transmit local ROAM flag together with DEL
      batman-adv: tt: clear ROAM flag when re-adding a pending local client
      batman-adv: tt: send ROAM_ADV on each roamed back client
      batman-adv: tt: ignore ROAM flag of received ADD changes
      batman-adv: tt: only update flags for TT events
      batman-adv: tt: don't drop local events queued during TVLV update
      batman-adv: tt: limit local table to single TVLV response size

 net/batman-adv/bat_iv_ogm.c            |   7 +-
 net/batman-adv/distributed-arp-table.c |   1 +
 net/batman-adv/main.c                  |  12 +-
 net/batman-adv/multicast_forw.c        |   5 +-
 net/batman-adv/tp_meter.c              |   2 +-
 net/batman-adv/translation-table.c     | 215 ++++++++++++++++++++++-----------
 net/batman-adv/types.h                 |   8 +-
 7 files changed, 174 insertions(+), 76 deletions(-)
