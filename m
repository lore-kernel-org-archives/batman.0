Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A29FD2069A
	for <batman@archiver.kernel.org>; Wed, 16 Oct 2024 06:18:50 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 4C101800DF
	for <batman@archiver.kernel.org>; Wed, 16 Oct 2024 08:18:48 +0200 (CEST)
ARC-Seal: i=2; cv=fail; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1729059528;
 b=t0udTUwHfMcdnCgHfq9AC/RDLRSDyUxC4tOJo8dSQEJ8YSCx7c4zpcs5QskfCdZyYbSCT
 somW8gHwkmjdzanasPzLuDe2caWmUpJ3ML4yGC19qhvC533mZ8cWoVAYLen/JdLepiBMCkt
 4Zuf67PdB6yAKw29HkCwT2/jzg7yJ/I=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1729059528; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=lzLnLhOjiR2+pVyiXhCYA+BsRyQe1BqT/kIohvcxU10=;
 b=eEfUGg34iNt6OJGDOdittRU4xv3KILMV/PNugQcezbNq6gdxyFlC6qnYDvQCXsj4h6Eyd
 7khwhwyMKC9bFHu4WYzsWQDUbK16a6H6nFxbcQzilDNCsGHI/YDcj78AnHGbO7HZBznuVZr
 3H6jC9N77VdsBNvbb9p+69KuZlZjjbo=
ARC-Authentication-Results: i=2; open-mesh.org; dkim=pass header.d=kernel.org;
  arc=fail (ARC-Seal[1] did not validate);
  dmarc=pass (Used From Domain Record) header.from=kernel.org
 policy.dmarc=quarantine
Authentication-Results: open-mesh.org; dkim=pass header.d=kernel.org;
 arc=fail (ARC-Seal[1] did not validate);
 dmarc=pass (Used From Domain Record) header.from=kernel.org
 policy.dmarc=quarantine
Received: from nyc.source.kernel.org (nyc.source.kernel.org
 [IPv6:2604:1380:45d1:ec00::3])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 766E28150F
	for <b.a.t.m.a.n@lists.open-mesh.org>; Tue, 15 Oct 2024 20:00:37 +0200 (CEST)
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1729015237; a=rsa-sha256;
	cv=none;
	b=N31sWxmbUUJveowJ0zb4zzyes33dzcWERc3d6bI7sTHv3z80pB2MIFVyATAeNlRBIVsYFe
	5j2qfvVsF8rCKmOe+WvwWD6LqmgOExxWK8oMCDOOd1ocyvLCfDOJs/Y1/xqF/gtKUCzmv4
	uqW/NB765LnBGSRFr09KY/qm1OIMyCA=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=kernel.org header.s=k20201202 header.b=KuGT0VK8;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (diktynna.open-mesh.org: domain of
 patchwork-bot+netdevbpf@kernel.org designates 2604:1380:45d1:ec00::3 as
 permitted sender) smtp.mailfrom=patchwork-bot+netdevbpf@kernel.org
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1729015237;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=lzLnLhOjiR2+pVyiXhCYA+BsRyQe1BqT/kIohvcxU10=;
	b=A9/ZsBxwKxUp+V9gjpOBV20zy5wnKAkP4ESycqyrWlIDgoKYoysvhpsVy0+lLrLOZcCq/Y
	mLVIDqB6p81zVoxzFOvF14geDM26uZoGsQVGYqdP7O5lkS+rGoMo54jZ44mZooeEcf2N2v
	cAckfmf+lr/Q8OxDJp1ZfFxQmnQcqpM=
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 374E6A4215E;
	Tue, 15 Oct 2024 18:00:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAE2EC4CEC7;
	Tue, 15 Oct 2024 18:00:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729015235;
	bh=Sa6sgGhK0f0PdlrPB+pJBNsb8BQKXN13Ox+Haom2HEI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=KuGT0VK8S5iZkpWwdj4icg6/wNAAUrBPevfh4SZqoijO/LK0M//4+TxvzWdvkTnPh
	 ej10iYjREMrmMJ2Gu5Npr2RUIAnkdhPsv3wpjIS9oD4lasA8tAu3GCw1fTFYauLrpu
	 3RuHOcS958KJIGxUYsp0ERB1QMGW0dSsPNdQ80PsrTJLr49xkilO6b+UUnJ05d1/wn
	 JClelGibXCeLsadFDN2D9J1PR77WpKnQ3JH6qPkguuPszYj5ShJSHAIV1To4/BfUf4
	 6EO69W5HKU6Kiqfv8lDFOsDsbIiS0OIBybyVPrn0xkepuW1lWPDAUwAp49hj4XETun
	 TYtKkZ3F14U8g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id
 33D453809A8A;
	Tue, 15 Oct 2024 18:00:42 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 00/17] replace call_rcu by kfree_rcu for simple
 kmem_cache_free callback
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172901524099.1243233.14809044192149107515.git-patchwork-notify@kernel.org>
Date: Tue, 15 Oct 2024 18:00:40 +0000
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
Message-ID-Hash: P2NJHPYNJDXEPXZ5VCRSXWDZAFHM3NPP
X-Message-ID-Hash: P2NJHPYNJDXEPXZ5VCRSXWDZAFHM3NPP
X-Mailman-Approved-At: Wed, 16 Oct 2024 08:18:45 +0200
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/X22DIWUZNKGFU45TDGCHFEX2PVDSBRD6/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

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
    https://git.kernel.org/netdev/net-next/c/497e17d80759
  - [03/17] inetpeer: replace call_rcu by kfree_rcu for simple kmem_cache_free callback
    https://git.kernel.org/netdev/net-next/c/bb5810d4236b
  - [04/17] ipv6: replace call_rcu by kfree_rcu for simple kmem_cache_free callback
    https://git.kernel.org/netdev/net-next/c/85e48bcf294c
  - [05/17] xfrm6_tunnel: replace call_rcu by kfree_rcu for simple kmem_cache_free callback
    (no matching commit)
  - [06/17] batman-adv: replace call_rcu by kfree_rcu for simple kmem_cache_free callback
    (no matching commit)
  - [08/17] net: bridge: replace call_rcu by kfree_rcu for simple kmem_cache_free callback
    https://git.kernel.org/netdev/net-next/c/4ac64e570c33
  - [10/17] can: gw: replace call_rcu by kfree_rcu for simple kmem_cache_free callback
    (no matching commit)
  - [14/17] kcm: replace call_rcu by kfree_rcu for simple kmem_cache_free callback
    https://git.kernel.org/netdev/net-next/c/7bb3ecbc2b6b
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


