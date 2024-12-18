Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24687E77187
	for <batman@archiver.kernel.org>; Wed, 18 Dec 2024 13:14:52 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 9BD6A840D0
	for <batman@archiver.kernel.org>; Wed, 18 Dec 2024 14:14:50 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1734527690;
 b=h3J2lk374g3YaE7Bd1+0wNVuxB7Ko6pK/CM5wXrdtsqh7xpYbWjTr5njVJOITpIgzvVCq
 yG2KEatVtgWx9ugRsHaiXOziM0qKxh/ax2n87yxMwSROSPlf3Q8ezofLzQ8bMGrZWfEliMJ
 AqVPayqXfaaN/OrnbjmZdycGLpdm8ak=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1734527690; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=ZWtx/GpPr8Y7UYus5aPINKHxwSB0EzMFBw6o16b+Q3k=;
 b=AhR6/rStoiayUN9AQ1w8jRWWH3tqllNltrEAhCmFmtdozd3Ac0+Vc59rzvbO1d44bQzJ1
 WUeSzjZeWLW1xo3oZtkvjm1pdvu3Kju5ayJiimzQoTedk4PKRy/Yf9fMGXytBpHf5dd2r1f
 QydW0MhfWrLPCIJLKaI3hVZccDRKFro=
ARC-Authentication-Results: i=2; open-mesh.org; dkim=pass header.d=gmail.com;
  arc=pass;
  dmarc=pass (Used From Domain Record) header.from=gmail.com
 policy.dmarc=quarantine
Authentication-Results: open-mesh.org; dkim=pass header.d=gmail.com; arc=pass;
 dmarc=pass (Used From Domain Record) header.from=gmail.com
 policy.dmarc=quarantine
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com
 [IPv6:2607:f8b0:4864:20::429])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 60EF283D9D
	for <b.a.t.m.a.n@lists.open-mesh.org>; Wed, 18 Dec 2024 14:09:59 +0100 (CET)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1734527399;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=ZWtx/GpPr8Y7UYus5aPINKHxwSB0EzMFBw6o16b+Q3k=;
	b=jx3GwwvC0b9M6qrINlpfEdBTOy6vrB028DMTdlODg1oY8I5g8pMKGZkZ/8IG9pl5q/p5ku
	qyrODdStTE+1zGNiycydGs7a21n5BDHTAxdqeBiXWtlDN0euAAZKmSlhJ/UwOo9FtFuM/H
	Gsb2jK1ncJen4KIkhQ/zNEo7JsN0Ziw=
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1734527399; a=rsa-sha256;
	cv=none;
	b=bUwfFaUGSOEibzuQiwT9NB4qSX/P2W/YxNFnPYE8HRI3UCjFaSY253L2/9YC8+5xXuWi16
	1lkf0Ao4Mgto/Yhroe/aykFpdS+mjggeSDGgM46o9FR/yqrcB6EA38l4yFmMWuCmgyNeV9
	1QAPLoAxPqZgnD+JCDLpP+gnb+Ix4J0=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=gmail.com header.s=20230601 header.b=lVu8zjkM;
	spf=pass (diktynna.open-mesh.org: domain of shaw.leon@gmail.com designates
 2607:f8b0:4864:20::429 as permitted sender)
 smtp.mailfrom=shaw.leon@gmail.com;
	dmarc=pass (policy=none) header.from=gmail.com
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-728eccf836bso5678169b3a.1
        for <b.a.t.m.a.n@lists.open-mesh.org>;
 Wed, 18 Dec 2024 05:09:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734527398; x=1735132198;
 darn=lists.open-mesh.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZWtx/GpPr8Y7UYus5aPINKHxwSB0EzMFBw6o16b+Q3k=;
        b=lVu8zjkMXhCHFVEyj5+66423vcd86HeQAMFHZ/N/xQWZslC4IahwAmj5PyLxdazFcP
         47RE+dHMda4uvkrWju8eWiRbWlQNzQqBzge/XTXHqeib2GPCKDbM/rasyXHJYMyIPWAW
         uYcQfiELe1ljpvXaP00EYg3s1r46hI2W547DLc8hW50OfLceyV+iHR3kRLerggPy/JVl
         zEZK8QDKdBtpgm5Veodfc5eTGkmVFkpEaTsdLWpeToZjF9WNZVzwK+rW9S6EcoMfjiwP
         H43+97XVAwJyBykBdaqBsexctLcyF6D1+0c7hZrSz5pcqJ3V9F1lzjE9HK3ah/qMpOi5
         LXJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734527398; x=1735132198;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZWtx/GpPr8Y7UYus5aPINKHxwSB0EzMFBw6o16b+Q3k=;
        b=X0nPNAfK+yuBjcARFsFVJPqizqcoDwRLk6FLdoC1BQgE8nilR/U862KVo+ro3cVEdb
         5H+EJeaGclJhwkgtbEMNYIwHiZchjtg8o3+d62Cbjr/0YlPqBuvvo3lw0Artl0gY+dTN
         0YNPC3PvUazPLVp0dCZNHnoKBu2KHsH5Js3muyCp4/D1Jn6Mi1CLTnopsW4nLFHu2zJX
         c+j1Wf/FHF1vsprxsykyUnc1W1Gq8mf6thOkCN64Ba7WAhsDn7OCN+k4h2uhtnLAdYND
         XB0MVfUz+yGd+YA2/K45cGI3srmtfvb+KvbY5xoG+D/Ry0opeprODDtCacA/DVTNSglm
         4EUA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWQuzIUPM//GHnJQKxYYCQhg7bhvvPsu3mQJBEzIRqx1x7VWtqt6nC6Yb/LFOmYzWPMTXxMc+khXiK2Jw==@lists.open-mesh.org
