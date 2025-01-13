Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87312C02183
	for <batman-adv@archiver.kernel.org>; Mon, 13 Jan 2025 15:26:38 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id D302D841E5
	for <batman-adv@archiver.kernel.org>; Mon, 13 Jan 2025 16:26:36 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1736781996;
 b=Fxmp7/BXl9o8hYdNo5ZckIy/eKhmazTs4r4cuKG5+Nd6Bs+unQpkdu7ocZM8J7MzWC+3J
 kjGDg9e7mCP4XuWCYX730z1MygrGmhdVbEYP2U2rKgUwYP+GnfwLw7LoTgR2Q255fjf3f1I
 mTiGItl4VHDMJ986V8JCXR6AEXqSGiM=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1736781996; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=oQWEflIxWDAik4fl9hhH1GQo7B+/kKhdJ5eqx3FBJEo=;
 b=rPJHIOsT+j1OQQaeAeKcZc0CILkgtZY2eO8Z7TDk3U5I3RuwIBu/Usis+6uCFiq2Fm85t
 PM/99eryaksnDWvSIwp783M4Xk1aO7kDCB3DJsC28YqcJMOnYp35K56gi8rWObTCkWVmpOS
 LDSSDtMgHmaACUyGR95R+k/SV0OznkY=
ARC-Authentication-Results: i=2; open-mesh.org; dkim=pass header.d=gmail.com;
  arc=pass;
  dmarc=pass (Used From Domain Record) header.from=gmail.com
 policy.dmarc=quarantine
Authentication-Results: open-mesh.org; dkim=pass header.d=gmail.com; arc=pass;
 dmarc=pass (Used From Domain Record) header.from=gmail.com
 policy.dmarc=quarantine
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com
 [IPv6:2607:f8b0:4864:20::630])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id D781281D31
	for <b.a.t.m.a.n@lists.open-mesh.org>; Mon, 13 Jan 2025 15:38:31 +0100 (CET)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1736779111;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=oQWEflIxWDAik4fl9hhH1GQo7B+/kKhdJ5eqx3FBJEo=;
	b=M55274t6URMuvgpVuS33Bvh4ephHO9zIU2AWz2yP7i2UyeQmSH2L5+OO7iX1j06Hz6l7BV
	E8QX53/SQuKmKOgge11XorpJYx3x3MsCrqcNiaIRq4u3tInfWx2zyaP1Vp4ccKBhTw97Xq
	Y62iWCbIE3KEFnbMN5x0sYaEmW1ifcg=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=gmail.com header.s=20230601 header.b=l4nqPNBB;
	spf=pass (diktynna.open-mesh.org: domain of shaw.leon@gmail.com designates
 2607:f8b0:4864:20::630 as permitted sender)
 smtp.mailfrom=shaw.leon@gmail.com;
	dmarc=pass (policy=none) header.from=gmail.com
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1736779111; a=rsa-sha256;
	cv=none;
	b=Zc4G0fF6rwbS9UEHu8Adinh42wHXHo4cqFNCyGv+vkiZCx+jZs+z0f6wc97M0cjVMgRyK1
	L/KwHmFboy913GRbJhCOT4Fe0yEAzjBzAqydmRAJhR37T0O3tAQf7ozXDhS5zXeL9o149U
	+W99a3yzIcJG285yBqL0YxTnLrNL0WQ=
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-21636268e43so101764155ad.2
        for <b.a.t.m.a.n@lists.open-mesh.org>;
 Mon, 13 Jan 2025 06:38:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736779110; x=1737383910;
 darn=lists.open-mesh.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oQWEflIxWDAik4fl9hhH1GQo7B+/kKhdJ5eqx3FBJEo=;
        b=l4nqPNBBE1NfTf2+olkaCk4oeclHquLzqIUt5trG1xFvxtxSDr/NBAP8Y0MMVfhn8p
         fNFGnE6uKVW0RuO00QEGb0VKU0KeKY6iSJw6jBFQVi+1yzMbPs5f5DUxTBUjJ81qaFl0
         UNkjr5spMu3uP4QNhHUhzfxjOB5MsVloHhKnjheLzMbGPjmnvEKrg2NrP3Yd6J1JtsUB
         pwetyURE7nmmo9ns99H5TbSUCpzeen6/+4lNcGRiqblaQTopUq95Lt4cT/ZJJ0fmdsis
         BhhakEezBnr27T5zH7HRhiRgtin+cC8JYJMzZvjBfPxM6NVr3utrtRIFPbZgxO4FBoKA
         Pkhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736779110; x=1737383910;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oQWEflIxWDAik4fl9hhH1GQo7B+/kKhdJ5eqx3FBJEo=;
        b=lP2vyCibPAyBKYOSpG1rhx4KOxC4c4+3HJ4S/fi+fKFcWwurkSzVUD9/U+c9G4VHmk
         /Pl+iCWLeuhpmPIaOiwVPA7JFnb/IeU4S2aVA4dr//vPcPeX5ySdMYayI1/M5i/mVWcI
         YOSVx/KDTo/djRp0qGdV6T/8SO8mHwn5S1eTePJCayhaVv7j+y10JTTJn7xJLPBQce1E
         HkLb55Fho5tnlKI4OXaayFt8olqhn/9ANTN7SoF1J/Gcwr6cyP1pTbSXszGIANJ4x8N2
         ucA8bR0sbExp8oNv0LRmUPBcuyiwe/Dzg1DBEQ4WEtKgGyXW3LkXTB2ZEl77mWLuMy3X
         KmYg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXaHrKY/Etlmv80nFxB7IEY/sK1xkYlAMlza7j+uGNb3foLkAJhCpnb0+7T0LC+rnXkyxFougKDP9Qgtw==@lists.open-mesh.org
