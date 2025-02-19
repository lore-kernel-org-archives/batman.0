Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8FE1C021AA
	for <batman@archiver.kernel.org>; Wed, 19 Feb 2025 15:50:02 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 4C5D2842AF
	for <batman@archiver.kernel.org>; Wed, 19 Feb 2025 16:50:01 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1739980201;
 b=jpew82C/zrXajMZ/KDF+w/iIQOqEapPx0rdX90cu41QsHIcQv4nIsntjnFqzYLw0/b5BU
 TaTU0y9/fCtXXJwj4gKksBKxy4KwFSSctbH4UJe25DeJuUSM8UgLVZzYFfHz75+CSJuAbN9
 pCKWYMALOLr3XwJPiFmK1HFaKcR+2m0=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1739980201; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=B6bozwwxLUJNxVW5ZYXuCA298+o6a+m5Om77EOnyIyg=;
 b=ImlLXpA1AFjIXoqj0L9K34/YP7wAW7YyUueNq5jFkmbmTErGGXg32QAeuwOOO+nTqlX83
 UjY9CbFXPwd57P9Hzv+Xt3sBLZQ/LdG4I3vrf4zvSaskGepQm+U5kF1X7WALJqYuyQd+AOp
 mBTALrA32AEcfZVKKlRAAg9HlSfgouU=
ARC-Authentication-Results: i=2; open-mesh.org; dkim=pass header.d=gmail.com;
  arc=pass;
  dmarc=pass (Used From Domain Record) header.from=gmail.com
 policy.dmarc=quarantine
Authentication-Results: open-mesh.org; dkim=pass header.d=gmail.com; arc=pass;
 dmarc=pass (Used From Domain Record) header.from=gmail.com
 policy.dmarc=quarantine
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com
 [IPv6:2607:f8b0:4864:20::634])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id C0EB983FA1
	for <b.a.t.m.a.n@lists.open-mesh.org>; Wed, 19 Feb 2025 13:51:58 +0100 (CET)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1739969518;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=B6bozwwxLUJNxVW5ZYXuCA298+o6a+m5Om77EOnyIyg=;
	b=CBQ6IxAwZwzHIQtZKyVviy2zmtbBP2A3FlyROvm3siTJnt9ApIbkjRhhF+AqNOPwmlDZpk
	A0YpHS/CJfJ//eGAixSHjZ51KI+p02AQO5f3t6DuRZfoj0tkjnlRbdLmmCIMrdGHMLXwT0
	fnXN+WjMGIhLieMG4OZkE7iCgoVdvRM=
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1739969518; a=rsa-sha256;
	cv=none;
	b=y925jTr3XgojEUHOHD/0uTYtA73uvxlg5lHtA3Y1fOoIiRh5kqek4QpuDTcObnETNByBwV
	xH3a/xGm0xwvExntbhgfpGQDks/GmCB6nMWKYsNLw0IimgY2XHtPbh/0VJt0Af+xKsHiwO
	UV8guxLdX2hAo4x/32ul0gJ5PTpfc9Q=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=gmail.com header.s=20230601 header.b="W9Fffvg/";
	spf=pass (diktynna.open-mesh.org: domain of shaw.leon@gmail.com designates
 2607:f8b0:4864:20::634 as permitted sender)
 smtp.mailfrom=shaw.leon@gmail.com;
	dmarc=pass (policy=none) header.from=gmail.com
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-2211acda7f6so77947155ad.3
        for <b.a.t.m.a.n@lists.open-mesh.org>;
 Wed, 19 Feb 2025 04:51:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739969517; x=1740574317;
 darn=lists.open-mesh.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B6bozwwxLUJNxVW5ZYXuCA298+o6a+m5Om77EOnyIyg=;
        b=W9Fffvg/9K+KSHmIxMb1DIORvVBKRUSPfze3e3enhNr/r5a59L2+chfCYyCsUgYFpr
         5EMYO1zPQdqfNrNn4JeqZYV7qx8XfAHBf3jswNhVYGV8dgKriPtyFbgZDuvScZZ2//BS
         uLARfQT50ZgZA3iBV9qX+hi6ZsJR6z+7mG+PdrSin6KnubegTfb6k6/8rOrx5zXI6DzD
         y0GnbKU/0G2xhKAine9Mf6O4KkEuQqHN5d1G3/2QqptZq8HBX7Vnzbpj5KAUEoHdYI5F
         R3sWvMCzK+6url96eSY6HG7ImK4NdGLx6EDG+JkI6tl0FFu5q9IChv0tp/+iqWvULJD1
         cytw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739969517; x=1740574317;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B6bozwwxLUJNxVW5ZYXuCA298+o6a+m5Om77EOnyIyg=;
        b=fgcQGoS2o0/gw9zhZ+auHA1EJdXiInwhn2JbU8EFc3ij9DQjl161yU+1QoEBRX+1tD
         WyepYgG+BGbsVMC7/ePW1ETYSb8lmnHjx/kGglBjiGgRLP0qCcKj57wNB+jbyfHg653C
         KyfJD7jfOYUGuMVICdE260DSDJTX0PJwq+jADjwirPSluFNH1w1EwCyDb+50cln5Ciko
         JPrTC85t2HQU+V+NVgDQ7c4RJRfHdoRVntmHIEkdldGHtQ/1ypM++MHHGBoa7JuBrRha
         01nIncsDmPs5tQGDyNSUKt7DDWS+7xbhbhrQSnZIaGiXkV3P9lj2WZReo0lfvHA/f3CB
         oVJw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV4wu+qxe2hsPDZZoQo7HUnuX3W7kWlM7VQyD3Tv2peYD9hBgJOOd/4FjUWTxEEu85lXoW7Fl6ecjWHxg==@lists.open-mesh.org