X-Gm-Message-State: AOJu0Yz9PJ/nMutNNyOYjYFYfvS5U7BPNGn6Nqq9lwjgHz8Y7uPe6m55
	8sy3k8fkTMbvCzQiko+vz4M0AkyWlndkquY9otB16x9a7dZwEuxE
X-Gm-Gg: ASbGnctH1mXEPuEPcKtHDc6KCGiVXooxB6KGnzkI18za31gfi3ikr7sOHA6YoDCD9Pw
	72EwUAhKXAG6WVoO9Xg/jiAKFx1AyOjfMW+5BQxIxZERg279BRGEYL3/LQWtiGnKwaVoWmBjB/o
	zE4u+yMCuStGWANx5ZkvTkAZc9uGDH0Esy+fCGjqLmtqqfJQE7AydIAfsqNeXzNfvjFzb9nbSC3
	oqOy00+pQZ5XWc8s2GJylrAF8QsValYbXMMCDRtvlcCUvI=
X-Google-Smtp-Source: 
 AGHT+IGmYU6ujKxLBy1JGYsxY/MwVi8oxkRDUmwYNBJP1y7XmPRqmJNLVIgjjMfYAOzzfAymm/3esA==
X-Received: by 2002:a05:6a00:35c3:b0:71e:1722:d019 with SMTP id
 d2e1a72fcca58-72a8d2f0b92mr4132701b3a.22.1734527397729;
        Wed, 18 Dec 2024 05:09:57 -0800 (PST)
Received: from ws.. ([103.167.140.11])
        by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-801d5c0f59asm7434754a12.67.2024.12.18.05.09.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2024 05:09:57 -0800 (PST)
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
Subject: [PATCH net-next v6 04/11] ieee802154: 6lowpan: Use link netns in
 newlink() of rtnl_link_ops
Date: Wed, 18 Dec 2024 21:09:02 +0800
Message-ID: <20241218130909.2173-5-shaw.leon@gmail.com>
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
Message-ID-Hash: YSKOWHWC5FAJ42JUO6QLY52HSUYKJBGW
X-Message-ID-Hash: YSKOWHWC5FAJ42JUO6QLY52HSUYKJBGW
X-Mailman-Approved-At: Wed, 18 Dec 2024 14:11:51 +0100
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/YSKOWHWC5FAJ42JUO6QLY52HSUYKJBGW/>
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
 net/ieee802154/6lowpan/core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/ieee802154/6lowpan/core.c b/net/ieee802154/6lowpan/core.c
index c16c14807d87..65a5c61cf38c 100644
--- a/net/ieee802154/6lowpan/core.c
+++ b/net/ieee802154/6lowpan/core.c
@@ -143,7 +143,8 @@ static int lowpan_newlink(struct rtnl_newlink_params *params)
 	if (!tb[IFLA_LINK])
 		return -EINVAL;
 	/* find and hold wpan device */
-	wdev = dev_get_by_index(dev_net(ldev), nla_get_u32(tb[IFLA_LINK]));
+	wdev = dev_get_by_index(params->link_net ? : dev_net(ldev),
+				nla_get_u32(tb[IFLA_LINK]));
 	if (!wdev)
 		return -ENODEV;
 	if (wdev->type != ARPHRD_IEEE802154) {
-- 
2.47.1

