Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B7FD606A31C
	for <batman@archiver.kernel.org>; Thu, 12 Nov 2026 19:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nLZUkaRD
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id F01E4846C0
	for <batman@archiver.kernel.org>; Thu, 12 Nov 2026 20:10:48 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1794510648;
 b=2xYGaqu1NVZlNSfu9FNQ15kBh8E3mlJSz9SlbKeahyrbL2bD1GVjyxltXB2O82nbEN+yz
 pUab+fmw8yq74yKPWMKWCBOt8WalL+3Jn38lXwt8bWXZHyNYlpl1zQ3LBbTxOBwTYt1XXo5
 fFvMCcvsBo8Ow1U+UhQhd/PW66HmN+g=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1794510648; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=0/wRb0QkrCnpP/cVCpQ/2KgkiapnxUmfzZNvLjxejRw=;
 b=FY0gHYdyD5m2+m/S0UmDmlSJURczai/LfSAzmVkhWaL4t7kRA8JRRMAuelP552s60S59I
 RvfFA5ng0/XDy2/mFTKReriNlV4zLE6aZWy7ipoHhHmZfBOf0QhvVxIeWOWlJE9ZPRO8uJG
 WFOM8/J3UYb4En5bcEO+BaXP/EfL6Hc=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=kernel.org;
 arc=pass;
 dmarc=pass header.from=kernel.org policy.dmarc=quarantine
Authentication-Results: open-mesh.org; dkim=pass header.d=kernel.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=kernel.org policy.dmarc=quarantine
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 08A9C80B45
	for <b.a.t.m.a.n@lists.open-mesh.org>; Thu, 12 Nov 2026 20:10:13 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1794510624;
	b=qGwT0SKWEfUf6gpaJSSSDc6apCw2tUzDopABpjTenXZePdlEFMy/4+1SkWUMwXGKNuuaaH
	AMn+SB0OSIgO1Gx6CbHwhwKD908pMUm6p66UZlBcJwt9+mgKjoHjMTe3whXLKL8IISCOoF
	tgT1GJ0VxKCoshRdL+Pur+z/XowCVx4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1794510624;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=0/wRb0QkrCnpP/cVCpQ/2KgkiapnxUmfzZNvLjxejRw=;
	b=P3fdSMatPjerqecX4fdCqt1ZpL78sNIQi2TKotUYuSWqWK120MlXLDxdSXgurh/egH2QHy
	uq6+WUgnB/Q6HI9GL45+8xi02aFgx9Po9J0cpAfcyseX9vCjqkAopsbzm+r9TYQ9/i1F7o
	3yn8uCY+8eJBYi8xaWvZhZ/63w4F5j8=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=nLZUkaRD;
	spf=pass (diktynna.open-mesh.org: domain of
 patchwork-bot+netdevbpf@kernel.org designates 172.105.4.254 as permitted
 sender) smtp.mailfrom=patchwork-bot+netdevbpf@kernel.org;
	dmarc=pass (policy=quarantine) header.from=kernel.org
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 956E362418;
	Thu, 12 Nov 2026 19:10:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 450E71F000C5;
	Thu, 12 Nov 2026 19:10:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794510612;
	bh=0/wRb0QkrCnpP/cVCpQ/2KgkiapnxUmfzZNvLjxejRw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=nLZUkaRDwTxJciXRHkKbmJlzw786NyZwzt/uMpqEbfLy3/MIWbxDW89DcsOqJTOwz
	 MZjbvCKnyCyUu3dk8dgVl8bY4LrNQD5WDf+Fr+kmhKdbwgo2cmx2ixab0hHMfMF+DR
	 AgI3pifcOjOxATigKSiiLswLrn472KnRjSRCDLSQvCaxeWGk0I5WGkZRABSC4x7aDb
	 zAvBZ03xMjjhMOGg+mY93JEZDivQTPGv5TqWkRY3dSOAvh6zWCACCktMQ1NPuKbq9x
	 zAivNPghICDPRfWcnXVDBhyah+JvbDZripUcwLE2fqpx46NOxVdNDEyBEpW4+7OfK6
	 yTsvZ6dENapuA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id
 3A36C3924A5F;
	Thu, 12 Nov 2026 19:10:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 01/15] batman-adv: mcast: explicitly initialize
 mcast.num_want_all_rtr{4,6)
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179451061077.599290.18211748615272269475.git-patchwork-notify@kernel.org>
Date: Thu, 12 Nov 2026 19:10:10 +0000
References: <20261111102729.2096241-2-sw@simonwunderlich.de>
In-Reply-To: <20261111102729.2096241-2-sw@simonwunderlich.de>
To: Simon Wunderlich <sw@simonwunderlich.de>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 b.a.t.m.a.n@lists.open-mesh.org, sven@narfation.org, sashiko-bot@kernel.org,
 linus.luessing@c0d3.blue
