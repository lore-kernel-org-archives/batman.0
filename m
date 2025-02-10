Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B389C0219E
	for <batman-adv@archiver.kernel.org>; Mon, 10 Feb 2025 13:37:04 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id CDB3684247
	for <batman-adv@archiver.kernel.org>; Mon, 10 Feb 2025 14:37:02 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1739194622;
 b=fajyknpOCC8yBkivSJsIRCnABggS82LxxIXxoqXQRfExvCmQn/g6Iaxp2ZDXqXHuR40XB
 Rd+tjAhWIzJ2rAb700A3z6kKp4BIZAOIzA+tdX3Dr7q77INnPiPa/YKJ+ahi5NkFM3soA9B
 f6LKYMjN69hdqNU33MFDxZWi6JkOw/g=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1739194622; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=1pf9SNTQbR6dSoBCEAV6dPuN8Gz1/YecnHQoz2AJqpo=;
 b=GvLP+Q9N6HgUOMDmclgLUX4FUU+g3VxAZO0oZiLx9dil0AN+X78VP7g+hJYSqH+ZkDN8Q
 oTOwwAQMw/AnfRVpn7YGFVUj0W92ixopwX1Pm9oXODLiz/O5G8ZooU3UVdkI8sy28XCZreZ
 XQmkT/GAlPvHvPfRakL/YzeMMAkBAwM=
ARC-Authentication-Results: i=2; open-mesh.org; dkim=pass header.d=gmail.com;
  arc=pass;
  dmarc=pass (Used From Domain Record) header.from=gmail.com
 policy.dmarc=quarantine
Authentication-Results: open-mesh.org; dkim=pass header.d=gmail.com; arc=pass;
 dmarc=pass (Used From Domain Record) header.from=gmail.com
 policy.dmarc=quarantine
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com
 [IPv6:2607:f8b0:4864:20::62b])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 8A9518346C
	for <b.a.t.m.a.n@lists.open-mesh.org>; Mon, 10 Feb 2025 14:30:27 +0100 (CET)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1739194227;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=1pf9SNTQbR6dSoBCEAV6dPuN8Gz1/YecnHQoz2AJqpo=;
	b=tPVKzQ+EmS0EEKT7LOD4gklHVg9b25a/4XRpBE292Ee0+U7unNFzN9gq46LM8o/K7/DIO4
	AcIaW8Ik0TC1j/hTy4bqecAssHfCbbNqYnfGHDtOE3W1z9wNDFAx3HDPFsc1Ulx4OdX3ev
	Tq31mZJRR5NafSPLiJPPTcwsCHwGkOo=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=gmail.com header.s=20230601 header.b=hoSEAMBi;
	spf=pass (diktynna.open-mesh.org: domain of shaw.leon@gmail.com designates
 2607:f8b0:4864:20::62b as permitted sender)
 smtp.mailfrom=shaw.leon@gmail.com;
	dmarc=pass (policy=none) header.from=gmail.com
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1739194227; a=rsa-sha256;
	cv=none;
	b=Yprk4uTnAhAnllLOx6DrjNbuIT/xETi8oUCzKkzj1XGHRxScT6sVlwW7X/86fes9Eg4g4z
	/s2w1NXnlj7Ip5e6YVYUaPI4oIzZyJr75XkgtTGXYi7EeT4St7hufxg9JKhzeY3yz5qBQc
	Uh5MOhrF9G+x+t7NHnwQHpD+7ABavoA=
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-21f3c119fe6so95782215ad.0
        for <b.a.t.m.a.n@lists.open-mesh.org>;
 Mon, 10 Feb 2025 05:30:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739194226; x=1739799026;
 darn=lists.open-mesh.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1pf9SNTQbR6dSoBCEAV6dPuN8Gz1/YecnHQoz2AJqpo=;
        b=hoSEAMBim16HQ4napEOV0EekDU8zaFfrEe3kbcn4V7ZeHjjXy1DIlz6kNaHW4cS1sx
         +YPdhHEfuP37Xn4qNht+lOy3i32Qn3C4/Aa1fM+MVKAVx+XQDggFxPgUHXovtA2KuM3t
         aivOxK0T9ZwTCJOp6BO/BLz45IDE/SIFREcYt1aDNxqWER/YEkUePWVRNb0vwERBECx5
         yo0moIecw6aGgdFKTUKAt0ISRA7EEUv48epe4HX5ER22QCPGd5TgQG57qxLktMHxmJur
         XgOPrgG04Yp5+6OXdaY32Yk/e+v/+QLtXn2n9juBd7Yq1podUhZTM1RJUbnAcChaPUFN
         HQEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739194226; x=1739799026;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1pf9SNTQbR6dSoBCEAV6dPuN8Gz1/YecnHQoz2AJqpo=;
        b=svzumXKKWS51n2zQOqNiv08MpNDIPeOux0Xp9P+Iv39EiZIzsf3nJFz1+E9gaAOq9u
         IcEe+/hSdldbMjw6l6IHoeea7nHSeecsRpoJjvPkJ189WwcwjIqqDnKEd1puxO+lhnWy
         PC+2sogyO9MarZ2A6+WlpncyiNqc9Y1XUUsAgnfxkHJ8QHvfvhSZGcyrgAoR1JmwqkOO
         qXFOCVCXloyvwcV25S7sjMVppSUu10QD2GE6nVMEg7kVikyKpupHGkDozyE68ns2AlXC
         e1UCmwSudORzJ2SB689LpSQiNHB7N+36xH0x/gYhDSEWuCVqq185YYxK3faNs9E8/1OC
         ct1Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUXQzq5oQB9bi12fDFnEmHu/igIqY1YK9Z49fCePml3DNK4PKb3V4UnhjIr9Uyky8q9IRaEyZc+bZZC1w==@lists.open-mesh.org
