Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCAB8E77188
	for <batman-adv@archiver.kernel.org>; Tue, 14 Jan 2025 08:14:58 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 1544B83D07
	for <batman-adv@archiver.kernel.org>; Tue, 14 Jan 2025 09:14:57 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1736842497;
 b=dvMeYSyGfGajajWx4bgFtN5gBQ6dd/aNzxfKyxBJYpxNVlJNkz/DiHboDE5fpfp48Iqw/
 sJNuycfreRMWlkmVuNyf74lIuTb3RAfX4SYUDa2L4cyQ7vN8zrG3HBIMwo8MsXS2JQfhgmQ
 VQf0D1r75B7JjbR0S9GHzwczZ424Pcw=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1736842497; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=0cedPuJPQkStIGe+OXyB1F52+EDOiClOdRu6CBFc8ew=;
 b=P8WAe0xSaaamhdT/ko4E5j6JGHWmCirsblreNH+4n2WF/R+JF/X5rGvh6sVuC9cx+qngv
 THj3eRvAB1AHR2mVyrN9F6LOnEMrTC19wzf3cEMmcJd8K+TvrK0Jb4n4hxhFxRyRve23m/c
 +nkNTqRxmXsx1hYkF7hCzJbp3cRlAHc=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=amazon.com header.i=@amazon.com;
  arc=pass;
  dmarc=none
Authentication-Results: open-mesh.org;
 dkim=pass header.d=amazon.com header.i=@amazon.com; arc=pass; dmarc=none
Received: from smtp-fw-2101.amazon.com (smtp-fw-2101.amazon.com
 [72.21.196.25])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 8A46981D84
	for <b.a.t.m.a.n@lists.open-mesh.org>; Tue, 14 Jan 2025 02:39:33 +0100 (CET)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1736818773;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=0cedPuJPQkStIGe+OXyB1F52+EDOiClOdRu6CBFc8ew=;
	b=EqcSvtJpCPybI9x2hXBB5m2yTASPQT4bnxdDksMZyNgU/KGpqNw6trttewiMguwnSsxN6X
	T7qclWpXB20Pd8hDm8UfxiutLQgKrnPGTjqu2hcC71y8DA9xPkZ9BxjkIwSW1VE7BX487f
	PX5AN07Rwj9FWlcTCm5OhbWOHtukUTI=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=amazon.com header.s=amazon201209 header.b=ulYOiJrG;
	spf=pass (diktynna.open-mesh.org: domain of
 "prvs=102578ec8=kuniyu@amazon.co.jp" designates 72.21.196.25 as permitted
 sender) smtp.mailfrom="prvs=102578ec8=kuniyu@amazon.co.jp";
	dmarc=pass (policy=quarantine) header.from=amazon.com
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1736818773; a=rsa-sha256;
	cv=none;
	b=JB1mGIgiUz8ILqAsicWO16xDvXXCHFXQBzr4/KB7PCDCJ611zA9vUs3TBYMX8LsbNe+KmI
	TXr0v+O2RxXJ0CU2mUy/MInzYOApbdzxjwepE88uboYGx/19HicG3qny0WN/IwcxkwMWC2
	ukc0WX4aVPH8yX93OcC70RFr7jka/XE=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1736818773; x=1768354773;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0cedPuJPQkStIGe+OXyB1F52+EDOiClOdRu6CBFc8ew=;
  b=ulYOiJrGfwLLIQlaC5df0p8qTUHookFX4E1EVMGeB2zzuJEaXCcr3ywE
   pYgIAgWxZ7gAWt33PfS6ikic9TiKNRKx6wyF+zm+AVwOTILNPavNIM1Jr
   M8k8dFUxwxE0txLTiPla8I/1/5NfNhICw449qbzjF7h/dePAirdXDZhAo
   g=;
X-IronPort-AV: E=Sophos;i="6.12,312,1728950400";
   d="scan'208";a="458589578"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO
 smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-2101.iad2.amazon.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2025 01:39:28 +0000
Received: from EX19MTAUWA001.ant.amazon.com [10.0.7.35:58030]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.14.236:2525]
 with esmtp (Farcaster)
 id 86aea7c8-dd91-44b2-aaf7-7a7eff52786e;
 Tue, 14 Jan 2025 01:39:28 +0000 (UTC)
X-Farcaster-Flow-ID: 86aea7c8-dd91-44b2-aaf7-7a7eff52786e
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Tue, 14 Jan 2025 01:39:27 +0000
Received: from 6c7e67c6786f.amazon.com (10.119.11.99) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Tue, 14 Jan 2025 01:39:19 +0000
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
Subject: Re: [PATCH net-next v8 01/11] rtnetlink: Lookup device in target
 netns when creating link
Date: Tue, 14 Jan 2025 10:39:09 +0900
Message-ID: <20250114013909.7102-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250113143719.7948-2-shaw.leon@gmail.com>
References: <20250113143719.7948-2-shaw.leon@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.119.11.99]
X-ClientProxiedBy: EX19D045UWA004.ant.amazon.com (10.13.139.91) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)
X-MailFrom: prvs=102578ec8=kuniyu@amazon.co.jp
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-0;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-1;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-2
Message-ID-Hash: VZKBJJUA3TJ5H4Z4IDIVUII7H4T7SKZL
X-Message-ID-Hash: VZKBJJUA3TJ5H4Z4IDIVUII7H4T7SKZL
X-Mailman-Approved-At: Tue, 14 Jan 2025 09:14:47 +0100
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/VZKBJJUA3TJ5H4Z4IDIVUII7H4T7SKZL/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

From: Xiao Liang <shaw.leon@gmail.com>
Date: Mon, 13 Jan 2025 22:37:09 +0800
> When creating link, lookup for existing device in target net namespace
> instead of current one.
> For example, two links created by:
> 
>   # ip link add dummy1 type dummy
>   # ip link add netns ns1 dummy1 type dummy
> 
> should have no conflict since they are in different namespaces.
> 
> Signed-off-by: Xiao Liang <shaw.leon@gmail.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>
