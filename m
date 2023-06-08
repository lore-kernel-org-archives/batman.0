Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7FA6C7EE25
	for <batman@archiver.kernel.org>; Thu,  8 Jun 2023 06:39:38 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 9102381720
	for <batman@archiver.kernel.org>; Thu,  8 Jun 2023 08:39:36 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1686206376;
 b=ZO5M6wgH0LA1DD106YfHFRrcrxnzE54G5zhoFAhzj20P1Vs87BZvWDdKD023HmtJTuPtl
 D9mz5NzkuHdif0MWdeg16eAMDdZpWvhwAXohDEvOGSfLIwADGYA1BBJGBA1r5VKW0U+p9vq
 CSXpFt6KxXa2qSnLmVUxPiZrke50JDw=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1686206376; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=o2v5VCvK6VNHOiZxAr9pmeXt/7HYG7vSW8TR5+VCsgI=;
 b=XqDCOc4IRHSoCaSkM6CuRjqSjJuZX7OIo3X7G4Pv/upX+MeOcWybsLcDJGLqympUCEwEv
 3hsa/W1l06jyNk6ikjFO5QS2+61VMRbcifaq8tLWqq8B7Cj93fLNunfK1q6ZgK74xgLDY/B
 v1HF5pdWm97bIFDLGuQaoQOixmgO7r4=
ARC-Authentication-Results: i=2; open-mesh.org; dkim=pass header.d=kernel.org;
  arc=pass;
  dmarc=pass (Used From Domain Record) header.from=kernel.org
 policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=kernel.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=kernel.org policy.dmarc=none
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 609F280519
	for <b.a.t.m.a.n@lists.open-mesh.org>; Thu,  8 Jun 2023 07:00:25 +0200 (CEST)
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1686200426; a=rsa-sha256;
	cv=none;
	b=XQqxifJjLE9/Rha+qXFGuAPjptwOPLjs3aRN6VhuJnk9KinnhYZx44qiOieZ04pKxaztrd
	WPePlQTPIaFgZWH5tG23Zppx3UItmQdqaYpjKVnU6B+GldhCOkCf+tyVLpc7EZakckYEXv
	A/UZdgnP4xIU1qrIloPB14qvMGiR2JM=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=kernel.org header.s=k20201202 header.b="I1oRQak/";
	spf=pass (diktynna.open-mesh.org: domain of
 patchwork-bot+netdevbpf@kernel.org designates 2604:1380:4641:c500::1 as
 permitted sender) smtp.mailfrom=patchwork-bot+netdevbpf@kernel.org;
	dmarc=pass (policy=none) header.from=kernel.org
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1686200426;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=o2v5VCvK6VNHOiZxAr9pmeXt/7HYG7vSW8TR5+VCsgI=;
	b=hly53GzRiRClTRmYAROPuzyJVnp4we5nQrHdjN+oqiRi/HPUZFlTzIxJGwBaosPBd2f+Wg
	YVJADgSjXMdNPUv80jt6LrSZHyrk9hOTYPcuWbb2sUH8NUSLnbSMBq8Ye27wrU+SqWhLFg
	NIpeeYbSYiqee8/VQG3XqjR/KQjztk0=
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 34956647FF;
	Thu,  8 Jun 2023 05:00:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0BFF8C433EF;
	Thu,  8 Jun 2023 05:00:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1686200423;
	bh=u6gKiDY/HsEUHdRq8tbpupxV7SXGRVcLLZSbJkFwsS8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=I1oRQak/+uFzko5FE0Pmz5GM1pd6Bj2Wbo37WxJr6NhpWcou97N4jHFsdJNuJx9Tz
	 CaeNWZk4GmcQmt7kRirQHZnA7wrY51vTpejJwFDMNyi1W39Ejp+9TF/0v5Ukyl4DzF
	 YV807/eIAa4ZfM/MVdsXsa8+4q44VGPajT8QFumyJNCG/CbKy69sX0JpobQVY1B7t/
	 TKxYAuJ9eHyG/elj38hi1UqJ9rxXoBcFNOekrHYKpvLdKaJyswP/k2OCSk0/cVMtwe
	 hc6QVXe+QcKU/FI4bEFPySoD5pgacnVUt4kR3XlFzcfZCbVCvMSbHUle68NWt/IrAC
	 70AaPClVNjVmQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org
 (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id
 DFB12E87232;
	Thu,  8 Jun 2023 05:00:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 1/1] batman-adv: Broken sync while rescheduling delayed
 work
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <168620042291.23382.13609079860562597568.git-patchwork-notify@kernel.org>
Date: Thu, 08 Jun 2023 05:00:22 +0000
References: <20230607155515.548120-2-sw@simonwunderlich.de>
In-Reply-To: <20230607155515.548120-2-sw@simonwunderlich.de>
To: Simon Wunderlich <sw@simonwunderlich.de>
X-MailFrom: patchwork-bot+netdevbpf@kernel.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-0;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-1
Message-ID-Hash: NCWYTDQVEXKEE7ROEMDT5Q3GYTELQJJV
X-Message-ID-Hash: NCWYTDQVEXKEE7ROEMDT5Q3GYTELQJJV
X-Mailman-Approved-At: Thu, 08 Jun 2023 08:39:30 +0200
CC: davem@davemloft.net, kuba@kernel.org, netdev@vger.kernel.org,
 b.a.t.m.a.n@lists.open-mesh.org, VEfanov@ispras.ru, stable@kernel.org
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/JCE4SF3HR523SRY7V2KEP45TBVJISPF3/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

Hello:

This patch was applied to netdev/net.git (main)
by Simon Wunderlich <sw@simonwunderlich.de>:

On Wed,  7 Jun 2023 17:55:15 +0200 you wrote:
> From: Vladislav Efanov <VEfanov@ispras.ru>
> 
> Syzkaller got a lot of crashes like:
> KASAN: use-after-free Write in *_timers*
> 
> All of these crashes point to the same memory area:
> 
> [...]

Here is the summary with links:
  - [1/1] batman-adv: Broken sync while rescheduling delayed work
    https://git.kernel.org/netdev/net/c/abac3ac97fe8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


