Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F370C021A8
	for <batman@archiver.kernel.org>; Thu, 13 Feb 2025 07:10:46 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id C88F684265
	for <batman@archiver.kernel.org>; Thu, 13 Feb 2025 08:10:44 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1739430644;
 b=U538i3IE3hGQrKpx5/wLLMiuYvSBGzCZ3/3gFSfi4bWnaaQw97/IepSETdEdZUPTjLGEn
 PXZ+UK5u/3mdr6UKELM+44UIpDi1rQv9jHPlUEV4OVk5U55M+xfIotPSUnerp76gH3KxhWq
 g/mTuSIfSs7P5JDzcEQ1+DokGdOVh5k=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1739430644; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=vJk+OOP08wb+BW+/huJFBkOKxAdi/eEFURshZRzHTxA=;
 b=Z9SVeUfKBq3PifMrGNRLvkLlArGsAOCTFPZ9BFbRyXoTyhLlXyepgUg00Qf5UDlRDl4hA
 QUM8B7sOamrtVwAd50WzwdWzcAnEY4biAfPn6o1BneU3744kjtQobfX2AhhKTDFbKz1kyP9
 xhLNxSWA4XqJAtrbNca8GhvqbfdarLo=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=amazon.com header.i=@amazon.com;
  arc=pass;
  dmarc=none
Authentication-Results: open-mesh.org;
 dkim=pass header.d=amazon.com header.i=@amazon.com; arc=pass; dmarc=none
Received: from smtp-fw-80006.amazon.com (smtp-fw-80006.amazon.com
 [99.78.197.217])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id D20DC81B88
	for <b.a.t.m.a.n@lists.open-mesh.org>; Thu, 13 Feb 2025 07:54:20 +0100 (CET)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1739429661;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=vJk+OOP08wb+BW+/huJFBkOKxAdi/eEFURshZRzHTxA=;
	b=ptHMMj8iQz2luuDrnK/hNnNQqYFbMIt7DFrO25B/HVqPRZVn8Iq1XMnZjgxV96rOALMQgp
	dhs1JYZbYjXicdYs96UrhIl9sdBKiV3HocSx+x38drRKnyxnUdETJgNBFuJwws6bwXAIjM
	Z03PNAObRjmjGpMFxMPQluBItOoBxfg=
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1739429661; a=rsa-sha256;
	cv=none;
	b=RxJPBxRsbKdiRH7Y6YsmmNFkW46IWq2ZS2TldLvmmfBjtEaP9H9vMkIyUhZp1qkjeoy25d
	gX+PahZfvzOgvtP9rx59jljQk4y+vWSMYqaCGYhcYYWYWopXxqfI9dNmb/CzAlEGvo5Iqd
	Pe9s28vvgOpx2R8XSdDEbaSYV0heFz0=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=amazon.com header.s=amazon201209 header.b=sDMoFXu6;
	spf=pass (diktynna.open-mesh.org: domain of
 "prvs=132b843d4=kuniyu@amazon.co.jp" designates 99.78.197.217 as permitted
 sender) smtp.mailfrom="prvs=132b843d4=kuniyu@amazon.co.jp";
	dmarc=pass (policy=quarantine) header.from=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1739429661; x=1770965661;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=vJk+OOP08wb+BW+/huJFBkOKxAdi/eEFURshZRzHTxA=;
  b=sDMoFXu6aPvsQCllTNWOpMgaTHoH9b4R33FpQJ90SobeOOPpYzs9nLm0
   oRXrtqrOQRcE2tcQ1Kp1w+35OzlNv6h4gpJS8MOH1RtyxirGKZ/2UJVqu
   X+V7TjNyWwrh1+bk7HyfAaig6Dhzd8l342gzP4y12dJ3k9PisCz+7c3Ky
   c=;
X-IronPort-AV: E=Sophos;i="6.13,282,1732579200";
   d="scan'208";a="22171230"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO
 smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-80006.pdx80.corp.amazon.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2025 06:54:17 +0000
Received: from EX19MTAUWA002.ant.amazon.com [10.0.38.20:56641]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.32.208:2525]
 with esmtp (Farcaster)
 id d7a2dd72-4afe-411d-a503-05d091406983;
 Thu, 13 Feb 2025 06:54:17 +0000 (UTC)
X-Farcaster-Flow-ID: d7a2dd72-4afe-411d-a503-05d091406983
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Thu, 13 Feb 2025 06:54:10 +0000
Received: from 6c7e67bfbae3.amazon.com (10.37.244.7) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Thu, 13 Feb 2025 06:54:01 +0000
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
Subject: Re: [PATCH net-next v9 02/11] rtnetlink: Pack newlink() params into
 struct
Date: Thu, 13 Feb 2025 15:53:48 +0900
Message-ID: <20250213065348.8507-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250210133002.883422-3-shaw.leon@gmail.com>
References: <20250210133002.883422-3-shaw.leon@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.37.244.7]
X-ClientProxiedBy: EX19D031UWC003.ant.amazon.com (10.13.139.252) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)
X-MailFrom: prvs=132b843d4=kuniyu@amazon.co.jp
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-0;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-1;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-2
Message-ID-Hash: C6FFX6YPJL7MTQJNA2ZUWA4KLR3CS47I
X-Message-ID-Hash: C6FFX6YPJL7MTQJNA2ZUWA4KLR3CS47I
X-Mailman-Approved-At: Thu, 13 Feb 2025 08:08:50 +0100
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/C6FFX6YPJL7MTQJNA2ZUWA4KLR3CS47I/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

