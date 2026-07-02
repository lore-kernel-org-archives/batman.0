Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A7EFC43458
	for <batman-adv@archiver.kernel.org>; Thu,  2 Jul 2026 08:41:44 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 508748155F
	for <batman-adv@archiver.kernel.org>; Thu, 02 Jul 2026 10:41:38 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1782981698;
 b=HYecy6dd3Vj7UUyVT67t4GeKQQMd38g5+ZRZ06ZuTovm0JeIc2I+fVGFKC/79fcJi+l3+
 rVSE7DCu9eC+D7MBwkRU0MqXUzNoEXrAaSyeiujJdbFPa+f7icUR2o3GQIKXL/vmd7YV4SH
 oF5/oA/SfyFcL0xKKomTxr8aAlHb+E4=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1782981698; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=rlECEzGVBnRQcX1PJHlOlcimtBsMPxut6cTFhxNIhiU=;
 b=hqx2etSQMkvtpEWe7+ITIVZaCsMUeSMC9XZDTm0WlPkwEb+9Wzhvn4i83XDp6CkQZKk0T
 CWVzU7fJ27NA93SsKYPo5hCbjG92xEyYc85ebvQa0eirA7D2qO7REXXRQ2nnEj6JiNjJ+HF
 holzo42Q8tp4RKhDIbFgd/Sz1eR17e4=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=kernel.org;
 arc=pass;
 dmarc=pass header.from=kernel.org policy.dmarc=quarantine
Authentication-Results: open-mesh.org; dkim=pass header.d=kernel.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=kernel.org policy.dmarc=quarantine
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 3DAC184361
	for <b.a.t.m.a.n@lists.open-mesh.org>; Thu, 02 Jul 2026 10:41:01 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1782981661;
	b=T35DqGNdgi1Cx1XWSZYZqkwVajjnYXmONyWB/EWus7iskcIQlI60blYjXTjBE5ehvWvXrc
	3BAXT+v94+HSDozojsbtctqlX4dKduTd327GHbeaxHNvj6rSu/GY1C14EqAIBPz3vzZ0A0
	Uqp+IbUIyJXaVpZ/x9kRvH+YT4DMkfU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1782981661;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=rlECEzGVBnRQcX1PJHlOlcimtBsMPxut6cTFhxNIhiU=;
	b=y5CXU/JYhoWZATxRky8VEDRSSbtzpQOoeyeBptbvxZOL+nJmg0ytusI5F2vMbaaEzzPiUq
	zeB7jGK5BdIZRo0JorqqRQ57mc+wPjuHD0mu+rvhLu6OvZRHVDNUBnu0xwCBB64bFa3WYp
	c2qUkHGoOp8Z84vnbq8LQDFk+sgdnsU=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=erLP9qVF;
	spf=pass (diktynna.open-mesh.org: domain of
 patchwork-bot+netdevbpf@kernel.org designates 172.234.252.31 as permitted
 sender) smtp.mailfrom=patchwork-bot+netdevbpf@kernel.org;
	dmarc=pass (policy=quarantine) header.from=kernel.org
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id F22DF42A14;
	Thu,  2 Jul 2026 08:40:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D390B1F00A3A;
	Thu,  2 Jul 2026 08:40:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782981659;
	bh=rlECEzGVBnRQcX1PJHlOlcimtBsMPxut6cTFhxNIhiU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=erLP9qVFeoBKHxbL5S7+0GXPVVPi5R49WQM/bQe7BGucsZeYJHSIwc775V9xTS0R+
	 7XJBgRHKLvByjqT5507N6HqkIjNazNm7Kvf2DUIjuuW0uHWVvmi8o6xOw4Ms6r2i9A
	 JkipjPf2QxfmpN7YZExKSQ0MPYVL46OG/WvkQdKxsI3E9a68Sk4SxwB/e3vlxREcPy
	 3bQK3G/E4e/bzUADxS+xEiZNO/v9evCWmajFbbunWQjVyboDAizqr9LMZE1fE/zdPD
	 dnBh6a9eZGWsvNAThX8HmB0pS3DMLgEtGZ00O7KyZn524+suXM4pqtDLqAI8T0RVSj
	 1FXzKgKN0QEGg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id
 1983C3926664;
	Thu,  2 Jul 2026 08:40:44 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 01/15] batman-adv: create hardif only for netdevs
 that are part of a mesh
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178298164263.1523446.6187059831704914179.git-patchwork-notify@kernel.org>
Date: Thu, 02 Jul 2026 08:40:42 +0000
References: <20260630140623.88431-2-sw@simonwunderlich.de>
In-Reply-To: <20260630140623.88431-2-sw@simonwunderlich.de>
To: Simon Wunderlich <sw@simonwunderlich.de>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 b.a.t.m.a.n@lists.open-mesh.org, neocturne@universe-factory.net,
 sven@narfation.org
