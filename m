Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A930606A320
	for <batman@archiver.kernel.org>; Fri, 30 Oct 2026 22:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=P+/36Xbm
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id D8F758479B
	for <batman@archiver.kernel.org>; Fri, 30 Oct 2026 23:00:39 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1793397639;
 b=IkNkhTEeavfh7387o3a9dYVH/gOQZmjjND7tHrqNgtrVDLR4kIBzH+bOjeGdvMttdBthR
 PuRA7IdV9qg5KmjnE1HPTeDdTZDTx9xosj589D4OHoY9Zs3Ilno8Ac7CcDZulzeHn/mIafa
 5R8HooD3oG6bw+lPxS6RjOVtwjaJhFQ=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1793397639; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=U2kaPQCEoqKi8S6vGTnuzQOL+3u+NmMeqZfbb6IoDwc=;
 b=AdqtfoUt7tsP00SmM6VX8xDmTwpu84nZYwKJdFaYaDP34JvcsS4j45ELMqEuJUxloMaCW
 /foq7vdxHzLxZcx0Ci3bdQbUJpPTjoxdPGTyMH0+Hyca46sajdvljLGlbK8VxheV+kmn5Ad
 HqMNSfz9vAgTUq9GLC21excTqZ0qKq8=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=kernel.org;
 arc=pass;
 dmarc=pass header.from=kernel.org policy.dmarc=quarantine
Authentication-Results: open-mesh.org; dkim=pass header.d=kernel.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=kernel.org policy.dmarc=quarantine
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 547B08084D
	for <b.a.t.m.a.n@lists.open-mesh.org>; Fri, 30 Oct 2026 23:00:15 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1793397625;
	b=Sdg8JYAHGmwmX3Fkz/1qR3rRZk6Er+wrFsXJOeN4e/ySBrkvar+GJlhPwwQ2d2LgVEIIrM
	1Xc7e+FqPelrSNX9pXVkJP156ZJCJzngfrJxFfTDxiwQuVlwA5a4wRJPr1ts3yHcPwxsXv
	iiZOzn/R4UsDOoLYeqYe4vtAuVzFKAc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1793397625;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=U2kaPQCEoqKi8S6vGTnuzQOL+3u+NmMeqZfbb6IoDwc=;
	b=sLmLM2IYYqzBkZTQpCoiWhrOK/qRIJJ2STBQvNb4dyUjURyoB9lyTAEAf8Ki8ZqpMEELla
	rdn/W5Ko32pj07V9GSbYKdoKawR2Wv0ycWJ6KrTrLQcX7zmiVPaogkrtubxRI8rJ3A1+q9
	xrYGLkoBNhvVsgX9OtBGVs4ApjA4pPI=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b="P+/36Xbm";
	spf=pass (diktynna.open-mesh.org: domain of
 patchwork-bot+netdevbpf@kernel.org designates 172.105.4.254 as permitted
 sender) smtp.mailfrom=patchwork-bot+netdevbpf@kernel.org;
	dmarc=pass (policy=quarantine) header.from=kernel.org
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id D6BC160611;
	Fri, 30 Oct 2026 22:00:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8803A1F00A17;
	Fri, 30 Oct 2026 22:00:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793397608;
	bh=U2kaPQCEoqKi8S6vGTnuzQOL+3u+NmMeqZfbb6IoDwc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=P+/36XbmjnR6ILLz5KyJwRfviGAJtf1P/u4eq7VOj52Pz3dLHHrd9qin44eKD8NSm
	 LBDHyFUs1exy8tvZgCyzmz81ErWTeHRLH5GfbAuTP7RdHXp04XpRaT4Z52+kPhgWsT
	 laqmdS5f9z6v0u4X5AEwJMZwuE6nYtQaJOI8g1o2TOyRPigYKE0pcscZi8pgqPhuQD
	 9ohEoqQqBhZR+cIS55c9Q1qCJwO7a+LGkHpWKEBSGGT+oTSyOo31PYK7t/FqhWS7lT
	 iOWaA/pAqSsrK1qOIw71l+x6OMsF5NO4/x673feTYx3lyw5akmgWdVSwzaPcxCN5FQ
	 jEARb/sCeScSQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id
 7D2F63800478;
	Fri, 30 Oct 2026 22:00:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 01/14] batman-adv: avoid WARN_ON for orig_ifinfo
 allocation failure
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179339760704.1793924.4372470360549262374.git-patchwork-notify@kernel.org>
Date: Fri, 30 Oct 2026 22:00:07 +0000
References: <20261030135105.2555887-2-sw@simonwunderlich.de>
In-Reply-To: <20261030135105.2555887-2-sw@simonwunderlich.de>
To: Simon Wunderlich <sw@simonwunderlich.de>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 b.a.t.m.a.n@lists.open-mesh.org, kartikey406@gmail.com,
 syzbot+a079f084653164a652d1@syzkaller.appspotmail.com, sven@narfation.org
