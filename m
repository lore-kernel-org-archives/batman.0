Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF7CECD343F
	for <batman@archiver.kernel.org>; Fri, 15 May 2026 10:00:06 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 7F73385DE7
	for <batman@archiver.kernel.org>; Fri, 15 May 2026 12:00:05 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1778839205;
 b=rJd9vLPtEwS7R+9w5JANG4ZFGVuuV7pz3NQcE37+aThiWNpPg23xcvLfaewYJRT2ZtFP9
 t+y/OFTuqo4yOYQjVWWaUErx45FD/Jagrr3UZaZTqvsHJ88UGuOtJ0lvUcFleCTNOyeo5DQ
 IrrErIksB+9WAIt1Wn3Fdpsc1AH+JDY=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1778839205; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=WdW96lwjZLtv5rn+c5R3Ebu/EKI3ykmUo3hD6IAnLSk=;
 b=vZ3aAF9ukcSIREIWJDWMZEvYDBdANrPcFZhf7XdHdPDTjnvmdxPh5K2QG3jts2Z17I+gD
 JiGnpAPKqCjYUlKYntfz9wMCCuSQQ1jPsXIn8O+La/HfaRsZaMBo5i7Rt0ag76BowlGmrlf
 O+cP7H9VBSNia52fgUO2CRqvaXS+mnA=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass header.from=simonwunderlich.de policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=simonwunderlich.de policy.dmarc=none
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de
 [IPv6:2a01:4f8:c17:e8c0::1])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 594B68538A
	for <b.a.t.m.a.n@lists.open-mesh.org>; Fri, 15 May 2026 11:55:48 +0200 (CEST)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1778838953;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:dkim-signature;
	bh=WdW96lwjZLtv5rn+c5R3Ebu/EKI3ykmUo3hD6IAnLSk=;
	b=IuC/W7ze8gbVRF82xPiesJgY040aJm9taO3dVz57MYqC+u8xCrLoaEApg6F8Bs1Vp59JRb
	ISdXAd0uzPr/gQilH1ZvyzxmLJ+P6iygDyhBadG7E6e1vp0xKhqPkSa+iX9ni1rJw+G8sM
	hGe1m9StGw4LYzGAPsp3PyIQQGZH8hE=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=simonwunderlich.de header.s=09092022 header.b=X86GfgkJ;
	dmarc=pass (policy=none) header.from=simonwunderlich.de;
	spf=pass (diktynna.open-mesh.org: domain of sw@simonwunderlich.de designates
 2a01:4f8:c17:e8c0::1 as permitted sender) smtp.mailfrom=sw@simonwunderlich.de
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1778838953;
	b=bZ2FS0kz7goaCmR5zixDcdHogen/pP0m+ur/GYZQUEimIG5Gw2RU6i8sVuCDVPs13wwE2B
	qz4PonBvBfZgpYd83oZoU7ov7f6ooqj+iA0IaT86NlrhLp3SvGs7yhlxY2UmHN2eB/V96J
	icLofdeDy6rWQUMXGhp0+refmSOf8Xg=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1778838946;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=WdW96lwjZLtv5rn+c5R3Ebu/EKI3ykmUo3hD6IAnLSk=;
	b=X86GfgkJHPGQ+jvTknJbGTTTLciNEs7qckV5iKMyYWnc+fCdSvG2EN1y9OiFGQoNET+5mQ
	/IlWzAQfNjZvOKWhBvvXMNNCdOFpb4ASVtnoVJ48r+6eum1AgN8mkYrJaiCcREiwVdAFCo
	jgJ1G6Msgwt5VbiJPM83iNoTW3gO6J31fi3WcIccBP1WxuQ4wp7TR8ij+6ENEiT4qmljAY
	OiVpr3oLrkdGBR3EV2WPVybqNbY5l7tncwgwgL+S5RnhiyIAtudFk8aL6m/Qdl2FqDaVWa
	yRT5kr+yrJrGj4OnlNW/84HFjcetC87nnfQKGz0rxckXS/weRuQ/wBZo3iDtrA==
From: Simon Wunderlich <sw@simonwunderlich.de>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	b.a.t.m.a.n@lists.open-mesh.org,
	Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH net 00/14] pull request: batman-adv 2026-05-15
Date: Fri, 15 May 2026 11:55:25 +0200
Message-ID: <20260515095540.325586-1-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: BHDV6FINSAZKQMSKTMMMGDO5LFITPE6L
X-Message-ID-Hash: BHDV6FINSAZKQMSKTMMMGDO5LFITPE6L
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/BHDV6FINSAZKQMSKTMMMGDO5LFITPE6L/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

Dear net maintainers,

here are quite a few more bugfixes for batman-adv which we would like to have integrated into net.

Please pull or let me know of any problem!

Thank you,
      Simon

The following changes since commit ba9d20ee9076dac32c371116bacbe72480eb356c:

  batman-adv: bla: put backbone reference on failed claim hash insert (2026-05-08 14:29:02 +0200)

are available in the Git repository at:

  https://git.open-mesh.org/batadv.git tags/batadv-net-pullrequest-20260515

for you to fetch changes up to d5487249a81ea658717614009c8f46acc5b7101a:

  batman-adv: tp_meter: directly shut down timer on cleanup (2026-05-15 10:41:55 +0200)

----------------------------------------------------------------
Here are various batman-adv bugfixes:

 - fix tp_meter counter underflow during shutdown, by Luxiao Xu

 - fix tp_meter tp_vars reference leak in receiver shutdown,
   by Sven Eckelmann

 - fix various translation table integer handling issues,
   by Sven Eckelmann (3 patches)

 - fix various translation table counter issues,
   by Sven Eckelmann (3 patches)

 - fix fragment reassembly length accounting, by Ruide Cao

 - clear current gateway during teardown, by Ruijie Li

 - handle forward allocation error in DAT, by Sven Eckelmann

 - tp_meter: avoid use of uninitialized sender variables in tp_meter,
   by Sven Eckelmann

 - disallow unicast fragment in fragment, by Sven Eckelmann

 - directly shut down tp_meter timer on cleanup, by Sven Eckelmann

----------------------------------------------------------------
Luxiao Xu (1):
      batman-adv: fix tp_meter counter underflow during shutdown

Ruide Cao (1):
      batman-adv: fix fragment reassembly length accounting

Ruijie Li (1):
      batman-adv: clear current gateway during teardown

Sven Eckelmann (11):
      batman-adv: tp_meter: fix tp_vars reference leak in receiver shutdown
      batman-adv: tt: reject oversized local TVLV buffers
      batman-adv: tt: fix negative tt_buff_len
      batman-adv: tt: fix negative last_changeset_len
      batman-adv: tt: fix TOCTOU race for reported vlans
      batman-adv: tt: avoid empty VLAN responses
      batman-adv: tt: prevent TVLV entry number overflow
      batman-adv: dat: handle forward allocation error
      batman-adv: tp_meter: avoid use of uninit sender vars
      batman-adv: frag: disallow unicast fragment in fragment
      batman-adv: tp_meter: directly shut down timer on cleanup

 net/batman-adv/distributed-arp-table.c |  3 ++
 net/batman-adv/fragmentation.c         | 58 ++++++++++++++++++++++++++++++----
 net/batman-adv/gateway_client.c        |  4 +++
 net/batman-adv/tp_meter.c              | 36 +++++++++++++--------
 net/batman-adv/translation-table.c     | 55 ++++++++++++++++++++++++++------
 net/batman-adv/types.h                 |  9 ++++--
 6 files changed, 133 insertions(+), 32 deletions(-)
