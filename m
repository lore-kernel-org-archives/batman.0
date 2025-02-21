Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42969C021AA
	for <batman-adv@archiver.kernel.org>; Fri, 21 Feb 2025 07:56:54 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id DC49584464
	for <batman-adv@archiver.kernel.org>; Fri, 21 Feb 2025 08:56:52 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1740124612;
 b=nzZA2HSS00xcamEX3NRdukGOzYT4Aduh3HCK7RDoMAOukh9N84fWFoRhTZ/ekTzj70j2L
 cnKLHV1xVCL9hU+aiFGKUnFMGtF6KgbLiSYa5VHzO9ll/2X77qydk/ojKsF/Q1U+GJRU95V
 T9NFwd/g2G38Bc0WD8Aqo6TIT5Y6ZtY=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1740124612; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=M3R4jgVzCNPLBzNuXpXuKMyO2gDw390ime/+zg7mysY=;
 b=PDQMOf9/H8LAsFFR1mGvQFPQzBnETyN/yX34nBex95Ed+fkxz1F1k5XgeZ/ph4y/YLLbj
 s4JVTfBChos/klNrvasZU7VeDX8tl423L126cC99vRLlQaK+cGR4WWiJml1NtANDeJq33/o
 fgNMBUPb0NsWmJ5sCVBN5aZUlSFuUfI=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=amazon.com header.i=@amazon.com;
  arc=pass;
  dmarc=none
Authentication-Results: open-mesh.org;
 dkim=pass header.d=amazon.com header.i=@amazon.com; arc=pass; dmarc=none
Received: from smtp-fw-9102.amazon.com (smtp-fw-9102.amazon.com
 [207.171.184.29])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 865B283ADE
	for <b.a.t.m.a.n@lists.open-mesh.org>; Fri, 21 Feb 2025 05:09:24 +0100 (CET)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1740110965;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=M3R4jgVzCNPLBzNuXpXuKMyO2gDw390ime/+zg7mysY=;
	b=p//5QqHuGKixHz+3+zg4fCi+KjCd2qEJQ7GBMyo7ES0rB4sdJ4mDpcj6pvG9JOgsE/s8jc
	ARzfqM0rq1uP3BkmdV8lYFw9Js187PhIpQ0FLRQ3OdXbiK2PqxFLbhPhKXhed7JHm2Hmwx
	wg7QX3T4cqnrl6kJyMd9KYN72OGRk/E=
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1740110965; a=rsa-sha256;
	cv=none;
	b=DPxPoU3NJOgs5Qrm/zgB2Rcr3fW92AIn6b3thphJ6mtQ6bEg8F9j7RDz1mgQkHiQAluuXL
	t9xPBXrAkcYavY/pk/E/dPwP2Xji+mKwKafM2L0ilR771bVV2AOlZriPFEZxCdYFjzluAD
	w/i8Uc1kltSRKVfeupbigd26S+VllV4=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=amazon.com header.s=amazon201209 header.b=s5o9M4Nq;
	spf=pass (diktynna.open-mesh.org: domain of
 "prvs=140266d62=kuniyu@amazon.co.jp" designates 207.171.184.29 as permitted
 sender) smtp.mailfrom="prvs=140266d62=kuniyu@amazon.co.jp";
	dmarc=pass (policy=quarantine) header.from=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1740110965; x=1771646965;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=M3R4jgVzCNPLBzNuXpXuKMyO2gDw390ime/+zg7mysY=;
  b=s5o9M4NqD96f5Q18op7NFd2lN5NPn0UqxeSEVnnBLnEnWlnUa0Zm7DEi
   EAuAfDVCaD6dRwwx0BxW/mNhKX0AKgek+X/n1bLc5s2N/VBDZNbdKBnEf
   PGhBULo9cbBDmcpMbZNtCliyVoL38GuA8IRgEWunaN5FfWf6jnNiH4YGY
   A=;
X-IronPort-AV: E=Sophos;i="6.13,303,1732579200";
   d="scan'208";a="495807538"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO
 smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-9102.sea19.amazon.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2025 04:09:13 +0000
Received: from EX19MTAUWB002.ant.amazon.com [10.0.7.35:23369]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.18.32:2525]
 with esmtp (Farcaster)
 id c0ba83e4-397a-4153-a293-f9b3f392ec9f;
 Fri, 21 Feb 2025 04:09:12 +0000 (UTC)
X-Farcaster-Flow-ID: c0ba83e4-397a-4153-a293-f9b3f392ec9f
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Fri, 21 Feb 2025 04:09:12 +0000
Received: from 6c7e67bfbae3.amazon.com (10.135.209.63) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Fri, 21 Feb 2025 04:09:06 +0000
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
Subject: Re: [PATCH net-next v10 08/13] net: ipv6: Use link netns in newlink()
 of rtnl_link_ops
Date: Thu, 20 Feb 2025 20:08:58 -0800
Message-ID: <20250221040858.78214-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250219125039.18024-9-shaw.leon@gmail.com>
References: <20250219125039.18024-9-shaw.leon@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.135.209.63]
X-ClientProxiedBy: EX19D042UWA004.ant.amazon.com (10.13.139.16) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)
X-MailFrom: prvs=140266d62=kuniyu@amazon.co.jp
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-0;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-1;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-2
Message-ID-Hash: FGRL77RLL46LX4KEQCXAU4TV4UU7GP32
X-Message-ID-Hash: FGRL77RLL46LX4KEQCXAU4TV4UU7GP32
X-Mailman-Approved-At: Fri, 21 Feb 2025 08:53:56 +0100
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/FGRL77RLL46LX4KEQCXAU4TV4UU7GP32/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

From: Xiao Liang <shaw.leon@gmail.com>
Date: Wed, 19 Feb 2025 20:50:34 +0800
> When link_net is set, use it as link netns instead of dev_net(). This
> prepares for rtnetlink core to create device in target netns directly,
> in which case the two namespaces may be different.
> 
> Signed-off-by: Xiao Liang <shaw.leon@gmail.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>
