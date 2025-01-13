Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9DF3C02180
	for <batman-adv@archiver.kernel.org>; Mon, 13 Jan 2025 15:22:47 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 0DEC6841EB
	for <batman-adv@archiver.kernel.org>; Mon, 13 Jan 2025 16:22:46 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1736781766;
 b=WI8wDrgA+IRcdG2se1RfVMr5pU+O2lyxvU0VkXApvDqVeKbCpYQe6rPKKipCS1gggcSo+
 vu9ou7a58lYZ3kx5v6ZY2M1SjkM003gykx8DWpL+isjkNpDn5snFSep1sbg/9vVt3w35Oe7
 h0Z8T/XTvrwAEC+N+a2zp/8ACuDx9PI=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1736781766; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=aStnhmnU+u9WzYJvS9wSRsKutCltWxiDBFKzpdLaN7A=;
 b=Ru73/xSxJdRCp8cEtfHiRiSj6R1aYuyGwEQb9+VaT7ekBBqOjfZ9OLY3/aJFqHzBmk9Hh
 NIBhflL+ysLRVygbIZ8QB94RvrgWjo3n+AmfgflTT1wokhj7hJoKms9wzDbk2MFuR5eWknZ
 gWXvC9KTCloA8cYP5KO7ucYksDW0N/Y=
ARC-Authentication-Results: i=2; open-mesh.org; dkim=pass header.d=gmail.com;
  arc=pass;
  dmarc=pass (Used From Domain Record) header.from=gmail.com
 policy.dmarc=quarantine
Authentication-Results: open-mesh.org; dkim=pass header.d=gmail.com; arc=pass;
 dmarc=pass (Used From Domain Record) header.from=gmail.com
 policy.dmarc=quarantine
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com
 [IPv6:2607:f8b0:4864:20::633])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 2F0FB80832
	for <b.a.t.m.a.n@lists.open-mesh.org>; Mon, 13 Jan 2025 15:37:48 +0100 (CET)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1736779068;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=aStnhmnU+u9WzYJvS9wSRsKutCltWxiDBFKzpdLaN7A=;
	b=XbQq1nwuiQVcDg6CPpRpAx4OplQTxDY2YIMy8cMWRtLw/avUN8R0oH1LX4EXFtLe2H8xq2
	d1MrAz4aIUFTS7dflqkNUQyUpeoe1Hxp6fQj9Z5xWAwiHxxzsu+nTCI7aDCGZFxy0vPy4l
	pu83es0EVmZyffRkJY2lhbg/ll76/vw=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=gmail.com header.s=20230601 header.b=NKr2Z0QO;
	spf=pass (diktynna.open-mesh.org: domain of shaw.leon@gmail.com designates
 2607:f8b0:4864:20::633 as permitted sender)
 smtp.mailfrom=shaw.leon@gmail.com;
	dmarc=pass (policy=none) header.from=gmail.com
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1736779068; a=rsa-sha256;
	cv=none;
	b=iQq+7PpYsXQCkOO+NfXezsaRxg6qfprkNKj7OYC4Azh0hdscqpN2iYjQ3IUsWjCNTj4MJF
	EddnB+FfOcrU4TV+vg6L2daG+BIInz3Sx5QAqfeaQtxp1lsKZuFsfmKZAaOLwfXg35GkPR
	XVogP+1mCd3CDVPcCyO6L1L5jLLgrUs=
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-21661be2c2dso73443105ad.1
        for <b.a.t.m.a.n@lists.open-mesh.org>;
 Mon, 13 Jan 2025 06:37:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736779066; x=1737383866;
 darn=lists.open-mesh.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aStnhmnU+u9WzYJvS9wSRsKutCltWxiDBFKzpdLaN7A=;
        b=NKr2Z0QOBjEeO+q4L2cBxe5zXk8ApuHwHTViP/L9h/gCbWzRdi47BqUJOO2PeCO9vR
         n2a3TC5KUC8lQ0uwCNU53bp5Dq7MSns32ZLvTwaKY0W38jbBrL8WSbI8l5iP1bfRp/Fo
         22ItAi2NGBsLndHFaMJAo6SKhWt3NQP28tYDbqMOqBnCkYS1rJysEVPqwk3mGxPvxaZ6
         5bY/9VYPC1JJuarRU8nG5A2H0OuQ2azPn9oM50Bw5/w5An53aARjd2DZSX9px29aD+Ga
         9Gt9uWSznwAlQkztjTKcNgHyP5zzRttkTO0DPu/9Y06qwNuCCKnD+WdZgEkdkb0KuAWL
         SexA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736779066; x=1737383866;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aStnhmnU+u9WzYJvS9wSRsKutCltWxiDBFKzpdLaN7A=;
        b=jqUAPoez9QYY/VlmUEZhbmidFWf+QhlRbYBA0TgdGfzP2/pA8S9zhoI4GIXfjsb0id
         Zpc9exIMSUE1LXmG7dtaRFUKWRoPqMKDgmN+47kZtNHe293CTFSsRqp0l6WSLQ1wujPK
         vhV1Qeo2Y6y1vhgnim4Dd60wCAo2+uayNKrPWc2ZmowcXih69MBm20svCgBz7ixUcP7r
         yFxZO6Avs0EjEHaNTgJvOZiSC+euiv7d0n+aIspAzvN6DCk2WxvkPwvTBjHj852bKhWh
         YNnFofUcmdiw6MkgOtVCjiRnUkTECDZMR5jk3pcwMxaWSVhUwSiCXxQWosT+QimeMS2F
         WGRA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX1oPrpwjPids6iG1HzMDtr1t5wUdFMz5+CrJEsQiaOw/AuYLLmBL5r9V0dhgW++owtskD0PQW6Bhyyqw==@lists.open-mesh.org
