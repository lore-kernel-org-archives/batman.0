Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97A7DC369B1
	for <batman@archiver.kernel.org>; Wed, 16 Apr 2025 07:05:31 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id D09E284936
	for <batman@archiver.kernel.org>; Wed, 16 Apr 2025 09:05:29 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1744787129;
 b=IsD/Nj9usNT/xmdOn0kFPHM7GUEIa+tSggZKkP5iEsHICNjSBrQVBcFFgmekpLrwgiRgW
 P+8HTflCO0xA0Y2HFU3+yCHAzkTdUIaphs9sHI6DLjge7ulVya97Fgenhn7ETcqElMR1B6o
 OQussnSITjbzziruQ/yzhEaidMGvjIU=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1744787129; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=3VBQIdiOdSt8WaOMvTxp6unaxnq+a3uZAKmQ4/6s2bE=;
 b=EIpMnuKb0b2VLcm4ELLAlbDcxlgfD6XnVYo3CsxmrtW58If7vM7bxBnxxSatpNvCWjo/v
 GhO6Yv/Xb4+YetrgSoQFEnhgMIUUr71bylDJzOFvAHSCKqgs7JQmp394TNMo4Ehho2PkSGv
 FZEHZmEQTQuwBuKwwxLMUm4AZ8Syrp8=
ARC-Authentication-Results: i=2; open-mesh.org; dkim=pass header.d=kernel.org;
  arc=pass;
  dmarc=pass (Used From Domain Record) header.from=kernel.org
 policy.dmarc=quarantine
Authentication-Results: open-mesh.org; dkim=pass header.d=kernel.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=kernel.org policy.dmarc=quarantine
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id E9780845F7
	for <b.a.t.m.a.n@lists.open-mesh.org>; Wed, 16 Apr 2025 05:09:57 +0200 (CEST)
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1744773008; a=rsa-sha256;
	cv=none;
	b=0P/YX6cg+/RXio6Ow5sKZ82FJKn8cRkcnoxypUnE/VNfNWU999WzEuRBkKnrgJTq6wGv/p
	O/wdAc3S8dZwFZ40d2Q39DjzF7RH1iWFHDlKQwyR7+kn5tpGfWYKJQ9LS+nlQWFEtFHzSI
	1ka0mqpIyl4f9OwsyJKEJEe+jgCk/PQ=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=kernel.org header.s=k20201202 header.b=SXnvyzUF;
	spf=pass (diktynna.open-mesh.org: domain of
 patchwork-bot+netdevbpf@kernel.org designates 2604:1380:4641:c500::1 as
 permitted sender) smtp.mailfrom=patchwork-bot+netdevbpf@kernel.org;
	dmarc=pass (policy=quarantine) header.from=kernel.org
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1744773008;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=3VBQIdiOdSt8WaOMvTxp6unaxnq+a3uZAKmQ4/6s2bE=;
	b=TZBn60ogyc/Pktu2RWZMC+7A+PjE7pUROXDz/5Y+Ae9BHysRHMhNUUEHIgA7/nt0w3hZ9z
	YjFkBUt8FHhkLN0ZZdWwWlrtOal4ulBLoGhKuBgLPeOj+9dZOn7sc/Bz88expGk1aGy9nZ
	IfPT0aO3tGRPHuBj2fV5KG2/KmssXmo=
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 47DFA5C5A1A;
	Wed, 16 Apr 2025 03:07:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDF5FC4CEEB;
	Wed, 16 Apr 2025 03:09:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744772996;
	bh=pjwuOhl+6YnLRO0UJWY97LUYEwC0+mgIl+EW6AZdz3s=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=SXnvyzUF3PkfQxd3KY6C5nx9Z7fGtfz7q/PDdxxbjw0UC1s008kRVlDl93zijVNtA
	 KVz7FG+RMh9Z+FXd6u2o4FJ7i1Vx9qOr8Q9FrUzagsh4mC3z/XoCahfxEzQyZgQkaA
	 F5tmhBw0dvPPjwahH/qfPfHad7iBDEUFFELtlk4BhKk4XREv4aX33gHU2iHLY3ekOV
	 L/V/ES9a7ozknm23AqcXMNmOGHjb+7R2AaLbwQF5nd08BfSGHLQnhYvp97rLZxaOni
	 8hKQRVf3Fd3R39/lOf1iyezpfhCLKvE930/6mioecx1jyrhKv9LDbktKlG+L6FoTwP
	 bnXBisWu2dbWw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id
 33F593822D55;
	Wed, 16 Apr 2025 03:10:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v5] batman-adv: Fix double-hold of meshif when getting
 enabled
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174477303400.2860234.7904751019740013737.git-patchwork-notify@kernel.org>
Date: Wed, 16 Apr 2025 03:10:34 +0000
References: <20250414-double_hold_fix-v5-1-10e056324cde@narfation.org>
In-Reply-To: <20250414-double_hold_fix-v5-1-10e056324cde@narfation.org>
To: Sven Eckelmann <sven@narfation.org>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, b.a.t.m.a.n@lists.open-mesh.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 syzbot+ff3aa851d46ab82953a3@syzkaller.appspotmail.com,
 syzbot+4036165fc595a74b09b2@syzkaller.appspotmail.com,
 syzbot+c35d73ce910d86c0026e@syzkaller.appspotmail.com,
 syzbot+48c14f61594bdfadb086@syzkaller.appspotmail.com,
 syzbot+f37372d86207b3bb2941@syzkaller.appspotmail.com
X-MailFrom: patchwork-bot+netdevbpf@kernel.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-0;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-1;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-2
Message-ID-Hash: QZMMBN47AA4FKXOCMHYYCKA3LHECX72R
X-Message-ID-Hash: QZMMBN47AA4FKXOCMHYYCKA3LHECX72R
X-Mailman-Approved-At: Wed, 16 Apr 2025 09:05:24 +0200
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/I6PX6S33CVF2FXPEAN4SHTPUCDASRJC6/>
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

On Mon, 14 Apr 2025 20:05:37 +0200 you wrote:
> It was originally meant to replace the dev_hold with netdev_hold. But this
> was missed in batadv_hardif_enable_interface(). As result, there was an
> imbalance and a hang when trying to remove the mesh-interface with
> (previously) active hard-interfaces:
> 
>   unregister_netdevice: waiting for batadv0 to become free. Usage count = 3
> 
> [...]

Here is the summary with links:
  - [net,v5] batman-adv: Fix double-hold of meshif when getting enabled
    https://git.kernel.org/netdev/net/c/10a77965760c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


