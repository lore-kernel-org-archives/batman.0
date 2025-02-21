Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CE13C021B2
	for <batman-adv@archiver.kernel.org>; Sat, 22 Feb 2025 08:46:30 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id B7DFA84200
	for <batman-adv@archiver.kernel.org>; Sat, 22 Feb 2025 09:46:28 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1740213988;
 b=hOARaIvotLMytT6/VlV687eePF1RSd00zA51uxvKqmvxiYAFULY7Y3FPbgi3DLCrtWx4I
 Ea+7CIUahxzxYa+JAbs/ck+4EgY1QG1Sue2dwQiQN91KwHlecQjmuey5EyWpK+SqHUITYlR
 hAjkgxjMmrap66f+Ay7HPDJGs5bRrgM=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1740213988; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=c6q5Y6WGiTWc7ZOiNwGwfiH2QOEjYjjdW6Iunf1+76g=;
 b=mfJ3ULa00SqlpSe7VJ3Kl62PifxAdtKmLe7kFy4Avu5PyY6eH2i8Fj30LQsaPvHlRhRcJ
 ZIbGWExs6BGiiptPCr3DtoQzOHyn5AJaQFP6TtSKxlutNeg0QFtE59aSJM+4SN5ldXRbdvI
 zjNMiv9gF4UXKCICDbMwYliteEDzeKk=
ARC-Authentication-Results: i=2; open-mesh.org; dkim=pass header.d=kernel.org;
  arc=pass;
  dmarc=pass (Used From Domain Record) header.from=kernel.org
 policy.dmarc=quarantine
Authentication-Results: open-mesh.org; dkim=pass header.d=kernel.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=kernel.org policy.dmarc=quarantine
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04::f03c:95ff:fe5e:7468])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id B063081F4C
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sat, 22 Feb 2025 00:50:03 +0100 (CET)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1740181804;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=c6q5Y6WGiTWc7ZOiNwGwfiH2QOEjYjjdW6Iunf1+76g=;
	b=d9hZv2FJD5vsqlhVmNcHjnUnEJSaVng8OAE/x9eGh143b/Fr9SiQKP5+t1FnE5QflsqjdG
	3kPfTql6TYAusyEzr2gkuNF5b7Kp5lYXml8X3DD/NFxvePnU6u9ppFAWpZ5PexFuGWydWL
	EJNw4C35P1EG4liDG/ZfBWlNbYSdLQY=
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1740181804; a=rsa-sha256;
	cv=none;
	b=3rOKXpWvM7EZtJ2Ols/h+9zR3AcBeq4ySxDqhGtzCCXRkOphb2L5ZrzN5NuaXLo1X0WYK0
	8RnWYEyWUg98umze0hRF0GGJ3EM+PGJrR4/fWITIw8+BHTQuGm+hkTmkrnoumnyEggkvjR
	NWP25+Kxo46N4y+K8IEo2pVh8SXaYgM=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=kernel.org header.s=k20201202 header.b=BDu9ISbE;
	spf=pass (diktynna.open-mesh.org: domain of
 patchwork-bot+netdevbpf@kernel.org designates 2600:3c04::f03c:95ff:fe5e:7468
 as permitted sender) smtp.mailfrom=patchwork-bot+netdevbpf@kernel.org;
	dmarc=pass (policy=quarantine) header.from=kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id B63B268364;
	Fri, 21 Feb 2025 23:49:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D170C4CEE8;
	Fri, 21 Feb 2025 23:50:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740181802;
	bh=CTqJ/KmzI6Gqn0P8GISxBeKnxm42pSWuEHz+MsnFwsw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=BDu9ISbENe4QBTzFvL3z1yzMFvK03RKEkTbSwfBUkHNtTUh87YeINV9ofzYEHWC3S
	 jZzNU5gsxWbwLeHefuhEiZ9tiDlx3f/7HNbz6+540xOxAjI7PR0td6mH30Y3+TKUgF
	 LvyTFKZzhdtpcsU6ypDidAaK+ncYlAPPafKV4INeuNv7tC9FhmAMN0Vo6m1FyHhHaY
	 CchC7RgW86hAUItr0fS49w52qJFaotrHr/KW9nOdhhDez05BFc79K9glnKMMjqoXTE
	 2B5QJHf8bMDZ6dD1+XamNosy4PieEtpvxtm9eOjBTRJHtAiLr3CyiD+AQA01DPTnNn
	 +FzWQRl5jE+uA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id
 710DC380CEEC;
	Fri, 21 Feb 2025 23:50:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v10 00/13] net: Improve netns handling in
 rtnetlink
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174018183327.2240430.4249639047640655494.git-patchwork-notify@kernel.org>
Date: Fri, 21 Feb 2025 23:50:33 +0000
References: <20250219125039.18024-1-shaw.leon@gmail.com>
In-Reply-To: <20250219125039.18024-1-shaw.leon@gmail.com>
To: Xiao Liang <shaw.leon@gmail.com>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
 kuniyu@amazon.com, kuba@kernel.org, davem@davemloft.net, dsahern@kernel.org,
 edumazet@google.com, pabeni@redhat.com, andrew+netdev@lunn.ch,
 horms@kernel.org, shuah@kernel.org, donald.hunter@gmail.com,
 alex.aring@gmail.com, stefan@datenfreihafen.org, miquel.raynal@bootlin.com,
 steffen.klassert@secunet.com, herbert@gondor.apana.org.au,
 linux-rdma@vger.kernel.org, linux-can@vger.kernel.org,
 osmocom-net-gprs@lists.osmocom.org, bpf@vger.kernel.org,
 linux-ppp@vger.kernel.org, wireguard@lists.zx2c4.com,
 linux-wireless@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org,
 bridge@lists.linux.dev, linux-wpan@vger.kernel.org,
 linux-kernel@vger.kernel.org
