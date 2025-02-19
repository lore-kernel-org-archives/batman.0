Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1B93C021AA
	for <batman@archiver.kernel.org>; Wed, 19 Feb 2025 15:53:06 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 69ACD84251
	for <batman@archiver.kernel.org>; Wed, 19 Feb 2025 16:53:05 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1739980385;
 b=V4g42uu1JyEi/M7Ibrfb6fh8rg34vrnPHPa6GDeUdEB9rBel3Q0kvs4rpWUB0ayaV2Fk6
 bCeWP+mbf4e91svaCxQYsuyvLmK/L2CEV4aWcKPbwjQdUUZIPrMw0tdeWZRMlaRpD4WNwaY
 v96MneMxMRDGljQgB9NaSVfGWOROBt0=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1739980385; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=HRequyiks98F4TvQO/vmtwESixnPXuO1TfB2/aKs1TA=;
 b=xu7bni8kEHmoVHiviXQqZngq1WBrhIF8vbOgTVGKtCLSBEDP/cIwRJ9xnO+liVBHcb381
 j3iHtRmcL9uY2O2P/uTY7HrwQ0PERo6n9ai6NZaUsvEuWUVITDoA32JRSTtEs1tLpoEeKKu
 R+VzBaohS5pn/Q1n/+TCeI3j7xFyLoQ=
ARC-Authentication-Results: i=2; open-mesh.org; dkim=pass header.d=gmail.com;
  arc=pass;
  dmarc=pass (Used From Domain Record) header.from=gmail.com
 policy.dmarc=quarantine
Authentication-Results: open-mesh.org; dkim=pass header.d=gmail.com; arc=pass;
 dmarc=pass (Used From Domain Record) header.from=gmail.com
 policy.dmarc=quarantine
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com
 [IPv6:2607:f8b0:4864:20::635])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 5739683FC9
	for <b.a.t.m.a.n@lists.open-mesh.org>; Wed, 19 Feb 2025 13:52:25 +0100 (CET)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1739969545;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=HRequyiks98F4TvQO/vmtwESixnPXuO1TfB2/aKs1TA=;
	b=ejv5kVbyEjMKySFLVl4KaYLHuAEowl6De4d/NYNr29kyhKMT5XqJTyHU0McDg4thLYnuGD
	ina7XXJO+rI9cMFPMGtjIeaGiYMO/oKsuoLjBL3xRdc4YQVtj/Sex8UMwyP1nIjm3es90a
	IB8WgoVZwjoz6USyWBBlNadPz/nRgck=
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1739969545; a=rsa-sha256;
	cv=none;
	b=FjDsOhwZalYmDMSq34ilIrVchfheaSMJDwD1JZC/+2XZt6FKha9d1hTzLit+ZF8BDFj0qO
	IVYs5ekCfk0mosflV7WEhGsyABfw/04BVn0sEC/BqZA7PROFSQuiqq8bWlNq3mUnQ4f47k
	Zy16d9gU4x3dcgjZtr07oqucsqms6Xs=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=gmail.com header.s=20230601 header.b=iU87uVug;
	spf=pass (diktynna.open-mesh.org: domain of shaw.leon@gmail.com designates
 2607:f8b0:4864:20::635 as permitted sender)
 smtp.mailfrom=shaw.leon@gmail.com;
	dmarc=pass (policy=none) header.from=gmail.com
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-21c2f1b610dso169882155ad.0
        for <b.a.t.m.a.n@lists.open-mesh.org>;
 Wed, 19 Feb 2025 04:52:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739969544; x=1740574344;
 darn=lists.open-mesh.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HRequyiks98F4TvQO/vmtwESixnPXuO1TfB2/aKs1TA=;
        b=iU87uVugCZZBlltXWf2c9BS+BwzwLU3ugDBHK6n8EwDDhnZt3IXV8oEvaAIfj4jAH7
         HHsx0n2fEgowfBEHgGXJ4W3586TZDKgrTZsbm9uOwUzq4xyRrxPjj7c7ec6rHRGHlmqL
         DlB91udTsW7fZ6MrJYDyM1nBM4Gs4bx8bzuJHd/5bh7v8vVSUNwMXhsGXL0ef3jWpuqx
         11N0LbIqhvnme/whdsE8r1l3b94tNSb5dHj7ZDUS/UlUZ9gzM+8hyoKoDWGTzNhLOw4H
         XnAy2PRcieLQheDT+TnaqOIDPHENsdu+QPrJg4GUSJii099PjZ+ftPI3/zeALNO87sdJ
         El8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739969544; x=1740574344;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HRequyiks98F4TvQO/vmtwESixnPXuO1TfB2/aKs1TA=;
        b=h0pQgD5Ui87zEKkAANyfU+kmJjj0f/AEjP5OFtpWxwcSvyEf1bWz6BBIkRK9Yuk0tq
         2aI/qKSH9osWcIdYPz7+tS6tsBQFnrORK3ic68L1pT8r+dZIeqbZkU8Atk3CW8ZsUtlc
         hpRLybbNR3/wiXWY7jujOzvXs9vjnEo6DImCOPu2RldH6cD3/ohG7BWydi3VsT8Hofpe
         bTTGxFhxUa3Oqh94ZSjxy0KlJ0Sf3FflQtsR3lTPw0X3qX5hv9YWDHa4Z7SyaQRKS3rC
         UeVc4H5kpXP46R8/shcXvebwLMK7afJNWg2hv0c8oTLiJU97J7333tiwRyQRQmSjOIeW
         h7iw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVhtFDN496Na7Cwg3axgoDwEBItZv/euCJmRwn/BsyEsGXm0U0YTM9kdIZWcG31QGft+FfMSrebGkNgrA==@lists.open-mesh.org
