Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72FEDD60D12
	for <batman-adv@archiver.kernel.org>; Tue, 19 Nov 2024 03:07:17 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id A490183F5E
	for <batman-adv@archiver.kernel.org>; Tue, 19 Nov 2024 04:07:15 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1731985635;
 b=t5XRrJq1qhBRo202vkB70kh3vPY35WkutypT842Js1s5TrqBis0e9g5ks+mBe4JcJqZAa
 PzYUA3ArOUitCw9R0IDrYm1qciBwn4kfD8Plqb+eQtM0Q0WDT/+AzkrJ8l5r6t7JgFDuBAn
 dNZMkgSQVJsQGhdlUtew0H4SSpd/tyY=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1731985635; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=/WPIIba+7UAUNJarc3qBJ1i0kO7vNM7h1He5Vk/uAV0=;
 b=BuO+E0QYUaS6WWMbvVQT9ijhpsck+GF0myrZZVzS+5xp0jygd9LjFy34XlY23Q6IHQFPA
 9Z12RJywhVlS3eSQv4kKriXZDTcF3e0BzlX6JDklM0DoKynBiucQH5BW0rXhzNxfLqMez3W
 5JXLoNVh8PC5JC5EbkG7I6otoQt0xi8=
ARC-Authentication-Results: i=2; open-mesh.org; dkim=pass header.d=kernel.org;
  arc=pass;
  dmarc=pass (Used From Domain Record) header.from=kernel.org
 policy.dmarc=quarantine
Authentication-Results: open-mesh.org; dkim=pass header.d=kernel.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=kernel.org policy.dmarc=quarantine
Received: from nyc.source.kernel.org (nyc.source.kernel.org [147.75.193.91])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 4B04B8261D
	for <b.a.t.m.a.n@lists.open-mesh.org>; Tue, 19 Nov 2024 04:07:04 +0100 (CET)
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1731985624; a=rsa-sha256;
	cv=none;
	b=t/+dS6K1kVyd3rLuG2pDDJIdH4caCWx0gbEywZAENcpR+2utPvWWwGZ2L0NF4bKrnMbZuq
	nXPLwPN73QS+87vH/uu2dl5QPao09jbdK5F1wC87QUFw6GJC8yxxFS2LtSNSsXJvklUtOJ
	IeE/ecze6yu6CAl3fE/Xxf+ESHOInck=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=kernel.org header.s=k20201202 header.b=oGWzVf9f;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (diktynna.open-mesh.org: domain of kuba@kernel.org designates
 147.75.193.91 as permitted sender) smtp.mailfrom=kuba@kernel.org
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1731985624;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=/WPIIba+7UAUNJarc3qBJ1i0kO7vNM7h1He5Vk/uAV0=;
	b=si31r1qt2l/22ajyNXS8o42PXSjWMQNncBj8uTJz4aiDaXBAFW/hc+k54/DiRjobG6+R/6
	yjGsD+yaYPNBBZzoewd4Kdv1n1GpLE2q+9nVmffFQJscKS/PeuK23G0P1fAqeuCk+nCbfe
	GkjQqff2hg0kywh5bwlFyCYezfjJ/GI=
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 95061A42574;
	Tue, 19 Nov 2024 03:05:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAD48C4CECF;
	Tue, 19 Nov 2024 03:07:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731985622;
	bh=PGoG8fEB7llM322/jpcOwn3LGAi0gafsk5SM9vL39KQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=oGWzVf9fm47IURqF82sBjxlSLSQaSxQvnftln+sAaadyrOaTpKmG1QB1++Q+XtGq2
	 iqnrNBO0CyTqqEwlU/q+011kC2hwIrbq/6K0SGXImw3qfRg1+XKGoOsssJ5vIMkYcz
	 Z6YQRFxP4izqrZoqEbsdoy+taGRJqRWgfpsrekJKESn6nbT7e6NOHGhh6GN5IbeTmn
	 lzthFeg7CnYNFnEs0XFbrLEZd2ql/Jl9IGwusT5cDv1Qr6Psf8Q5n6XqbkH/peqmPn
	 uwk0TjN/tbOC/IkQ2CmF/L5xISUzVUBpQQlxdujGCk9lYUVk7IvT7QmP1ZZAPQtMkX
	 AVNlOOjcQBmSw==
Date: Mon, 18 Nov 2024 19:07:00 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Xiao Liang <shaw.leon@gmail.com>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, Kuniyuki
 Iwashima <kuniyu@amazon.com>, Donald Hunter <donald.hunter@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Ido
 Schimmel <idosch@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>, Simon
 Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>, Jiri Pirko
 <jiri@resnulli.us>, Hangbin Liu <liuhangbin@gmail.com>,
 linux-rdma@vger.kernel.org, linux-can@vger.kernel.org,
 osmocom-net-gprs@lists.osmocom.org, bpf@vger.kernel.org,
 linux-ppp@vger.kernel.org, wireguard@lists.zx2c4.com,
 linux-wireless@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org,
 bridge@lists.linux.dev, linux-wpan@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v4 0/5] net: Improve netns handling in RTNL and
 ip_tunnel
Message-ID: <20241118190700.4c1b8156@kernel.org>
In-Reply-To: <20241118143244.1773-1-shaw.leon@gmail.com>
References: <20241118143244.1773-1-shaw.leon@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-ID-Hash: EVT6KMIDJPI6IGM3U626G7BI4CMHATMI
X-Message-ID-Hash: EVT6KMIDJPI6IGM3U626G7BI4CMHATMI
X-MailFrom: kuba@kernel.org
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/EVT6KMIDJPI6IGM3U626G7BI4CMHATMI/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

On Mon, 18 Nov 2024 22:32:39 +0800 Xiao Liang wrote:
> This patch series includes some netns-related improvements and fixes for
> RTNL and ip_tunnel, to make link creation more intuitive:
> 
>  - Creating link in another net namespace doesn't conflict with link names
>    in current one.
>  - Refector rtnetlink link creation. Create link in target namespace
>    directly. Pass both source and link netns to drivers via newlink()
>    callback.
> 
> So that
> 
>   # ip link add netns ns1 link-netns ns2 tun0 type gre ...
> 
> will create tun0 in ns1, rather than create it in ns2 and move to ns1.
> And don't conflict with another interface named "tun0" in current netns.

## Form letter - net-next-closed

The merge window for v6.13 has begun and net-next is closed for new drivers,
features, code refactoring and optimizations. We are currently accepting
bug fixes only.

Please repost when net-next reopens after Dec 2nd.

RFC patches sent for review only are welcome at any time.

See: https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#development-cycle
-- 
pw-bot: defer

