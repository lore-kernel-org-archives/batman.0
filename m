Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C90EE77187
	for <batman@archiver.kernel.org>; Wed, 18 Dec 2024 13:18:15 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id BB5D983FEC
	for <batman@archiver.kernel.org>; Wed, 18 Dec 2024 14:18:13 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1734527893;
 b=XlKr/tD1ejdq2k8fy+N9fyrjAvPe0MUraCyGM25Lgdc9hYRkTot0yVHW6BsgfunE3/l23
 3XTEoM7XKHY8WvyUcOM0GzGg4egqiJUlq5dTQTkHsz6RJIwayEqW1LQr0aAa21UAvqywFg2
 V6wbJLSDnoGq5b15XSqt4MSCNz58+Wo=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1734527893; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=vKRdbuSYL7hnJpCbxB6/aqEJFoCo8iX729XZZAsUkqw=;
 b=dynlVmM/WOOuWQULes9kC9bvZkIzSVhwj/X3ntVNK5zRVr+tzSAfLnfpQcYe4BNa/liIY
 WNv9nTmAJnw2wIDJ+CRFcSvyVUgklOPh4vo/4w1gtMulE7MchpTaxNj82H1lDnhTlnq0b9r
 WEzCPi/ryQlglPPskhX3b8S3cYk5eKU=
ARC-Authentication-Results: i=2; open-mesh.org; dkim=pass header.d=gmail.com;
  arc=pass;
  dmarc=pass (Used From Domain Record) header.from=gmail.com
 policy.dmarc=quarantine
Authentication-Results: open-mesh.org; dkim=pass header.d=gmail.com; arc=pass;
 dmarc=pass (Used From Domain Record) header.from=gmail.com
 policy.dmarc=quarantine
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com
 [IPv6:2607:f8b0:4864:20::631])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 1103083F15
	for <b.a.t.m.a.n@lists.open-mesh.org>; Wed, 18 Dec 2024 14:10:32 +0100 (CET)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1734527432;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=vKRdbuSYL7hnJpCbxB6/aqEJFoCo8iX729XZZAsUkqw=;
	b=PsDVdn6kMRRkILZZzInFcvN4FZPAcqbETGklzUUYVhGt4Q4sRNq22VOhPTDS8HiU/L4PId
	MFsTRW04M3cGuI/Nw4UFwWTC8vBT3R77+hYDt7vIZZqiqhjfHaTKkLlhB2YP8M+IAF2JPS
	eFz8c2OPYl8RgB4A5s/gCatzNTfSqeQ=
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1734527432; a=rsa-sha256;
	cv=none;
	b=WaKashwgQwCHcdSmbr6HcfPuPWzz8fJN3V0T8feHWSzJPP0HM+znk/LMfDDNr+vQZlQTrt
	Zvap7n6jCF7LYdq9vVslpaoe+3Xtneu5MUygk4Ojx8qKyQ7RVLCdMgQto38141g7alVPCB
	MNO687kr9BKKJUKkub4wTBMrGwcnQ6I=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=gmail.com header.s=20230601 header.b="db6Qb4o/";
	spf=pass (diktynna.open-mesh.org: domain of shaw.leon@gmail.com designates
 2607:f8b0:4864:20::631 as permitted sender)
 smtp.mailfrom=shaw.leon@gmail.com;
	dmarc=pass (policy=none) header.from=gmail.com
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-2164b1f05caso59837385ad.3
        for <b.a.t.m.a.n@lists.open-mesh.org>;
 Wed, 18 Dec 2024 05:10:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734527430; x=1735132230;
 darn=lists.open-mesh.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vKRdbuSYL7hnJpCbxB6/aqEJFoCo8iX729XZZAsUkqw=;
        b=db6Qb4o/zUYSjZQKfC/v0Tq8XejBAT/55DvA605+plxjX5gb6v07Qg4jlw5p6KjzeQ
         MgDZFnstnhqH5kjCX28l9mrbzJSn5OXRFfSzQbaYd2fh0XN2iWkn/GF2WNBg6KMBssnC
         JXXxOmzBtxtNOlSQ3jPEhXVzwRyZuynVuFm6RE+6NetkM65YzL6kkhfMqd+Heip/eefq
         bIo7kNRX/SriLY+YU11+5sALRANPe+wmW06p0LihDHUmFAWH8SON7Z68tqLACf5nMvkd
         o9i+fssg2700SOKUY/5iY0Iwu8EijvKaV0DGmm3F7tOi7ChDhazSxPGaI/f/3jtaX4kq
         IXjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734527430; x=1735132230;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vKRdbuSYL7hnJpCbxB6/aqEJFoCo8iX729XZZAsUkqw=;
        b=fMcP87xbYzIotvyySANXzl2ean5elxiR+TbRqye3k29vXFZkJooShR5oQ1CassC3lg
         BF8xDe4B6KR+Lzpzxp8GUHVpGFndw7FB5tCWwybkR1XFxhYqvDGfV7R81gPsv5ELv+ts
         JzTO71U4bynTldq41NX/ktK0XFBNhemQ6sI0ykgxFToCe1GXJ7SwWGKkD2MlLtvCvMeV
         F8Y63IO0PXax/rcy9HkWykALa2wdtqq8fbx97JLeWib44j//Y200/mGXIPrEVZJ1VQWb
         1SaToHmP163eJSRYkqw/7v1qQoy+PD207uSeW2ft27012MaoBK+Rl4apg/0ZxIrhJ3WE
         gP3w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUhk2G/ADvDNo/GepfZmQQhkPMPxZH+U+pvOAy0ieBD62q0jUMjt7QkWpFLKNkWRqqyiJWSAsQ9mSPC9w==@lists.open-mesh.org
