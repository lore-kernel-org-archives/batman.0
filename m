Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E806C3ABBC
	for <batman-adv@archiver.kernel.org>; Sat, 10 May 2025 00:30:30 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id C776A84030
	for <batman-adv@archiver.kernel.org>; Sat, 10 May 2025 02:30:28 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1746837028;
 b=mB/mZTyBR9qJ5FmxhlWoO2ZGjVxwTSb7Iq+sfUGLcJ2WPkp+9MoKmOmpwY5YXVnNpG+E6
 UUgdXx7ZtkPxVlbXAKC+Qr0x/j2FbI3owYDL1FXoDk1vysVkDkUKvzayMSeuIDr7QBKPpS0
 Rn325Zqocw/2yKTFogAUXakT7DMZlUc=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1746837028; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=ikyeM1Fr2Lf42LA7e3l3u9fdIDF8e5AVlUcNmcep/qI=;
 b=Ovsan1v4rBdYywHAhx2Zafg01wY6tqCVbC2TF/Htp6CnQwP6AEZYzrNNdLCqhXjD9QikO
 zme2PYIzh/ULKv0ulJUkXdZhx9hMJiP9Mfi3CqJNwuXhURsiwY8DAK1GVa2UQ6d6kV3TkcE
 BBazWQv8ntnjxPWi+qTOc3JG/vgz3/M=
ARC-Authentication-Results: i=2; open-mesh.org; dkim=pass header.d=kernel.org;
  arc=pass;
  dmarc=pass (Used From Domain Record) header.from=kernel.org
 policy.dmarc=quarantine
Authentication-Results: open-mesh.org; dkim=pass header.d=kernel.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=kernel.org policy.dmarc=quarantine
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 6396084334
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sat, 10 May 2025 02:29:52 +0200 (CEST)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1746837003;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=ikyeM1Fr2Lf42LA7e3l3u9fdIDF8e5AVlUcNmcep/qI=;
	b=baVu14VJXH8ufhPvi3nOtBc/DaffUCiuQQpKoh3cp2JP/KdCwmrSzTRxBMU6f/lc08LGF3
	L0N3kKXzAKLU+yM40IVDwFymGYQfSzZymCRaan7B+eUlvfUghC1+pH8nnYgFpkS5irKFDc
	6hQ3+C9li9YY3QAiM+DbU5cCNHVj7JQ=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=kernel.org header.s=k20201202 header.b=JXrtRgB8;
	spf=pass (diktynna.open-mesh.org: domain of
 patchwork-bot+netdevbpf@kernel.org designates 172.234.252.31 as permitted
 sender) smtp.mailfrom=patchwork-bot+netdevbpf@kernel.org;
	dmarc=pass (policy=quarantine) header.from=kernel.org
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1746837003; a=rsa-sha256;
	cv=none;
	b=ihMvQvH23leS2+o78SzRtbVoHue/2MYiDjUgqEXy9Arnw2GGpEQFQNlqHSqAT3NyAM3B8z
	tmpfR4kJFaXnL9f2eNrgmqlXlrJGpg/0uwD+53SI9XJjTLmWfZulvFMAzwKcjH8t7ji+oa
	XhzizSJQweVeOcgS2Y41C0rbUnNdZug=
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 8DB074A66E;
	Sat, 10 May 2025 00:29:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C507C4CEE4;
	Sat, 10 May 2025 00:29:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746836990;
	bh=5flC4LkV9wCWcziU/SIzwtlZU/HyoHncGFHjDuXVcK8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=JXrtRgB8zfKe6iFLpm5gVd0HBGdFl+W83iP8aki9M+6nWeGXbvk1DUivPDhkznEqC
	 WvrgASH3E6MuYE1FSFCoQ4BCZwKLvh8e5ycPDCbo0Sm+4TX0VUo9cNiqP/cuwmYape
	 qheFUeAAS9DXCAL0i2zyrbacW3fGnoSuoDQvVjxe6ZB7qtlUScl3eccNIRe/AJQ0Yt
	 fWtFlsy7ZvORs45uM8ueynpzzOuRHNxr5Z5xlwezccB5OZTEiKViOLVzmemLKlIBkr
	 ned9a5qQrGrN/fRNZ9c87/9zTziAp4w84zXd/SihHupe2avnip+0OYBiOfzB51KbZm
	 PzfSBS/Va/6SA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id
 EACF4381091A;
	Sat, 10 May 2025 00:30:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 1/1] batman-adv: fix duplicate MAC address check
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174683702875.3851370.14678019061074033156.git-patchwork-notify@kernel.org>
Date: Sat, 10 May 2025 00:30:28 +0000
References: <20250509090240.107796-2-sw@simonwunderlich.de>
In-Reply-To: <20250509090240.107796-2-sw@simonwunderlich.de>
To: Simon Wunderlich <sw@simonwunderlich.de>
Cc: davem@davemloft.net, kuba@kernel.org, netdev@vger.kernel.org,
 b.a.t.m.a.n@lists.open-mesh.org, mschiffer@universe-factory.net
Message-ID-Hash: L7OQVGKB2VFKV2JOFERVZ7Z3HBZOHLWX
X-Message-ID-Hash: L7OQVGKB2VFKV2JOFERVZ7Z3HBZOHLWX
X-MailFrom: patchwork-bot+netdevbpf@kernel.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-0;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-1;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-2
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/AXWBNTGSOYDFHWGCQVZXIPLKZTGTYIX4/>
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

On Fri,  9 May 2025 11:02:40 +0200 you wrote:
> From: Matthias Schiffer <mschiffer@universe-factory.net>
> 
> batadv_check_known_mac_addr() is both too lenient and too strict:
> 
> - It is called from batadv_hardif_add_interface(), which means that it
>   checked interfaces that are not used for batman-adv at all. Move it
>   to batadv_hardif_enable_interface(). Also, restrict it to hardifs of
>   the same mesh interface; different mesh interfaces should not interact
>   at all. The batadv_check_known_mac_addr() argument is changed from
>   `struct net_device` to `struct batadv_hard_iface` to achieve this.
> - The check only cares about hardifs in BATADV_IF_ACTIVE and
>   BATADV_IF_TO_BE_ACTIVATED states, but interfaces in BATADV_IF_INACTIVE
>   state should be checked as well, or the following steps will not
>   result in a warning then they should:
> 
> [...]

Here is the summary with links:
  - [net,1/1] batman-adv: fix duplicate MAC address check
    https://git.kernel.org/netdev/net/c/8772cc49e0b8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