X-Gm-Message-State: AOJu0YzMmEyxpKDYIPv0KPwy93gFj7Jp0yh+iDrjh5JAq8ea6DhTiSMU
	2//GGXB+qs9RRLVss6fsJIj00IbVDvGmsrXEXG8NlT5HfDYxsEtC
X-Gm-Gg: ASbGnctwCjYzfOS23fU8m9omd9yOH6Wk2yXo4OHQBPN8o1gU8TJ2/vxIo0uLImXSNvi
	P0S4gXqjeR1bGEVr4x3BtJezd2aARmjIQ8khHJhnzkqBg5pISfvvyaPqyfHO/I4EaSYu20Rrnwk
	nDIw1OVA7i4VajA8Yn5hvGCeCh6vW3LhqeCalvXmLVu3nHrA8sjUXhKyY3B5/VhKS7DGNdlEMgP
	Oczgg8DYQYy5Kz7JZ+WsdLYA94BJgo7gZIxOdZq+0KmbPLTtK9N3K6AMgJGpGmdkhGWB6EbVOA2
	V8uLSA==
X-Google-Smtp-Source: 
 AGHT+IGKxW3/SlkXIFQ/R+7OZM2jJGBrIehyvby3inig7425vAO11UDlInuUnZBsT6heGdokKuXecQ==
X-Received: by 2002:a17:903:2305:b0:220:fce7:d3b8 with SMTP id
 d9443c01a7336-221709654admr66486875ad.12.1739969517203;
        Wed, 19 Feb 2025 04:51:57 -0800 (PST)
Received: from ws.. ([103.167.140.11])
        by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-220d536436fsm103427175ad.64.2025.02.19.04.51.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2025 04:51:56 -0800 (PST)
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
Subject: [PATCH net-next v10 07/13] net: ipv6: Init tunnel link-netns before
 registering dev
Date: Wed, 19 Feb 2025 20:50:33 +0800
Message-ID: <20250219125039.18024-8-shaw.leon@gmail.com>
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
Message-ID-Hash: FU2F2X6GIBDWDKDNUAG2F7S5W6N5SJSV
X-Message-ID-Hash: FU2F2X6GIBDWDKDNUAG2F7S5W6N5SJSV
X-Mailman-Approved-At: Wed, 19 Feb 2025 16:43:04 +0100
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/FU2F2X6GIBDWDKDNUAG2F7S5W6N5SJSV/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

Currently some IPv6 tunnel drivers set tnl->net to dev_net(dev) in
ndo_init(), which is called in register_netdevice(). However, it lacks
the context of link-netns when we enable cross-net tunnels at device
registration time.

Let's move the init of tunnel link-netns before register_netdevice().

ip6_gre has already initialized netns, so just remove the redundant
assignment.

Signed-off-by: Xiao Liang <shaw.leon@gmail.com>
---
 net/ipv6/ip6_gre.c    | 2 --
 net/ipv6/ip6_tunnel.c | 3 ++-
 net/ipv6/ip6_vti.c    | 3 ++-
 net/ipv6/sit.c        | 8 +++++---
 4 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/net/ipv6/ip6_gre.c b/net/ipv6/ip6_gre.c
index 863852abe8ea..d9e6b1fd9917 100644
--- a/net/ipv6/ip6_gre.c
+++ b/net/ipv6/ip6_gre.c
@@ -1498,7 +1498,6 @@ static int ip6gre_tunnel_init_common(struct net_device *dev)
 	tunnel = netdev_priv(dev);
 
 	tunnel->dev = dev;
-	tunnel->net = dev_net(dev);
 	strcpy(tunnel->parms.name, dev->name);
 
 	ret = dst_cache_init(&tunnel->dst_cache, GFP_KERNEL);
@@ -1882,7 +1881,6 @@ static int ip6erspan_tap_init(struct net_device *dev)
 	tunnel = netdev_priv(dev);
 
 	tunnel->dev = dev;
-	tunnel->net = dev_net(dev);
 	strcpy(tunnel->parms.name, dev->name);
 
 	ret = dst_cache_init(&tunnel->dst_cache, GFP_KERNEL);
