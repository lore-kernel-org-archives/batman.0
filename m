Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74D5CC02183
	for <batman-adv@archiver.kernel.org>; Fri, 17 Jan 2025 12:39:33 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id E760383F7A
	for <batman-adv@archiver.kernel.org>; Fri, 17 Jan 2025 13:39:31 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1737117571;
 b=wfCqKTpInqUJcSgkVZlIAcNH/JkzH7gqM3EXOOu6zR/Bfp0rJIYHnAMaGcFu0907myBBZ
 pssCKg/oB5K/0REWDYgAN8fBMYPZvyRghFEZOOx2g4VEBA8gXPQqo+vSksZ/3RNoAhLHwxQ
 s7w7sXda/IajR6l4PzjSgzGyBiMvi8Y=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1737117571; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=XmpilTFuSNAg6FQWIEMKEo4fDrYph4EI5a/mVe82IF4=;
 b=m3PTWVt7psg6Kr6lu8GBBqUY+klcUjC3JslxxwPYJnjWOJFEKBNpGhWAPWaNH65GDGRYH
 2/5hcLNqv3sQmEIQci53gl4QgasCKCpG5DkUormHgkXVfc76jSFtIIrwJPoQCI8VXsKNI/x
 wlQg9vpZKGw7eyTK2E68rv3XX9avqO8=
ARC-Authentication-Results: i=2; open-mesh.org; dkim=fail;
  arc=pass;
  dmarc=fail (Used From Domain Record) header.from=simonwunderlich.de
 policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=fail; arc=pass;
 dmarc=fail (Used From Domain Record) header.from=simonwunderlich.de
 policy.dmarc=none
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de
 [IPv6:2a01:4f8:c17:e8c0::1])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 8C8CE81B1A
	for <b.a.t.m.a.n@lists.open-mesh.org>; Fri, 17 Jan 2025 13:39:24 +0100 (CET)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1737117564;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=XmpilTFuSNAg6FQWIEMKEo4fDrYph4EI5a/mVe82IF4=;
	b=s8ZMYa/V1Bo9XVaggWq2iyFMOrPLhbzfxo7lPrUb6IRmvZtq/sYQQNXEmTy0P0YkEIDdpx
	dUk3ZWdyiV7XL0yMoCkbrHFLicn6jsaGlapVFJ6x0SoXq3TP9hWdIcvpPW39djwl+X63FD
	UYdXkQYyR8/8gCVYpXZ5hRwix3c8A/E=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=none;
	spf=pass (diktynna.open-mesh.org: domain of sw@simonwunderlich.de designates
 2a01:4f8:c17:e8c0::1 as permitted sender)
 smtp.mailfrom=sw@simonwunderlich.de;
	dmarc=pass (policy=none) header.from=simonwunderlich.de
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1737117564; a=rsa-sha256;
	cv=none;
	b=Qk3T3kBWZs1mO+ztxFD0G9yJr36rAsvvopj13iuhSvcZe0b55oyEPSy5bxdadzVjz1q2M5
	GkHLV5bqtmzugs++eiOP8JD753kbNbUoqaxRV9ytz3Ci7BTai+zFSqp3RzCQ1nY6eqRPZr
	Mhytiy8pMnvezEKfKbwnkjAcBt+Z1nQ=
Received: from kero.packetmixer.de
 (p200300c5973c90d8A96DD71A2E03F697.dip0.t-ipconnect.de
 [IPv6:2003:c5:973c:90d8:a96d:d71a:2e03:f697])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits)
 server-digest SHA256)
	(No client certificate requested)
	by mail.simonwunderlich.de (Postfix) with ESMTPSA id 8733DFA132;
	Fri, 17 Jan 2025 13:39:23 +0100 (CET)
From: Simon Wunderlich <sw@simonwunderlich.de>
To: kuba@kernel.org,
	davem@davemloft.net
Cc: netdev@vger.kernel.org,
	b.a.t.m.a.n@lists.open-mesh.org,
	Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH 00/10] pull request for net-next: batman-adv 2025-01-17
Date: Fri, 17 Jan 2025 13:39:00 +0100
Message-Id: <20250117123910.219278-1-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Message-ID-Hash: Q6KRW4Y6AXYJSBGWNQQKMNGEUAQR3RHT
X-Message-ID-Hash: Q6KRW4Y6AXYJSBGWNQQKMNGEUAQR3RHT
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/Q6KRW4Y6AXYJSBGWNQQKMNGEUAQR3RHT/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

Hi Jakub, hi David,

here is a cleanup pull request of batman-adv to go into net-next.

Please pull or let me know of any problem!

Thank you,
      Simon

The following changes since commit 40384c840ea1944d7c5a392e8975ed088ecf0b37:

  Linux 6.13-rc1 (2024-12-01 14:28:56 -0800)

are available in the Git repository at:

  git://git.open-mesh.org/linux-merge.git tags/batadv-next-pullrequest-20250117

for you to fetch changes up to 6ecc4fd6c2f43862c5e3b280cf419f0131e45c97:

  batman-adv: netlink: reduce duplicate code by returning interfaces (2025-01-17 13:36:01 +0100)

----------------------------------------------------------------
This cleanup patchset includes the following patches:

 - bump version strings, by Simon Wunderlich

 - Reorder includes for distributed-arp-table.c, by Sven Eckelmann

 - Fix translation table change handling, by Remi Pommarel (2 patches)

 - Map VID 0 to untagged TT VLAN, by Sven Eckelmann

 - Update MAINTAINERS/mailmap e-mail addresses, by the respective authors
   (4 patches)

 - netlink: reduce duplicate code by returning interfaces,
   by Linus Lüssing

----------------------------------------------------------------
Antonio Quartulli (1):
      MAINTAINERS: mailmap: add entries for Antonio Quartulli

Linus Lüssing (1):
      batman-adv: netlink: reduce duplicate code by returning interfaces

Marek Lindner (1):
      MAINTAINERS: update email address of Marek Linder

Remi Pommarel (2):
      batman-adv: Remove atomic usage for tt.local_changes
      batman-adv: Don't keep redundant TT change events

Simon Wunderlich (2):
      batman-adv: Start new development cycle
      mailmap: add entries for Simon Wunderlich

Sven Eckelmann (3):
      batman-adv: Reorder includes for distributed-arp-table.c
      batman-adv: Map VID 0 to untagged TT VLAN
      mailmap: add entries for Sven Eckelmann

 .mailmap                                |  19 +++++
 Documentation/networking/batman-adv.rst |   2 +-
 MAINTAINERS                             |   4 +-
 net/batman-adv/bridge_loop_avoidance.c  |  33 ++------
 net/batman-adv/distributed-arp-table.c  |  20 ++---
 net/batman-adv/gateway_client.c         |  18 +---
 net/batman-adv/main.c                   |   7 ++
 net/batman-adv/main.h                   |   4 +-
 net/batman-adv/multicast.c              |  17 +---
 net/batman-adv/netlink.c                | 146 ++++++++++++++++++++++----------
 net/batman-adv/netlink.h                |   5 +-
 net/batman-adv/originator.c             | 116 +++++++++----------------
 net/batman-adv/soft-interface.c         |  16 +++-
 net/batman-adv/translation-table.c      |  92 ++++++++------------
 net/batman-adv/types.h                  |   4 +-
 15 files changed, 251 insertions(+), 252 deletions(-)
