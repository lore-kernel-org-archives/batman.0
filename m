Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E1F2C43458
	for <batman-adv@archiver.kernel.org>; Thu,  9 Jul 2026 09:21:26 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 67098841D8
	for <batman-adv@archiver.kernel.org>; Thu, 09 Jul 2026 11:21:25 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1783588885;
 b=SXPQE0ycyO8zKJqUIoqefm8qCZtDmVSBuUROWsAlS2ZNeDijyFjw+7vyxQWzGxw29hKT2
 abafVKBDo6cJCQCdCOI1O1DArQoseH6yyF0lXcQk+f//0EXwMwSgsAX8/5AA8xFQzvSwVPQ
 ZtmYH2z0PujenY/a4retE3ouJ9/6Zqw=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1783588885; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=K3oDSCq0e8fq1E3kfwxiBNJ3XGysx97IQDwhOEiZyFI=;
 b=YzQT4m/GqHHRzhWOk2xG5EUZXKuew4+t3LI1aKH2glfoWGxVMqW0BV7sK3BJRffiymImM
 qyohpORciLtlcS1NKAy0FHoyvM6pdAXMwea8REzHw9eVLPFzW2X4gSANR39XywyBvm7Ie2o
 2b9b+82jUqHL4e4Nro6xYElUpyZPZqY=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=kernel.org;
 arc=pass;
 dmarc=pass header.from=kernel.org policy.dmarc=quarantine
Authentication-Results: open-mesh.org; dkim=pass header.d=kernel.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=kernel.org policy.dmarc=quarantine
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id F1486804FC
	for <b.a.t.m.a.n@lists.open-mesh.org>; Thu, 09 Jul 2026 11:20:44 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1783588855;
	b=moB+XGRDcY8/zQTpIdi01xpLOdZYaurDEtecXHId8LE2UuAias6ENuo18fh4RbzG1XsoC3
	2Ijt7yTI8pXLi+ZkmE7hSiuVtoLQKtpDDtWBcZFHbACTUk3XQv/XhgTOuMC0pEnBMsTAFl
	2fE0WXhKPCgQHYYX0pgLTDYkuscKXHQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1783588855;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=K3oDSCq0e8fq1E3kfwxiBNJ3XGysx97IQDwhOEiZyFI=;
	b=yCkPwavbzHPNMLgkgbDZ9Lx7CLHiwdl+KDpZ9QAsqVk4eKPbCduprEbc3x8S7Taaku8Jsh
	visz4enchTghIJETGmK5XSJ+XI5s8ztg4cNje9eXJrBo+C7CxiTAwcjYpgCKdcGLP89xAG
	R1xEbbTRVp6AwrP6zMOWNmaxG0DGWO0=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=kCNUL24U;
	spf=pass (diktynna.open-mesh.org: domain of
 patchwork-bot+netdevbpf@kernel.org designates 172.234.252.31 as permitted
 sender) smtp.mailfrom=patchwork-bot+netdevbpf@kernel.org;
	dmarc=pass (policy=quarantine) header.from=kernel.org
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id CBE9D433AF;
	Thu,  9 Jul 2026 09:20:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADA661F000E9;
	Thu,  9 Jul 2026 09:20:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783588842;
	bh=K3oDSCq0e8fq1E3kfwxiBNJ3XGysx97IQDwhOEiZyFI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=kCNUL24UMlODqSOgMyE/UcsKJA04LYuGHy1ArpYvMMQFDRq5lvSjSBuxc4UpvEw3B
	 dY0G0nqr9bdQa/rEkWk5tYJmsAx+qJbjg/nL9efqMP7CHYfwu+ESyos8IShg66DLjr
	 osoXJeAgcI54NaSBfBFLpLvCX4SPgTpD1D822y0o4OA3HPKfnPHtpb3eO77RVAeqG3
	 DKK97htGTLU3wnQ0+AH/baFwbrIeFo+1+CyhbcuoQJthICjM2F6Gap4/Em1P7JJx3g
	 VXqGU1buhU4uU9eKJzdLRG6Q+UX/oIS+jCTQmb5JYsloojheoLkcaANuKUsjGSudFv
	 2YlbQDWKo+RRg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id
 939F3393A564;
	Thu,  9 Jul 2026 09:20:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 1/9] batman-adv: ensure minimal ethernet header on TX
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178358882114.3359576.16875111531041578494.git-patchwork-notify@kernel.org>
Date: Thu, 09 Jul 2026 09:20:21 +0000
References: <20260708091821.314516-2-sw@simonwunderlich.de>
In-Reply-To: <20260708091821.314516-2-sw@simonwunderlich.de>
To: Simon Wunderlich <sw@simonwunderlich.de>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 b.a.t.m.a.n@lists.open-mesh.org, sven@narfation.org, stable@vger.kernel.org,
 sashiko-bot@kernel.org
Message-ID-Hash: SPRJNSQFONQACXGZ3W6LL2TCF4Y4GVOX
X-Message-ID-Hash: SPRJNSQFONQACXGZ3W6LL2TCF4Y4GVOX
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/SPRJNSQFONQACXGZ3W6LL2TCF4Y4GVOX/>
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

On Wed,  8 Jul 2026 11:18:13 +0200 you wrote:
> From: Sven Eckelmann <sven@narfation.org>
> 
> As documented in commit 8bd67ebb50c0 ("net: bridge: xmit: make sure we have
> at least eth header len bytes"), it is possible by for a local user with
> eBPF TC hook access to attach a tc filter which truncates the packet and
> redirects to an batadv interface. But the code assumes that at least
> ETH_HLEN bytes are available and thus might read outside of the available
> buffer.
> 
> [...]

Here is the summary with links:
  - [net,1/9] batman-adv: ensure minimal ethernet header on TX
    https://git.kernel.org/netdev/net/c/49df66b7993c
  - [net,2/9] batman-adv: fix VLAN priority offset
    https://git.kernel.org/netdev/net/c/fdb3be00ba4d
  - [net,3/9] batman-adv: clean untagged VLAN on netdev registration failure
    https://git.kernel.org/netdev/net/c/8669a550c752
  - [net,4/9] batman-adv: tt: avoid request storms during pending request
    https://git.kernel.org/netdev/net/c/27c7d4000823
  - [net,5/9] batman-adv: tt: prevent TVLV OOB check overflow
    https://git.kernel.org/netdev/net/c/7a581d9aaba8
  - [net,6/9] batman-adv: frag: free unfragmentable packet
    https://git.kernel.org/netdev/net/c/6b628425aed4
  - [net,7/9] batman-adv: frag: fix primary_if leak on failed linearization
    https://git.kernel.org/netdev/net/c/353d2c1d5492
  - [net,8/9] batman-adv: mcast: avoid OOB read of num_dests header
    https://git.kernel.org/netdev/net/c/38eaed28e250
  - [net,9/9] batman-adv: dat: fix tie-break for candidate selection
    https://git.kernel.org/netdev/net/c/98052bdaf6ac

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