diff --git a/net/ipv6/ip6_tunnel.c b/net/ipv6/ip6_tunnel.c
index 54b843d20870..111a8777c2f7 100644
--- a/net/ipv6/ip6_tunnel.c
+++ b/net/ipv6/ip6_tunnel.c
@@ -1878,7 +1878,6 @@ ip6_tnl_dev_init_gen(struct net_device *dev)
 	int t_hlen;
 
 	t->dev = dev;
-	t->net = dev_net(dev);
 
 	ret = dst_cache_init(&t->dst_cache, GFP_KERNEL);
 	if (ret)
@@ -1940,6 +1939,7 @@ static int __net_init ip6_fb_tnl_dev_init(struct net_device *dev)
 	struct net *net = dev_net(dev);
 	struct ip6_tnl_net *ip6n = net_generic(net, ip6_tnl_net_id);
 
+	t->net = net;
 	t->parms.proto = IPPROTO_IPV6;
 
 	rcu_assign_pointer(ip6n->tnls_wc[0], t);
@@ -2015,6 +2015,7 @@ static int ip6_tnl_newlink(struct net_device *dev,
 	int err;
 
 	nt = netdev_priv(dev);
+	nt->net = net;
 
 	if (ip_tunnel_netlink_encap_parms(data, &ipencap)) {
 		err = ip6_tnl_encap_setup(nt, &ipencap);
diff --git a/net/ipv6/ip6_vti.c b/net/ipv6/ip6_vti.c
index 993f85aeb882..16e0d74f99dd 100644
--- a/net/ipv6/ip6_vti.c
+++ b/net/ipv6/ip6_vti.c
@@ -925,7 +925,6 @@ static inline int vti6_dev_init_gen(struct net_device *dev)
 	struct ip6_tnl *t = netdev_priv(dev);
 
 	t->dev = dev;
-	t->net = dev_net(dev);
 	netdev_hold(dev, &t->dev_tracker, GFP_KERNEL);
 	netdev_lockdep_set_classes(dev);
 	return 0;
@@ -958,6 +957,7 @@ static int __net_init vti6_fb_tnl_dev_init(struct net_device *dev)
 	struct net *net = dev_net(dev);
 	struct vti6_net *ip6n = net_generic(net, vti6_net_id);
 
+	t->net = net;
 	t->parms.proto = IPPROTO_IPV6;
 
 	rcu_assign_pointer(ip6n->tnls_wc[0], t);
@@ -1009,6 +1009,7 @@ static int vti6_newlink(struct net_device *dev,
 	vti6_netlink_parms(data, &nt->parms);
 
 	nt->parms.proto = IPPROTO_IPV6;
+	nt->net = net;
 
 	if (vti6_locate(net, &nt->parms, 0))
 		return -EEXIST;
diff --git a/net/ipv6/sit.c b/net/ipv6/sit.c
index e2bd52cabdee..20453671ac50 100644
--- a/net/ipv6/sit.c
+++ b/net/ipv6/sit.c
@@ -269,6 +269,7 @@ static struct ip_tunnel *ipip6_tunnel_locate(struct net *net,
 
 	nt = netdev_priv(dev);
 
+	nt->net = net;
 	nt->parms = *parms;
 	if (ipip6_tunnel_create(dev) < 0)
 		goto failed_free;
@@ -1449,7 +1450,6 @@ static int ipip6_tunnel_init(struct net_device *dev)
 	int err;
 
 	tunnel->dev = dev;
-	tunnel->net = dev_net(dev);
 	strcpy(tunnel->parms.name, dev->name);
 
 	ipip6_tunnel_bind_dev(dev);
@@ -1565,6 +1565,7 @@ static int ipip6_newlink(struct net_device *dev,
 	int err;
 
 	nt = netdev_priv(dev);
+	nt->net = net;
 
 	if (ip_tunnel_netlink_encap_parms(data, &ipencap)) {
 		err = ip_tunnel_encap_setup(nt, &ipencap);
@@ -1860,6 +1861,9 @@ static int __net_init sit_init_net(struct net *net)
 	 */
 	sitn->fb_tunnel_dev->netns_local = true;
 
+	t = netdev_priv(sitn->fb_tunnel_dev);
+	t->net = net;
+
 	err = register_netdev(sitn->fb_tunnel_dev);
 	if (err)
 		goto err_reg_dev;
@@ -1867,8 +1871,6 @@ static int __net_init sit_init_net(struct net *net)
 	ipip6_tunnel_clone_6rd(sitn->fb_tunnel_dev, sitn);
 	ipip6_fb_tunnel_init(sitn->fb_tunnel_dev);
 
-	t = netdev_priv(sitn->fb_tunnel_dev);
-
 	strcpy(t->parms.name, sitn->fb_tunnel_dev->name);
 	return 0;
 
-- 
2.48.1

