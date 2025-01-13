Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8FE6C02180
	for <batman-adv@archiver.kernel.org>; Mon, 13 Jan 2025 15:28:23 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 2B7E784131
	for <batman-adv@archiver.kernel.org>; Mon, 13 Jan 2025 16:28:22 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1736782102;
 b=usxAJ+pBOJqG1Lben12Bs1qJk6QBEbIsupn+WJ+nTFW8j8Uy+dy5WZe4e3NOfaseVixGC
 1j1N0Wmd2vVtS4HWbr9Js9c0560hD8H/dvr5Op46lNje2D+mXrxcxnyG5b0dZFc7ubahgxf
 zJYqj04om3Z9gXI3T0tOULCzPGulhj8=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1736782102; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=O0itpuEZRuaRQ33kirP60JpiMAPNyz5teegcwQ5xuJQ=;
 b=iNSO6yKv6rrIW4j0mDPCo4t5BoslaxgMXSHt8FtP2StjeCnkxsbAdGfiwbYE1mQbeCrYJ
 flY8SBEcnM9kO8acz0wh0UE/pgZhc/c98NXqbrw5m+ceEUOUvpYczzaR+bzkyS1yrOrJSY8
 tmKf4mjcwlxnvFEf6dq9SnybFuRDuuc=
ARC-Authentication-Results: i=2; open-mesh.org; dkim=pass header.d=gmail.com;
  arc=pass;
  dmarc=pass (Used From Domain Record) header.from=gmail.com
 policy.dmarc=quarantine
Authentication-Results: open-mesh.org; dkim=pass header.d=gmail.com; arc=pass;
 dmarc=pass (Used From Domain Record) header.from=gmail.com
 policy.dmarc=quarantine
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com
 [IPv6:2607:f8b0:4864:20::633])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id C4D1381AD7
	for <b.a.t.m.a.n@lists.open-mesh.org>; Mon, 13 Jan 2025 15:38:48 +0100 (CET)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1736779128;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=O0itpuEZRuaRQ33kirP60JpiMAPNyz5teegcwQ5xuJQ=;
	b=VwmkxUCM5kmNB6/iwY26FtetC6pgh9YruA1K4gMZNSJ1+cjCo7aXjZStDpqVP0yHIwYqdV
	KuwSK1aJTTDgaSp7QKMXSy3PPOeZ+uz7mxBus2DXbTqvml0NDoXT6F6yWZn+eFu/+FpZaJ
	kMNuERbp+xt5ZZbrlWu89vixrQmGylE=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=gmail.com header.s=20230601 header.b=isphlOLu;
	spf=pass (diktynna.open-mesh.org: domain of shaw.leon@gmail.com designates
 2607:f8b0:4864:20::633 as permitted sender)
 smtp.mailfrom=shaw.leon@gmail.com;
	dmarc=pass (policy=none) header.from=gmail.com
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1736779128; a=rsa-sha256;
	cv=none;
	b=gIKZ132SzY9SejP+iI9eexy05387KwUJymWVZ01TlEXs2lvqMdmd3864DLR4iSge7cDpWA
	mhPPzn1QQJlqv6h5aP9tOH97neQmLLCzhkQjyUBE04CjAU7D0s1Cgqy0valWskdy3xZS5K
	4qTxDDduMmqNoZagKn8Fkay/DxcfHi0=
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-21628b3fe7dso73483605ad.3
        for <b.a.t.m.a.n@lists.open-mesh.org>;
 Mon, 13 Jan 2025 06:38:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736779127; x=1737383927;
 darn=lists.open-mesh.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O0itpuEZRuaRQ33kirP60JpiMAPNyz5teegcwQ5xuJQ=;
        b=isphlOLudsdq15VlRlTZ3UiY3Opl8buW05JLuH11W7tzGatwlfP7DXWrPxG+TvLL2t
         LKNousNPC2z051czNfcMecI6s8NpuP5Hf2iECSM7ZTK3J0YQKWKcMoxnE++ofpwSEhQy
         JFfWYkXUu3T650ddwbOoVoZTiBery3iqJqXtgW6jToSPWAYDdG//Vk61q9c09mYNNsnb
         d0qHwa03togn216+YqvXb0WqRtC4/w0DqQRbgY7jZIerCG6aERhAM5Cz9jh9om6Tdf03
         HojT2pGLSbtWJ1qMLYioWT/h08uzM7oBqSOgiUZHOhrNobXp7lz/sf0XBHpcxSWUMqMS
         7RJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736779127; x=1737383927;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O0itpuEZRuaRQ33kirP60JpiMAPNyz5teegcwQ5xuJQ=;
        b=dpG5t/ZcpPgErr0Rd1TMP2VZJy484FdK/RvlqVJweXeOO8n3FcqdzBzhOhr2EXKorm
         N7EnCvwXuEEuA0vwKnCuQIwvCWwy7CgAUie2VPStjCGXK6IcA97gRl4Mj2BvKVlZr2Ny
         IQ3vzzaMDNxedaCSaq31YOK4JtuGd9shNfPPJx7JgHF7QcBRsJscJJSwLV3we1ThMHOm
         ys3MXfBsHqJQXHEC5/8PenuPY0kKUwFnb05uXtXCnOgfPnTT3NlbmSXfDyz9jExF/NIq
         Bpenb5mtETzcZZxG1orojmfl7rns8Lp/jUjb1G2X+J5ktH4PMW3cmrczdp8WY/E2CywY
         kVsw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXb5cmKW/zecM86+Qhqg+GjyZGLwH8KVJsNcgi4O4BChVSIZcLwOe3P03aYRq77auMD/skt+vXpjJnM5g==@lists.open-mesh.org
