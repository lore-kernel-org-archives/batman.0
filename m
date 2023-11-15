Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AE4FC2BB3F
	for <batman-adv@archiver.kernel.org>; Wed, 15 Nov 2023 18:00:07 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 89A1B83D76
	for <batman-adv@archiver.kernel.org>; Wed, 15 Nov 2023 19:00:05 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1700071205;
 b=k+l9ufiAQXj+tlqi437bsYuh7CveGrX937S3PG6/EL8WeMy3etp42ZJspljr2C2virzaA
 N/dOolLtf/ijX86ZWEHVp3G0UlbZAMshNTwJTfkC9EaOzaikNdrzwQwVE42ETE35dc0TzEM
 zGHAKFD/wrz/h3OuR8BKnH4rjQ4dq4Y=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1700071205; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=bAxk9ym77K0Zu3J0BGuMitLBBUOGx3lIQ1Es2z5iKmI=;
 b=G1DJ6SOwirdGn28Hjtzxr8JSYFmFBf6TIibkHUnN/IMnzQWL+HQu1YEpNdpcnPfQmNPVf
 C2DZycY5PBDXrZGKYNZedv7twZMbIN4RVc47mvC5S01pvNaWK6NU2EKMeMn99dj0nirV4wb
 38o2/gtQzLj5H5qMWEnkvmrg0vQpgKg=
ARC-Authentication-Results: i=2; open-mesh.org; dkim=fail;
  arc=pass;
  dmarc=fail (Used From Domain Record) header.from=simonwunderlich.de
 policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=fail; arc=pass;
 dmarc=fail (Used From Domain Record) header.from=simonwunderlich.de
 policy.dmarc=none
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de
 [IPv6:2a01:4f8:c17:e8c0::1])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id E739C807C5
	for <b.a.t.m.a.n@lists.open-mesh.org>; Wed, 15 Nov 2023 18:59:41 +0100 (CET)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1700071182;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=bAxk9ym77K0Zu3J0BGuMitLBBUOGx3lIQ1Es2z5iKmI=;
	b=g3WQzPBlX1KXJYChsAuCLfgyuhqCrhJtZRrPuKx6ctdJu/tSdy7SVb/+gkfI8LNmRperHT
	C5XQZy8J7LiOpAza2E0npxllwDZ3mpOuQVkpMvB5GuumuwStnmfztfJzQm1y4zZ/22dSE8
	FOWBjRMQjUy9xn0ZyEIWlXFjOjLu++o=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=none;
	dmarc=pass (policy=none) header.from=simonwunderlich.de;
	spf=pass (diktynna.open-mesh.org: domain of sw@simonwunderlich.de designates
 2a01:4f8:c17:e8c0::1 as permitted sender) smtp.mailfrom=sw@simonwunderlich.de
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1700071182; a=rsa-sha256;
	cv=none;
	b=n5mIzaz5rTIQjKlvLmxQiTqWpDSZlrpPYXbfu82ZVRbIwMTagKpDt102QLDi5y5fv1vItM
	t/hmtcUGzbkEOIi7QyF90vsQVW748GnxGTWYak8+HdTRDc6NKNf8AmGAPK7mgGb/SC86P8
	iBEgYKbnZ8ZVtDetOXvNR779jwnmlFI=
Received: from kero.packetmixer.de
 (p200300fa2706340047Bd8a14b9C54dBB.dip0.t-ipconnect.de
 [IPv6:2003:fa:2706:3400:47bd:8a14:b9c5:4dbb])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits)
 server-digest SHA256)
	(No client certificate requested)
	by mail.simonwunderlich.de (Postfix) with ESMTPSA id 8356DFB5F7;
	Wed, 15 Nov 2023 18:59:41 +0100 (CET)
From: Simon Wunderlich <sw@simonwunderlich.de>
To: kuba@kernel.org,
	davem@davemloft.net
Cc: netdev@vger.kernel.org,
	b.a.t.m.a.n@lists.open-mesh.org,
	Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH 0/6] pull request for net-next: batman-adv 2023-11-15
Date: Wed, 15 Nov 2023 18:59:26 +0100
Message-Id: <20231115175932.127605-1-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Message-ID-Hash: CXXKJPVFXCOYB33JBQSP2FWVECGW4VRC
X-Message-ID-Hash: CXXKJPVFXCOYB33JBQSP2FWVECGW4VRC
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/CXXKJPVFXCOYB33JBQSP2FWVECGW4VRC/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

Hi Jakub, hi David,

here is a feature/cleanup pull request of batman-adv to go into net-next.

Please pull or let me know of any problem!

Thank you,
      Simon

The following changes since commit 89cdf9d556016a54ff6ddd62324aa5ec790c05cc:

  Merge tag 'net-6.7-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net (2023-11-09 17:09:35 -0800)

are available in the Git repository at:

  git://git.open-mesh.org/linux-merge.git tags/batadv-next-pullrequest-20231115

for you to fetch changes up to c3ed16a64c0b0a5b116c9753bf48496d49daffb5:

  batman-adv: Switch to linux/array_size.h (2023-11-14 08:16:34 +0100)

----------------------------------------------------------------
This feature/cleanup patchset includes the following patches:

 - bump version strings, by Simon Wunderlich

 - Implement new multicast packet type, including its transmission,
   forwarding and parsing, by Linus Lüssing (3 patches)

 - Switch to new headers for sprintf and array size,
   by Sven Eckelmann (2 patches)

----------------------------------------------------------------
Linus Lüssing (3):
      batman-adv: mcast: implement multicast packet reception and forwarding
      batman-adv: mcast: implement multicast packet generation
      batman-adv: mcast: shrink tracker packet after scrubbing

Simon Wunderlich (1):
      batman-adv: Start new development cycle

Sven Eckelmann (2):
      batman-adv: Switch to linux/sprintf.h
      batman-adv: Switch to linux/array_size.h

 include/uapi/linux/batadv_packet.h     |   45 +-
 net/batman-adv/Makefile                |    1 +
 net/batman-adv/bridge_loop_avoidance.c |    2 +-
 net/batman-adv/fragmentation.c         |    8 +-
 net/batman-adv/gateway_client.c        |    2 +-
 net/batman-adv/main.c                  |    5 +-
 net/batman-adv/main.h                  |    2 +-
 net/batman-adv/multicast.c             |  129 +++-
 net/batman-adv/multicast.h             |   30 +-
 net/batman-adv/multicast_forw.c        | 1178 ++++++++++++++++++++++++++++++++
 net/batman-adv/netlink.c               |    2 +-
 net/batman-adv/originator.c            |   28 +
 net/batman-adv/originator.h            |    3 +
 net/batman-adv/routing.c               |   70 ++
 net/batman-adv/routing.h               |   11 +
 net/batman-adv/soft-interface.c        |   18 +-
 net/batman-adv/types.h                 |   70 ++
 17 files changed, 1572 insertions(+), 32 deletions(-)
 create mode 100644 net/batman-adv/multicast_forw.c
