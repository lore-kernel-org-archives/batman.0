Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7B3DCD343F
	for <batman-adv@archiver.kernel.org>; Tue, 19 May 2026 00:00:46 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id EA52F807F3
	for <batman-adv@archiver.kernel.org>; Tue, 19 May 2026 02:00:44 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1779148844;
 b=yTlpfUzslLGF9W75dE21OCAh4EW5OF2d5s0S4LpnWq6QXgVdjssKtVaNiLnHb24dPyg+4
 JQ7Zil1iLBSaCn1Rv5yHYWKfmpJ0ySKYz6E+y8F1fkHXI5NxssSn4IaRQ8K7beqw/TdLerS
 eqCKolGmVer8lvilDSjEMElpypgab2g=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1779148844; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=clTinzgnip9SjZBS71xsoZZXjzKJ76MbF10dH3TWgAY=;
 b=CzOh1UU5Otwj1qCM0Z//t3C1aoyGnowNHxTSr7AmJ9qr2Vn9yYTHDW0ZJsrdsgibP9ZR2
 U3kk1I1ifScUXD9dMkZQSV8hFYTiZ05yw+AIwzrbf/q3CPvbrQw9akQmiZe9w0T2PZn5cdc
 ocuR7x2jFfBlzhybJlBP0pllge6GII4=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=kernel.org;
 arc=pass;
 dmarc=pass header.from=kernel.org policy.dmarc=quarantine
Authentication-Results: open-mesh.org; dkim=pass header.d=kernel.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=kernel.org policy.dmarc=quarantine
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 147D1802BE
	for <b.a.t.m.a.n@lists.open-mesh.org>; Tue, 19 May 2026 02:00:13 +0200 (CEST)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1779148813;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=clTinzgnip9SjZBS71xsoZZXjzKJ76MbF10dH3TWgAY=;
	b=4GHitd+dGHU7GLJ13xOUIvxRzHvVYTtlWaItjzhShIRaymAsXr1skrBzAauqQhQyKOC2Fy
	pPjzr94QnGPMPgQEYa4fdv+qBZlOhhTugHEsTUHFf/ERXT+WmV5bf5ntDKHj6MwLtJsXKF
	PxKxv/Io3ut+zj9Yz2B3+IsH7aJPhKw=
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1779148813;
	b=iUxB3NUYZhNcg2iXY+aDFV0H9E9JAerznQLn749SVRRPLXLC4N38kPiHIXJ2TViqhThnKT
	ecG/ApkhyLApO1njVOoDr5Oj9fk1SXGO6vczAd+MDQ1xkbAmurJW3I3mKTW7CFuk9fgpGD
	rppKKP+0KNjFdxUIMafOTmYnsXpV7VY=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=kernel.org header.s=k20201202 header.b=vCktNkqB;
	spf=pass (diktynna.open-mesh.org: domain of
 patchwork-bot+netdevbpf@kernel.org designates 172.105.4.254 as permitted
 sender) smtp.mailfrom=patchwork-bot+netdevbpf@kernel.org;
	dmarc=pass (policy=quarantine) header.from=kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 977CE600CB;
	Tue, 19 May 2026 00:00:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44772C2BCB7;
	Tue, 19 May 2026 00:00:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779148811;
	bh=kuTqi/4P3P1Pltknu+oTj37VkQ8fT36kuly6Uv6oqms=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=vCktNkqBSfqF6Vy/AXyocNpgtv4NktC/pTSwmggCo0ErtHh1o5HCdWwT7NQzkKRar
	 lGtnvpX4i1qb5hMAqrSjwBb1z1OibIrgGxVoYLhQ+CO7UmrbcH1m+sDrY5iOHef5se
	 vQL38z8XnCRRTSnVI7yR/Kf86scP9sPKbqph0uBlWq1b0leqqxrk4ytsqZeqUbVY1d
	 KNnDgj5bcXcwI1Kj9MNqSy/oNyW1G9QQ8gmT+gtieMDkKepd0uqnj62FYFmoWV5KGd
	 5/MAlW3NELVtzP/bhe6MXpL5N8I4DfSWTccN31pQSrrbj1sizv0GWdkMbx84tw5vZ2
	 r9H6mih09flwQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id
 D0BC83930CBF;
	Tue, 19 May 2026 00:00:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 01/14] batman-adv: fix tp_meter counter underflow
 during
 shutdown
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177914882239.2018613.11265100133321410962.git-patchwork-notify@kernel.org>
Date: Tue, 19 May 2026 00:00:22 +0000
References: <20260515095540.325586-2-sw@simonwunderlich.de>
In-Reply-To: <20260515095540.325586-2-sw@simonwunderlich.de>
To: Simon Wunderlich <sw@simonwunderlich.de>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 b.a.t.m.a.n@lists.open-mesh.org, rakukuip@gmail.com, stable@kernel.org,
 yuantan098@gmail.com, yifanwucs@gmail.com, tomapufckgml@gmail.com,
 bird@lzu.edu.cn, n05ec@lzu.edu.cn, sven@narfation.org
