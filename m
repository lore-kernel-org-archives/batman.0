Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C66B5C021AA
	for <batman-adv@archiver.kernel.org>; Fri, 21 Feb 2025 07:54:08 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 0B1CA841EA
	for <batman-adv@archiver.kernel.org>; Fri, 21 Feb 2025 08:54:07 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1740124447;
 b=pjMEFwwljqEgvYixne4BH6dpXw840ViONOVG7huYCUB2uaLHStf4nT8PZ6Lh0M2WcR8rD
 Ee72Tn1prMHl4IY5fBo5UdoiFsfxxyemitpvY2EFluLuS0FPJs/Y2P3nacqmjzWpyhpDkc8
 V9QR3BlyOtxjaf7B7CPrIcMQhGtj+6Q=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1740124447; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=98eKIkOj5zDaaN0aeg/8QMarn/Dvke+2ZuIrd8oeP2I=;
 b=ymDuFDyE8kn7VZR6gE1P7rINfzXmFIioJTwAgNZnzq6G0j1BBu+/3TEwdvHhIYuGQSzYo
 PPi9NfwcdHq5W4CILA/+vm4tWk9PXW0Ebs+weTXl4r5rTwiyDx/Dke0MBepH5fU5H4djVUx
 zipHpbXoUZaq15EDSQJFfvsg5XuASDE=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=amazon.com header.i=@amazon.com;
  arc=pass;
  dmarc=none
Authentication-Results: open-mesh.org;
 dkim=pass header.d=amazon.com header.i=@amazon.com; arc=pass; dmarc=none
Received: from smtp-fw-80008.amazon.com (smtp-fw-80008.amazon.com
 [99.78.197.219])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id DD67E81E99
	for <b.a.t.m.a.n@lists.open-mesh.org>; Fri, 21 Feb 2025 04:25:14 +0100 (CET)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1740108315;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=98eKIkOj5zDaaN0aeg/8QMarn/Dvke+2ZuIrd8oeP2I=;
	b=rpKiXCfhryK1rqvT1T6pZS0MNZye6wp9Smj2IW6VW5j3XVxyR5n+RgSRY4yMevXU3/MhqC
	M9cTXd8qiErzKldriAOTIHM3wOYFtHFpcCNMvrTf+ZJGeN2+fj+FA63iCKfWJ+R4qjX2ra
	1xwaCWSFRD4KejyviLMC6jT1/WrtDjM=
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1740108315; a=rsa-sha256;
	cv=none;
	b=eL/HhqfBrfJ2WLWQKO3fCVa9XJJ0BPIOLsl3W1w/NeIKDJSpBe5eNvXI5RkWyVzhOT7oWU
	WfwiszBIFO6MzKTV2Tj4+yA1QqF1I4bGDrB7h6ja5kl4f7AfuKMlrNwmbWTZzpnPfKhrzj
	Zo+3rAekgJacfQcruL2877ioiUJLvoI=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=amazon.com header.s=amazon201209 header.b=o59W6x+p;
	spf=pass (diktynna.open-mesh.org: domain of
 "prvs=140266d62=kuniyu@amazon.co.jp" designates 99.78.197.219 as permitted
 sender) smtp.mailfrom="prvs=140266d62=kuniyu@amazon.co.jp";
	dmarc=pass (policy=quarantine) header.from=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1740108315; x=1771644315;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=98eKIkOj5zDaaN0aeg/8QMarn/Dvke+2ZuIrd8oeP2I=;
  b=o59W6x+pXlzlKsinrjFJntBl7F8jVzawqzXLo68S09Mh89s25Eadgd/F
   uVq8A2CkeGl/4N6MXU9BTsEccyQoK2fUzmb3EGcBf03Hmbp020NwPI4aA
   ToZSn35Blr9IoGaaOH1wvvDA2JmtrIEGFAqeuo9wYivnw+0lYQphEOm4j
   4=;
X-IronPort-AV: E=Sophos;i="6.13,303,1732579200";
   d="scan'208";a="171680556"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO
 smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-80008.pdx80.corp.amazon.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2025 03:25:09 +0000
Received: from EX19MTAUWC001.ant.amazon.com [10.0.7.35:29611]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.34.181:2525]
 with esmtp (Farcaster)
 id 878d6712-a911-4454-a3d1-f12dc573cc97;
 Fri, 21 Feb 2025 03:25:09 +0000 (UTC)
X-Farcaster-Flow-ID: 878d6712-a911-4454-a3d1-f12dc573cc97
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Fri, 21 Feb 2025 03:25:04 +0000
Received: from 6c7e67bfbae3.amazon.com (10.135.209.63) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Fri, 21 Feb 2025 03:24:58 +0000
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
Subject: Re: [PATCH net-next v10 02/13] rtnetlink: Pack newlink() params into
 struct
Date: Thu, 20 Feb 2025 19:24:49 -0800
Message-ID: <20250221032449.73597-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250219125039.18024-3-shaw.leon@gmail.com>
References: <20250219125039.18024-3-shaw.leon@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.135.209.63]
X-ClientProxiedBy: EX19D033UWC004.ant.amazon.com (10.13.139.225) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)
X-MailFrom: prvs=140266d62=kuniyu@amazon.co.jp
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-0;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-1;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-2
Message-ID-Hash: BFLSQDBRARTNTK77VG4SLK4FR2VXZBW6
X-Message-ID-Hash: BFLSQDBRARTNTK77VG4SLK4FR2VXZBW6
X-Mailman-Approved-At: Fri, 21 Feb 2025 08:53:55 +0100
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/BFLSQDBRARTNTK77VG4SLK4FR2VXZBW6/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

From: Xiao Liang <shaw.leon@gmail.com>
Date: Wed, 19 Feb 2025 20:50:28 +0800
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
> To provide more netns context for drivers, this patch packs existing
> newlink() parameters, along with the source netns, link netns and peer
> netns, into a struct. The old "src_net" is renamed to "net" to avoid
> confusion with real source netns, and will be deprecated later. The use
> of src_net are converted to params->net trivially.
> 
> Signed-off-by: Xiao Liang <shaw.leon@gmail.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>
