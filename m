Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69D79EE49AA
	for <batman-adv@archiver.kernel.org>; Sat, 19 Aug 2023 08:11:51 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id B2609832CE
	for <batman-adv@archiver.kernel.org>; Sat, 19 Aug 2023 10:11:49 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1692432709;
 b=mWXbiG2djRPVfCqlGTp0P0gkkNtsUPW+g225A9npTm79+KR1LaZkY15YtlmXpvQnWjOy+
 ZL1rbjsDXl/IXnTJPVv5RO6TfytzP9DywqHlU46hd9zoQ5WTi40iH45sVQ0iWPTkkvSYjhQ
 9c5rrVPPG7TrtyrMVnRrZf4zsZUsf98=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1692432709; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=12uJQFIEZ9LYxrEmZo2lh/UBraFBmx19bS5WYpbMC7o=;
 b=XtCCiv9N//h1RgSzpVD9F822sFb9YxfU2PdOE1kmbM1jd6klBWsuljUluuTuM82LLiUJE
 EA79MxWAK6ZrYRQkS/SlUByemTbssl5nQ4ijBmCNe2785cxl3ododu9sGRy9B44ZB05rfIO
 3lUcbwslf/eFvGoaXhPFtCZ6w4nodr0=
ARC-Authentication-Results: i=2; open-mesh.org; dkim=pass header.d=kernel.org;
  arc=pass;
  dmarc=pass (Used From Domain Record) header.from=kernel.org
 policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=kernel.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=kernel.org policy.dmarc=none
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 5E27481F29
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sat, 19 Aug 2023 00:20:29 +0200 (CEST)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1692397229;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=12uJQFIEZ9LYxrEmZo2lh/UBraFBmx19bS5WYpbMC7o=;
	b=MXylrph52ptcfYKV+yT4zh+bn2Kd3baN+7BOXTpdsDDRXWlOpsIyQrsOQpa+tvu3yPKLFv
	3GVSSW2eywd0QLkzNfH6LRCIhexCpp9PVZ8g+vzQaYpeDUCCkIt5R5ebKZmUSXCXcuTveu
	3nH4wuniLRFPDwYRnwU/2DfK707m1OM=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=kernel.org header.s=k20201202 header.b=oFAtqBtC;
	spf=pass (diktynna.open-mesh.org: domain of
 patchwork-bot+netdevbpf@kernel.org designates 139.178.84.217 as permitted
 sender) smtp.mailfrom=patchwork-bot+netdevbpf@kernel.org;
	dmarc=pass (policy=none) header.from=kernel.org
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1692397229; a=rsa-sha256;
	cv=none;
	b=MzipzGCqdCKb77V/LuGX/uL9ufdnZhynzBtDDi3EICOjlMnvBBEAYG/BgzcER438/VTyes
	Pu1irlkac/ArP4OKrjh6bKfubYY354bqpWo+xgxb0mHeh6GMQ2LmhuG3tck0bZ/2xyg73A
	JaoC4+KwkQzyEDqxHw8weiAbH/9ufZI=
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 3027B61E5B;
	Fri, 18 Aug 2023 22:20:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8D4D3C433CA;
	Fri, 18 Aug 2023 22:20:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692397227;
	bh=dG/seTSjRPI+tu7gkUXoP3P0aPr0y1BQI3/OiexoifQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=oFAtqBtCBBEKUt/gg4H7KP7Teu2NJbhIFvouo50zRvKZkee0zaqOFkUqXJGX22qfs
	 Nsvu4TLckHyA5Zc91CnTLh9qJ1nY3iTAq2Dv3ubjK3dWO0aIsCXjQXOFadpCirNr4F
	 pWWFO4RoDK8kZ60sTVduahWYc443Wqh5roW2luK67d0n1eNPI4lZweE+4ReeTEosad
	 Wv9qT9Qmj5fa2lIrcshh7KdqZsHi7039rWK4gTqNxhwwQQJ7kRyVZpMsEOes4Zt1X7
	 Y/IT4fhUHSGcri+oEIYw+21pLsTnWf6xllwMXUs2CDwUP8sm/E6Ohgf08Rni10hBHV
	 5bj1384MhNtqg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org
 (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id
 79CC9E93B34;
	Fri, 18 Aug 2023 22:20:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 1/7] batman-adv: Start new development cycle
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169239722749.24641.16398477164244966628.git-patchwork-notify@kernel.org>
Date: Fri, 18 Aug 2023 22:20:27 +0000
References: <20230816164000.190884-2-sw@simonwunderlich.de>
In-Reply-To: <20230816164000.190884-2-sw@simonwunderlich.de>
To: Simon Wunderlich <sw@simonwunderlich.de>
X-MailFrom: patchwork-bot+netdevbpf@kernel.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-0;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-1
Message-ID-Hash: 3PECYPHUVRV7R573N562JLUXSV2OHAOG
X-Message-ID-Hash: 3PECYPHUVRV7R573N562JLUXSV2OHAOG
X-Mailman-Approved-At: Sat, 19 Aug 2023 10:10:32 +0200
CC: kuba@kernel.org, davem@davemloft.net, netdev@vger.kernel.org,
 b.a.t.m.a.n@lists.open-mesh.org
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/HGKKONZJY3NE34BM4QGHQLZWWZNNGW34/>
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

On Wed, 16 Aug 2023 18:39:54 +0200 you wrote:
> This version will contain all the (major or even only minor) changes for
> Linux 6.6.
> 
> The version number isn't a semantic version number with major and minor
> information. It is just encoding the year of the expected publishing as
> Linux -rc1 and the number of published versions this year (starting at 0).
> 
> [...]

Here is the summary with links:
  - [1/7] batman-adv: Start new development cycle
    https://git.kernel.org/netdev/net-next/c/2744cefe0337
  - [2/7] batman-adv: Remove unused declarations
    https://git.kernel.org/netdev/net-next/c/bbfb428a0cf6
  - [3/7] batman-adv: Avoid magic value for minimum MTU
    https://git.kernel.org/netdev/net-next/c/e4b817804579
  - [4/7] batman-adv: Check hardif MTU against runtime MTU
    https://git.kernel.org/netdev/net-next/c/112cbcb4af90
  - [5/7] batman-adv: Drop unused function batadv_gw_bandwidth_set
    https://git.kernel.org/netdev/net-next/c/950c92bbaa8f
  - [6/7] batman-adv: Keep batadv_netlink_notify_* static
    https://git.kernel.org/netdev/net-next/c/02e61f06a97e
  - [7/7] batman-adv: Drop per algo GW section class code
    https://git.kernel.org/netdev/net-next/c/6f96d46f9a1a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