X-Gm-Message-State: AOJu0YwFfmiA5odQ/29rAbdfcvwJb6pjyHWh9dBDr7VaCPVaTpUADalA
	uJiqPV+zjkDlF6uAhV4jFG6viFQ4k/ae1hzoGpzyr0SKHAxQxUkc
X-Gm-Gg: ASbGncsMdMdZk9mGo8OEdkDMzzuYjXr4wc7Fh0vY2V8o7ym9dpvFGwF4M2jDs0DeJzj
	k2wrGwxqm0iCdIJ/KtNC1jRguMu2N1LuFZCPGFLFprR3hUHnu86cEni02AefHJWAOFS9lSs6ubd
	nNHPEmO4InaRFY4j1510tWLWuaqI/2CQJs17qT/VY7Gnb0Fcg6zmHOy/7qOPrRYLfSd7nvuRsXz
	uhm7p3FUevO0gmvCzMqO2sAYC98V63knHCTJZXsBQIqyHc=
X-Google-Smtp-Source: 
 AGHT+IH2EwVnyCLc0IdhYURoHcqSq8a7l1rdTlos+W9PilaFrNaXj6haYBmin4OcYsiFKO0gg5hkKA==
X-Received: by 2002:a17:902:dac6:b0:216:4a8a:2665 with SMTP id
 d9443c01a7336-21a84012a17mr321236845ad.50.1736779110291;
        Mon, 13 Jan 2025 06:38:30 -0800 (PST)
Received: from ws.. ([103.167.140.11])
        by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21a9f155e00sm54328715ad.103.2025.01.13.06.38.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2025 06:38:29 -0800 (PST)
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
Subject: [PATCH net-next v8 06/11] net: ipv6: Use link netns in newlink() of
 rtnl_link_ops
Date: Mon, 13 Jan 2025 22:37:14 +0800
Message-ID: <20250113143719.7948-7-shaw.leon@gmail.com>
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
Message-ID-Hash: GO3DSRFUUVYU6VWFUFON5FUSN6L6UHD5
X-Message-ID-Hash: GO3DSRFUUVYU6VWFUFON5FUSN6L6UHD5
X-Mailman-Approved-At: Mon, 13 Jan 2025 16:21:55 +0100
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/GO3DSRFUUVYU6VWFUFON5FUSN6L6UHD5/>
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

Set correct netns in priv before registering device, and avoid
overwriting it in ndo_init() path.

Signed-off-by: Xiao Liang <shaw.leon@gmail.com>
---
 net/ipv6/ip6_gre.c    | 20 ++++++++++----------
 net/ipv6/ip6_tunnel.c | 13 ++++++++-----
 net/ipv6/ip6_vti.c    | 10 ++++++----
 net/ipv6/sit.c        | 11 +++++++----
 4 files changed, 31 insertions(+), 23 deletions(-)

diff --git a/net/ipv6/ip6_gre.c b/net/ipv6/ip6_gre.c
index 863852abe8ea..108600dc716f 100644
--- a/net/ipv6/ip6_gre.c
+++ b/net/ipv6/ip6_gre.c
@@ -1498,7 +1498,8 @@ static int ip6gre_tunnel_init_common(struct net_device *dev)
 	tunnel = netdev_priv(dev);
 
 	tunnel->dev = dev;
-	tunnel->net = dev_net(dev);
+	if (!tunnel->net)
+		tunnel->net = dev_net(dev);
 	strcpy(tunnel->parms.name, dev->name);
 
 	ret = dst_cache_init(&tunnel->dst_cache, GFP_KERNEL);
@@ -1882,7 +1883,8 @@ static int ip6erspan_tap_init(struct net_device *dev)
 	tunnel = netdev_priv(dev);
 
 	tunnel->dev = dev;
-	tunnel->net = dev_net(dev);
+	if (!tunnel->net)
+		tunnel->net = dev_net(dev);
 	strcpy(tunnel->parms.name, dev->name);
 
 	ret = dst_cache_init(&tunnel->dst_cache, GFP_KERNEL);
@@ -1971,7 +1973,7 @@ static bool ip6gre_netlink_encap_parms(struct nlattr *data[],
 	return ret;
 }
 
