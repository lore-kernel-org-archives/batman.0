Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C48AC282DE
	for <batman-adv@archiver.kernel.org>; Thu, 13 Mar 2025 16:17:51 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id A4AED84279
	for <batman-adv@archiver.kernel.org>; Thu, 13 Mar 2025 17:17:49 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1741882669;
 b=ITL631vTAp2A/jxtdgvaPAyoD0/LGC3z2SoA4Yaf5mq/zX5Me4eWafIIeiRSxVjEm/Sqx
 EXxztBPDOaXL87FAo892vk5d0FeDYaVe5mjCk40mS27oqVTWKY7OsVMKmmc8VLrsi7ZN5B5
 AXmOBn1zaWcVBaSL+TNVU57zPrYP85k=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1741882669; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=VMQ+6fs4CmEPlFkKzTJwaoCA0D2oJV+t2quPSshPkSM=;
 b=ZhGSPNbotFzL9UuYv65hQ673eFxr4Ufw8cJ4FqIZqAW9DY3eOQiQzSMMzgU9cyuIJ6T8Z
 YSgQH9G3xBYIwEaxNIf2y4bph3bELRoMcBKivtrthxdZLr8vt/j5iMsPjz7bEFGUPiUHv5K
 s+DS3Drc8PI4foT0UyeUVZGhVOjYxUQ=
ARC-Authentication-Results: i=2; open-mesh.org; dkim=fail;
  arc=pass;
  dmarc=fail (Used From Domain Record) header.from=simonwunderlich.de
 policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=fail; arc=pass;
 dmarc=fail (Used From Domain Record) header.from=simonwunderlich.de
 policy.dmarc=none
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de
 [IPv6:2a01:4f8:c17:e8c0::1])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 30DFD818D3
	for <b.a.t.m.a.n@lists.open-mesh.org>; Thu, 13 Mar 2025 17:17:40 +0100 (CET)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1741882661;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=VMQ+6fs4CmEPlFkKzTJwaoCA0D2oJV+t2quPSshPkSM=;
	b=SUluo3DYkYpOgk4Y5ifekW9X9tUCdynIPRFuMBpsHj2JJCfMVXKMZw1zHqVyJsbNxRQ9bO
	6rXgf7593uddL5zR0c1413YxdO5VFea2upLlu1KvoT4C2F6kX6oog/ki6KKXvp2us7O02g
	JZ+FlMvJnUtt1oV27LqpNSalaD1Rg7M=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=none;
	dmarc=pass (policy=none) header.from=simonwunderlich.de;
	spf=pass (diktynna.open-mesh.org: domain of sw@simonwunderlich.de designates
 2a01:4f8:c17:e8c0::1 as permitted sender) smtp.mailfrom=sw@simonwunderlich.de
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1741882661; a=rsa-sha256;
	cv=none;
	b=N2t2aliWZCvoAGKO48jTGRzBXVLMqBFpqV+KW/38Iuyq/ccb5ngQQNSOuBfoTg4p2NLpcS
	P9N7NsvXLL6NaVSD5RnM4IWdDKSZydIwEZ2mjeZk3EILEYkgYot8gZlG0KltlTwMx7G8KP
	utoPNrippMIVT7wslZmnzeEjxBjJKPI=
Received: from kero.packetmixer.de
 (p200300fA272413901A38A4bc9c0De305.dip0.t-ipconnect.de
 [IPv6:2003:fa:2724:1390:1a38:a4bc:9c0d:e305])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits)
 server-digest SHA256)
	(No client certificate requested)
	by mail.simonwunderlich.de (Postfix) with ESMTPSA id 6041AFA131;
	Thu, 13 Mar 2025 17:17:40 +0100 (CET)
From: Simon Wunderlich <sw@simonwunderlich.de>
To: davem@davemloft.net,
	kuba@kernel.org
Cc: netdev@vger.kernel.org,
	b.a.t.m.a.n@lists.open-mesh.org,
	Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH 0/5] pull request for net: batman-adv 2025-03-13
Date: Thu, 13 Mar 2025 17:17:33 +0100
Message-Id: <20250313161738.71299-1-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: MABW7XC5HZA74K4ABIZSQQVS2IXNWP52
X-Message-ID-Hash: MABW7XC5HZA74K4ABIZSQQVS2IXNWP52
X-MailFrom: sw@simonwunderlich.de
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-0;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-1;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-2; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/MABW7XC5HZA74K4ABIZSQQVS2IXNWP52/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

Hi David, hi Jakub,

here are some bugfixes for batman-adv which we would like to have integrated into net.

Please pull or let me know of any problem!

Thank you,
      Simon

The following changes since commit fff8f17c1a6fc802ca23bbd3a276abfde8cc58e6:

  batman-adv: Do not let TT changes list grows indefinitely (2024-12-05 22:38:26 +0100)

are available in the Git repository at:

  git://git.open-mesh.org/linux-merge.git tags/batadv-net-pullrequest-20250313

for you to fetch changes up to 548b0c5de7619ef53bbde5590700693f2f6d2a56:

  batman-adv: Ignore own maximum aggregation size during RX (2025-02-08 19:24:33 +0100)

----------------------------------------------------------------
Here are some batman-adv bugfixes:

- fix panic during interface removal, by Andy Strohman

- Ignore neighbor throughput metrics in error case, by Sven Eckelmann

- Drop unmanaged ELP metric worker, by Sven Eckelmann

- Fix incorrect offset in batadv_tt_tvlv_ogm_handler_v1(), by Remi Pommarel

- Ignore own maximum aggregation size during RX, Sven Eckelmann

----------------------------------------------------------------
Andy Strohman (1):
      batman-adv: fix panic during interface removal

Remi Pommarel (1):
      batman-adv: Fix incorrect offset in batadv_tt_tvlv_ogm_handler_v1()

Sven Eckelmann (3):
      batman-adv: Ignore neighbor throughput metrics in error case
      batman-adv: Drop unmanaged ELP metric worker
      batman-adv: Ignore own maximum aggregation size during RX

 net/batman-adv/bat_iv_ogm.c        |   3 +-
 net/batman-adv/bat_v.c             |   2 -
 net/batman-adv/bat_v_elp.c         | 122 ++++++++++++++++++++++++++-----------
 net/batman-adv/bat_v_elp.h         |   2 -
 net/batman-adv/bat_v_ogm.c         |   3 +-
 net/batman-adv/translation-table.c |  12 ++--
 net/batman-adv/types.h             |   3 -
 7 files changed, 93 insertions(+), 54 deletions(-)
