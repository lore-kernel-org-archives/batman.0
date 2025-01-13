Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11340C02180
	for <batman-adv@archiver.kernel.org>; Mon, 13 Jan 2025 15:29:20 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 6FAC7842A2
	for <batman-adv@archiver.kernel.org>; Mon, 13 Jan 2025 16:29:18 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1736782158;
 b=rCJxJHOOLLhDCF1lrwyKjAxFjM8bfLYc/LxYmZsLjVP60dqYP4tvPocXPOmnvvoXVTryz
 xnh9cvjjaGDk98jFmsYFK2iiNfMyMqzx4R06guEJlOoWv/gCpl3izvTOvtza2VP+g0MNGF2
 5K4sQV+xYplPDjCN5mpA+Xk9CpbCF8A=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1736782158; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=3RwrUezkHV4Bxso8Lan3H8PNeHkallTCdG4JVNGo1S0=;
 b=b0XmQcDdI2Jgnp4yv+QQOkODCkie4JF0i1AxIrem7Z7IYTlEijdSZVKdccHAjYByZmKRk
 7hk09EB+ZyjCedjY3HOPLw4V4bMgDTX6xWWWHBnrFeZwbCoH+C6aI7d6RlP1dUWRUQ0uq/a
 mIGsrjhpQJuPuuzbbI1kTV94XDcclJ4=
ARC-Authentication-Results: i=2; open-mesh.org; dkim=pass header.d=gmail.com;
  arc=pass;
  dmarc=pass (Used From Domain Record) header.from=gmail.com
 policy.dmarc=quarantine
Authentication-Results: open-mesh.org; dkim=pass header.d=gmail.com; arc=pass;
 dmarc=pass (Used From Domain Record) header.from=gmail.com
 policy.dmarc=quarantine
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com
 [IPv6:2607:f8b0:4864:20::62c])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 8DFC8803F3
	for <b.a.t.m.a.n@lists.open-mesh.org>; Mon, 13 Jan 2025 15:38:57 +0100 (CET)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1736779137;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=3RwrUezkHV4Bxso8Lan3H8PNeHkallTCdG4JVNGo1S0=;
	b=nwgsQhbKxpMwXRoidCZ4DeptwMfPAYW/DJ8Z8V4GOHcLmQ1gEHbOuQr+3auicIw3bk4wxI
	eguYbWsaqrfVeQyEmJK85OAd6Adwd2L/pHrSAm6Ob4p/pNC4+FH5+ilNSE/TETV/VP54br
	B4cGYO7OQnPju7DG/KH/Abd0WuJuIrk=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=gmail.com header.s=20230601 header.b=JaSIK21X;
	spf=pass (diktynna.open-mesh.org: domain of shaw.leon@gmail.com designates
 2607:f8b0:4864:20::62c as permitted sender)
 smtp.mailfrom=shaw.leon@gmail.com;
	dmarc=pass (policy=none) header.from=gmail.com
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1736779137; a=rsa-sha256;
	cv=none;
	b=0ZKFHsJWaPIKDUyMFREwROjPP5Ng/Ws95yLzwdtKrpytj2f0IOmj257TNIIDLBV3OpSbB4
	XnHqVfgjh8cm1E6KmOkI0NfumdIoxk+LWQW4ybfR8UeJ4qZoMc+7lg9RZqbpEvcFDsSZPo
	+ZmnpCY8YFEvGbHoK2FsZdPIr8xxaxI=
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-2161eb94cceso52864955ad.2
        for <b.a.t.m.a.n@lists.open-mesh.org>;
 Mon, 13 Jan 2025 06:38:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736779136; x=1737383936;
 darn=lists.open-mesh.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3RwrUezkHV4Bxso8Lan3H8PNeHkallTCdG4JVNGo1S0=;
        b=JaSIK21X/X9lA5c9+EuVbgWvUURFfnujBfoYZYBINUZz+bkBQWpoT2J8EemEt3131N
         XgVAaoQ1agy88tTb7j1Lc42CFA0ZpoXzwPa1iG1lyZf5b6DLKRCeHTs4CIjDmuruVGf3
         jKL5T0UP10TGJa0FrdpLVF1Xp9V3Mswg5F48SMM7AzYxdIW6/NlqdAa5IsS3xYOgeokL
         WUmZZviju93hyJRWnv5fbmbLX4gtxmM/1dakGZhzi96qDIuMTs/vReBWVE29CiYAUarw
         m3MpR50PNGB8SI09OfcNXrpR/9slRkUgRoBp5Db/kgNBNygEs7VHQpySZ+zgH8HZnoHa
         Sz6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736779136; x=1737383936;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3RwrUezkHV4Bxso8Lan3H8PNeHkallTCdG4JVNGo1S0=;
        b=Og/xAyXE8w+Kxe0ccOMnyw6/eOYppfRSy8av30+WpGmb3hjqJkpHejQwuxlvCvoCqS
         J1DUzMDl2Kre/6mLeASinv67tQK1NCiPHXG2YllPYr6ytSO2tRIE782OVO1oRh7aDmYP
         LKAwqNWbITBHhYufY6IDdPBXfwXtJ1f8kWnEfSf62nSU0nVofySgnfB+x9TdgR1LZXBQ
         yN2yHnSDVlUNjV8FJk9PDCTu8h85CnHgrPBmS8Gc5yoB1UqqCEmg6HnAtJsqNPmeSJmS
         PHqzOWa1TJSqVUdj24Zsj8+uXhjyrTdDAC88DV6taGVXUNhoJWHPrCvB1J830t6kbPSX
         dcBA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVBEjMNotZpjKhH5flZPbd3zNA2OUhvCGNSvfBH50A3RQ8w7102OFzkws+2u1P10FpYDKzb41CduAagFw==@lists.open-mesh.org