-static int ip6gre_newlink_common(struct net *src_net, struct net_device *dev,
+static int ip6gre_newlink_common(struct net *link_net, struct net_device *dev,
 				 struct nlattr *tb[], struct nlattr *data[],
 				 struct netlink_ext_ack *extack)
 {
@@ -1992,7 +1994,7 @@ static int ip6gre_newlink_common(struct net *src_net, struct net_device *dev,
 		eth_hw_addr_random(dev);
 
 	nt->dev = dev;
-	nt->net = dev_net(dev);
+	nt->net = link_net;
 
 	err = register_netdevice(dev);
 	if (err)
@@ -2009,11 +2011,10 @@ static int ip6gre_newlink(struct net_device *dev,
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
 
@@ -2028,7 +2029,7 @@ static int ip6gre_newlink(struct net_device *dev,
 			return -EEXIST;
 	}
 
-	err = ip6gre_newlink_common(src_net, dev, tb, data, extack);
+	err = ip6gre_newlink_common(net, dev, tb, data, extack);
 	if (!err) {
 		ip6gre_tnl_link_config(nt, !tb[IFLA_MTU]);
 		ip6gre_tunnel_link_md(ign, nt);
@@ -2248,11 +2249,10 @@ static int ip6erspan_newlink(struct net_device *dev,
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
 
@@ -2268,7 +2268,7 @@ static int ip6erspan_newlink(struct net_device *dev,
 			return -EEXIST;
 	}
 
-	err = ip6gre_newlink_common(src_net, dev, tb, data, extack);
+	err = ip6gre_newlink_common(net, dev, tb, data, extack);
 	if (!err) {
 		ip6erspan_tnl_link_config(nt, !tb[IFLA_MTU]);
 		ip6erspan_tunnel_link_md(ign, nt);
diff --git a/net/ipv6/ip6_tunnel.c b/net/ipv6/ip6_tunnel.c
index 54b843d20870..2438dc627e02 100644
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
@@ -1878,7 +1877,8 @@ ip6_tnl_dev_init_gen(struct net_device *dev)
 	int t_hlen;
 
 	t->dev = dev;
-	t->net = dev_net(dev);
+	if (!t->net)
+		t->net = dev_net(dev);
 
 	ret = dst_cache_init(&t->dst_cache, GFP_KERNEL);
 	if (ret)
@@ -2008,13 +2008,16 @@ static int ip6_tnl_newlink(struct net_device *dev,
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
+	nt->net = net;
 
 	if (ip_tunnel_netlink_encap_parms(data, &ipencap)) {
 		err = ip6_tnl_encap_setup(nt, &ipencap);
diff --git a/net/ipv6/ip6_vti.c b/net/ipv6/ip6_vti.c
index 993f85aeb882..4aa1e7821951 100644
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
@@ -925,7 +924,8 @@ static inline int vti6_dev_init_gen(struct net_device *dev)
 	struct ip6_tnl *t = netdev_priv(dev);
 
 	t->dev = dev;
-	t->net = dev_net(dev);
+	if (!t->net)
+		t->net = dev_net(dev);
 	netdev_hold(dev, &t->dev_tracker, GFP_KERNEL);
 	netdev_lockdep_set_classes(dev);
 	return 0;
@@ -1002,13 +1002,15 @@ static int vti6_newlink(struct net_device *dev,
 			struct netlink_ext_ack *extack)
 {
 	struct nlattr **data = params->data;
-	struct net *net = dev_net(dev);
 	struct ip6_tnl *nt;
+	struct net *net;
 
+	net = params->link_net ? : dev_net(dev);
 	nt = netdev_priv(dev);
 	vti6_netlink_parms(data, &nt->parms);
 
 	nt->parms.proto = IPPROTO_IPV6;
+	nt->net = net;
 
 	if (vti6_locate(net, &nt->parms, 0))
 		return -EEXIST;
diff --git a/net/ipv6/sit.c b/net/ipv6/sit.c
index e2bd52cabdee..e870271ed04a 100644
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
@@ -270,6 +269,7 @@ static struct ip_tunnel *ipip6_tunnel_locate(struct net *net,
 	nt = netdev_priv(dev);
 
 	nt->parms = *parms;
+	nt->net = net;
 	if (ipip6_tunnel_create(dev) < 0)
 		goto failed_free;
 
@@ -1449,7 +1449,8 @@ static int ipip6_tunnel_init(struct net_device *dev)
 	int err;
 
 	tunnel->dev = dev;
-	tunnel->net = dev_net(dev);
+	if (!tunnel->net)
+		tunnel->net = dev_net(dev);
 	strcpy(tunnel->parms.name, dev->name);
 
 	ipip6_tunnel_bind_dev(dev);
@@ -1556,15 +1557,17 @@ static int ipip6_newlink(struct net_device *dev,
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
+	nt->net = net;
 
 	if (ip_tunnel_netlink_encap_parms(data, &ipencap)) {
 		err = ip_tunnel_encap_setup(nt, &ipencap);
-- 
2.47.1

