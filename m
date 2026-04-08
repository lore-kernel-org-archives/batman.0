Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3543D1073C8D
	for <batman@archiver.kernel.org>; Wed,  8 Apr 2026 11:03:19 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 7243E81712
	for <batman@archiver.kernel.org>; Wed, 08 Apr 2026 13:03:17 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1775646197;
 b=uPf/Hv7DHSSf7Z+tgc3XaZ4g3/bIGjAQ5eO56yuiR03EO5f0aDCTdg9na9ZUO598g3EVd
 1mVJmmf8L1sAXHeNHQwuU0fd5LIOsrbQzx1s0DDbA9G1SRPgPMvvN3tuFiwMYcpW85GZr+v
 ghtmKbxJ359WxEaPfqcZ486Dkv+yrMs=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1775646197; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=pJS2ibfOWyySj7tquSq/UocQeHFXSHfn/HFR9aV+i4Y=;
 b=b9xZFd3GHY9cowRvWM1jkP1Rba2c6kuElsHAPEYxb9Ps3we6WFZededyhBVF0+TvDsS9k
 v6tI51mexvLC4/opI7Cg/88uts+QcYjrgbsX4LAFKWCLp9AHgszvSAbg5ygPzq4EMUxDmXI
 s1D7wbGxPLcDikqmbweJ0S2ZIDgW0uU=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass header.from=simonwunderlich.de policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=simonwunderlich.de policy.dmarc=none
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id BDCC580270
	for <b.a.t.m.a.n@lists.open-mesh.org>; Wed, 08 Apr 2026 13:03:03 +0200 (CEST)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1775646183;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:dkim-signature;
	bh=pJS2ibfOWyySj7tquSq/UocQeHFXSHfn/HFR9aV+i4Y=;
	b=B9p/+awVjzVBirB/Zy0wctlpaSnLHO8CIqklPoCN73+4lthJdldpygHIKnPaSodA+aezF7
	zWFBPxaRyEWgrOVvmt579Hr0ssnqgx3ttLnPrUBPFgZcMU8rrUMO7CkECfE4+0VZyx9M8k
	OgiE2ttWebEnhBmHgaTGm805iCojdbM=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=simonwunderlich.de header.s=09092022 header.b=mqrZy+Ay;
	dmarc=pass (policy=none) header.from=simonwunderlich.de;
	spf=pass (diktynna.open-mesh.org: domain of sw@simonwunderlich.de designates
 23.88.38.48 as permitted sender) smtp.mailfrom=sw@simonwunderlich.de
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1775646183;
	b=fM12GHSGB4Wo94Dfg3Sqq7VMswTIrKHpNc49sMwYghVt9kX8Nf/5e0CLYEsbD8CZFNIwZG
	4qysqcI/d8SHglkAPfMGqselDHn8zNAxQVjllgiYHHBfY8eYGp5KnQS18XZ76wXxVhJn50
	ZTIxhJ8YzLOG8MwTkxMn0IrDM1CFg1U=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1775646182;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=pJS2ibfOWyySj7tquSq/UocQeHFXSHfn/HFR9aV+i4Y=;
	b=mqrZy+AyIsuGGaULaUhSwNWvYnzFI13etUrR5xa0reTzbXUSPagIzqtXiq/0mcuap+KGjd
	43OaVeulFeo56UFFDUH5q7uEBbZV0raavHkqF3qCci1XukfhRCKqJ5lNY3Dn7VATEJWf05
	It7gqgtNRUFReLswtLfFMNPMFG4U+WCK4OaCqUIo3Xawzzwgy3tSh6UX4VYF97omYCQfKM
	nz7GoKWgcyTYylkjIeXuFBK8xIto+K1RgB9iyc3jH0fC0bqcbYYoGSUVU5daFaVlydLsm1
	rTJrjoP/WzvyBLDvSNzinYfMDApX2EnyTZ5jA8+cXStMYpfRT1ojF4tJvb8FfA==
From: Simon Wunderlich <sw@simonwunderlich.de>
To: davem@davemloft.net,
	kuba@kernel.org
Cc: netdev@vger.kernel.org,
	b.a.t.m.a.n@lists.open-mesh.org,
	Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH net 0/2] pull request: batman-adv 2025-04-08
Date: Wed,  8 Apr 2026 13:02:53 +0200
Message-ID: <20260408110255.976389-1-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: CW57MFLH5O322K73MLAZV4FUMR324Y2E
X-Message-ID-Hash: CW57MFLH5O322K73MLAZV4FUMR324Y2E
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/CW57MFLH5O322K73MLAZV4FUMR324Y2E/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

Hi David, hi Jakub,

here are two bugfixes for batman-adv which we would like to have integrated into net.

Please pull or let me know of any problem!

Thank you,
      Simon

The following changes since commit 0d4aef630be9d5f9c1227d07669c26c4383b5ad0:

  batman-adv: avoid OGM aggregation when skb tailroom is insufficient (2026-03-14 08:29:47 +0100)

are available in the Git repository at:

  https://git.open-mesh.org/linux-merge.git tags/batadv-net-pullrequest-20260408

for you to fetch changes up to 82d8701b2c930d0e96b0dbc9115a218d791cb0d2:

  batman-adv: hold claim backbone gateways by reference (2026-04-06 15:42:29 +0200)

----------------------------------------------------------------
Here are two batman-adv bugfixes:

 - reject oversized global TT response buffers, by Ruide Cao

 - hold claim backbone gateways by reference, by Haoze Xie

----------------------------------------------------------------
Haoze Xie (1):
      batman-adv: hold claim backbone gateways by reference

Ruide Cao (1):
      batman-adv: reject oversized global TT response buffers

 net/batman-adv/bridge_loop_avoidance.c | 27 ++++++++++++++++++---------
 net/batman-adv/translation-table.c     |  9 +++++++--
 2 files changed, 25 insertions(+), 11 deletions(-)