X-Gm-Message-State: AOJu0YwZ7X4ZjPZ72CwRmYLMiMEiQA8QJvj+qvFEurJJ6Pewfyfv4Kei
	ztqxEM6aT+qtxbGDBpo2lauwCsN9GwRI3NcYhC7ewQwFuyAilPF+
X-Gm-Gg: ASbGnctm1inkc41OfoQceLIvBOCJvRzCTkk8/r21OlcgHVsMQcPX3UV0irrL8vzHUQ3
	kqy5T/ZYD4C7zAGn8ZyjyBaClsdib2mSey38KylcQcvh+yqIC7J/xst42IV20z6vuFcMm+9g53N
	7ce0uV1T8o5wua17/zGWv0449TipHQxhRWlJ8gMNnpenjzA0dpmLjUMiVleDo0xb3N4h/PR5LK6
	lCGCoE7e7o7VDhcnRBEwC16q1g1nFlOvHEUeWZ79Lkf01qxuiWaBlVlLzj/vNSzl5ZG4+JKU/yH
	GFvInQ==
X-Google-Smtp-Source: 
 AGHT+IHnIbIec9duqjv7lrtmGReNVQPeBtoczKplB0CDd7UUW+fM90Yj1MwAFqvvYB9Zquhv6onO5g==
X-Received: by 2002:a17:903:240f:b0:216:7cde:523 with SMTP id
 d9443c01a7336-21f4e739f99mr242405235ad.32.1739194225944;
        Mon, 10 Feb 2025 05:30:25 -0800 (PST)
Received: from ws.. ([103.167.140.11])
        by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21f3653af3bsm78799445ad.57.2025.02.10.05.30.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2025 05:30:25 -0800 (PST)
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
Subject: [PATCH net-next v9 01/11] rtnetlink: Lookup device in target netns
 when creating link
Date: Mon, 10 Feb 2025 21:29:52 +0800
Message-ID: <20250210133002.883422-2-shaw.leon@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250210133002.883422-1-shaw.leon@gmail.com>
References: <20250210133002.883422-1-shaw.leon@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MailFrom: shaw.leon@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-0;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-1;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-2
Message-ID-Hash: MVG4VRJNQXEPHU2F5ABZ5CTZAM5W65UZ
X-Message-ID-Hash: MVG4VRJNQXEPHU2F5ABZ5CTZAM5W65UZ
X-Mailman-Approved-At: Mon, 10 Feb 2025 14:36:12 +0100
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/MVG4VRJNQXEPHU2F5ABZ5CTZAM5W65UZ/>
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
Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 net/core/rtnetlink.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index cb7fad8d1f95..3b3398283a8f 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -3866,20 +3866,26 @@ static int __rtnl_newlink(struct sk_buff *skb, struct nlmsghdr *nlh,
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
2.48.1

