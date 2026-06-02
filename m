Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20588CD6E5D
	for <batman-adv@archiver.kernel.org>; Tue,  2 Jun 2026 19:11:12 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 0A98882285
	for <batman-adv@archiver.kernel.org>; Tue, 02 Jun 2026 21:11:10 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1780427470;
 b=LchGg0v9GuAG2d6Tx5yl0q+dNtDmmGvjyUer8nNV1siuMv56bUOK1VN0OfzUBqrL4dPfN
 XU0rfFIeahuJt4McuWN6ht/sUkVv1jqVOxbz9ZRtKPuBaqyhmSKb8Uub8S/rUe5YSdFZ5xh
 a1csm5RzdNqEorxxpZViDao+S0eGDLo=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1780427470; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=/qDg78ixEj2MH/tGiTu0JsKHtgfhzCK3Z95O0mqgqiQ=;
 b=E4h8BG8Ix1uHjOQRg+KqPayC+Uw//b57mzlBerOu51H4jL7GpT2wDf1ps5OjVNA893axm
 tq16jksqFwdgxcZ5NV9tbtVwOvRLRt63DjpbSkM9P9ACDoj8bI043xFGQS2SojRPl0OHwM9
 RgXX25r9YCDFpuRNYK6aabR++n4gVOQ=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=kernel.org;
 arc=pass;
 dmarc=pass header.from=kernel.org policy.dmarc=quarantine
Authentication-Results: open-mesh.org; dkim=pass header.d=kernel.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=kernel.org policy.dmarc=quarantine
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id E641E814EF
	for <b.a.t.m.a.n@lists.open-mesh.org>; Tue, 02 Jun 2026 21:10:49 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1780427460;
	b=wXjpjLozpxpmzU9oCJePN0iG5zjGNWMc21nuuZ7B+KJXhiQ8mUGgVYTgIocdyqMVekbZs0
	vF6gFywDgBB0Bs3fARBGXZIwiSrizKtq13pedgRJBqYEPRDgwMcn8ZmsUte8Ug7N8JVeM+
	nO3eIXJMl4FJZlecWmhiCxoBNXDO9yE=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=M4aWfJ0d;
	spf=pass (diktynna.open-mesh.org: domain of
 patchwork-bot+netdevbpf@kernel.org designates 2600:3c0a:e001:78e:0:1991:8:25
 as permitted sender) smtp.mailfrom=patchwork-bot+netdevbpf@kernel.org;
	dmarc=pass (policy=quarantine) header.from=kernel.org
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1780427460;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=/qDg78ixEj2MH/tGiTu0JsKHtgfhzCK3Z95O0mqgqiQ=;
	b=IlS3vCmSRXQiC761/SozUM/ihW1ieH5s/E7ev/TCTxzqpzHaVlZPcJvtkHtdWO8LPj1hOe
	2X1TRsdJtDb/CaSADXhUptYAX8IcrXSBYkwmKGTlZkIcSfa7pAyNXPC+EsGzLvjXlZlZah
	cp+hDa9i0p1HmF5Ps+n3MG6bZEJtJ4Q=
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 5BB45408A8;
	Tue,  2 Jun 2026 19:10:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DC5F1F00893;
	Tue,  2 Jun 2026 19:10:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780427443;
	bh=/qDg78ixEj2MH/tGiTu0JsKHtgfhzCK3Z95O0mqgqiQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=M4aWfJ0d/k0caXpXHIqgJKr0AU1teEKFvLBu9TnK9IkxB695SPtPUgMNx4SbCpt1M
	 lPXgLBW3Cxji9S5VI9jGXbwRkKNBebQCf+NX/VnCUso7gshFP+Pio+DJRS4FPd0AXZ
	 ZXWH1YxY7GYYW1y+Gzm1NFMDB5z7vzgW1QKmS198F7C3YTr3jIfiDgX74zBvAsrfkn
	 t2+A7aftMNe3l3UEpV//bS5q0wHOZ2It89JxiA415kjIUf8JlbskhR5W/CGAodbgi7
	 wqvDo7ep2/1BKNBmssbdo6TiS7qXS3owfYE9srwbVSzcd8IOqq9La4BKnDYOepHM+4
	 VB4kBMJWIUMaQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id
 569463811A6C;
	Tue,  2 Jun 2026 19:10:46 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 01/15] batman-adv: drop batman-adv specific
 version
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178042744488.1010994.13027563047282027332.git-patchwork-notify@kernel.org>
Date: Tue, 02 Jun 2026 19:10:44 +0000
References: <20260601123629.707089-2-sw@simonwunderlich.de>
In-Reply-To: <20260601123629.707089-2-sw@simonwunderlich.de>
To: Simon Wunderlich <sw@simonwunderlich.de>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 b.a.t.m.a.n@lists.open-mesh.org, sven@narfation.org
Message-ID-Hash: IKT6LPS6BZDKNSAVKWT6GA5IXUO4WC2P
X-Message-ID-Hash: IKT6LPS6BZDKNSAVKWT6GA5IXUO4WC2P
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/IKT6LPS6BZDKNSAVKWT6GA5IXUO4WC2P/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

