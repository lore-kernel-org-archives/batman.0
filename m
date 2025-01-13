Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E6ECC02180
	for <batman-adv@archiver.kernel.org>; Mon, 13 Jan 2025 15:24:13 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 0201E8408A
	for <batman-adv@archiver.kernel.org>; Mon, 13 Jan 2025 16:24:12 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1736781852;
 b=TNYpJjgqRpiDw5EDXISfNN7cIHNCFXiZ81sTR5/mO23YHJ/9K84l5OTpCSAcxY6G2eXnF
 HJHZY2zr0OLDLwzIIhTMSJl4NI4Uxlvg+n6tg12q24W8mpF6twcVf5dX3sIvS1zxuuMg16l
 LHsAMPDi7UNUeZ+5155NJap+/dgUGOs=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1736781852; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=LZBCyw57IE7Zso6/WsMTOb7GBu1vP4ikeykgITmoGTY=;
 b=32S26oanT4qNJsXSy2W/UAN5+r99dWf7gYmhEtQmmyM1HCGyD6ycYIFy4zD38UMqubt4Z
 6xXm7Ar/hdtPNuATDp68n1XnlmtzIYUc/PmItYSk8DFxmLbAQavtvQzPiAA8k0AgAjusfyO
 HF2sMP07mnEBz0agn18m3yQ9JKpHY74=
ARC-Authentication-Results: i=2; open-mesh.org; dkim=pass header.d=gmail.com;
  arc=pass;
  dmarc=pass (Used From Domain Record) header.from=gmail.com
 policy.dmarc=quarantine
Authentication-Results: open-mesh.org; dkim=pass header.d=gmail.com; arc=pass;
 dmarc=pass (Used From Domain Record) header.from=gmail.com
 policy.dmarc=quarantine
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com
 [IPv6:2607:f8b0:4864:20::62d])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 1EDCB81B29
	for <b.a.t.m.a.n@lists.open-mesh.org>; Mon, 13 Jan 2025 15:38:06 +0100 (CET)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1736779086;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=LZBCyw57IE7Zso6/WsMTOb7GBu1vP4ikeykgITmoGTY=;
	b=J6xrQQBp4s4IkRunWZSJX5D0gpeEQdGw4NtbqE1RfLfgPm7rzJz4kGRWc/XoOebZNYGwwh
	d9dvpulCKIfEz2BOQ/kGTSE3DcX1fvjr7UPAym94nkShl27z0j2dLtrwyLubwyea/4FklF
	qfnW5zEUXD1A5l7F0rpJhmFvdzpBLyM=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=gmail.com header.s=20230601 header.b=c2kBV3+H;
	spf=pass (diktynna.open-mesh.org: domain of shaw.leon@gmail.com designates
 2607:f8b0:4864:20::62d as permitted sender)
 smtp.mailfrom=shaw.leon@gmail.com;
	dmarc=pass (policy=none) header.from=gmail.com
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1736779086; a=rsa-sha256;
	cv=none;
	b=h0Z43fGU/+kRS0Bxw6GALm84mpoojHytzJmoEiPsN4SJmg05jcjxEYkDvh+A/Kch7lbl+0
	baCQi1Yy04OeYbhBX8XVSmYJoPgCOrnP5Sf6qQhqctmVg+fU0hlJwh/2LCWnYicuMIW/ln
	hV0vp9vKykTTIeKp02GHx0SBDOQUfrk=
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-21628b3fe7dso73457845ad.3
        for <b.a.t.m.a.n@lists.open-mesh.org>;
 Mon, 13 Jan 2025 06:38:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736779084; x=1737383884;
 darn=lists.open-mesh.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LZBCyw57IE7Zso6/WsMTOb7GBu1vP4ikeykgITmoGTY=;
        b=c2kBV3+Hm5lXtK+A3CzFV4Lr1yjG0pmhgsO47yRLBflWCqs+ISkCDdEt+DB7ESi8RN
         51CaJcjeWYNGwh59YTvYHkLOVzo1TMEvbHYNJgf/4HTyRnGA/3DHb5QgNpleZgXq8DoX
         a3BrYhM7vMlG0WMjSd6J14G0Mt3xcGWhPjflOInZUovcJiPSw7oaKRKrWOQgyIHft0GA
         ogM+UUWRkyn+uefVrcN0UMfOnQC6Sh4wQEG3XRNnfE4oF4VdAavvikENjgJANuvQFb77
         jrvpekrrlkxnu52Bp5A4hEuL0qNwTgIk5tO8gjAM547uyclED0E6pKgHgiUTzSZ6MbzF
         gVyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736779084; x=1737383884;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LZBCyw57IE7Zso6/WsMTOb7GBu1vP4ikeykgITmoGTY=;
        b=KOWR/VI/0HMaOe8ARozRwMMF2xFQuBl0JLLksHbmT3TxwcwQKFr0cdrvCSWnpsWWEW
         qUO7T5dwbv8tSH4LN7DzvCMmCE2ZyktXjUwcyc0Qh84UzDDkj9mMQ+vlGyiGqMK7txm4
         ek2Zt+5NLFj8z/IzteqCXbEnaegSP50tdkE7ZLbaLRqjDBXvMhuB7xo4amagWIq2lUFj
         d0EW+GwZ05kuE5Rp9El14Vjj4rdsGTVk8IINmUL4S7SnmSPdVj1+gHk6ALtKi95NL+bA
         071TxKhRoZpGmOnZ5FmuV9adeD2B4xj8GVjq5z34ytwsPUAtAiXnovyslOd565qXKtGS
         nbXA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUHn7lAG1TKuM8osXx0WaAMB20Dtu338ggPQ9umSdU8WbFXmjgG2qqZc8sIBb34h/ZGLXAYcP8goBYMpg==@lists.open-mesh.org
