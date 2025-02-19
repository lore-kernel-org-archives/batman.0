Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 371C8C021AA
	for <batman@archiver.kernel.org>; Wed, 19 Feb 2025 15:51:01 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id CB30B841FF
	for <batman@archiver.kernel.org>; Wed, 19 Feb 2025 16:50:59 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1739980259;
 b=c/rEK3btksYl+oCtvoaWcVKBH6vClmY7PWupMf2lZdC35IAHr5bDrmxUa3CUmodB4lpSF
 Roysc9Y+y9Lqj34uax+59O+gyo6AIwP3+omlQ4tIDb6+01vCSJ9yjXwSiFUVRYUA72qp785
 gWEkHX8kgSJB/2xHqG5Dy1pNADoZ24I=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1739980259; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=rsYd7KiB2vQaWNh0ASWhN8pl6PDFq3SaA7EkmHtk6YM=;
 b=n3jMynuVkdcibJW08HbfeN6d391jIG2V3mj2jUbfvZo9gUq++wtH3P514zD+nWTGoLDDR
 B/08JXZXK6n6UZ7WRx/CqjAJDGCFkyzgvXf+0bEBhe4zLgMGHj6+lsgvp3BIJCPJt3AzT25
 3v79SOwIAG48N/bN0rJEGYLQLBKzltU=
ARC-Authentication-Results: i=2; open-mesh.org; dkim=pass header.d=gmail.com;
  arc=pass;
  dmarc=pass (Used From Domain Record) header.from=gmail.com
 policy.dmarc=quarantine
Authentication-Results: open-mesh.org; dkim=pass header.d=gmail.com; arc=pass;
 dmarc=pass (Used From Domain Record) header.from=gmail.com
 policy.dmarc=quarantine
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com
 [IPv6:2607:f8b0:4864:20::636])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id A7C2883F16
	for <b.a.t.m.a.n@lists.open-mesh.org>; Wed, 19 Feb 2025 13:52:07 +0100 (CET)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1739969527;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=rsYd7KiB2vQaWNh0ASWhN8pl6PDFq3SaA7EkmHtk6YM=;
	b=bLJzBwjGqdaTawKTWStDCIr4ThtAlNPWkg11MMPkTXNYcMwmqs4Awms3Vh0/bCLlBf0WhJ
	Hrb7+7ff9Bpl+k8ziNo7ZK+VML+R/7RM7kSbik31mqdbbsXjhzGDt8wJ8VfdtD4QYB2OKU
	4FmhhgkHm7/glwiX1qVTO4XijeUtwjE=
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1739969527; a=rsa-sha256;
	cv=none;
	b=WpLxAGTyJBjF5bdvlZKgS3Z9CMvZHNJtZW8yHlOOwVlp3MWvQ8eK6Hs1BucjcxtgHGGAvs
	AOZ5/1P4ZKXwWqsB5wSNbf13ffLuScPn6Pq65sjZoVCWfFMFntTbn34JiYHkeJ23I7Thih
	/RsAqxW6vRSLWQwBOhlcUIz9cDqd434=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=gmail.com header.s=20230601 header.b="Y/u1GXGL";
	spf=pass (diktynna.open-mesh.org: domain of shaw.leon@gmail.com designates
 2607:f8b0:4864:20::636 as permitted sender)
 smtp.mailfrom=shaw.leon@gmail.com;
	dmarc=pass (policy=none) header.from=gmail.com
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-220c8eb195aso135167875ad.0
        for <b.a.t.m.a.n@lists.open-mesh.org>;
 Wed, 19 Feb 2025 04:52:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739969526; x=1740574326;
 darn=lists.open-mesh.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rsYd7KiB2vQaWNh0ASWhN8pl6PDFq3SaA7EkmHtk6YM=;
        b=Y/u1GXGLQtMKYQxFIgymSpLFouS2y1RXrSk2VkbNExNWTm7dY6FMwByr+vhAwEtGpF
         3tdDlQUh8rlbRSXs4MmhcAcsBuJb4HTE9Lr22m359NH6UK22rIicvZfqhXHctlS9asAD
         S2oIPTLYs+JagxVUQptLz2XdoOvYOrEjGG1TUZpziMl18y/pQ5z9h7GU4XpJg5Xm+0nt
         IqhcWlSyvxg87cSPKRSgfAVn5q/DMEAGTBQDp6Aj9ZYG5+ZBpHd7ub2KqE2DcvBAll4f
         /jR8YVD8h9JIj8EWhKpCe9nCHxgY3578TGSwqL2a4K/R31gcA6SLQeH/M5A3UvrmVFpW
         pC8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739969526; x=1740574326;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rsYd7KiB2vQaWNh0ASWhN8pl6PDFq3SaA7EkmHtk6YM=;
        b=AlnO/eB3ad62Vz9BiZ32fudRWPi6iFqJY99h+eH0QIMEEiHo41SqTdA/aEytJwoF+E
         b0IuCOOJdc4CG/ZCAKjuO14xJqbXSoGCPyRb3dShsKlnFFHFYRtoo/pXd2Jwuqe0DAr0
         HQpQV7wuX7fnWmyczJcLJaNZbCs9XYDSSTSPlM1j1d9M+s5t3PVW8YOAapoRLc72cuRQ
         O7Zh6wgZ8g9XlNsoxslDgvE+cRdTXBHhqUm9vAPA/0SStS0ZKHWbim36jsqaBivWR07g
         Z/73pCg0lHbqRfwq8jIGxchNBaeDT+rjRecwNzk5KG+EfgAZDz7lWhufueGEVq0xas4y
         uG4A==
