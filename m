Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F0C4C43458
	for <batman-adv@archiver.kernel.org>; Tue, 30 Jun 2026 13:45:38 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id BF70782F12
	for <batman-adv@archiver.kernel.org>; Tue, 30 Jun 2026 15:45:36 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1782827136;
 b=WCqLwgZeAtCVEkcH1FrH51HgeylIJwOdO/FSQW00tthzHMNhUE3E7qPeE8je0ZyxIl6jN
 1MJ4FlBqPkNxQe4mA+lYUDQbeY8ycdNE6O1s30rNG9WYsb8gN2/fDhlPr3jzEc+4j2fWkvK
 s12jNTEiwlYoryEoLrJS1CntIM6lzAM=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1782827136; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=chPXv7++l38ngSLvkWCokAnOz0yB1awOLYQnYMHr4js=;
 b=xMIvAD6gj+sDT7FFOM20aqUfae7xvHHMFS7CHAVSnC0ODguIchr4ZpIVfgZfV6bC8UI0C
 ZT77pDugpe9bLNyJojDRpivJOVsTr28o3vAl07rseivbUWDb93pYbvZZ/Ya5LvmcMMtXNxi
 YobMuMKCuhbSw4fZpXQ59gTqgDzKDD8=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass header.from=simonwunderlich.de policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=simonwunderlich.de policy.dmarc=none
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de
 [IPv6:2a01:4f8:c17:e8c0::1])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id C703980C21
	for <b.a.t.m.a.n@lists.open-mesh.org>; Tue, 30 Jun 2026 15:44:33 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1782827073;
	b=TCvplGV9CXfSFK7AuRaJgpqZuoidfJW4NNBagJ6E87vaUbuAQ2VJkExXPbKoVlFW9kzO64
	MQJpqTIBR9B5Sp+0ELNXtWG7RskdXlb4Y925bDCzMGJgwOBC1IYtX7pyZ4WqBA393aR9Q5
	Z2aSjjYhM/UoaorWXxyxgqdffKcxRvA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1782827073;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:dkim-signature;
	bh=chPXv7++l38ngSLvkWCokAnOz0yB1awOLYQnYMHr4js=;
	b=yeJt9cPe/YRJGyBvvfbaTrIqBapq+l41yypKyOLukDhZKvZyIjYflNFDmv/615Iw532f6a
	dLamfHV4WVSgYV5NqNtEk2+X0NliL3VEHvOVWZAAAWAbX0FOt9Un7rIqI+6294jcrUvBw1
	sTVobWIcc+ohPp0PnxkJBRuq/ULcdO8=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=simonwunderlich.de header.s=09092022 header.b=wYd2D1cD;
	spf=pass (diktynna.open-mesh.org: domain of sw@simonwunderlich.de designates
 2a01:4f8:c17:e8c0::1 as permitted sender)
 smtp.mailfrom=sw@simonwunderlich.de;
	dmarc=pass (policy=none) header.from=simonwunderlich.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1782827071;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=chPXv7++l38ngSLvkWCokAnOz0yB1awOLYQnYMHr4js=;
	b=wYd2D1cDDBHMXhRtV125IjhreNgzEkma9b8QF9y8aERTZX18kz/zd99boU6xPGFX5VjHFX
	J2kBaipvq1qLTOtXh7ch2IuHp8yBKlAhpKOE1L2F3C59vCiSSrC6+CnhmuEjwi0lpubU9Y
	uCNbOAzh6ciOGVR3SQY1Suam1jN4Xban/kExSjtjz/l03vvuj6iysv5SV+7ClNPdgmVxdk
	Z0fVPP8pJpdC3GE2IiBy0MIJ2s3ZwQVzZwfeE/CKkysViE2evhxyB0cNwWQ+RcnglBS9wU
	/RARVCvmu9RtgpmPw8AgpPG4r83ZH7Hav1ny8pOBAq/d2l3qX3cNjX6ngllsRw==
From: Simon Wunderlich <sw@simonwunderlich.de>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	b.a.t.m.a.n@lists.open-mesh.org,
	Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH net 0/6] pull request: batman-adv 2026-06-30
Date: Tue, 30 Jun 2026 15:44:24 +0200
Message-ID: <20260630134430.85786-1-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: SFR4PBUDPFMHA245NMCOI4EV7CD7B2IM
X-Message-ID-Hash: SFR4PBUDPFMHA245NMCOI4EV7CD7B2IM
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/SFR4PBUDPFMHA245NMCOI4EV7CD7B2IM/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

Dear net maintainers,

here are a couple of bugfixes for batman-adv which we would like to have integrated into net.

Please pull or let me know of any problem!

Thank you,
      Simon

The following changes since commit 805185b7c7a1069e407b6f7b3bc98e44d415f484:

  Merge tag 'net-7.2-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net (2026-06-25 12:25:36 -0700)

are available in the Git repository at:

  https://git.open-mesh.org/batadv.git tags/batadv-net-pullrequest-20260630

for you to fetch changes up to 26560c4a03dc4d607331600c187f59ab2df5f341:

  batman-adv: dat: ensure accessible eth_hdr proto field (2026-06-28 11:49:04 +0200)

----------------------------------------------------------------
Here are some batman-adv bugfix, all by Sven Eckelmann:

 - fix pointers after potential skb reallocs (5 patches)

 - dat: ensure accessible eth_hdr proto field

----------------------------------------------------------------
Sven Eckelmann (6):
      batman-adv: retrieve ethhdr after potential skb realloc on RX
      batman-adv: access unicast_ttvn skb->data only after skb realloc
      batman-adv: gw: acquire ethernet header only after skb realloc
      batman-adv: dat: acquire ARP hw source only after skb realloc
      batman-adv: bla: reacquire gw address after skb realloc
      batman-adv: dat: ensure accessible eth_hdr proto field

 net/batman-adv/distributed-arp-table.c | 28 +++++++++++++++++++++++++++-
 net/batman-adv/gateway_client.c        |  3 ++-
 net/batman-adv/main.c                  |  3 +++
 net/batman-adv/mesh-interface.c        |  1 +
 net/batman-adv/routing.c               |  3 ++-
 5 files changed, 35 insertions(+), 3 deletions(-)
