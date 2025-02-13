Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F837C021A7
	for <batman@archiver.kernel.org>; Thu, 13 Feb 2025 07:12:45 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 003F884239
	for <batman@archiver.kernel.org>; Thu, 13 Feb 2025 08:12:43 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1739430763;
 b=newqxQu2GZEOQzP+2N+QAGdxfFTuKrk2HRtrTuI2nQqg6L5fhg4NRifR6fb7UpG33XJp0
 tpky98p/Ww6qxLBki53lrYizb8ZVKh0LVLHVrKf5W+zmDNbHBndRt0c2itcyEkeXQ4nZUe4
 TcVK54Z0Yz7wrErDPT/krGCXU0np2j8=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1739430763; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=HIz1Atlqpi5tnoN7n4BPu3eHETPxx2TUlMkVpEwhuEo=;
 b=JPXzKC47eovPIo00g26vqjVLOVLiPCYdgLN5piaq3exUUZd9a7/VPTXex7qjzd/dYv643
 PhhKqL+aeNwGnXTSCndgSFg2Ct+P4QWTuVfkuFWOPhZEQAQDFW759fZnurlIL/BqPczrb/+
 2yzACk/5lM9g80VV9bQvR2qb6l22guA=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=amazon.com header.i=@amazon.com;
  arc=pass;
  dmarc=none
Authentication-Results: open-mesh.org;
 dkim=pass header.d=amazon.com header.i=@amazon.com; arc=pass; dmarc=none
Received: from smtp-fw-6001.amazon.com (smtp-fw-6001.amazon.com
 [52.95.48.154])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 4D1BF81755
	for <b.a.t.m.a.n@lists.open-mesh.org>; Thu, 13 Feb 2025 08:05:56 +0100 (CET)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1739430356;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=HIz1Atlqpi5tnoN7n4BPu3eHETPxx2TUlMkVpEwhuEo=;
	b=u/fQqZCibdoSgAHqPxR0X81p/Kov31m/30GOKmvM4zRUzBoW1aTmtzwsB8pAY5xhelVyrD
	kTEiLgayVN+H1q/RUDFIIISqoKoHlLPHqo1N+x/HLkAYMYlb6ajtmnXM2czaZ3r3tqFuRJ
	PlsR+6+1qfUWUK9rNU1JiNxJzgANW5A=
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1739430356; a=rsa-sha256;
	cv=none;
	b=3dg6nnuVQhl0ghhjWazy6iP1sn9YzEN6kQFziIrezDfEYurWJB0EIeH40odFOdtZNQwzYu
	AI1ADp9aXJihUEp57i4PAEvx+r3uQ5aLdG+wTt+hooZvFs8eiXbMl+L6SpALw+6OTBnQeh
	cP/sHswWynLYN+xf7r1YI9dEqbwDdP8=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=amazon.com header.s=amazon201209 header.b=Wwmobb+O;
	spf=pass (diktynna.open-mesh.org: domain of
 "prvs=132b843d4=kuniyu@amazon.co.jp" designates 52.95.48.154 as permitted
 sender) smtp.mailfrom="prvs=132b843d4=kuniyu@amazon.co.jp";
	dmarc=pass (policy=quarantine) header.from=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1739430356; x=1770966356;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=HIz1Atlqpi5tnoN7n4BPu3eHETPxx2TUlMkVpEwhuEo=;
  b=Wwmobb+OeJaUnwvzC8qyWguE4ENhgecbc1e8iz9L0n9C76h5kFvEpdDH
   SYd0Ywi2qVj5dKxFaku3Mx0qCjUjYYsBJ81ObmFxRbl54rX7HByfjZsAB
   ePZmQ/KkI3OLtwLPTLi4elv/4AKdfU6d79ymo3OIODW7C3mIcqeXnDD0D
   k=;
X-IronPort-AV: E=Sophos;i="6.13,282,1732579200";
   d="scan'208";a="462133403"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO
 smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.2])
  by smtp-border-fw-6001.iad6.amazon.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2025 07:05:51 +0000
Received: from EX19MTAUWC001.ant.amazon.com [10.0.7.35:18133]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.32.208:2525]
 with esmtp (Farcaster)
 id 044845a0-eb50-4d20-a33f-ef53eec55ed0;
 Thu, 13 Feb 2025 07:05:50 +0000 (UTC)