X-Gm-Message-State: AOJu0YyOTDLABidCsnoWldg6wQ280q7WZjO+fTSk0mvyhI+4gzgdgNCX
	+p+mN6ZcqmP4SIWDcDQdYSVTBUoaFXh5yegrk7j2zgn6C7s1nSSJ
X-Gm-Gg: ASbGncvI51iTFrLfSiOQSPfS6AgveCXPVR8XmLChr1o0pWhiPqAGWm4lRqHS4GmF7yy
	9ouJ/ZBafG6lPJKtfBX7wHqp1AyGJs47SMoIW/m6ogCg6Y7/IO7Yp44Sna4vwJnS5Rvr8aVDALC
	Xh0e6Qs7HdER6YkA9WJS5ke1eWg5bH2nTJPzQB4p+UrnAAGFjB9slSbJqD53wJVm6rHd9NShhX7
	X0Gu3I6xIyOO0QPdtaNOMhtIDLi+bT2oAdlm/gHSLXe6tc=
X-Google-Smtp-Source: 
 AGHT+IF46BIJsHmY25FQQjjhe3rRKluIF8yEXaDZgFjxpJ6wghwfrMVhniqYlndXdS242mt6yFdpoQ==
X-Received: by 2002:a17:903:230d:b0:215:cbbf:8926 with SMTP id
 d9443c01a7336-21a83fb0da4mr356224215ad.35.1736779127243;
        Mon, 13 Jan 2025 06:38:47 -0800 (PST)
Received: from ws.. ([103.167.140.11])
        by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21a9f155e00sm54328715ad.103.2025.01.13.06.38.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2025 06:38:46 -0800 (PST)
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
Subject: [PATCH net-next v8 08/11] rtnetlink: Remove "net" from newlink params
Date: Mon, 13 Jan 2025 22:37:16 +0800
Message-ID: <20250113143719.7948-9-shaw.leon@gmail.com>
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
Message-ID-Hash: GTX2XXEGEFMRLJOMS3ZSPBCFIDKZPTNS
X-Message-ID-Hash: GTX2XXEGEFMRLJOMS3ZSPBCFIDKZPTNS
X-Mailman-Approved-At: Mon, 13 Jan 2025 16:21:55 +0100
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/GTX2XXEGEFMRLJOMS3ZSPBCFIDKZPTNS/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

Now that devices have been converted to use the specific netns instead
of ambiguous "net", let's remove it from newlink parameters.

Signed-off-by: Xiao Liang <shaw.leon@gmail.com>
---
 include/net/rtnetlink.h | 2 --
 net/core/rtnetlink.c    | 6 ------
 2 files changed, 8 deletions(-)

diff --git a/include/net/rtnetlink.h b/include/net/rtnetlink.h
index 00c086ca0c11..dd51240431b8 100644
--- a/include/net/rtnetlink.h
+++ b/include/net/rtnetlink.h
@@ -72,7 +72,6 @@ static inline int rtnl_msg_family(const struct nlmsghdr *nlh)
 /**
  *	struct rtnl_newlink_params - parameters of rtnl_link_ops::newlink()
  *
- *	@net: Netns of interest
  *	@src_net: Source netns of rtnetlink socket
  *	@link_net: Link netns by IFLA_LINK_NETNSID, NULL if not specified
  *	@peer_net: Peer netns
@@ -80,7 +79,6 @@ static inline int rtnl_msg_family(const struct nlmsghdr *nlh)
  *	@data: IFLA_INFO_DATA attributes
  */
 struct rtnl_newlink_params {
-	struct net *net;
 	struct net *src_net;
 	struct net *link_net;
 	struct net *peer_net;
diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index 7ff5e96f6ba7..cce5bcd1f257 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -3767,7 +3767,6 @@ static int rtnl_newlink_create(struct sk_buff *skb, struct ifinfomsg *ifm,
 	char ifname[IFNAMSIZ];
 	int err;
 	struct rtnl_newlink_params params = {
-		.net = net,
 		.src_net = net,
 		.link_net = link_net,
 		.peer_net = peer_net,
@@ -3794,11 +3793,6 @@ static int rtnl_newlink_create(struct sk_buff *skb, struct ifinfomsg *ifm,
 
 	dev->ifindex = ifm->ifi_index;
 
-	if (link_net)
-		params.net = link_net;
-	if (peer_net)
-		params.net = peer_net;
-
 	if (ops->newlink)
 		err = ops->newlink(dev, &params, extack);
 	else
-- 
2.47.1

