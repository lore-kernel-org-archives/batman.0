Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8291EC021AA
	for <batman@archiver.kernel.org>; Wed, 19 Feb 2025 15:47:48 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 0676E842A1
	for <batman@archiver.kernel.org>; Wed, 19 Feb 2025 16:47:47 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1739980067;
 b=lvIjHUMhh401C8Rods8W3W/y8Pp3sExE1d2llgElb+ojLh/VPRbaVvjvinTklUQVfqM3O
 VegvwVCL/VLPgS1muW7Q5gfr+eO5e3UzgKRE1s24p5IT8jukG+Xn0fz/ZdECgCx3CRfv5Fq
 qYijfoA7M/ozdc2pVictCMN05g5kB6w=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1739980067; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=RiGtI+5ToMID9TUSdNCghgiM3EXs9/d4cQAhclrcdwo=;
 b=Iuh/yg9jqEHX1IwyRzZCNaz1L7YbD1rv2ID3z8jJLOFWEGX75Q1sPS2AVRnqzvXZ/VgzV
 yafkldolGLCtLG48ABwFmY1SBwAevZ0Z5HXkuvalhxPTRX5Vp9lQAFmXLEGZWNAYLy+d0H+
 ZYJIpiX+EOAw20/J6Lg7FIQ3YP2fq1U=
ARC-Authentication-Results: i=2; open-mesh.org; dkim=pass header.d=gmail.com;
  arc=pass;
  dmarc=pass (Used From Domain Record) header.from=gmail.com
 policy.dmarc=quarantine
Authentication-Results: open-mesh.org; dkim=pass header.d=gmail.com; arc=pass;
 dmarc=pass (Used From Domain Record) header.from=gmail.com
 policy.dmarc=quarantine
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com
 [IPv6:2607:f8b0:4864:20::62b])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id DC08383F65
	for <b.a.t.m.a.n@lists.open-mesh.org>; Wed, 19 Feb 2025 13:51:40 +0100 (CET)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1739969500;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=RiGtI+5ToMID9TUSdNCghgiM3EXs9/d4cQAhclrcdwo=;
	b=LZt0AYEipO8/dOTrGBdoYYTyy+cJ8T22Rf+DpvnFfBFp/r6qW/C0X+VZCwoeebxZVKeIhJ
	434v2cKoeoUw+5AwHk8GQ+8MMBbpD3aNYBiUvLxzqwfspzj6VI2uc4ff6Tak8FltDTj9Kh
	LmbInHrtu/nG5/qK8JF6nGh/j7lfYY4=
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1739969500; a=rsa-sha256;
	cv=none;
	b=il3Ev6B9iS8HInrkCUTT9EBvlCPqOcTIQ6sRV03EJE7AFZiS6otOZfbK0zHT08suv5P9gk
	oF8Zx02vKQLLlPNYN3h3utlqttksJU7N5iaPG1p+TwvedlUD0CdlQrj5rh9y+eTcT5wtNt
	Nj8FhdLJf5zkSCGBuPwKskNdESX/v+c=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=gmail.com header.s=20230601 header.b=JZWVRa0m;
	spf=pass (diktynna.open-mesh.org: domain of shaw.leon@gmail.com designates
 2607:f8b0:4864:20::62b as permitted sender)
 smtp.mailfrom=shaw.leon@gmail.com;
	dmarc=pass (policy=none) header.from=gmail.com
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-22100006bc8so75683925ad.0
        for <b.a.t.m.a.n@lists.open-mesh.org>;
 Wed, 19 Feb 2025 04:51:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739969499; x=1740574299;
 darn=lists.open-mesh.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RiGtI+5ToMID9TUSdNCghgiM3EXs9/d4cQAhclrcdwo=;
        b=JZWVRa0mnX/vL7RAmvXYgK4QsU3AWlzggfThF66RAPlVJRIXYDVQKlvwEJ+iBdvkvu
         tLHTDXGkiTqhCpmFRRdMA2XcW4a38hs9olryOvJAYBunpWDsjsIsiPzr/g6DiXjTaEfJ
         71Iu+Cg0xFnKp0KqNdF9tn4YdZva4Z3V/cD/N79sYsp4csYHGukPn68+Se+EjnLWdBp/
         9bKEVBnf3cudulOfZA/oYfE1kTxpFvzd2yyGQqz8NaUiXSDUDzsRAuMz/yMgCXpJNDeN
         eEkxx4aj0BcPgosTxhx6AJGXfzX0NTJJd7IZniC5owz2HU9nhlUs6Ewd6C28YF+xYF/K
         9TIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739969499; x=1740574299;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RiGtI+5ToMID9TUSdNCghgiM3EXs9/d4cQAhclrcdwo=;
        b=LYOX2ga81HzjxHYzG6DQG6b0Z1wcEz3UlcyBbO6WiN4PucPxzyna+JJk0pfOOXbSIc
         LQlNNBX9MMkmkhDDtsUSNNRjoF7aM6ntCpsoTMKRHd6Is95nVEXZ9CzwxNDFIL9mmGFm
         kPy+ZQ2Av4Sso3c4eKewRq8Z7moFmEJfrmdJdf0tXf1I9cOL9zjDcgr68d9H3KYbuyU7
         EMeK4frrxVDkl0irBEydAbMZLQAb6oIayjxlobG3CSgQDotBJZ3eTRInGF1AWY1BpyQI
         xMDMaU5M+fNDThzT5t7glLRuGi9CgJm+xn8v/PjCf5+p9V3KwXJW6IgT/nOUykZIQHgP
         gcIA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVUs0zWW6igRp2imWkYGyuoHhmJOcPXBwI4piqACK45v96uMxqssaDpZshL6Dx7v2wAWKWP4suRWA44Tw==@lists.open-mesh.org
