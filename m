Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 567CFE77187
	for <batman@archiver.kernel.org>; Wed, 18 Dec 2024 13:12:42 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 9646F8402C
	for <batman@archiver.kernel.org>; Wed, 18 Dec 2024 14:12:40 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1734527560;
 b=vsgbXGL1H+Yyjm4/c2q2CJMNmQaoFDkU868WaX/CD0I4KGHaNE4HtnH42JpTtOO8lowXn
 Of2KIkEm7l3rfg6Z8XeCeBVXABeMmfakDuADzxntEMX3ZPXu/n+G4gQVmjX/nvzH4t8CybM
 lpSewvpZ2UE5blqwIhxNgPsX1w2zRKk=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1734527560; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=rqBeWHkwlk4K5tQfUbZueoC1cX5zOkU9dpB02VEAE+k=;
 b=N0Zuem44IfwBwPfVh1dmjvIjqWKvJpqZo8xTPKBbUBtBfuB3hoFBhYq6nXUUyaO2LI4Om
 ipOL7sOKY+YGvfgvBhIfxnBT8cxuwx6sHSFOl5WbudA8C+D0ABiRE/vhE1KfLdliNFE38pr
 VJnVfe70PiaAKFb3DpSqlZxKH4wh+y0=
ARC-Authentication-Results: i=2; open-mesh.org; dkim=pass header.d=gmail.com;
  arc=pass;
  dmarc=pass (Used From Domain Record) header.from=gmail.com
 policy.dmarc=quarantine
Authentication-Results: open-mesh.org; dkim=pass header.d=gmail.com; arc=pass;
 dmarc=pass (Used From Domain Record) header.from=gmail.com
 policy.dmarc=quarantine
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com
 [IPv6:2607:f8b0:4864:20::530])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id ABEEE819CA
	for <b.a.t.m.a.n@lists.open-mesh.org>; Wed, 18 Dec 2024 14:09:34 +0100 (CET)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1734527374;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=rqBeWHkwlk4K5tQfUbZueoC1cX5zOkU9dpB02VEAE+k=;
	b=kwRk/LhNoERh65mT7gVe7nayPXlrHJ7/KOYnr9X5wVjEs0WWNOL8VGTtW3ugRY1n7k0f8q
	L+bj4suoe+sQ82tiu3nqk/5DfPAzrFJZOZjKK/z504JdywC7NGTuQqzlMSOfymPs3wUAgq
	htojMKcpOx2cDZbRrDHBLogESa6dRHs=
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1734527374; a=rsa-sha256;
	cv=none;
	b=vvYCD/gTEoe2YCndjLVNJFxAbEi2WAIG8VG4IVVSyJkPfIeLdbex9khU5gRfP3ACOM4hsI
	/s1OlFjyvL6xUe2765AQUIy/w2bsLF5ZNabCrVXrGoK5yI92G4/O/v8pk4T/aCRlkuY3J1
	mk8kLwzozrhghmun2scH48dkr9SPnEU=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=gmail.com header.s=20230601 header.b=jq79Xsg4;
	spf=pass (diktynna.open-mesh.org: domain of shaw.leon@gmail.com designates
 2607:f8b0:4864:20::530 as permitted sender)
 smtp.mailfrom=shaw.leon@gmail.com;
	dmarc=pass (policy=none) header.from=gmail.com
Received: by mail-pg1-x530.google.com with SMTP id
 41be03b00d2f7-7fd526d4d9eso5003497a12.2
        for <b.a.t.m.a.n@lists.open-mesh.org>;
 Wed, 18 Dec 2024 05:09:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734527373; x=1735132173;
 darn=lists.open-mesh.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rqBeWHkwlk4K5tQfUbZueoC1cX5zOkU9dpB02VEAE+k=;
        b=jq79Xsg4tmwrKUIgdRMYD4Il69RZryvisQpvqtJhDswPHncwkywgsmhKOCpVDQ45FP
         RqynbQo7XoPrIGakbazQ97d2K5Cuho0wcyXFLCameNJWi6jnJvOy8RS40Y3IuQfCelJ5
         ppbBHb2dElFgaIl7mQhuBSnFq6jKdn4c56dmDQzKPI4SO7QwatPE+f3sLHd64zYQrbmR
         6qYbwek194+/w3DRVA+lo7vda/6gvzJ8Ls6vUDcXfeM3jiKg2isqQQ1eNc5LmZEbnB/4
         I+2WCXginn4PpdHIxcwHjvVptIlCOFcPLSWsPYKZskgZnazi4IUu7HSY2O7pQXr1VMC6
         Q5oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734527373; x=1735132173;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rqBeWHkwlk4K5tQfUbZueoC1cX5zOkU9dpB02VEAE+k=;
        b=KSz1OHKR5UV6MlxHIUvC1fhsZ/of48SeoitG3p/i0NVodAnUUlc4tQNj9gZOQWQbGG
         rLo8N8tjrAcMHyJwGNkarM9jkTfYmoX+xK1DSFvpVdzVHpppQzHIjVis/JZfieM0ERNL
         OtsXiGa9fTao6gRo3jDMpgq3VCgirC7qDom1QplndlQBP4uk2HEGwfof/FBOrLwu1aWX
         7523j5AsuWqs5HpNzVbsJCr6s+6moeQqvebn/2x3qKGaabIg6L0SYuOsKdKsw9Nfmp4t
         2jZnPFInrxIc5TqVZQjaOgf0R8juwTGqc7S73ZM27KNZc75S+i+YwaxTEqLSi7quvu53
         OHLw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXrDv/wMrZMpLnrmHXBdCNtGc9otYz5wQOHql/pXCkuivpRGf72xlXWTivSW+es7Gco9auFd+wvA4/kLg==@lists.open-mesh.org
