Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6472CD37B9
	for <batman@archiver.kernel.org>; Sun, 10 May 2026 17:11:38 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 3D16685B95
	for <batman@archiver.kernel.org>; Sun, 10 May 2026 19:11:37 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1778433097;
 b=0cUmv4Xy+9zogIoX2FNLWH2YmjR+RyqaKO4GLKTB4vUn75qtHRZmenDe4yCgAIrPu3IZc
 5bda6Uv04v5IED96qB5CFDuCX/8RzimyEqu+RTjjeslGNuPASNe9WPMaV1GsS3CgyWOVhZ9
 pOSrf+1mLKtsTq8g+/ysdIA8oY85j3s=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1778433097; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=JSRq3xHVR0hS8REhWSyvZPVBpMxjZC1biD34OLr9Ipk=;
 b=vTTz+sSXYbS8emSXQ3x4izVYMDmqQcUTI0Hp/iU6U4+JhTj5q+2XiU/DzDPG6bjCtHq3M
 p7dgmoNi4o5ZJi+Bff/5kuB+8vDBTnuIwYQ6jFt2mx7woUC7PHlW5MZwCgwSMeGyltATIOI
 QxR5a1AzIN8mSQZ+LqiBuufhuFTUx68=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=kernel.org;
 arc=pass;
 dmarc=pass header.from=kernel.org policy.dmarc=quarantine
Authentication-Results: open-mesh.org; dkim=pass header.d=kernel.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=kernel.org policy.dmarc=quarantine
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 525FA854D9
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sun, 10 May 2026 19:11:11 +0200 (CEST)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1778433071;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=JSRq3xHVR0hS8REhWSyvZPVBpMxjZC1biD34OLr9Ipk=;
	b=yz75Le9efxwGTYthizLjJxoprnTd6pnHhoI0Erth4y5JZDOazig1CC/qsR/g8SaRbaWuz4
	hp7SHDHnjbXHFzbOCV3aQK4lRSQ1IeokCSMRdHKEdQ22amRVo8EIte+rD+JftKtTnLoFpN
	w/RkKjgHYFEpta+8cAAbik802gO//HE=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=kernel.org header.s=k20201202 header.b=PgozvB4x;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (diktynna.open-mesh.org: domain of
 patchwork-bot+netdevbpf@kernel.org designates 2600:3c0a:e001:78e:0:1991:8:25
 as permitted sender) smtp.mailfrom=patchwork-bot+netdevbpf@kernel.org
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1778433071;
	b=wd0bNBTDlBZHErlYk5dPyLwN4Vc1jYrzM19er86kcOon3vHZXup0rc/K1+1lYllC4w+6U5
	spvBb3QItO+nrnUMq3NYWHZhDOtYgy3wAIBxp/1LKG9KVy4647x4IlyiKJDnxeebvXFliM
	HhqkwuIOApo0s2C04bB2h9xzTKRvm6s=
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 913DD41B3F;
	Sun, 10 May 2026 17:11:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E811C2BCB8;
	Sun, 10 May 2026 17:11:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778433069;
	bh=uWkCMdpb0fYzHgP/nseR1GXrOlMzTE9gaiu7Q4LlA5M=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=PgozvB4xMsa5xQ2J2CmGLTA7DB3MlAmS4wKfwEqbECDp2dDmW1BybGKL5KQs7OlqW
	 lWUQuX0jzq2CsG3PWLaCI0LvisMaadxc7D2kNKLQmQgfzB3Qz9AhQMxg7LY6QzzWHv
	 bCTv4TjMurOETsuy2HAXofb3CwfUvwgLmUPwYA0LWqcR7M6lrVU4Li7D68/plhu/bJ
	 1JDp7Fp2iT7PGSD8ypt6o1UgfFp3WVHWrEQWZ+SQStByri+hXkFUMddBq3AAwbddud
	 yNkWIgGRaW7Qvb4qzvDHAWixSAPFIy0ADjZaaZ4ixo7pGxeLy5sJjbhUAKLDFFvK+9
	 j9NinvjLYZ4qA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id
 02CFC393001F;
	Sun, 10 May 2026 17:10:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 1/8] batman-adv: fix integer overflow on buff_pos
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177843301655.1434286.16917643691644742198.git-patchwork-notify@kernel.org>
Date: Sun, 10 May 2026 17:10:16 +0000
References: <20260508154314.12817-2-sw@simonwunderlich.de>
In-Reply-To: <20260508154314.12817-2-sw@simonwunderlich.de>
To: Simon Wunderlich <sw@simonwunderlich.de>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 b.a.t.m.a.n@lists.open-mesh.org, lbourennani@fuzzinglabs.com,
 stable@vger.kernel.org, apinson@fuzzinglabs.com, sven@narfation.org
Message-ID-Hash: 2D675AYS3UBO4NB6O6NEPVZQQ4HFYJWK
X-Message-ID-Hash: 2D675AYS3UBO4NB6O6NEPVZQQ4HFYJWK
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/2D675AYS3UBO4NB6O6NEPVZQQ4HFYJWK/>
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

On Fri,  8 May 2026 17:43:07 +0200 you wrote:
> From: Lyes Bourennani <lbourennani@fuzzinglabs.com>
> 
> Fixing an integer overflow present in batadv_iv_ogm_send_to_if. The size
> check is done using the int type in batadv_iv_ogm_aggr_packet whereas the
> buff_pos variable uses the s16 type. This could lead to an out-of-bound
> read.
> 
> [...]

Here is the summary with links:
  - [net,1/8] batman-adv: fix integer overflow on buff_pos
    https://git.kernel.org/netdev/net/c/0799e5943611
  - [net,2/8] batman-adv: reject new tp_meter sessions during teardown
    https://git.kernel.org/netdev/net/c/324354359242
  - [net,3/8] batman-adv: stop tp_meter sessions during mesh teardown
    https://git.kernel.org/netdev/net/c/3d3cf6a7314a
  - [net,4/8] batman-adv: stop caching unowned originator pointers in BAT IV
    https://git.kernel.org/netdev/net/c/f03e85835329
  - [net,5/8] batman-adv: tp_meter: fix tp_num leak on kmalloc failure
    https://git.kernel.org/netdev/net/c/ce425dd05d0f
  - [net,6/8] batman-adv: bla: prevent use-after-free when deleting claims
    https://git.kernel.org/netdev/net/c/4ae1709a3140
  - [net,7/8] batman-adv: bla: only purge non-released claims
    https://git.kernel.org/netdev/net/c/cf6b60401159
  - [net,8/8] batman-adv: bla: put backbone reference on failed claim hash insert
    https://git.kernel.org/netdev/net/c/ba9d20ee9076

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