X-Forwarded-Encrypted: i=1;
 AJvYcCW/ktBx9P54s3OhuFGSzcZl4C/LoMqmaEOYHquXqnw2AxixPSxsJZ46x971UMm670qzP4mmx013xPbF7w==@lists.open-mesh.org
X-Gm-Message-State: AOJu0Yxxh2ei0y6JCnzeQmIgF6AAqnlZzfe5a7VCdF+3kbu9JhG9P9Xu
	+YJvZYeIclZFa0vUVygFm9wCRER/0RbaDhNU3XJo0T+I3YJ4tE12
X-Gm-Gg: ASbGncuBHUkksoLg+bo0IDRWj8mZueOxc9htD2MlwC6Flj5CrcIqGZq7LJ3iHXPpFWr
	ripMGoAO7ZwI7KBcG6uwmTetGoTktL7Vb4kD+/tSYJWdDo5QBR5IiqRv/T0mRE6ySCuhunoUSW9
	DUh+MjCA7b1PDlSz9HyCiH0RNCTsG6QV8xDovgJWzgiHcyEIEXyW4AnTNi9ONBa5ouool1s/uoA
	SmhO1EPqYu7aSGOOjjqJB752+4mlaP9mjCMh6KbtVTIrPa3CuvxFOn9anCPH4E+Simv+zXVshef
	g2cdGg==
X-Google-Smtp-Source: 
 AGHT+IEmzyu5IbJEeeDhw+tXRaZzlcx6HaVQuXOtrNDJjpviTChMhHRF4glLxd0ys0/eE/gPyp4KqQ==
X-Received: by 2002:a17:902:db0a:b0:21f:8677:5961 with SMTP id
 d9443c01a7336-2217119d382mr58688885ad.34.1739969526138;
        Wed, 19 Feb 2025 04:52:06 -0800 (PST)
Received: from ws.. ([103.167.140.11])
        by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-220d536436fsm103427175ad.64.2025.02.19.04.51.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2025 04:52:05 -0800 (PST)
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
Subject: [PATCH net-next v10 08/13] net: ipv6: Use link netns in newlink() of
 rtnl_link_ops
Date: Wed, 19 Feb 2025 20:50:34 +0800
Message-ID: <20250219125039.18024-9-shaw.leon@gmail.com>
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
Message-ID-Hash: 7CGDEVYWAPY3ZOZUU4QOMB2UPYFAP3NZ
X-Message-ID-Hash: 7CGDEVYWAPY3ZOZUU4QOMB2UPYFAP3NZ
X-Mailman-Approved-At: Wed, 19 Feb 2025 16:43:04 +0100
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/7CGDEVYWAPY3ZOZUU4QOMB2UPYFAP3NZ/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

