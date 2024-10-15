Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3A8FD216A7
	for <batman@archiver.kernel.org>; Tue, 15 Oct 2024 13:54:48 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 4421C8184E
	for <batman@archiver.kernel.org>; Tue, 15 Oct 2024 15:54:47 +0200 (CEST)
ARC-Seal: i=2; cv=fail; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1729000487;
 b=g8PLV0lOaL15XU6O12tsdoqdHIUF+Yh2Hl87mzaT0lf1/gHe1Xy3BoHFtnmtQ9PXMLHgI
 6AwH5fDnQwV8RIgMMObjcgg226Jv+Ebs8vsFeDAhvaGIKzmFsUD35YADN0bpowbU2gL2lQY
 NcX9iijojmNXo7hXSWu+Qp71ySXYCp4=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1729000487; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=y+sDwZCNM90KYt/soAlpYgBe1DdAWGrVEXxeOWfj4Jg=;
 b=rNnN5JPnKZx1oQvI8OpbtxY6EAo3wbIJnHqDu/8wlBd1HMh9o5grqkfWp+SZqqdGOldIx
 MpzmMiQ81ecgySsfSAU5AvYDU3pEmjUQPiVZkt2DaHwvVeqpTuY54YvZyjTK3SwJLt/NF8l
 g/3ZsEJXcCJbDqM07VhOXR83HiDY7N8=
ARC-Authentication-Results: i=2; open-mesh.org; dkim=pass header.d=kernel.org;
  arc=fail (ARC-Seal[1] did not validate);
  dmarc=pass (Used From Domain Record) header.from=kernel.org
 policy.dmarc=quarantine
Authentication-Results: open-mesh.org; dkim=pass header.d=kernel.org;
 arc=fail (ARC-Seal[1] did not validate);
 dmarc=pass (Used From Domain Record) header.from=kernel.org
 policy.dmarc=quarantine
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id A41BD81D80
	for <b.a.t.m.a.n@lists.open-mesh.org>; Tue, 15 Oct 2024 15:40:28 +0200 (CEST)
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1728999629; a=rsa-sha256;
	cv=none;
	b=10mJlwrs8IgTGdhLHBWW5CJZfrydNpk0fCyYhj9FmmG90ZzSuRNlFRs7ezSs/9axGBSX+/
	lx10onIZ8LtWzhG/JQ0y6kWS/9yEk6fp7nkghfEn0OJzV71UrrSHi/GvoteYwq6bDz6cQK
	YjrV5n6z6/jh1D/9MhfOTsd98cwKiHk=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=kernel.org header.s=k20201202 header.b=uX00nqRb;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (diktynna.open-mesh.org: domain of
 patchwork-bot+netdevbpf@kernel.org designates 2604:1380:4641:c500::1 as
 permitted sender) smtp.mailfrom=patchwork-bot+netdevbpf@kernel.org
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1728999629;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=y+sDwZCNM90KYt/soAlpYgBe1DdAWGrVEXxeOWfj4Jg=;
	b=yMe57jpnIDN688A5aB6L6IicUh3jFy6AV//n5SKzRfeHKEDHWQMhcq/jm0ZfoGvVmQ+cgL
	beScBn9OdEoS2lrAwzC5legpkeOBQwVX9P3KSjf+YuwCCQUmXLfUO6Vz/j7VePjcfa6hE1
	/LQeSREvzVf9QErD86Q/6CGBWJbA30w=
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id E51EB5C58C6;
	Tue, 15 Oct 2024 13:40:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1D07C4CEC6;
	Tue, 15 Oct 2024 13:40:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728999626;
	bh=+eg5Ogets9SiLlYwP2uE1cyuHarfu0eMJpCc1LNOyZk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=uX00nqRbj0TEG1Tz8shbGOT2WxuN/MzsJ0/O8D6fMk7nTY7nynwkrPoV5Izq1912G
	 MCNxilzGTiCcfUAS5pjSXwW6q3cRG/BW6D6YbtnmlO0q+fhZtWAV8iW5Tl912r9gZP
	 jE929Z//XzSjfIYVBdbbV+yN6bRsMcoaXu9P5SmP/HpGUsX8oWRvpS3y/CHIagsxmZ
	 wSs02+S5+DmmcEkoZwbxu00ArbFRTvF91bDqH9pPk66sN6FjSlgd1oE0CGyqAvnLq/
	 xoAmzPiMCVa7yA7fqt68pGzpMEomnxnAVW+/H1RaLmsld8vRk3GlFiM5j84R4We9bm
	 NTYamxloL6Fqw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id
 33B943809A8A;
	Tue, 15 Oct 2024 13:40:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 00/17] replace call_rcu by kfree_rcu for simple
 kmem_cache_free callback
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172899963173.1165800.13282848624565322990.git-patchwork-notify@kernel.org>
Date: Tue, 15 Oct 2024 13:40:31 +0000
References: <20241013201704.49576-1-Julia.Lawall@inria.fr>
In-Reply-To: <20241013201704.49576-1-Julia.Lawall@inria.fr>
To: Julia Lawall <julia.lawall@inria.fr>
Cc: linux-nfs@vger.kernel.org, kernel-janitors@vger.kernel.org,
 vbabka@suse.cz, paulmck@kernel.org, tom@talpey.com, Dai.Ngo@oracle.com,
 okorniev@redhat.com, neilb@suse.de, linux-can@vger.kernel.org,
 bridge@lists.linux.dev, b.a.t.m.a.n@lists.open-mesh.org,
 linux-kernel@vger.kernel.org, wireguard@lists.zx2c4.com,
 netdev@vger.kernel.org, ecryptfs@vger.kernel.org,
 linux-block@vger.kernel.org, npiggin@gmail.com, christophe.leroy@csgroup.eu,
 naveen@kernel.org, maddy@linux.ibm.com, linuxppc-dev@lists.ozlabs.org,
 kvm@vger.kernel.org, netfilter-devel@vger.kernel.org, coreteam@netfilter.org
