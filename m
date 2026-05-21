Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19A72CD4F3D
	for <batman-adv@archiver.kernel.org>; Thu, 21 May 2026 14:11:00 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 51EB484160
	for <batman-adv@archiver.kernel.org>; Thu, 21 May 2026 16:10:59 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1779372659;
 b=iogHbDLm6mUUbsV98zkA58yCNLnltvmmBLCTMt+Bq/UD8pIrd4G63wsjFfH8naHtMy/Nd
 qeAn83sanQ33vz4/bR/XczDu3f2TDP3y1o1av//UVkA6fQVI7Oc6V8vrzCgWtDALJgVuta/
 IVPoFFAl6ANmOd3Jam6/s6Zy1cLb38U=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1779372659; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=ALfJb7rTXQ+RL1IByyB+qWVeikkQgS87H8EQ9cZsr4c=;
 b=vk0h6gkpR60/KXujEoSEgBgEa14h6TsNdYD49seOm1iWdy1JS0ZDOXdMs0+Jew2lBqzsc
 6U1I700jmg15na6ssGF9Ybu0ZBijDBu3MVPKxJVtDx7mFMInmCuoFtya15T8siUh3eFBIvq
 bAx+pSRqpmb+dZtoG0XCo/F/r3Va6Rg=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=kernel.org;
 arc=pass;
 dmarc=pass header.from=kernel.org policy.dmarc=quarantine
Authentication-Results: open-mesh.org; dkim=pass header.d=kernel.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=kernel.org policy.dmarc=quarantine
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 222D482C2E
	for <b.a.t.m.a.n@lists.open-mesh.org>; Thu, 21 May 2026 16:10:11 +0200 (CEST)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1779372621;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=ALfJb7rTXQ+RL1IByyB+qWVeikkQgS87H8EQ9cZsr4c=;
	b=nudOkmhaELsaIbzltL/uQSOGTR5DUW2ErSkRQU1TGNPSOfMWfTE9xSvra53weCWvz74I05
	KRurM3ELVNfk29BsOCkWH3C0QBpsDuzxdMAr25DTmHpcYksBTjX2/HTWhyIAq3C3g4uiwJ
	kIyc+gcumzEF54IpimQZzlrwOM6VjEA=
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1779372621;
	b=IZVJz8HKr+QmXduCsJEnNI1bVsc1JzNKwdJHqs1kdmOnt+6zwFtuHIRrYSmNfGs7r+VH8o
	x/MgFdZOfDjASWvcOHBmrjz8dqxZyFG0ambSo2YeH+uZvj0PC876K+gy5CpyHCrLtNpWwM
	ob5gpZ9wKFUhNHH3rcWUwZvi+QO2BoM=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=GsKg+a+x;
	spf=pass (diktynna.open-mesh.org: domain of
 patchwork-bot+netdevbpf@kernel.org designates 2600:3c04:e001:324:0:1991:8:25
 as permitted sender) smtp.mailfrom=patchwork-bot+netdevbpf@kernel.org;
	dmarc=pass (policy=quarantine) header.from=kernel.org
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 08AAE601F4;
	Thu, 21 May 2026 14:10:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3DD81F000E9;
	Thu, 21 May 2026 14:10:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779372609;
	bh=ALfJb7rTXQ+RL1IByyB+qWVeikkQgS87H8EQ9cZsr4c=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=GsKg+a+xtMFkLOTv9gk5rAV2YNiDd1JwYCvfUQ06co0bMlI5PBcMJ5h3HVl23IdVx
	 2sqDESNsx1vavu/1uQ/YJ4QXgp5qSb3hURNwetG9+yRteE4MovXVBJK8HhH7VrzwVX
	 5ST5Wcw5AtD3ZUr0suDJmr28B7GVYg7kSl0nFK2ZbbyHdl8QpyhKjVcYTWb8VesBHA
	 6ThCx27WsUb7K7Nqc+Ul97zkTs6vsK+ltsCbATsiAVkDguDjHTFR3s3G89yMUncfyr
	 whtcpogu4uGJYy2I1uP8qPRMWZ9cSSw8outrshzJ+Sz8cnyanbfZwTKw23OlVh/5Kg
	 diJsydiCnFH5Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id
 D0B733930DE5;
	Thu, 21 May 2026 14:10:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 01/11] batman-adv: fix batadv_skb_is_frag() kernel-doc
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177937261940.334326.3846070326283907142.git-patchwork-notify@kernel.org>
Date: Thu, 21 May 2026 14:10:19 +0000
References: <20260520115422.53552-2-sw@simonwunderlich.de>
In-Reply-To: <20260520115422.53552-2-sw@simonwunderlich.de>
To: Simon Wunderlich <sw@simonwunderlich.de>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 b.a.t.m.a.n@lists.open-mesh.org, sven@narfation.org
Message-ID-Hash: FGOJ7P7I4AGADYGYCUFCOJZ2TYEVXWCW
X-Message-ID-Hash: FGOJ7P7I4AGADYGYCUFCOJZ2TYEVXWCW
X-MailFrom: patchwork-bot+netdevbpf@kernel.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-b.a.t.m.a.n.lists.open-mesh.org-0;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-1;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-2;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-3; emergency; member-moderation
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/FGOJ7P7I4AGADYGYCUFCOJZ2TYEVXWCW/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

Hello:

This series was applied to netdev/net.git (main)
by Sven Eckelmann <sven@narfation.org>:

On Wed, 20 May 2026 13:54:12 +0200 you wrote:
> From: Sven Eckelmann <sven@narfation.org>
> 
> The kernel-doc comment for batadv_skb_is_frag() contained two errors:
> 
> * the function description referred to "gain a unicast packet" instead
>   of "contains unicast fragment".
> * the Return section omitted "merged" from "newly skb", leaving the
>   description grammatically incorrect and inconsistent with the
>   function description.
> 
> [...]

Here is the summary with links:
  - [net,01/11] batman-adv: fix batadv_skb_is_frag() kernel-doc
    https://git.kernel.org/netdev/net/c/0039ac830506
  - [net,02/11] batman-adv: v: stop OGMv2 on disabled interface
    https://git.kernel.org/netdev/net/c/f8ce8b8331a1
  - [net,03/11] batman-adv: tvlv: abort OGM send on tvlv append failure
    https://git.kernel.org/netdev/net/c/501368506563
  - [net,04/11] batman-adv: tvlv: reject oversized TVLV packets
    https://git.kernel.org/netdev/net/c/f50487e35663
  - [net,05/11] batman-adv: tp_meter: fix race condition in send error reporting
    https://git.kernel.org/netdev/net/c/71dce47f0758
  - [net,06/11] batman-adv: tp_meter: avoid role confusion in tp_list
    https://git.kernel.org/netdev/net/c/ff24f2ecfd94
  - [net,07/11] batman-adv: mcast: fix use-after-free in orig_node RCU release
    https://git.kernel.org/netdev/net/c/20c2d6a20ca9
  - [net,08/11] batman-adv: iv: recover OGM scheduling after forward packet error
    https://git.kernel.org/netdev/net/c/aa3153bd139a
  - [net,09/11] batman-adv: bla: fix report_work leak on backbone_gw purge
    https://git.kernel.org/netdev/net/c/0459430add32
  - [net,10/11] batman-adv: bla: avoid double decrement of bla.num_requests
    https://git.kernel.org/netdev/net/c/83ab69bd12b8
  - [net,11/11] batman-adv: bla: avoid NULL-ptr deref for claim via dropped interface
    https://git.kernel.org/netdev/net/c/f80d3d98d2ff

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


