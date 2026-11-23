Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E0A1606A337
	for <batman@archiver.kernel.org>; Mon, 23 Nov 2026 17:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=simonwunderlich.de header.i=@simonwunderlich.de header.a=rsa-sha256 header.s=09092022 header.b=qEOx6wTf
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id F33D782E7E
	for <batman@archiver.kernel.org>; Mon, 23 Nov 2026 18:18:49 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1795454329;
 b=3CkdGAfBiJIZN8ahQbMY977I0UbYek6mGsJIQoAAVnGtumUXI/pDK+M55t1cmEoHlzgBI
 kn6tpnHnt8edaGZkChEqCM9ZuZNlrL+H6HnrLJWO6rNQM+GwaQSQSBT6eldjMeGO4Xvti/+
 vdczlk2Mj9Md4OzinKqn//9kLUPH5xk=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1795454329; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=gj1hSguyCQXDj4T9K/2Fg1c9f4Jum2sq357NB14Izdo=;
 b=TE6XDeSyn2VTxJxguI9RcYsTqq+ZQyiVLpsdA4yZzaimsZ6tAOhCNVQKSfmXMQ4D26Srt
 /PEK8zqtGwjB08yaaHZN5JyJGEjqfRip2H87HqthJAuDWktZGkYhGk/+LIa7+rHholuQsdQ
 oz+GN5kdPSKojynYHnyd+V5vksUc/1k=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass header.from=simonwunderlich.de policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=simonwunderlich.de policy.dmarc=none
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de
 [IPv6:2a01:4f8:c17:e8c0::1])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 57C2C8310E
	for <b.a.t.m.a.n@lists.open-mesh.org>; Mon, 23 Nov 2026 18:18:32 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1795454322;
	b=lYlylFCfVPDknmvdk87c9n42Oelsf+FfHC+Fukg8bQwzI5iT+clJAHxRMRzafrR3vosT6+
	TrKLyO8PVzbWqcGOwylyr3H0WSZN4dwaVhdExN/IIGwJboa4nGCYcsaBJmeRAXdyBd6DqV
	aS9kVniEmWhMIF+KIY4FiTEoFBNGjYQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1795454322;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:dkim-signature;
	bh=gj1hSguyCQXDj4T9K/2Fg1c9f4Jum2sq357NB14Izdo=;
	b=Z6M1x+uNgG/jnGDD0ThvpYfz2WJjlWS8Q5iLnSiCPaIhVw6SrVQ5xfmb8y+HkWC/tp2C05
	bgOCxDxp/L8NzGuHt497fscH8f/aXoLq/kIixSrrm+jZA/jrdKckF03jB+L/bjIz3wDHCJ
	XJqPgNWn6sZEHQx0NdEEttbeShfroI4=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=simonwunderlich.de header.s=09092022 header.b=qEOx6wTf;
	dmarc=pass (policy=none) header.from=simonwunderlich.de;
	spf=pass (diktynna.open-mesh.org: domain of sw@simonwunderlich.de designates
 2a01:4f8:c17:e8c0::1 as permitted sender) smtp.mailfrom=sw@simonwunderlich.de
