Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4CF7C021AA
	for <batman-adv@archiver.kernel.org>; Fri, 21 Feb 2025 07:55:31 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 2DCEB8423B
	for <batman-adv@archiver.kernel.org>; Fri, 21 Feb 2025 08:55:30 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1740124530;
 b=Zkmoc7p/WuQrvnxsrlIxLHxLchF3Eut+tjTwPOHPivGCwpLwfqFy+/yM2zdOrUftVaCkO
 0BOLxXuMdiCCVhgeNwySYnKLXX4+FAEC2oQZgNXHBw0RhO07MOqNqeEI4OUjIljkjDt9W3l
 L9JXaTbgHMzVqbizj4UgDnpt2hfOMlc=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1740124530; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=oFHrnoZA5yunh9fQerpN+ou0poPl6NY3Hw3Lua8KpXw=;
 b=Dplx3UYbKqvlkp5erUwlGhJ04nzIc7FixkJqhDxGBouOpDKSm2+I56EqIGRsgK/LazczI
 wXNd50IPi64kuyWJf0gTG/LRAY6X5o5CogCNQOs2SgucGchfDksXLW+RO+RG/XcnXWkFmXy
 cDGT2Cj8cw4tjuni+R1X94xnsmiAM3Y=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=amazon.com header.i=@amazon.com;
  arc=pass;
  dmarc=none
Authentication-Results: open-mesh.org;
 dkim=pass header.d=amazon.com header.i=@amazon.com; arc=pass; dmarc=none
Received: from smtp-fw-9102.amazon.com (smtp-fw-9102.amazon.com
 [207.171.184.29])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 1545B815AE
	for <b.a.t.m.a.n@lists.open-mesh.org>; Fri, 21 Feb 2025 04:36:14 +0100 (CET)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1740108975;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=oFHrnoZA5yunh9fQerpN+ou0poPl6NY3Hw3Lua8KpXw=;
	b=qCU9d253OnhoplEp14D4J3jH3nF0lqmjgcxOgFQvY6/A4iycy0axJUxw9BjFAoY+P3owcw
	4NDOMnkNQxjqLyg2j3xZ09S1bzIOtlGwzPbJK+3ck8Gsr7/QwBCZtuv5CWSa3IFfI0OedX
	YIThx1EUKDIdSh6TOpLcvGIMCXQbjT4=
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1740108975; a=rsa-sha256;
	cv=none;
	b=qCsCWyqyoIHLUhbBf/Y1V6oFBXk1wOsTwiAulVTWLi3XU+tteVFaITNdV1nKD9edSzT34b
	S/24AB6TXirG2mXPjK2pyyS4f4SRNzeaBh9rwR1xbMZ0J/merMeOhRB8nOCN45m0e6I6qx
	SN3jp6YXq4djmJvWPtEXUX1OKSctXE8=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=amazon.com header.s=amazon201209 header.b=SiAodNiL;
	spf=pass (diktynna.open-mesh.org: domain of
 "prvs=140266d62=kuniyu@amazon.co.jp" designates 207.171.184.29 as permitted
 sender) smtp.mailfrom="prvs=140266d62=kuniyu@amazon.co.jp";
	dmarc=pass (policy=quarantine) header.from=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1740108975; x=1771644975;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=oFHrnoZA5yunh9fQerpN+ou0poPl6NY3Hw3Lua8KpXw=;
  b=SiAodNiLKmngO81Sr1WQbogqsYRHONJDQzhssBaw5SZhAyUWjIypYBiQ
   dGCyxtQrU+ilHZFtzIZLgiRLUik7FHg8qgmaniSo7leM96C7aOgqVHHjW
   7POuM0uMX85jvwkELBeFwh2I/Jq7HAABEvimbwDZkAqogIsYrEmTqRrMt
   E=;
X-IronPort-AV: E=Sophos;i="6.13,303,1732579200";
   d="scan'208";a="495797487"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO
 smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-9102.sea19.amazon.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2025 03:36:06 +0000
Received: from EX19MTAUWB002.ant.amazon.com [10.0.7.35:31178]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.35.58:2525]
 with esmtp (Farcaster)
 id 8cb3c8f8-0a7a-4678-9917-956104d654d3;
 Fri, 21 Feb 2025 03:36:05 +0000 (UTC)
X-Farcaster-Flow-ID: 8cb3c8f8-0a7a-4678-9917-956104d654d3
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Fri, 21 Feb 2025 03:35:58 +0000
Received: from 6c7e67bfbae3.amazon.com (10.135.209.63) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Fri, 21 Feb 2025 03:35:52 +0000
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
Subject: Re: [PATCH net-next v10 06/13] net: ip_tunnel: Use link netns in
 newlink() of rtnl_link_ops
Date: Thu, 20 Feb 2025 19:35:44 -0800
Message-ID: <20250221033544.74835-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250219125039.18024-7-shaw.leon@gmail.com>
References: <20250219125039.18024-7-shaw.leon@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.135.209.63]
X-ClientProxiedBy: EX19D039UWA004.ant.amazon.com (10.13.139.68) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)
X-MailFrom: prvs=140266d62=kuniyu@amazon.co.jp
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-0;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-1;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-2
Message-ID-Hash: HQ2C5ZEBMG3QS44M7IUJ5QZVX564QYQA
X-Message-ID-Hash: HQ2C5ZEBMG3QS44M7IUJ5QZVX564QYQA
X-Mailman-Approved-At: Fri, 21 Feb 2025 08:53:56 +0100
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/HQ2C5ZEBMG3QS44M7IUJ5QZVX564QYQA/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

From: Xiao Liang <shaw.leon@gmail.com>
Date: Wed, 19 Feb 2025 20:50:32 +0800
> When link_net is set, use it as link netns instead of dev_net(). This
> prepares for rtnetlink core to create device in target netns directly,
> in which case the two namespaces may be different.
> 
> Convert common ip_tunnel_newlink() to accept an extra link netns
> argument.
> 
> Signed-off-by: Xiao Liang <shaw.leon@gmail.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>
