Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45560C48286
	for <batman@archiver.kernel.org>; Thu,  1 Feb 2024 18:20:29 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 6CBA383464
	for <batman@archiver.kernel.org>; Thu,  1 Feb 2024 19:20:27 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1706811627;
 b=g5MAL3SYl/95x4+qokw5G7vIkdpKWXl7jCRzXZ0ytWPAoQpXVhjbxmY6885AZXfG+WPzx
 YjuPKvZ0F+BORhlwd9+PWl6xjrS+mlZL3yHVZWeRgeyLfbsIvM52lYrzGISDI91i+6aEgDs
 /wp8w8SjS9TPeN0wwz+9KVzPAI8KJYo=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1706811627; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=lbCgbtXWv17lNMZivKSYR3rDYHMHeTDODpOjhJSpHxo=;
 b=yPU+jlGQQ7yYIpDWlwpRMqBU9mTjtLX69DB2NBzV76Aw6HjKVZjnxzEA0vw+cDT6egzD0
 IRE8Vl5eo7SP1mOHmtnetXXq+3+BMpy6/HfOm9/3Uu04L7+mdphMutw20+x/1/YFRXsWFr/
 kt6MEeuGnM32U5Gh+9+gQelon0L+SYk=
ARC-Authentication-Results: i=2; open-mesh.org; dkim=pass header.d=kernel.org;
  arc=pass;
  dmarc=pass (Used From Domain Record) header.from=kernel.org
 policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=kernel.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=kernel.org policy.dmarc=none
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 84CB881467
	for <b.a.t.m.a.n@lists.open-mesh.org>; Thu,  1 Feb 2024 18:30:27 +0100 (CET)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1706808627;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=lbCgbtXWv17lNMZivKSYR3rDYHMHeTDODpOjhJSpHxo=;
	b=JCA4i5hDGJxSP6lNis9rSSMzdWlHa2JQd5bMyR21A44xwzpSo1GiZLGMF7D1yWXrj38lmW
	vB1++WsY69pMTzqCiHfSkkpc+k8MeZB+SkRhMz5R9UrJzMtiV6r0USXLiWhB6aWN0GxEoy
	Q/1FAEZxtD9hedrOXqL1STDr9iQa3yo=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=kernel.org header.s=k20201202 header.b=t624OMvH;
	spf=pass (diktynna.open-mesh.org: domain of
 patchwork-bot+netdevbpf@kernel.org designates 139.178.84.217 as permitted
 sender) smtp.mailfrom=patchwork-bot+netdevbpf@kernel.org;
	dmarc=pass (policy=none) header.from=kernel.org
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1706808627; a=rsa-sha256;
	cv=none;
	b=Gzmb4X79akExemH8RusqJ8QXtjptuZisSLqC8ut7+6zps8ONNzMXjuXp8G4aOJM5nZzJdQ
	5RQifZdT0OoarUetTqWPu6RIum3D4G8LfJLaRAWvtgbxUpJQOy4f6aRpLlB3NKCHSYcHpL
	nFPwfoNv02oEbdrjOiXf/EK4PZGKMpo=
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 2A28C6200E;
	Thu,  1 Feb 2024 17:30:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id CB975C43390;
	Thu,  1 Feb 2024 17:30:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706808625;
	bh=rj39GmVf5Um4yqY9ZyFiUDJf88cI4LWBo8tDH09V1Nc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=t624OMvHM5t3nP0q7msJYOP2JdkHubzWMm/Sw2VIX5AtF5RMXOVtCE7wUFXZRxos3
	 hZELeXDdXu7nHfulfdgdXx6H8Gps2sxfkglX2qZebW0u5R2181J3qDezjxrVcl+0ES
	 jHGCNRHnf6FHRu9EQuZ40pj6M+zdqXVLP1046rMrH6DPioPke9r5IMaaCO7ID649bH
	 dl2m6PuBZ6gV02nojGBoYa38kKG5+jjWfvF2pCr8Q1qnaO3HsQj4NRC/DWTn6p/HK2
	 HISQgJqePnk6Dp+7nKgNsKSRvNyNqzf61wlmz1fFhNaHrU3qsP0nyfCqFU631uAJh6
	 r6hM1alB+3VBQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org
 (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id
 B2F04C0C40E;
	Thu,  1 Feb 2024 17:30:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 1/2] batman-adv: mcast: fix mcast packet type counter on
 timeouted nodes
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170680862572.30194.1130104142363817483.git-patchwork-notify@kernel.org>
Date: Thu, 01 Feb 2024 17:30:25 +0000
References: <20240201110110.29129-2-sw@simonwunderlich.de>
In-Reply-To: <20240201110110.29129-2-sw@simonwunderlich.de>
To: Simon Wunderlich <sw@simonwunderlich.de>
Cc: davem@davemloft.net, kuba@kernel.org, netdev@vger.kernel.org,
 b.a.t.m.a.n@lists.open-mesh.org, linus.luessing@c0d3.blue, sven@narfation.org
X-MailFrom: patchwork-bot+netdevbpf@kernel.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-0;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-1;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-2
Message-ID-Hash: D3KKUBZRW3AWIPZURQIURO6NPKMQYNRO
X-Message-ID-Hash: D3KKUBZRW3AWIPZURQIURO6NPKMQYNRO
X-Mailman-Approved-At: Thu, 01 Feb 2024 19:20:20 +0100
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/ANBPJAWYEAEH2WB3IS6BKDPHC3DMCEX4/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

Hello:

This series was applied to netdev/net.git (main)
by Simon Wunderlich <sw@simonwunderlich.de>:

On Thu,  1 Feb 2024 12:01:09 +0100 you wrote:
> From: Linus Lüssing <linus.luessing@c0d3.blue>
> 
> When a node which does not have the new batman-adv multicast packet type
> capability vanishes then the according, global counter erroneously would
> not be reduced in response on other nodes. Which in turn leads to the mesh
> never switching back to sending with the new multicast packet type.
> 
> [...]

Here is the summary with links:
  - [1/2] batman-adv: mcast: fix mcast packet type counter on timeouted nodes
    https://git.kernel.org/netdev/net/c/59f7ea703c38
  - [2/2] batman-adv: mcast: fix memory leak on deleting a batman-adv interface
    https://git.kernel.org/netdev/net/c/0a186b49bba5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


