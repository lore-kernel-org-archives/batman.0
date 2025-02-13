Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA630C021A7
	for <batman@archiver.kernel.org>; Thu, 13 Feb 2025 07:09:52 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 58FC483FE2
	for <batman@archiver.kernel.org>; Thu, 13 Feb 2025 08:09:51 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1739430591;
 b=gyZAd6UkU5UYFfZz/hnULvWIbjaIiN6ma9yZD4UI1wtSkLee++i8WFeOMFyuI+7a8nOZA
 IbzHW17RcSbHB9LSXeYxS+BRJNOrO1hJNlJVrcQAY3n9hdgKGtVx1zu/PJrZwqNYOxOYIfZ
 f4Lwx3PT1x+G6b+QpqUDHN77sQD0EVw=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1739430591; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=y0qqspgyXFQAiVZhV1is4ipJluGgHz+aCeCybrjLYs8=;
 b=HbsVMOE2euXvkXUYszPzhriOu9caQHfvtaVZSbU3h2586BUZpi7NOsXmXQLr+2FyyVxap
 qPV1kq/W01TL860akLGiRZMvNHt4MYNeSmZ/b74M2xEiNvUx5xw2w9867Z0Vlr+wObwP1+t
 HGnclEl3qulMVhU7Hq7Fysov/YAaioY=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=amazon.com header.i=@amazon.com;
  arc=pass;
  dmarc=none
Authentication-Results: open-mesh.org;
 dkim=pass header.d=amazon.com header.i=@amazon.com; arc=pass; dmarc=none
Received: from smtp-fw-80008.amazon.com (smtp-fw-80008.amazon.com
 [99.78.197.219])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 3B331817CA
	for <b.a.t.m.a.n@lists.open-mesh.org>; Thu, 13 Feb 2025 07:20:51 +0100 (CET)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1739427652;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=y0qqspgyXFQAiVZhV1is4ipJluGgHz+aCeCybrjLYs8=;
	b=ulZQv5fSJpVFM/VgkyWYCaJxLUhAMLahduAYhbxG0/9xAKnzSd+RlWBr60rV3dVuo5ARY0
	txtArEc5GAdFwMEPC8hYTxB7O3wGn8LHgJOtCp42Q3r6obU2pIEG2Lrzy1fS+IzvEUHdOH
	1Hb1w/sSiNx7bh1Ry8Au7NT1I+mR6oU=
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1739427652; a=rsa-sha256;
	cv=none;
	b=WB9RArEsSRH80em2+On+/0zKXt3kxvpj6A99FQOwn91SeReZ+WfpwnfECDA1oOR5IAiFRP
	gwsRTqNJVBrzOoS5DPOeewu5dliIvsB/Mbk/CAFJLKGMzUUukUJACNRowmhXEqJX+NQqcq
	f2X5eMX1CxKL6mWuG24igY+DHVTR3Gs=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=amazon.com header.s=amazon201209 header.b=hgy3QJpl;
	spf=pass (diktynna.open-mesh.org: domain of
 "prvs=132b843d4=kuniyu@amazon.co.jp" designates 99.78.197.219 as permitted
 sender) smtp.mailfrom="prvs=132b843d4=kuniyu@amazon.co.jp";
	dmarc=pass (policy=quarantine) header.from=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1739427652; x=1770963652;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=y0qqspgyXFQAiVZhV1is4ipJluGgHz+aCeCybrjLYs8=;
  b=hgy3QJplzrbRkfGAbiL4qIhxugyJsSMQoAcGoaRyMzHQxgF/FVBebzjS
   oSQuyS7kfguBO00zlg5T7TBQ3CyWEcZ2ZdV6WpNhDxunzHySWUqkg0tdv
   sIKasF859HJ7LmEqJpl2hUDYMGDoLVihvRWicEDMUJfi51ri7U1fQ2Dcf
   A=;
X-IronPort-AV: E=Sophos;i="6.13,282,1732579200";
   d="scan'208";a="169268254"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO
 smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-80008.pdx80.corp.amazon.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2025 06:20:49 +0000
Received: from EX19MTAUWA001.ant.amazon.com [10.0.21.151:11164]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.32.208:2525]
 with esmtp (Farcaster)
 id 6c86040e-10d2-4a2e-98fc-c45ba71a877d;
 Thu, 13 Feb 2025 06:20:48 +0000 (UTC)
