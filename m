Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24D02C021B3
	for <batman-adv@archiver.kernel.org>; Fri, 21 Feb 2025 07:56:13 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id B303A84341
	for <batman-adv@archiver.kernel.org>; Fri, 21 Feb 2025 08:56:11 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1740124571;
 b=OX1FCEWKWkrpUQXU/548RBRCgoRsO8fQZ+5VSKgAMvfDmz6XuJOGE0GefqhzKHCaHC1Bj
 0X/G4AIvAljAyAzYq0VZtuaaiokwaohaKMWAdnE2gOCD+4XiX6TzZR2QTCwb+btdB4ENDkm
 PRpTL+CjdvTrIqNEgqcjRx3/ocPATHA=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1740124571; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=tKX8JdqFzrTi/1BQO/FO5wDgGYCQeQS6PgW1/5We6so=;
 b=ldraUvxCj1NkcpOvW4byF1CVfaH6FusuJFQHcgg8mu78qHcvWpAlEnVDc2SQ4DK0hKaK+
 k29P9KFpbbj8vCFKa96p289eJGvCbj70U+EyMwvXf1P4Kj70VmoVjUkQyIyiVfCOKqsUeMC
 91fPf03CgezXx1HHNH5kPJEnCXWIOas=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=amazon.com header.i=@amazon.com;
  arc=pass;
  dmarc=none
Authentication-Results: open-mesh.org;
 dkim=pass header.d=amazon.com header.i=@amazon.com; arc=pass; dmarc=none
Received: from smtp-fw-52003.amazon.com (smtp-fw-52003.amazon.com
 [52.119.213.152])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 9D91981D57
	for <b.a.t.m.a.n@lists.open-mesh.org>; Fri, 21 Feb 2025 05:07:10 +0100 (CET)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1740110830;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=tKX8JdqFzrTi/1BQO/FO5wDgGYCQeQS6PgW1/5We6so=;
	b=LuneVrKWq+GG8fcPWh9ekgGi3KsSu56T1E95Ld9jjeMUU3AboAjQ6p9lBJvQw13QHGq06h
	wb/wwXlHQXzDuWoXDPSFvvFKSwXnkcb1c+yEcY7KkEP37dVzl0dr7CFaIp1frgPD/cFYFS
	N4Rg7oh1M0G9K8sxmnQDA4bL0H0PcTU=
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1740110830; a=rsa-sha256;
	cv=none;
	b=d2HVXvzE9OYo1YetVALmQxiQejRijr8kkKarXnAc7hmC1I+bpbEQc33VGWrGlcxKT+O67N
	mSU83sD3jSAIYIxNgdzzpNw7gU/YP0NWAIHy9n0UppPDQFkiJxi9WSKQVn7c7GSq2kpaSD
	yAMJK/T6GK8LPwXjzL06QLAaCe0p/C8=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=amazon.com header.s=amazon201209 header.b=KG6WYo3X;
	spf=pass (diktynna.open-mesh.org: domain of
 "prvs=140266d62=kuniyu@amazon.co.jp" designates 52.119.213.152 as permitted
 sender) smtp.mailfrom="prvs=140266d62=kuniyu@amazon.co.jp";
	dmarc=pass (policy=quarantine) header.from=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1740110830; x=1771646830;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=tKX8JdqFzrTi/1BQO/FO5wDgGYCQeQS6PgW1/5We6so=;
  b=KG6WYo3X10aItz4bWXmcrILgUEldv835S2sh3F7vBuXWKOtSxBhyoAFb
   GtNb3XmxJOp1G1mb6oaLDQ1LjSdbss6I3YPPvo/i1SW7EMLseL1KZabsR
   3EANeZFuzDk1oDHgrVPVSDkbNGkna+tlaMnx++FB8Yg0TXTa0CD1JcYZ7
   k=;
X-IronPort-AV: E=Sophos;i="6.13,303,1732579200";
   d="scan'208";a="67970952"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO
 smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52003.iad7.amazon.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2025 04:06:57 +0000
Received: from EX19MTAUWA002.ant.amazon.com [10.0.21.151:51376]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.55.141:2525]
 with esmtp (Farcaster)
 id fca782d6-17f8-4d01-a8eb-9a81adbd66b0;
 Fri, 21 Feb 2025 04:06:56 +0000 (UTC)
X-Farcaster-Flow-ID: fca782d6-17f8-4d01-a8eb-9a81adbd66b0
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Fri, 21 Feb 2025 04:06:55 +0000
Received: from 6c7e67bfbae3.amazon.com (10.135.209.63) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Fri, 21 Feb 2025 04:06:50 +0000
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
Subject: Re: [PATCH net-next v10 07/13] net: ipv6: Init tunnel link-netns
 before registering dev
Date: Thu, 20 Feb 2025 20:06:41 -0800
Message-ID: <20250221040641.77646-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250219125039.18024-8-shaw.leon@gmail.com>
References: <20250219125039.18024-8-shaw.leon@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.135.209.63]
X-ClientProxiedBy: EX19D043UWC004.ant.amazon.com (10.13.139.206) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)
X-MailFrom: prvs=140266d62=kuniyu@amazon.co.jp
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-0;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-1;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-2
Message-ID-Hash: MLHTGJJJCUL3EWJ77MV3GFV66RB5RQSB
X-Message-ID-Hash: MLHTGJJJCUL3EWJ77MV3GFV66RB5RQSB
X-Mailman-Approved-At: Fri, 21 Feb 2025 08:53:56 +0100
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/MLHTGJJJCUL3EWJ77MV3GFV66RB5RQSB/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

From: Xiao Liang <shaw.leon@gmail.com>
Date: Wed, 19 Feb 2025 20:50:33 +0800
> Currently some IPv6 tunnel drivers set tnl->net to dev_net(dev) in
> ndo_init(), which is called in register_netdevice(). However, it lacks
> the context of link-netns when we enable cross-net tunnels at device
> registration time.
> 
> Let's move the init of tunnel link-netns before register_netdevice().
> 
> ip6_gre has already initialized netns, so just remove the redundant
> assignment.
> 
> Signed-off-by: Xiao Liang <shaw.leon@gmail.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>

left a small comment, but not a blocker.


> @@ -1565,6 +1565,7 @@ static int ipip6_newlink(struct net_device *dev,
>  	int err;
>  
>  	nt = netdev_priv(dev);
> +	nt->net = net;

This hunk is not necessary as we'll call ipip6_tunnel_locate(),
but it's harmless and not worth reposting the whole series given
we are alredy in v10.  You can just post a follow-up patch after
the series is applied.

Thanks!