X-Gm-Message-State: AOJu0YyeXi/fKrfW4ll6WhTUDdj16XzsO1HrQEyFgV7W/zucTtER6VUP
	NeEQLvH3RS1qYpq1Hxc6lFNwf2E208MLcKrhWpBrfxQp0mUFy6oJ
X-Gm-Gg: ASbGnctontpPdSSOw+OxnZ912Mnlb6xX8k475ttq2I4fjQyLAvi4Yl8VFQ2e69qhym7
	yAPmQV3D8fbE32cyGdwUSlMNFneU1ScwfN+dfYoUbVW2BkS1bheRSB9IzQyXqVJDC1+gC9ZROVm
	fGIxxb6fHxRPy/PrpCyeRWJoopRnTNq0fL9ZaChwOz02w7UjMNufBCqYTVbrdvwVBZIjFiB73Pj
	oA4dJARl/xk+tUAqchQaeVCeZgjEs0z9a+9ENg97za1Vg4=
X-Google-Smtp-Source: 
 AGHT+IE+8qVbma2Qb/CZO5qK/8pf/aA+GET4Kf+ksPfd0XQFxcjbmABnzOsLzbZBSWi1j8h4JBn4Hg==
X-Received: by 2002:a17:903:32ce:b0:215:b8c6:338a with SMTP id
 d9443c01a7336-21a83f338a5mr322037415ad.4.1736779084410;
        Mon, 13 Jan 2025 06:38:04 -0800 (PST)
Received: from ws.. ([103.167.140.11])
        by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21a9f155e00sm54328715ad.103.2025.01.13.06.37.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2025 06:38:03 -0800 (PST)
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
Subject: [PATCH net-next v8 03/11] net: Use link netns in newlink() of
 rtnl_link_ops
Date: Mon, 13 Jan 2025 22:37:11 +0800
Message-ID: <20250113143719.7948-4-shaw.leon@gmail.com>
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
Message-ID-Hash: MFYLYPRM2OVIQFP2BFHH3YXRRBZWJQP3
X-Message-ID-Hash: MFYLYPRM2OVIQFP2BFHH3YXRRBZWJQP3
X-Mailman-Approved-At: Mon, 13 Jan 2025 16:21:55 +0100
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/MFYLYPRM2OVIQFP2BFHH3YXRRBZWJQP3/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