X-Farcaster-Flow-ID: 6c86040e-10d2-4a2e-98fc-c45ba71a877d
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.204) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Thu, 13 Feb 2025 06:20:48 +0000
Received: from 6c7e67bfbae3.amazon.com (10.37.244.7) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Thu, 13 Feb 2025 06:20:40 +0000
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
Subject: Re: [PATCH net-next v9 05/11] net: ip_tunnel: Use link netns in
 newlink() of rtnl_link_ops
Date: Thu, 13 Feb 2025 15:20:31 +0900
Message-ID: <20250213062031.4547-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250210133002.883422-6-shaw.leon@gmail.com>
References: <20250210133002.883422-6-shaw.leon@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.37.244.7]
X-ClientProxiedBy: EX19D040UWB002.ant.amazon.com (10.13.138.89) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)
X-MailFrom: prvs=132b843d4=kuniyu@amazon.co.jp
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-0;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-1;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-2
Message-ID-Hash: BEL6K63GTM5TT3YSLLXHU6DLAJLPPHXS
X-Message-ID-Hash: BEL6K63GTM5TT3YSLLXHU6DLAJLPPHXS
X-Mailman-Approved-At: Thu, 13 Feb 2025 08:08:50 +0100
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/BEL6K63GTM5TT3YSLLXHU6DLAJLPPHXS/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

From: Xiao Liang <shaw.leon@gmail.com>
Date: Mon, 10 Feb 2025 21:29:56 +0800
> When link_net is set, use it as link netns instead of dev_net(). This
> prepares for rtnetlink core to create device in target netns directly,
> in which case the two namespaces may be different.
> 
> Convert common ip_tunnel_newlink() to accept an extra link netns
> argument. Don't overwrite ip_tunnel.net in ip_tunnel_init().

Why... ?  see a comment below.


[...]
> diff --git a/net/ipv4/ip_gre.c b/net/ipv4/ip_gre.c
> index 1fe9b13d351c..26d15f907551 100644
> --- a/net/ipv4/ip_gre.c
> +++ b/net/ipv4/ip_gre.c
> @@ -1413,7 +1413,8 @@ static int ipgre_newlink(struct net_device *dev,
>  	err = ipgre_netlink_parms(dev, data, tb, &p, &fwmark);
>  	if (err < 0)
>  		return err;
> -	return ip_tunnel_newlink(dev, tb, &p, fwmark);
> +	return ip_tunnel_newlink(params->link_net ? : dev_net(dev), dev, tb, &p,

This is duplicate at all call sites, let's move it into
ip_tunnel_newlink() by passing params.


> +				 fwmark);
>  }
>  
>  static int erspan_newlink(struct net_device *dev,
> 
> 
> diff --git a/net/ipv4/ip_tunnel.c b/net/ipv4/ip_tunnel.c
> index 09b73acf037a..618a50d5c0c2 100644
> --- a/net/ipv4/ip_tunnel.c
> +++ b/net/ipv4/ip_tunnel.c
> @@ -1213,11 +1213,11 @@ void ip_tunnel_delete_nets(struct list_head *net_list, unsigned int id,
>  }
>  EXPORT_SYMBOL_GPL(ip_tunnel_delete_nets);
>  
> -int ip_tunnel_newlink(struct net_device *dev, struct nlattr *tb[],
> -		      struct ip_tunnel_parm_kern *p, __u32 fwmark)
> +int ip_tunnel_newlink(struct net *net, struct net_device *dev,
> +		      struct nlattr *tb[], struct ip_tunnel_parm_kern *p,
> +		      __u32 fwmark)
>  {
>  	struct ip_tunnel *nt;
> -	struct net *net = dev_net(dev);
>  	struct ip_tunnel_net *itn;
>  	int mtu;
>  	int err;
> @@ -1326,7 +1326,9 @@ int ip_tunnel_init(struct net_device *dev)
>  	}
>  
>  	tunnel->dev = dev;
> -	tunnel->net = dev_net(dev);
> +	if (!tunnel->net)
> +		tunnel->net = dev_net(dev);

Isn't tunnel->net always non-NULL ?

ip_tunnel_newlink
-> netdev_priv(dev)->net = net
-> register_netdevice(dev)
  -> dev->netdev_ops->ndo_init(dev)
    -> ip_tunnel_init(dev)
      -> netdev_priv(dev)->net = dev_net(dev)
