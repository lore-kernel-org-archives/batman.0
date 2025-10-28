Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CE1ACCF9E5
	for <batman@archiver.kernel.org>; Tue, 28 Oct 2025 01:10:45 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 3D65F8030B
	for <batman@archiver.kernel.org>; Tue, 28 Oct 2025 02:10:43 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1761613843;
 b=DFk5rtPZBP+S7rX8gIVHbvPyINyi1vQgh1CthBCJzidklx/OtkmHU/jd4/opxm+4nCae6
 0GNcF/x+eX5aEAAoxxdPWuSJx2DEs353N+Vxr7K0dtOIu24Vq/GE0OhTw1wCuOQ6rFTjqnm
 T3+pw/T9nC/G6p8ezdZnkvctqiKK6/o=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1761613843; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=hWUSUHKODuEa3m7PyhIDtX6dw0NzcqY2EGOlmvK+eRA=;
 b=kvBW03G6vy9oxRzzROAZp0Xm1S5BjuWSO3dXYozURUWOuqnXJ2zV3lLLUk6k6ATnMQs7U
 cpls39GRGDGCZP9XAxZ93IOSiZl+fe4z6QcHGI0YcykXiVsfterLW/J9a75N+QIYJhImkQp
 4Oc8fBKgTDRGwGCum/7Rdd8LtHHgfAE=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=kernel.org;
 arc=pass;
 dmarc=pass header.from=kernel.org policy.dmarc=quarantine
Authentication-Results: open-mesh.org; dkim=pass header.d=kernel.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=kernel.org policy.dmarc=quarantine
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id EE68083AB3
	for <b.a.t.m.a.n@lists.open-mesh.org>; Tue, 28 Oct 2025 02:10:29 +0100 (CET)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1761613840;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=hWUSUHKODuEa3m7PyhIDtX6dw0NzcqY2EGOlmvK+eRA=;
	b=b6ssJLUl6CGChClQv0zPYTZLy0z2mzj+PF0AzuISrH+5GmRMLtG+DvXMCFvFnuKs589Bez
	jWKcuiuNSuMR46ttYy0lr1STZiSC8TTNF7zasJyPXAgQwJTnlqVNna+vtD1HAhVfrbxaGq
	2NuPKUBqi4wWNbyDuB5X8MkCU617H+Q=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=kernel.org header.s=k20201202 header.b=YnPPjTsC;
	spf=pass (diktynna.open-mesh.org: domain of
 patchwork-bot+netdevbpf@kernel.org designates 2600:3c0a:e001:78e:0:1991:8:25
 as permitted sender) smtp.mailfrom=patchwork-bot+netdevbpf@kernel.org;
	dmarc=pass (policy=quarantine) header.from=kernel.org
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1761613840; a=rsa-sha256;
	cv=none;
	b=dMQ3okl2iuQIHdUKEAZoreiTKRFF7uhhhuVK3U0fykX34E+LpdJ0GWvcfJY/Y6R0NK8pWp
	OUkthV1bL7gzCktemmkMmR1LIiuW6ZLDzKd5FUD2NGZ/iyKfdr8tmN7Ssu7NLcg1qLzP/3
	HhccVJPC+qo18AQO4srK1ShSwcQquVE=
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 1CEBD4192F;
	Tue, 28 Oct 2025 01:10:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB6BEC4CEF1;
	Tue, 28 Oct 2025 01:10:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761613828;
	bh=wVaT28yBfsup28vEdLuACMHTePkpOekM+7EufB5qAhw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=YnPPjTsC8LYWRKb5n+0BIhpy5Turp0Eah6yM2UlDMH5nWLdcpHme2kZo5iigbfHcT
	 WjmgU1lGEwltGeCQJt2nDV/xqy04yD7ytCy18grYHw7hEgoXJ0k3AuuPGIe7AHWvOi
	 WiHqaFlgCXWXvzmElH2G8defmcsUes9b5tjjC+TqcWfdGVk3LRVOD7QpI3SN/vbNdY
	 +kHmdGW6aTT+vwcCtPhIlU9bxv9uqZTL29gCa+Cnm3d8vZ5kKcdaFnXAJJMCeGaPBa
	 JgiLfwpg5zIi7ibuL3aEnM0LiauXPPhjWkViYvNoGS5AQlzGoH/sBxZc3Qct36h8AI
	 LBmAzF36QdQGw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id
 33DEA39D60B9;
	Tue, 28 Oct 2025 01:10:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 1/1] batman-adv: Release references to inactive
 interfaces
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176161380600.1648894.13441398313655370264.git-patchwork-notify@kernel.org>
Date: Tue, 28 Oct 2025 01:10:06 +0000
References: <20251024091150.231141-2-sw@simonwunderlich.de>
In-Reply-To: <20251024091150.231141-2-sw@simonwunderlich.de>
To: Simon Wunderlich <sw@simonwunderlich.de>
Cc: davem@davemloft.net, kuba@kernel.org, netdev@vger.kernel.org,
 b.a.t.m.a.n@lists.open-mesh.org, sven@narfation.org, stable@vger.kernel.org,
 syzbot+881d65229ca4f9ae8c84@syzkaller.appspotmail.com,
 penguin-kernel@i-love.sakura.ne.jp
Message-ID-Hash: CMENGQTGSQZYOTUGQMGYVZL54EVHW6XL
X-Message-ID-Hash: CMENGQTGSQZYOTUGQMGYVZL54EVHW6XL
X-MailFrom: patchwork-bot+netdevbpf@kernel.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-b.a.t.m.a.n.lists.open-mesh.org-0;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-1;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-2; emergency; member-moderation
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/CMENGQTGSQZYOTUGQMGYVZL54EVHW6XL/>
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

On Fri, 24 Oct 2025 11:11:50 +0200 you wrote:
> From: Sven Eckelmann <sven@narfation.org>
> 
> Trying to dump the originators or the neighbors via netlink for a meshif
> with an inactive primary interface is not allowed. The dump functions were
> checking this correctly but they didn't handle non-existing primary
> interfaces and existing _inactive_ interfaces differently.
> 
> [...]

Here is the summary with links:
  - [net,1/1] batman-adv: Release references to inactive interfaces
    https://git.kernel.org/netdev/net/c/f12b69d8f228

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


