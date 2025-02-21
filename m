Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58E58C021B3
	for <batman-adv@archiver.kernel.org>; Fri, 21 Feb 2025 07:58:59 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id DDD188448B
	for <batman-adv@archiver.kernel.org>; Fri, 21 Feb 2025 08:58:57 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1740124737;
 b=cxap9/tHU7obCShvlfn4SFm4rml9g6tQzZo6sp6a0u93nBoeW+rsblh+8Z0vE4QgQWxQh
 tEBpu9itCUPW9GRTh51PpzmNqh7LymcD26aRhq/e6r6ot7VOBD82YniCUihsMONa6pE/Wbu
 KqEuN04MwOrcWMzhpqHJu4g5WJj6FDo=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1740124737; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=2RBr407lfpNcQNLCj0KAWf8UC6PZVgFWPwamtTvf6ec=;
 b=CqBYMzlk3t+cg7Ty5hjPPLCL03SKpDrgxXzTyunfb4J49wqVVhWXg4oWudwjHCfB/yo06
 NebbactGHb85hv+Kcz9yib03W7kXf30bfaB/oBHDKHI0CO+Le2yRm9J5rBVt9Ny3ZYa7LBC
 WCA5zWSwYJHbhvQ4sftSXe/HxPVrUWg=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=amazon.com header.i=@amazon.com;
  arc=pass;
  dmarc=none
Authentication-Results: open-mesh.org;
 dkim=pass header.d=amazon.com header.i=@amazon.com; arc=pass; dmarc=none
Received: from smtp-fw-80008.amazon.com (smtp-fw-80008.amazon.com
 [99.78.197.219])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id EC13A83ADE
	for <b.a.t.m.a.n@lists.open-mesh.org>; Fri, 21 Feb 2025 05:17:01 +0100 (CET)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1740111422;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=2RBr407lfpNcQNLCj0KAWf8UC6PZVgFWPwamtTvf6ec=;
	b=XWWsVc3Ly8ASjb+jblvwrulWM+fsOmQU3iSlLZtRp9b2+mUDWd+j2IDabDe9goxlWk8TVC
	5uhrgIqZYOuNNj3zoYe1O4FcIYrMmsNM4CPjZyUMJZuoJwimb3PJ1XWFQgAGcEeeoIGiVW
	aH7ui88EEO6RhNv6OltpEh5ad5RhvsM=
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1740111422; a=rsa-sha256;
	cv=none;
	b=wLub2O4fSMroXhUCqqnWA1Iz0sr/e6iRcW/YzOIIje4HxM3zWf0EcMly4D3ZWF3CTcol22
	VyGj8id4BJqk0J/iRNML/2XUWIAJwyiyqGj9M7602GUDogykPbxrfz0MFcQHonJagRmtno
	WXjEhpbGwdElDSDVlvuqlzVlk/wtS2g=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=amazon.com header.s=amazon201209 header.b=RytkuUPo;
	spf=pass (diktynna.open-mesh.org: domain of
 "prvs=140266d62=kuniyu@amazon.co.jp" designates 99.78.197.219 as permitted
 sender) smtp.mailfrom="prvs=140266d62=kuniyu@amazon.co.jp";
	dmarc=pass (policy=quarantine) header.from=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1740111422; x=1771647422;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2RBr407lfpNcQNLCj0KAWf8UC6PZVgFWPwamtTvf6ec=;
  b=RytkuUPoa9O0sAUkvYKA5ja1n3MOdjSc+bdFXg1B3pm0F/YGe+xETOo7
   l0Nebdp/3mBugcGNd3VtlWtqdMUcvuOvprrLMqNkUqU6fM/oANvV6Xm18
   BZainl75unDNo7CP0lrEp2/6luIHq4PdnJoi/+dNMh07F45nG5HLntCeS
   4=;
X-IronPort-AV: E=Sophos;i="6.13,303,1732579200";
   d="scan'208";a="171697267"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO
 smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-80008.pdx80.corp.amazon.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2025 04:16:58 +0000
Received: from EX19MTAUWA002.ant.amazon.com [10.0.38.20:44806]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.18.70:2525]
 with esmtp (Farcaster)
 id 3d34885b-f494-4c98-a1a4-c9b8261fc88d;
 Fri, 21 Feb 2025 04:16:58 +0000 (UTC)
X-Farcaster-Flow-ID: 3d34885b-f494-4c98-a1a4-c9b8261fc88d
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Fri, 21 Feb 2025 04:16:55 +0000
Received: from 6c7e67bfbae3.amazon.com (10.135.209.63) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Fri, 21 Feb 2025 04:16:49 +0000
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
Subject: Re: [PATCH net-next v10 11/13] rtnetlink: Create link directly in
 target net namespace
Date: Thu, 20 Feb 2025 20:16:41 -0800
Message-ID: <20250221041641.79788-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250219125039.18024-12-shaw.leon@gmail.com>
References: <20250219125039.18024-12-shaw.leon@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.135.209.63]
X-ClientProxiedBy: EX19D046UWA002.ant.amazon.com (10.13.139.39) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)
X-MailFrom: prvs=140266d62=kuniyu@amazon.co.jp
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-0;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-1;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-2
Message-ID-Hash: 2XCE47DDOIRC5ZPCF3C6XIT7RT756JLN
X-Message-ID-Hash: 2XCE47DDOIRC5ZPCF3C6XIT7RT756JLN
X-Mailman-Approved-At: Fri, 21 Feb 2025 08:53:56 +0100
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/2XCE47DDOIRC5ZPCF3C6XIT7RT756JLN/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

From: Xiao Liang <shaw.leon@gmail.com>
Date: Wed, 19 Feb 2025 20:50:37 +0800
> Make rtnl_newlink_create() create device in target namespace directly.
> Avoid extra netns change when link netns is provided.
> 
> Device drivers has been converted to be aware of link netns, that is not
> assuming device netns is and link netns is the same when ops->newlink()
> is called.
> 
> Signed-off-by: Xiao Liang <shaw.leon@gmail.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>
