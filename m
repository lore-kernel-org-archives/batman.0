Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9244DC5DF86
	for <batman-adv@archiver.kernel.org>; Thu, 20 Aug 2026 20:31:39 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id AD4EA83C52
	for <batman-adv@archiver.kernel.org>; Thu, 20 Aug 2026 22:31:37 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1787257897;
 b=RxogtBYIrQX5RuDsanrutJ/1vXX9hEVHi24MnXl2ZkaWzG1DLa+8hONx4M51zRUui64i6
 PqUcfdTUerCt7QrO4AdjZNqq98BvoFDt12r70LIJ/u3FC+VJy+N1PJSlmRXLrAkHBH0r3Lq
 4ow45aWFgs4aBPv5/lBrXjhCgm+M7m4=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1787257897; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=5tuYkouMIEcOArFytrs8YKMb7M1bAek8TM5fLRAeDgI=;
 b=n0SfgdadCQBG1+897Y8XwvlekASfORmxRrQc1Zm/XaQ2e3pW/58vdX9/RNV7jPOnBW9iM
 n2di65q/6nNpdSPrevjtmNdo66/etAOdyFNX9Xkn9DBUW+vyqFqHj0Aul2QJZBMg5YP1fEO
 3p9QgDEamaeF+e/ITPgsFxdRGU3sOr0=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=kernel.org;
 arc=pass;
 dmarc=pass header.from=kernel.org policy.dmarc=quarantine
Authentication-Results: open-mesh.org; dkim=pass header.d=kernel.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=kernel.org policy.dmarc=quarantine
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 984DC82DF9
	for <b.a.t.m.a.n@lists.open-mesh.org>; Thu, 20 Aug 2026 22:31:18 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1787257888;
	b=Bvrr5ToOJJX8iNKBJ3RgBXtWUU24g4yf9UwpV3nUk905i3zNPjIYm1bloQ87exikc4JHCS
	1mk51Tw94HVxzsUIHAICOGgd6Q2rv6NSGaaAVdOXlrA3/wBKRe/qUhAVQwAYODVyhMoyun
	WXNJAxc2VXEYubDU+Xycd4bHovJLxAk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1787257888;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=5tuYkouMIEcOArFytrs8YKMb7M1bAek8TM5fLRAeDgI=;
	b=3B1hKN51lsm5ox4MkhrY/D/p8kNzCp1ceDGq3Lu+GNosh+unj3dnDHpUsBLwtxM53IyQSY
	UPA9jVXn7Lkc9qz/SOgjyPmVtDY3T3D2Ij1OXSPxwxSe+7C8WRnLOOMzhJ8bcKr2tMgT9N
	UgPYSgyM7MUvVz6QuuYnVaX+yGWzy5c=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=L9vntcEh;
	spf=pass (diktynna.open-mesh.org: domain of
 patchwork-bot+netdevbpf@kernel.org designates 2600:3c04:e001:324:0:1991:8:25
 as permitted sender) smtp.mailfrom=patchwork-bot+netdevbpf@kernel.org;
	dmarc=pass (policy=quarantine) header.from=kernel.org
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 3C4B060A71;
	Thu, 20 Aug 2026 20:31:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5BC61F00A3A;
	Thu, 20 Aug 2026 20:31:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787257876;
	bh=5tuYkouMIEcOArFytrs8YKMb7M1bAek8TM5fLRAeDgI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=L9vntcEh8neJKtXNfS5OoUPul/kH3cQcmh8l1FNInoAeIiis+QGWwGLfrk7aP6LOy
	 m3xLrSAmtRErGoOfuy7tjF6GKH7BvwMETRHHTgYpgF15BY/OItfIWYmPVXTIqGTDOB
	 r/5/Is41z3h5bc5jSBz6HNUDoV+heeOiiUKbWcGpdLQv5MlwCOJ9aneVWAcqVAtYdz
	 saF7fzkQcsqTDT6lKO+K0X8L3Vk9RTFMQJl2cYN5YEx7awp3vrYhubs2cfZ3tLHBTV
	 IZOAXVV2czdqLK9Mu6UTcGSzIyAB0L8Ntgvtjd0404gF5rUcF5H0+Tg2hw/aBS/bC7
	 V4xnYFiilq3Xg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id
 56751392445B;
	Thu, 20 Aug 2026 20:30:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v3] batman-adv: reject unrepresentable multicast TVLV
 offsets
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178725782688.470503.16295189825749503544.git-patchwork-notify@kernel.org>
Date: Thu, 20 Aug 2026 20:30:26 +0000
References: <20260817084955.944189-1-david.lee@trailofbits.com>
In-Reply-To: <20260817084955.944189-1-david.lee@trailofbits.com>
To: David Lee <david.lee@trailofbits.com>
Cc: marek.lindner@mailbox.org, sw@simonwunderlich.de, antonio@mandelbit.com,
 sven@narfation.org, kylebot@openai.com, davem@davemloft.net,
 linus.luessing@c0d3.blue, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, dominik.czarnota@trailofbits.com,
 netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Message-ID-Hash: MTK3UAC2KD5AWZUOOTQVMIE3FTHDAZOP
X-Message-ID-Hash: MTK3UAC2KD5AWZUOOTQVMIE3FTHDAZOP
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/MTK3UAC2KD5AWZUOOTQVMIE3FTHDAZOP/>
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

On Mon, 17 Aug 2026 08:49:54 +0000 you wrote:
> From: Kyle Zeng <kylebot@openai.com>
> 
> The network and transport header fields in struct sk_buff are 16-bit
> offsets from skb->head, and U16_MAX is reserved as the unset transport
> header value. batadv_tvlv_call_handler() sets both fields from a received
> multicast TVLV without checking whether the TVLV end is representable.
> 
> [...]

Here is the summary with links:
  - [net,v3] batman-adv: reject unrepresentable multicast TVLV offsets
    https://git.kernel.org/netdev/net/c/f12c2de4f542

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