These netdevice drivers already uses netns parameter in newlink()
callback. Convert them to use rtnl_newlink_link_net() or
rtnl_newlink_peer_net() for clarity and deprecate params->net.

Signed-off-by: Xiao Liang <shaw.leon@gmail.com>
---
 drivers/infiniband/ulp/ipoib/ipoib_netlink.c       | 4 ++--
 drivers/net/amt.c                                  | 6 +++---
 drivers/net/bareudp.c                              | 4 ++--
 drivers/net/can/vxcan.c                            | 2 +-
 drivers/net/ethernet/qualcomm/rmnet/rmnet_config.c | 4 ++--
 drivers/net/geneve.c                               | 4 ++--
 drivers/net/gtp.c                                  | 4 ++--
 drivers/net/ipvlan/ipvlan_main.c                   | 4 ++--
 drivers/net/macsec.c                               | 4 ++--
 drivers/net/macvlan.c                              | 4 ++--
 drivers/net/macvtap.c                              | 4 ++--
 drivers/net/netkit.c                               | 2 +-
 drivers/net/pfcp.c                                 | 4 ++--
 drivers/net/ppp/ppp_generic.c                      | 4 ++--
 drivers/net/veth.c                                 | 2 +-
 drivers/net/vxlan/vxlan_core.c                     | 4 ++--
 drivers/net/wireguard/device.c                     | 4 ++--
 drivers/net/wireless/virtual/virt_wifi.c           | 4 ++--
 drivers/net/wwan/wwan_core.c                       | 2 +-
 net/8021q/vlan_netlink.c                           | 4 ++--
 net/hsr/hsr_netlink.c                              | 8 ++++----
 21 files changed, 41 insertions(+), 41 deletions(-)

