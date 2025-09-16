Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95193CAC599
	for <batman-adv@archiver.kernel.org>; Tue, 16 Sep 2025 12:26:12 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 168CB8464E
	for <batman-adv@archiver.kernel.org>; Tue, 16 Sep 2025 14:26:11 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1758025571;
 b=P8mXPSnBJUyrgFVjd44zJwTJwbQAAzbATFKFUAbn8+r+beb8zGbXR73sPzO6HOoF162tE
 /Wf73eOZs3EUGYRiznhtGoXzSgXwlHaE209Qz+9EbZEvgpqijEMBQTYyoCr/qq4FSi5Ao8Q
 yy7qj4LsxPpQ7lREM62KQQidLU3EyH8=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1758025571; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=bpZbzm6HFqBxvcfchyUSBFLGW8UOsoL3GVzpxa8bmD0=;
 b=aYseaXf7CmCes4GoByfbUttAkfYGdc6/zByNhkpdIlBGS0C25Kpeq+OcOoJnrOVcvMsFM
 FRNdFYy7y76eCZwn+ir6mbnc6AKEsGnP/3RKU4+aYucCGpXnQP2Ml7rpVm/JkUp3/2kU6ag
 junvaAGKmbXaGBarPDnK5IRLzO3uPFQ=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=fail;
 arc=pass;
 dmarc=fail header.from=simonwunderlich.de policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=fail; arc=pass;
 dmarc=fail (Used From Domain Record) header.from=simonwunderlich.de
 policy.dmarc=none
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 72F4B845FB
	for <b.a.t.m.a.n@lists.open-mesh.org>; Tue, 16 Sep 2025 14:24:49 +0200 (CEST)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1758025494;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=bpZbzm6HFqBxvcfchyUSBFLGW8UOsoL3GVzpxa8bmD0=;
	b=quktvz1tIkrlIMCnVCRZYhlk9MTXa55GXHzQSNeC5UFD3BfWMR4uZaDcD1rILXgxGtltyw
	LcAHbYm40v79QFqxa7CYxiAeapc0NdBsRuxBhEuFSPjp+HnNowfzHPKoXcRAfuqGwJ2coT
	v7Cdi2+UAr5coEdEqlzGWV0XDDYYgk0=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=none;
	dmarc=pass (policy=none) header.from=simonwunderlich.de;
	spf=pass (diktynna.open-mesh.org: domain of sw@simonwunderlich.de designates
 23.88.38.48 as permitted sender) smtp.mailfrom=sw@simonwunderlich.de
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1758025494; a=rsa-sha256;
	cv=none;
	b=CDYiI09t6NAIyav6pOKgXSGds8aj6+Lf1FtjNV9yqw8Ix110Ap+gtGfMcT4v2bYmI6Qt98
	GYF2Dj/1KcTD4QTiX14/zfau8/mnxvUjK8r4kRyPM/y4lHtD7de3cPMGd/GLvgGCCOiHDg
	Go8tqjoW9XtbeFDCbOjT1pUsOhIwgfk=
Received: from kero.packetmixer.de
 (p200300c5972536D8604E0A64d0d3AAD8.dip0.t-ipconnect.de
 [IPv6:2003:c5:9725:36d8:604e:a64:d0d3:aad8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits)
 server-digest SHA256)
	(No client certificate requested)
	by mail.simonwunderlich.de (Postfix) with ESMTPSA id D79CDFA12C;
	Tue, 16 Sep 2025 14:24:48 +0200 (CEST)
From: Simon Wunderlich <sw@simonwunderlich.de>
To: kuba@kernel.org,
	davem@davemloft.net
Subject: [PATCH net-next 0/4] pull request for net-next: batman-adv 2025-09-16
Date: Tue, 16 Sep 2025 14:24:37 +0200
Message-ID: <20250916122441.89246-1-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Message-ID-Hash: VHRTD3JNK54CF3B7KQ26XFBT27NQFVBE
X-Message-ID-Hash: VHRTD3JNK54CF3B7KQ26XFBT27NQFVBE
X-MailFrom: sw@simonwunderlich.de
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-b.a.t.m.a.n.lists.open-mesh.org-0;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-1;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-2; emergency; member-moderation;
 nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size;
 news-moderation; no-subject; digests; suspicious-header
CC: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/VHRTD3JNK54CF3B7KQ26XFBT27NQFVBE/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>


Hi Jakub, hi David,

here is a cleanup pull request of batman-adv to go into net-next.

This time we use a https pull request link as we have turned off our
public git protocol server - sorry for the hiccup last time, I hope
everything is smooth now.

Please pull or let me know of any problem!

Thank you,
      Simon

The following changes since commit d69eb204c255c35abd9e8cb621484e8074c75eaa:

  Merge tag 'net-6.17-rc5' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net (2025-09-04 09:59:15 -0700)

are available in the Git repository at:

  https://git.open-mesh.org/linux-merge.git tags/batadv-next-pullrequest-20250916

for you to fetch changes up to 629a2b18e8729497eeac5b63e575e0961ca3a4ab:

  batman-adv: remove includes for extern declarations (2025-09-05 15:11:02 +0200)

----------------------------------------------------------------
This cleanup patchset includes the following patches:

 - bump version strings, by Simon Wunderlich

 - Remove network coding support, by Sven Eckelmann (2 patches)

 - remove includes for extern declarations, by Sven Eckelmann

----------------------------------------------------------------
Simon Wunderlich (1):
      batman-adv: Start new development cycle

Sven Eckelmann (3):
      batman-adv: remove network coding support
      batman-adv: keep skb crc32 helper local in BLA
      batman-adv: remove includes for extern declarations

 net/batman-adv/Kconfig                 |   13 -
 net/batman-adv/Makefile                |    1 -
 net/batman-adv/bat_iv_ogm.c            |    5 -
 net/batman-adv/bridge_loop_avoidance.c |   34 +
 net/batman-adv/hard-interface.c        |    1 +
 net/batman-adv/hard-interface.h        |    1 -
 net/batman-adv/log.h                   |    3 -
 net/batman-adv/main.c                  |   50 -
 net/batman-adv/main.h                  |    5 +-
 net/batman-adv/mesh-interface.c        |   15 +-
 net/batman-adv/mesh-interface.h        |    1 -
 net/batman-adv/netlink.c               |   17 -
 net/batman-adv/netlink.h               |    1 -
 net/batman-adv/network-coding.c        | 1878 --------------------------------
 net/batman-adv/network-coding.h        |  106 --
 net/batman-adv/originator.c            |    6 -
 net/batman-adv/routing.c               |    9 +-
 net/batman-adv/send.c                  |   16 +-
 net/batman-adv/translation-table.c     |    4 +-
 net/batman-adv/types.h                 |  216 ----
 20 files changed, 41 insertions(+), 2341 deletions(-)
 delete mode 100644 net/batman-adv/network-coding.c
 delete mode 100644 net/batman-adv/network-coding.h