X-Gm-Message-State: AOJu0YxZFitIc8kTMzh22FybVkappy1WkFM8JZTWnQzfZf1YTx3OVDER
	6R53Pu1C3HDhTJLD8k11YpihKkIrodgwz7GClyOGVW4D8nHZrrr5
X-Gm-Gg: ASbGnctBbp3LCnRL5jXoOZrsvTCDn64ycRcvrE4kVImg6G5P0PRyXMLWfj7MecMJE2e
	zxyqbRyzcQHhWTqZJf3/bTwlnSQ6GhB7fVh9B4Fi0+sbyuihNUJqVFEDQKQkcIusPuF1Sx0IrgQ
	uIlCELPYqpR7HZEFRhM656DfPIGtEITqQ+CqVf5MEvnVkTdXp1k8FTAmQtgUI5W7uw+/WLI8t0f
	pIwRkiocid9e0zSGBEDf5B/+hKZRyGLjb4lxkFy/Eqp17Y=
X-Google-Smtp-Source: 
 AGHT+IGwupxRC65MgCyutia2fH86BtEscvZ3hC19otgxhx9O+M/gNgTyzVuSwrO7sHgcHk/UbitTJA==
X-Received: by 2002:a17:90b:5490:b0:2ee:48bf:7dc9 with SMTP id
 98e67ed59e1d1-2f2e91f1112mr4682540a91.15.1734527372952;
        Wed, 18 Dec 2024 05:09:32 -0800 (PST)
Received: from ws.. ([103.167.140.11])
        by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-801d5c0f59asm7434754a12.67.2024.12.18.05.09.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2024 05:09:32 -0800 (PST)
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
Subject: [PATCH net-next v6 01/11] rtnetlink: Lookup device in target netns
 when creating link
Date: Wed, 18 Dec 2024 21:08:59 +0800
Message-ID: <20241218130909.2173-2-shaw.leon@gmail.com>
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
Message-ID-Hash: 5DDC2DTTBWXBSEKMXMH5CXXIMOK4O5JU
X-Message-ID-Hash: 5DDC2DTTBWXBSEKMXMH5CXXIMOK4O5JU
X-Mailman-Approved-At: Wed, 18 Dec 2024 14:11:51 +0100
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/5DDC2DTTBWXBSEKMXMH5CXXIMOK4O5JU/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

When creating link, lookup for existing device in target net namespace
instead of current one.
For example, two links created by:

  # ip link add dummy1 type dummy
  # ip link add netns ns1 dummy1 type dummy

should have no conflict since they are in different namespaces.

Signed-off-by: Xiao Liang <shaw.leon@gmail.com>
---
 net/core/rtnetlink.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index d9e363d9fa31..6a2fa030c8e0 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -3851,20 +3851,26 @@ static int __rtnl_newlink(struct sk_buff *skb, struct nlmsghdr *nlh,
 {
 	struct nlattr ** const tb = tbs->tb;
 	struct net *net = sock_net(skb->sk);
+	struct net *device_net;
 	struct net_device *dev;
 	struct ifinfomsg *ifm;
 	bool link_specified;
 
+	/* When creating, lookup for existing device in target net namespace */
+	device_net = (nlh->nlmsg_flags & NLM_F_CREATE) &&
+		     (nlh->nlmsg_flags & NLM_F_EXCL) ?
+		     tgt_net : net;
+
 	ifm = nlmsg_data(nlh);
 	if (ifm->ifi_index > 0) {
 		link_specified = true;
-		dev = __dev_get_by_index(net, ifm->ifi_index);
+		dev = __dev_get_by_index(device_net, ifm->ifi_index);
 	} else if (ifm->ifi_index < 0) {
 		NL_SET_ERR_MSG(extack, "ifindex can't be negative");
 		return -EINVAL;
 	} else if (tb[IFLA_IFNAME] || tb[IFLA_ALT_IFNAME]) {
 		link_specified = true;
-		dev = rtnl_dev_get(net, tb);
+		dev = rtnl_dev_get(device_net, tb);
 	} else {
 		link_specified = false;
 		dev = NULL;
-- 
2.47.1

