Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58A21C282EC
	for <batman@archiver.kernel.org>; Tue, 18 Mar 2025 13:45:24 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id E210D83BF0
	for <batman@archiver.kernel.org>; Tue, 18 Mar 2025 14:45:22 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1742305522;
 b=DL7X64as2J1Z1ow1mBSbRQxVaTRQq+JIFhMlK6TxQVE9dwN5gLX+NqNKb7dlSQxUSBukK
 3c6/qqqf7epTfxKFqdBHyLmIO9TuDw1Gmkkr7z0lkAGKn6u6m5YMAFPZQWjdFtCuWfICvou
 HTUnWcLKLl2YXJzPzvycFS1pB567fro=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1742305522; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=OcSTZcGwm0Ufp/SuCoUfQrUUcXsmfnW04AtmtgJKBUE=;
 b=s12jBTGF6M6X3Nxuq9TLYwT4/Qq82QS6qtV6WEdgE3Z188nAPbMUBH2DVUrkdG9ZiX6Mo
 gwDKPWslev7yymFlIZDRoROqAywrSigWMi/ohOitWHpAKIBhD5xmikRYqhyk+RirLEvoYIT
 rzzeTkHkhnGmrlSnFMmzeFR8Ry0iEoo=
ARC-Authentication-Results: i=2; open-mesh.org; dkim=pass header.d=kernel.org;
  arc=pass;
  dmarc=pass (Used From Domain Record) header.from=kernel.org
 policy.dmarc=quarantine
Authentication-Results: open-mesh.org; dkim=pass header.d=kernel.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=kernel.org policy.dmarc=quarantine
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id A2F4280926
	for <b.a.t.m.a.n@lists.open-mesh.org>; Tue, 18 Mar 2025 12:30:05 +0100 (CET)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1742297406;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=OcSTZcGwm0Ufp/SuCoUfQrUUcXsmfnW04AtmtgJKBUE=;
	b=o5nymtbl5iezFa4MF7MoVssgEEFGpku2Cutv+O8zDPdIDLFymSZ6YdiNHuwSSVhHn8ymI6
	SKC4vptp2vN3wMcx6PX5uv5Bbo+QHJn6q5mWWSJygPnPe7AruO8vg4B1TFYUlDV7CmnTu3
	puxluFXlVyYqlFhzqfLnATASbUCHdCg=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=kernel.org header.s=k20201202 header.b=tq48iJkb;
	spf=pass (diktynna.open-mesh.org: domain of
 patchwork-bot+netdevbpf@kernel.org designates 2604:1380:4641:c500::1 as
 permitted sender) smtp.mailfrom=patchwork-bot+netdevbpf@kernel.org;
	dmarc=pass (policy=quarantine) header.from=kernel.org
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1742297406; a=rsa-sha256;
	cv=none;
	b=UqtOKLGlDOI5fARIWT1R67qbokophEy/4pqCAOHHt/lDdb4xm4pTngMtmTT2Z5hgl/RYSe
	v2pCj7HshboIcIUxHgwGgJfUs/nQwHimDEhKYHFV8Rmlh2cT10/y81tieZD0Kj7AvLXdBm
	iiXXMW/Xg8AOdeSdZ8WXn/AaFr6fCzc=
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 3DFDB5C58C1;
	Tue, 18 Mar 2025 11:27:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D06CEC4CEE3;
	Tue, 18 Mar 2025 11:30:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742297403;
	bh=r69d5xBhzd1oSteBxc/VbEo1hdNp79uDB5aVghpztaM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=tq48iJkbASb1aHOoBxNL5OirnAc/ZAXyLmWNVOJUyEerYnbT3RKLOwQwNTvU3wu0A
	 xXyx4dN2d7skqwW/+Q2IDUvy/acx9JI/RrGOGx8CEGhhAvkDnCsW8IsAWJ7aJV9ZSd
	 9sc/IY5mPGN8nlJ1laO6KNvJKS+/8J0lr/NHoXLOarFSMkTMyEPTigG0E14jswBvGa
	 geG+19Og1xndvUvMrOZr0Mhq51cFeXpTV85Zl2mFHeJkZBc1VVgRF/g4qhlqw9uPas
	 BXbgvn7tCkjTs5bL5HoDKHhmdiA35B2qsXvUpvv0mFIHMqsYPoS76X8rsxzV99X6Eo
	 Wb1YqyUfmIw6A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id
 75030380DBE8;
	Tue, 18 Mar 2025 11:30:40 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 01/10] batman-adv: Start new development cycle
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174229743927.4143607.16972269079132014230.git-patchwork-notify@kernel.org>
Date: Tue, 18 Mar 2025 11:30:39 +0000
References: <20250313164519.72808-2-sw@simonwunderlich.de>
In-Reply-To: <20250313164519.72808-2-sw@simonwunderlich.de>
To: Simon Wunderlich <sw@simonwunderlich.de>
Cc: kuba@kernel.org, davem@davemloft.net, netdev@vger.kernel.org,
 b.a.t.m.a.n@lists.open-mesh.org
X-MailFrom: patchwork-bot+netdevbpf@kernel.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-0;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-1;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-2
Message-ID-Hash: FVQ7LUUEM4SW74IN3ZPKWY763ZQ7STMA
X-Message-ID-Hash: FVQ7LUUEM4SW74IN3ZPKWY763ZQ7STMA
X-Mailman-Approved-At: Tue, 18 Mar 2025 14:44:21 +0100
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/G6LLXYPJ6OT4TYJHERT2QOOIVIPEIJ3T/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

Hello:

This series was applied to netdev/net-next.git (main)
by Simon Wunderlich <sw@simonwunderlich.de>:

On Thu, 13 Mar 2025 17:45:10 +0100 you wrote:
> This version will contain all the (major or even only minor) changes for
> Linux 6.15.
> 
> The version number isn't a semantic version number with major and minor
> information. It is just encoding the year of the expected publishing as
> Linux -rc1 and the number of published versions this year (starting at 0).
> 
> [...]

Here is the summary with links:
  - [01/10] batman-adv: Start new development cycle
    https://git.kernel.org/netdev/net-next/c/b195d60408d4
  - [02/10] batman-adv: Drop batadv_priv_debug_log struct
    https://git.kernel.org/netdev/net-next/c/9a006e72d30c
  - [03/10] batman-adv: adopt netdev_hold() / netdev_put()
    https://git.kernel.org/netdev/net-next/c/00b35530811f
  - [04/10] batman-adv: Add support for jumbo frames
    https://git.kernel.org/netdev/net-next/c/1666951c4424
  - [05/10] batman-adv: Use consistent name for mesh interface
    https://git.kernel.org/netdev/net-next/c/94433355027d
  - [06/10] batman-adv: Limit number of aggregated packets directly
    https://git.kernel.org/netdev/net-next/c/434becf57bdc
  - [07/10] batman-adv: Switch to bitmap helper for aggregation handling
    https://git.kernel.org/netdev/net-next/c/77405977f187
  - [08/10] batman-adv: Use actual packet count for aggregated packets
    https://git.kernel.org/netdev/net-next/c/0db110059e79
  - [09/10] batman-adv: Limit aggregation size to outgoing MTU
    https://git.kernel.org/netdev/net-next/c/e4aa3412f632
  - [10/10] batman-adv: add missing newlines for log macros
    https://git.kernel.org/netdev/net-next/c/7cfb32456ed8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


