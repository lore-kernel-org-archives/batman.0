Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36F4DEE49AB
	for <batman-adv@archiver.kernel.org>; Wed, 23 Aug 2023 06:26:38 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 6E6928332C
	for <batman-adv@archiver.kernel.org>; Wed, 23 Aug 2023 08:26:35 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1692771995;
 b=cLyyogRuL1U60xSaX8MY7B2rXHuYQWiulagtW7zbD+yWDwKjjj6Fqt1jCWv9bV/ydoA2n
 b4MFykugRoh41MPa8shp6OmjCjgzGFi+lX5jtnQ+3npBwB3TuzlvlkQH7GI5ePWq01H+iyD
 5x9vGe3MiZf/dWKtfTcXNmmecrOwIcQ=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1692771995; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=TMbKJwO+dc00bTMpCiqOyqvM6FpMffgS6jke6PHJEZg=;
 b=rsJDhO/lJ6Wst/xTCLrY99mZcfsn6t10sbQ0n71etPieB92vc5hVfTN4QswCu42CZ9T1m
 rAs1cgR5YeAo7aiEnqqwzksVKqUSVMJUI94feh4ZIt/BAwlCpswihrWfixdAc0qJG2jtpJn
 GobFU5JFgOiP8JHNtV/iHqKwHHBIpS8=
ARC-Authentication-Results: i=2; open-mesh.org; dkim=pass header.d=kernel.org;
  arc=pass;
  dmarc=pass (Used From Domain Record) header.from=kernel.org
 policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=kernel.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=kernel.org policy.dmarc=none
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id ADFDA802ED
	for <b.a.t.m.a.n@lists.open-mesh.org>; Wed, 23 Aug 2023 02:30:27 +0200 (CEST)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1692750627;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=TMbKJwO+dc00bTMpCiqOyqvM6FpMffgS6jke6PHJEZg=;
	b=ohrVqxYhqBjxHDnXNFqAA1cCA56sf/eyTsBGJxpAuNNvT/X1Ih8zAKuHFPSFucbdsxsl7T
	Jtzg7GQ3clyY0yi1LgstHfPYLlEEniXPZXCgkTdnC5G52d1Lm9nqwvKk+2Kg6V9vmgDbS+
	y0cSy6N9/XBl317VCP++5K+9Q3lMGJc=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=kernel.org header.s=k20201202 header.b=UFktCEzc;
	spf=pass (diktynna.open-mesh.org: domain of
 patchwork-bot+netdevbpf@kernel.org designates 2604:1380:4641:c500::1 as
 permitted sender) smtp.mailfrom=patchwork-bot+netdevbpf@kernel.org;
	dmarc=pass (policy=none) header.from=kernel.org
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1692750627; a=rsa-sha256;
	cv=none;
	b=FAU9q/eoHfhkbZrkgl8xssSwgQI2v8A4LtraywZ+PiLdD9863OHl7ImAQs6w0PVU+pdPYG
	ergPVoCwcDIrxVGCibL5Gujo+Q7ZFCwq9RjKp/JLGUkROB8FrhBmw9F8AVairxeF4ECB5F
	Xe9MQEMhrPz0L6PGevkT/kl+l8Ep1nA=
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 3DE9563600;
	Wed, 23 Aug 2023 00:30:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B149CC433CB;
	Wed, 23 Aug 2023 00:30:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692750624;
	bh=CoLz3mD8z3EEnrbY+VFjJFD64qCW/Afi2VmVdewI4/Y=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=UFktCEzctW4y2wlIHFFSLqgvs8nF6H4/MQ0qiQbUQJQaBffabN1Q0a8OIZ7KGWKKo
	 RDWWy/buROKpjv0mRDtiCE4Rs9znIT46WTR3DzwjKMWKvcEjnWqu9yvjOT2fmMcGzn
	 BkchH9KiP4aQhRy2XBra5KLNT79lMLo/6g9L4swtYCCqj8sQPDcYAITtcip/Sia9C6
	 qKCwiDHNOR9/tnQFbNsBtv0M2Jk0qJ5KMCbFk0A1Yuh+NgkZX89MAbF7eRy5KhJupb
	 jnWF+F46LHMnODf2egESvoD1Ok8SDelwkRR8kM1jCNjhDZX2WDzBUNgqcoe4IGXeSO
	 sHQ1LkO2moqZQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org
 (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id
 96E97E21ED3;
	Wed, 23 Aug 2023 00:30:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] batman-adv: Hold rtnl lock during MTU update via
 netlink
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169275062461.22438.15672454677210639225.git-patchwork-notify@kernel.org>
Date: Wed, 23 Aug 2023 00:30:24 +0000
References: 
 <20230821-batadv-missing-mtu-rtnl-lock-v1-1-1c5a7bfe861e@narfation.org>
In-Reply-To: 
 <20230821-batadv-missing-mtu-rtnl-lock-v1-1-1c5a7bfe861e@narfation.org>
To: Sven Eckelmann <sven@narfation.org>
X-MailFrom: patchwork-bot+netdevbpf@kernel.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-0;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-1
Message-ID-Hash: GXV6KQ7Q3D7RA2EFTYMZXOJF7YEZQTF6
X-Message-ID-Hash: GXV6KQ7Q3D7RA2EFTYMZXOJF7YEZQTF6
X-Mailman-Approved-At: Wed, 23 Aug 2023 08:26:00 +0200
CC: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, b.a.t.m.a.n@lists.open-mesh.org, netdev@vger.kernel.org,
 stable@vger.kernel.org, syzbot+f8812454d9b3ac00d282@syzkaller.appspotmail.com
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/JPU7SKJP4762ZURNZ6RZQPMBYVGFMXGM/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 21 Aug 2023 21:48:48 +0200 you wrote:
> The automatic recalculation of the maximum allowed MTU is usually triggered
> by code sections which are already rtnl lock protected by callers outside
> of batman-adv. But when the fragmentation setting is changed via
> batman-adv's own batadv genl family, then the rtnl lock is not yet taken.
> 
> But dev_set_mtu requires that the caller holds the rtnl lock because it
> uses netdevice notifiers. And this code will then fail the check for this
> lock:
> 
> [...]

Here is the summary with links:
  - [net] batman-adv: Hold rtnl lock during MTU update via netlink
    https://git.kernel.org/netdev/net/c/987aae75fc10

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