X-Gm-Message-State: AOJu0YxjVa+OQlTcfBsMfL9hhfo0ue/b+XFUvNpMTOd6d0UxBY1UQlfj
	9Kydv7l8Z8A3srsH45vqpVspC70/AEa1U2OKeyD9hiuLWuZrgtTa
X-Gm-Gg: ASbGncsFa7AnjCJf61E+svHMpeK5jpMyJhrxjRBAnAHk8azPyWOu07ZuvquDQTCPpdl
	2xOBFHnzZ75elP6FhdX98isjGpxWeNEHzHeX52mB3z8ZDrx6kaklfAlQHeA7wHrLRW+9cZ2SPxJ
	P9XOhNvh2r8hwdCO8s85cJShx5ST0hNKh8SPZ3Yd6X1Fm+0MVkAxp4j37evLiuqOSyCJYF3xX9e
	3Cv4JBdgmRb68w0SqX8edwYeTX8i4Ih0fOL1KY8Yq/uN28=
X-Google-Smtp-Source: 
 AGHT+IHt1nCTDh10fBQS9NHgK/oOky2VtiRHLWbePcQNxSAsFYQfmLDkyg61R0c+C95BGg+IP2F6xw==
X-Received: by 2002:a17:903:18a:b0:216:4a06:e87a with SMTP id
 d9443c01a7336-21a83fc7640mr358427785ad.40.1736779135888;
        Mon, 13 Jan 2025 06:38:55 -0800 (PST)
Received: from ws.. ([103.167.140.11])
        by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21a9f155e00sm54328715ad.103.2025.01.13.06.38.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2025 06:38:55 -0800 (PST)
From: Xiao Liang <shaw.leon@gmail.com>
To: netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Jakub Kicinski <kuba@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Donald Hunter <donald.hunter@gmail.com>,
	Alexander Aring <alex.aring@gmail.com>,
	Stefan Schmidt <stefan@datenfreihafen.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	linux-rdma@vger.kernel.org,
	linux-can@vger.kernel.org,
	osmocom-net-gprs@lists.osmocom.org,
	bpf@vger.kernel.org,
	linux-ppp@vger.kernel.org,
	wireguard@lists.zx2c4.com,
	linux-wireless@vger.kernel.org,
	b.a.t.m.a.n@lists.open-mesh.org,
	bridge@lists.linux.dev,
	linux-wpan@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v8 09/11] rtnetlink: Create link directly in target
 net namespace
Date: Mon, 13 Jan 2025 22:37:17 +0800
Message-ID: <20250113143719.7948-10-shaw.leon@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250113143719.7948-1-shaw.leon@gmail.com>
References: <20250113143719.7948-1-shaw.leon@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MailFrom: shaw.leon@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-0;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-1;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-2
Message-ID-Hash: CPHO2PNLBOOTFNQDVFLAMCTNMNBQEPDK
X-Message-ID-Hash: CPHO2PNLBOOTFNQDVFLAMCTNMNBQEPDK
X-Mailman-Approved-At: Mon, 13 Jan 2025 16:21:55 +0100
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/CPHO2PNLBOOTFNQDVFLAMCTNMNBQEPDK/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

Make rtnl_newlink_create() create device in target namespace directly.
Avoid extra netns change when link netns is provided.

Device drivers has been converted to be aware of link netns, that is not
assuming device netns is and link netns is the same when ops->newlink()
is called.

Signed-off-by: Xiao Liang <shaw.leon@gmail.com>
---
 net/core/rtnetlink.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index cce5bcd1f257..65f09ab616b5 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -3784,8 +3784,8 @@ static int rtnl_newlink_create(struct sk_buff *skb, struct ifinfomsg *ifm,
 		name_assign_type = NET_NAME_ENUM;
 	}
 
-	dev = rtnl_create_link(link_net ? : tgt_net, ifname,
-			       name_assign_type, ops, tb, extack);
+	dev = rtnl_create_link(tgt_net, ifname, name_assign_type, ops, tb,
+			       extack);
 	if (IS_ERR(dev)) {
 		err = PTR_ERR(dev);
 		goto out;
@@ -3805,11 +3805,6 @@ static int rtnl_newlink_create(struct sk_buff *skb, struct ifinfomsg *ifm,
 	err = rtnl_configure_link(dev, ifm, portid, nlh);
 	if (err < 0)
 		goto out_unregister;
-	if (link_net) {
-		err = dev_change_net_namespace(dev, tgt_net, ifname);
-		if (err < 0)
-			goto out_unregister;
-	}
 	if (tb[IFLA_MASTER]) {
 		err = do_set_master(dev, nla_get_u32(tb[IFLA_MASTER]), extack);
 		if (err)
-- 
2.47.1

