Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FE5CC021B5
	for <batman-adv@archiver.kernel.org>; Fri, 21 Feb 2025 07:54:50 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id CAB9A842A5
	for <batman-adv@archiver.kernel.org>; Fri, 21 Feb 2025 08:54:48 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1740124488;
 b=jUlNl9uSxj4PJl5jO19vInjXKEcMcXzdIre93xOheX26wE0ErhfoKAJ1ikpfTemVVroI1
 jEWlLf49lnXCppTRziqwp4ADvoZq/HFajNTtOmgmDepcCTfDPF0zStF1cWMklBilIatJEih
 xeKApbx3Cb0Buxihg2ga+g1bmGdQsDU=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1740124488; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=8mNjS6ciQxTju2qMj3xcfBbIY4//EJ+QLkySghPDl14=;
 b=MEPh/9eVlg9AY7xjxERPMmsJMHyqEYU/cJcCcCR94q/5rFi0/vSfIwPF48aoJI0KhBnJl
 o3qU3ZUuBFZpSxxNTKPEoFWzCTJnxtZdIFXt3wofAU7kOoANjsmroqemgyVOf4E3Bzu0Yzj
 X0OanQVq7eC41pS3ZCvJCBeepEknQEE=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=amazon.com header.i=@amazon.com;
  arc=pass;
  dmarc=none
Authentication-Results: open-mesh.org;
 dkim=pass header.d=amazon.com header.i=@amazon.com; arc=pass; dmarc=none
Received: from smtp-fw-9106.amazon.com (smtp-fw-9106.amazon.com
 [207.171.188.206])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 7DACD81D2E
	for <b.a.t.m.a.n@lists.open-mesh.org>; Fri, 21 Feb 2025 04:26:52 +0100 (CET)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1740108413;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=8mNjS6ciQxTju2qMj3xcfBbIY4//EJ+QLkySghPDl14=;
	b=hr8eoHqfyJllIg1nLwJdl4eCR+B62iq93C1SefDSe5iafrPuUH5pfltXSnv/WBFchxuahl
	5dAOhqxA7SH48awri1j5wzqs5L1+Ux8j6e7FIJRETkhTnF9pjKo3tid50hK2VknOO1j57A
	BZQV4ePpcYmaxwnOd8MRd234M2zcUDo=
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1740108413; a=rsa-sha256;
	cv=none;
	b=v5GkFc84rGQY9FlXpLJTUxdvDINe2n+ddXuTSQ6ulm9CFH7bEYO+dFZfEwAlArAKcGHyL7
	w/sX+nBCJ6pok9N2NMigKaHWcMK62bq3qWp8syM03sekImHgHNkHiPvLxE2V7U5FbVXfWF
	DBlhgHC7urvsKgJQQHCZJWRAHKfJ7TM=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=amazon.com header.s=amazon201209 header.b=NBBAUobz;
	spf=pass (diktynna.open-mesh.org: domain of
 "prvs=140266d62=kuniyu@amazon.co.jp" designates 207.171.188.206 as permitted
 sender) smtp.mailfrom="prvs=140266d62=kuniyu@amazon.co.jp";
	dmarc=pass (policy=quarantine) header.from=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1740108413; x=1771644413;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8mNjS6ciQxTju2qMj3xcfBbIY4//EJ+QLkySghPDl14=;
  b=NBBAUobzJpvgNC6H+GB38degD5n/b4HJpoLaNZ7g3LtagtxJv3Lsr8n/
   PRnV7nfOtduxTx0nGM+zN9hzYru6SdSX5eNzIM3B9iYi/eypuYt8vHo32
   fCWW51lPE7ffq7CzRXOUk+otjmUkL8J93Q7kdUUdzm7w2uMaMIOtNqXFl
   w=;
X-IronPort-AV: E=Sophos;i="6.13,303,1732579200";
   d="scan'208";a="800651343"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO
 smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-9106.sea19.amazon.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2025 03:26:45 +0000
Received: from EX19MTAUWB002.ant.amazon.com [10.0.7.35:51797]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.18.70:2525]
 with esmtp (Farcaster)
 id 0699b55d-301b-4263-9bf9-a0cbd11131d6;
 Fri, 21 Feb 2025 03:26:43 +0000 (UTC)
X-Farcaster-Flow-ID: 0699b55d-301b-4263-9bf9-a0cbd11131d6
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Fri, 21 Feb 2025 03:26:43 +0000
Received: from 6c7e67bfbae3.amazon.com (10.135.209.63) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Fri, 21 Feb 2025 03:26:38 +0000
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
Subject: Re: [PATCH net-next v10 05/13] net: ip_tunnel: Don't set tunnel->net
 in ip_tunnel_init()
Date: Thu, 20 Feb 2025 19:26:29 -0800
Message-ID: <20250221032629.73823-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250219125039.18024-6-shaw.leon@gmail.com>
References: <20250219125039.18024-6-shaw.leon@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.135.209.63]
X-ClientProxiedBy: EX19D038UWB002.ant.amazon.com (10.13.139.185) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)
X-MailFrom: prvs=140266d62=kuniyu@amazon.co.jp
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-0;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-1;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-2
Message-ID-Hash: JZNIH7AEJYZCSLTUJETJTQCNQWOEVLGI
X-Message-ID-Hash: JZNIH7AEJYZCSLTUJETJTQCNQWOEVLGI
X-Mailman-Approved-At: Fri, 21 Feb 2025 08:53:56 +0100
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/JZNIH7AEJYZCSLTUJETJTQCNQWOEVLGI/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

From: Xiao Liang <shaw.leon@gmail.com>
Date: Wed, 19 Feb 2025 20:50:31 +0800
> ip_tunnel_init() is called from register_netdevice(). In all code paths
> reaching here, tunnel->net should already have been set (either in
> ip_tunnel_newlink() or __ip_tunnel_create()). So don't set it again.
> 
> Signed-off-by: Xiao Liang <shaw.leon@gmail.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>
