Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEAF7C88E4A
	for <batman-adv@archiver.kernel.org>; Fri, 11 Sep 2026 01:11:21 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id E16518336B
	for <batman-adv@archiver.kernel.org>; Fri, 11 Sep 2026 03:11:19 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1789089079;
 b=LkReaSU/xPogPBZQSSSdeEU0HkWyb79LIUAQNv+WpEVPCuOif8Vvzjqg1t9pGrd2UzoDZ
 +ekH/Jbmbve/fH8LsTnxxAJb+6rR1Hf5lPp4W9V9vAokElCkRW78HrIALltBF0g33Cbl+0m
 EcpEx/xw85XwfAAkySNM4cEPqQ2VMN0=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1789089079; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=COxM5nheeIAIoGcpHWTk9qgNvX6jI95QcrY9v89jb3s=;
 b=piz5+1nOa+oteRhy1srAW5EtdjraLdLa3KwTkWpFMvZD+GbRBAEmkJ+k1DAZx+rWfNgas
 YM61ffzbvFTHvWDjN5e+whlkkNn+wgolX3OvINfMGNkF/Chg/o0S4R4A+C2wZOQ2cZQQ/jr
 CPMfnChKykn3gvt5SEkfD177SrP2qTQ=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=kernel.org;
 arc=pass;
 dmarc=pass header.from=kernel.org policy.dmarc=quarantine
Authentication-Results: open-mesh.org; dkim=pass header.d=kernel.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=kernel.org policy.dmarc=quarantine
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id BD33C8045F
	for <b.a.t.m.a.n@lists.open-mesh.org>; Fri, 11 Sep 2026 03:11:10 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1789089071;
	b=Vz6CL7rMyTZ2Edi8/YC8PSlDqnOEl7lW6UE+wWpPQY0wpyW476MJIoPEkmHTRQpuw17DpX
	dR+xW4ab+CfI2mIutn+avhB69G4LdYvEFsp6gLU7fP1ueEpjIuh6537qihdwzLfw/y9pSY
	OjnMenOwO82Gztgi3vtmh6Kj545HNE4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1789089071;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=COxM5nheeIAIoGcpHWTk9qgNvX6jI95QcrY9v89jb3s=;
	b=EDzxKZsDWX913LOblDVMqi9Ew+W/f26AtHwkzfJ7BrBVzC7dWaRjTrXbv8ysVP7TwS+TrD
	/rpnpG8b+NJpV1bjPcV4KVGQXRiEX/kJ528X+JlF8eCo8akmzSly7HTouz4Tnn4d2NKNwu
	15lhSJL93BjNaOzHeXYyIVeTeM+RLiE=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=NwN8c5ET;
	spf=pass (diktynna.open-mesh.org: domain of
 patchwork-bot+netdevbpf@kernel.org designates 172.105.4.254 as permitted
 sender) smtp.mailfrom=patchwork-bot+netdevbpf@kernel.org;
	dmarc=pass (policy=quarantine) header.from=kernel.org
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 3CC3160204;
	Fri, 11 Sep 2026 01:11:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E52E01F000FF;
	Fri, 11 Sep 2026 01:11:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789089068;
	bh=COxM5nheeIAIoGcpHWTk9qgNvX6jI95QcrY9v89jb3s=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=NwN8c5ETX9cq1NHWLjnO6y1kq42+C295a7irzS5quv9amHr2Ca7QOLCNFUfP/1siH
	 v3OPQmSbm14Hr6IOQeFM9eSMCoyEtdGLZW6MzkH85DNdrqYUP+Ofau2h4G+66u+s2k
	 Fpt6+DvDVAzXAUgBmEir/8WLTbOcrQJgJzSN5x+1BnGfR+RyzLY4NoPQ3Kp5Xi5YQU
	 kJsGmZ4SX7Z7dVYVODBd2+vGk5Ur8C5meI31UgOOw/sr4n891hDq6Ue0GFKCIQg56Z
	 9NZUxQL/Kp5kPF5pnLFxwZBtX5HFbvFmH9yeSlUnoRPTA7PBBGS4sJNC9aC/WByY7Y
	 4lqq1AtVySAbw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id
 56A063810901;
	Fri, 11 Sep 2026 01:10:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 01/15] batman-adv: tt: look up wifi state of
 incoming
 interface in helper
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178908900614.2170035.18425688675148363165.git-patchwork-notify@kernel.org>
Date: Fri, 11 Sep 2026 01:10:06 +0000
References: <20260907081824.2474040-2-sw@simonwunderlich.de>
In-Reply-To: <20260907081824.2474040-2-sw@simonwunderlich.de>
To: Simon Wunderlich <sw@simonwunderlich.de>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 b.a.t.m.a.n@lists.open-mesh.org, sven@narfation.org
Message-ID-Hash: TYNXFIVQGWDLZYX46DLBAQVKV3P5NIFH
X-Message-ID-Hash: TYNXFIVQGWDLZYX46DLBAQVKV3P5NIFH
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/TYNXFIVQGWDLZYX46DLBAQVKV3P5NIFH/>
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

