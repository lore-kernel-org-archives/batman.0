Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AF80C2BB3F
	for <batman-adv@archiver.kernel.org>; Sat, 18 Nov 2023 18:02:25 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id A03EB83D75
	for <batman-adv@archiver.kernel.org>; Sat, 18 Nov 2023 19:02:23 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1700330543;
 b=aYEN/25/6SOUIegz+slgMcBqQy4F4My8LMLB+5Fd7G7dl5w8NwsI8UA9yO2F7eQrEPE84
 fvDQL2wIWI9RtoXyWf+VH8zF06X9v0tm+hTMjuBztc9qkXDcBDujPNDgRr3N5Z1Z57I97FA
 mbwUSx5y8wX+naK+U2sdTt3ZubRxFT0=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1700330543; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=wouCvTcUFLG4EZM9kRw96Pj1EV4nmbNDESjDNnJyJ34=;
 b=jZTzfTURhF4WOCsbxJk/4LZ3ryYqw4InVDy5UqohP7LJqsNuJ81FA+88njb9Cfnb2ZHsY
 S+fZLuYVDTIj4wwJD3mp3dKgjSPE3MF4z3LLMhtilF0BOeaaayjKZSpeR5MFhzrwJjOLkvM
 nTbRcsZKzmAY5oZIeZ7zf/1j167UMfk=
ARC-Authentication-Results: i=2; open-mesh.org; dkim=pass header.d=kernel.org;
  arc=pass;
  dmarc=pass (Used From Domain Record) header.from=kernel.org
 policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=kernel.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=kernel.org policy.dmarc=none
Received: from ams.source.kernel.org (ams.source.kernel.org
 [IPv6:2604:1380:4601:e00::1])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 9554580980
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sat, 18 Nov 2023 18:50:36 +0100 (CET)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1700329836;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=wouCvTcUFLG4EZM9kRw96Pj1EV4nmbNDESjDNnJyJ34=;
	b=m8p0BVBZ35+Km22nMDZLy/bbfLe2G6FNarZGvZnWzw7adOtJYARZB/J5biGpAgVNylpq8O
	86SPgEMxQ7EYRfXmorXkrIMYtaH4801y4U2JXtVNP7z+FWGNqsXmLuZWTiTCzyFEuQw+wE
	VAEthufegHitEZadK9SQUPAH2Fivxc8=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=kernel.org header.s=k20201202 header.b=Gu3YXKGQ;
	dmarc=pass (policy=none) header.from=kernel.org;
	spf=pass (diktynna.open-mesh.org: domain of
 patchwork-bot+netdevbpf@kernel.org designates 2604:1380:4601:e00::1 as
 permitted sender) smtp.mailfrom=patchwork-bot+netdevbpf@kernel.org
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1700329836; a=rsa-sha256;
	cv=none;
	b=3sPtjLl9wC2BUEf+Ipjt3BGRnNKnTNIPqBhhjrkAEG4mkdD0kT91PJb934HFZJ8jEZi7Uu
	TLdewbSL0j8Q0E80nKMeARTkKAL8Nb3mru+TtXxtcV8XplPEtrJIXgHw+VE0YO5BJ44VI5
	04TLOk8deND5EJzUG72KKBM8t+FmF3w=
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by ams.source.kernel.org (Postfix) with ESMTP id C51A9B81D08;
	Sat, 18 Nov 2023 17:50:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E6DD8C433C8;
	Sat, 18 Nov 2023 17:50:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700329834;
	bh=IjGq9Tn6TCqQNGvgrILNi0oe9NtJ7Ce9pw/XAhPlbk4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Gu3YXKGQkXMHj6zHyt6QoI8/cobanh1hErh6uCU3IomnWb6UNz6RhrjKm3Tco/wNu
	 wG7yz4gJtFlzzKCxTjG/fDVynwRdvNK4qgnE1dmWDiK8bhJQzE5WevboeYMl3SY70R
	 Dyqd4tRZI5BjrI2at8hmh5jkoVvEQk3Nn9UUTsrKFdlwz68gSps1KQqHfiMX1g5ZAX
	 dVfIG33mUkhe2nQMocF0r3gJBM/eZceqKR3OdHn8nO/D0rlaBZ0v+q7NzzPGMjG6RG
	 NLZ28TKN1DS+taow4gC+9Rs6fpbswXdfdi74susgDIzdywX9mOxQkeBbY9Aj9Z9T6W
	 vTey93ykapcKw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org
 (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id
 C6ADBEA6303;
	Sat, 18 Nov 2023 17:50:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 1/6] batman-adv: Start new development cycle
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170032983380.21361.9610627559571808432.git-patchwork-notify@kernel.org>
Date: Sat, 18 Nov 2023 17:50:33 +0000
References: <20231115175932.127605-2-sw@simonwunderlich.de>
In-Reply-To: <20231115175932.127605-2-sw@simonwunderlich.de>
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
Message-ID-Hash: XPJJHWDBHD64ROGGP2R7S7L7LAFP5MXA
X-Message-ID-Hash: XPJJHWDBHD64ROGGP2R7S7L7LAFP5MXA
X-Mailman-Approved-At: Sat, 18 Nov 2023 19:01:57 +0100
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/DB5EIZZHNJX62XWRNI37QJYCVZBAL6TN/>
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

On Wed, 15 Nov 2023 18:59:27 +0100 you wrote:
> This version will contain all the (major or even only minor) changes for
> Linux 6.8.
> 
> The version number isn't a semantic version number with major and minor
> information. It is just encoding the year of the expected publishing as
> Linux -rc1 and the number of published versions this year (starting at 0).
> 
> [...]

Here is the summary with links:
  - [1/6] batman-adv: Start new development cycle
    https://git.kernel.org/netdev/net-next/c/e4679a1b8a73
  - [2/6] batman-adv: mcast: implement multicast packet reception and forwarding
    https://git.kernel.org/netdev/net-next/c/07afe1ba288c
  - [3/6] batman-adv: mcast: implement multicast packet generation
    https://git.kernel.org/netdev/net-next/c/90039133221e
  - [4/6] batman-adv: mcast: shrink tracker packet after scrubbing
    https://git.kernel.org/netdev/net-next/c/2dfe644a1ce0
  - [5/6] batman-adv: Switch to linux/sprintf.h
    https://git.kernel.org/netdev/net-next/c/69f9aff27a94
  - [6/6] batman-adv: Switch to linux/array_size.h
    https://git.kernel.org/netdev/net-next/c/c3ed16a64c0b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


