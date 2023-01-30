Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7B29C54EAA
	for <batman-adv@archiver.kernel.org>; Mon, 30 Jan 2023 09:16:00 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 972A9846F7
	for <batman-adv@archiver.kernel.org>; Mon, 30 Jan 2023 10:15:58 +0100 (CET)
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 5CCB780680
	for <b.a.t.m.a.n@lists.open-mesh.org>; Mon, 30 Jan 2023 08:40:20 +0100 (CET)
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1675064420; a=rsa-sha256;
	cv=none;
	b=ytBAZZ/kZeSjA2YyJO4VHesUXYOZ/kLQmq5mut64KJ9LUJJarrCHXMrgUToo+qi1gz1FfG
	fgFkKZSDJRpHDp4muV1O8C+v8odY4KSTk4tYfCokSTrUQ/APoasjdNMsGj5c+oToMGuVg/
	HpwYDx9IH5/74RmZY8jWRHoAry9vR+A=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=kernel.org header.s=k20201202 header.b=fduDIw3y;
	spf=pass (diktynna.open-mesh.org: domain of patchwork-bot+netdevbpf@kernel.org designates 145.40.68.75 as permitted sender) smtp.mailfrom=patchwork-bot+netdevbpf@kernel.org;
	dmarc=pass (policy=none) header.from=kernel.org
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1675064420;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=2BA2XNn/cQL+D8ovFvK8IF4iwOFAeMwz4/Dbz0LtlJA=;
	b=o8n3836W8aQIBVshrd/6cCUmxP0XsOdGMbn74lh6QIczdjZyAEelP+AJpzEkPaW2+gdt3y
	BCAZeIvHCd8QpD4SRrNRUjtewfPuInvvy981CRAFx+6OoHWjvuSaVT3iVHKZQkT6ahkn7U
	cU44RfzOAYHuKWgSVOQdbdLiNKiwDJ0=
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.source.kernel.org (Postfix) with ESMTPS id DAECFB80E58;
	Mon, 30 Jan 2023 07:40:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 803B9C433D2;
	Mon, 30 Jan 2023 07:40:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1675064418;
	bh=nSEjeldxldT/Tw4Jdo7TKldjMfhn6B7LCjpXjTkze+0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=fduDIw3yW9QehxqhCgDcjkokAopUrbyDr7tkY8lYUUndPiPfS5Fkj0SIBI3FfuiJA
	 GS1uTDVlT6/coCa6l2DpF77IlKb/XQ2yOynicBBC1Eld4xRezPzOw5aApNUIkRU5tF
	 VNn4JYcY+YhHMMS5lrQE3RU2BDpdO8++7bhTfFqo7KwTgFGaIYuw/uH9QZ9V+azQCr
	 keQiD5PP1S3BjUtmFIVjqIPom72nZyPBOQjQYmxpYItzpxRMppIASLABgC50LAFefH
	 ZsyTqnr9nJcCHjhkm+Z6nKyIuS+WqIdzj03qdoVHoiypno+GfDHIFzNvXw83oDW5B/
	 6XiNTAbaBrguw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 69AD5E4522A;
	Mon, 30 Jan 2023 07:40:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Subject: Re: [PATCH 1/5] batman-adv: Start new development cycle
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <167506441843.19672.4070886774468126901.git-patchwork-notify@kernel.org>
Date: Mon, 30 Jan 2023 07:40:18 +0000
References: <20230127102133.700173-2-sw@simonwunderlich.de>
In-Reply-To: <20230127102133.700173-2-sw@simonwunderlich.de>
To: Simon Wunderlich <sw@simonwunderlich.de>
Content-Transfer-Encoding: quoted-printable
X-MailFrom: patchwork-bot+netdevbpf@kernel.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-b.a.t.m.a.n.lists.open-mesh.org-0; header-match-b.a.t.m.a.n.lists.open-mesh.org-1
Message-ID-Hash: NSH54UMUCGEMSGH6BFN5QOAHAYC24KHN
X-Message-ID-Hash: NSH54UMUCGEMSGH6BFN5QOAHAYC24KHN
X-Mailman-Approved-At: Mon, 30 Jan 2023 09:15:32 +0100
CC: kuba@kernel.org, davem@davemloft.net, netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org
X-Mailman-Version: 3.2.1
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/U2V4PJDJSIYGBVPURTVGJD6WOFXZT2WA/>
List-Archive: <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

Hello:

This series was applied to netdev/net-next.git (master)
by Simon Wunderlich <sw@simonwunderlich.de>:

On Fri, 27 Jan 2023 11:21:29 +0100 you wrote:
> This version will contain all the (major or even only minor) changes fo=
r
> Linux 6.3.
>=20
> The version number isn't a semantic version number with major and minor
> information. It is just encoding the year of the expected publishing as
> Linux -rc1 and the number of published versions this year (starting at =
0).
>=20
> [...]

Here is the summary with links:
  - [1/5] batman-adv: Start new development cycle
    https://git.kernel.org/netdev/net-next/c/55307f51f48e
  - [2/5] batman-adv: Drop prandom.h includes
    https://git.kernel.org/netdev/net-next/c/c4b40f80585c
  - [3/5] batman-adv: Fix mailing list address
    https://git.kernel.org/netdev/net-next/c/8f6bc4583713
  - [4/5] batman-adv: mcast: remove now redundant single ucast forwarding
    https://git.kernel.org/netdev/net-next/c/e7d6127b89a9
  - [5/5] batman-adv: tvlv: prepare for tvlv enabled multicast packet typ=
e
    https://git.kernel.org/netdev/net-next/c/0c4061c0d0e2

You are awesome, thank you!
--=20
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

