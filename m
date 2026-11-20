Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 202C8606A325
	for <batman@archiver.kernel.org>; Fri, 20 Nov 2026 02:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Fsn3MbM1
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 54ADD8427E
	for <batman@archiver.kernel.org>; Fri, 20 Nov 2026 03:10:31 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1795140631;
 b=CZl9eoRUn/Qt98AFZnLIUpL05amwEtr0yrczlzAxc21z3SIjq/hEfjVmjeyXiVVSdnZRl
 ly9gdjQcUD9lQ5do7uQTE2Srwwu6Gpc8PlLwKSAqKCled31ckt0/TkMc9Fw7xTQL439Dm/j
 9pBghYSptGHK3LuuWjPF3UT6yThgWvI=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1795140631; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=BWF/o7HxuhpeDvyIS/P6u0dIIiRMG6uCfb04buHYMAw=;
 b=Cazz4xC2s88sMToxGY/+qRT2XON2X2vecze4JTWZDaANjRyEguAukSGNNeA025sxLMo4g
 R9oSg52+KB4lXpp11jSZfccepff93NlsjXYkchXy3ACC+neBMeYVYDBUXBp/beaJyk59ntO
 4bns/dYVlMgABwrmaAR2EsEjE5zZu6I=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=kernel.org;
 arc=pass;
 dmarc=pass header.from=kernel.org policy.dmarc=quarantine
Authentication-Results: open-mesh.org; dkim=pass header.d=kernel.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=kernel.org policy.dmarc=quarantine
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 3B2B880947
	for <b.a.t.m.a.n@lists.open-mesh.org>; Fri, 20 Nov 2026 03:10:12 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1795140622;
	b=xm04e6aaEutLl6BNuwwN8B6mCRi8M/1wF/JrN4o8SbcZOSk5Z5Lb9gbGwfCBoeC126xdSU
	bGCrHWmyaJws/82hDWTIIAZfWzc5XN0Ade7WfOPDfQILH0ryOi/kLq0m4rGkQGaQLnPdzJ
	RcotRtcGVzijWZZEHqfF64tnJKFSabE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1795140622;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=BWF/o7HxuhpeDvyIS/P6u0dIIiRMG6uCfb04buHYMAw=;
	b=TTNy3G4k3o7D2v7eqs85ezwlLlYfF5J0N44Gd7ja8GvUhCZffbG1t7nLJABggoIPmqMcGD
	1+ST1WJQgoekD7AcqfyA6TEPitLeWO31PexbL8rp+5UfdfvbV0NRJ7CptyqGraqREGJ65s
	PSGDhywRz7asakSLa9q4x8YwVovQPo0=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=Fsn3MbM1;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (diktynna.open-mesh.org: domain of
 patchwork-bot+netdevbpf@kernel.org designates 172.234.252.31 as permitted
 sender) smtp.mailfrom=patchwork-bot+netdevbpf@kernel.org
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 63120464DE;
	Fri, 20 Nov 2026 02:10:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44AD31F000C6;
	Fri, 20 Nov 2026 02:10:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795140610;
	bh=BWF/o7HxuhpeDvyIS/P6u0dIIiRMG6uCfb04buHYMAw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=Fsn3MbM1H8nPZJ5Fnfy0J2BpkjlfovQSkKuSMxkqUkudoBMwl7bOJNplRBqkoJklq
	 +0pRVHLck9QVfXX55D3S/gck+EPp2Ne2R3TWCyMh8Jh02zntwgwpMAl5HlwH2gyhuq
	 i9vyD1BZpUmLxEVMetuJbg6i6MRrpnX/ZH3FLqzaMjOKNOdAXOUpp4qIpEhhuwRgPQ
	 7xTjI3BhRdA6j8R6J0HKLeGQdyE+SCS/Fl30ML8ELd+UvNsoEWVdei7r8wnH6cqpEz
	 HIEMs8jHeVbJv60aMTlIGM0qpspSmem6y3Z+p9xkbWorXX8ChfStoYB0wiXrwN73+G
	 xnSXt9z9fZR8Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id
 3A32B3808209;
	Fri, 20 Nov 2026 02:10:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 01/15] batman-adv: bla: use dedicated key type
 for
 claim hash
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179514060903.3979015.3571765439725680582.git-patchwork-notify@kernel.org>
Date: Fri, 20 Nov 2026 02:10:09 +0000
References: <20261114091556.3336038-2-sw@simonwunderlich.de>
In-Reply-To: <20261114091556.3336038-2-sw@simonwunderlich.de>
To: Simon Wunderlich <sw@simonwunderlich.de>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 b.a.t.m.a.n@lists.open-mesh.org, sven@narfation.org
Message-ID-Hash: N4YYZ4AXX7HJBRAJORZAGTJDS4T6B3O3
X-Message-ID-Hash: N4YYZ4AXX7HJBRAJORZAGTJDS4T6B3O3
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/N4YYZ4AXX7HJBRAJORZAGTJDS4T6B3O3/>
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

