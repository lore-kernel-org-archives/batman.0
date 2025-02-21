Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CAAEC021AA
	for <batman-adv@archiver.kernel.org>; Fri, 21 Feb 2025 07:57:35 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 2B81A8425B
	for <batman-adv@archiver.kernel.org>; Fri, 21 Feb 2025 08:57:34 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1740124654;
 b=ASApWWCcrYYz7mOk9FfgGB6chK1uZWT8aNcIWwXQOsG2eoXpG+NWvnBZw5KXKHUd1+g/r
 vfQCuGUhy+Z220sw0F0tCUwqk3j0qsTWh+w1e0Du8Y5mtQ8std10jQuy87F0F62gB+A3WBw
 uujpnAKyobXizpDdWUvBCba7FKHVdJM=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1740124654; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=hwbCjops9YNPWmDfophlYDE2t1KmR8e+5lnc5x6kKzA=;
 b=RIW8y6DX5LTWNRXpqC49jmiaygGfIORS8LYzEmtDZx1TMeXjWVUDj9AP09Lvt9NQDF5vZ
 XE4nX1jZPA57/cEa4RGOBOKN2/WAzVquufyOa1rubGv4Zi1CNIOU6Un6kbLeOY8sGVJ0iEA
 /A4epOOP3ioTgOf9FrO+BVz8D2Hfdm8=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=amazon.com header.i=@amazon.com;
  arc=pass;
  dmarc=none
Authentication-Results: open-mesh.org;
 dkim=pass header.d=amazon.com header.i=@amazon.com; arc=pass; dmarc=none
Received: from smtp-fw-80009.amazon.com (smtp-fw-80009.amazon.com
 [99.78.197.220])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 4296F8353C
	for <b.a.t.m.a.n@lists.open-mesh.org>; Fri, 21 Feb 2025 05:10:49 +0100 (CET)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1740111049;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=hwbCjops9YNPWmDfophlYDE2t1KmR8e+5lnc5x6kKzA=;
	b=I4eLqAiBrnMg4vS2O7dLujjPfC8AQsmrD5watmR9kPDfVYUGnQ7ARn+v3D4zbJ+aN0QymL
	PgsigH2QD3tzAdK66pvL6vKJELYU0BgLcU4Kd9+G8hhyES2FrXQlMh67+d0mnpyLr79D48
	IgYYKvHO486R9fJ8Ns2wBkh4cQPlJZI=
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1740111049; a=rsa-sha256;
	cv=none;
	b=wUHjeTImSUWkDsjh1V74xSF/Wxi+G2fw/8HJ+bvIaBPoHCKfV2VRWRElADnZ+mEDKL8sYO
	A8/GKmlshw+TKu3wiCPpeg7+qP0uSBbK8Yqvttn+CrLxcEWxcdJZCtgfaxqVo62XFSPn6w
	vpCOzKcRxfZiyxh8Ulgy1+j331/5fps=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=amazon.com header.s=amazon201209 header.b=IR2FuNQ8;
	spf=pass (diktynna.open-mesh.org: domain of
 "prvs=140266d62=kuniyu@amazon.co.jp" designates 99.78.197.220 as permitted
 sender) smtp.mailfrom="prvs=140266d62=kuniyu@amazon.co.jp";
	dmarc=pass (policy=quarantine) header.from=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1740111049; x=1771647049;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hwbCjops9YNPWmDfophlYDE2t1KmR8e+5lnc5x6kKzA=;
  b=IR2FuNQ8O6JvDc396ZA9LHiKztg+X0ITxjhTTchW/5eVgYdqdigP3c4r
   hsHnTUSI53eTouCiA0e3apN+lynrP5Kmi1UW+Pa7vWVmGuZXx2fMkl0Iq
   TmxDLnOHNIHvDDXEWM2gBaObjcP2CLk19Q39+kvkbIG3RFZ5b2QCe7YoB
   s=;
X-IronPort-AV: E=Sophos;i="6.13,303,1732579200";
   d="scan'208";a="174489550"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO
 smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80009.pdx80.corp.amazon.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2025 04:10:44 +0000
Received: from EX19MTAUWC002.ant.amazon.com [10.0.21.151:50069]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.35.58:2525]
 with esmtp (Farcaster)
 id fbfaca7d-a389-4e71-a4ee-c9c9b4945549;
 Fri, 21 Feb 2025 04:10:44 +0000 (UTC)
X-Farcaster-Flow-ID: fbfaca7d-a389-4e71-a4ee-c9c9b4945549
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Fri, 21 Feb 2025 04:10:44 +0000
Received: from 6c7e67bfbae3.amazon.com (10.135.209.63) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Fri, 21 Feb 2025 04:10:39 +0000
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
Subject: Re: [PATCH net-next v10 09/13] net: xfrm: Use link netns in newlink()
 of rtnl_link_ops
Date: Thu, 20 Feb 2025 20:10:30 -0800
Message-ID: <20250221041030.78359-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250219125039.18024-10-shaw.leon@gmail.com>
References: <20250219125039.18024-10-shaw.leon@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.135.209.63]
X-ClientProxiedBy: EX19D035UWB003.ant.amazon.com (10.13.138.85) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)
X-MailFrom: prvs=140266d62=kuniyu@amazon.co.jp
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-0;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-1;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-2
Message-ID-Hash: BG3Z7QWW6PJIPKFFCO3MCI4SHWKS275Y
X-Message-ID-Hash: BG3Z7QWW6PJIPKFFCO3MCI4SHWKS275Y
X-Mailman-Approved-At: Fri, 21 Feb 2025 08:53:56 +0100
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/BG3Z7QWW6PJIPKFFCO3MCI4SHWKS275Y/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

From: Xiao Liang <shaw.leon@gmail.com>
Date: Wed, 19 Feb 2025 20:50:35 +0800
> When link_net is set, use it as link netns instead of dev_net(). This
> prepares for rtnetlink core to create device in target netns directly,
> in which case the two namespaces may be different.
> 
> Signed-off-by: Xiao Liang <shaw.leon@gmail.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>
