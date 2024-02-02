Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F83DC47DB3
	for <batman@archiver.kernel.org>; Fri,  2 Feb 2024 14:46:33 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 714DC83E52
	for <batman@archiver.kernel.org>; Fri,  2 Feb 2024 15:46:31 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1706885191;
 b=Oyq+uajiRVjF9cS+zYZSmupnbeWCebjS6jEf8GeLUC/OfFvoMAFNisE5Pab6k/dFxz8+E
 k5SKuYDTtnMsuiljsQT3SVILKd1uGqC9YxvZCpHTpROOaWldqOrUN03/vIzk5GKL/3ve9qO
 kxp/2NDJ7xGLwLC7xsMPVTl2ntA+OCk=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1706885191; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=Jo9uarzUR9L6ANnzEiYKe+dBRte4zg2hbxt5z0QjL4E=;
 b=1hPWXCs6Lsz4lLvrgLjfcw8Te7kAgfAEAFO6OsxYNuNFiGofb5x6V6jNFfviex2qphMQw
 31AlLt2oa3NieV+cLVgaEo9v0cyBCvr+rLtCX6PzipfZx5Fb3MkZYIP6pfs56TPDWZ2yVlC
 GfgvwetNnSLoNuAe6ld+E5zAmDBbmEE=
ARC-Authentication-Results: i=2; open-mesh.org; dkim=pass header.d=kernel.org;
  arc=pass;
  dmarc=pass (Used From Domain Record) header.from=kernel.org
 policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=kernel.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=kernel.org policy.dmarc=none
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 5D42F80183
	for <b.a.t.m.a.n@lists.open-mesh.org>; Fri,  2 Feb 2024 13:50:32 +0100 (CET)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1706878232;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=Jo9uarzUR9L6ANnzEiYKe+dBRte4zg2hbxt5z0QjL4E=;
	b=Th0sOsSz+vGnZwvq38AWItJ0I/dpgwHphNBV6T4SXxOWKZYT0d/kcRHaKh5vOMNlKLyjm+
	Uc6wHshcLub9bPO7LA0KPRefXYaw6HXkVRO2ANP4HYfUKUcHM+XcFpL42JmAUyhFC5p/mI
	rHu4wxjJ2PVF1HFZjJhAQBiwXssH3/k=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=kernel.org header.s=k20201202 header.b=b9qM9A9B;
	spf=pass (diktynna.open-mesh.org: domain of
 patchwork-bot+netdevbpf@kernel.org designates 139.178.84.217 as permitted
 sender) smtp.mailfrom=patchwork-bot+netdevbpf@kernel.org;
	dmarc=pass (policy=none) header.from=kernel.org
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1706878232; a=rsa-sha256;
	cv=none;
	b=G8tDpkraXgyDZdeBwy8+TinvaVHZdtCkTaImZr8OXZnBDwwa53mS/NevkMF98LZQXeo5Bk
	cnudJg3p5kbaRLxWBypdzhJ4hlZ8rRFY/l8bWOrz6Ww30Kw3lPU5QRG53d8IehJEKdCr/p
	3Xk90lNSocaqhFMDwwW3s2x0VNKI6zo=
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id E12BE62173;
	Fri,  2 Feb 2024 12:50:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8F2DAC43390;
	Fri,  2 Feb 2024 12:50:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706878230;
	bh=u7RiM0Pypl3EzOdBZ9FDy9MqeXVePrrJicNCJaQwZQk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=b9qM9A9B2633n+z/MewQtlUyxEvEOFb8gGRGCNYGPRmrrO2vK2WJJD4ZaTmjFp3kD
	 bbfgeta/3menT2K0HkH8/IX+jAykOeMWzDqaJnh1w16IjIBK2Dfmqr01n7CWHfD1p/
	 QSqhgtm0pyS4AnFDCOaQSD+ruykx9U+7K9wewRoUzvnBKGUCDqugqibpCR7lxfG53V
	 kwc9GzklH5gRdHpYlMMdI+Ig3w2vduO62XsNechgrPhd0UNp4LHTfspdviAux5Fl7N
	 5vnNvssdXAHyEEYCegVoSf02IHLHwnOszy5c0PeLR10H4ThRVE0OI+oaqC95mHNZQM
	 yk+hUeGem70xg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org
 (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id
 7AADEC04E27;
	Fri,  2 Feb 2024 12:50:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 1/4] batman-adv: Start new development cycle
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170687823049.13015.12274931129811487024.git-patchwork-notify@kernel.org>
Date: Fri, 02 Feb 2024 12:50:30 +0000
References: <20240201110756.29728-2-sw@simonwunderlich.de>
In-Reply-To: <20240201110756.29728-2-sw@simonwunderlich.de>
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
Message-ID-Hash: HRMWU2KLKFU2NNRDACEDQY2RXRMR2JZW
X-Message-ID-Hash: HRMWU2KLKFU2NNRDACEDQY2RXRMR2JZW
X-Mailman-Approved-At: Fri, 02 Feb 2024 15:46:24 +0100
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/GD6V2DAB7MCLNMTQXEKHNQT4A5SJDIYW/>
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

On Thu,  1 Feb 2024 12:07:53 +0100 you wrote:
> This version will contain all the (major or even only minor) changes for
> Linux 6.9.
> 
> The version number isn't a semantic version number with major and minor
> information. It is just encoding the year of the expected publishing as
> Linux -rc1 and the number of published versions this year (starting at 0).
> 
> [...]

Here is the summary with links:
  - [1/4] batman-adv: Start new development cycle
    https://git.kernel.org/netdev/net-next/c/df3fc228dead
  - [2/4] batman-adv: Return directly after a failed batadv_dat_select_candidates() in batadv_dat_forward_data()
    https://git.kernel.org/netdev/net-next/c/ffc15626c861
  - [3/4] batman-adv: Improve exception handling in batadv_throw_uevent()
    https://git.kernel.org/netdev/net-next/c/5593e9abf1cf
  - [4/4] batman-adv: Drop usage of export.h
    https://git.kernel.org/netdev/net-next/c/db60ad8b21ce

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