X-MailFrom: patchwork-bot+netdevbpf@kernel.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-0;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-1;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-2
Message-ID-Hash: ZNO75KNFQVWX7LVYMIX4JOYWDTLRG5GT
X-Message-ID-Hash: ZNO75KNFQVWX7LVYMIX4JOYWDTLRG5GT
X-Mailman-Approved-At: Tue, 15 Oct 2024 15:53:57 +0200
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/22LLNIUUVI2MLR3RMVXMTM74ENWKOHPS/>
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

On Sun, 13 Oct 2024 22:16:47 +0200 you wrote:
> Since SLOB was removed and since
> commit 6c6c47b063b5 ("mm, slab: call kvfree_rcu_barrier() from kmem_cache_destroy()"),
> it is not necessary to use call_rcu when the callback only performs
> kmem_cache_free. Use kfree_rcu() directly.
> 
> The changes were done using the following Coccinelle semantic patch.
> This semantic patch is designed to ignore cases where the callback
> function is used in another way.
> 
> [...]

Here is the summary with links:
  - [01/17] wireguard: allowedips: replace call_rcu by kfree_rcu for simple kmem_cache_free callback
    (no matching commit)
  - [02/17] ipv4: replace call_rcu by kfree_rcu for simple kmem_cache_free callback
    (no matching commit)
  - [03/17] inetpeer: replace call_rcu by kfree_rcu for simple kmem_cache_free callback
    (no matching commit)
  - [04/17] ipv6: replace call_rcu by kfree_rcu for simple kmem_cache_free callback
    (no matching commit)
  - [05/17] xfrm6_tunnel: replace call_rcu by kfree_rcu for simple kmem_cache_free callback
    (no matching commit)
  - [06/17] batman-adv: replace call_rcu by kfree_rcu for simple kmem_cache_free callback
    https://git.kernel.org/netdev/net-next/c/356c81b6c494
  - [08/17] net: bridge: replace call_rcu by kfree_rcu for simple kmem_cache_free callback
    (no matching commit)
  - [10/17] can: gw: replace call_rcu by kfree_rcu for simple kmem_cache_free callback
    (no matching commit)
  - [14/17] kcm: replace call_rcu by kfree_rcu for simple kmem_cache_free callback
    (no matching commit)
  - [15/17] netfilter: nf_conncount: replace call_rcu by kfree_rcu for simple kmem_cache_free callback
    (no matching commit)
  - [16/17] netfilter: expect: replace call_rcu by kfree_rcu for simple kmem_cache_free callback
    (no matching commit)
  - [17/17] netfilter: xt_hashlimit: replace call_rcu by kfree_rcu for simple kmem_cache_free callback
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


