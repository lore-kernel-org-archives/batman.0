Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEC67C021AA
	for <batman@archiver.kernel.org>; Wed, 19 Feb 2025 15:46:52 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 5ED58841EB
	for <batman@archiver.kernel.org>; Wed, 19 Feb 2025 16:46:51 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1739980011;
 b=A4zd0JnM7xMA300almCyxkHEbq0j1favodiH0nNL0wFfjXhmcVFMzn6XviSHLH5M0+0wn
 jMtqD0WRJbGGuaN3XnoqbMg0rvN4saJwfu/nZP4v8vrVkV65xA8GmKPYCRBu1nfJYwKm7Vu
 4grBz1JU6+VeAPHesnifZ0AJ+/6NNrE=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1739980011; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=so6ixpN3+kGL2R8Euj1cLc9vRqq6Wkcgz/xNsuJc6Sk=;
 b=jk7WmCFncQ4YENMb5z8mVVQON0Q8aW6/MU3/oLAAesfkveAuqmTw9eNXkY60Xbk21skT5
 b61HJ9668myb5oqEFI872ODa6j6nrfa5t3NUOIxUOazjNVoHNQbQgY0tBOtZpBp2mcbUTrr
 YhVpRKrGHm9XCcZbXUjUZbOKLOGvy9s=
ARC-Authentication-Results: i=2; open-mesh.org; dkim=pass header.d=gmail.com;
  arc=pass;
  dmarc=pass (Used From Domain Record) header.from=gmail.com
 policy.dmarc=quarantine
Authentication-Results: open-mesh.org; dkim=pass header.d=gmail.com; arc=pass;
 dmarc=pass (Used From Domain Record) header.from=gmail.com
 policy.dmarc=quarantine
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com
 [IPv6:2607:f8b0:4864:20::633])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id DDACF83F43
	for <b.a.t.m.a.n@lists.open-mesh.org>; Wed, 19 Feb 2025 13:51:31 +0100 (CET)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1739969491;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=so6ixpN3+kGL2R8Euj1cLc9vRqq6Wkcgz/xNsuJc6Sk=;
	b=WPLdkVhfsY/aO7K6HWJg211P0kqGbIedviqQOkoeuPx3RmVJ1uapUn+8Bd3SILDl3g2IPd
	So0HX4o8xWTfhgWSa3L7iccLqZZMWkTcptbDtAR4ubtUSNFLRNprQggH4O/C8+FZKFu1dp
	kFXJdJIFymyZLSnZuaaC1akgx/P0XeI=
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1739969491; a=rsa-sha256;
	cv=none;
	b=fCyjv9U6d76+jv0BroYsQ/QYCoR2p4XEqEo8t6KmcXcex6DKNuqpfw1uMaR66IPHVZPFn6
	Y7QrfvmOAyvIW840OV4u/dt2EBlWY+fLna2pzbx7m6WCEHM7O6IK3uV3t7nqNj7cJLkv7t
	Q4B4jbwJYwuguZkKm4CITFGPJUDqsqg=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=gmail.com header.s=20230601 header.b=NEvaqpzB;
	spf=pass (diktynna.open-mesh.org: domain of shaw.leon@gmail.com designates
 2607:f8b0:4864:20::633 as permitted sender)
 smtp.mailfrom=shaw.leon@gmail.com;
	dmarc=pass (policy=none) header.from=gmail.com
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-220ecbdb4c2so2357915ad.3
        for <b.a.t.m.a.n@lists.open-mesh.org>;
 Wed, 19 Feb 2025 04:51:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739969490; x=1740574290;
 darn=lists.open-mesh.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=so6ixpN3+kGL2R8Euj1cLc9vRqq6Wkcgz/xNsuJc6Sk=;
        b=NEvaqpzBwDBrqN7FEEP3xmRprWjRj03ECrjkpKi8amDAHu/j9c3i/MXtzAGXXLd9WJ
         JSM3Lxt2i9CvhrcG5lZTzXjg+koQXn/VTIBwHvulXRsdIk8vgQT80NpFZ3MqAmJ0MhlM
         i2VlQhNsnyNgkvbiRrQh9mGoD+3xLhc2yGyzeiqOTu4q5Wl52CEAnpLVUEUv2X0Dv9zC
         mP38uCCVtl96+2E+E1GFWMv5l7SJVA3Ojq6OY547A+lNVoGp6JgKQmkuPgLoLz+gzns9
         6Ofiy3r9K3R3Kc96/AuQR7K+Zq4JPBSR6kX4gkVutr1ocuRzeTeVqH1InmMcR5ELIdSj
         Uz4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739969490; x=1740574290;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=so6ixpN3+kGL2R8Euj1cLc9vRqq6Wkcgz/xNsuJc6Sk=;
        b=tOsHnqH0IFcf2i3kF8iQgBFv38znsXXVtH5uswv2J8wpiqnl4VaM9jim5KRWfWojUN
         N389tw1ZIYc9UTzxA/PuHAu1heDykxUi9guJiB3oaptgMZyXSl5OlerSoZsym7pqB35S
         LPjeYND3YIfmwvblG2GOHG98s71D76dsgr68bGYV5ndswgW0LHTCqSJONdLxWERTe2hr
         Eoea1Dari9esvIu4wfaqtHeKutf4WqYLAimB/vijPrOl1dFCneqv9IIbuAB9PpOBEX1w
         7aWGDqVpuyaw4ma/L2Nkq26db3wtujtxUmc6DP0QiIl6l4ESlzt+sqbM+ETc+zuPTXdv
         Uuzw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUz6bY0qpsqQuN/pmkwdDjkR0YtfQB5oE6p1DXRRNAPx0j/Qt8o5z8qUxnTyd1Y5NYjfHAVclM5TCRVXw==@lists.open-mesh.org
