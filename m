Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 868EFC624C6
	for <batman-adv@archiver.kernel.org>; Mon, 31 Aug 2026 13:51:49 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 6DF7581A7E
	for <batman-adv@archiver.kernel.org>; Mon, 31 Aug 2026 15:51:47 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1788184307;
 b=zsrHKHvVB3tnRu+9e3Gw4fO0rwHo+m53ZVIakA8dICy749dGtjZuetHp09H3vKtAf6hD+
 sMVhNMTaeH+dtV9Ej2zdKAtO99OINCN5T/iUt7ROILC+6Hsvk5qJK8xoKTpyRYgt4Gr2xkC
 se0X1xkRfe72+56ULtrRcfHzTkr6gUI=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1788184307; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=v58nA171/ZUbo3ELGRawLjqoT65WZroxRXQzt4gJV1Q=;
 b=x10eOaNpwbMUQrpv0UWnkqmgqP2DEw4+pqfqFyhvXwzsPfmoDRxQvKdsEA+ulerWLagNW
 YYCdtmoh/ct0xUlXH7absv2IjAXFT5UBymMochiqH56k3o27KLP6Er4uUEvJGTp7D+jCyO8
 zw2Abx5MSWP9KIg/H3Je/jV5dg2Q18o=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass header.from=simonwunderlich.de policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=simonwunderlich.de policy.dmarc=none
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de
 [IPv6:2a01:4f8:c17:e8c0::1])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 29E98818DE
	for <b.a.t.m.a.n@lists.open-mesh.org>; Mon, 31 Aug 2026 15:51:34 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1788184300;
	b=Go8RSopxzLc1iWy+LmmwjkRsWu5rpbJGAKAZQU9VU7Sy1w/yFYqyPbqj5bY4UTU795NYeT
	+hOg2LT4KvFl09JHEkMmjGHu6NmUH/TIK4Cha2olmtkdMakTDvwZS8c6fyRV7ZNeEvUDI0
	D0nzMbAhCOOX0NwqEzFfuXxb/igDXtM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1788184300;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:dkim-signature;
	bh=v58nA171/ZUbo3ELGRawLjqoT65WZroxRXQzt4gJV1Q=;
	b=0k5N6ULRPGGOkVaNo9aRcZa/w7+ne0ysj1NEh6apssMB50Xh3f15J/6W1DoJ5k4R7PXIu3
	EwhyDVQCoK4LN5pXV9Z1bQ3ZCnhCVrR62so2ur7iGM9k0TINjBPItfzFvy2G3zKex/F2jJ
	UUVZ/Op7MAyefRCTlsadRxuLBFMLFjM=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=simonwunderlich.de header.s=09092022 header.b=Ay18lRtu;
	spf=pass (diktynna.open-mesh.org: domain of sw@simonwunderlich.de designates
 2a01:4f8:c17:e8c0::1 as permitted sender)
 smtp.mailfrom=sw@simonwunderlich.de;
	dmarc=pass (policy=none) header.from=simonwunderlich.de
