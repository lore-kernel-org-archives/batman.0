Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E759C5CFCF
	for <batman@archiver.kernel.org>; Thu, 13 Aug 2026 02:01:38 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 9C1E283B12
	for <batman@archiver.kernel.org>; Thu, 13 Aug 2026 04:01:36 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1786586496;
 b=czKoXoGZHlENGHbIUJoV5h6rZ5aODx1QgOTr8EKGaf5+zjvjssko+rGMl2jzfmqe9Ayvi
 qP74nWMb6RaZoXT9P9bnI1bpbPE4vXZYMbkm+zlfHIoamN69nxbTBq7k+X5a3/zzq9bA1Lf
 LboBk2zoHe4/klA/k6q74yes4UaR+bM=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1786586496; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=oDooSXLIV5Tj92pi9xACQ9Y8xUulN5SFZ9Gh0I2SRqc=;
 b=Hgvx4UW1DqD+Qo7DiRVA2pL3l2gLUrBO3E20mgeE0TkMS6VRulUWRMuVdYvcrwh92r9hb
 OsoNt4NRDRFJDwenUgdtB14UNWCZ77p+lOWsQ3nuEeUj83tEPyE1CgU29dkhh6BYoxiSSz9
 /IHs34lGLkpo217jJ/D6+XyJyzlmCms=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=kernel.org;
 arc=pass;
 dmarc=pass header.from=kernel.org policy.dmarc=quarantine
Authentication-Results: open-mesh.org; dkim=pass header.d=kernel.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=kernel.org policy.dmarc=quarantine
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id E98CB80468
	for <b.a.t.m.a.n@lists.open-mesh.org>; Thu, 13 Aug 2026 04:01:05 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1786586476;
	b=ra/cWwj4O9D3kzCk5jvrpfSi+bUG/mFKMQ/Rp6pgeb6W5XB72zfew7PpE0vLzvp3bpkTKF
	w2du0eDvKKq1VqKfEgcDhQbG5m4RW8s5v1pa0DL2y+OXKHubQKgHOc7Tv6A8ruNt/iys7V
	wbCEnmbWTTCOjQsIED5/IlIcxSIn97I=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1786586476;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=oDooSXLIV5Tj92pi9xACQ9Y8xUulN5SFZ9Gh0I2SRqc=;
	b=jJNsgTT/s1/KHN1tN6V2VxmBbZPYBRe14fiv1MgOYaLDJLdhVSGxY8s5rzPDMAWc6Rfxpc
	IPPqRRT9u3Ms6EJX8khxY9G7YjtrdF0wH9Zj/Rscije17jgpTWJ7z7Nbzjhmbb4XTc4P7f
	63vwVW9O+essX2IAUFGgdnQGNaqzkGc=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=PtqK6WqY;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (diktynna.open-mesh.org: domain of
 patchwork-bot+netdevbpf@kernel.org designates 2600:3c04:e001:324:0:1991:8:25
 as permitted sender) smtp.mailfrom=patchwork-bot+netdevbpf@kernel.org
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id C3D19600BB;
	Thu, 13 Aug 2026 02:01:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7912A1F000E9;
	Thu, 13 Aug 2026 02:01:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786586463;
	bh=oDooSXLIV5Tj92pi9xACQ9Y8xUulN5SFZ9Gh0I2SRqc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=PtqK6WqYlXd/xPZ3youNYdkGuoGuys9klhsdKendasq2ukR39eF4lhJ691XmuL79i
	 jtXQtpv4bYAJ+51xS0q+KixyvMUeikD5sliVEjRu1Feaqd+wgUwdDaUiuz+tXfxs7y
	 uzPAMoQawvvHMzarbsLopPLqdY+dUURP52premLDCI3r0gKKSRb8ZFBsFBR1iLPrdA
	 teUQ10XrSSx56p0QwH2voWjHnJRadD2x466Gza+XrWPVc6ukTV7k6qiIJ6Dutj85C3
	 H3WUQJWVZ+WwBe68oB/no9eCUgTm4hToifKnLbjqjZbIvDhrEgInDnB4YqA5oRIkOQ
	 xNcaLz25sKCBQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id
 D0A5C380CED0;
	Thu, 13 Aug 2026 02:00:19 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 01/10] batman-adv: dat: drop non-4addr backwards
 compatibility
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178658641839.2186174.13993982202522689838.git-patchwork-notify@kernel.org>
Date: Thu, 13 Aug 2026 02:00:18 +0000
References: <20260805143200.722098-2-sw@simonwunderlich.de>
In-Reply-To: <20260805143200.722098-2-sw@simonwunderlich.de>
To: Simon Wunderlich <sw@simonwunderlich.de>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 b.a.t.m.a.n@lists.open-mesh.org, sven@narfation.org, antonio@mandelbit.com
Message-ID-Hash: FHHECDQ3DAXJGXUDQ5OTXNCDOSLM2PXO
X-Message-ID-Hash: FHHECDQ3DAXJGXUDQ5OTXNCDOSLM2PXO
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/FHHECDQ3DAXJGXUDQ5OTXNCDOSLM2PXO/>
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

On Wed,  5 Aug 2026 16:27:15 +0200 you wrote:
> From: Sven Eckelmann <sven@narfation.org>
> 
> The 4addr unicast packet support is mandatory in compat version 15. No
> older compat version is supported and the kernel doesn't need to keep code
> to talk to nodes which cannot be in the same mesh.
> 
> Acked-by: Antonio Quartulli <antonio@mandelbit.com>
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
> 
> [...]

Here is the summary with links:
  - [net-next,01/10] batman-adv: dat: drop non-4addr backwards compatibility
    https://git.kernel.org/netdev/net-next/c/0de27651929b
  - [net-next,02/10] batman-adv: tvlv: handle negative tvlv processing return codes
    https://git.kernel.org/netdev/net-next/c/e558ee008810
  - [net-next,03/10] batman-adv: add missing kernel-doc comments
    https://git.kernel.org/netdev/net-next/c/3ebcaccc8871
  - [net-next,04/10] batman-adv: fix kernel-doc for functions holding skb ownership
    https://git.kernel.org/netdev/net-next/c/104570fe64fa
  - [net-next,05/10] batman-adv: annotate functions which may reallocate the skbuff
    https://git.kernel.org/netdev/net-next/c/ed00ac0be85f
  - [net-next,06/10] batman-adv: split multiple declarations per line
    https://git.kernel.org/netdev/net-next/c/a0082bd0f851
  - [net-next,07/10] batman-adv: switch var declarations to reverse x-mas tree order
    https://git.kernel.org/netdev/net-next/c/4549e49abbce
  - [net-next,08/10] batman-adv: handle errors in batadv_init()
    https://git.kernel.org/netdev/net-next/c/085a4112165b
  - [net-next,09/10] batman-adv: correct NET_RX_* NET_XMIT_* confusion
    https://git.kernel.org/netdev/net-next/c/1c852e4a99c7
  - [net-next,10/10] batman-adv: remove negative returns for batadv_send_skb_unicast
    https://git.kernel.org/netdev/net-next/c/02aee8ebea3a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


