Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78D4FC0219D
	for <batman@archiver.kernel.org>; Thu, 13 Feb 2025 12:18:32 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id C4E648420D
	for <batman@archiver.kernel.org>; Thu, 13 Feb 2025 13:18:30 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1739449110;
 b=KY8HRmVWmNuFtqNATJLr9v7qEgbL52h+2vwYhWg9ywK2ek95g2Yrpu/iGiL6z20ZIbfCT
 62E5FHyYjN1wjMqmBC7Y0iLzrVS5xdPBDq8OFR3aKmnsFOHG69pEpCLW0ka+jMyr8/n0us1
 6lnFzyF7lwcvY4OGh+MFsFdsRZHdAqc=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1739449110; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=x6a76+cOw96XPtQyXhpo63qOZBEMTvYTLb5LP/CLpRQ=;
 b=iIVUAdUrNPR39Ytg0abZlYbsQztCiHNRls3TCOAxViYc8GF9GU/msmsWH2hL+cXTiCbW/
 ZpcLCFLtUtPonhPrBJoZw/YFog24ptHNw620mL6t1MbXUATZl5nBMWdulxFnhf5Q6lQEx4M
 bTOo8+4qY4sK3KmWcbGXtL/iYnX56gg=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=amazon.com header.i=@amazon.com;
  arc=pass;
  dmarc=none
Authentication-Results: open-mesh.org;
 dkim=pass header.d=amazon.com header.i=@amazon.com; arc=pass; dmarc=none
Received: from smtp-fw-52004.amazon.com (smtp-fw-52004.amazon.com
 [52.119.213.154])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id E84EA83E06
	for <b.a.t.m.a.n@lists.open-mesh.org>; Thu, 13 Feb 2025 12:00:28 +0100 (CET)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1739444429;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=x6a76+cOw96XPtQyXhpo63qOZBEMTvYTLb5LP/CLpRQ=;
	b=0CTq66CDcbfjpiqJWzaKNnyaCSmSagv8vLIdXFRzSjhP23+/Ojs1gC0Cb3keDpV5y17Stg
	4odcikUPjSLFRwkd9NQuzzNkQsYC+jF4ikmIEwJAAXrlpx1lA90+UdRpCPvQqpU5ZPq0Rf
	Da4ZFXbqf+19PWGbnB3w3xVc1rYUL1A=
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1739444429; a=rsa-sha256;
	cv=none;
	b=DbedEv9M5C5QOj8KKrFC45EdyVCOX1SAdVrFAYp2jrX/rArmvm1PhwxsQxs61EDMNev80N
	acCtF9z3YsRnOOnsVYGQq9SJN9bnVtxdt1wiaG7xdzpiSpuk6jV0ILGQy+jifHO0rDn9kS
	90j9QLRFyMxcEwhfvjaalE0vdflIdFw=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=amazon.com header.s=amazon201209 header.b="R82/HQrL";
	spf=pass (diktynna.open-mesh.org: domain of
 "prvs=132b843d4=kuniyu@amazon.co.jp" designates 52.119.213.154 as permitted
 sender) smtp.mailfrom="prvs=132b843d4=kuniyu@amazon.co.jp";
	dmarc=pass (policy=quarantine) header.from=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1739444429; x=1770980429;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=x6a76+cOw96XPtQyXhpo63qOZBEMTvYTLb5LP/CLpRQ=;
  b=R82/HQrLtUh6W51x1swIKV0mPrQMJaL8zVH9ZYQp4GwboTBhKjIVMTdk
   /a5p6ASKj8NymuXJnrOLcJoKek21ha1Qn9YC1HTPyRoJuwI4swY61IQog
   4DIIufDIxzvRst0ACMlRGzKUXLRS5wHM60b+wEF8EEYYD1Z+eqq6QtrCX
   0=;
X-IronPort-AV: E=Sophos;i="6.13,282,1732579200";
   d="scan'208";a="270835605"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO
 smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.2])
  by smtp-border-fw-52004.iad7.amazon.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2025 11:00:25 +0000
