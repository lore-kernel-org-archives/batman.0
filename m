Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 049F6CA0FF0
	for <batman-adv@archiver.kernel.org>; Mon,  1 Sep 2025 20:40:26 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 7BE368433E
	for <batman-adv@archiver.kernel.org>; Mon, 01 Sep 2025 22:40:24 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1756759224;
 b=QB4j4b+ngcWIcSRD1VCMLk9EUSSbWiTy/KGtBC1yfwO6w7FBsigFx+feFX4pAuArB3k2f
 TWfE85/IrixV8ilDoV+4KEr15VcK1ElP2Q6HnpzhLy0cPr10sZFRWRiivlDaGp28v+rIBNz
 tOYBRiEEJxS3WJ2WVyreDGil0ZL3Ki8=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1756759224; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=yr1FvyLBiiebR/n+4OXyxyrmM/5d/e5gvuxU7TlGhKo=;
 b=FNs5xhNGlrz0U8Jjl+l03dmNZrLVlbCv3XbvszaK55G57kUmpQ4oq3YVOEyVBQkNwQ25V
 Bhp3aQzGNuQWdxwgc+okAHs4edLOV4CpamS0kGyjQlD2WfCr7uX1sI9Tj/EceiBVRlQyS1m
 EdyZv6O3jxNhKFcFcl287pJ/jn49jh0=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=kernel.org;
 arc=pass;
 dmarc=pass header.from=kernel.org policy.dmarc=quarantine
Authentication-Results: open-mesh.org; dkim=pass header.d=kernel.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=kernel.org policy.dmarc=quarantine
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 7ADAB842A0
	for <b.a.t.m.a.n@lists.open-mesh.org>; Mon, 01 Sep 2025 22:40:04 +0200 (CEST)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1756759204;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=yr1FvyLBiiebR/n+4OXyxyrmM/5d/e5gvuxU7TlGhKo=;
	b=AdFSjkp8plZDbyYs6GQAux07tCihOzTR6LpCl7u52IW5/vDtwdeqbnc6QrjkxJtP2EZcbF
	+TfrJErjiTSriQ4TIHl5L2kxbFaF4pQGtUGEOXaxiCPO9zsApmzjqzn6LvgBHSfcMZxd4V
	Vu1HnOFR9YjrGkfJOKiaq5STD6KgAXk=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=kernel.org header.s=k20201202 header.b=GSlYBQxd;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (diktynna.open-mesh.org: domain of
 patchwork-bot+netdevbpf@kernel.org designates 2600:3c04:e001:324:0:1991:8:25
 as permitted sender) smtp.mailfrom=patchwork-bot+netdevbpf@kernel.org
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1756759204; a=rsa-sha256;
	cv=none;
	b=Rm5E8Ik+l0TjXsqygMjMUoR3wxp1x1Ax+hgrSTr2fluL2vEaYxdHKzktVusuyhPdNVNPQ0
	2dx+luVbt2sfytKH4zKcKJ2E33gHRQRLju2BQpT6nmAoBVGFeZVxf2bpLqKeuOemRJ4ZUP
	cgqs1bgLwsUEuRj1wdk1IDt6+MEKWds=
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 0EFB8601E9;
	Mon,  1 Sep 2025 20:40:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8603C4CEF5;
	Mon,  1 Sep 2025 20:40:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756759202;
	bh=TQsdXo/XjaLSUYqZV3CzXaSVUVIWdgIM5Dg3GPo1Rgg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=GSlYBQxdV+8/WnyxgORuHiGxvzWeCpSSokTgD2Mgxxu40Pn7CF6Dsb1UYmKflWOn0
	 DwjQnk7is3+ea38Ny71PNUqvttWjIWHVLS+HB1q5v+ynGMRwsLXIGhypnTNS7+VNs5
	 t1QVlB4ArRHoiJnSG4uhp9W3wk/5H3yJysmDRBy5HiZG3HQ3zvH4LbaQSBsN9iJxfX
	 pJNr+9KDwZjI4YZpiwAdUCgA6t/hPwo91GFI1fkFaPEZ+kvsP5GLdCJkUWQ7QSfH7B
	 Ou6m8/nRJkB4KM3M1uWsqdc3AVPvvGhQMeAgy2PzsZJ5OEBPhvIfZST0hrdj5yyvLE
	 VLojkphQrmATQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id
 B6A15383BF4E;
	Mon,  1 Sep 2025 20:40:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 1/1] batman-adv: fix OOB read/write in network-coding
 decode
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175675920849.3877324.13775233533723046808.git-patchwork-notify@kernel.org>
Date: Mon, 01 Sep 2025 20:40:08 +0000
References: <20250901161546.1463690-2-sw@simonwunderlich.de>
In-Reply-To: <20250901161546.1463690-2-sw@simonwunderlich.de>
To: Simon Wunderlich <sw@simonwunderlich.de>
Message-ID-Hash: WCGYE4SOEZ2ZAKHT7WYR3CFADUWHW4OJ
X-Message-ID-Hash: WCGYE4SOEZ2ZAKHT7WYR3CFADUWHW4OJ
X-MailFrom: patchwork-bot+netdevbpf@kernel.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-b.a.t.m.a.n.lists.open-mesh.org-0;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-1;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-2; emergency; member-moderation
CC: davem@davemloft.net, kuba@kernel.org, netdev@vger.kernel.org,
 b.a.t.m.a.n@lists.open-mesh.org, stanislav.fort@aisle.com,
 stable@vger.kernel.org, disclosure@aisle.com
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/WCGYE4SOEZ2ZAKHT7WYR3CFADUWHW4OJ/>
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

On Mon,  1 Sep 2025 18:15:46 +0200 you wrote:
> From: Stanislav Fort <stanislav.fort@aisle.com>
> 
> batadv_nc_skb_decode_packet() trusts coded_len and checks only against
> skb->len. XOR starts at sizeof(struct batadv_unicast_packet), reducing
> payload headroom, and the source skb length is not verified, allowing an
> out-of-bounds read and a small out-of-bounds write.
> 
> [...]

Here is the summary with links:
  - [net,1/1] batman-adv: fix OOB read/write in network-coding decode
    https://git.kernel.org/netdev/net/c/d77b6ff0ce35

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