When link_net is set, use it as link netns instead of dev_net(). This
prepares for rtnetlink core to create device in target netns directly,
in which case the two namespaces may be different.

Signed-off-by: Xiao Liang <shaw.leon@gmail.com>
---
 net/ipv6/ip6_gre.c    | 14 ++++++--------
 net/ipv6/ip6_tunnel.c |  9 +++++----
 net/ipv6/ip6_vti.c    |  6 +++---
 net/ipv6/sit.c        |  6 +++---
 4 files changed, 17 insertions(+), 18 deletions(-)

diff --git a/net/ipv6/ip6_gre.c b/net/ipv6/ip6_gre.c
index d9e6b1fd9917..d31a4ce3b19f 100644
--- a/net/ipv6/ip6_gre.c
+++ b/net/ipv6/ip6_gre.c
@@ -1969,7 +1969,7 @@ static bool ip6gre_netlink_encap_parms(struct nlattr *data[],
 	return ret;
 }
 
-static int ip6gre_newlink_common(struct net *src_net, struct net_device *dev,
+static int ip6gre_newlink_common(struct net *link_net, struct net_device *dev,
 				 struct nlattr *tb[], struct nlattr *data[],
 				 struct netlink_ext_ack *extack)
 {
@@ -1990,7 +1990,7 @@ static int ip6gre_newlink_common(struct net *src_net, struct net_device *dev,
 		eth_hw_addr_random(dev);
 
 	nt->dev = dev;
-	nt->net = dev_net(dev);
+	nt->net = link_net;
 
 	err = register_netdevice(dev);
 	if (err)
@@ -2007,11 +2007,10 @@ static int ip6gre_newlink(struct net_device *dev,
 			  struct rtnl_newlink_params *params,
 			  struct netlink_ext_ack *extack)
 {
+	struct net *net = params->link_net ? : dev_net(dev);
 	struct ip6_tnl *nt = netdev_priv(dev);
 	struct nlattr **data = params->data;
-	struct net *src_net = params->net;
 	struct nlattr **tb = params->tb;
-	struct net *net = dev_net(dev);
 	struct ip6gre_net *ign;
 	int err;
 
@@ -2026,7 +2025,7 @@ static int ip6gre_newlink(struct net_device *dev,
 			return -EEXIST;
 	}
 
-	err = ip6gre_newlink_common(src_net, dev, tb, data, extack);
+	err = ip6gre_newlink_common(net, dev, tb, data, extack);
 	if (!err) {
 		ip6gre_tnl_link_config(nt, !tb[IFLA_MTU]);
 		ip6gre_tunnel_link_md(ign, nt);
@@ -2246,11 +2245,10 @@ static int ip6erspan_newlink(struct net_device *dev,
 			     struct rtnl_newlink_params *params,
 			     struct netlink_ext_ack *extack)
 {
+	struct net *net = params->link_net ? : dev_net(dev);
 	struct ip6_tnl *nt = netdev_priv(dev);
 	struct nlattr **data = params->data;
-	struct net *src_net = params->net;
 	struct nlattr **tb = params->tb;
-	struct net *net = dev_net(dev);
 	struct ip6gre_net *ign;
 	int err;
 
@@ -2266,7 +2264,7 @@ static int ip6erspan_newlink(struct net_device *dev,
 			return -EEXIST;
 	}
 
-	err = ip6gre_newlink_common(src_net, dev, tb, data, extack);
+	err = ip6gre_newlink_common(net, dev, tb, data, extack);
 	if (!err) {
 		ip6erspan_tnl_link_config(nt, !tb[IFLA_MTU]);
 		ip6erspan_tunnel_link_md(ign, nt);
diff --git a/net/ipv6/ip6_tunnel.c b/net/ipv6/ip6_tunnel.c
index 111a8777c2f7..89d206731af0 100644
--- a/net/ipv6/ip6_tunnel.c
+++ b/net/ipv6/ip6_tunnel.c
@@ -253,8 +253,7 @@ static void ip6_dev_free(struct net_device *dev)
 static int ip6_tnl_create2(struct net_device *dev)
 {
 	struct ip6_tnl *t = netdev_priv(dev);
-	struct net *net = dev_net(dev);
-	struct ip6_tnl_net *ip6n = net_generic(net, ip6_tnl_net_id);
+	struct ip6_tnl_net *ip6n = net_generic(t->net, ip6_tnl_net_id);
 	int err;
 
 	dev->rtnl_link_ops = &ip6_link_ops;
@@ -2008,12 +2007,14 @@ static int ip6_tnl_newlink(struct net_device *dev,
 {
 	struct nlattr **data = params->data;
 	struct nlattr **tb = params->tb;
-	struct net *net = dev_net(dev);
-	struct ip6_tnl_net *ip6n = net_generic(net, ip6_tnl_net_id);
 	struct ip_tunnel_encap ipencap;
+	struct ip6_tnl_net *ip6n;
 	struct ip6_tnl *nt, *t;
+	struct net *net;
 	int err;
 
+	net = params->link_net ? : dev_net(dev);
+	ip6n = net_generic(net, ip6_tnl_net_id);
 	nt = netdev_priv(dev);
 	nt->net = net;
 
diff --git a/net/ipv6/ip6_vti.c b/net/ipv6/ip6_vti.c
index 16e0d74f99dd..83c055996fbb 100644
--- a/net/ipv6/ip6_vti.c
+++ b/net/ipv6/ip6_vti.c
@@ -177,8 +177,7 @@ vti6_tnl_unlink(struct vti6_net *ip6n, struct ip6_tnl *t)
 static int vti6_tnl_create2(struct net_device *dev)
 {
 	struct ip6_tnl *t = netdev_priv(dev);
-	struct net *net = dev_net(dev);
-	struct vti6_net *ip6n = net_generic(net, vti6_net_id);
+	struct vti6_net *ip6n = net_generic(t->net, vti6_net_id);
 	int err;
 
 	dev->rtnl_link_ops = &vti6_link_ops;
@@ -1002,9 +1001,10 @@ static int vti6_newlink(struct net_device *dev,
 			struct netlink_ext_ack *extack)
 {
 	struct nlattr **data = params->data;
-	struct net *net = dev_net(dev);
 	struct ip6_tnl *nt;
+	struct net *net;
 
+	net = params->link_net ? : dev_net(dev);
 	nt = netdev_priv(dev);
 	vti6_netlink_parms(data, &nt->parms);
 
diff --git a/net/ipv6/sit.c b/net/ipv6/sit.c
index 20453671ac50..f7b59bc957d3 100644
--- a/net/ipv6/sit.c
+++ b/net/ipv6/sit.c
@@ -201,8 +201,7 @@ static void ipip6_tunnel_clone_6rd(struct net_device *dev, struct sit_net *sitn)
 static int ipip6_tunnel_create(struct net_device *dev)
 {
 	struct ip_tunnel *t = netdev_priv(dev);
-	struct net *net = dev_net(dev);
-	struct sit_net *sitn = net_generic(net, sit_net_id);
+	struct sit_net *sitn = net_generic(t->net, sit_net_id);
 	int err;
 
 	__dev_addr_set(dev, &t->parms.iph.saddr, 4);
@@ -1556,14 +1555,15 @@ static int ipip6_newlink(struct net_device *dev,
 {
 	struct nlattr **data = params->data;
 	struct nlattr **tb = params->tb;
-	struct net *net = dev_net(dev);
 	struct ip_tunnel *nt;
 	struct ip_tunnel_encap ipencap;
 #ifdef CONFIG_IPV6_SIT_6RD
 	struct ip_tunnel_6rd ip6rd;
 #endif
+	struct net *net;
 	int err;
 
+	net = params->link_net ? : dev_net(dev);
 	nt = netdev_priv(dev);
 	nt->net = net;
 
-- 
2.48.1