Received: from kero.packetmixer.de
 (p200300c59714c2E05A704819B6bA2DB4.dip0.t-ipconnect.de
 [IPv6:2003:c5:9714:c2e0:5a70:4819:b6ba:2db4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by mail.simonwunderlich.de (Postfix) with UTF8SMTPSA id A1759FA039;
	Mon, 23 Nov 2026 18:18:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1795454310;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=gj1hSguyCQXDj4T9K/2Fg1c9f4Jum2sq357NB14Izdo=;
	b=qEOx6wTfhumqnID6mo/8ZF4Rn69LImUfbk0NWi0PLJkydKb8DKGz3XWCF1MD7Nsw29LGsq
	JfiFja12weGs883Hjz74VbUNxBPXSXXmdjXSGgktiHZXFxKW62lD47tSPhMIna54X13vN6
	R7ZCqeUHP2RLWxlm9baZyKiFHfXmovQXYREQe/5jhvbAxf9hVetgFMjsMarOSWtD7L6/kB
	gkiSOcnfVjmyAOZ8dP1hcUr8/fqGcFf2aodZnrcn+lKU24cIIKHN+WXQQDjGfRx7Xn6W93
	4LBYJ5JFT1fgbZsZi0UMLbkpSoEJWu92JN7SepLygyHNYhvDIuKYM971KZmQBA==
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
 2026-11-23
Date: Mon, 23 Nov 2026 18:18:12 +0100
Message-ID: <20261123171827.3294525-1-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.47.3
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: ETMAHXFHNWCGXAPKCIBME67GZ2PGODRK
X-Message-ID-Hash: ETMAHXFHNWCGXAPKCIBME67GZ2PGODRK
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/ETMAHXFHNWCGXAPKCIBME67GZ2PGODRK/>
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

here is another pull request of batman-adv to go into net-next.

Please pull or let me know of any problem!

Thank you,
      Simon

The following changes since commit e2c4b4b08e96e8ada2674ce26ff9e4abc33897bb:

  batman-adv: annotate functions returning objects with __must_check (2026-11-01 18:13:10 +0100)

are available in the Git repository at:

  https://git.open-mesh.org/batadv.git tags/batadv-next-pullrequest-20261123

for you to fetch changes up to a859ae9d28de739ad791a5f83482808665d706f9:

  batman-adv: tt: drop ADD+DEL events of never announced clients (2026-11-20 08:33:06 +0100)

----------------------------------------------------------------
This feature/cleanup patchset includes the following patches, all by
Sven Eckelmann:

- document refcount of returned objects

- mcast: use mla_lock also during mcast_free

- mark functions inheriting critical sections

- bla: register own backbone gw when claiming for local node

- tt: rework local entry hash and locking handling (11 patches)

----------------------------------------------------------------
Sven Eckelmann (15):
      batman-adv: document refcount of returned objects
      batman-adv: mcast: use mla_lock also during mcast_free
      batman-adv: mark functions inheriting critical sections
      batman-adv: bla: register own backbone gw when claiming for local node
      batman-adv: tt: unhash local entries with hlist_del_init_rcu()
      batman-adv: tt: refresh local entry in single flags_lock section
      batman-adv: tt: don't remove unhashed local entries
      batman-adv: tt: don't queue local events for unhashed entries
      batman-adv: tt: remove unannounced local entries via pending state
      batman-adv: tt: keep local entry unchanged when ADD can't be queued
      batman-adv: tt: requeue DEL of pending local entry after failed allocation
      batman-adv: tt: extract removal of pending local entry
      batman-adv: tt: commit only the announced local changes
      batman-adv: tt: avoid list_lock for unchanged local clients
      batman-adv: tt: drop ADD+DEL events of never announced clients

 net/batman-adv/bat_iv_ogm.c            |   9 +-
 net/batman-adv/bat_v.c                 |   5 +-
 net/batman-adv/bat_v_ogm.c             |   5 +
 net/batman-adv/bridge_loop_avoidance.c |  15 +-
 net/batman-adv/distributed-arp-table.c |   1 +
 net/batman-adv/fragmentation.c         |   1 +
 net/batman-adv/fragmentation.h         |   1 +
 net/batman-adv/gateway_client.c        |   8 +-
 net/batman-adv/hard-interface.c        |   6 +-
 net/batman-adv/hard-interface.h        |   3 +-
 net/batman-adv/multicast.c             |  18 +-
 net/batman-adv/multicast_forw.c        |   2 +
 net/batman-adv/netlink.c               |  28 +-
 net/batman-adv/originator.c            |  16 +-
 net/batman-adv/routing.c               |   1 +
 net/batman-adv/tp_meter.c              |  12 +-
 net/batman-adv/translation-table.c     | 930 ++++++++++++++++++++++++---------
 net/batman-adv/tvlv.c                  |   5 +
 net/batman-adv/types.h                 |  14 +
 19 files changed, 787 insertions(+), 293 deletions(-)