Hello:

This series was applied to netdev/net-next.git (main)
by Sven Eckelmann <sven@narfation.org>:

On Mon,  1 Jun 2026 14:36:15 +0200 you wrote:
> From: Sven Eckelmann <sven@narfation.org>
> 
> Bumping the version number on the first pull request after each merge
> window was deemed inappropriate for an in-tree component. The version
> number carries little meaningful information in the context of the Linux
> kernel release model, where stable and distribution might all carry
> slightly different patches (without any change to the batman-adv version).
> 
> [...]

Here is the summary with links:
  - [net-next,v2,01/15] batman-adv: drop batman-adv specific version
    https://git.kernel.org/netdev/net-next/c/6f864eb5cfd8
  - [net-next,02/15] MAINTAINERS: Rename batman-adv T(ree)
    https://git.kernel.org/netdev/net-next/c/1e323d0e7d22
  - [net-next,03/15] MAINTAINERS: Don't send batman-adv patches to netdev
    https://git.kernel.org/netdev/net-next/c/6dbf9f76a692
  - [net-next,04/15] batman-adv: add missing includes
    https://git.kernel.org/netdev/net-next/c/b8fbbfe81d3e
  - [net-next,05/15] batman-adv: use atomic_xchg() for gw.reselect check
    https://git.kernel.org/netdev/net-next/c/9550dd11e360
  - [net-next,v2,06/15] batman-adv: extract netdev wifi detection information object
    https://git.kernel.org/netdev/net-next/c/c0559465842c
  - [net-next,07/15] batman-adv: replace non-atomic meshif config fields with (READ|WRITE)_ONCE
    https://git.kernel.org/netdev/net-next/c/6a4f30e6e34c
  - [net-next,08/15] batman-adv: replace non-atomic hardif config fields with (READ|WRITE)_ONCE
    https://git.kernel.org/netdev/net-next/c/dbb48d9089bd
  - [net-next,09/15] batman-adv: replace non-atomic vlan config fields with (READ|WRITE)_ONCE
    https://git.kernel.org/netdev/net-next/c/26f8f9f9379b
  - [net-next,10/15] batman-adv: replace non-atomic mesh state with (READ|WRITE)_ONCE
    https://git.kernel.org/netdev/net-next/c/2b2450e3266a
  - [net-next,v2,11/15] batman-adv: replace non-atomic packet_size_max with (READ|WRITE)_ONCE
    https://git.kernel.org/netdev/net-next/c/58020571b54f
  - [net-next,12/15] batman-adv: replace non-atomic last_ttvn with (READ|WRITE)_ONCE
    https://git.kernel.org/netdev/net-next/c/4dd2055046c4
  - [net-next,13/15] batman-adv: tt: replace open-coded overflow check with helper
    https://git.kernel.org/netdev/net-next/c/5ffd4dd87425
  - [net-next,14/15] batman-adv: tvlv: avoid unnecessary OGM buffer reallocations
    https://git.kernel.org/netdev/net-next/c/735522e7ca3f
  - [net-next,15/15] batman-adv: use neigh_node's orig_node only as id
    https://git.kernel.org/netdev/net-next/c/3bd64ca11d9a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


