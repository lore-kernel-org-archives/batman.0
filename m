Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26FF7C021A7
	for <batman@archiver.kernel.org>; Thu, 13 Feb 2025 07:09:09 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 5BB23840F0
	for <batman@archiver.kernel.org>; Thu, 13 Feb 2025 08:09:08 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1739430548;
 b=HdFedbPDGqb5FEu3wtYpti09/lLekaHcrSJWcDcpW7qwp+57RM8QOQViy4zA5fBQU9pPb
 r0hISRwz6UuZOoiItDl886hCYp1ViurSmc8u3KVM2W3C9ds1hH93y+JJlEmYW3CbCi0YPtn
 krF4qBUYEiXnOuDTCfeRnoBReu0ed8c=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1739430548; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=2H6L2IVdEyIK/cEvvFHgSWxdXbDY3pM4JrV+qKQ3oRc=;
 b=oGms5ZCZ9QRXN23IY1tOZZalDO+RGiRcQz08dPHXMdzY/86wI1m/k7CPdhjcwNFp5DHtP
 giRMmZP7eGSh9/OXNGrGs/CTCf3+loAFtcV1Lrloc0MCRJckoBttOTNdOANr7hXPZuc96uW
 haek3QP8yTSH0A+WQHYaUM4GMTGYJP8=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=amazon.com header.i=@amazon.com;
  arc=pass;
  dmarc=none
Authentication-Results: open-mesh.org;
 dkim=pass header.d=amazon.com header.i=@amazon.com; arc=pass; dmarc=none
Received: from smtp-fw-6002.amazon.com (smtp-fw-6002.amazon.com [52.95.49.90])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 9CE5F80E41
	for <b.a.t.m.a.n@lists.open-mesh.org>; Thu, 13 Feb 2025 06:49:18 +0100 (CET)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1739425759;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=2H6L2IVdEyIK/cEvvFHgSWxdXbDY3pM4JrV+qKQ3oRc=;
	b=JwjMKtd6skPRJ1vfrm8D0tiThbdz2WehnDAuzGRyRLENiFFp6EUqTOKVZ6Zu6T38bIrw7t
	54JAS0ce4bFEd5bp4dHIi/m6X1V0b2e+Vz1ma8J6pngwc+L/SfaIxvRxx7Q6dgbAKeeax6
	j35BaXWkgh2sNZg3z9ULpsuxyGMJQDY=
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1739425759; a=rsa-sha256;
	cv=none;
	b=CrMX8rNesGRxQAKOMfl2PMGrUWIzbqSpgBibhdToFgf2gJMTv+FVWD5x2NgTzvGJESL7og
	3ouFCww66sjEvQvMle0XoSmICEwk4thKrY0kaQETYuepy9sN4U48gvt/ee1Th8Rxdadg81
	kosjZk7T2MCgPVJRdkJ/72kkQsURzQU=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=amazon.com header.s=amazon201209 header.b=tfevQMuh;
	spf=pass (diktynna.open-mesh.org: domain of
 "prvs=132b843d4=kuniyu@amazon.co.jp" designates 52.95.49.90 as permitted
 sender) smtp.mailfrom="prvs=132b843d4=kuniyu@amazon.co.jp";
	dmarc=pass (policy=quarantine) header.from=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1739425759; x=1770961759;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2H6L2IVdEyIK/cEvvFHgSWxdXbDY3pM4JrV+qKQ3oRc=;
  b=tfevQMuhUgtCb9dkBIA+Mge0MmoryFBT4daPY6PSB3V76P/zAMVpBQNR
   DuO6OEBG47UC0exqxtCw385IMR07qe2YLmXE2cvkiBoVKorPDetyi0Kpm
   tPnM7Ye4ETznKun7zT7Ntu/oDYN3iwPKXgbZ6RVPnThsH10RVyrbsvh5p
   k=;
X-IronPort-AV: E=Sophos;i="6.13,282,1732579200";
   d="scan'208";a="471752672"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO
 smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-6002.iad6.amazon.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2025 05:49:13 +0000
Received: from EX19MTAUWB001.ant.amazon.com [10.0.38.20:24405]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.23.136:2525]
 with esmtp (Farcaster)
 id 4661396c-a15f-4263-9318-13d4ea54af5c;
 Thu, 13 Feb 2025 05:49:12 +0000 (UTC)
X-Farcaster-Flow-ID: 4661396c-a15f-4263-9318-13d4ea54af5c
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Thu, 13 Feb 2025 05:49:12 +0000
Received: from 6c7e67bfbae3.amazon.com (10.37.244.7) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Thu, 13 Feb 2025 05:49:03 +0000
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
Subject: Re: [PATCH net-next v9 04/11] ieee802154: 6lowpan: Validate link
 netns in newlink() of rtnl_link_ops
Date: Thu, 13 Feb 2025 14:48:53 +0900
Message-ID: <20250213054853.285-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250210133002.883422-5-shaw.leon@gmail.com>
References: <20250210133002.883422-5-shaw.leon@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.37.244.7]
X-ClientProxiedBy: EX19D035UWA004.ant.amazon.com (10.13.139.109) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)
X-MailFrom: prvs=132b843d4=kuniyu@amazon.co.jp
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-0;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-1;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-2
Message-ID-Hash: AGEXPPXGGDVLHLAIN4TR2GTIQVTL7YVE
X-Message-ID-Hash: AGEXPPXGGDVLHLAIN4TR2GTIQVTL7YVE
X-Mailman-Approved-At: Thu, 13 Feb 2025 08:08:50 +0100
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/AGEXPPXGGDVLHLAIN4TR2GTIQVTL7YVE/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

From: Xiao Liang <shaw.leon@gmail.com>
Date: Mon, 10 Feb 2025 21:29:55 +0800
> Device denoted by IFLA_LINK is in link_net (IFLA_LINK_NETNSID) or
> source netns by design, but 6lowpan uses dev_net.
> 
> Note dev->netns_local is set to true and currently link_net is
> implemented via a netns change. These together effectively reject
> IFLA_LINK_NETNSID.
> 
> This patch adds a validation to ensure link_net is either NULL or
> identical to dev_net. Thus it would be fine to continue using dev_net
> when rtnetlink core begins to create devices directly in target netns.
> 
> Signed-off-by: Xiao Liang <shaw.leon@gmail.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>