On Sat, 14 Nov 2026 10:15:42 +0100 you wrote:
> From: Sven Eckelmann <sven@narfation.org>
> 
> The claim hash lookup functions are given a struct batadv_bla_claim.
> For a lookup, a dummy claim is created on the stack and only its addr
> and vid members are filled. All other members stay uninitialized, and
> only by reading the hash and compare callbacks can one tell which
> members form the key.
> 
> [...]

Here is the summary with links:
  - [net-next,01/15] batman-adv: bla: use dedicated key type for claim hash
    https://git.kernel.org/netdev/net-next/c/e5604b4bf76c
  - [net-next,02/15] batman-adv: bla: use dedicated key type for backbone gateway hash
    https://git.kernel.org/netdev/net-next/c/f23273d7aa9d
  - [net-next,03/15] batman-adv: dat: use dedicated key type for DAT hash
    https://git.kernel.org/netdev/net-next/c/77e73f6381f6
  - [net-next,04/15] batman-adv: tt: use dedicated key type for hashes
    https://git.kernel.org/netdev/net-next/c/d4813c39c32d
  - [net-next,05/15] batman-adv: originator: pass explicit key to orig_hash
    https://git.kernel.org/netdev/net-next/c/8c42235b3d88
  - [net-next,06/15] batman-adv: hash: document key argument of hash operations
    https://git.kernel.org/netdev/net-next/c/733eaea66bf9
  - [net-next,07/15] batman-adv: never consume skb in BLA rx and DAT incoming snooping
    https://git.kernel.org/netdev/net-next/c/114fd66162da
  - [net-next,08/15] batman-adv: always consume skb in batadv_forw_packet_alloc()
    https://git.kernel.org/netdev/net-next/c/873b9f25cd4b
  - [net-next,09/15] batman-adv: split fragment forwarding into lookup and forward
    https://git.kernel.org/netdev/net-next/c/04fb828b297f
  - [net-next,10/15] batman-adv: document skb ownership of always-consuming functions
    https://git.kernel.org/netdev/net-next/c/770779407c2d
  - [net-next,11/15] batman-adv: tt: increase hash generation when purging clients
    https://git.kernel.org/netdev/net-next/c/581a1de769e4
  - [net-next,12/15] batman-adv: dat: increase hash generation when purging entries
    https://git.kernel.org/netdev/net-next/c/f984ddb2522d
  - [net-next,13/15] batman-adv: bla: increase hash generation when purging entries
    https://git.kernel.org/netdev/net-next/c/b34f640b6d90
  - [net-next,14/15] batman-adv: increase orig hash generation when purging originators
    https://git.kernel.org/netdev/net-next/c/d1c3f6e0d7f3
  - [net-next,15/15] batman-adv: annotate functions returning objects with __must_check
    https://git.kernel.org/netdev/net-next/c/e2c4b4b08e96

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