Message-ID-Hash: TVPID5LVFGVY5BTUJINXNNMH376S7EQM
X-Message-ID-Hash: TVPID5LVFGVY5BTUJINXNNMH376S7EQM
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/TVPID5LVFGVY5BTUJINXNNMH376S7EQM/>
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

On Fri, 15 May 2026 11:55:26 +0200 you wrote:
> From: Luxiao Xu <rakukuip@gmail.com>
> 
> batadv_tp_sender_shutdown() unconditionally decrements the "sending"
> atomic counter. If multiple paths (e.g. timeout, user cancel, and
> normal finish) call this function, the counter can underflow to -1.
> 
> Since the sender logic treats any non-zero value as "still sending",
> a negative value causes the sender kthread to loop indefinitely.
> This leads to a use-after-free when the interface is removed while
> the zombie thread is still active.
> 
> [...]

Here is the summary with links:
  - [net,01/14] batman-adv: fix tp_meter counter underflow during shutdown
    https://git.kernel.org/netdev/net/c/94f3b133168d
  - [net,02/14] batman-adv: tp_meter: fix tp_vars reference leak in receiver shutdown
    https://git.kernel.org/netdev/net/c/77098e4bea37
  - [net,03/14] batman-adv: tt: reject oversized local TVLV buffers
    https://git.kernel.org/netdev/net/c/1e9fab756f83
  - [net,04/14] batman-adv: tt: fix negative tt_buff_len
    https://git.kernel.org/netdev/net/c/b64963a2ceeb
  - [net,05/14] batman-adv: tt: fix negative last_changeset_len
    https://git.kernel.org/netdev/net/c/fc92cdfcb295
  - [net,06/14] batman-adv: tt: fix TOCTOU race for reported vlans
    https://git.kernel.org/netdev/net/c/94d27005016b
  - [net,07/14] batman-adv: tt: avoid empty VLAN responses
    https://git.kernel.org/netdev/net/c/fa1bd704940b
  - [net,08/14] batman-adv: tt: prevent TVLV entry number overflow
    https://git.kernel.org/netdev/net/c/99d9958fa10f
  - [net,09/14] batman-adv: fix fragment reassembly length accounting
    https://git.kernel.org/netdev/net/c/9cd3f16c320b
  - [net,10/14] batman-adv: clear current gateway during teardown
    https://git.kernel.org/netdev/net/c/a340a51ed801
  - [net,11/14] batman-adv: dat: handle forward allocation error
    https://git.kernel.org/netdev/net/c/2d8826a2d365
  - [net,12/14] batman-adv: tp_meter: avoid use of uninit sender vars
    https://git.kernel.org/netdev/net/c/6c65cf23d4c6
  - [net,13/14] batman-adv: frag: disallow unicast fragment in fragment
    https://git.kernel.org/netdev/net/c/bc62216dc8e2
  - [net,14/14] batman-adv: tp_meter: directly shut down timer on cleanup
    https://git.kernel.org/netdev/net/c/d5487249a81e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