diff --git a/drivers/infiniband/ulp/ipoib/ipoib_netlink.c b/drivers/infiniband/ulp/ipoib/ipoib_netlink.c
index 16cb8ced9f35..53db7c8191e3 100644
--- a/drivers/infiniband/ulp/ipoib/ipoib_netlink.c
+++ b/drivers/infiniband/ulp/ipoib/ipoib_netlink.c
@@ -101,8 +101,8 @@ static int ipoib_new_child_link(struct net_device *dev,
 				struct rtnl_newlink_params *params,
 				struct netlink_ext_ack *extack)
 {
+	struct net *link_net = rtnl_newlink_link_net(params);
 	struct nlattr **data = params->data;
-	struct net *src_net = params->net;
 	struct nlattr **tb = params->tb;
 	struct net_device *pdev;
 	struct ipoib_dev_priv *ppriv;
@@ -112,7 +112,7 @@ static int ipoib_new_child_link(struct net_device *dev,
 	if (!tb[IFLA_LINK])
 		return -EINVAL;
 
-	pdev = __dev_get_by_index(src_net, nla_get_u32(tb[IFLA_LINK]));
+	pdev = __dev_get_by_index(link_net, nla_get_u32(tb[IFLA_LINK]));
 	if (!pdev || pdev->type != ARPHRD_INFINIBAND)
 		return -ENODEV;
 
diff --git a/drivers/net/amt.c b/drivers/net/amt.c
index 96b7ec9a2c13..53899b70fae1 100644
--- a/drivers/net/amt.c
+++ b/drivers/net/amt.c
@@ -3165,13 +3165,13 @@ static int amt_newlink(struct net_device *dev,
 		       struct rtnl_newlink_params *params,
 		       struct netlink_ext_ack *extack)
 {
+	struct net *link_net = rtnl_newlink_link_net(params);
 	struct amt_dev *amt = netdev_priv(dev);
 	struct nlattr **data = params->data;
 	struct nlattr **tb = params->tb;
-	struct net *net = params->net;
 	int err = -EINVAL;
 
-	amt->net = net;
+	amt->net = link_net;
 	amt->mode = nla_get_u32(data[IFLA_AMT_MODE]);
 
 	if (data[IFLA_AMT_MAX_TUNNELS] &&
@@ -3186,7 +3186,7 @@ static int amt_newlink(struct net_device *dev,
 	amt->hash_buckets = AMT_HSIZE;
 	amt->nr_tunnels = 0;
 	get_random_bytes(&amt->hash_seed, sizeof(amt->hash_seed));
-	amt->stream_dev = dev_get_by_index(net,
+	amt->stream_dev = dev_get_by_index(link_net,
 					   nla_get_u32(data[IFLA_AMT_LINK]));
 	if (!amt->stream_dev) {
 		NL_SET_ERR_MSG_ATTR(extack, tb[IFLA_AMT_LINK],
diff --git a/drivers/net/bareudp.c b/drivers/net/bareudp.c
index fc21dcfb4848..d1473c5f8eef 100644
--- a/drivers/net/bareudp.c
+++ b/drivers/net/bareudp.c
@@ -702,9 +702,9 @@ static int bareudp_newlink(struct net_device *dev,
 			   struct rtnl_newlink_params *params,
 			   struct netlink_ext_ack *extack)
 {
+	struct net *link_net = rtnl_newlink_link_net(params);
 	struct nlattr **data = params->data;
 	struct nlattr **tb = params->tb;
-	struct net *net = params->net;
 	struct bareudp_conf conf;
 	int err;
 
@@ -712,7 +712,7 @@ static int bareudp_newlink(struct net_device *dev,
 	if (err)
 		return err;
 
-	err = bareudp_configure(net, dev, &conf, extack);
+	err = bareudp_configure(link_net, dev, &conf, extack);
 	if (err)
 		return err;
 
diff --git a/drivers/net/can/vxcan.c b/drivers/net/can/vxcan.c
index 6f8ebb1cfd7b..99a78a757167 100644
--- a/drivers/net/can/vxcan.c
+++ b/drivers/net/can/vxcan.c
@@ -176,8 +176,8 @@ static int vxcan_newlink(struct net_device *dev,
 			 struct rtnl_newlink_params *params,
 			 struct netlink_ext_ack *extack)
 {
+	struct net *peer_net = rtnl_newlink_peer_net(params);
 	struct nlattr **data = params->data;
-	struct net *peer_net = params->net;
 	struct nlattr **tb = params->tb;
 	struct vxcan_priv *priv;
 	struct net_device *peer;
diff --git a/drivers/net/ethernet/qualcomm/rmnet/rmnet_config.c b/drivers/net/ethernet/qualcomm/rmnet/rmnet_config.c
index 8151e91395e2..ab7e5b6649b2 100644
--- a/drivers/net/ethernet/qualcomm/rmnet/rmnet_config.c
+++ b/drivers/net/ethernet/qualcomm/rmnet/rmnet_config.c
@@ -122,8 +122,8 @@ static int rmnet_newlink(struct net_device *dev,
 			 struct netlink_ext_ack *extack)
 {
 	u32 data_format = RMNET_FLAGS_INGRESS_DEAGGREGATION;
+	struct net *link_net = rtnl_newlink_link_net(params);
 	struct nlattr **data = params->data;
-	struct net *src_net = params->net;
 	struct nlattr **tb = params->tb;
 	struct net_device *real_dev;
 	int mode = RMNET_EPMODE_VND;
@@ -137,7 +137,7 @@ static int rmnet_newlink(struct net_device *dev,
 		return -EINVAL;
 	}
 
-	real_dev = __dev_get_by_index(src_net, nla_get_u32(tb[IFLA_LINK]));
+	real_dev = __dev_get_by_index(link_net, nla_get_u32(tb[IFLA_LINK]));
 	if (!real_dev) {
 		NL_SET_ERR_MSG_MOD(extack, "link does not exist");
 		return -ENODEV;
diff --git a/drivers/net/geneve.c b/drivers/net/geneve.c
index d373a851930c..c7700deefb00 100644
--- a/drivers/net/geneve.c
+++ b/drivers/net/geneve.c
@@ -1618,9 +1618,9 @@ static int geneve_newlink(struct net_device *dev,
 			  struct rtnl_newlink_params *params,
 			  struct netlink_ext_ack *extack)
 {
+	struct net *link_net = rtnl_newlink_link_net(params);
 	struct nlattr **data = params->data;
 	struct nlattr **tb = params->tb;
-	struct net *net = params->net;
 	struct geneve_config cfg = {
 		.df = GENEVE_DF_UNSET,
 		.use_udp6_rx_checksums = false,
@@ -1634,7 +1634,7 @@ static int geneve_newlink(struct net_device *dev,
 	if (err)
 		return err;
 
-	err = geneve_configure(net, dev, extack, &cfg);
+	err = geneve_configure(link_net, dev, extack, &cfg);
 	if (err)
 		return err;
 
diff --git a/drivers/net/gtp.c b/drivers/net/gtp.c
index 80ad618ba423..646d0fdd42f4 100644
--- a/drivers/net/gtp.c
+++ b/drivers/net/gtp.c
@@ -1464,8 +1464,8 @@ static int gtp_newlink(struct net_device *dev,
 		       struct rtnl_newlink_params *params,
 		       struct netlink_ext_ack *extack)
 {
+	struct net *link_net = rtnl_newlink_link_net(params);
 	struct nlattr **data = params->data;
-	struct net *src_net = params->net;
 	unsigned int role = GTP_ROLE_GGSN;
 	struct gtp_dev *gtp;
 	struct gtp_net *gn;
@@ -1496,7 +1496,7 @@ static int gtp_newlink(struct net_device *dev,
 	gtp->restart_count = nla_get_u8_default(data[IFLA_GTP_RESTART_COUNT],
 						0);
 
-	gtp->net = src_net;
+	gtp->net = link_net;
 
 	err = gtp_hashtable_new(gtp, hashsize);
 	if (err < 0)
diff --git a/drivers/net/ipvlan/ipvlan_main.c b/drivers/net/ipvlan/ipvlan_main.c
index 19ce19ca7e32..b56144ca2fde 100644
--- a/drivers/net/ipvlan/ipvlan_main.c
+++ b/drivers/net/ipvlan/ipvlan_main.c
@@ -535,9 +535,9 @@ static int ipvlan_nl_fillinfo(struct sk_buff *skb,
 int ipvlan_link_new(struct net_device *dev, struct rtnl_newlink_params *params,
 		    struct netlink_ext_ack *extack)
 {
+	struct net *link_net = rtnl_newlink_link_net(params);
 	struct ipvl_dev *ipvlan = netdev_priv(dev);
 	struct nlattr **data = params->data;
-	struct net *src_net = params->net;
 	struct nlattr **tb = params->tb;
 	struct ipvl_port *port;
 	struct net_device *phy_dev;
@@ -547,7 +547,7 @@ int ipvlan_link_new(struct net_device *dev, struct rtnl_newlink_params *params,
 	if (!tb[IFLA_LINK])
 		return -EINVAL;
 
-	phy_dev = __dev_get_by_index(src_net, nla_get_u32(tb[IFLA_LINK]));
+	phy_dev = __dev_get_by_index(link_net, nla_get_u32(tb[IFLA_LINK]));
 	if (!phy_dev)
 		return -ENODEV;
 
diff --git a/drivers/net/macsec.c b/drivers/net/macsec.c
index 1869b0513f57..4de5d63fd577 100644
--- a/drivers/net/macsec.c
+++ b/drivers/net/macsec.c
@@ -4145,10 +4145,10 @@ static int macsec_newlink(struct net_device *dev,
 			  struct rtnl_newlink_params *params,
 			  struct netlink_ext_ack *extack)
 {
+	struct net *link_net = rtnl_newlink_link_net(params);
 	struct macsec_dev *macsec = macsec_priv(dev);
 	struct nlattr **data = params->data;
 	struct nlattr **tb = params->tb;
-	struct net *net = params->net;
 	rx_handler_func_t *rx_handler;
 	u8 icv_len = MACSEC_DEFAULT_ICV_LEN;
 	struct net_device *real_dev;
@@ -4157,7 +4157,7 @@ static int macsec_newlink(struct net_device *dev,
 
 	if (!tb[IFLA_LINK])
 		return -EINVAL;
-	real_dev = __dev_get_by_index(net, nla_get_u32(tb[IFLA_LINK]));
+	real_dev = __dev_get_by_index(link_net, nla_get_u32(tb[IFLA_LINK]));
 	if (!real_dev)
 		return -ENODEV;
 	if (real_dev->type != ARPHRD_ETHER)
diff --git a/drivers/net/macvlan.c b/drivers/net/macvlan.c
index 0c496aa1f706..689759bbd159 100644
--- a/drivers/net/macvlan.c
+++ b/drivers/net/macvlan.c
@@ -1569,8 +1569,8 @@ static int macvlan_newlink(struct net_device *dev,
 			   struct rtnl_newlink_params *params,
 			   struct netlink_ext_ack *extack)
 {
-	return macvlan_common_newlink(params->net, dev, params->tb,
-				      params->data, extack);
+	return macvlan_common_newlink(rtnl_newlink_link_net(params), dev,
+				      params->tb, params->data, extack);
 }
 
 void macvlan_dellink(struct net_device *dev, struct list_head *head)
diff --git a/drivers/net/macvtap.c b/drivers/net/macvtap.c
index 6dbfeeac5c99..ee1bfd4298c2 100644
--- a/drivers/net/macvtap.c
+++ b/drivers/net/macvtap.c
@@ -105,8 +105,8 @@ static int macvtap_newlink(struct net_device *dev,
 	/* Don't put anything that may fail after macvlan_common_newlink
 	 * because we can't undo what it does.
 	 */
-	err = macvlan_common_newlink(params->net, dev, params->tb, params->data,
-				     extack);
+	err = macvlan_common_newlink(rtnl_newlink_link_net(params), dev,
+				     params->tb, params->data, extack);
 	if (err) {
 		netdev_rx_handler_unregister(dev);
 		return err;
diff --git a/drivers/net/netkit.c b/drivers/net/netkit.c
index 1e9eadc77da2..d278d7697cee 100644
--- a/drivers/net/netkit.c
+++ b/drivers/net/netkit.c
@@ -331,8 +331,8 @@ static int netkit_new_link(struct net_device *dev,
 			   struct rtnl_newlink_params *params,
 			   struct netlink_ext_ack *extack)
 {
+	struct net *peer_net = rtnl_newlink_peer_net(params);
 	struct nlattr **data = params->data;
-	struct net *peer_net = params->net;
 	struct nlattr **tb = params->tb;
 	struct nlattr *peer_tb[IFLA_MAX + 1], **tbp = tb, *attr;
 	enum netkit_action policy_prim = NETKIT_PASS;
diff --git a/drivers/net/pfcp.c b/drivers/net/pfcp.c
index d9e4b5185c51..33eaded152ce 100644
--- a/drivers/net/pfcp.c
+++ b/drivers/net/pfcp.c
@@ -188,12 +188,12 @@ static int pfcp_newlink(struct net_device *dev,
 			struct rtnl_newlink_params *params,
 			struct netlink_ext_ack *extack)
 {
+	struct net *link_net = rtnl_newlink_link_net(params);
 	struct pfcp_dev *pfcp = netdev_priv(dev);
-	struct net *net = params->net;
 	struct pfcp_net *pn;
 	int err;
 
-	pfcp->net = net;
+	pfcp->net = link_net;
 
 	err = pfcp_add_sock(pfcp);
 	if (err) {
diff --git a/drivers/net/ppp/ppp_generic.c b/drivers/net/ppp/ppp_generic.c
index b3340f8a6149..6220866258fc 100644
--- a/drivers/net/ppp/ppp_generic.c
+++ b/drivers/net/ppp/ppp_generic.c
@@ -1307,8 +1307,8 @@ static int ppp_nl_newlink(struct net_device *dev,
 			  struct rtnl_newlink_params *params,
 			  struct netlink_ext_ack *extack)
 {
+	struct net *link_net = rtnl_newlink_link_net(params);
 	struct nlattr **data = params->data;
-	struct net *src_net = params->net;
 	struct nlattr **tb = params->tb;
 	struct ppp_config conf = {
 		.unit = -1,
@@ -1346,7 +1346,7 @@ static int ppp_nl_newlink(struct net_device *dev,
 	if (!tb[IFLA_IFNAME] || !nla_len(tb[IFLA_IFNAME]) || !*(char *)nla_data(tb[IFLA_IFNAME]))
 		conf.ifname_is_set = false;
 
-	err = ppp_dev_configure(src_net, dev, &conf);
+	err = ppp_dev_configure(link_net, dev, &conf);
 
 out_unlock:
 	mutex_unlock(&ppp_mutex);
diff --git a/drivers/net/veth.c b/drivers/net/veth.c
index 7dfda89f072f..ba3ae2d8092f 100644
--- a/drivers/net/veth.c
+++ b/drivers/net/veth.c
@@ -1769,8 +1769,8 @@ static int veth_newlink(struct net_device *dev,
 			struct rtnl_newlink_params *params,
 			struct netlink_ext_ack *extack)
 {
+	struct net *peer_net = rtnl_newlink_peer_net(params);
 	struct nlattr **data = params->data;
-	struct net *peer_net = params->net;
 	struct nlattr **tb = params->tb;
 	int err;
 	struct net_device *peer;
diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
index 86c620b4c26f..cd0964823864 100644
--- a/drivers/net/vxlan/vxlan_core.c
+++ b/drivers/net/vxlan/vxlan_core.c
@@ -4397,8 +4397,8 @@ static int vxlan_newlink(struct net_device *dev,
 			 struct rtnl_newlink_params *params,
 			 struct netlink_ext_ack *extack)
 {
+	struct net *link_net = rtnl_newlink_link_net(params);
 	struct nlattr **data = params->data;
-	struct net *src_net = params->net;
 	struct nlattr **tb = params->tb;
 	struct vxlan_config conf;
 	int err;
@@ -4407,7 +4407,7 @@ static int vxlan_newlink(struct net_device *dev,
 	if (err)
 		return err;
 
-	return __vxlan_dev_create(src_net, dev, &conf, extack);
+	return __vxlan_dev_create(link_net, dev, &conf, extack);
 }
 
 static int vxlan_changelink(struct net_device *dev, struct nlattr *tb[],
diff --git a/drivers/net/wireguard/device.c b/drivers/net/wireguard/device.c
index 404cf05bd72b..c496d35b266d 100644
--- a/drivers/net/wireguard/device.c
+++ b/drivers/net/wireguard/device.c
@@ -311,11 +311,11 @@ static int wg_newlink(struct net_device *dev,
 		      struct rtnl_newlink_params *params,
 		      struct netlink_ext_ack *extack)
 {
+	struct net *link_net = rtnl_newlink_link_net(params);
 	struct wg_device *wg = netdev_priv(dev);
-	struct net *src_net = params->net;
 	int ret = -ENOMEM;
 
-	rcu_assign_pointer(wg->creating_net, src_net);
+	rcu_assign_pointer(wg->creating_net, link_net);
 	init_rwsem(&wg->static_identity.lock);
 	mutex_init(&wg->socket_update_lock);
 	mutex_init(&wg->device_update_lock);
diff --git a/drivers/net/wireless/virtual/virt_wifi.c b/drivers/net/wireless/virtual/virt_wifi.c
index 26905b2b3ba3..f9d11a023313 100644
--- a/drivers/net/wireless/virtual/virt_wifi.c
+++ b/drivers/net/wireless/virtual/virt_wifi.c
@@ -524,7 +524,7 @@ static int virt_wifi_newlink(struct net_device *dev,
 			     struct netlink_ext_ack *extack)
 {
 	struct virt_wifi_netdev_priv *priv = netdev_priv(dev);
-	struct net *src_net = params->net;
+	struct net *link_net = rtnl_newlink_link_net(params);
 	struct nlattr **tb = params->tb;
 	int err;
 
@@ -534,7 +534,7 @@ static int virt_wifi_newlink(struct net_device *dev,
 	netif_carrier_off(dev);
 
 	priv->upperdev = dev;
-	priv->lowerdev = __dev_get_by_index(src_net,
+	priv->lowerdev = __dev_get_by_index(link_net,
 					    nla_get_u32(tb[IFLA_LINK]));
 
 	if (!priv->lowerdev)
diff --git a/drivers/net/wwan/wwan_core.c b/drivers/net/wwan/wwan_core.c
index 53a6c437ff79..34e34bc3ae94 100644
--- a/drivers/net/wwan/wwan_core.c
+++ b/drivers/net/wwan/wwan_core.c
@@ -1068,7 +1068,7 @@ static void wwan_create_default_link(struct wwan_device *wwandev,
 	struct nlmsghdr *nlh;
 	struct sk_buff *msg;
 	struct rtnl_newlink_params params = {
-		.net = &init_net,
+		.src_net = &init_net,
 		.tb = tb,
 		.data = data,
 	};
diff --git a/net/8021q/vlan_netlink.c b/net/8021q/vlan_netlink.c
index 91df0f96e32a..a000b1ef0520 100644
--- a/net/8021q/vlan_netlink.c
+++ b/net/8021q/vlan_netlink.c
@@ -139,9 +139,9 @@ static int vlan_newlink(struct net_device *dev,
 			struct rtnl_newlink_params *params,
 			struct netlink_ext_ack *extack)
 {
+	struct net *link_net = rtnl_newlink_link_net(params);
 	struct vlan_dev_priv *vlan = vlan_dev_priv(dev);
 	struct nlattr **data = params->data;
-	struct net *src_net = params->net;
 	struct nlattr **tb = params->tb;
 	struct net_device *real_dev;
 	unsigned int max_mtu;
@@ -158,7 +158,7 @@ static int vlan_newlink(struct net_device *dev,
 		return -EINVAL;
 	}
 
-	real_dev = __dev_get_by_index(src_net, nla_get_u32(tb[IFLA_LINK]));
+	real_dev = __dev_get_by_index(link_net, nla_get_u32(tb[IFLA_LINK]));
 	if (!real_dev) {
 		NL_SET_ERR_MSG_MOD(extack, "link does not exist");
 		return -ENODEV;
diff --git a/net/hsr/hsr_netlink.c b/net/hsr/hsr_netlink.c
index 39add538ba99..b120470246cc 100644
--- a/net/hsr/hsr_netlink.c
+++ b/net/hsr/hsr_netlink.c
@@ -33,8 +33,8 @@ static int hsr_newlink(struct net_device *dev,
 		       struct rtnl_newlink_params *params,
 		       struct netlink_ext_ack *extack)
 {
+	struct net *link_net = rtnl_newlink_link_net(params);
 	struct nlattr **data = params->data;
-	struct net *src_net = params->net;
 	enum hsr_version proto_version;
 	unsigned char multicast_spec;
 	u8 proto = HSR_PROTOCOL_HSR;
@@ -48,7 +48,7 @@ static int hsr_newlink(struct net_device *dev,
 		NL_SET_ERR_MSG_MOD(extack, "Slave1 device not specified");
 		return -EINVAL;
 	}
-	link[0] = __dev_get_by_index(src_net,
+	link[0] = __dev_get_by_index(link_net,
 				     nla_get_u32(data[IFLA_HSR_SLAVE1]));
 	if (!link[0]) {
 		NL_SET_ERR_MSG_MOD(extack, "Slave1 does not exist");
@@ -58,7 +58,7 @@ static int hsr_newlink(struct net_device *dev,
 		NL_SET_ERR_MSG_MOD(extack, "Slave2 device not specified");
 		return -EINVAL;
 	}
-	link[1] = __dev_get_by_index(src_net,
+	link[1] = __dev_get_by_index(link_net,
 				     nla_get_u32(data[IFLA_HSR_SLAVE2]));
 	if (!link[1]) {
 		NL_SET_ERR_MSG_MOD(extack, "Slave2 does not exist");
@@ -71,7 +71,7 @@ static int hsr_newlink(struct net_device *dev,
 	}
 
 	if (data[IFLA_HSR_INTERLINK])
-		interlink = __dev_get_by_index(src_net,
+		interlink = __dev_get_by_index(link_net,
 					       nla_get_u32(data[IFLA_HSR_INTERLINK]));
 
 	if (interlink && interlink == link[0]) {
-- 
2.47.1

