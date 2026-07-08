Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8A1AC44503
	for <batman-adv@archiver.kernel.org>; Wed,  8 Jul 2026 09:22:04 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 144AB84772
	for <batman-adv@archiver.kernel.org>; Wed, 08 Jul 2026 11:22:03 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1783502523;
 b=n5n0nFbR1hD5IGvtBtNA9UyYy6tdZZC7AhbWorpEg62m4d9nSKgObWy8QpU1CvnHOcCDX
 SntZ+RF8SN/HtVRJBOJf+Ufz5Qef0eaWxb7Y+1MA9ayiWRHTwPmbQF3PG2hPw/ibDYVV/vi
 U2Raa2ozJbXMoVAInape5mxf4zDdKls=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1783502523; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=XWkYU4Tl1LIlSBFPEbkVF+ndyjxVNCuoXkEReRpmdi4=;
 b=iW4IvQCsRzLIi1NVwDXdhsMgtYrdATw5ujp3Psu1my7IUovNFgGXY64y1tYoHVJjKtsPB
 5HhaZB1SqPTAajHqL10SBSPf6p8lHH/2+eJPfPlI1+/j6QtI56cF7FWMF7csaMDEnt9DkBj
 xwLHTyvZSKjQD0nRGLS9Ag8n0pxNypM=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass header.from=simonwunderlich.de policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=simonwunderlich.de policy.dmarc=none
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de
 [IPv6:2a01:4f8:c17:e8c0::1])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 4CA0F81E8C
	for <b.a.t.m.a.n@lists.open-mesh.org>; Wed, 08 Jul 2026 11:18:39 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1783502324;
	b=Vy5OdjrYAFqViS+vhamkP+bjYQIcQ1VoGHW37OMGQpZmv4NFnaPqcWLq32DRil4J0Tcf2P
	YdPfWM3xWsXY7Ab+eWqskI977T1q33XX4DKl5fakUS39fK+Jycdkux8CfQ1Qncn0+eVeN5
	g9ceaAYbIxvrcfzfimRceNuvl8WcJUw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1783502324;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:dkim-signature;
	bh=XWkYU4Tl1LIlSBFPEbkVF+ndyjxVNCuoXkEReRpmdi4=;
	b=1tcSDDgYcPQP1VL08R5NSq6Z135XD2DVN5EYuOzGvO/2HhKbLNadex5qcl/ZWqaTzQ9vKE
	WJDGzQTUgvLFrMTXuq8F8iyvAibACB3ivOIFLYRG9QuxmWqTm3tUr9hWI4ON9HckQAREDj
	vHlzYgJ5BgRbA0cO8/x9lbJbzv8EUbc=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=simonwunderlich.de header.s=09092022 header.b=XAtDioUD;
	spf=pass (diktynna.open-mesh.org: domain of sw@simonwunderlich.de designates
 2a01:4f8:c17:e8c0::1 as permitted sender)
 smtp.mailfrom=sw@simonwunderlich.de;
	dmarc=pass (policy=none) header.from=simonwunderlich.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1783502316;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=XWkYU4Tl1LIlSBFPEbkVF+ndyjxVNCuoXkEReRpmdi4=;
	b=XAtDioUDr99Cgtu7OTy1gMTDubFDxzvz5iPtM3udwsCPfWhxUsrk9zl69t+IeJ57MxJmbD
	9hJc61i3XPFYxM2lJJF00zroGHFBckEJuzh6iqJ8rbG84BR0Vj3knN/uyhepxQbAh2rVYo
	mq5zfOaIpE2FukxV8EBeXO4i8DPgItpHzoaK03e6TRbMRO9hoCWelmIm31PY3N8flQxUFH
	SC5tVQoy25Fxgvvo3iubb9GWLIhlxEgULUWRLUnNOu1y6Ial0xLcC9rshhF+OSN5npFHUF
	VV1VpqdIaxWl8qr3KDLFMSSyVe67xIMRfzPuWNNgJBDg8Z19onux6hyz0Qe+1Q==
From: Simon Wunderlich <sw@simonwunderlich.de>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	b.a.t.m.a.n@lists.open-mesh.org,
	Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH net 0/9] pull request: batman-adv 2026-07-08
Date: Wed,  8 Jul 2026 11:18:12 +0200
Message-ID: <20260708091821.314516-1-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: LLZCN3X3FPUH7GFNGOHST6VLTLR5UUCN
X-Message-ID-Hash: LLZCN3X3FPUH7GFNGOHST6VLTLR5UUCN
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/LLZCN3X3FPUH7GFNGOHST6VLTLR5UUCN/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

Dear net maintainers,

here are some more smaller bugfixes for batman-adv which we would like
to have integrated into net.

Please pull or let me know of any problem!

Thank you,
      Simon

The following changes since commit 26560c4a03dc4d607331600c187f59ab2df5f341:

  batman-adv: dat: ensure accessible eth_hdr proto field (2026-06-28 11:49:04 +0200)

are available in the Git repository at:

  https://git.open-mesh.org/batadv.git tags/batadv-net-pullrequest-20260708

for you to fetch changes up to 98052bdaf6ac1639a63ffc10244eeeab1f62ed2b:

  batman-adv: dat: fix tie-break for candidate selection (2026-07-06 07:18:59 +0200)

----------------------------------------------------------------
Here are some batman-adv bugfixes, all by Sven Eckelmann:

 - ensure minimal ethernet header on TX

 - fix VLAN priority offset

 - clean untagged VLAN on netdev registration failure

 - tt: avoid request storms during pending request

 - tt: prevent TVLV OOB check overflow

 - frag: free unfragmentable packet

 - frag: fix primary_if leak on failed linearization

 - mcast: avoid OOB read of num_dests header

 - dat: fix tie-break for candidate selection

----------------------------------------------------------------
Sven Eckelmann (9):
      batman-adv: ensure minimal ethernet header on TX
      batman-adv: fix VLAN priority offset
      batman-adv: clean untagged VLAN on netdev registration failure
      batman-adv: tt: avoid request storms during pending request
      batman-adv: tt: prevent TVLV OOB check overflow
      batman-adv: frag: free unfragmentable packet
      batman-adv: frag: fix primary_if leak on failed linearization
      batman-adv: mcast: avoid OOB read of num_dests header
      batman-adv: dat: fix tie-break for candidate selection

 net/batman-adv/distributed-arp-table.c |  2 +-
 net/batman-adv/fragmentation.c         |  8 +++++---
 net/batman-adv/main.c                  | 10 +++++++++-
 net/batman-adv/mesh-interface.c        | 16 +++++-----------
 net/batman-adv/mesh-interface.h        |  2 ++
 net/batman-adv/multicast_forw.c        |  7 +++----
 net/batman-adv/translation-table.c     |  5 +++--
 7 files changed, 28 insertions(+), 22 deletions(-)
