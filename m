Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC3EEC021A7
	for <batman@archiver.kernel.org>; Thu, 13 Feb 2025 07:11:39 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 8417084307
	for <batman@archiver.kernel.org>; Thu, 13 Feb 2025 08:11:38 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1739430698;
 b=i6t3lgglje7qAz3rJ3HusPuJF18ITYEX2wnpXqI/Yvw6NX+2N9ROF2MjZR5n7owT2Bfpj
 AMwsMjSFzka3Wy/o/e5lPlXUEF0uzGiFTnG1SqnJyidRtDgkoNf26YN5TLaniYE1CP88IBv
 hSeFVJmCfJSkglYqSX1LMbSpqmne6rA=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1739430698; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=Y6vhqwcHgjQ9crHQuKcOHH1ChdkHGoRglO+wy/6/WSQ=;
 b=H0vmryyw13Vl88dJtEtx+29u31mDokzCQ0zj7R+zrsiEGRiMdQfJU6gjOH+6GLpGstoIi
 tpwLjW0Q8ncAeWNauUFW6dE9g6g/m06TepI9JzOD/dAxSBP4bt8D3159e0PngjKqGEXcnB1
 StDEDT3I3iE6xccbg6vICxvyLqnxBvE=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=amazon.com header.i=@amazon.com;
  arc=pass;
  dmarc=none
Authentication-Results: open-mesh.org;
 dkim=pass header.d=amazon.com header.i=@amazon.com; arc=pass; dmarc=none
Received: from smtp-fw-52004.amazon.com (smtp-fw-52004.amazon.com
 [52.119.213.154])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 9F17A81741
	for <b.a.t.m.a.n@lists.open-mesh.org>; Thu, 13 Feb 2025 07:55:31 +0100 (CET)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1739429731;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=Y6vhqwcHgjQ9crHQuKcOHH1ChdkHGoRglO+wy/6/WSQ=;
	b=NQ0StIeCnLj2CBFvVx0kE2MBib3tZVCbdQmWbydHBTkYOCPeFkVUTMkYAJ+S+0Ck0qXK9S
	MP9NGLD1I5YvD66RlB7NjvANfbXF10adgcTuzalh8Uryg/Iy5wBN4la3vWLNNwUAImOGpP
	k0lEAzhhuvpvoS2a3O6LT1wSBnVKDhc=
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1739429731; a=rsa-sha256;
	cv=none;
	b=IfRdtCRYB3pH880Fj1ifh6LVeV9x7eZoIYkCVfe2ZstYrueFVcq2wxsWeGrbFOEoqwpJxQ
	PG3p7WVE5bEB0hpvdVQSIUY7q6quLriA479RkPCyk1RSZbZNeLD1xCvzdJPWlO4+Ni0Ohe
	kGO//OFmrd/shtApGftY0KPmuKsy3/0=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=amazon.com header.s=amazon201209 header.b=BRoMzwdc;
	spf=pass (diktynna.open-mesh.org: domain of
 "prvs=132b843d4=kuniyu@amazon.co.jp" designates 52.119.213.154 as permitted
 sender) smtp.mailfrom="prvs=132b843d4=kuniyu@amazon.co.jp";
	dmarc=pass (policy=quarantine) header.from=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1739429732; x=1770965732;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Y6vhqwcHgjQ9crHQuKcOHH1ChdkHGoRglO+wy/6/WSQ=;
  b=BRoMzwdc+AnxqWgne0up9L8FJBjQaVL9uR+IbjaLD3JwayzTK+RILbcW
   LXAnW8tEsY+3NLzvY5Gim7wBX/ALwZG4a6bCQa5YVaMXtw+QAfiaUayYU
   B0lslLmJOpdfzpSPbCe3CmXg8JZjeoksQgR+5+SMwJ16I3xLRaJarQYwJ
   s=;
X-IronPort-AV: E=Sophos;i="6.13,282,1732579200";
   d="scan'208";a="270777830"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO
 smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.2])
  by smtp-border-fw-52004.iad7.amazon.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2025 06:55:26 +0000
Received: from EX19MTAUWB001.ant.amazon.com [10.0.21.151:9280]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.23.246:2525]
 with esmtp (Farcaster)
 id 0c153c97-2bf1-4a6b-942d-4cbd218ce4f6;
 Thu, 13 Feb 2025 06:55:25 +0000 (UTC)
X-Farcaster-Flow-ID: 0c153c97-2bf1-4a6b-942d-4cbd218ce4f6
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Thu, 13 Feb 2025 06:55:24 +0000
Received: from 6c7e67bfbae3.amazon.com (10.37.244.7) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Thu, 13 Feb 2025 06:55:16 +0000
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
Subject: Re: [PATCH net-next v9 03/11] net: Use link netns in newlink() of
 rtnl_link_ops
Date: Thu, 13 Feb 2025 15:55:06 +0900
Message-ID: <20250213065506.8720-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250210133002.883422-4-shaw.leon@gmail.com>
References: <20250210133002.883422-4-shaw.leon@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.37.244.7]
X-ClientProxiedBy: EX19D038UWC003.ant.amazon.com (10.13.139.209) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)
X-MailFrom: prvs=132b843d4=kuniyu@amazon.co.jp
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-0;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-1;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-2
Message-ID-Hash: OGINX5BGNZXU57LUYYRBUFQFGYQ6ABEN
X-Message-ID-Hash: OGINX5BGNZXU57LUYYRBUFQFGYQ6ABEN
X-Mailman-Approved-At: Thu, 13 Feb 2025 08:08:50 +0100
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/OGINX5BGNZXU57LUYYRBUFQFGYQ6ABEN/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

From: Xiao Liang <shaw.leon@gmail.com>
Date: Mon, 10 Feb 2025 21:29:54 +0800
> These netdevice drivers already uses netns parameter in newlink()
> callback. Convert them to use rtnl_newlink_link_net() or
> rtnl_newlink_peer_net() for clarity and deprecate params->net.
> 
> Signed-off-by: Xiao Liang <shaw.leon@gmail.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>


> diff --git a/drivers/net/ethernet/qualcomm/rmnet/rmnet_config.c b/drivers/net/ethernet/qualcomm/rmnet/rmnet_config.c
> index 8151e91395e2..ab7e5b6649b2 100644
> --- a/drivers/net/ethernet/qualcomm/rmnet/rmnet_config.c
> +++ b/drivers/net/ethernet/qualcomm/rmnet/rmnet_config.c
> @@ -122,8 +122,8 @@ static int rmnet_newlink(struct net_device *dev,
>  			 struct netlink_ext_ack *extack)
>  {
>  	u32 data_format = RMNET_FLAGS_INGRESS_DEAGGREGATION;
> +	struct net *link_net = rtnl_newlink_link_net(params);

nit: reverse xmas tree


>  	struct nlattr **data = params->data;
> -	struct net *src_net = params->net;
>  	struct nlattr **tb = params->tb;
>  	struct net_device *real_dev;
>  	int mode = RMNET_EPMODE_VND;