X-Gm-Message-State: AOJu0Yyl4GWQHWxzgK72/d/PXRb9v+tWDP2Vs3TwwYN01yJW1UO6rA2O
	g1bEUJp6yqkA18oqn2XsMQxdn2Y2wdBueIN5zOgAvKxuuM0hkU0g
X-Gm-Gg: ASbGnct9RSgOEvZlGmVqQ284cOuQT2/vM14jX5ImyMfv9HcswtWJ59X50pOjqrF1m9m
	Zv6xtKfOMApLxc8YHSs++lznmcfvEalrCZ8pNmuAjfCnmaaAFXSgDZLW7zHI5V1mLRdiG93188R
	5NH3eu4gsQ2r31kD93ALn69mfGauBT1ixPM/aXiXicD9JUYxsReEwZG45JbyGfG0pe2B2Q/edqT
	t1fUX0fUZpWFm+hVI7csD7zvnOgVj3wPZISWPXNvZ+jaKYM0MOrp6k9nLDFNDJUESat0FJBIYF0
	LhGBvw==
X-Google-Smtp-Source: 
 AGHT+IFttmTeAFp7rRNlCvGNA6c3f8HloQtXmzYtg/s+sWnJsGTKFqc7jLE1fU4ek1ihZeJfgcA+rA==
X-Received: by 2002:a17:902:ec83:b0:21f:5933:b3eb with SMTP id
 d9443c01a7336-22104087bc1mr237554135ad.31.1739969499276;
        Wed, 19 Feb 2025 04:51:39 -0800 (PST)
Received: from ws.. ([103.167.140.11])
        by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-220d536436fsm103427175ad.64.2025.02.19.04.51.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2025 04:51:38 -0800 (PST)
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
Subject: [PATCH net-next v10 05/13] net: ip_tunnel: Don't set tunnel->net in
 ip_tunnel_init()
Date: Wed, 19 Feb 2025 20:50:31 +0800
Message-ID: <20250219125039.18024-6-shaw.leon@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250219125039.18024-1-shaw.leon@gmail.com>
References: <20250219125039.18024-1-shaw.leon@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MailFrom: shaw.leon@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-0;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-1;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-2
Message-ID-Hash: 44PTBSWWPYN5XJLPI5FXOM7UVF6YSRJK
X-Message-ID-Hash: 44PTBSWWPYN5XJLPI5FXOM7UVF6YSRJK
X-Mailman-Approved-At: Wed, 19 Feb 2025 16:43:04 +0100
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/44PTBSWWPYN5XJLPI5FXOM7UVF6YSRJK/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

ip_tunnel_init() is called from register_netdevice(). In all code paths
reaching here, tunnel->net should already have been set (either in
ip_tunnel_newlink() or __ip_tunnel_create()). So don't set it again.

Signed-off-by: Xiao Liang <shaw.leon@gmail.com>
---
 net/ipv4/ip_tunnel.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/net/ipv4/ip_tunnel.c b/net/ipv4/ip_tunnel.c
index 09b73acf037a..dd4b4e5be998 100644
--- a/net/ipv4/ip_tunnel.c
+++ b/net/ipv4/ip_tunnel.c
@@ -1326,7 +1326,6 @@ int ip_tunnel_init(struct net_device *dev)
 	}
 
 	tunnel->dev = dev;
-	tunnel->net = dev_net(dev);
 	strscpy(tunnel->parms.name, dev->name);
 	iph->version		= 4;
 	iph->ihl		= 5;
-- 
2.48.1