X-MailFrom: patchwork-bot+netdevbpf@kernel.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-0;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-1;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-2
Message-ID-Hash: MXN5OBRRRVQPRDSIWXST2HBG4YHB4TT6
X-Message-ID-Hash: MXN5OBRRRVQPRDSIWXST2HBG4YHB4TT6
X-Mailman-Approved-At: Sat, 22 Feb 2025 09:46:20 +0100
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/UIJSOREY7UWOU4QJL27YIO3K6WHCDNLR/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 19 Feb 2025 20:50:26 +0800 you wrote:
> This patch series includes some netns-related improvements and fixes for
> rtnetlink, to make link creation more intuitive:
> 
>  1) Creating link in another net namespace doesn't conflict with link
>     names in current one.
>  2) Refector rtnetlink link creation. Create link in target namespace
>     directly.
> 
> [...]

Here is the summary with links:
  - [net-next,v10,01/13] rtnetlink: Lookup device in target netns when creating link
    https://git.kernel.org/netdev/net-next/c/ec061546c6cf
  - [net-next,v10,02/13] rtnetlink: Pack newlink() params into struct
    https://git.kernel.org/netdev/net-next/c/69c7be1b903f
  - [net-next,v10,03/13] net: Use link/peer netns in newlink() of rtnl_link_ops
    https://git.kernel.org/netdev/net-next/c/cf517ac16ad9
  - [net-next,v10,04/13] ieee802154: 6lowpan: Validate link netns in newlink() of rtnl_link_ops
    https://git.kernel.org/netdev/net-next/c/3533717581dd
  - [net-next,v10,05/13] net: ip_tunnel: Don't set tunnel->net in ip_tunnel_init()
    https://git.kernel.org/netdev/net-next/c/9e17b2a1a097
  - [net-next,v10,06/13] net: ip_tunnel: Use link netns in newlink() of rtnl_link_ops
    https://git.kernel.org/netdev/net-next/c/eacb1160536e
  - [net-next,v10,07/13] net: ipv6: Init tunnel link-netns before registering dev
    https://git.kernel.org/netdev/net-next/c/db014522f356
  - [net-next,v10,08/13] net: ipv6: Use link netns in newlink() of rtnl_link_ops
    https://git.kernel.org/netdev/net-next/c/5e72ce3e3980
  - [net-next,v10,09/13] net: xfrm: Use link netns in newlink() of rtnl_link_ops
    https://git.kernel.org/netdev/net-next/c/5314e3d68455
  - [net-next,v10,10/13] rtnetlink: Remove "net" from newlink params
    https://git.kernel.org/netdev/net-next/c/9c0fc091dc01
  - [net-next,v10,11/13] rtnetlink: Create link directly in target net namespace
    https://git.kernel.org/netdev/net-next/c/7ca486d08a30
  - [net-next,v10,12/13] selftests: net: Add python context manager for netns entering
    https://git.kernel.org/netdev/net-next/c/030329416232
  - [net-next,v10,13/13] selftests: net: Add test cases for link and peer netns
    https://git.kernel.org/netdev/net-next/c/85cb3711acb8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