Message-ID-Hash: VCATGJSNXUEFIIGATDSTJHNCDZRYZJ4B
X-Message-ID-Hash: VCATGJSNXUEFIIGATDSTJHNCDZRYZJ4B
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/VCATGJSNXUEFIIGATDSTJHNCDZRYZJ4B/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_NONE
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hello:

This series was applied to netdev/net-next.git (main)
by Sven Eckelmann <sven@narfation.org>:

On Wed, 11 Nov 2026 11:27:15 +0100 you wrote:
> From: Sven Eckelmann <sven@narfation.org>
> 
> All mcast.num_want_all_* are initialized in batadv_mesh_init_late() - with
> the exception of mcast.num_want_all_rtr4 + mcast.num_want_all_rtr6. At the
> moment, it works because atomic_set just initializes it to 0 and the netdev
> private data is already set to 0 before being passed to .ndo_init.
> 
> [...]

Here is the summary with links:
  - [net-next,01/15] batman-adv: mcast: explicitly initialize mcast.num_want_all_rtr{4,6)
    https://git.kernel.org/netdev/net-next/c/9efd82f6805d
  - [net-next,02/15] batman-adv: mcast: explicitly initialize mcast.want_all_rtr{4,6}_list
    https://git.kernel.org/netdev/net-next/c/ec14a473ec1c
  - [net-next,03/15] batman-adv: uapi: add note/clarification on access of reserved bytes/bits
    https://git.kernel.org/netdev/net-next/c/50d3cce980fb
  - [net-next,04/15] batman-adv: avoid torn u64 counter reads on 32-bit systems
    https://git.kernel.org/netdev/net-next/c/82c663800f4c
  - [net-next,05/15] batman-adv: bat_v: initialize last_unicast_tx on neighbor creation
    https://git.kernel.org/netdev/net-next/c/b844a1f97194
  - [net-next,06/15] batman-adv: dat: annotate last_update with READ/WRITE_ONCE
    https://git.kernel.org/netdev/net-next/c/0ca317f5194d
  - [net-next,07/15] batman-adv: bla: avoid negative reported BATADV_ATTR_LAST_SEEN_MSECS
    https://git.kernel.org/netdev/net-next/c/53a21998ad66
  - [net-next,08/15] batman-adv: tt: annotate last_seen with READ/WRITE_ONCE
    https://git.kernel.org/netdev/net-next/c/a063d1749de1
  - [net-next,09/15] batman-adv: annotate originator last_seen with READ/WRITE_ONCE
    https://git.kernel.org/netdev/net-next/c/d4b4b01b5f37
  - [net-next,10/15] batman-adv: annotate neigh_node last_seen with READ/WRITE_ONCE
    https://git.kernel.org/netdev/net-next/c/45d1474790e4
  - [net-next,11/15] batman-adv: annotate hardif_neigh_node last_seen with READ/WRITE_ONCE
    https://git.kernel.org/netdev/net-next/c/150e85d113fd
  - [net-next,12/15] batman-adv: use matching return types for bool and void functions
    https://git.kernel.org/netdev/net-next/c/2daee4a0d81e
  - [net-next,13/15] batman-adv: mark read-only MAC address parameters as const
    https://git.kernel.org/netdev/net-next/c/c58558f8998f
  - [net-next,14/15] batman-adv: use bool for boolean flags
    https://git.kernel.org/netdev/net-next/c/0f97847fdd1c
  - [net-next,15/15] batman-adv: mcast: document the value stored in is_routable
    https://git.kernel.org/netdev/net-next/c/d5c0415dfb58

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


