Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29D95C5AC67
	for <batman-adv@archiver.kernel.org>; Thu,  6 Aug 2026 19:03:33 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 3E6F6815E0
	for <batman-adv@archiver.kernel.org>; Thu, 06 Aug 2026 21:03:27 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1786043007;
 b=Iod49ZP3JuAUpiPD914uB7nndnNnzGUMqq1uz64GU0lqHOvg3ftn595V7et1Mr8VbQcbY
 OAu1rzPa4jqrNmghPo0YRUAjIkpTNtmn6+mqywnwrHjaOdpensrkaFqO0lYNSg9ner75yjX
 qkfgtVnijqpvAMyOC6kN7X3kWhsc7qk=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1786043007; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=A3eYNm4yE7wmdMIoDOQgACjJDV6r2aC5+hcKgJ1CGr0=;
 b=BsEE8jkLm1NxLbsSIQ05O0rJubnWG6c+xgOvnmKH+UhHzfD1pSZsVluoyFwb9W1fFDE0r
 iO4rMF37crL93b3/8dx8YQonY9nCYhQ8KCK73UZ6Fs40d4dap90VMkef17Sr2DFLiGBCmVM
 SgWvRfTu/z/nEWBx9365txZAHmfJFaI=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org
 [IPv6:2a00:17d8:100::8b1])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 0199C81E08
	for <b.a.t.m.a.n@lists.open-mesh.org>; Thu, 06 Aug 2026 20:55:24 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1786042535;
	b=xBdrInX7LyG35w4SYtwV+vmAllR9WNquGzVnnF3BxXv8ObhOLkr/QQBnKtQxKqrVqNKP/+
	LjOzDCBgN06HJoXFSb0DqNiZ4q7YXzk7rZhN/U6oexV317rcdDMwO7h1RZXvyTQ387nYZK
	9ysCf2fi45YH/XM/y60s+pAfuIXA/6w=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1786042535;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:dkim-signature;
	bh=A3eYNm4yE7wmdMIoDOQgACjJDV6r2aC5+hcKgJ1CGr0=;
	b=zCF2KxdxpxOICq+NwS3RrKDQYFKG6nAxuFYxk9Jsv2BV9Zp5gv2ZkK1LYf9ET+3gdu3pEY
	9Up+Bg2jtQ3s6SawD5OP+Ntws77PtmMyBUsBBrRR60IHSCHIyYIGS97jx8n5dOa/Rc6gOX
	NiJSDk9Rd9Ig+CNq70PjjtS50kAsbRo=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=hLNpDN9U;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id 23DC52083E;
	Thu, 06 Aug 2026 18:55:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1786042520;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=A3eYNm4yE7wmdMIoDOQgACjJDV6r2aC5+hcKgJ1CGr0=;
	b=hLNpDN9UJBiLPwIzg1CAoXhmvAP1d0U7mbFfU28jHqgxQXHbzliE3AxrT6FyTAN5pARa0j
	zhfnlx2CdFDwFtCgQeMSeWkAhm2mkW+AONNbJwsXtPKgpyx5kMNmx3yVOB3ZBhtQeM8Y7t
	ymMFNoSfrUmkr3snEXgt8EzHzYJOus8=
From: Sven Eckelmann <sven@narfation.org>
Subject: [PATCH batadv 0/3] batman-adv: bat_v: fix bonding candidate
 selection
Date: Thu, 06 Aug 2026 20:54:52 +0200
Message-Id: <20260806-bat_v-sob-kdoc-v1-0-ba4d763de0da@narfation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHzYdGoC/yWM0QrCMAxFf2Xk2UAsbnT+ioi0TdQorNLMIoz9+
 6o+nss9ZwGTomJw7BYoUtU0Tw32uw7SPUw3QeXG4MgN5GnAGOZLRcsRn5wTMh1GT+J8zyM06VX
 kqp9f8ATtG7jC+b/bOz4kzd8arOsGV3//KHoAAAA=
X-Change-ID: 20260806-bat_v-sob-kdoc-d04980e285d9
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>, Sashiko <sashiko-bot@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1388; i=sven@narfation.org;
 h=from:subject:message-id; bh=BC7IiBjaJR08XHBVYolphOhO2NqPE0C72ieZ+yLCkx4=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFklN1o52LR4Th1aEWSd9SUorVuN9/HmJrl35RUlbyb21
 G8M393QUcrCIMbFICumyLLnSv75zexv5T9P+3gUZg4rE8gQBi5OAZiI5DaGfwZHomJfXXQpWPPI
 yvPvphqrSTw/tBPMTu7ZHtX85S7P0V5GhnthXsoHbRhcK2SiORb5L34rsIVrXnxjXeW/t6/3Rm1
 MYAYA
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: TPSRKMHIWKTXSKU7SJWISVFWUKMHMFQT
X-Message-ID-Hash: TPSRKMHIWKTXSKU7SJWISVFWUKMHMFQT
X-MailFrom: sven@narfation.org
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/TPSRKMHIWKTXSKU7SJWISVFWUKMHMFQT/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

batadv_v_neigh_is_sob() implements the metric (throughput) similarity check
as:

  neigh2 (the reference) has a better throughput than 3/4 of the neigh1
  (candidate) throughput

But this results in a selection of bonding candidates in
batadv_find_router() which have a really low throughput. But the goal must
be to select candidates which have a good throughput.

The neigh1/neigh2 operands must be swapped in the comparison to use the
reference as such and select only neighbor+interface combinations with good
throughput.

To make the code more readable, use the names "candidate" and "reference"
instead of "neigh1" + "neigh2".

See https://www.open-mesh.org/issues/464

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
Sven Eckelmann (3):
      batman-adv: bat_v: fix bonding candidate selection
      batman-adv: clarify cut-off in batadv_v_neigh_is_sob kernel-doc
      batman-adv: use more descriptive var names for is_similar_or_better

 net/batman-adv/bat_iv_ogm.c | 25 +++++++++++++------------
 net/batman-adv/bat_v.c      | 42 +++++++++++++++++++++---------------------
 net/batman-adv/types.h      | 12 ++++++------
 3 files changed, 40 insertions(+), 39 deletions(-)
---
base-commit: 6ff21902725ca4c437f6d60774e903ecdca2e645
change-id: 20260806-bat_v-sob-kdoc-d04980e285d9

Best regards,
--  
Sven Eckelmann <sven@narfation.org>

