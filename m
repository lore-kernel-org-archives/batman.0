Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F5C3606A31D
	for <batman@archiver.kernel.org>; Mon, 26 Oct 2026 08:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=simonwunderlich.de header.i=@simonwunderlich.de header.a=rsa-sha256 header.s=09092022 header.b=C6LmprTf
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 1103E844BD
	for <batman@archiver.kernel.org>; Mon, 26 Oct 2026 09:53:37 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1793004817;
 b=lTNTXV24SvGIdbMubENcxrb0EC5K80PwK1zha2tvWrW6bTl+q9hY2nRD0X0/stUCrHKCf
 A29Ozk+4SaPcGWMbfjozWGOSFPqDgpCmF1NB92mrTLkOnX/7ucDdS4m9ySZ5LknhIiO8RCA
 ouK4b77FXqldBFs+AWcJP37iaw4Ev8E=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1793004817; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=dZ9QsbA9QwTKvGZBboI7YZTRLZ7fIDnixDLulFlqOr8=;
 b=hsnMmJ4iahYg3Xo5Ly/bf2OFQo1o2GC+LeJ6WsVSbP4euLdwUZ4aaMnHgAsnIeZ8JgJug
 +wZILcl4ybps+Iw5zRVq4PSGJWRvzxccXAuIk+09vu83Raka9c7Dyxyz/b+3KxhtkbS6pKP
 1X5KV28mciX/KJreBQ10pbOWodwbYKI=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass header.from=simonwunderlich.de policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=simonwunderlich.de policy.dmarc=none
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 13F86811A7
	for <b.a.t.m.a.n@lists.open-mesh.org>; Mon, 26 Oct 2026 09:53:11 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1793004802;
	b=t0LGLZ0hm4NrLoiJ/RIZ+nHnk7y57Uc7jekrGG06866aXh9fqBbDr1srLsGw4yD5FNEdOH
	MJFMsSgstmvSHIPGqy9bCYIy1Bzilr6jFGvNVAC9WOHZVByNL71rOrV0oTfwlqCNEzcCFP
	JFIAbL5ZxiOnBaCRrEsxUpDWDYUu6ug=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1793004802;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:dkim-signature;
	bh=dZ9QsbA9QwTKvGZBboI7YZTRLZ7fIDnixDLulFlqOr8=;
	b=Fuec5rOSEYSqQ5hRDfq8F81rTIXrBgYH+J4Wydq4Wu01AGxQeNPb8yQQy9u8GoYshnXopt
	IFZ8Mx/1AQESXZF/XCmRf3qzAd3ygQObSBKnvY23G9pwtDmt3mJeygv6k1qKN6F5z1LxSP
	HKlVgp/uJbYkITYmc4FEHt7NQVXjZXc=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=simonwunderlich.de header.s=09092022 header.b=C6LmprTf;
	spf=pass (diktynna.open-mesh.org: domain of sw@simonwunderlich.de designates
 23.88.38.48 as permitted sender) smtp.mailfrom=sw@simonwunderlich.de;
	dmarc=pass (policy=none) header.from=simonwunderlich.de
Received: from kero.packetmixer.de
 (p200300c5973cE5d80Fc8DFe94a24022D.dip0.t-ipconnect.de
 [IPv6:2003:c5:973c:e5d8:fc8:dfe9:4a24:22d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by mail.simonwunderlich.de (Postfix) with UTF8SMTPSA id 97AB3FA006;
	Mon, 26 Oct 2026 09:53:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1793004790;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=dZ9QsbA9QwTKvGZBboI7YZTRLZ7fIDnixDLulFlqOr8=;
	b=C6LmprTfwyC68NDhM8E/qRr//HptQaaAVuJ6CgWwGX2ffJClTuMUpYY9BPVNO1aIM52QU2
	EBr35KMrwdmenQQZkFD+Zspz9hJfB/etIj+XiZkKos2HXHEO5dB3i0rhygAp5zvDQCgKwE
	RqZdoDMpZ6VAQ7e1nOAhf6pVHAR+ywv2IVZLMhOd5HQalu7SvEBe1gXJRhZyHFF3Uijw+B
	GIlUr90vRlT2R1NG0inQYMdTLAWWADv7P0sqMY6PEqSF9ltv0ilIifydCHCNHcYZodrFR7
	/8q+1iTopAbAGMHsFnFA43EjafPuFhYHITKz4oFVJtEo78SEyyANi6LK4PRsLQ==
From: Simon Wunderlich <sw@simonwunderlich.de>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	b.a.t.m.a.n@lists.open-mesh.org,
	Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH net 00/10] pull request: batman-adv 2026-10-26
Date: Mon, 26 Oct 2026 09:52:59 +0100
Message-ID: <20261026085309.1074911-1-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.47.3
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Message-ID-Hash: F3ZIIMNAPUUSOEC65MVONSVNRTYSCGY7
X-Message-ID-Hash: F3ZIIMNAPUUSOEC65MVONSVNRTYSCGY7
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/F3ZIIMNAPUUSOEC65MVONSVNRTYSCGY7/>
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

here are some bugfixes for batman-adv which we would like to have integrated into net.

Please pull or let me know of any problem!

Thank you,
      Simon

The following changes since commit d1807b20d548171d40c5d21a7cf22830ea8f348e:

  batman-adv: use assign_bit() where applicable (2026-09-27 19:03:34 +0200)

are available in the Git repository at:

  https://git.open-mesh.org/batadv.git tags/batadv-net-pullrequest-20261026

for you to fetch changes up to 6e7c45ed237c5cfe10ee121f8c0c8909e7d6e0f8:

  batman-adv: tt: limit local table to single TVLV response size (2026-10-25 08:45:11 +0100)

----------------------------------------------------------------
Here are a few batman-adv bugfixes:

- avoid WARN_ON for orig_ifinfo allocation failure, by Deepanshu Kartikey

- close OGM aggregation before transmission, by Chengfeng Ye

The remaining bufixes are authored by Sven Eckelmann:

- tpmeter: fix u32 truncation of reported bytes

- dat: initialize orig_node of unfilled candidate slots

- fix skb leak when hard_iface is being released

- stop originator purge worker before freeing tt

- tt: fix flag and event handling (3 patches)

- tt: limit local table to single TVLV response size

----------------------------------------------------------------
Chengfeng Ye (1):
      batman-adv: Close OGM aggregation before transmission

Deepanshu Kartikey (1):
      batman-adv: avoid WARN_ON for orig_ifinfo allocation failure

Sven Eckelmann (8):
      batman-adv: tpmeter: fix u32 truncation of reported bytes
      batman-adv: dat: initialize orig_node of unfilled candidate slots
      batman-adv: fix skb leak when hard_iface is being released
      batman-adv: stop originator purge worker before freeing TT
      batman-adv: tt: only transmit local ROAM flag together with DEL
      batman-adv: tt: only update flags for TT events
      batman-adv: tt: don't drop local events queued during TVLV update
      batman-adv: tt: limit local table to single TVLV response size

 net/batman-adv/bat_iv_ogm.c            |   7 +-
 net/batman-adv/distributed-arp-table.c |   1 +
 net/batman-adv/main.c                  |  12 ++-
 net/batman-adv/tp_meter.c              |   2 +-
 net/batman-adv/translation-table.c     | 138 +++++++++++++++++++++------------
 5 files changed, 104 insertions(+), 56 deletions(-)
