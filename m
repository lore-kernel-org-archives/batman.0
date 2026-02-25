Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77BAFEFD20A
	for <batman@archiver.kernel.org>; Wed, 25 Feb 2026 08:47:01 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id B2F06859F3
	for <batman@archiver.kernel.org>; Wed, 25 Feb 2026 09:46:59 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1772009219;
 b=niskOZxbFY0FJmhx48F+gOOjB/NOTCb8b3CcRSdQFoUE0hPRJwEGOA0UqzplUtVe15WfU
 v+HsxCN0M6jjphCZVVI2nmVpqFI+LgA1lxtAAhy1m+/mVoOIagYif6Cibpbz756NwJWfG5G
 FgMyCS0krUo2OTsTBKtxGMBLZUCCRAc=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1772009219; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=9+r/aLXNcZUbizaqmSJ4N85bkD5HLrXYGZvg1TDdi7c=;
 b=d6qgYDT5xlkKZaAmgj6A3+CGFI7Gzm6t3hBmLIc4rYoOzuFWyrk+2zd3DRJMPLA++2ePb
 ymfP2MrFDI+KEZvEADP9SdlhvGsZyVQgLMKxcqr+6VAfYJVSFnbXtT/qXKuy6B/9eN9jCu7
 x3SJo0yk17Qqjy8mS2IVKe9Pr6yLitQ=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=fail;
 arc=pass;
 dmarc=fail header.from=simonwunderlich.de policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=fail; arc=pass;
 dmarc=fail (Used From Domain Record) header.from=simonwunderlich.de
 policy.dmarc=none
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id CDD5984220
	for <b.a.t.m.a.n@lists.open-mesh.org>; Wed, 25 Feb 2026 09:46:19 +0100 (CET)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1772009190;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=9+r/aLXNcZUbizaqmSJ4N85bkD5HLrXYGZvg1TDdi7c=;
	b=YqbGcqEALqfWfmP69ppG6+VqOW1eW3GURJYDB2dQMkZIxRJifuvOLSeREaF3GGri/twP4U
	Q/z2Rni0fllrkd1xI66n62WIOkk78Xx0D3AvY7eBtQRDtxlCpdNJ2cvHsyfLz21oCpKGs9
	BwLnGvlp6eOCqGhJg41SpFRxhTsaa0c=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=none;
	spf=pass (diktynna.open-mesh.org: domain of sw@simonwunderlich.de designates
 23.88.38.48 as permitted sender) smtp.mailfrom=sw@simonwunderlich.de;
	dmarc=pass (policy=none) header.from=simonwunderlich.de
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1772009190;
	b=Ldjsoy/9MrKcNbBaU8B+LkWrqaRavd8WCuTNGOkDDdOs4JOIRC5kvOa9+JW8FB0rN5RDP2
	X0YaxM+u32nKnxb1XQWFf1IpNYpXo2cufE4o5bvvhwW100e/w9ynq229Ykfm1Y5jTTlwCN
	V9EnHCpbYtVbncmCSmR6XWmtMX0zL0U=
Received: from kero.packetmixer.de
 (p200300c5970D83d820CE3bc4f6Cb317e.dip0.t-ipconnect.de
 [IPv6:2003:c5:970d:83d8:20ce:3bc4:f6cb:317e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits)
 server-digest SHA256)
	(No client certificate requested)
	by mail.simonwunderlich.de (Postfix) with ESMTPSA id 274A6FA12C;
	Wed, 25 Feb 2026 09:46:18 +0100 (CET)
From: Simon Wunderlich <sw@simonwunderlich.de>
To: davem@davemloft.net,
	kuba@kernel.org
Cc: netdev@vger.kernel.org,
	b.a.t.m.a.n@lists.open-mesh.org,
	Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH net 0/1] pull request: batman-adv 2025-05-09
Date: Wed, 25 Feb 2026 09:46:13 +0100
Message-ID: <20260225084614.229077-1-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Message-ID-Hash: CIHHXYJ5Z6YEXF4UDBH3T6BURVYGCR5C
X-Message-ID-Hash: CIHHXYJ5Z6YEXF4UDBH3T6BURVYGCR5C
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
Archived-At: <>
List-Archive: <>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

Hi David, hi Jakub,

here is a bugfix for batman-adv which we would like to have integrated into net.

Please pull or let me know of any problem!

Thank you,
      Simon

The following changes since commit 8f7aa3d3c7323f4ca2768a9e74ebbe359c4f8f88:

  Merge tag 'net-next-6.19' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next (2025-12-03 17:24:33 -0800)

are available in the Git repository at:

  https://git.open-mesh.org/linux-merge.git tags/batadv-net-pullrequest-20260225

for you to fetch changes up to cfc83a3c71517b59c1047db57da31e26a9dc2f33:

  batman-adv: Avoid double-rtnl_lock ELP metric worker (2026-02-21 13:01:55 +0100)

----------------------------------------------------------------
Here is a batman-adv bugfix:

 - Avoid double-rtnl_lock ELP metric worker, by Sven Eckelmann

----------------------------------------------------------------
Sven Eckelmann (1):
      batman-adv: Avoid double-rtnl_lock ELP metric worker

 net/batman-adv/bat_v_elp.c      | 10 +++++++++-
 net/batman-adv/hard-interface.c |  8 ++++----
 net/batman-adv/hard-interface.h |  1 +
 3 files changed, 14 insertions(+), 5 deletions(-)