X-Gm-Message-State: AOJu0Ywr/lLVk/rAkwVusxhSu1oIsPr66S0OfFYycxT3VqxBeGXcqOI5
	nWDpOYGHGLlnTjcV6CwcW7icTuvTfxqKAwVU9oveGddYx7g9PHGr
X-Gm-Gg: ASbGnct1zlYDIfMELfq/YwiNDozI/KaQ9N9e+J9keAl7C7+8Rc3TJfdr9TEBU/q0H2/
	cfyM2WQr3X88iRAisVWlid1Ns7UNqJ1n0wH0jgL5kF1/WjiPxoEwOrHtN1X8BPazxG5aG/OTdBu
	G//LQBS0uZgi+m8POK1n+JDnWz/Zrs+PVF54oOcYXIHV9lfjEMQ6DBgnrfR3x9gogW5zSQUS4bK
	K+fSUUWLrAGTg4AXIZcbu9jfcY5NY3CJ/OonO2b1OHHQdc=
X-Google-Smtp-Source: 
 AGHT+IG5uNon7/+5tavnAU1+6ODsDyulZAAiwNo5sldF4FHk8kNssZ4/V0oQpI2qOsRTRp3qJQ4m2Q==
X-Received: by 2002:a17:902:db01:b0:216:5867:976a with SMTP id
 d9443c01a7336-218d725b7aamr38087595ad.45.1734527430302;
        Wed, 18 Dec 2024 05:10:30 -0800 (PST)
Received: from ws.. ([103.167.140.11])
        by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-801d5c0f59asm7434754a12.67.2024.12.18.05.10.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2024 05:10:29 -0800 (PST)
From: Xiao Liang <shaw.leon@gmail.com>
To: netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Donald Hunter <donald.hunter@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Ido Schimmel <idosch@nvidia.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Jiri Pirko <jiri@resnulli.us>,
	Hangbin Liu <liuhangbin@gmail.com>,
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
Subject: [PATCH net-next v6 08/11] rtnetlink: Remove "net" from newlink params
Date: Wed, 18 Dec 2024 21:09:06 +0800
Message-ID: <20241218130909.2173-9-shaw.leon@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241218130909.2173-1-shaw.leon@gmail.com>
References: <20241218130909.2173-1-shaw.leon@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MailFrom: shaw.leon@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-0;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-1;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-2
Message-ID-Hash: 4LD4L2TWQ24BC4IWKH3YPM25Q4I7FY5T
X-Message-ID-Hash: 4LD4L2TWQ24BC4IWKH3YPM25Q4I7FY5T
X-Mailman-Approved-At: Wed, 18 Dec 2024 14:11:51 +0100
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/4LD4L2TWQ24BC4IWKH3YPM25Q4I7FY5T/>
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
index ed970b4568d1..04fc0e91af42 100644
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
@@ -82,7 +81,6 @@ static inline int rtnl_msg_family(const struct nlmsghdr *nlh)
  *	@extack: Netlink extended ACK
  */
 struct rtnl_newlink_params {
-	struct net *net;
 	struct net *src_net;
 	struct net *link_net;
 	struct net *peer_net;
diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index f7c176a2f1a0..e33ef8a0a6d6 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -3758,7 +3758,6 @@ static int rtnl_newlink_create(struct sk_buff *skb, struct ifinfomsg *ifm,
 	char ifname[IFNAMSIZ];
 	int err;
 	struct rtnl_newlink_params params = {
-		.net = net,
 		.src_net = net,
 		.link_net = link_net,
 		.peer_net = peer_net,
@@ -3787,11 +3786,6 @@ static int rtnl_newlink_create(struct sk_buff *skb, struct ifinfomsg *ifm,
 	dev->ifindex = ifm->ifi_index;
 	params.dev = dev;
 
-	if (link_net)
-		params.net = link_net;
-	if (peer_net)
-		params.net = peer_net;
-
 	if (ops->newlink)
 		err = ops->newlink(&params);
 	else
-- 
2.47.1

