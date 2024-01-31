Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 889ADC47258
	for <batman@archiver.kernel.org>; Wed, 31 Jan 2024 06:49:30 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id AC8DE83E97
	for <batman@archiver.kernel.org>; Wed, 31 Jan 2024 07:49:28 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1706683768;
 b=RpvqnwCpIbAX7ClaSK5n0055mXwbxNJPmg+vKw0DXkzl36T9rxqPC0p4KVVur6Zc8NOTT
 IaBi4YL2Ybrc/+lx8yULeVTlCwnGsnl4hTPCMYbq9FVwGmthaCKJjLnZxnOieNF3yiFjAHa
 6NhsSw+HOgMB5GIm9azyQo8wkNLgHgM=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1706683768; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=kzaLHSj2Vu+4rLi2LY2wAXM1NnS9ogtnaKkVNPjQbEg=;
 b=vQsT62MayQIOFysbJL0ZanVIdhUg8LiNAKBqhlunA1wAlQuLom8PTVsosABoP3Dnlgeti
 g7u2fmbQmu4Kt3JZf6ZlLUtoR6FjAa4Gf6a3ItdhMRZJemcmIf6Dn/jACEwDVyCULGH+wja
 50o3d3AB74UMtTzWcsVtpOygBQz7+Co=
ARC-Authentication-Results: i=2; open-mesh.org; dkim=pass header.d=kernel.org;
  arc=pass;
  dmarc=pass (Used From Domain Record) header.from=kernel.org
 policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=kernel.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=kernel.org policy.dmarc=none
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 678BE80DE2
	for <b.a.t.m.a.n@lists.open-mesh.org>; Wed, 31 Jan 2024 03:40:28 +0100 (CET)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1706668828;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=kzaLHSj2Vu+4rLi2LY2wAXM1NnS9ogtnaKkVNPjQbEg=;
	b=xl4lupbbeS2/YabVrhCb+u4imoVqlZr3xHywOHvud8e2/ck2VUvzTfPpMAhU11QxX/kCbH
	1jZgLTy3cZ2dI3yDMikhfJwLSaM3girpoyv/oYJPv4aHrDsGSGlSstqeagHnC1U9yZujP5
	ZkLvncAXIjnvpM+yGaXRzLix/lXTx84=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=kernel.org header.s=k20201202 header.b="g6iY/pv9";
	spf=pass (diktynna.open-mesh.org: domain of
 patchwork-bot+netdevbpf@kernel.org designates 2604:1380:4641:c500::1 as
 permitted sender) smtp.mailfrom=patchwork-bot+netdevbpf@kernel.org;
	dmarc=pass (policy=none) header.from=kernel.org
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1706668828; a=rsa-sha256;
	cv=none;
	b=DtJCHJad0ejAtKZCwLcVGrRqPTs1Il4QQkFt7Psa5Hdl5B2p9RJpu/IPkuD/ccIM/oOoXW
	MEUEK3wl1urZKqZEmqL3asiXPmvHe0CK+gFBSJihQVUkB1q7H/EgAvzVNYGvba3iovRBf7
	tfvYOLBTXalbDrnRR/J5afzuC2/s4XM=
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id DBF5C61231;
	Wed, 31 Jan 2024 02:40:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7E99AC43390;
	Wed, 31 Jan 2024 02:40:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706668826;
	bh=ri+xtdqHDdAedu6sRg/n0UlatJBbNJKunWM840Atne4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=g6iY/pv9E9iheFF3QaNJfoym3PlztBxYNWx1crzr5v6vk32yc9KKET2axhPJYpWOP
	 4h4MYp0FlTHtGsgmkpTbxIYRnoVY+5gJ7kr9gdJoxke1MJdqlw1Roy5ev4ZWCriV3N
	 P3+okxs7wbEmjbXIalOYHwCjkp3UER+pkll1gkfAsdSW2a0hgxjghlW7nyOzFQjhc2
	 s/jHOmVaJqFOGdhlTFmxkhsJYHzmMKAZa8/p56Kke1VETRj7C0si6tUNniarNnVrUD
	 W5p7mQaN96um2NhapXfN0Ki/9RABZuYylgPaOOExfgwMYmGA2NTX5qZN5h8mX6Lu+u
	 BK4UsBS5WJT6w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org
 (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id
 62EC6E3237E;
	Wed, 31 Jan 2024 02:40:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] bridge: mcast: fix disabled snooping after long
 uptime
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170666882640.24091.16393026544437992064.git-patchwork-notify@kernel.org>
Date: Wed, 31 Jan 2024 02:40:26 +0000
References: <20240127175033.9640-1-linus.luessing@c0d3.blue>
In-Reply-To: <20240127175033.9640-1-linus.luessing@c0d3.blue>
To: 
 =?utf-8?q?Linus_L=C3=BCssing_=3Clinus=2Eluessing=40c0d3=2Eblue=3E?=@ci.codeaurora.org
Cc: netdev@vger.kernel.org, bridge@lists.linux.dev,
 b.a.t.m.a.n@lists.open-mesh.org, linux-kernel@vger.kernel.org,
 roopa@nvidia.com, razor@blackwall.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
X-MailFrom: patchwork-bot+netdevbpf@kernel.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-0;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-1;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-2
Message-ID-Hash: W27IEU6KL3HHDYHNMK6AVWCJAFWSYKKP
X-Message-ID-Hash: W27IEU6KL3HHDYHNMK6AVWCJAFWSYKKP
X-Mailman-Approved-At: Wed, 31 Jan 2024 07:49:22 +0100
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/5FVDP5T7GQSQNGWVFYJCIIBEZ6L4TI25/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat, 27 Jan 2024 18:50:32 +0100 you wrote:
> The original idea of the delay_time check was to not apply multicast
> snooping too early when an MLD querier appears. And to instead wait at
> least for MLD reports to arrive before switching from flooding to group
> based, MLD snooped forwarding, to avoid temporary packet loss.
> 
> However in a batman-adv mesh network it was noticed that after 248 days of
> uptime 32bit MIPS based devices would start to signal that they had
> stopped applying multicast snooping due to missing queriers - even though
> they were the elected querier and still sending MLD queries themselves.
> 
> [...]

Here is the summary with links:
  - [net,v2] bridge: mcast: fix disabled snooping after long uptime
    https://git.kernel.org/netdev/net/c/f5c3eb4b7251

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


