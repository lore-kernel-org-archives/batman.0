Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD912C79F89
	for <batman-adv@archiver.kernel.org>; Mon,  7 Sep 2026 08:19:50 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 7E1E8842E6
	for <batman-adv@archiver.kernel.org>; Mon, 07 Sep 2026 10:19:49 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1788769189;
 b=P/MOEO/mYOzHO8ZJvWwNljEoMJXdNYTgYprdAWIhAMIDTVqiuXATc8fAn8mEUD/20ZgGG
 qy4OWdhozUhIcNqYzq24LJ7hK/rExu/x4SG7Cc5pJizw3fEbiQQBRiuGcEhw/dwIs11m+RM
 ogWEgYu6maf3OQjwWwdNS4nJdrOINBw=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1788769189; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=/en6S0pLrmK0uJTojaLbW/qD54v16Ukp5Ukr3J8LW4I=;
 b=e1UOGBHQgbiPiFRTtir44aEXl3oMyUivWr6V+BoRaNcwd6Xy3ZpPtV7syb0mxfW6G3S2I
 9yeE38yo0KN9Y2Yk/M4Gnky0BKQ0l/up2AulnnvX/U153koWJ+4hyqAz646m3vqJzi9/PH8
 DhNgdvsP/j4Zjsgv1nAbdurVTCjtSFE=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass header.from=simonwunderlich.de policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=simonwunderlich.de policy.dmarc=none
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id BD66184122
	for <b.a.t.m.a.n@lists.open-mesh.org>; Mon, 07 Sep 2026 10:18:27 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1788769117;
	b=QSM/z/3BW9afhfXuhEjJatWQS+yGJ1/eoK2mRoMJkaXzGKQrAuofmrGFewp5cAFxA3enpC
	89qw1z/FI2fTqRy24oGDyiL7RTncWnOCUNIOJtW7sXa0Z5GUb19C8/IqARCWl3Whd3rMI4
	Nn5bW4lydwKMf9Gx0AMr5NyOVeaF1ew=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1788769117;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:dkim-signature;
	bh=/en6S0pLrmK0uJTojaLbW/qD54v16Ukp5Ukr3J8LW4I=;
	b=IqGySjYE9c00jZNL0Z6hhLOccfUasWXENasynWIrZjiigCFjbq+hAnJxnBU4YxoT9RJE8X
	SuzjPJkNACoGIlYcoTNBm6xHvGGizGeuSSGvUcvRZXJw9bGeclJ59VjFXY3xq/AVY48qzt
	ROmsYekSzJp31u6zFERIJojv7mE8x8o=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=simonwunderlich.de header.s=09092022 header.b=pC5P4gD1;
	spf=pass (diktynna.open-mesh.org: domain of sw@simonwunderlich.de designates
 23.88.38.48 as permitted sender) smtp.mailfrom=sw@simonwunderlich.de;
	dmarc=pass (policy=none) header.from=simonwunderlich.de
Received: from kero.packetmixer.de
 (p200300C59748d0D8c3747188e6dFe6C0.dip0.t-ipconnect.de
 [IPv6:2003:c5:9748:d0d8:c374:7188:e6df:e6c0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by mail.simonwunderlich.de (Postfix) with UTF8SMTPSA id DFAC3FA006;
	Mon, 07 Sep 2026 10:18:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1788769106;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=/en6S0pLrmK0uJTojaLbW/qD54v16Ukp5Ukr3J8LW4I=;
	b=pC5P4gD1fT6z1++6CFiLfF6yzWWzbyHcpv3nXQ2kb2S9KhACZKBdJndxcSMVeEayH/UJWh
	DMiEBTKBFGdyAKr++efS+VcmFSo8BHZDAUVpJq/Rcm3t1r+ZiioUiK1HEhYUZuImzLUGXn
	ehPTNH6c/88IDW3KrwKbjJc2uUddXhxbqLPmqm6jD0PNEgglmmB7tThCHyQ4MYLZfOzgaS
	TmxefvLE+M3Upy/MHHIVAfrRnuTpfGPdLxtYeXX9Zno6a6R3KWMm3Dv+j2NY3tV6ZyPKoJ
	gfMpZvdD7tCUETATkI2tuf+a2khED3o2td5dIdgeMv49Jt9R5e68YzkqfmMAPQ==
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
 2026-09-07
Date: Mon,  7 Sep 2026 10:18:09 +0200
Message-ID: <20260907081824.2474040-1-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: YSGOYVVKGLPTZKUVZEEFMBLOM7HM7YQC
X-Message-ID-Hash: YSGOYVVKGLPTZKUVZEEFMBLOM7HM7YQC
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/YSGOYVVKGLPTZKUVZEEFMBLOM7HM7YQC/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

Dear net maintainers,

here is another cleanup pull request of batman-adv to go into net-next.

Please pull or let me know of any problem!

Thank you,
      Simon

The following changes since commit 799152bcf6cbe4393eb03690925a382cefae303c:

  batman-adv: tt: decrement count for committed client on local_remove (2026-08-30 20:05:57 +0200)

are available in the Git repository at:

  https://git.open-mesh.org/batadv.git tags/batadv-next-pullrequest-20260907

for you to fetch changes up to 6d7f71ae4cdcbb22f541638057299fe26c451e65:

  batman-adv: correct batadv_hash_remove kdoc return type (2026-09-06 20:05:31 +0200)

----------------------------------------------------------------
This cleanup patchset includes the following patches, all by Sven Eckelmann:

 - translation table cleanups (12 patches)

 - kerneldoc fixes noted by sashiko (3 patches)

----------------------------------------------------------------
Sven Eckelmann (15):
      batman-adv: tt: look up wifi state of incoming interface in helper
      batman-adv: tt: extract allocation of new local entries
      batman-adv: tt: replace forward gotos in batadv_tt_local_add()
      batman-adv: tt: extract refresh of existing local entries
      batman-adv: tt: extract update of dynamic client flags
      batman-adv: tt: extract allocation of new global entries
      batman-adv: tt: extract merging of flags into existing global entries
      batman-adv: tt: replace add_orig_entry goto in batadv_tt_global_add()
      batman-adv: tt: extract removal of the superseded local entry
      batman-adv: tt: extract marking of a removed local entry
      batman-adv: tt: extract immediate purge of a local entry
      batman-adv: tt: drop the cleanup label from batadv_tt_local_remove()
      batman-adv: tt: clarify kernel doc for batadv_tt_local_set_pending_event()
      batman-adv: bat_iv: fix ogm_neigh_is_sob parameters references
      batman-adv: correct batadv_hash_remove kdoc return type

 net/batman-adv/bat_iv_ogm.c        |   4 +-
 net/batman-adv/hash.h              |   2 +-
 net/batman-adv/translation-table.c | 655 +++++++++++++++++++++++--------------
 3 files changed, 420 insertions(+), 241 deletions(-)