Received: from kero.packetmixer.de
 (p200300C5970eEdd85f51F1fAA919d7a5.dip0.t-ipconnect.de
 [IPv6:2003:c5:970e:edd8:5f51:f1fa:a919:d7a5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by mail.simonwunderlich.de (Postfix) with UTF8SMTPSA id 41977FA004;
	Mon, 31 Aug 2026 15:51:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1788184288;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=v58nA171/ZUbo3ELGRawLjqoT65WZroxRXQzt4gJV1Q=;
	b=Ay18lRtu+lcmixwdjd/wI5jShXwNI/IkZWqCxEBXiEJ1ewtoBGmZQEbQEVTv23h6zpQf5e
	dTZkfS/JpMCrZ+qXk3YlZN1TB5NYrnkuU3ucfIPF8a9xCK3jS6IPs3PXqVVdMHmqusleLH
	Sf0a/6murdsJyXQ0GElpqFcO98BecwU03KN31rAPBJW5irjak98hPqMr3QpMFutwSvSvYE
	rCsyd3/FBc61bkyu+wOOhvRov5pjHmOIe1VPVPO7+BT9K3Z4sShKJt1k+Gy9g9CtU0QkKG
	khfomIC8Wj3mO6Y8V08AVeNSibCv0EZkHbkjR7fhwukc44PjX8kFiG7FVWP4bA==
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
 2026-08-31
Date: Mon, 31 Aug 2026 15:51:02 +0200
Message-ID: <20260831135117.574836-1-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: 25EC7B5SMHVHRVKWCIWQ5NI67R7OTMX7
X-Message-ID-Hash: 25EC7B5SMHVHRVKWCIWQ5NI67R7OTMX7
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/25EC7B5SMHVHRVKWCIWQ5NI67R7OTMX7/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

Dear net maintainers,

here is cleanup pull request of batman-adv to go into net-next.

Please pull or let me know of any problem!

Thank you,
      Simon

The following changes since commit 1b78070aaef63512688aebfbc82365ef9d6660f1:

  Merge tag 'net-7.3-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net (2026-08-27 13:53:43 -0700)

are available in the Git repository at:

  https://git.open-mesh.org/batadv.git tags/batadv-next-pullrequest-20260831

for you to fetch changes up to 799152bcf6cbe4393eb03690925a382cefae303c:

  batman-adv: tt: decrement count for committed client on local_remove (2026-08-30 20:05:57 +0200)

----------------------------------------------------------------
This cleanup patchset includes the following patches, all by Sven Eckelmann:

- dat: fix printing of unknown 4addr subtype

- drop direction in _batadv_is_ap_isolated kernel-doc

- bat_v: fix bonding candidate selection

- clarify cut-off in batadv_v_neigh_is_sob kernel-doc

- use more descriptive var names for is_similar_or_better

- ensure u16 aligned mac addresses in structs and arrays (2 patches)

- translation table (tt) fixes/cleanups, 8 patches:

  - remove only the entry which was looked up from the hash
  - extract code handling a roam on add
  - simplify NEW flag transition code
  - drop unnecessary cleanup goto in helpers
  - use protected flag modifications
  - transition NEW local entries only under lock
  - don't uncount never committed clients on pending purge
  - decrement count for committed client on local_remove

----------------------------------------------------------------
Sven Eckelmann (15):
      batman-adv: dat: fix printing of unknown 4addr subtype
      batman-adv: drop direction in _batadv_is_ap_isolated kernel-doc
      batman-adv: bat_v: fix bonding candidate selection
      batman-adv: clarify cut-off in batadv_v_neigh_is_sob kernel-doc
      batman-adv: use more descriptive var names for is_similar_or_better
      batman-adv: ensure u16 aligned mac address arrays on stack
      batman-adv: ensure u16 aligned mac address in structs
      batman-adv: tt: remove only the entry which was looked up from the hash
      batman-adv: tt: extract code handling a roam on add
      batman-adv: tt: simplify NEW flag transition code
      batman-adv: tt: drop unnecessary cleanup goto in helpers
      batman-adv: tt: use protected flag modifications
      batman-adv: tt: transition NEW local entries only under lock
      batman-adv: tt: don't uncount never committed clients on pending purge
      batman-adv: tt: decrement count for committed client on local_remove

 net/batman-adv/bat_iv_ogm.c            |  25 +-
 net/batman-adv/bat_v.c                 |  42 +--
 net/batman-adv/bridge_loop_avoidance.c |   6 +-
 net/batman-adv/distributed-arp-table.c |  10 +-
 net/batman-adv/mesh-interface.c        |  12 +-
 net/batman-adv/multicast.c             |   6 +-
 net/batman-adv/translation-table.c     | 503 ++++++++++++++++++++++-----------
 net/batman-adv/types.h                 |  49 ++--
 8 files changed, 425 insertions(+), 228 deletions(-)