X-Gm-Message-State: AOJu0Yx24G+wib0OKgDCwHWdUDndvWnFg+a0oux+USZKyoXN3fFiwOa/
	R5QktgtVwi0yR4txczFK3qkQvCCNR8z/Y4wQ67Oiv8BPjncKEGoz
X-Gm-Gg: ASbGnctOdkliX5pvCUMMhKuXcb44ZEvzqFN7nWE4fFNBn/AaqFkA06ENDJbSZ0pVf5F
	tc89Oe3Mn7B2YP/q4brFZv2e9RFLew+JTfGpga9SEo4sn1SUabhL2cowimxhVOYpokg4QFXeHuB
	MdXEmkjdepf8di7XblRJgUqQF/NSsp/ms87IBKl2TyidHQOKb686aOzG0oLPK6CladtQu0oJVhM
	FaxbDCqfqmrm1ph4fEvruhSMXAY6YnSHBkwtxF1un9BmHf0IzJVEcTeeM9YReV7o2jAsxK0qXpz
	2rwDAg==
X-Google-Smtp-Source: 
 AGHT+IHnb5v62m0BvDxfIowP9iMNtE/Y7pYhM/eIGIlagffbyppVP0uCqTnvfVFz3C1LICvyxAmpug==
X-Received: by 2002:a17:902:e841:b0:21f:564:80a4 with SMTP id
 d9443c01a7336-221040a9a0emr294098225ad.33.1739969543796;
        Wed, 19 Feb 2025 04:52:23 -0800 (PST)
Received: from ws.. ([103.167.140.11])
        by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-220d536436fsm103427175ad.64.2025.02.19.04.52.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2025 04:52:23 -0800 (PST)
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
Subject: [PATCH net-next v10 10/13] rtnetlink: Remove "net" from newlink
 params
Date: Wed, 19 Feb 2025 20:50:36 +0800
Message-ID: <20250219125039.18024-11-shaw.leon@gmail.com>
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
Message-ID-Hash: HQZVCXQWSWT5W7H6AMUI3DPI3M2A42G3
X-Message-ID-Hash: HQZVCXQWSWT5W7H6AMUI3DPI3M2A42G3
X-Mailman-Approved-At: Wed, 19 Feb 2025 16:43:08 +0100
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/HQZVCXQWSWT5W7H6AMUI3DPI3M2A42G3/>
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
index b22a106621fb..ec65a8cebb99 100644
--- a/include/net/rtnetlink.h
+++ b/include/net/rtnetlink.h
@@ -72,7 +72,6 @@ static inline int rtnl_msg_family(const struct nlmsghdr *nlh)
 /**
  * struct rtnl_newlink_params - parameters of rtnl_link_ops::newlink()
  *
- * @net: Netns of interest
  * @src_net: Source netns of rtnetlink socket
  * @link_net: Link netns by IFLA_LINK_NETNSID, NULL if not specified
  * @peer_net: Peer netns
@@ -80,7 +79,6 @@ static inline int rtnl_msg_family(const struct nlmsghdr *nlh)
  * @data: IFLA_INFO_DATA attributes
  */
 struct rtnl_newlink_params {
-	struct net *net;
 	struct net *src_net;
 	struct net *link_net;
 	struct net *peer_net;
diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index 9ebbde0d131c..e980481bdd28 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -3798,12 +3798,6 @@ static int rtnl_newlink_create(struct sk_buff *skb, struct ifinfomsg *ifm,
 
 	dev->ifindex = ifm->ifi_index;
 
-	params.net = params.src_net;
-	if (link_net)
-		params.net = link_net;
-	if (peer_net)
-		params.net = peer_net;
-
 	if (ops->newlink)
 		err = ops->newlink(dev, &params, extack);
 	else
-- 
2.48.1