X-Farcaster-Flow-ID: 044845a0-eb50-4d20-a33f-ef53eec55ed0
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Thu, 13 Feb 2025 07:05:50 +0000
Received: from 6c7e67bfbae3.amazon.com (10.37.244.7) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Thu, 13 Feb 2025 07:05:42 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <shaw.leon@gmail.com>
CC: <alex.aring@gmail.com>, <andrew+netdev@lunn.ch>,
	<b.a.t.m.a.n@lists.open-mesh.org>, <bpf@vger.kernel.org>,
	<bridge@lists.linux.dev>, <davem@davemloft.net>, <donald.hunter@gmail.com>,
	<dsahern@kernel.org>, <edumazet@google.com>, <herbert@gondor.apana.org.au>,
	<horms@kernel.org>, <kuba@kernel.org>, <kuniyu@amazon.com>,
	<linux-can@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, <linux-ppp@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <linux-wireless@vger.kernel.org>,
	<linux-wpan@vger.kernel.org>, <miquel.raynal@bootlin.com>,
	<netdev@vger.kernel.org>, <osmocom-net-gprs@lists.osmocom.org>,
	<pabeni@redhat.com>, <shuah@kernel.org>, <stefan@datenfreihafen.org>,
	<steffen.klassert@secunet.com>, <wireguard@lists.zx2c4.com>
Subject: Re: [PATCH net-next v9 06/11] net: ipv6: Use link netns in newlink()
 of rtnl_link_ops
Date: Thu, 13 Feb 2025 16:05:33 +0900
Message-ID: <20250213070533.9926-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250210133002.883422-7-shaw.leon@gmail.com>
References: <20250210133002.883422-7-shaw.leon@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.37.244.7]
X-ClientProxiedBy: EX19D035UWA002.ant.amazon.com (10.13.139.60) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)
X-MailFrom: prvs=132b843d4=kuniyu@amazon.co.jp
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-0;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-1;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-2
Message-ID-Hash: 67FXGYCQJCPD53HNPZQUQMIEB42BP47E
X-Message-ID-Hash: 67FXGYCQJCPD53HNPZQUQMIEB42BP47E
X-Mailman-Approved-At: Thu, 13 Feb 2025 08:08:50 +0100
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/67FXGYCQJCPD53HNPZQUQMIEB42BP47E/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

From: Xiao Liang <shaw.leon@gmail.com>
Date: Mon, 10 Feb 2025 21:29:57 +0800
> When link_net is set, use it as link netns instead of dev_net(). This
> prepares for rtnetlink core to create device in target netns directly,
> in which case the two namespaces may be different.
> 
> Set correct netns in priv before registering device, and avoid
> overwriting it in ndo_init() path.
> 
> Signed-off-by: Xiao Liang <shaw.leon@gmail.com>
> ---
>  net/ipv6/ip6_gre.c    | 20 ++++++++++----------
>  net/ipv6/ip6_tunnel.c | 13 ++++++++-----
>  net/ipv6/ip6_vti.c    | 10 ++++++----
>  net/ipv6/sit.c        | 11 +++++++----
>  4 files changed, 31 insertions(+), 23 deletions(-)
> 
> diff --git a/net/ipv6/ip6_gre.c b/net/ipv6/ip6_gre.c
> index 863852abe8ea..108600dc716f 100644
> --- a/net/ipv6/ip6_gre.c
> +++ b/net/ipv6/ip6_gre.c
> @@ -1498,7 +1498,8 @@ static int ip6gre_tunnel_init_common(struct net_device *dev)
>  	tunnel = netdev_priv(dev);
>  
>  	tunnel->dev = dev;
> -	tunnel->net = dev_net(dev);
> +	if (!tunnel->net)
> +		tunnel->net = dev_net(dev);

Same question as patch 5 for here and other parts.
Do we need this check and assignment ?

ip6gre_newlink_common
-> nt->net = dev_net(dev)
-> register_netdevice
  -> ndo_init / ip6gre_tunnel_init()
    -> ip6gre_tunnel_init_common
      -> tunnel->net = dev_net(dev)