X-Gm-Message-State: AOJu0YxS20nwF60XAwnc0+K/CVYKug+aGZ94HDvhcaDEmkSxZVApfjum
	lVfiAvkOWnLQw6oqh+Gl8EtwWUYVoTgE4BjlvQYXLs5wBnlGk8cd
X-Gm-Gg: ASbGncu62CErMYftn4dww0QVF0OOVKKKOruwdcQl9ukYtZ9HBizqim15x1LXQWyVSZR
	Xsl4fDY2ncGih2BlmSTyCbGlsu2mPZvsSy4YTFhvXRt8HGzYxDyH9dxkSCLtYsOckrRF06wUcsK
	jBjgwGuA+c29DHF5O26kn+FLCDt/nCE+gk19n71nBi3r4tcwX+iTxblvCAs9+nrKzwCors97vkL
	xpQyDQ4ZniEpKrRERVHPsrEQkqC91xsKj7qZM4OhezHEDKRv43ex4sQdC65E6HKiAttvywpSyY3
	QYNoTw==
X-Google-Smtp-Source: 
 AGHT+IEqkCyGg/QTxep/fqv5CqcRvswNVHWV96b7TSvHtcfDnyWeYpeOAf5Az1bAxRJk7mW/W72uWQ==
X-Received: by 2002:a17:902:ce0d:b0:215:a179:14ca with SMTP id
 d9443c01a7336-22103ef5861mr278510175ad.2.1739969490317;
        Wed, 19 Feb 2025 04:51:30 -0800 (PST)
Received: from ws.. ([103.167.140.11])
        by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-220d536436fsm103427175ad.64.2025.02.19.04.51.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2025 04:51:29 -0800 (PST)
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
Subject: [PATCH net-next v10 04/13] ieee802154: 6lowpan: Validate link netns
 in newlink() of rtnl_link_ops
Date: Wed, 19 Feb 2025 20:50:30 +0800
Message-ID: <20250219125039.18024-5-shaw.leon@gmail.com>
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
Message-ID-Hash: JAGWQY4EJ6PRZ2FCMWPQAIHHIK7W4ATN
X-Message-ID-Hash: JAGWQY4EJ6PRZ2FCMWPQAIHHIK7W4ATN
X-Mailman-Approved-At: Wed, 19 Feb 2025 16:43:04 +0100
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/JAGWQY4EJ6PRZ2FCMWPQAIHHIK7W4ATN/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

Device denoted by IFLA_LINK is in link_net (IFLA_LINK_NETNSID) or
source netns by design, but 6lowpan uses dev_net.

Note dev->netns_local is set to true and currently link_net is
implemented via a netns change. These together effectively reject
IFLA_LINK_NETNSID.

This patch adds a validation to ensure link_net is either NULL or
identical to dev_net. Thus it would be fine to continue using dev_net
when rtnetlink core begins to create devices directly in target netns.

Signed-off-by: Xiao Liang <shaw.leon@gmail.com>
Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 net/ieee802154/6lowpan/core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/ieee802154/6lowpan/core.c b/net/ieee802154/6lowpan/core.c
index 704bf9e3f097..ee318d46817d 100644
--- a/net/ieee802154/6lowpan/core.c
+++ b/net/ieee802154/6lowpan/core.c
@@ -143,6 +143,8 @@ static int lowpan_newlink(struct net_device *ldev,
 
 	if (!tb[IFLA_LINK])
 		return -EINVAL;
+	if (params->link_net && !net_eq(params->link_net, dev_net(ldev)))
+		return -EINVAL;
 	/* find and hold wpan device */
 	wdev = dev_get_by_index(dev_net(ldev), nla_get_u32(tb[IFLA_LINK]));
 	if (!wdev)
-- 
2.48.1