Received: from EX19MTAUWC001.ant.amazon.com [10.0.21.151:61563]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.32.208:2525]
 with esmtp (Farcaster)
 id 84cbae71-03ca-491c-8392-66d89dbb8c97;
 Thu, 13 Feb 2025 11:00:24 +0000 (UTC)
X-Farcaster-Flow-ID: 84cbae71-03ca-491c-8392-66d89dbb8c97
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Thu, 13 Feb 2025 11:00:24 +0000
Received: from 6c7e67bfbae3.amazon.com (10.37.244.7) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Thu, 13 Feb 2025 11:00:14 +0000
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
Date: Thu, 13 Feb 2025 20:00:04 +0900
Message-ID: <20250213110004.38415-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: 
 <CABAhCORgi7Jqu=Aigs6Fc8ewG5OshFvcunye03R43C+Z0ojZyw@mail.gmail.com>
References: 
 <CABAhCORgi7Jqu=Aigs6Fc8ewG5OshFvcunye03R43C+Z0ojZyw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.37.244.7]
X-ClientProxiedBy: EX19D040UWA003.ant.amazon.com (10.13.139.6) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)
X-MailFrom: prvs=132b843d4=kuniyu@amazon.co.jp
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-0;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-1;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-2
Message-ID-Hash: 6BCLRJNPGTL2A6MCTE62GOOEQXBEPEP2
X-Message-ID-Hash: 6BCLRJNPGTL2A6MCTE62GOOEQXBEPEP2
X-Mailman-Approved-At: Thu, 13 Feb 2025 13:18:12 +0100
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/6BCLRJNPGTL2A6MCTE62GOOEQXBEPEP2/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

From: Xiao Liang <shaw.leon@gmail.com>
Date: Thu, 13 Feb 2025 17:55:32 +0800
> On Thu, Feb 13, 2025 at 4:37 PM Xiao Liang <shaw.leon@gmail.com> wrote:
> >
> > On Thu, Feb 13, 2025 at 3:05 PM Kuniyuki Iwashima <kuniyu@amazon.com> wrote:
> > >
> > [...]
> > > > diff --git a/net/ipv6/ip6_gre.c b/net/ipv6/ip6_gre.c
> > > > index 863852abe8ea..108600dc716f 100644
> > > > --- a/net/ipv6/ip6_gre.c
> > > > +++ b/net/ipv6/ip6_gre.c
> > > > @@ -1498,7 +1498,8 @@ static int ip6gre_tunnel_init_common(struct net_device *dev)
> > > >       tunnel = netdev_priv(dev);
> > > >
> > > >       tunnel->dev = dev;
> > > > -     tunnel->net = dev_net(dev);
> > > > +     if (!tunnel->net)
> > > > +             tunnel->net = dev_net(dev);
> > >
> > > Same question as patch 5 for here and other parts.
> > > Do we need this check and assignment ?
> > >
> > > ip6gre_newlink_common
> > > -> nt->net = dev_net(dev)
> > > -> register_netdevice
> > >   -> ndo_init / ip6gre_tunnel_init()
> > >     -> ip6gre_tunnel_init_common
> > >       -> tunnel->net = dev_net(dev)
> >
> > Will remove this line.
> 
> However, fb tunnel of ip6_tunnel, ip6_vti and sit can have
> tunnel->net == NULL here. Take ip6_tunnel for example:
> 
> ip6_tnl_init_net()
>     -> ip6_fb_tnl_dev_init()
>     -> register_netdev()
>         -> register_netdevice()
>             -> ip6_tnl_dev_init()
> 
> This code path (including ip6_fb_tnl_dev_init()) doesn't set
> tunnel->net. But for ip6_gre, ip6gre_fb_tunnel_init() does.

Ah, okay.  Then, let's set net in a single place, which would
be better than spreading net assignment and adding null check
in ->ndo_init(), and maybe apply the same to IPv4 tunnels ?
