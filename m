Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58E01FD9E35
	for <batman-adv@archiver.kernel.org>; Fri, 27 Feb 2026 03:30:38 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id A43CA8594F
	for <batman-adv@archiver.kernel.org>; Fri, 27 Feb 2026 04:30:36 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1772163036;
 b=KFhMq2Bb3MdzeexEks2a/egPRsof5a9StglhebMsZpzUdLtfgbTjuRhvrz3gTqZthAa32
 DaptOarCgIyTm3KDGAh0lJimo1yiOI0wh9ZM++6hz0uJotFihet1JDeB6dpmR1r4WidwE3N
 6EDRfWGpvrt6hKzFj+uCjZ1S4tRSKt4=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1772163036; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=QdwReOU7r5rDPJiFZPcJgBOeJ+msak9ZHx49dcXz00Y=;
 b=xOe+3T1avUr8fbZJSmG7YxhFkyQW0NsRs27vfbEnnxWge72LEaALwMyU/Cl8vC7CaDOe3
 GERe16ElNI43F+h8r0T3seG86HD6d6vxZXaYcpF3tl1n5DA3B4w+zNAZVxFCyk8I48HbrQ5
 ls57d8n4E2q9jlL1gNHkyCi2cnEWmA8=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=kernel.org;
 arc=pass;
 dmarc=pass header.from=kernel.org policy.dmarc=quarantine
Authentication-Results: open-mesh.org; dkim=pass header.d=kernel.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=kernel.org policy.dmarc=quarantine
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 526D283107
	for <b.a.t.m.a.n@lists.open-mesh.org>; Fri, 27 Feb 2026 04:30:03 +0100 (CET)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1772163003;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=QdwReOU7r5rDPJiFZPcJgBOeJ+msak9ZHx49dcXz00Y=;
	b=3sYLXbZ1Vh9IB5KPJJ16o7O/KgqpKIqOJA1/6qKRSaLTm3QHY3d31QwFokZo/BEuzCI2BA
	u9Na398ZpFdxTpmYclbHzKQyl7mS98ApxTiP1pa2Q7SkOWLxCuWZIJ/UluwT+vDwzmWifT
	xgks9vimHu3f5PquWf0zJRDC8EZgPJA=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=kernel.org header.s=k20201202 header.b=bNft+ry0;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (diktynna.open-mesh.org: domain of
 patchwork-bot+netdevbpf@kernel.org designates 2600:3c0a:e001:78e:0:1991:8:25
 as permitted sender) smtp.mailfrom=patchwork-bot+netdevbpf@kernel.org
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1772163003;
	b=VH4Mileo6cLD/mzWbQQYswghIlymHRWGqQr+l1Ye+vxzgtA4BxsMieBsJ0vZ4hcT0K1CvV
	A9qdaE6+Yw3JiRup+QMx/ojTmUoD3zcLgfnGpslJNWFkV+95oCBRLBYySglxMeUlzdgubk
	K65xpX2E0zNsa5fdq3AmUADFUPs8+lY=
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 23F84438DD;
	Fri, 27 Feb 2026 03:30:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F109EC19423;
	Fri, 27 Feb 2026 03:30:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772163001;
	bh=iiOwXb8uVifSZ7PySOcOmZe1Jp2tN1bt6v5sZO3UzmM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=bNft+ry00BO5EctoGu/4PmXQQ86TgRcDmWzuolyeWHWAhmBMewxuGH3u7cbn7Iy2j
	 LHrz9OM8PqFS2eZMNfVhLYkDTaVwatUHrYSuoU/z+xNNK36iTGavzwvQI+sUb0Jh9A
	 77JHtLwLPJO488k/5YUsBq4eMtDS0f+DS2tjBaJjMDMkT4dRpb+b35rqD0H2K5QLxc
	 Uv2jyAsB2vKScYj1VszyfeOvQJFAjmhMTLPdbT2D+ZX6S8xo9hyR1nYMX4sfu+zKvC
	 BGxsH6VzL3qa9ERcV7G6Fc4BcFVPBrKkGRuKPIIMrkCQOTBs4YyQSb6PuT1JKYwWil
	 njZyfXKeLxDsg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id
 3FE81393109B;
	Fri, 27 Feb 2026 03:30:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 1/1] batman-adv: Avoid double-rtnl_lock ELP metric
 worker
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177216300504.1958105.15758262442071363378.git-patchwork-notify@kernel.org>
Date: Fri, 27 Feb 2026 03:30:05 +0000
References: <20260225084614.229077-2-sw@simonwunderlich.de>
In-Reply-To: <20260225084614.229077-2-sw@simonwunderlich.de>
To: Simon Wunderlich <sw@simonwunderlich.de>
Cc: davem@davemloft.net, kuba@kernel.org, netdev@vger.kernel.org,
 b.a.t.m.a.n@lists.open-mesh.org, sven@narfation.org, stable@vger.kernel.org,
 github@grische.xyz, freifunk_nordm4nn@gmx.de
Message-ID-Hash: LBR53QV4GORKIRKOD3GXSENKLXNY6NL6
X-Message-ID-Hash: LBR53QV4GORKIRKOD3GXSENKLXNY6NL6
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
Archived-At: <>
List-Archive: <>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

Hello:

This patch was applied to netdev/net.git (main)
by Simon Wunderlich <sw@simonwunderlich.de>:

On Wed, 25 Feb 2026 09:46:14 +0100 you wrote:
> From: Sven Eckelmann <sven@narfation.org>
> 
> batadv_v_elp_get_throughput() might be called when the RTNL lock is already
> held. This could be problematic when the work queue item is cancelled via
> cancel_delayed_work_sync() in batadv_v_elp_iface_disable(). In this case,
> an rtnl_lock() would cause a deadlock.
> 
> [...]

Here is the summary with links:
  - [net,1/1] batman-adv: Avoid double-rtnl_lock ELP metric worker
    https://git.kernel.org/netdev/net/c/cfc83a3c7151

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