Message-ID-Hash: O7TIF3SX4JRJHOXHXR6K5HQYXICZYJ2Y
X-Message-ID-Hash: O7TIF3SX4JRJHOXHXR6K5HQYXICZYJ2Y
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/O7TIF3SX4JRJHOXHXR6K5HQYXICZYJ2Y/>
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

On Tue, 30 Jun 2026 16:06:09 +0200 you wrote:
> From: Nora Schiffer <neocturne@universe-factory.net>
> 
> batman-adv is using netdev notifiers to create a hard_iface struct for
> every Ethernet-like netdev in the system. These hardifs are tracked in a
> global linked list, which results in a few performance issues:
> 
> Lookups in this list are O(n) in the total number of netdevs. As a
> hardif is looked up when a netdev is removed, this also takes O(n) in
> the number of netdevs, and removing n netdevs may take O(n^2). This
> slowdown will always happen when the batman-adv module is loaded, no
> mesh needs to be active.
> 
> [...]

Here is the summary with links:
  - [net-next,01/15] batman-adv: create hardif only for netdevs that are part of a mesh
    https://git.kernel.org/netdev/net-next/c/fcba102e0e4a
  - [net-next,02/15] batman-adv: remove global hardif list
    https://git.kernel.org/netdev/net-next/c/49e9de6e124f
  - [net-next,03/15] batman-adv: make hard_iface->mesh_iface immutable
    https://git.kernel.org/netdev/net-next/c/f846e779532e
  - [net-next,04/15] batman-adv: remove BATADV_IF_NOT_IN_USE hardif state
    https://git.kernel.org/netdev/net-next/c/48ea7b6b7b94
  - [net-next,05/15] batman-adv: move hardif generation counter into batadv_priv
    https://git.kernel.org/netdev/net-next/c/cbda6a6cf2a5
  - [net-next,06/15] batman-adv: drop unneeded goto and initialization from batadv_hardif_disable_interface()
    https://git.kernel.org/netdev/net-next/c/2b429dbc50b4
  - [net-next,07/15] batman-adv: drop NULL check for immutable hardif->mesh_iface
    https://git.kernel.org/netdev/net-next/c/b58c36b804f4
  - [net-next,08/15] Revert "batman-adv: v: stop OGMv2 on disabled interface"
    https://git.kernel.org/netdev/net-next/c/5fa5f64fc018
  - [net-next,09/15] batman-adv: iv: drop migration check for batadv_hard_iface
    https://git.kernel.org/netdev/net-next/c/ba2d97e8736e
  - [net-next,10/15] batman-adv: tvlv: extract tvlv header iterator
    https://git.kernel.org/netdev/net-next/c/278e5890704c
  - [net-next,11/15] batman-adv: tp_meter: simplify unordered ack calculation
    https://git.kernel.org/netdev/net-next/c/71b7987ec001
  - [net-next,12/15] batman-adv: tp_meter: combine adjacent/overlapping unacked entries
    https://git.kernel.org/netdev/net-next/c/936a1c10cece
  - [net-next,13/15] batman-adv: tp_meter: keep unacked list for receivers
    https://git.kernel.org/netdev/net-next/c/3bbb8b94217a
  - [net-next,14/15] batman-adv: tp_meter: adjust name of receiver lock
    https://git.kernel.org/netdev/net-next/c/6cd45ef4dfa5
  - [net-next,15/15] batman-adv: tp_meter: delay allocation of unacked entry
    https://git.kernel.org/netdev/net-next/c/247691642fd4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


