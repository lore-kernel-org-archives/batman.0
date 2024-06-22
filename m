Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 452BDC27C53
	for <batman-adv@archiver.kernel.org>; Sat, 22 Jun 2024 05:40:41 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 4D67882F31
	for <batman-adv@archiver.kernel.org>; Sat, 22 Jun 2024 07:40:39 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1719034839;
 b=fyieCIgJSukhqrxYtIH0eDBHOtkOYwgF8S8T6HcHqxN0slEGShUdeo+1GcD7g6XEBrYo3
 yyLXR9EObimaRpk5qAYaBM6de/kgjniIk1O7hRivFqkqRlBo0ht/GWIwFWTcVUdu9mOBcZX
 Kgrj++5mzNQSMyr7G0CstPI8tdUFJgM=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1719034839; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=Z6gtVQli6mpJBAaa/pBQHGgPtI+6lxHsS6Y7E++undE=;
 b=efNKoEBMW6UVoiyImqwT92ChY/WINOg2Vr3RiOJZ/w2Up+yBiyULv3BiqZs+CEa+eb/ro
 2I75h5T5AcmZ88WuL1/5kKHEFDF7WHJlX0ImKAaWzQWhehmnG3KUi13QY4C7H1rnosvhMOk
 r69711diZU/72Z7cm9jmV8wdbvQhyMg=
ARC-Authentication-Results: i=2; open-mesh.org; dkim=pass header.d=kernel.org;
  arc=pass;
  dmarc=pass (Used From Domain Record) header.from=kernel.org
 policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=kernel.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=kernel.org policy.dmarc=none
Received: from sin.source.kernel.org (sin.source.kernel.org
 [IPv6:2604:1380:40e1:4800::1])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 498DC8202D
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sat, 22 Jun 2024 03:20:35 +0200 (CEST)
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1719019236; a=rsa-sha256;
	cv=none;
	b=gSDHTw+OZ9vecvLHn2y80DN3MUeksBqXJQcK7UrDxS2wlGWI8u/CutVwxAgR0MceM6qPBI
	Dpv5Qlm+g2artRt5ft/sM4voRjeBwU9vN9IokLYPp5OObaWydhD9J+CmB601CcSJ2LcPWu
	mow9VHoRCKkYIfAkL4bTRUWMD9ZLPNc=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=kernel.org header.s=k20201202 header.b=q+NvcuHi;
	dmarc=pass (policy=none) header.from=kernel.org;
	spf=pass (diktynna.open-mesh.org: domain of
 patchwork-bot+netdevbpf@kernel.org designates 2604:1380:40e1:4800::1 as
 permitted sender) smtp.mailfrom=patchwork-bot+netdevbpf@kernel.org
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1719019236;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=Z6gtVQli6mpJBAaa/pBQHGgPtI+6lxHsS6Y7E++undE=;
	b=CoShWxaTX5vg3qJmw4yxAk6/AI8n7gvKkc1dwIM/iwq9xnV+hGT+/r9R5zvZYnB4K2VURI
	IjheylNneP0qmG21/rlK8Lk3Piku+0bFBjob/N214zbMmPzVmPpB2j/isss7AZ9cSH5C7D
	nzr29R40aCddzUfcsFpC3IBz9+4uizI=
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 9BFFACE3DD9;
	Sat, 22 Jun 2024 01:20:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2D66CC4AF07;
	Sat, 22 Jun 2024 01:20:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719019231;
	bh=myMQCTlzgeMQ6jiOQ7ZSjM+UrDbgE8T89P2Sms49IUY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=q+NvcuHi/76nQQ6q7HRiM+b+VaeJllq9GDTOonXUjA9m6SXpwqDjGGrRAIlaf9AAy
	 hxbc9Wcj8U2p4Mkwuc4Kiv9PLXyiraXVkj/NAT1/uy2VOHt1bP4ag5XRyhn36y5Dol
	 JqAeYwQHhFr1xC5cLrsaZj/xvXzxJSaCwQFVPJuy1FMwXt5nAW80cpdImBnYiCjwep
	 uUIZjxhAfBSKculjFH/1hNaAaSZBN6TzISnlsx0slstFxPO+Ea66zy0gUi0HaP70GX
	 XOHw6FLARvygW58y+h3+bbySCVzfOM0lXwPSeZgwU1oFZjlOPGisgA3i2KuHRdiSIs
	 God6QpqYnIT/Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org
 (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id
 0FC22C43140;
	Sat, 22 Jun 2024 01:20:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 1/2] batman-adv: Don't accept TT entries for out-of-spec
 VIDs
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171901923106.1383.2164378801371432677.git-patchwork-notify@kernel.org>
Date: Sat, 22 Jun 2024 01:20:31 +0000
References: <20240621143915.49137-2-sw@simonwunderlich.de>
In-Reply-To: <20240621143915.49137-2-sw@simonwunderlich.de>
To: Simon Wunderlich <sw@simonwunderlich.de>
Cc: davem@davemloft.net, kuba@kernel.org, netdev@vger.kernel.org,
 b.a.t.m.a.n@lists.open-mesh.org, sven@narfation.org, stable@vger.kernel.org,
 linus.luessing@c0d3.blue
X-MailFrom: patchwork-bot+netdevbpf@kernel.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-0;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-1;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-2
Message-ID-Hash: SR7IS2X6C6WUV6227SDFJBBJ2QUIYC2O
X-Message-ID-Hash: SR7IS2X6C6WUV6227SDFJBBJ2QUIYC2O
X-Mailman-Approved-At: Sat, 22 Jun 2024 07:39:54 +0200
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/BK5M4TOQJHUGKLVXBJKDN5DZPABEVJ2X/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

Hello:

This series was applied to netdev/net.git (main)
by Simon Wunderlich <sw@simonwunderlich.de>:

On Fri, 21 Jun 2024 16:39:14 +0200 you wrote:
> From: Sven Eckelmann <sven@narfation.org>
> 
> The internal handling of VLAN IDs in batman-adv is only specified for
> following encodings:
> 
> * VLAN is used
>   - bit 15 is 1
>   - bit 11 - bit 0 is the VLAN ID (0-4095)
>   - remaining bits are 0
> * No VLAN is used
>   - bit 15 is 0
>   - remaining bits are 0
> 
> [...]

Here is the summary with links:
  - [1/2] batman-adv: Don't accept TT entries for out-of-spec VIDs
    https://git.kernel.org/netdev/net/c/537a350d1432
  - [2/2] Revert "batman-adv: prefer kfree_rcu() over call_rcu() with free-only callbacks"
    https://git.kernel.org/netdev/net/c/6bfff3582416

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