X-Gm-Message-State: AOJu0YwhSNmqR9KG9djPJYLFzN5yMj70/MKX8N6vSVOp2HA194DdPCpT
	mTAeTXGpO25R0n3auPm2E5OVN7jM4I6f55uhpcPJot4pvyhCIcJY
X-Gm-Gg: ASbGncsH+eiZd0qgO0XpulxwUNNn2SqOpnQuT40dPo3euQ39f1uPg82HDHHbKysmbAH
	vNPC2A6+1EwopYug9+1+VfsGRmc8EOtOg/3h7op0T7Kyrm4A5F3zYckQVHP0hb9hgjZqTGEZBW1
	wfhEQSdBcg8wSteV5KdFO8XJUf8v9kqX/YHdfW7wOgmWtNZDsRoY20ig+We/z6B/kyqPwIcJged
	MbhKkT3hwfR1Y0aJ0BI5gwmpVZ7jGqI84B5tFEI9K+lNGc=
X-Google-Smtp-Source: 
 AGHT+IEEIzRcAyOPsqmoPyg3LqUO10MpSinA1zy4f8+lVawQb15WuSETw63Trl8RPwnuvmvDM8k1Dw==
X-Received: by 2002:a17:902:e74e:b0:215:aee1:7e3e with SMTP id
 d9443c01a7336-21a83f36d48mr318259495ad.5.1736779066532;
        Mon, 13 Jan 2025 06:37:46 -0800 (PST)
Received: from ws.. ([103.167.140.11])
        by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21a9f155e00sm54328715ad.103.2025.01.13.06.37.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2025 06:37:46 -0800 (PST)
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
Subject: [PATCH net-next v8 01/11] rtnetlink: Lookup device in target netns
 when creating link
Date: Mon, 13 Jan 2025 22:37:09 +0800
Message-ID: <20250113143719.7948-2-shaw.leon@gmail.com>
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
Message-ID-Hash: TF66LSP6VZP4GNSNWXMHY32LB4464RWD
X-Message-ID-Hash: TF66LSP6VZP4GNSNWXMHY32LB4464RWD
X-Mailman-Approved-At: Mon, 13 Jan 2025 16:21:55 +0100
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/TF66LSP6VZP4GNSNWXMHY32LB4464RWD/>
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
index 1f4d4b5570ab..ec98349b9620 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -3861,20 +3861,26 @@ static int __rtnl_newlink(struct sk_buff *skb, struct nlmsghdr *nlh,
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

