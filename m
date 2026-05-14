Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C019CD4851
	for <batman@archiver.kernel.org>; Thu, 14 May 2026 17:07:32 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id AD2C885D52
	for <batman@archiver.kernel.org>; Thu, 14 May 2026 19:07:30 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1778778450;
 b=SpNve7IvX0OLutrQ2EzpUzN9sc62itr7lbkgnPj+zy0vrQH5ddbZvyHSHea336q/JBdfU
 8Z+48q1UgN8020BUyMVx9/xtertMQ8NkyrmKP6eKFD4OU77ouAoutc/5bgaKXIXiLkXG22D
 wMp1d0xO4lHKQC2+m729XKCcVd0AJ9s=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1778778450; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=p5Yr9CtfWmpTfHYqGMNWpJ1hI81HRyEDRV6Z0ltalIE=;
 b=TAFap5YRY6PtSE1byUzrCet4n8e/nW2584gI8L4N0+LgyAIBRfNpSeEkrL2Y70QB784nT
 kGZqgoZdnwvFh2l7ZDOUvsVatizoXvMTmCqSKjeZMigcJmflnYHkoy5I0d1YnxsejJm9hNi
 wq9Pz9PS04zSqTL3Uty7eQhQr/7lfjQ=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org
 [IPv6:2a00:17d8:100::8b1])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id E1E9E8195D
	for <b.a.t.m.a.n@lists.open-mesh.org>; Thu, 14 May 2026 19:06:56 +0200 (CEST)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1778778426;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=p5Yr9CtfWmpTfHYqGMNWpJ1hI81HRyEDRV6Z0ltalIE=;
	b=N0duhgYe97a7HjSTo9CeOhMM16pRq0gFgl3uPNja0g0gl1mUmcZIXGsin+yLeN8LxkdX8x
	cGCOFcVvyJB6IcGVMa7pyaEmTi4m+UF7uqQI4cFpExJNAEb6/K1KfiO0cCTijc6x9iA4TM
	lmHuirPH0urcwijgKmzrGZ4ByLHg6sM=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b="oFG/4Xq1";
	dmarc=pass (policy=none) header.from=narfation.org;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1778778426;
	b=QkLFyN9F4L29Lva3TjA3YZ8ZJaK04BdbzOeomLPbDVcM8OvhIJQz3xgXAYjOU1U3yNmdgM
	RcBndkrPsz9mqzGjC9TR+seGLb4sqtgxOJWImDq8U+BbKT06QAEETHhdoFcjrcptU50l1u
	MMRPRD10F8Qr6sGu8TV1U//Ya9YZOI8=
Received: by dvalin.narfation.org (Postfix) id 1CF8E218A8;
	Thu, 14 May 2026 17:06:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1778778414;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=p5Yr9CtfWmpTfHYqGMNWpJ1hI81HRyEDRV6Z0ltalIE=;
	b=oFG/4Xq1wvBjG0U4vlPTQbLldbfyboB2Tg/XanqHx18JiMPxsQG1496941Stfckx+iO7NQ
	21shzXwKOV2LH1t/nWkvDYHGTCbPlrotLoopuajwMxqc5ORASSIYolusYqIdxteu4nSMyt
	TaISDDYJGSmMVFg4K5WQ2ysf+BxbVx8=
From: Sven Eckelmann <sven@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org, Ren Wei <n05ec@lzu.edu.cn>
Cc: marek.lindner@mailbox.org, sw@simonwunderlich.de, antonio@mandelbit.com,
 yuantan098@gmail.com, yifanwucs@gmail.com, tomapufckgml@gmail.com,
 bird@lzu.edu.cn, ruijieli51@gmail.com, lzhanpeng2025@lzu.edu.cn
In-Reply-To: 
 <05bdee6e85c3514822f98afa8fb75826b3928dd0.1778671969.git.ruijieli51@gmail.com>
References: 
 <05bdee6e85c3514822f98afa8fb75826b3928dd0.1778671969.git.ruijieli51@gmail.com>
Subject: Re: [PATCH batadv 1/1] batman-adv: clear current gateway during
 teardown
Message-Id: <177877840509.69270.8247149631226619599.b4-ty@b4>
Date: Thu, 14 May 2026 19:06:45 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=298; i=sven@narfation.org;
 h=from:subject:message-id; bh=9Xm+Hs4LX7N4ocyKrxaKIbZDNhS+PT5gswrri6zD/0o=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFlsjOpB+0zVij5/S1SZPJOpMTNPbp7ZN/1LihudNuhnf
 /678X5bRykLgxgXg6yYIsueK/nnN7O/lf887eNRmDmsTCBDGLg4BWAimxwYGbbtOux92Gl3Yv29
 ZzFFdUoh3N78nwP8hO6/WffN7SSn0j9Ghg6Nky/41F6GnOB/FO+ytPVXS2dTwI4W6ROm15aebv6
 2nhsA
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: NBTCORSR73RZM654O22YUOKTSL6FVKEH
X-Message-ID-Hash: NBTCORSR73RZM654O22YUOKTSL6FVKEH
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/NBTCORSR73RZM654O22YUOKTSL6FVKEH/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>


On Thu, 14 May 2026 16:13:25 +0800, Ren Wei wrote:
> batman-adv: clear current gateway during teardown

Applied, thanks!

[1/1] batman-adv: clear current gateway during teardown
      https://git.open-mesh.org/batadv/c/a340a51ed801

Best regards,
-- 
Sven Eckelmann <sven@narfation.org>