On Mon,  7 Sep 2026 10:18:10 +0200 you wrote:
> From: Sven Eckelmann <sven@narfation.org>
> 
> batadv_tt_local_add() only needs to know whether the client was seen on a
> wifi interface. But it kept the net_device reference of the incoming
> interface alive until its own cleanup section, together with a "net" and an
> "in_dev" variable which are of no interest to the rest of the function.
> 
> [...]

Here is the summary with links:
  - [net-next,01/15] batman-adv: tt: look up wifi state of incoming interface in helper
    https://git.kernel.org/netdev/net-next/c/3273a5cd2d74
  - [net-next,02/15] batman-adv: tt: extract allocation of new local entries
    https://git.kernel.org/netdev/net-next/c/defa87f5ce75
  - [net-next,03/15] batman-adv: tt: replace forward gotos in batadv_tt_local_add()
    https://git.kernel.org/netdev/net-next/c/a5e5d2709d10
  - [net-next,04/15] batman-adv: tt: extract refresh of existing local entries
    https://git.kernel.org/netdev/net-next/c/ec6edeb755ec
  - [net-next,05/15] batman-adv: tt: extract update of dynamic client flags
    https://git.kernel.org/netdev/net-next/c/d72e16b1c5d5
  - [net-next,06/15] batman-adv: tt: extract allocation of new global entries
    https://git.kernel.org/netdev/net-next/c/d9017aeb40c1
  - [net-next,07/15] batman-adv: tt: extract merging of flags into existing global entries
    https://git.kernel.org/netdev/net-next/c/b535e61347ba
  - [net-next,08/15] batman-adv: tt: replace add_orig_entry goto in batadv_tt_global_add()
    https://git.kernel.org/netdev/net-next/c/3f8e8b42f639
  - [net-next,09/15] batman-adv: tt: extract removal of the superseded local entry
    https://git.kernel.org/netdev/net-next/c/228c70d51b10
  - [net-next,10/15] batman-adv: tt: extract marking of a removed local entry
    https://git.kernel.org/netdev/net-next/c/5e02403a4c2e
  - [net-next,11/15] batman-adv: tt: extract immediate purge of a local entry
    https://git.kernel.org/netdev/net-next/c/931de98d3960
  - [net-next,12/15] batman-adv: tt: drop the cleanup label from batadv_tt_local_remove()
    https://git.kernel.org/netdev/net-next/c/926013fd40f6
  - [net-next,13/15] batman-adv: tt: clarify kernel doc for batadv_tt_local_set_pending_event()
    https://git.kernel.org/netdev/net-next/c/857fbd765c65
  - [net-next,14/15] batman-adv: bat_iv: fix ogm_neigh_is_sob parameters references
    https://git.kernel.org/netdev/net-next/c/271f3730fc87
  - [net-next,15/15] batman-adv: correct batadv_hash_remove kdoc return type
    https://git.kernel.org/netdev/net-next/c/6d7f71ae4cdc

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