Message-ID-Hash: USHQK4P3TVCX3SUH3JEEKV23ZNHKGM6O
X-Message-ID-Hash: USHQK4P3TVCX3SUH3JEEKV23ZNHKGM6O
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/USHQK4P3TVCX3SUH3JEEKV23ZNHKGM6O/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_NONE
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hello:

This series was applied to netdev/net.git (main)
by Sven Eckelmann <sven@narfation.org>:

On Fri, 30 Oct 2026 14:50:52 +0100 you wrote:
> From: Deepanshu Kartikey <kartikey406@gmail.com>
> 
> batadv_orig_ifinfo_new() returns NULL only when its GFP_ATOMIC
> allocation fails, which is a normal runtime condition and not a bug.
> batadv_v_ogm_forward() already handles this the same way, simply
> checking for NULL without a WARN_ON.
> 
> [...]

Here is the summary with links:
  - [net,01/14] batman-adv: avoid WARN_ON for orig_ifinfo allocation failure
    https://git.kernel.org/netdev/net/c/dfa953ba5366
  - [net,v2,02/14] batman-adv: Close OGM aggregation before transmission
    https://git.kernel.org/netdev/net/c/f91f64a91682
  - [net,03/14] batman-adv: mcast: validate tracker padding before forwarding
    https://git.kernel.org/netdev/net/c/ea01fff30f63
  - [net,04/14] batman-adv: tpmeter: fix u32 truncation of reported bytes
    https://git.kernel.org/netdev/net/c/1025b76d1328
  - [net,05/14] batman-adv: dat: initialize orig_node of unfilled candidate slots
    https://git.kernel.org/netdev/net/c/4eb19a389d74
  - [net,06/14] batman-adv: fix skb leak when hard_iface is being released
    https://git.kernel.org/netdev/net/c/522e4aece2e9
  - [net,07/14] batman-adv: stop originator purge worker before freeing TT
    https://git.kernel.org/netdev/net/c/f89eda5a9ccf
  - [net,v2,08/14] batman-adv: tt: only transmit local ROAM flag together with DEL
    https://git.kernel.org/netdev/net/c/10f24f058417
  - [net,09/14] batman-adv: tt: clear ROAM flag when re-adding a pending local client
    https://git.kernel.org/netdev/net/c/cc2186d78547
  - [net,10/14] batman-adv: tt: send ROAM_ADV on each roamed back client
    https://git.kernel.org/netdev/net/c/aff4d5d10f2d
  - [net,11/14] batman-adv: tt: ignore ROAM flag of received ADD changes
    https://git.kernel.org/netdev/net/c/c5d68abe6e7f
  - [net,v2,12/14] batman-adv: tt: only update flags for TT events
    https://git.kernel.org/netdev/net/c/ad1fd828aa39
  - [net,v2,13/14] batman-adv: tt: don't drop local events queued during TVLV update
    https://git.kernel.org/netdev/net/c/ed7a0dfdd370
  - [net,v2,14/14] batman-adv: tt: limit local table to single TVLV response size
    https://git.kernel.org/netdev/net/c/a137095419b4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