From: Xiao Liang <shaw.leon@gmail.com>
Date: Mon, 10 Feb 2025 21:29:53 +0800
> There are 4 net namespaces involved when creating links:
> 
>  - source netns - where the netlink socket resides,
>  - target netns - where to put the device being created,
>  - link netns - netns associated with the device (backend),
>  - peer netns - netns of peer device.
> 
> Currently, two nets are passed to newlink() callback - "src_net"
> parameter and "dev_net" (implicitly in net_device). They are set as
> follows, depending on netlink attributes in the request.
> 
>  +------------+-------------------+---------+---------+
>  | peer netns | IFLA_LINK_NETNSID | src_net | dev_net |
>  +------------+-------------------+---------+---------+
>  |            | absent            | source  | target  |
>  | absent     +-------------------+---------+---------+
>  |            | present           | link    | link    |
>  +------------+-------------------+---------+---------+
>  |            | absent            | peer    | target  |
>  | present    +-------------------+---------+---------+
>  |            | present           | peer    | link    |
>  +------------+-------------------+---------+---------+
> 
> When IFLA_LINK_NETNSID is present, the device is created in link netns
> first and then moved to target netns. This has some side effects,
> including extra ifindex allocation, ifname validation and link events.
> These could be avoided if we create it in target netns from
> the beginning.
> 
> On the other hand, the meaning of src_net parameter is ambiguous. It
> varies depending on how parameters are passed. It is the effective
> link (or peer netns) by design, but some drivers ignore it and use
> dev_net instead.
> 
> This patch packs existing newlink() parameters, along with the source
> netns, link netns and peer netns, into a struct. The old "src_net"
> is renamed to "net" to avoid confusion with real source netns, and
> will be deprecated later. The use of src_net are converted to
> params->net trivially.
> 
> To make the semantics more clear, two helper functions -
> rtnl_newlink_link_net() and rtnl_newlink_peer_net() - are provided
> for netns fallback logic. Peer netns falls back to link netns, and
> link netns falls back to source netns.
> 
> In following patches, to prepare for creating link in target netns
> directly:
> 
>   - For device drivers that are aware of the old "src_net", the use of
>     it are replace with one of the two helper functions.
>   - And for those that takes dev_net() as link netns, we try
>     params->link_net and then dev_net(), in order to maintain
>     compatibility with the old behavior.
> 
> Signed-off-by: Xiao Liang <shaw.leon@gmail.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>

I left small comments below.


[...]
> diff --git a/include/linux/if_macvlan.h b/include/linux/if_macvlan.h
> index 523025106a64..0f7281e3e448 100644
> --- a/include/linux/if_macvlan.h
> +++ b/include/linux/if_macvlan.h
> @@ -59,8 +59,10 @@ static inline void macvlan_count_rx(const struct macvlan_dev *vlan,
>  
>  extern void macvlan_common_setup(struct net_device *dev);
>  
> -extern int macvlan_common_newlink(struct net *src_net, struct net_device *dev,
> -				  struct nlattr *tb[], struct nlattr *data[],
> +struct rtnl_newlink_params;

You can just include <net/rtnetlink.h> and remove it from .c
files, then this forward declaration will be unnecessary.


> +
> +extern int macvlan_common_newlink(struct net_device *dev,
> +				  struct rtnl_newlink_params *params,
>  				  struct netlink_ext_ack *extack);
>  
>  extern void macvlan_dellink(struct net_device *dev, struct list_head *head);


[...]
> diff --git a/include/net/rtnetlink.h b/include/net/rtnetlink.h
> index bc0069a8b6ea..00c086ca0c11 100644
> --- a/include/net/rtnetlink.h
> +++ b/include/net/rtnetlink.h
> @@ -69,6 +69,42 @@ static inline int rtnl_msg_family(const struct nlmsghdr *nlh)
>  		return AF_UNSPEC;
>  }
>  
> +/**
> + *	struct rtnl_newlink_params - parameters of rtnl_link_ops::newlink()

The '\t' after '*' should be single '\s'.

Same for lines below.


> + *
> + *	@net: Netns of interest
> + *	@src_net: Source netns of rtnetlink socket
> + *	@link_net: Link netns by IFLA_LINK_NETNSID, NULL if not specified
> + *	@peer_net: Peer netns
> + *	@tb: IFLA_* attributes
> + *	@data: IFLA_INFO_DATA attributes
> + */
> +struct rtnl_newlink_params {

[...]
> +/* Get effective link netns from newlink params. Generally, this is link_net
> + * and falls back to src_net. But for compatibility, a driver may * choose to
> + * use dev_net(dev) instead.
> + */
> +static inline struct net *rtnl_newlink_link_net(struct rtnl_newlink_params *p)
> +{
> +	return p->link_net ? : p->src_net;
> +}
> +
> +/* Get peer netns from newlink params. Fallback to link netns if peer netns is
> + * not specified explicitly.
> + */
> +static inline struct net *rtnl_newlink_peer_net(struct rtnl_newlink_params *p)
> +{
> +	return p->peer_net ? : rtnl_newlink_link_net(p);
> +}

These helpers should belong to patch 2 ?
