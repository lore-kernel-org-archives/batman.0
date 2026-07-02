Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33A98C43602
	for <batman-adv@archiver.kernel.org>; Thu,  2 Jul 2026 08:40:59 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 5324E84267
	for <batman-adv@archiver.kernel.org>; Thu, 02 Jul 2026 10:40:54 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1782981654;
 b=C/dSwAwG2zHTmlMvgeRaufSys9iycgtS1sWgJ2dm+QBKlL+8UHLEsMTV0sKJ4igW0Gve5
 in9EbH8VD9bNJ8Alq5GephBFM+VfXuuFnyslBvwT9p1Qz1bSTdjgQF12FHAPqMF+QcdhbFC
 zRmceNFHPSjBXvRAMTWSHUsg4IsYyN4=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1782981654; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=8VMSXycOlH9NOdnFXl3zUFIjdbZj01HF3XqLUjhwnBE=;
 b=hXaFD52Y+xGkeaAaYJ/dwOJGFSNdjdvZmdvJvywlxj1wvIctap1sw4ElsmB+2n87cclLy
 xpNcyzba2sjr6J2cy1Z84UyzdrGvWaEnpdBaFakQpZM5y8MnwUafFUOWLfR3xQfQuFJ0hVP
 ftjksGrIAvJLlFFUrnBTXtTgEdLuh9c=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=kernel.org;
 arc=pass;
 dmarc=pass header.from=kernel.org policy.dmarc=quarantine
Authentication-Results: open-mesh.org; dkim=pass header.d=kernel.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=kernel.org policy.dmarc=quarantine
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 0704481678
	for <b.a.t.m.a.n@lists.open-mesh.org>; Thu, 02 Jul 2026 10:40:32 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1782981633;
	b=36QWUGeLLpyDeZOh+fxr8EIVp3nfm0h0RdjTPcdJP1zn+hsVKsZT/VpifuQU/UDRPg7eWq
	gCFQTEgWhec3qVC30AKqbY57jujCa9wlcU6QN40Tk1owMq8OL2gTyhwAR2lgN3wFNWeR/Y
	jTgfx741dkoKUiCLiMIGrggk7YByLIA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1782981633;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=8VMSXycOlH9NOdnFXl3zUFIjdbZj01HF3XqLUjhwnBE=;
	b=pd3Dh9+ueRhKwpcipVJ2dAak1UlxcytfqIpu1CDw0Q8CtAssppKst82vxP/ZLDxwNspMge
	g0GA4EQW/6RpJ/jAMGBgitHje7OtaNWDcisAutTfmPg9172akFtjd+dAwlE3QsNlwTUIAF
	q+rliB53o8Wcbln8a7AllMWmsm4DaCU=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=Z31ohw48;
	spf=pass (diktynna.open-mesh.org: domain of
 patchwork-bot+netdevbpf@kernel.org designates 172.234.252.31 as permitted
 sender) smtp.mailfrom=patchwork-bot+netdevbpf@kernel.org;
	dmarc=pass (policy=quarantine) header.from=kernel.org
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 3AA6943A5D;
	Thu,  2 Jul 2026 08:40:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B3101F00A3A;
	Thu,  2 Jul 2026 08:40:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782981631;
	bh=8VMSXycOlH9NOdnFXl3zUFIjdbZj01HF3XqLUjhwnBE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=Z31ohw480/a+WZo5w5EtGFtkYcOU1iUyJYJv7BmItjzGwbOECslT1FWeCTQ28wtrz
	 2pSTwQ/FcVhfh6FnolFmA+J6vSVec9vuIaI3Ipb0iqbgAjquqaec3K2HpaWlFRJeVj
	 h9urMOP0fijHjMVXGZh64j9UQqFCfy2A/JbFgHMmgi0VBBYxhcwynHkKlKSP1mbeK9
	 bofT7WRBT2M1UWuCqcQrLpOoAJw+6mhvgo3Ta+D6i077um3QpV9xUQXlKJ9MC5tM6B
	 JmRjicF1lA9yyLdE08SgA34efQ/2Cuv0UaQwyXm/SWN93BOL6yQ9rWee2sKaUWQv0U
	 jcnDFSDM6R2jg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id
 5688D3926664;
	Thu,  2 Jul 2026 08:40:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 1/6] batman-adv: retrieve ethhdr after potential skb
 realloc on RX
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178298161396.1523446.3039520497502044353.git-patchwork-notify@kernel.org>
Date: Thu, 02 Jul 2026 08:40:13 +0000
References: <20260630134430.85786-2-sw@simonwunderlich.de>
In-Reply-To: <20260630134430.85786-2-sw@simonwunderlich.de>
To: Simon Wunderlich <sw@simonwunderlich.de>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 b.a.t.m.a.n@lists.open-mesh.org, sven@narfation.org, stable@vger.kernel.org,
 sashiko-bot@kernel.org
Message-ID-Hash: LM3GQ5TQJDAH4AIV5HXBKRC45Z7BCNU7
X-Message-ID-Hash: LM3GQ5TQJDAH4AIV5HXBKRC45Z7BCNU7
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/LM3GQ5TQJDAH4AIV5HXBKRC45Z7BCNU7/>
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

On Tue, 30 Jun 2026 15:44:25 +0200 you wrote:
> From: Sven Eckelmann <sven@narfation.org>
> 
> pskb_may_pull() in batadv_interface_rx() could reallocate the buffer behind
> the skb. Variables which were pointing to the old buffer need to be
> reassigned to avoid an use-after-free.
> 
> This was done correctly for the VLAN header but missed for the ethernet
> header which is later used for the TT and AP isolation handling.
> 
> [...]

Here is the summary with links:
  - [net,1/6] batman-adv: retrieve ethhdr after potential skb realloc on RX
    https://git.kernel.org/netdev/net/c/035e1fed892d
  - [net,2/6] batman-adv: access unicast_ttvn skb->data only after skb realloc
    https://git.kernel.org/netdev/net/c/7141990add3f
  - [net,3/6] batman-adv: gw: acquire ethernet header only after skb realloc
    https://git.kernel.org/netdev/net/c/77880a3be88d
  - [net,4/6] batman-adv: dat: acquire ARP hw source only after skb realloc
    https://git.kernel.org/netdev/net/c/48067b2ae450
  - [net,5/6] batman-adv: bla: reacquire gw address after skb realloc
    https://git.kernel.org/netdev/net/c/cdf3b5af2bc4
  - [net,6/6] batman-adv: dat: ensure accessible eth_hdr proto field
    https://git.kernel.org/netdev/net/c/26560c4a03dc

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


