Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39A24EE4996
	for <batman-adv@archiver.kernel.org>; Tue, 22 Aug 2023 11:54:02 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 725E38311B
	for <batman-adv@archiver.kernel.org>; Tue, 22 Aug 2023 13:54:00 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1692705240;
 b=Ivgc7pwl8Mf63UeNkIOc1bXjVli4MrUnC0DIS3ERt4fYg3QdcEHRF4l7U4MKqpsSeeLtZ
 ORaqo8h4rpQ1Urc6AtkGp3qE/AO5WqmIc/rGjmN9gbxj0GWuOjHr9siwKA7TprmxGsXBvIE
 SjzT0N1zmLxLhyFY+hXCVF5qwAB397k=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1692705240; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=OcSyWDcOO9K6QMqsIfE1q93YdgrK/01T64BGNyTvHJs=;
 b=gnrL7f4oywCZtAkFpwRUZscSMpn9i3T7FC1eHy645ri1vdbERZApVncSt5j/KdYsXeV7l
 wIde2Ip2nH2hGr/PEIeRxh6ZR7Y1Pi0Kec7j7sXWPd+21s7mLgp5skQcFolAXZuLpqKzQFd
 RHaj9gkpTy42Z4+tu6zm8JgA2Hlo480=
ARC-Authentication-Results: i=2; open-mesh.org; dkim=pass header.d=kernel.org;
  arc=pass;
  dmarc=pass (Used From Domain Record) header.from=kernel.org
 policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=kernel.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=kernel.org policy.dmarc=none
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 4818C80757
	for <b.a.t.m.a.n@lists.open-mesh.org>; Tue, 22 Aug 2023 09:55:45 +0200 (CEST)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1692690945;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=OcSyWDcOO9K6QMqsIfE1q93YdgrK/01T64BGNyTvHJs=;
	b=yNKuk10o9LnuTWLJ1IEgRbEuxP8yS6+baaKOV7DRlGtErcZdG5LpGeHENyvzUqg2ORMZDY
	qlQUgAjUHO0u7LK2ylaKRKk05PBM0BhDmoHSiF+foZTSxiQPoGSuMWbWKnxLFHggfWkDCm
	4g+hE36vsFqIVfcsStNh3VvWzmV79pk=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=kernel.org header.s=k20201202 header.b=ZmeH0c00;
	spf=pass (diktynna.open-mesh.org: domain of horms@kernel.org designates
 2604:1380:4641:c500::1 as permitted sender) smtp.mailfrom=horms@kernel.org;
	dmarc=pass (policy=none) header.from=kernel.org
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1692690945; a=rsa-sha256;
	cv=none;
	b=S4EGMlYOBQkqH7yYvI96ChhnN2Zcdo/SAfwxEFe3JJ5f6VmIENLSISR6624bEc4r2UvplN
	gFCZq19vIo0GdjAQsPkPg2rY3kffuM3tbFZXnEsPAnMeQIEFcU3HpSM3CYq0Dwg85X1QWi
	2iNCgQmP4/rhfPf51AU02gIFZPpyIIg=
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 9F95160EBB;
	Tue, 22 Aug 2023 07:55:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A98EC433C7;
	Tue, 22 Aug 2023 07:55:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692690943;
	bh=HgS4yGKAG70Gf+ddyrfQ4yCXJvgfhzVcU5cE2sHvA9I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZmeH0c00ZEtMrTSee7G6WcrDoSDkz6l1EhgHWG8XYQCpb3JTyzQv5iTt3GMmc76ne
	 i1F1KiRzfGGdgIs8m48wRn1si931WnDn7FDAkX18fj4/FPytTfgkvyE5l0ukjG/kV0
	 gGc3eOCKJeYdBy7Rz4o/jnBDaaVk4Aa0Bl3WdmeR+BpAL6Oqbiz/Uj8jk10qAw0D9t
	 VSsqXjYuXo6W1yUW1evsW1CJT0tckM3QDcfBijXoD41oZkCaYW1iKIzO6RdYoblcUN
	 BIvXBy3xB6d8jQXDNahmfXhNId5AEdPJMyOoo103N3Uv6aNDWlWGpWk9gUDsuwEezH
	 0IWLP+fv7l51Q==
Date: Tue, 22 Aug 2023 09:55:39 +0200
From: Simon Horman <horms@kernel.org>
To: Sven Eckelmann <sven@narfation.org>
Subject: Re: [PATCH net] batman-adv: Hold rtnl lock during MTU update via
 netlink
Message-ID: <20230822075539.GU2711035@kernel.org>
References: 
 <20230821-batadv-missing-mtu-rtnl-lock-v1-1-1c5a7bfe861e@narfation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: 
 <20230821-batadv-missing-mtu-rtnl-lock-v1-1-1c5a7bfe861e@narfation.org>
X-MailFrom: horms@kernel.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-0;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-1
Message-ID-Hash: J6625VXPWM3J4SQSYPE6ITN7ZRCWOM3Z
X-Message-ID-Hash: J6625VXPWM3J4SQSYPE6ITN7ZRCWOM3Z
X-Mailman-Approved-At: Tue, 22 Aug 2023 13:53:21 +0200
CC: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, b.a.t.m.a.n@lists.open-mesh.org,
 netdev@vger.kernel.org, stable@vger.kernel.org,
 syzbot+f8812454d9b3ac00d282@syzkaller.appspotmail.com
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/J6625VXPWM3J4SQSYPE6ITN7ZRCWOM3Z/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

On Mon, Aug 21, 2023 at 09:48:48PM +0200, Sven Eckelmann wrote:
> The automatic recalculation of the maximum allowed MTU is usually triggered
> by code sections which are already rtnl lock protected by callers outside
> of batman-adv. But when the fragmentation setting is changed via
> batman-adv's own batadv genl family, then the rtnl lock is not yet taken.
> 
> But dev_set_mtu requires that the caller holds the rtnl lock because it
> uses netdevice notifiers. And this code will then fail the check for this
> lock:
> 
>   RTNL: assertion failed at net/core/dev.c (1953)
> 
> Cc: stable@vger.kernel.org
> Reported-by: syzbot+f8812454d9b3ac00d282@syzkaller.appspotmail.com
> Fixes: c6a953cce8d0 ("batman-adv: Trigger events for auto adjusted MTU")
> Signed-off-by: Sven Eckelmann <sven@narfation.org>

Reviewed-by: Simon Horman <horms@kernel.org>

> ---
> This problem was just identified by syzbot [1]. I hope it is ok to directly
> send this patch to netdev instead of creating a single-patch PR from
> the batadv/net branch. If you still prefer a PR then we can also prepare
> it.
> 
> [1] https://lore.kernel.org/r/0000000000009bbb4b0603717cde@google.com

...
